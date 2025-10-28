Return-Path: <netdev+bounces-233561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7483C1570E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328C440564F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF38341AC3;
	Tue, 28 Oct 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+4v4gLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9C340DA4
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665198; cv=none; b=qrJI+Ma/+mqwK+fDWfUdZFmMWnJymc/gt4gsgGYugkcPu4XisvdVqvnLxlUZPV9JtdTgXEwBnBOvrqp36flSJpBgluTSRWaBdWrZvmjqb6SiGwM+FV40uSC05cciUrqmfvZxm7iMEJ7hGTg/Vb7X6PoCrdPxWHsqy4iVsIA5zJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665198; c=relaxed/simple;
	bh=4M2/3ejgEOnPWTU2k4hO2uU/c3DMXoSdd9TFkij3CjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFwO0wd5OjHb4IE6p7zvr88S97rfX+cttE3+MAcVtHAHbYvpdEIgbGIit8A+542K/w7EgOYwJVNGAQF1RPHm2ZkduqT5D4C5cAP0U/nf1rK1arherUQw4j4EnVdtDEaDufNO2SWJQW29xKeu1q9fbVPpSIWE8LwOPZ23fb7WqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+4v4gLk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso25884175e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761665194; x=1762269994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMaVfQlDtYuJ6c5NZttg0Mv3ou88wdr4jRmdcFT8ouM=;
        b=H+4v4gLktyhkWnO7rIvfpaDbP1EZoak/ELNlG+aWCfSIyjmweJzP4qr/KzOkYurWYB
         yv/nXmXbRxYPaF9C55CiKtriWItZytTj2aI3KHdclvZT8ySVryPTUZCYV7QiyDC4Sp6S
         xX+d3Gz1o0GZmOeTfCbsduadmbmLgI5UUxq7j8LVYDAloFBK3SOLFNm+31cD8ZECGNF+
         NhRxi8lKh+p32c/6WVVGmahp2Xj+eEw8QRWIaqN33uijiLA4jTCnJoKMGvP3XLWSRgXT
         KhGDnIeRUnFJ3ONf7cZDUt8tCFSi8WPsf44ThO+7skv40UKVCatVggN5xXocoTNAarM2
         lrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665194; x=1762269994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMaVfQlDtYuJ6c5NZttg0Mv3ou88wdr4jRmdcFT8ouM=;
        b=ez4F2e5xHRHwYuWOJiXY50+OiV/fRQ9wRn54GWzFV1diihFbaIy/nXsEoNzFHdjk87
         0HwKvk3Z1PBmJX4qpnIA5rU/NTVuziS1LuEWg7l+pEjeyJffJ3XKTZsVnoLgHV1kkMos
         exkkYjfnkNrwRzDNikn2mo/H6iTs3GjH5cW+QQGPo8WiSDhajUxxIJ+XozsJ8z7Qn1HI
         ftZgxgIXHDvMHOu9inyvGgoJMAJW8GiuJIM7LSEsFklXFHpGV6j8yE3rbUYVvVNzH7kX
         y/KRQ5sbRIssQ7WHVaPNwdY0sdSGGtoH1pdgvgEXUvs71aNpjPiB3CIVajlJ51/SjXRW
         zAZw==
X-Gm-Message-State: AOJu0YyLmoHGPwbcyJHN/c/VoPcdpca1aS2FOSEUc6AN9Bpgk5D6vF51
	4kP1UO3BtWYMroCGsQnNECQuxVmzD24xYoKhf11nvF/vtXfL4vIAoHgNB4RqN1Ec9wtsKLRlHJV
	Wr0DQRO4PHJ2D0JP2vjLncyKFL8HCC7M=
X-Gm-Gg: ASbGncu68tFRBWkHk8Rk8QO0I7IwiLH7Fvgkac9pEpB51jTPsTuJfmvyrUc2tnQFzlL
	tMcS/ryampmFGdBR1HnNTLt4j9B6xogl7QDNA9pIGNqk9HHW7e0dKMWkGwMhUTw+DgVASgOaMWX
	GrTNAa4l/6cn+E88OTkOFp7VIJercmk58pc4r5hctRGmVnzd9/7YcTXPZ9qGeGVsoAlTN/kKawx
	w4QWNmxP5Is2QLcltfecbzqmu2uTSJIZj5qcdtryD4e57WOSXA/PRNQyzVWqdJcrVt+I1RC6X7l
	SQjF30gmOFH+bFK8sw==
X-Google-Smtp-Source: AGHT+IFecXEBer9gY3Fw6bXmh2cLauGwvMSJKmcd/nJJQmi8Wb6V42y+e2nXPa7xL85yaGozx7KScirkyKtgA+pwrqA=
X-Received: by 2002:a05:600c:8216:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47717e30970mr33123315e9.26.1761665194193; Tue, 28 Oct 2025
 08:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133845391.2245037.2378678349333571121.stgit@ahduyck-xeon-server.home.arpa>
 <59f1c869-58c0-4158-82d7-e7b11870b790@lunn.ch>
In-Reply-To: <59f1c869-58c0-4158-82d7-e7b11870b790@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 28 Oct 2025 08:25:56 -0700
X-Gm-Features: AWmQ_bkaUO1kkrdof1AVi8vi6kcMrBG7lqOhVJnvIyuE4P4QiZgjLGqZ7Jd_MEU
Message-ID: <CAKgT0UduBJYty0WRzQMuzg64rbdMyZ_ubhgOh-q_Df6NPXsA9A@mail.gmail.com>
Subject: Re: [net-next PATCH 3/8] net: phy: Add 25G-CR, 50G-CR, 100G-CR2
 support to C45 genphy
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:57=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 24, 2025 at 01:40:53PM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > Add support for 25G-CR, 50G-CR, 50G-CR2, and 100G-CR2 the c45 genphy. N=
ote
> > that 3 of the 4 are IEEE compliant so they are a direct copy from the
> > clause 45 specification, the only exception to this is 50G-CR2 which is
> > part of the Ethernet Consortium specification which never referenced ho=
w to
> > handle this in the MDIO registers.

I will go ahead and split this up as you suggested in the other email.

> Does the Ethernet Consortium have other media types which are not in
> 802.3? Does your scheme work for all of them?
>
>         Andrew

Looking at the latest spec on the consortium website
(https://ethernettechnologyconsortium.org/wp-content/uploads/2021/10/Ethern=
et-Technology-Consortium_800G-Specification_r1.1.pdf)
it looks like they are adding 800G-KR8/CR8 and 400G-KR8/CR8. In the
case of these two we would have to come up with a different approach
as the implementation for them appears to be doing some sort of
bonding of a pair of 4 lane links.

The only other "consortium mode" is another implementation of
25G-KR/CR which I could have followed the same approach on. The IEEE
mode is close enough for now that there wasn't a point in splitting it
off as a type of its own. In fact I got this idea from copying how the
SFP bus code handles this
(https://elixir.bootlin.com/linux/v6.18-rc3/source/drivers/net/phy/sfp-bus.=
c#L251).
There is already logic that is setting the 25G link capability when it
detects the 100G cable. The general idea would be that we would end up
with the 50R2 eventually slipping in there as well since the same
cable can support all 3 types.

I suppose if we wanted to be more consistent between these setups we
could treat this more like the setup described for the 400/800 setup
and instead of having one PHY doing 1/2 of 100G we could treat it as a
bonded pair of PHYs doing 25G. As it stands I am going to have to
present 2 instances of the PCS/PMA anyway as the vendor config and
RSFEC ultimately has to be setup twice even though we are managing the
core PCS logic through only the first instance.

