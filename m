Return-Path: <netdev+bounces-211244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7DEB17582
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB121AA79E6
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA2523C4E6;
	Thu, 31 Jul 2025 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRzq1hbi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492327BAEC;
	Thu, 31 Jul 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753982208; cv=none; b=XKowZnVzQxOax+JsEjDsowFaZRVO2wjnmctkBjXqBZy++Ej/Ns1P7FKsCNPTEZeOvURTNQg1Iy16D544Z8yTs1Zdl5Gg7HCIx9T+6yXoX6UqmrNBg+jPexK+l2JSAHFIRu5V0sypKG1VInC/l0Pw4xHLojqK1CLgQyJ9+n/rCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753982208; c=relaxed/simple;
	bh=i05QV2naqKp/Ic+OIfkKDRuKNkkmQFkt9rjuiy2vuIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwB44IJ/6Ad9jx5gBjzM3Olobhnw4o/BFYQoRCHb1CbpkiSdUjjR0ZqGngTvGN9mIoKDJ+oNQ3jw44Wa23tLmZQvhui+xl6UARE8butWB+LvZbYRiP+LXNRM0RhaPH0DkSrIQAbETiMHeU2K1+2VdGC2PY09AGJBzYbUmcg4HiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRzq1hbi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4562421501fso900115e9.2;
        Thu, 31 Jul 2025 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753982205; x=1754587005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4D/5oUi0rHFvo7R6wGM8D36OwxVlVTV+Fqq7M/vD60=;
        b=XRzq1hbiVvmJyvHDKYUXHerr3hO5IG1o1ARkWQFC6hsygx2Eh2itjZEBDJ30CFekXI
         O9f772x0p3EvOAp7QFwj0GqvyR06TAA+V6ZZxLMR9bEDg3lVU4M0CPClU7RjmiVZL4sr
         hTuJJvJxTYlKbNuJOpd24wf7Pulhx0EP10n+9wjQHsxVa5/L36/FuyBRyfBM8QUbFvYf
         8nLXkzzF2KJiJuBoaziPC5sJNPBaj3rKWaPER6e3Ywlokb2AxTKQJHGN5tihDGhrx+ZB
         Dx2WczAkauW4S3RAEOzFQTs05wCkl5KLzMxvN8sgrY1l2ctShqj5CWGl0rQnlnsAUwwZ
         Q99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753982205; x=1754587005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4D/5oUi0rHFvo7R6wGM8D36OwxVlVTV+Fqq7M/vD60=;
        b=fJ1zUchE4JWjGqwXVI5hiG1NB31S2Y85FQHvm2596nqDz1akFn+seAmrUYGLyEmguB
         BN9l1/6KH8eaC1pNnrw7gO5upbJpduKGBrwGhhW19W2mEZmKko1pSv8OZbn32m0pdppM
         +FymfJbDNT3S0Gfmg47FjepB/AA0VKcICxnt3BJb8lJXHuuquU6Xp3X4i0XtpnRcEkTI
         H/IvOXjOmPsrPAVqgnPLZF75lJlMfeF9ak9/FOcSqTsqCzm2yP1aoEApilZdiVIu2+ZL
         yqeJtyzpOWm6vVnX6AMIxqDb06KrSgzL7eiOPk94PTrwy6pBxug8O2K6H/EeBaL+/G8t
         c8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCUgsKa1i5541ZaUDTV50Ep2kWt1BAWOnxwRlcNcnnXbq4FJ+fCimzGQjJOUUtrw/xO6w2NMoP@vger.kernel.org, AJvYcCWUQjdAlaWNfFphOpzBaRsT0lJ6m7ANV+dNfJjQ17Lm0NKaoNI/+7+ZBsC2N0IrpTlZVodjkfG7zELl/yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfIn8MjH9WGMcFq5IA1kZm8GG8RNEdyqmtxyYdzr2xHq1Fazc
	OKzGvqdl+5TYNdTtUZe28dUYd6/whojsERHjWDPw89hIqb6PVJohaXXTx8m7Xw==
X-Gm-Gg: ASbGncvZuKD3x+Yc3qs7cL++WzMfZ7TB0VwrIDkky4M+EMsYvV903EfkXKiIIsixUJC
	f9b8IZZ6KVf+R9TLzIGw7MM+CLTsR9Vlp0j/UV4wBONt4Z3exsKEZb1Lwoyp7q4GJx72xm8tBj7
	woP8AZR9mv95W/9SMfJyW3rlr4mPszUMAyOx1bS+0s9o7HxQF2hJuxeYmLJ7yyfZSrUaAaUA2RF
	F0+RO9NXOTHnzqlOl8236+y8PjMAo7ARzkEuxLEaXFXzQAPzgZkRDXDh+Pv6/a0YG8cVFH1Cfws
	gJRUY7QfLfecsA4Fed+m2Xr+51ral4Y6oHUtD6cPSzLbBYtoYfXC9bIZ7km6z03OulJnW+amNb8
	bpl6MtdhwcCvMF0L9mpR5hjcU
X-Google-Smtp-Source: AGHT+IGIhr5jXCpKAkOQYJyGNYmApdRKTfdh5g4GBLU3CPVzVN223o14oMVvDO1lPTB9VPzUG9bgHA==
X-Received: by 2002:a05:600c:4588:b0:456:2137:5662 with SMTP id 5b1f17b1804b1-45899045e20mr27955365e9.7.1753982205199;
        Thu, 31 Jul 2025 10:16:45 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:97a:e6c7:bad3:aa51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f0d2sm33144625e9.18.2025.07.31.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:16:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 20:16:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250731171642.2jxmhvrlb554mejz@skbuf>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>

Hi Alexander,

On Thu, Jul 31, 2025 at 04:59:09PM +0200, Alexander Wilhelm wrote:
> Hello devs,
> 
> I'm fairly new to Ethernet PHY drivers and would appreciate your help. I'm
> working with the Aquantia AQR115 PHY. The existing driver already supports the
> AQR115C, so I reused that code for the AQR115, assuming minimal differences. My
> goal is to enable 2.5G link speed. The PHY supports OCSGMII mode, which seems to
> be non-standard.
> 
> * Is it possible to use this mode with the current driver?
> * If yes, what would be the correct DTS entry?
> * If not, I’d be willing to implement support. Could you suggest a good starting point?
> 
> Any hints or guidance would be greatly appreciated.
> 
> 
> Best regards
> Alexander Wilhelm
> 

In addition to what Andrew and Russell said:

The Aquantia PHY driver is a bit unlike other PHY drivers, in that it
prefers not to change the hardware configuration, and work with the
provisioning of the firmware.

Do you know that the PHY firmware was built for OCSGMII, or do you just
intend to use OCSGMII knowing that the hardware capability is there?
Because the driver reads the VEND1_GLOBAL_CFG registers in
aqr107_fill_interface_modes(). These registers tell Linux what host
interface mode to use for each negotiated link speed on the media side.

If you haven't already,

[ and I guess you haven't, because you can find there this translation
  which clearly shows that OCSGMII corresponds to what Linux treats as
  2500base-x:

		case VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII:
			interface = PHY_INTERFACE_MODE_2500BASEX;
			break;

]

then you can instrument this function and see what host interface mode
it detects as configured for VEND1_GLOBAL_CFG_2_5G.

