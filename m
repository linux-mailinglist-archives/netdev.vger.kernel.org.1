Return-Path: <netdev+bounces-74073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752085FCF6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB571C225B9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BEB14F9C5;
	Thu, 22 Feb 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5t2/Zcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B178E14E2C3
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616876; cv=none; b=f/402R2/9O00Ri0kNiGhKzlwlXI03D97yCKWn5Hzk/NQ0YIdrgx1zJVG0v8IYDMHdVzDslBYuHsBeIWP4iL6JyAgeXmQpee1NWWWoYqnbbMR5V4kFERQYffk/OMOcMfNv5IimfPzo1S7PWW+HwMkYVfcgBGEZ98UarH+1lFtcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616876; c=relaxed/simple;
	bh=iuQWyzF6N/DDMROgfqzA6UD2AURk0eWw9/HuWbTZFVE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U+kMCLhhO9TADTsl7xZ0+cDF/DYwZw667JxiGpBeuhMJEz9OBfzzT87L+VrzX55usuvvzQQzSSDOkgcUyLnLDVM1T+jkyKzSm508QsW60GI/5PANvGYo2DjYiur4LgtIObys0uUcF915tOE4cJrt2TVsCWVe3MdN6WkYuzYNMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5t2/Zcz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce2aada130so7026032a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708616874; x=1709221674; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwtNz5UBqomgubAwMoqD7R7UuwAQWY2h1rdUgiKU8Xg=;
        b=N5t2/ZczGEOuPkpsLaiXqpMnb3e/AoqlpHlQZoSZqN6+WopVj3oJYSegAqqL+3ABxI
         8W7V1xuAEthIY7kCus3wapxlpCMpPvOWgLsuP9NnNZJ1eKIqm9f69nOEYO8Zk68bNLLJ
         ELs/Up3RTsRiyf6WX9ckxAnHm+r+ITDmWYE6OK61FusIhr8tkzXGjc4TeQuBlNC6eqFa
         EMBIZfUAVPtIUbPwPiIBW3dgp8FSYq9e7tgnrJ+txITXLIjmCbSt4WxwiwY4Vi3LsXey
         uyc+2zih+NQ3mQYGOEOFrrGYfnF5d/TqDSO7RvuTaNe0b9dK0POyEHNp3mcdS2GQrONM
         S10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616874; x=1709221674;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwtNz5UBqomgubAwMoqD7R7UuwAQWY2h1rdUgiKU8Xg=;
        b=F978Lcl+wkMTt2S57rwNjKxXJkzK+qVYRzD4opzC9kK04JnSkBBPxhxkxC48wkpPVm
         bfl8LAtgsZWidpBwVlwrY6Ou7XDMp0fherrz5vT4489dsFrzExhb0lPFDleLAaw8vyBZ
         nbRCRIbtJ2f4Q4q5WH3luHxbiPJS3zDFiR+SSp4VrqGzwwZbtMZXDjitoX/qaazRTZmE
         eJhZmqp24PJIRpns+V2GqCRywJyTut0WOvrg98QcU9IRszM11ZGqZ//b77yj/PY57vY3
         qtbW/Ezg/+xOPIKBXMmTI63s9kobPR/sPegmkeUWkUAx4iLnQesi6HtRur38p6BatQ0l
         yjlQ==
X-Gm-Message-State: AOJu0YwLFxQL3cnbhYDf37nRd3DEgdfSPdfzVPb+XT29/ilVsZSSkepL
	hZ5E+LZIPq1PdEX3/hPCl2IDMy2tlMkt7Y+D1FT1B5SixXzyLm9OBCCes75bCWc=
X-Google-Smtp-Source: AGHT+IFT7/JHYEw50EogqNR4asTq3LpEcyRf7pSlI9DLdh/IkmFUqD714aRdXfbJwjy5xc/PkV1o0g==
X-Received: by 2002:a17:90a:e008:b0:29a:5714:f9df with SMTP id u8-20020a17090ae00800b0029a5714f9dfmr1239294pjy.35.1708616873926;
        Thu, 22 Feb 2024 07:47:53 -0800 (PST)
Received: from smtpclient.apple (va133-130-115-230-f.a04e.g.tyo1.static.cnode.io. [2400:8500:1301:747:a133:130:115:230f])
        by smtp.gmail.com with ESMTPSA id pl2-20020a17090b268200b002997cac594bsm4148008pjb.51.2024.02.22.07.47.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:47:53 -0800 (PST)
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
In-Reply-To: <20240221164942.5af086c5@kernel.org>
Date: Thu, 22 Feb 2024 23:47:37 +0800
Cc: netdev@vger.kernel.org,
 pabeni@redhat.com,
 "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <36F1F1E8-6BD7-44ED-95EB-F0F47E78EC9B@gmail.com>
References: <5F52CAE2-2FB7-4712-95F1-3312FBBFA8DD@gmail.com>
 <20240221164942.5af086c5@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)



> 2024=E5=B9=B42=E6=9C=8822=E6=97=A5 08:49=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, 20 Feb 2024 22:38:52 +0800 Miao Wang wrote:
>> I tried to bisect the kernel to find the commit that introduced the =
problem, but
>> it would take too long to carry out the tests. However, after 4 =
rounds of
>> bisecting, by examining the remaining commits, I'm convinced that the =
problem is
>> caused by the following commit:
>>=20
>>  9d3684c24a5232 ("veth: create by default nr_possible_cpus queues")
>>=20
>> where changes are made to the veth module to create queues for all =
possbile
>> cpus when not providing expected number of queues by the userland. =
The previous
>> behavior was to create only one queue in the same condition. The =
memory in need
>> will be large when the number of cpus is large, which is 96 * 768 =3D =
72KB or 18
>> continuous 4K pages in total, no wonder causing the allocation =
failure. I guess
>> on certain platforms, the number of possbile cpus might be even =
larger, and
>> larger than actual cpu cores physically installed, for several people =
in the
>> above discussion mentioned that manually specifing nr_cpus in the =
boot command
>> line can work around the problem.
>>=20
>> I've carried out a cross check by applying the commit on the working =
5.10
>> kernel, and the problem occurs. Then I reverted the commit on the 6.1 =
kernel,=20
>> the problem has not occured for 27 hours.
>=20
> Thank you for the very detailed report! Would you be willing to give
> this patch a try and report back if it fixes the problem for you?
>=20
> It won't help with the memory waste but should make the allocation
> failures less likely:
>=20
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a786be805709..cd4a6fe458f9 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1461,7 +1461,8 @@ static int veth_alloc_queues(struct net_device =
*dev)
> struct veth_priv *priv =3D netdev_priv(dev);
> int i;
>=20
> - priv->rq =3D kcalloc(dev->num_rx_queues, sizeof(*priv->rq), =
GFP_KERNEL_ACCOUNT);
> + priv->rq =3D kvcalloc(dev->num_rx_queues, sizeof(*priv->rq),
> +    GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
> if (!priv->rq)
> return -ENOMEM;
>=20
> @@ -1477,7 +1478,7 @@ static void veth_free_queues(struct net_device =
*dev)
> {
> struct veth_priv *priv =3D netdev_priv(dev);
>=20
> - kfree(priv->rq);
> + kvfree(priv->rq);
> }
>=20
> static int veth_dev_init(struct net_device *dev)

I directly applied this patch to the veth module on 6.1.0 stable kernel =
since no
reboot would be required. No problem had occurred in the previous try on
reverting the patch in question, which lasted for about 76 hours before =
I replaced
the veth module with this patch applied. I'll monitor and report after =
24 hours if
the problem does not occur.

Cheers,

Miao Wang=

