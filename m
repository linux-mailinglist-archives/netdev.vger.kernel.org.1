Return-Path: <netdev+bounces-75086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F3868201
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968FA1C22C6B
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB857F7EC;
	Mon, 26 Feb 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AaDhEtz0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDF12C55D
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980075; cv=none; b=MMeWXuBWVkgdBFqChdqU6E4fQbwhQzUUqa9uFCrU1na/jxTyoclSVSh5XjVdQcuhh1dJt4YDEUwKDZiJOuyWK4U14PIB14htaXDfpnqAm2z+MR950juAs5Lq0lwj/aUeKYXayDHn5vh9FpTsa9lNIJXGAQpzbmR317fkWc0PnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980075; c=relaxed/simple;
	bh=DKsE82iP6S3O+mEqARUG7EFsN2gCd5xm00NlsC+lWKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXpHEZekjkbPmh8YZ/S/GoXOUg4pgCA9YDISSxFKKTZJwsDUXWaicMsV4pR9XoKEx4JwOA22khZ5lvAqHc3/mJcpTjJRnDo3meQ4GvljAvj4b6kyHQE7dRod3nGkIDTvCP1M1l4UebqJf4iYEZHQa9deDry5oV9IuF+Y5adKsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AaDhEtz0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc5d0162bcso29931765ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 12:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708980073; x=1709584873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tci/5dZx2s1MSJB2WE+gJneNS4BO2j/CH3XpWnC/92A=;
        b=AaDhEtz0/QbKGkSduhKl75YlCCdA0xFj0ynBYT5s1+x+qR59b+SOIRzjSRfwsGl2rn
         b3sA6A5E4yKQbiqAaOBy1IOUBmCYgREwu6QfMPU/1gxtrPtNK3ByhtkoQs0RgvMFSPLx
         UTaHMTpsQjF0DbqLPrz4ZHytpKOsXy3ExNAQHA+k9qGu4WrvPMQEgu2b4RCVjQbvUre3
         ho4OvbRo5J0GUhTaHPdLb7kwFiBd8wk9nGeBvWe1FY/x9zzC1peN/0hvN3Jmb+Y9Jf0r
         Iqo9/I9ffeqHcAR4zRf0KT32vZGMtZi3JAXjuksYzLpszaZb2YJrdCzWvxPpiYW7anN5
         Rd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708980073; x=1709584873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tci/5dZx2s1MSJB2WE+gJneNS4BO2j/CH3XpWnC/92A=;
        b=E3lCDK+sOeG5gtU00qDCQ9KGKjQ0bPBk+iouRhOH3PEPVFdLN301qW3mN625luX7Bp
         j7yzuYUflsHU08//7mzFhbMc3gbDwhwkF/J3vqYbwlAfghS8xoh3Ux19zPHDh6NQ9k+z
         loyGGM8AswP5bROLPx7Q5t2Zz31JkgoQ5g1HFvFZl5ee6ae8IhSKz6fjWtmrPhfP1asd
         TAzQ4AVtNyM5RxKlijMAGf4OKYRzJH5p0lF+OnQBI2ib/F6cNJ73kAYCocIHQzh+Y9Gb
         aIz/YkbYWneS3goDkeBniSNQy7nxzdblzdDypwWRANBG/X5T5PEyf2qjjCuDWveLDXfc
         hbEw==
X-Forwarded-Encrypted: i=1; AJvYcCWkDzVGRZSF0tsIHoTYtu3XEOmGdEv32LxZyTWW4LXOIL9OtWpcyu8KiZqNgAXFWK5a/o30uGf0EIpycmABx6bMvCfxk5B9
X-Gm-Message-State: AOJu0Yybsa30QNxMKLvJ9BdlGce4CnureoFwQBQSjzrJ/RMCg0brkP88
	I+GSjh3uHqz6RWVEaqAUmihaq27BaY2yzRmi7aBd8Pb0qaN9P/4YUlkhglLL8Mg=
X-Google-Smtp-Source: AGHT+IFDDwa7J70HY93nmamOoPtFzarkgYwDr7jZySqTulC650/gUO8a+KakLuZxQYF/AxHij2YnEw==
X-Received: by 2002:a17:903:41cb:b0:1db:fad5:26b0 with SMTP id u11-20020a17090341cb00b001dbfad526b0mr8393880ple.55.1708980072681;
        Mon, 26 Feb 2024 12:41:12 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id s12-20020a170903320c00b001dc214f7353sm99751plh.249.2024.02.26.12.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 12:41:12 -0800 (PST)
Date: Mon, 26 Feb 2024 12:41:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ip link: hsr: Add support for passing information about
 INTERLINK device
Message-ID: <20240226124110.37892211@hermes.local>
In-Reply-To: <20240216132114.2606777-1-lukma@denx.de>
References: <20240216132114.2606777-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 14:21:14 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> The HSR capable device can operate in two modes of operations -
> Doubly Attached Node for HSR (DANH) and RedBOX.
> 
> The latter one allows connection of non-HSR aware device to HSR network.
> This node is called SAN (Singly Attached Network) and is connected via
> INTERLINK network device.
> 
> This patch adds support for passing information about the INTERLINK device,
> so the Linux driver can properly setup it.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Patch should target iproute2-next since headers come from upstream.
And kernel side needs to be accepted first.

When it is merged to net-next, Dave Ahern can pickup the headers
from there.

>  
> diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
> index da2d03d..1f048fd 100644
> --- a/ip/iplink_hsr.c
> +++ b/ip/iplink_hsr.c
> @@ -25,12 +25,15 @@ static void print_usage(FILE *f)
>  {
>  	fprintf(f,
>  		"Usage:\tip link add name NAME type hsr slave1 SLAVE1-IF slave2 SLAVE2-IF\n"
> -		"\t[ supervision ADDR-BYTE ] [version VERSION] [proto PROTOCOL]\n"
> +		"\t[ interlink INTERLINK-IF ] [ supervision ADDR-BYTE ] [ version VERSION ]\n"
> +		"\t[ proto PROTOCOL ]\n"
>  		"\n"
>  		"NAME\n"
>  		"	name of new hsr device (e.g. hsr0)\n"
>  		"SLAVE1-IF, SLAVE2-IF\n"
>  		"	the two slave devices bound to the HSR device\n"
> +		"INTERLINK-IF\n"
> +		"	the interlink device bound to the HSR network to connect SAN device\n"
>  		"ADDR-BYTE\n"
>  		"	0-255; the last byte of the multicast address used for HSR supervision\n"
>  		"	frames (default = 0)\n"
> @@ -86,6 +89,12 @@ static int hsr_parse_opt(struct link_util *lu, int argc, char **argv,
>  			if (ifindex == 0)
>  				invarg("No such interface", *argv);
>  			addattr_l(n, 1024, IFLA_HSR_SLAVE2, &ifindex, 4);
> +		} else if (matches(*argv, "interlink") == 0) {

No new uses of matches() allowed in iproute2.

> +			NEXT_ARG();
> +			ifindex = ll_name_to_index(*argv);
> +			if (ifindex == 0)
> +				invarg("No such interface", *argv);
> +			addattr_l(n, 1024, IFLA_HSR_INTERLINK, &ifindex, 4);
>  		} else if (matches(*argv, "help") == 0) {
>  			usage();
>  			return -1;
> @@ -113,6 +122,9 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  	if (tb[IFLA_HSR_SLAVE2] &&
>  	    RTA_PAYLOAD(tb[IFLA_HSR_SLAVE2]) < sizeof(__u32))
>  		return;
> +	if (tb[IFLA_HSR_INTERLINK] &&
> +	    RTA_PAYLOAD(tb[IFLA_HSR_INTERLINK]) < sizeof(__u32))
> +		return;
>  	if (tb[IFLA_HSR_SEQ_NR] &&
>  	    RTA_PAYLOAD(tb[IFLA_HSR_SEQ_NR]) < sizeof(__u16))
>  		return;
> @@ -136,6 +148,14 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  	else
>  		print_null(PRINT_ANY, "slave2", "slave2 %s ", "<none>");
>  
> +	if (tb[IFLA_HSR_INTERLINK])
> +		print_string(PRINT_ANY,
> +			     "interlink",
> +			     "interlink %s ",
> +			     ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK])));

Better to print that in color and pack args on line up to 100 characters.

	if (tb[IFLA_HSR_INTERLINK])
		print_color_string(PRINT_ANY, COLOR_IFNAME, "interlink", "interlink %s ",
				   ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK])));

> +	else
> +		print_null(PRINT_ANY, "interlink", "interlink %s ", "<none>");

The output from ip show commands should resemble inputs to configuration.
Therefore the else clause should not be there. Only print if interlink is configured.



