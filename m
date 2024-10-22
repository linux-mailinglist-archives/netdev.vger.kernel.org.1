Return-Path: <netdev+bounces-137831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5C9A9FD8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD520B227C2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E2C199FC5;
	Tue, 22 Oct 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaDm7S3O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0E196DA2;
	Tue, 22 Oct 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592532; cv=none; b=s3IHVjss/hbEKKc93MdV7AJT7b8PTb4PDQsWPow/T27wCSBfbOFfs+UWtkyCVJzzdT0kwUKYs/cqMerllIIpld+H95anykKoup6d4oU4aHYTZaYPpbWh8Zl1vIlqSQdXc2gojk+fcW8ELxEquHpUTtnxvtlIncUK4jU7pX1kFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592532; c=relaxed/simple;
	bh=btbwea1DHA50mqi8e3PkNi/S6VNsqJNEwogTcf50oRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jim0sfBYN7XBKebmwJkczSOO8T8fVfBp3P49/ydH/qM/dZBNDD0RiztkkyVYCj2pC9JgkSwIsKXDj/W7Xalzz/TmPLdQCoFRLrGC8WmwAZNm1PKMUtuJ3G/Ojj+WjTdcHjr1qlqWR2c7ZFhNAPheeEHqHniHt1OUZ2Y23n7vuAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaDm7S3O; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so3990200a91.2;
        Tue, 22 Oct 2024 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729592530; x=1730197330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sI849jpnNtz3jUPY9JimvHmQMDeWZfkp6+41mM9VEbU=;
        b=WaDm7S3OkzNY8p6OcrmMm5P/U01rzJXXLSk18oq31Kl0zZRWH5NakayC3cWtGJg0dQ
         rV7pE+MaBhj9zzwvIGCxMTzVNtOuNjvlCpqXnh4bRK6Q/DqQ7E40eQdvmqEhy+z7wpaR
         +3Mrq7mk/BGGKTxvtSgb6APLmKqbYCdz1SJASE9FzqQkTQFKPHHS+/xEml1c64B0wqj+
         PyY+9fnI5lrBIm2/vNSHcJFRWJ5Gse8FYDAGXSXBBq44/v/aCwU4Sk5SPXlgJ7AJlKKg
         +e2BeeHD1a6+TsNhdScE6icuM1s2Dl+10JzleVHSeqoGA/5p+ut3pP3l4ya5wJ6cwLCp
         YCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729592530; x=1730197330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sI849jpnNtz3jUPY9JimvHmQMDeWZfkp6+41mM9VEbU=;
        b=Tm+YS1s071rBi++hNdq79YF9rqJYgsHpDuXnwsud2CuC2gFjh1d0rWPYldQiMoitfb
         1LMmVYDP2jsp0TcHZBJx8V9gYip5CiemMh7ana4BXwOcu3GXTHNNPnRvmI1Zxc2hbpdM
         IUYIB047RF7YBjmPu90iK+/z3hrpHebzndgjDPAT6n3waJesRKznPl0jZ8/A7X7mRWLR
         hip+TJvlmvM/XURscCKkRYyxBNIBbS1pzR8pYY6FemAjdth6a0pSQldiQbpDOQ3eo8aL
         sykS6Pz2UimNiZ0g9SnyYh/SZYI8C9CVMRX97L8UfOkRONlaEmQzz8InDPa96jd6zgWJ
         39VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuLhI2f2mWdCKJK4ujcp4L52QeTyie/m3J7toNdCWGf2rgCk2bEnKZmblZCzKXsmR0jWGMfoG9l8ji@vger.kernel.org, AJvYcCWFxJzfF8QiIheT/fLw/lFdLxO0Dx07Z+bkTZZEzmmgZkN7uwJNrXwmEt5msDqA/ehL5pxzUs2H@vger.kernel.org, AJvYcCWSKmC+9avl3RwuYmS1RJsjLmkpAqNOwfbZqNa8K4Ooi2MkNhFnWY+iGhfFnBpVknT7aOShYFK79RL3j6Iy@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkFOZmym4fyACLIYTiut1Fo+PfV+QCK4XQsf13n0heUz6hhCn
	dSP+B8Xd6cbVtRf70Ho85tNfJpCE7/zhcSNzfx21bRS3QAh/CB9V
X-Google-Smtp-Source: AGHT+IF0yrkWnZfHUykTJ4Fo4aQzxqBmdzqmVMi+fptihu1U4ST488NkYyut5AtEoorOS8tcNGE7TA==
X-Received: by 2002:a17:90a:740a:b0:2c8:65cf:e820 with SMTP id 98e67ed59e1d1-2e5616c4202mr17264934a91.2.1729592530050;
        Tue, 22 Oct 2024 03:22:10 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad517911sm5728653a91.57.2024.10.22.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:22:09 -0700 (PDT)
Date: Tue, 22 Oct 2024 18:21:49 +0800
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
Message-ID: <424erlm55tuorjvs2xgmanzpximvey22ufhzf3fli7trpimxih@st4yz53hpzzr>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-5-inochiama@gmail.com>
 <227daa87-1924-4b0b-80db-77507fc20f19@lunn.ch>
 <gwtiuotmwj2x3d5rhfrploj7o763yjye4jj7vniomv77s7crqx@5jwrpwrlwn4s>
 <65720a16-d165-4379-a01f-54340fb907df@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65720a16-d165-4379-a01f-54340fb907df@lunn.ch>

On Mon, Oct 21, 2024 at 03:27:18PM +0200, Andrew Lunn wrote:
> > It is related to the RGMII delay. On sg2044, when the phy 
> > sets rx-delay, the interal mac is not set the same delay, 
> > so this is needed to be set.
> 
> This is the wrong way to do it. Please look at how phy-mode should be
> used, the four different "rgmii" values. Nearly everybody gets this
> wrong, so there are plenty of emails from me in the netdev list about
> how it should be done.
> 

The phy-mode is alreay set to the "rgmii-id" and a rx delay is already
set (a default tx delay is set by the phy driver). In the scenario 
the extra bit is used to fix 2ns difference between the sampling clock
and data. It is more like an extra setting and the kernel can not handle
it by only setting the phy-mode.

This is draft dts patch for the sg2044 gmac.
https://github.com/project-inochi/linux/commit/381cb6000044a89cb13d6d9c839e9bbc7b9d2e5a

Regards,
Inochi

