Return-Path: <netdev+bounces-187035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBDBAA48BC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE7B17C469
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEBD250BF2;
	Wed, 30 Apr 2025 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc4lrSah"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27025228B
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009277; cv=none; b=QRhCYsp/SLKs+kda29ks2UtwZQMcw5v6bOy74pli/mOWbNngKCuWl73kNvNPnLx3UmbLa/FnuYK6HR2VTlYZm1g5Ye+UKBjmt2YVjlprAaP4klKmeVVSOkBIjFnXrgLhX+Xc/UBIXAAMGf8GoTswAucqqnrmrHgEveKqm1MLPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009277; c=relaxed/simple;
	bh=57iokHmYjdcAZayIvqdZd5fOEHDPDI/m5Ok9KeY3rFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9pbw/kzS+nl3WVSdqa9dUinfGrQKlgIs91UOzdsu/lqDIDjVpJ/z3R7zDnJFHEWbQxmZFJ8r7gb1PGOwBLyBTunlcb8QLs984IrzF9gaBYiOg+9xg1v2gV3b0AmcQOpSswWqk+FLe51DUE21gv//JVNRadN2LjGgeBedZOvHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uc4lrSah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746009273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57iokHmYjdcAZayIvqdZd5fOEHDPDI/m5Ok9KeY3rFc=;
	b=Uc4lrSahq1iSzNujDIxANcGQtBtzRqacvYLfUYaNpQxA4jiE78A+Fv1baXmm5h4KVAmdwH
	UuyUDomzlJ1sI/R0oer8u82OgFKUIkKh/pjbT2xMguMziZJGWAR8uHgceqB5W2A3wZJypq
	sCAan8oQ2qPXCR9RCvJl1pcFnBBFFpE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-oKJ_bMcUOZuAT27_Z1Q3FQ-1; Wed, 30 Apr 2025 06:34:31 -0400
X-MC-Unique: oKJ_bMcUOZuAT27_Z1Q3FQ-1
X-Mimecast-MFC-AGG-ID: oKJ_bMcUOZuAT27_Z1Q3FQ_1746009271
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e6de4ddbb3bso8234812276.0
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 03:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009271; x=1746614071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57iokHmYjdcAZayIvqdZd5fOEHDPDI/m5Ok9KeY3rFc=;
        b=Wego9PHifXJVG/gXEPqpP/55phDjdlt/Fx5DBw0NISaf1/R+m/MhZ4MBtCErzvHQMn
         S2DPmhQg82ACdHqvhMCUa1zuI2hd5T7P2d4yAIy7DO+/7JRjDSw9oH/IG2n0Qlsywh1w
         Gj2P19FO+Gy3m+8od+x5aXRT/DRc1IwspSmSaLf3ihZrvALjTbkIKJDZfgIAouqroTI5
         6D1Qi/EtjeBHGXV/rNuEz0GFGM3ttyfepjhaWod3KCcU57ExsfGhpmyQ7Q7d3Lv1HRyS
         NnXEH2EpW2e+V73znReRuLd3381OCn4hel5d1rZfjFQ8fvI/r34T/ZD3BRqfZt97uY/f
         XHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXXVuy6W4HnE1Lx9YDA1tloNj/wasAGY/0IEN81okgmXrK6JgqSmj7lzzYQchNVaNJanWCTGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwQmat3m/5tTCLb4kEJO8dmVyhXTR54xlUwecB7ndNZKkKnAR
	sfutHRR0nrQC0msk8MPcSgDQq7lEsOU8Do+SYFqCnmuPi61trgArMFAR692D/r/nGaDRb84CDnS
	GAAS2A2rmpU5i7uLNOiFtfedAwZhrmFQp/BaRcF0a52QAOvmtsBHu2+/W6erhXWYQ0e2OemL3O1
	njIw9Z17PEqz08zcvs5Ulb6Hd7UfRN
X-Gm-Gg: ASbGncuPqxx9fOiDHdgIqw7np6dTIl5JAGTtB1myozB53+M8o2iwyf/WVKDj5c3ZqjP
	ndxMx4cBS5/1n7lBSlKH7aB4B219XNYdkeeZJy+gmG8ZTBCOxGhv51n2UZ06Q2ptQszO3f74=
X-Received: by 2002:a05:6902:2e04:b0:e72:8aca:d06b with SMTP id 3f1490d57ef6-e73eb1e65bbmr3488705276.25.1746009271077;
        Wed, 30 Apr 2025 03:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2PrL/8Qtn9RsZP8gd5PYBcNrIX0CThPxJuTbKkfEk6rVR0kYHi6XEOL3ZZcMQ3Xfw0mqQVeC6RSWHmdB1B5w=
X-Received: by 2002:a05:6902:2e04:b0:e72:8aca:d06b with SMTP id
 3f1490d57ef6-e73eb1e65bbmr3488683276.25.1746009270736; Wed, 30 Apr 2025
 03:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-2-ddbe73b53457@rbox.co> <dlk4swnprv52exa3xs5omo76ir7e3x5u7bwlkkuecmrrn2cznm@smxggyqjhgke>
 <1b24198d-2e74-43b5-96be-bdf72274f712@rbox.co>
In-Reply-To: <1b24198d-2e74-43b5-96be-bdf72274f712@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 30 Apr 2025 12:34:19 +0200
X-Gm-Features: ATxdqUG9mjYJydPSVQyHlnDymiSRul3tknhI-VICJUQQ6q1CyA6LPz-wMS1FOD0
Message-ID: <CAGxU2F5_vZ8S7uoU4QF=J0jh11y976+AxFKf94dp01Fctq-ZwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/4] vsock/virtio: Reduce indentation in virtio_transport_wait_close()
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 12:30, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 4/30/25 11:28, Stefano Garzarella wrote:
> > On Wed, Apr 30, 2025 at 11:10:28AM +0200, Michal Luczaj wrote:
> >> Flatten the function. Remove the nested block by inverting the condition:
> >> return early on !timeout.
> >
> > IIUC we are removing this function in the next commit, so we can skip
> > this patch IMO. I suggested this change, if we didn't move the code in
> > the core.
> Right, I remember your suggestion. Sorry, I'm still a bit uncertain as to
> what should and shouldn't be done in a single commit.

Sorry for the confusion :-)

The rule I usually follow is this (but may not be the perfect one):
- try to make the fewest changes in a commit, to simplify both
backports, but also for debug/revert/bisection/etc.
- when I move code around and edit it a bit, then it's okay to edit
style, comments, etc.

Thanks,
Stefano


