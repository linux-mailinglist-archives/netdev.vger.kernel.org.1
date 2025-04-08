Return-Path: <netdev+bounces-180401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C308CA81360
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6074A1BA7BC8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D48236427;
	Tue,  8 Apr 2025 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTb5C/t3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0942356CC;
	Tue,  8 Apr 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132673; cv=none; b=BfoCwag53JnymxAuXSzAUe14DGxiweAK2eCx8nES6X8UjOSeJ5FsbjveOAURyTldJWzGF/7yPafQWiAxLBSJCadDbqXsz7EwyfOMOCCsjb1shoh6cageWAYmkuF+Z1g16JPXQfXRkBVPHTk6Rle4cFdneaLoYjmUU8YBVmG+wYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132673; c=relaxed/simple;
	bh=3U0IErLIyOWqVxRKzPpI+ZFFfJDxPaxOtZn64adEp/4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/rOY4Uw7X9LMIxqmwlr0ioE3fUMakj9M7CZh1c9Fy6naxj34NQtsSmFlP0VaqW1rJTxmjamSDYqA7jyLnkIVxUDeYBBlocYqmIqsijQ6xGW4UhqNoMmE3VMFgJMhQGHUTiRrsV3uLZXlxNozTP0kLtiWT3O51e1JcgMp/uxznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTb5C/t3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so38961145e9.1;
        Tue, 08 Apr 2025 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744132670; x=1744737470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y9FEiJ6GtO3x4AiYlszABTIXDcZSRIh+gOJoUIjbzrc=;
        b=LTb5C/t3NBpwjGvmRib2NEw8a2h+7rDSPPJajTj88IUf2mnmkHcr4wP3iv2YVBdE2m
         ILqm7ygxMECWe9Wuch9egLdvrf0TBBSVYrH5UXput43PsE+9CzpjmeLuT4ELAO4MYeOB
         d+UyBbxms00EGVi/mAi2ZPUkxaUBd7CYX3fAQLoVig/vd9K8jjvxXUycaeQ71TA/wAMs
         KWisq28b9PwPmEUDpbeMnVTgIpkjKwmbJJqkNHv20IjthTDfx9AVhUbMEl/G5k4V/VhG
         jHzsSOTCBEPGcTwh9vJHw2nM+W2crMKUt/nY0La3UNLYBjgULjcUHFrY+/+6Zco/WOp7
         VUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744132670; x=1744737470;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9FEiJ6GtO3x4AiYlszABTIXDcZSRIh+gOJoUIjbzrc=;
        b=jNR4XaLPlqqI5apeT7RkfhwaeUIQHbMr0DXQB3XBkSLth3bQZKhVpqE7HJAv07xagM
         zx+9Tr7Dd2i3SorPgF4Scc2CJ23qW5ENhSL8kwZWXDKJiclGqsi6PeqF/bhlIniknPmk
         voTX/mUN3ck8t7q1eOAc6CzW3yWY7dZY3k3gGLDBCaDAKzcLGvYn9zMLOL8tW5uEYajs
         Y6nZBrG/hPxsnVtnDiORf/5xyG7i5jdqsbCDRk19SKmQIygniFlrxpZr0E9LjT7ubMYQ
         rzY0eLMhhquPDDEGFNRDoAn0u4y2p5ra9nLgLmd2Fn6az9XR66QEG6pfSVImejQK4r2f
         Sa6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb+ZeHGE+A/h/iyLi4LmW5QoOLXjp5gzOEChN9Zlih/tToLNpcqUJGqmB/Qjw7bblX+ezldhr9AwSdNEo=@vger.kernel.org, AJvYcCV8pGfHAjZHZqi/2+sslbz+Qex5hqJdMHY9lhNzJW7rAFvCh7UdEUfxfMC6lingWd4MeZHT08/f@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9bK5gG9zDdsULW5EOiFcXbtzw4BJTm73q8mSjcJZfYA3XCdp
	lZtIrHDSy0dr+V4yyAel5ovZZ/mTbqT8Qon8uDrK82jtWzENImKe
X-Gm-Gg: ASbGncsnQon77GYGuxbzOoHTnCGqGkUxy+q/K2VTrbAXUu3uuR+He+DJ1DkmcW0jXDv
	jtLIp3XVDl2wGW+CfjMo+L3EsKLZRwsxSgJ4ORZzWWqJqDXPsqtJCupkgYvD9pk2k9y4ZlHuTbo
	vH3serexCTWz3hYy1GXppm7qWPlZkavF2XgsG0Qb1xuAgAOd6mGAjsdXfFJCJltkUE1jwyRaD7n
	D1MGZJ6Li/BazZyfaX30qKaajBAjrNPUbuf7s9mDyhPva0+f0zyqB+7w/lvJwi/g/Ci8NZwSH59
	N0HY77ODfDxy7sFqhSXsf++JEshD4lQbnLpY2P7VQ2XFug==
X-Google-Smtp-Source: AGHT+IGMxsDZ68vfGvY6rmtQL+9u8l96JpsI36c7dOT+rCUWPpt8G0b9GVy/azT74f17G5UjIxKHow==
X-Received: by 2002:a05:600c:34c2:b0:43c:fdbe:43be with SMTP id 5b1f17b1804b1-43ed0da05c8mr146186625e9.27.1744132669487;
        Tue, 08 Apr 2025 10:17:49 -0700 (PDT)
Received: from Ansuel-XPS. ([109.52.104.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c2fe9875dsm15443812f8f.0.2025.04.08.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:17:49 -0700 (PDT)
Message-ID: <67f55a3d.050a0220.f3f61.8550@mx.google.com>
X-Google-Original-Message-ID: <Z_VaN2iATWh7sipi@Ansuel-XPS.>
Date: Tue, 8 Apr 2025 19:17:43 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.or
Subject: Re: [net-next PATCH 2/2] net: phy: mediatek: add Airoha PHY ID to
 SoC driver
References: <20250408155321.613868-1-ansuelsmth@gmail.com>
 <20250408155321.613868-2-ansuelsmth@gmail.com>
 <Z_VYz6InC1p4vwku@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_VYz6InC1p4vwku@shell.armlinux.org.uk>

On Tue, Apr 08, 2025 at 06:11:43PM +0100, Russell King (Oracle) wrote:
> On Tue, Apr 08, 2025 at 05:53:14PM +0200, Christian Marangi wrote:
> >  config MEDIATEK_GE_SOC_PHY
> >  	tristate "MediaTek SoC Ethernet PHYs"
> > -	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> > -	depends on NVMEM_MTK_EFUSE || COMPILE_TEST
> > +	depends on (ARM64 && (ARCH_MEDIATEK || ARCH_AIROHA)) || COMPILE_TEST
> > +	depends on (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || ARCH_AIROHA || COMPILE_TEST
> 
> So...
> COMPILE_TEST	ARM64	ARCH_AIROHA	ARCH_MEDIATEK	NVMEM_MTK_EFUSE	result
> N		N	x		x		x		N
> N		Y	N		N		x		N
> N		Y	N		Y		N		N
> N		Y	N		Y		Y		Y
> N		Y	Y		x		x		Y
> Y		x	x		x		x		Y
> 
> Hence this simplifies to:
> 
> 	depends on ARM64 || COMPILE_TEST
> 	depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
> 		   COMPILE_TEST
>

Right, I will update in v2.

Hope Andrew is OK with keeping the review tag.

-- 
	Ansuel

