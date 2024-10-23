Return-Path: <netdev+bounces-138429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3889AD7A9
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E121F23115
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182EB1F470D;
	Wed, 23 Oct 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIdmQhiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA91146A79;
	Wed, 23 Oct 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722990; cv=none; b=TkY7121+nneRvxnDxtK5fq4AsiYbTBSKVzCNkihXP5Ll2Jf4qkGIH32g0wbRM+g4yAeg7PVn1i7Rh8VC3VKCRRQgXDd+7p+SMh6syCgEcxZ0T1OBmjOEQh+jZfoKiCbdkqyxw0gLkQI1FzfTA2BCDSt94yjSlve6VT9oxgapXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722990; c=relaxed/simple;
	bh=oGbzP/dZFrF4nG1MIoNOSQ/DgmaCcGSA4+AVZdVaWbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNcsRpaKS+LOx3dgURxTHf68kArWd6lkAXk6z+Lb7EJrmTdRcQqL9Oyk553wEXeM7/wfTI3ODsEoFOQT275Y2Si1b6KMXlva4bYGmsKzN3BWUDX0GCTRPP0OVE/Bm+c5kRVD7Ph2Dz5GoGczwQyOqhurMBHTPSYk7kXeDIdNtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIdmQhiF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e5a0177531so267333a91.2;
        Wed, 23 Oct 2024 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729722987; x=1730327787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDwSkxF7WJ4kfN02Vjn7/1ATHMtONFtEuwuiRviy10s=;
        b=EIdmQhiF1WHiK4McyMSYPly3ort6eMBegUy5aneInQgL4d/3kYLO0rtDIKJIE8fhDo
         E7VrMOgYJ+h/1KiogSir8lvkhKk2zmP0g3VTjtb6RjFOXkyGM2xLcxv1WQU5zWdHl9bi
         AnoQB6lQWCLEXa9/ne4ouPsHncoq6suSpGX8s1p9xoBr98JUNafAFMsKvM+qSihyNwkQ
         S5R5v9KQsAPo6u6Et3QqU8WXmwDQ+p7+xEqIV+WQMvFeigGBoGBrCquII1uGs9og38PI
         KJ80i52wNQNNvy7n6LcTujM3XyOLLHYncHKDeAJGenp8UzJlI+KuAvtf60ersT3gQYuS
         6Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729722987; x=1730327787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDwSkxF7WJ4kfN02Vjn7/1ATHMtONFtEuwuiRviy10s=;
        b=DpiHtuPYhUWE44Jr44uCMIIJ8t9QyQajZ0wyXZwORqYwy+r6Yni5q9vYHulrmjvswX
         1wLLk7Bum59WCUjZ9XMUAPEhaL6BjLCMPJgu9+XgThcW3P/PWVPYNnvCabPrr11Rlz1b
         tkxD3W47AslcDXu/VHp8SuunbPUFb3WdvTgtCJuzEx3XFdTUoVCs/W83cAphy8NeWLSp
         bKqAcf6Vsmh0i/2lCfCGgbCyeTpnD8W4kmi1kZYYufBvpKhTjLay4MyTBtYaHog4AXyE
         VWvxVTzVfLMA7upTfxiUD3h/PsUlH+2P86eDgpUZ0JN2zPvznpeJxUgDKXbL049g8u6F
         AyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE08bzCk3CfiuaJTKwwWzLCtqnr8wKHeUyggDLQn6A+IpapKO/m6qksoF+6Nz/tHCwXSml4D/bhDNu@vger.kernel.org, AJvYcCX0/9hq/ac1OeDDLpPbNCRwUIc91ZiyjfWCabR7JsBy6wsHLTi2fOqMUjn1fFamXZobkJQeNM5PcOkS7O//@vger.kernel.org, AJvYcCX8TRnoOEjJdSE0rI5Dv+1Nio6jXSeid4YZahQsTC88loYuA0OZzjt8j0A5Oqrcjb9WFQHOujZv@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOPzmcrVP6SU6KgNSDAb4RTmtXH2oGi3DTO5mKe8ybHvEo1HM
	gikm+Re+7la+0eg8vq8aqzNsoW2M1citJ0tJRRBtnldEqg8mY2nU
X-Google-Smtp-Source: AGHT+IHZHuIwRxG7OAHNulcO6fIJfRQUcZc5T2JQxQu8pU9oJ4gNvzh822T/LibfUXWlnPRbU4LzEg==
X-Received: by 2002:a17:90a:9f8c:b0:2db:89f0:99a3 with SMTP id 98e67ed59e1d1-2e76b6d7175mr4285461a91.26.1729722987343;
        Wed, 23 Oct 2024 15:36:27 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76ddc9e6dsm2033227a91.0.2024.10.23.15.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:36:26 -0700 (PDT)
Date: Thu, 24 Oct 2024 06:36:06 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <uzlmckuziavq5qeybvfm7htycprzogvkfdqj2pxrjmdkuovfut@5euc5nou7aly>
References: <20241021103617.653386-5-inochiama@gmail.com>
 <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
 <gwtiuotmwj2x3d5rhfrploj7o763yjye4jj7vniomv77s7crqx@5jwrpwrlwn4s>
 <65720a16-d165-4379-a01f-54340fb907df@lunn.ch>
 <424erlm55tuorjvs2xgmanzpximvey22ufhzf3fli7trpimxih@st4yz53hpzzr>
 <66f35d1b-fd26-429b-bbf9-d03ed0c1edaf@lunn.ch>
 <zum7n3656qonk4sdfu76owfs4jk2mkjrzayd57uuoqeb6iiris@635pw3mqymqd>
 <d691a687-c0e2-48a9-bf76-d0a086aa7870@lunn.ch>
 <amg64lxjjetkzo5bpi7icmsfgmt5e7jmu2z2h3duqy2jcloj7s@nma2hjk4so5b>
 <79f9b971-8b3f-4f31-ab42-42a31d505607@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f9b971-8b3f-4f31-ab42-42a31d505607@lunn.ch>

On Wed, Oct 23, 2024 at 02:42:16PM +0200, Andrew Lunn wrote:
> > Yes, this is what I have done at the beginning. At first I only
> > set up the phy setting and not set the config in the syscon. 
> > But I got a weird thing: the phy lookback test is timeout. 
> > Although the datasheet told it just adds a internal delay for 
> > the phy, I suspect sophgo does something more to set this delay.
> 
> You need to understand what is going on here. Just because it works
> does not mean it is correct.
> 

It seems like there is a missing info in the SG2044 doc: setting the
syscon internal delay bit is not enabling the internal mac delay, but
disable it. Now everything seems like normal: the mac adds no delay,
and the phy adds its delay. 

The sophgo have already confirmed this is a firmware issue that does 
not set up the mac delay correctly and will fix this in the firmware,
so the kernal can always have not mac delay. Since this will be fixed
in the firmware and this interface is not exposed to the kernel, I will
remove the code setting the syscon bit.

Thanks for your effort on this.

Regards,
Inochi

