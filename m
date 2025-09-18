Return-Path: <netdev+bounces-224527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05BB85E55
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089863B1FD3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA6313E20;
	Thu, 18 Sep 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOr72Oha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641493148C5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211451; cv=none; b=ThW7CXtq+PCjk6zfKTCfGI/8Y352RhMpSWUDYw0y3TqtjXDaV5fHYLAKR2MCy19rJHrbfsnyJYdf2GYX2MWE7BRbfnQIh5gwgsuZquLCKjnoRGL8w0NQSys1kOhnpTNyscwy3PnzRqQSxXBg8vLhboiQKB1TNEVLrllUbT+3aFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211451; c=relaxed/simple;
	bh=Z5B5dt6wI87+KOD3sTN8FRIoAj7TBjgpAUwP/aqCmqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bM4NRnoIU7S0J7yA7lYXqcDBPR0rM2hv76yrWDB8q7WZXP16rr865X6BxGAuNbLIsUANHk1LLr6aK7YiTOLl8Do0nxvAhiqFE+F3yxq0WAWuubmtBGZzYMwiSD45Sd7InpO4BQpOSdP0LFMJ9/Q8W3HO57QxQpg5DIzshbjt6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOr72Oha; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324e41e946eso1803057a91.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758211449; x=1758816249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqabNObTrUIXb/BYAEPfcGgxscP8Gw2Vuj2oVftkStA=;
        b=VOr72OhaMYpzapuIs580oRqi7i5QW15pQ9M7wpE19Y140mgSmxSlSVReqFLOdc+dEJ
         TNey1BMN6NnoMxNbUCB6x7YhYkHnduajq+EtrEbB4RPOCSqhq6RxkIP52vIQ94Oxpj9n
         wgd5FY7+hHyR2ZAi9W6K8Fh3rcnD7DvjNqx+s8Ox7BzmO9bSWKRNAAdeaoUZ9OAnWrtq
         UGKNxq2qcV7Xy2dSdlpMgMs0wXSQ0N0G983D8i9Z2DkJQD6pTjRwSh9ujtkhg+2p0e4z
         GsxHpfYUP/U/iqEP2WuxUDFFHEB0FM972laqIV+9ueYEzkZ6PvV0xIMG4/HF34G1cagy
         bS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211449; x=1758816249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqabNObTrUIXb/BYAEPfcGgxscP8Gw2Vuj2oVftkStA=;
        b=fn8DobcGdoo8DM7jWZarJggUFkOyzioaZdDL8rCG2tYib3+ItSK300btBv3Uo05/+z
         NJC6t/kc48gyi6EKQbk9lyoES+fNZ56lrefKpXegQm3fPhEvP3KPssIiwn4RcwgeZtNa
         UZ9hO7hpHR9mVIQnr4Cysk0Oc5QmFy5dIdOQNesI65GCOwDX2n2SMSLUbrgIcjlJwPXj
         m1I1dYbSVPdVps5SnCG5sVvVxLCM24gwFCWj/c5eX0hmMIsLDjf/K6umWVkdPttTJOAi
         4FMLCyJZ0jBTxzOutVhmQXWjQGknGtFbQkZZNxtML42ddn3FYQAa3+Nt39Jkla8ELSgF
         8ZXA==
X-Forwarded-Encrypted: i=1; AJvYcCVe11+e8OhGCTvutj1Tmfyfmjo5SpbjLfmvpOQFMiAz7b6pMsr4UwzM2GFaSp1IsEmzHLUiF48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSIfMLu9Ep7Jd92aT/j88HO32XJTVAec+8NoSiYqeQCWHxw12
	L7Ws0itM+OL/dpdMyw82HoJYnPDmpoAXXpwE5i1k6SHdNi5bM57xcwNDlJX3ANpMqWTlBi4XQUJ
	Ekzj5zA==
X-Google-Smtp-Source: AGHT+IGkmbYJfZP5nllHSP5gPnF6lwqm76wSLahcIX1/RcNPCgiykqnALzGjrifpViIQLPrzkR7sDPMdXBM=
X-Received: from pjp16.prod.google.com ([2002:a17:90b:55d0:b0:329:ec3d:72ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f4b:b0:32e:9281:7c7b
 with SMTP id 98e67ed59e1d1-32ee3ebb1e1mr8451052a91.3.1758211448798; Thu, 18
 Sep 2025 09:04:08 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:04:07 -0700
In-Reply-To: <20250918154826.oUc0cW0Y@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org> <20250918154826.oUc0cW0Y@linutronix.de>
Message-ID: <aMwtd40q44q5uqwr@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > So how about switching to this approach then?
> > Instead of piling up fixes like we seem to do now ...

I don't have a strong preference for 6.17, beyond landing a fix of some kind.
I think there are three options for 6.17, in order of "least like to break
something":

 1. Sebastian's get_task_struct() fix
 2. This series, without the KILLED sanity check in __vhost_task_wake()
 3. This series, with my fixup (with which syzbot was happy)

Longer term, I'd still like to land everything though.

> > Sean?
> 
> Since I am in To: here. You want me to resent my diff as a proper patch?

Ya, I think it makes sense to harden against UAF even if we fix the KVM bug more
directly.

