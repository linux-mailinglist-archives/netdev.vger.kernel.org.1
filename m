Return-Path: <netdev+bounces-253759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFE0MKR9eGkFqQEAu9opvQ
	(envelope-from <netdev+bounces-253759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:56:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DECEF91593
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A1E33002B6D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85A2DB790;
	Tue, 27 Jan 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7NdCjAL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF9332A3F3
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504160; cv=none; b=nlQGvA/Lc13pAgJcNNpaJ4geOR/UqPwTxb3yId6PpZF6+upDbiO9QGugnbeRsdA2gg5YPMHld9RxrsW54LiY31EHY+nOq5d5DYbWl3AJIpgKK6FFno3D2nslB1UpOPTqwcLX8HgjFmpOwP+BznbOoDBOBxcl6BK1ikokAEfewqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504160; c=relaxed/simple;
	bh=uMKblArHl5A9jcSFlaLTAYlOk8eq3QqLeD+7zdgmwRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V57MdJJ845rEg85hwhgK+AZhhReOg6Czt5hE0uUGWAM2awMG+gKglcEJk8xPx2hc1PkVVtGYO9Ihw0SJmmZFsa5oliTcJCWTbLOUY8DHyFFmDwnnLCXyN8SeG/URbHBJWbvj38ZXVgPh7hcsHYE/WY9HuWekfbq8czFtrMQ48Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a7NdCjAL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so40808575e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769504157; x=1770108957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6gcw78eDfCGKXCKZBLgnF/iPeG+D4+74BvG9CfzhIA=;
        b=a7NdCjALzVrFuDYprpgbei/cfz0vbzMpZmWos9idjaZZE/MCFcAtuJZLCko+b5LSzH
         09wbUKiRBGHojrvUDxIUsATiCy34rSU2dzKYP3pbO2Kgeotenkhyx3pjqYL3VMKe6BWx
         RzWgvPFj26K4ltrzc1GgUJcjqNHqkVaOz17V3JSfL41aiI5U/RujPJaZQUG2VNXAJ4o6
         4MeV+/bkPFI2Ap53CpMWLVnxlEgIrMqXN3IzOsXpucPwNGonLJXGHVQz0zgLd1RJDxAk
         FtqeOGNjSn3bhqwd0JrlhO2u/mjOcqQ8h0aLY4e2mvaylzGx7s7L4U524qj0ytRhexR9
         jdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504157; x=1770108957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6gcw78eDfCGKXCKZBLgnF/iPeG+D4+74BvG9CfzhIA=;
        b=ubBARbZ5ifIQ9MRv+SWPFlibahumBy2kA0Zl65CPXI/gKhEQix2KAdJrCY2lUmlPJJ
         Adg4RzC99/49boqLlrYaStEMFfbfejH3wKaJDHMYbzSPBvVUVoC/FEddsl60dbgN7Sks
         vQ3qb+mJUPgq/FqUiECtarNhxftVNrBaqOB4bTpH92e5mFX4bviN6u8iqBCThIV5xz+z
         SI0PZ5htSo5/yeDOdj1bdKGXKNppbJATOGE4WvekbG/CkPje2Gg7hckZRGGP7saEyjc7
         /DGIEMTvITMXTcx6KqUy5PnqZtuTjHws8g7UhwzmwraUKDLwkWUYRHBYZpD08K6MWdDp
         r1tw==
X-Forwarded-Encrypted: i=1; AJvYcCVxkI4pwYdpD5y72W6QV8dXF0unRlFLQ6tz2ACP0IgfAqqBGSifJQEOGVolawDAlZHudzKd6/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycn/U9driepNrins1evqITBwGJbeFYhTB3x7f2+bcY/xPge3PE
	UxzcRA8mQp45bFiValkBZBgYp2/D7swqYM0ySAhx/crLY6dh8Ph/vfdUl9duH5t/YP0=
X-Gm-Gg: AZuq6aLz0j4ExvvZl+8pB9CEnjRWd1+8cgJc2+XQBNxyKZ3D8dGqu2UKKuL7xBxRPXQ
	54nmyGOhz07FMbMVrFDOv9Ott3yXU9XIQNBZcsSOnTshIp6p3FM7sm2R3jnj3ow8bWiqXR30Q36
	IU9Ejuk03g3bgY7wn2dEUFvGbcFhefPWUbfPwjIi5TXNSHVz/eDTLjWEtBI6jvjBhWLHoyeKXrN
	W8aHFQ3kCw8ZAodUqt6ZRLlkaF3UVsLyhR0thECm61p3/MsysA+IiYw23o/gpZKoiExmsi+VCxs
	WVtMywoyJ8t8ckwI3PHnMeaQvoD69kdYoJC5LhLCdpSaNPWzNbSnA4iyicj+IHe/za3D2A310R5
	8QrGn1AT7R6Vi9Wtchil9TE2nQnMYGCSNJNEjHY+MkiJ2e4e8abpYRxRY2A/tAnsC/1gBMomwRA
	yLrwT7+pGQk8Dojdc=
X-Received: by 2002:a05:600c:33a6:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-48069e0fd24mr6300105e9.1.1769504156658;
        Tue, 27 Jan 2026 00:55:56 -0800 (PST)
Received: from localhost ([41.210.143.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c42895sm50695725e9.14.2026.01.27.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 00:55:56 -0800 (PST)
Date: Tue, 27 Jan 2026 11:55:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, robh@kernel.org,
	kuba@kernel.org, festevam@gmail.com,
	ghennadi.procopciuc@oss.nxp.com, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	shawnguo@kernel.org, mbrugger@suse.com, mcoquelin.stm32@gmail.com,
	linaro-s32@linaro.org, davem@davemloft.net, s.hauer@pengutronix.de,
	edumazet@google.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, conor+dt@kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, Frank.li@nxp.com,
	chester62515@gmail.com, netdev@vger.kernel.org,
	kernel@pengutronix.de, pabeni@redhat.com, jan.petrous@oss.nxp.com,
	linux-stm32@st-md-mailman.stormreply.com, s32@nxp.com
Subject: Re: [v4,1/3] net: stmmac: s32: use a syscon for
 S32_PHY_INTF_SEL_RGMII
Message-ID: <aXh9lcfw6D6KouI_@stanley.mountain>
References: <8f2139e8adf02b485a4c84d558fc23f78cf04add.1769195864.git.dan.carpenter@linaro.org>
 <20260126152430.1390514-1-horms@kernel.org>
 <aXeJYo-0iiNuXVGH@shell.armlinux.org.uk>
 <aXeP1y7cK0XRx3Wo@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeP1y7cK0XRx3Wo@horms.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253759-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,kernel.org,gmail.com,oss.nxp.com,foss.st.com,vger.kernel.org,lunn.ch,suse.com,linaro.org,davemloft.net,pengutronix.de,google.com,lists.infradead.org,lists.linux.dev,nxp.com,redhat.com,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DECEF91593
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 04:01:27PM +0000, Simon Horman wrote:
> But at any rate, I think the key question is should the case
> where regmap_write() returns an error be handled in
> s32_gmac_write_phy_intf_select() (by some means)?

Generally if register read/writes fail then there is nothing you
can do a the software level, you need to buy a new computer.  However,
in this case we may eventually put the registers behind an SCMI
interface so probably checking is a good idea.

Could I leave the error message out?  The callers has an error
message and if you ever see the error message, and even with SCMI,
the fix is probably still to buy a new computer.

regards,
dan carpenter

