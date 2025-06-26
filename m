Return-Path: <netdev+bounces-201395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09969AE944F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20A84E142F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF7213E74;
	Thu, 26 Jun 2025 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpGg4q8K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB14212B31
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905545; cv=none; b=lFqvVDgoWpCFXY2smnzo/NleSAF5Ta3nNcLwVsZG1P2eZ9VvTC4J2t//uRo/gpk8BQFKeELD9muLHlpePfj/X2ruw6aTRlUejYesROBMl5Ab/BZT2jmhqKZ5AZVsoY7un8iqYHIVNOgzoMlHExg5OZxAqaKDmHaGPghwfTgk2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905545; c=relaxed/simple;
	bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkTeko+2TSYSKGqgNoN1BqKZiKEduzlAnT1Qf0TULFSsFJpmerCLReBYouMna+I4nxiGIaVLMXqpBT3M1RZpYw/vlfT9ivZmOr4BgPAhQq2nMN+K+jQuv+ucj6CqhIvGqlkarc3L4yZsEyyEBUpthoVfIZvDqkvZlZNSb0B2buA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpGg4q8K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750905542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
	b=GpGg4q8Kh3LzKa6ebCOrgqW09cOh2AscACGseimvPM96zHYB1N4qfCkNF2y9M7IKyx4HB5
	kHa5THA3lZvi3x10bMhFH6HNow44wccE9RivR80ptOT1FsuT6wCg23mrkmap0UAj64xYsB
	mN2oaLnsN5E8MsHWE2n1ech8npHOalw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-kkWVCoP3MmuVXyFvAoOWig-1; Wed, 25 Jun 2025 22:39:00 -0400
X-MC-Unique: kkWVCoP3MmuVXyFvAoOWig-1
X-Mimecast-MFC-AGG-ID: kkWVCoP3MmuVXyFvAoOWig_1750905539
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2349498f00eso12865575ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 19:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905539; x=1751510339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
        b=N6idRMv0aBeHev8ZuxN8MFTS8PacFGEQOjd1DEFlLvA3vUceY8dHBpSrcTQOD5RjxO
         6VIWMzD2frb04qWk4b0/K3eql3Y7PLcA6RqYF9RUufIF8Chgdd3991n/1rRSCPdTzf8c
         +izeOYqpJAV/L+u23P2l8uFuXQC4vQ02VXKEmHRN+Y/tlHzH25vNZvCxkoYKDjDJnM+g
         SFZku9TsDSyaBECnLB/tCAL0mZi3ekqkLxE00yU1eh0wLb+YA0OW5PWkmKcdTh7UFMAl
         /bTzyjGICzVlx9Yc71Y6LTyVy77nev3u7xsM/RRhEP0gz/x+JgbbZw40G12e3lLrX5bo
         WZ8A==
X-Gm-Message-State: AOJu0YzQHMq6vZN1MhuT7O/MBF6rwb5YnQ0xeT6fRokAiL/rv74EEI5v
	CdDFZixw+uoL8tRg/T1EU6orOcPcsWcYjzCnsMK/qhjAJhb7fzrbz4zblFkpCxaJs3Z227dQTIp
	sq/802iFGPDJQidlXl10IWfXhA1QrMA9SzOkIcZncd9jLvvSfN2OM9vfCl5kDDXoRCdr6I742RB
	S1NLH3iGg1UMZ9Mx0vAbD4W1hE6Ons+qCg
X-Gm-Gg: ASbGncuJphDX7Z1bh3cbMTk2HkjMiwpMTbXgd8mp3BkTWSGRd35sfPS4BToOo4k8BOK
	NrAwEAQOoQcchVSdfMSIIbbOYln47oRipy2JgrX/fQL0VJ9NDnuSRLO2IS7y7Ds/AXkTApRBLnT
	5t14Y1
X-Received: by 2002:a17:903:3c6b:b0:237:f757:9ad8 with SMTP id d9443c01a7336-238e9e06b68mr26264435ad.1.1750905539235;
        Wed, 25 Jun 2025 19:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeb7cSsXZgQCsbZuX3BxI9ea2eoF1dmzDHFHzV2vn7oWQ24AkuEOzAXNT7eLnpup8aMyphvstnn6ceEBYA5HM=
X-Received: by 2002:a17:903:3c6b:b0:237:f757:9ad8 with SMTP id
 d9443c01a7336-238e9e06b68mr26264205ad.1.1750905538830; Wed, 25 Jun 2025
 19:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-4-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-4-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:38:47 +0800
X-Gm-Features: Ac12FXzGBspfM0xNLFV6s_nJRqcVgjaFcF2_Hcvm4OR2ygauzrYWua0l6j8T7wo
Message-ID: <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Currently, we have repeated code to check the received mergeable buffer's
> length with allocated size. This commit creates a helper to do that and
> converts current code to use it.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

I think it would be better to introduce this as patch 1, so a
mergeable XDP path can use that directly.

This will have a smaller changeset.

Thanks


