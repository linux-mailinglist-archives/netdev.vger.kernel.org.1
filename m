Return-Path: <netdev+bounces-90425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99038AE16F
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB57B21E8D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428235914C;
	Tue, 23 Apr 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzgkWkVf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5756772
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866105; cv=none; b=NgiDh8l5/nqEpdtcwv1/Q4Tf3i/x7vaA1KQuZJsmil8stWvaJpY2m/CA5E7HLWnh+/GJ5WgFFKQ8Nav3xPeWpVt5Idli6oSyqRT894EUtJ1t25L3vIeCYQ24gXda6ayBBr02Zy8xv8YaG3yFpWxX5ng1AMwTKBaWHt/5BaYgsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866105; c=relaxed/simple;
	bh=l1SrZL1cASL2mgtxTBxC/NncYTe/aTqVERhCyL/t/As=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1MYErZKjG0S8HafPES9P0HkFJAuhRNzRx/PdWwaxY27x9ugnFOYMy7qp1uGx41Y2C/9cP361lmMA89PNwqgOG2tSoGYVr2oKdyhYAl18x2hIvkY833412xm8s/r4mNG4gMazKgSuV20uv2u2rSkw/Lz0FqHfYsuWLFjMxtFlpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzgkWkVf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713866102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l1SrZL1cASL2mgtxTBxC/NncYTe/aTqVERhCyL/t/As=;
	b=BzgkWkVf4DRS7E4moKtb65qYU3lgZ/hVmow6MrpPlo0S+ZPq75IfpKh6kOXPpwkOJZvDOB
	qe6sa1UcPQsQUnAtNsp7q9nZNDEYsqvPkA6efVt+xjkqOU+waSP5lHzBtJL5lH9lLXUcHl
	IDCrSUm2B72f2d2813D7UOLjqf08hNE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-f-42DQabMzmcHwYtal8cpw-1; Tue, 23 Apr 2024 05:54:58 -0400
X-MC-Unique: f-42DQabMzmcHwYtal8cpw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a0426da999so17325976d6.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 02:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713866098; x=1714470898;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1SrZL1cASL2mgtxTBxC/NncYTe/aTqVERhCyL/t/As=;
        b=a/5ATf9GANKfCcYTnJl//oOMPn1E1mKE8oz9BbB8M2oQBUXvTWbvUyWKGq2TtFK528
         Xqm8JmGjYn37g8FaNMSAhCKS9VQIbCf5lMaCwwzGvABlT11cDlgCHkWMDqXtfI7s3bXD
         e+LN0aZb+XY0Zoh8asRLMTCIwPiVUhO3+3ulBInvhaRBNdFIPg9fbAR9WWmUVDerd9PF
         r7qqPzmG/SNTHQ644Kpq45o/GtsUB6HB9+LCH2AF/86cp8EgXlZDj7cOZ9fD8b+Zoy5b
         LeJPyfWs7QpVnkaqEQwMqKoF/a3McDOsiLMhRo2ZwMkUVEkI6scPwYrionfs9kpr30G5
         xL1w==
X-Forwarded-Encrypted: i=1; AJvYcCVqmgZaOCJuCNPRPd/hG1p14e/Gn6Ds0/Rs99wFRqp7pmJuoxXvYa6FXCooggIS/ZcabRiBgC0PFUk5fKG6BU+96GKfozTm
X-Gm-Message-State: AOJu0YxbgQ3OgtgJzKhtbg8zzsJh7nM2YXBpIJNKCpssbdoR+8kgBJyH
	g5GHpZsFjAXvpZ/Y3BnuBAtM9PvFpv8vdAUCnl1G2MHXpB5f8GAHdjGWfR8rerh0vnc7Tk/UJ17
	fhg+DWyBRP1KjM+eeWekGMzIiX0R1tdbPWXTMuRAcpKe74BXYhOkHTw==
X-Received: by 2002:ad4:5fcb:0:b0:699:4d3:98dc with SMTP id jq11-20020ad45fcb000000b0069904d398dcmr14771982qvb.0.1713866097892;
        Tue, 23 Apr 2024 02:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEANV+wUlgWipvpnUV1mlQ7bpFEg3Rx+pUadk29eSRaTsNmr/HE01WaOfhMOXYsJIT7SQmzyw==
X-Received: by 2002:ad4:5fcb:0:b0:699:4d3:98dc with SMTP id jq11-20020ad45fcb000000b0069904d398dcmr14771965qvb.0.1713866097581;
        Tue, 23 Apr 2024 02:54:57 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id g6-20020a0cdf06000000b0069f1c071f1csm4948323qvl.29.2024.04.23.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:54:57 -0700 (PDT)
Message-ID: <1c757979de156d01dcc3f011af35a4895c7a7bb7.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net/sched: fix false lockdep warning on
 qdisc root lock
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Davide Caratti <dcaratti@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>,  Tariq Toukan <tariqt@nvidia.com>,
 netdev@vger.kernel.org, renmingshuai@huawei.com, jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, xmu@redhat.com, Christoph Paasch
 <cpaasch@apple.com>,  Jamal Hadi Salim <jhs@mojatatu.com>, Maxim
 Mikityanskiy <maxim@isovalent.com>, Victor Nogueira <victor@mojatatu.com>
Date: Tue, 23 Apr 2024 11:54:53 +0200
In-Reply-To: <CANn89iKH9FQFjnkmSCX2qcjcvG2GZigT+hFgKEd6P4L5fvGmTA@mail.gmail.com>
References: 
	<7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com>
	 <CAKa-r6tZkLX8rVRWjN6857PLiLQtp92O114FYEkXn6pu9Mb27A@mail.gmail.com>
	 <7ce1a0dba3cc100e6f73a7499b407176a99c0aa9.camel@redhat.com>
	 <CANn89iKH9FQFjnkmSCX2qcjcvG2GZigT+hFgKEd6P4L5fvGmTA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-23 at 11:40 +0200, Eric Dumazet wrote:
> On Tue, Apr 23, 2024 at 11:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >=20
> > On Thu, 2024-04-18 at 16:01 +0200, Davide Caratti wrote:
> > > hello,
> > >=20
> > > On Thu, Apr 18, 2024 at 3:50=E2=80=AFPM Davide Caratti <dcaratti@redh=
at.com> wrote:
> > > >=20
> > >=20
> > > [...]
> > >=20
> > > > This happens when TC does a mirred egress redirect from the root qd=
isc of
> > > > device A to the root qdisc of device B. As long as these two locks =
aren't
> > > > protecting the same qdisc, they can be acquired in chain: add a per=
-qdisc
> > > > lockdep key to silence false warnings.
> > > > This dynamic key should safely replace the static key we have in sc=
h_htb:
> > > > it was added to allow enqueueing to the device "direct qdisc" while=
 still
> > > > holding the qdisc root lock.
> > > >=20
> > > > v2: don't use static keys anymore in HTB direct qdiscs (thanks Eric=
 Dumazet)
> > >=20
> > > I didn't have the correct setup to test HTB offload, so any feedback
> > > for the HTB part is appreciated. On a debug kernel the extra time
> > > taken to register / de-register dynamic lockdep keys is very evident
> > > (more when qdisc are created: the time needed for "tc qdisc add ..."
> > > becomes an order of magnitude bigger, while the time for "tc qdisc de=
l
> > > ..." doubles).
> >=20
> > @Eric: why do you think the lockdep slowdown would be critical? We
> > don't expect to see lockdep in production, right?
>=20
> I think you missed one of my update, where I said this was absolutely ok.
>=20
> https://lore.kernel.org/netdev/CANn89iJQZ5R=3DCct494W0DbNXR3pxOj54zDY7bgt=
FFCiiC1abDg@mail.gmail.com/

Indeed I missed that, thanks for pointing out.

> > Enabling lockdep will defeat most/all cacheline optimization moving
> > around all fields after a lock, performances should be significantly
> > impacted anyway.
> >=20
> > WDYT?
> >=20
> > The HTB bits looks safe to me, but it would be great if someone @nvidia
> > could actually test it (AFAICS mlx5 is the only user of such
> > annotation).

Let's wait a bit for some feedback here.

Thanks,

Paolo


