Return-Path: <netdev+bounces-159368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90802A1540D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6001631CE
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1D19DF81;
	Fri, 17 Jan 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN2bfK4D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B719DF62;
	Fri, 17 Jan 2025 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130690; cv=none; b=iQImcAgVU/3P8sLU7uMqTzNHqN9KSrSkLZKl1zJGxR/5A0ZkaKeBiJL9K98RRCJEyaxuVGOculocA3qRnNN32sgfADpbZz2qlWAH9gH2jHyvU0h3CfunBpSFjIy644TQ3xmIjtPmGLjcRuT/MWjjqwKoTG50PA0+2PY8kwwRvJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130690; c=relaxed/simple;
	bh=EGU6+ilCylYYb4443P1Y1m3Nuf0m4CaRGF3lNrgVYJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppcaGJks7eYst2eUKzmLyjeOoMySD28DI7oDjF1sR0JNoQwn1hXI44H6dYCeOVa6+JJuJvH5r788oyT7QHMILY9m/nHyZTmPSLa8dl3EKVe6pJURq23GBMC1LPVj2Sl+LDU0VzqkEk9jQcx8iZGgsfiARI3LMpOMA3nBpr/T8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN2bfK4D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436381876e2so3048405e9.1;
        Fri, 17 Jan 2025 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130687; x=1737735487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dhGM5ZRTBFqwnR3Cs8LWHXJUPSUuzE/GinBi4lm49ag=;
        b=SN2bfK4D9pOoqQ4mEsIc1YcTlzzNaFhGPCvjBUGnjqCYx2EIoPRaOOPiks3MCZiauC
         L4pyaTPlo8lCReV7N9TS2bb2VFeGs+mVmC+GJKk/fkO8EpYMaa1i799OQb6NqQJ0dpr2
         Dv2bWhQrkeB+D3zJflJry9ysEDR2P2NtMxjRVFxwOB0/3QqkH/3HIBRuiRA1PZRx+Inu
         w1oNDY8PDOijATvx3i90eCqvX3sLnvsUo5bdUbyTRypdUhGA4nAUfRV6qklDVQmcghKF
         yrlLL9xk+wd5BBTsfJ4xhz1fs3ZbxFFOm+L+gwh+VIo1wcjzCbinZjAotPSgr/P6wIoi
         jN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130687; x=1737735487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhGM5ZRTBFqwnR3Cs8LWHXJUPSUuzE/GinBi4lm49ag=;
        b=F3pWqoLMhgk3skCcyP/YqGlfgsLAXZilJ+01wFo32UJ+qJK4xzcS+JNsCy0iv5aDID
         DvQObvTobI1cySWsT3X+DYr5ySZf3v+SE5krOgfPoBXhTYNyaYe1qZZiowjJnq7CKRn8
         WwjUKEqqmcR6onrH5Fbmr0GHXUzbAwCEx3h38JyDXEQhRoi3ZZ+oIVKjT3guWAbpGg3A
         jZS6p5OUTdX51pehO3K6dmwJSWJqdlbiOsLsn1wpUwZkAZNfrm3Y2VHOi1vm7aj7uTyg
         bCNxuu8jqAoDvxoGf8QSsY+gKkFCdtKZGhAeoYsVDPM/hgZ/OBn/jtOH2THMZHagYA6Y
         k/lw==
X-Forwarded-Encrypted: i=1; AJvYcCX7/XqVNqo6wMDvkmsJX2JU6h03u7c1Gj42J6vrRElCQUv4RdEyP+qwl1Vtrcj66xKljL8YE/lgLVEzemY=@vger.kernel.org, AJvYcCXNZehyY9cvK5DNEy4yWXBSkh6dmGCJeVdVNMCiWA7iivhs8qgYH/roINVuWvlz5sCM96CWj79H@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQei7aZlObpWpv4+C1CmQXNjbzLrGya/vltcmj/6XPbJmso9Q
	ue0Ebg6H9Q5aWhffcsqPP5ESm5jj/yovG9nThUqGjuWhZ9CMHuIV
X-Gm-Gg: ASbGncs2onx06hsPoz77RSu4+28xmesXu2/MnNNvCE8qAD9FzIvPb8P3cnGPcR3ymP/
	sYg2nEIQ+1amk4REek7k2UvXDk5Wh4re91+UFFW79QrY/6BJ108e78G7Zl8hn5r/V2/IegQHBGx
	CS9A7nNx+rhZ+pqyejYgIWKZ5qN502LTUKP4mGBovcmVtvsrWSUlEcrZ2tS9tA6aEpYcF0H5cBF
	ONy/T+W9fjJqBaGWV4SeWAZVGsAoMfrrebqDP2kTjUv
X-Google-Smtp-Source: AGHT+IHVWKgmOZ99OJUsWyTHPVHc05Z6MyN8QvHf6Udqd+IQR5d1gd0DTZXMd3IiaMGRJ07tty8RTg==
X-Received: by 2002:a05:600c:510b:b0:436:fb10:d595 with SMTP id 5b1f17b1804b1-438913bff64mr13724785e9.1.1737130686909;
        Fri, 17 Jan 2025 08:18:06 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890420412sm39194935e9.18.2025.01.17.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:18:06 -0800 (PST)
Date: Fri, 17 Jan 2025 18:18:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: maxime.chevallier@bootlin.com, Woojung.Huh@microchip.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20250117161804.p6qn653bagygwhib@skbuf>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf>
 <20250115111042.2bf22b61@fedora.home>
 <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf>
 <20250115111042.2bf22b61@fedora.home>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>

On Fri, Jan 17, 2025 at 12:56:14AM +0000, Tristram.Ha@microchip.com wrote:
> The KSZ9477 SGMII module does use DesignWare IP, but its implementation
> is probably too old as some registers do not match.  When using XPCS
> driver link detection works but the SGMII port does not pass traffic for
> some SFPs.  It is probably doable to update the XPCS driver to work in
> KSZ9477, but there is no way to submit that patch as that may affect
> other hardware implementation.
> 
> One thing that is strange is that driver enables interrupt for 1000BaseX
> mode but not SGMII mode, but in KSZ9477 SGMII mode can trigger link up
> and link down interrupt but 1000BaseX can only trigger link up interrupt.

Sometimes, the "collaborative" aspect of open source projects does work
out, and you might get help, feedback and/or regression testing for
hardware you don't have. Sure, it doesn't always work out, but I suggest
you give it a try and not put the cart before the horses.

