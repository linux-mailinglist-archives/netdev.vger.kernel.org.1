Return-Path: <netdev+bounces-74625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C329861FE5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E91B1F2349A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAEC22071;
	Fri, 23 Feb 2024 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIrJGs6j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC410A33
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727856; cv=none; b=Yq/uCDgm6Ta7JbwqMYHaNhh+GPYYQ5ox9oHbkjk+rQ2R4unrSK80vC1dIrEn73Rd7fblUbCxhneJfJtLHX3D+rDoEZNLzw/boZeDwRf2SQSiXeMawFn84TWIMkc+1H7D1C81kIzUNUvO3uFamAD5tMmDRS8i/3Elg4kL5eDIK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727856; c=relaxed/simple;
	bh=T8zseAlUyedDzBkBQp/PAJcc5BpLsmCCWlmysKCfFng=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lCFQNNzv9E9QBFrHmuWusezsFDYveUt9yj3p1bhrSYrD/emtUG/LpcD63g8amw3F3oLtkeGGCsuEthxgTv2m/OGMNgXn0fiB3on8YdU9fh16ARr8o0QRdBTLM/Oaff2nAd2hAp2+pTu0L2SG+Az8+m2TIa+u8lXZNEwj4deDeyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIrJGs6j; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da9c834646so1217072b3a.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 14:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708727854; x=1709332654; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zbjtl8MSI5cpIvVbKottlrM7NLh5VQOkXgx+nlXVyCg=;
        b=AIrJGs6jS3d+GvWjg2p0HQ98ftSfMDqEgJUrbbDuva005hL0iPzrk5VjfSiUMzl+N1
         BIpnKC4eB/1AxVRHUpOjaItdQBqkFglljL4Stikx3Wu8709T2WbH3SoWio6JpuQ7aB3J
         klkpBDLBa9GCH1CxJ65PelC4e9uvtrjbkWyLAuhgp4gcMATdyUGS1d9bMYU3PfjaulC7
         jDWoQHgbuNQB2Yz8QqxyhVF7rNoqeiB/9icBgAIkX7p1+bJcovpOMgcKu3NtH4DET+nl
         mK6EJbc7G4nxjDWc8AJPyjmfshYtvG599e6YfvFadxEHxHbg3AaN3hSlkafqYQvidvuy
         iWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727854; x=1709332654;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zbjtl8MSI5cpIvVbKottlrM7NLh5VQOkXgx+nlXVyCg=;
        b=J0sRtq+aA80aT2sFS2WfXP+Y//hKyEIDCB2R8/9W6yH2JAXoOBck71r8+2g5XFfAiI
         /dSRV8SVVJxcGXVN5zv8pxGRIDHWvpm3I9r1DYLfKxiV79XtWuL2rhNXqtw+nlYXPnFL
         n95rv/wCA5sjl2In4JhD8UOVTM5d0prujSc8cWrB90LMOXyBKx39Zx5vhoj+HEjHjGvl
         2smhJXO8wN78wcIVnfww+qIdtrJCIJdOhUtZBJbclVRPJrZKLLTA29hwyiBLYkFgceMR
         9QguHJtz1XDse8LXgN0mFUYJgXlzWA3yjBkmMJRCMDzhkM9/A+9fzZPvvg1xnyPwacpC
         HgmA==
X-Gm-Message-State: AOJu0Yx5fuk2ByJkSrH2zgumEbNkbwyDoqzQtoCuv9T8WAqittYbIn6b
	6vxuv7qKwxICdwbIH169ICok32YO/Su9hV8sDe6IuAHljiYxNOaim+04BcLcxsZ3a+jt
X-Google-Smtp-Source: AGHT+IGXuM6eXEMIiGF+bZa2ybTRbH4PSJw63NNIqOfAikkmxv5ViSjZx2j/1KHsbBQ7J1izO9ibMg==
X-Received: by 2002:aa7:9edd:0:b0:6e4:e65f:b0cd with SMTP id r29-20020aa79edd000000b006e4e65fb0cdmr1101464pfq.10.1708727854355;
        Fri, 23 Feb 2024 14:37:34 -0800 (PST)
Received: from smtpclient.apple (va133-130-115-230-f.a04e.g.tyo1.static.cnode.io. [2400:8500:1301:747:a133:130:115:230f])
        by smtp.gmail.com with ESMTPSA id j18-20020a62e912000000b006da96503d9fsm13334818pfh.109.2024.02.23.14.37.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:37:33 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [Bug report] veth cannot be created, reporting page allocation
 failure
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <36F1F1E8-6BD7-44ED-95EB-F0F47E78EC9B@gmail.com>
Date: Sat, 24 Feb 2024 06:37:18 +0800
Cc: netdev@vger.kernel.org,
 pabeni@redhat.com,
 "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78C6CA8F-3634-418A-8A50-71753B5DB0C8@gmail.com>
References: <5F52CAE2-2FB7-4712-95F1-3312FBBFA8DD@gmail.com>
 <20240221164942.5af086c5@kernel.org>
 <36F1F1E8-6BD7-44ED-95EB-F0F47E78EC9B@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)


> 2024=E5=B9=B42=E6=9C=8822=E6=97=A5 23:47=EF=BC=8CMiao Wang =
<shankerwangmiao@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
>> 2024=E5=B9=B42=E6=9C=8822=E6=97=A5 08:49=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> On Tue, 20 Feb 2024 22:38:52 +0800 Miao Wang wrote:
>>> I tried to bisect the kernel to find the commit that introduced the =
problem, but
>>> it would take too long to carry out the tests. However, after 4 =
rounds of
>>> bisecting, by examining the remaining commits, I'm convinced that =
the problem is
>>> caused by the following commit:
>>>=20
>>> 9d3684c24a5232 ("veth: create by default nr_possible_cpus queues")
>>>=20
>>> where changes are made to the veth module to create queues for all =
possbile
>>> cpus when not providing expected number of queues by the userland. =
The previous
>>> behavior was to create only one queue in the same condition. The =
memory in need
>>> will be large when the number of cpus is large, which is 96 * 768 =3D =
72KB or 18
>>> continuous 4K pages in total, no wonder causing the allocation =
failure. I guess
>>> on certain platforms, the number of possbile cpus might be even =
larger, and
>>> larger than actual cpu cores physically installed, for several =
people in the
>>> above discussion mentioned that manually specifing nr_cpus in the =
boot command
>>> line can work around the problem.
>>>=20
>>> I've carried out a cross check by applying the commit on the working =
5.10
>>> kernel, and the problem occurs. Then I reverted the commit on the =
6.1 kernel,=20
>>> the problem has not occured for 27 hours.
>>=20
>> Thank you for the very detailed report! Would you be willing to give
>> this patch a try and report back if it fixes the problem for you?
>>=20
>> It won't help with the memory waste but should make the allocation
>> failures less likely:
>>=20
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index a786be805709..cd4a6fe458f9 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -1461,7 +1461,8 @@ static int veth_alloc_queues(struct net_device =
*dev)
>> struct veth_priv *priv =3D netdev_priv(dev);
>> int i;
>>=20
>> - priv->rq =3D kcalloc(dev->num_rx_queues, sizeof(*priv->rq), =
GFP_KERNEL_ACCOUNT);
>> + priv->rq =3D kvcalloc(dev->num_rx_queues, sizeof(*priv->rq),
>> +    GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>> if (!priv->rq)
>> return -ENOMEM;
>>=20
>> @@ -1477,7 +1478,7 @@ static void veth_free_queues(struct net_device =
*dev)
>> {
>> struct veth_priv *priv =3D netdev_priv(dev);
>>=20
>> - kfree(priv->rq);
>> + kvfree(priv->rq);
>> }
>>=20
>> static int veth_dev_init(struct net_device *dev)
>=20
> I directly applied this patch to the veth module on 6.1.0 stable =
kernel since no
> reboot would be required. No problem had occurred in the previous try =
on
> reverting the patch in question, which lasted for about 76 hours =
before I replaced
> the veth module with this patch applied. I'll monitor and report after =
24 hours if
> the problem does not occur.
>=20

It's now about 30 hours since the patch is applied, and the problem has =
not occurred.=20

Cheers,

Miao Wang



