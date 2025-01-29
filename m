Return-Path: <netdev+bounces-161534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565EA221FD
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88CD162C28
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1882B1DF248;
	Wed, 29 Jan 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="aCHYEhO+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF3143722
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169047; cv=none; b=I5TcrzAtSOakljsy6hpGPjfWoV1Uoet1fEDgsyNZwbgv/Ytn2HHMvKw8BNYpt7bXYZtcnofcCm5wdKM6RHQnkmCc44mHea7CiRfzIFH2tn72Oh81mDCW/VT6E8S0hGJKppJr9jtddpGLwOjbeLChmFECReAWTzocLX7sYDOZFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169047; c=relaxed/simple;
	bh=hKg5QSxKCFrPNhnrX8Gp+pkhaBSGardrL+l3tr4t8wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q05wZj+KStU2bYaXouXdrcAIclcw8sp7MfPfYzcUSjN4JYKczng736Mm8lkPLN7jfOlhpuAz6q1rvRjsqqGojzvJeKQyXzDNt8QH4qkr0xwnP6Jt+3UVwSyFV/Gq3b5XKvjfeBMWx8tE2oxpzZqcyrryfQpchDKGYzEjZrcEA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=aCHYEhO+; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hKg5QSxKCFrPNhnrX8Gp+pkhaBSGardrL+l3tr4t8wc=; t=1738169045; x=1739033045; 
	b=aCHYEhO+5wOfqYJcrVk898FHI54g2gLOeBgtaxTZ/cdL1WUe1ZpjDidGVDgGH31ffkYX7gOmPxy
	fcVg40SCaWlD4Q3VGpbPbmNqeK6XzLL5pQjQHZiFOeJ0CSIWGNneRRAfIqRpVyyCILrY8MetClwem
	4iZSRUA7gabXQJEcolB8IkigytqEAbrqFHvpLqi4LHw4GSLzPSuPWBIe0hK9mmRvHWzjBp4oTrNq9
	AbEf/4KrGy95xyPXQ0/jJCX5wK7D3K9bTuL81pm7gigRri/k3foVwPTvjN5MyF9S/jWXMFS4fUtGb
	IoPw4flNqOvJMlK8bm/jtBoef82n6MWqNXrw==;
Received: from mail-oa1-f42.google.com ([209.85.160.42]:49321)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdBAa-0004Ev-9c
	for netdev@vger.kernel.org; Wed, 29 Jan 2025 08:44:04 -0800
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29f87f1152cso3579872fac.2
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 08:44:04 -0800 (PST)
X-Gm-Message-State: AOJu0YxQDj7OX2lPh3O1Hx7jkAfWOmNXbqQjkoCsSscjxya2HNHcnN/p
	+0JIIY+7R8Zu1cbPmAdvwF0DPTl/N+7MXD81kU3Qw/yZhbrJ2JnfuKioHw7eUhmld6Omm+fvLvH
	MNbUffd/Wrkk64Ea1vH21UFM9tY8=
X-Google-Smtp-Source: AGHT+IEqovigGXqdRWt8g66jn5b/I8jeUGfPTBQcCosSeIATCMZaXsdLBVXr2RuzKSEsULcbj6zFQhg6Gq0H7k9Nxdo=
X-Received: by 2002:a05:6871:3a8e:b0:29e:592f:f4f3 with SMTP id
 586e51a60fabf-2b32f27fe8emr2067442fac.27.1738169043702; Wed, 29 Jan 2025
 08:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com> <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
 <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com> <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
 <9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com> <CAGXJAmyb8s5xu9W1dXxhwnQfeY4=P21FquBymonUseM_OpaU2w@mail.gmail.com>
 <13345e2a-849d-4bd8-a95e-9cd7f287c7df@redhat.com>
In-Reply-To: <13345e2a-849d-4bd8-a95e-9cd7f287c7df@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 29 Jan 2025 08:43:28 -0800
X-Gmail-Original-Message-ID: <CAGXJAmweUSP8-eG--nOrcst4tv-qq9RKuE0arme4FJzXW67x3Q@mail.gmail.com>
X-Gm-Features: AWEUYZkCvG4Jmt1JfJVM5w3XAhsPX2QKawMHQzqOnf3gx_VzYAHTq8r9Z_CpUyM
Message-ID: <CAGXJAmweUSP8-eG--nOrcst4tv-qq9RKuE0arme4FJzXW67x3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and homa_rpc.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: f219e97bb238ccbb8ed40879dafdba3c

On Wed, Jan 29, 2025 at 2:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/29/25 2:23 AM, John Ousterhout wrote:
> > In my measurements, skb freeing is by far the largest cost in RPC
> > reaping. I'm not currently in a good position to remeasure this, but
> > my recollection is that it takes a few hundred ns to free an skb. A
> > large RPC (1 MByte is Homa's current limit) will have at least 100
> > skbs (with jumbo frames) and more than 600 skbs with 1500B frames:
> > that's 20-100 usec.
>
> I guess a couple of things could improve skb free performances:
>
> - packet aggregation for home protocol - either at the GRO stage[*] or
> skb coalescing while enqueuing in `msgin.packets`, see
> skb_try_coalesce()/tcp_try_coalesce().
>
> - deferred skb freeing, see skb_attempt_defer_free() in net/core/skbuff.c=
.
>
> [*] I see a bunch of parameters for it but no actual code, I guess it's
> planned for later?

GRO is implemented in the "full" Homa (and essential for decent
performance); I left it out of this initial patch series to reduce the
size of the patch. But that doesn't affect the cost of freeing skbs.
GRO aggregates skb's into batches for more efficient processing, but
the same number of skb's ends up being freed in the end.

-John-

