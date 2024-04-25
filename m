Return-Path: <netdev+bounces-91145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6E88B186C
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0FB1C21A86
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F95BA42;
	Thu, 25 Apr 2024 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9juG4cN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07014C98
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008284; cv=none; b=caIfD/V4Sd1bioe7Cx8u/dAyMs8bu0mOLb/T/jEaqedcCfJHr+Yj41hK9dSzvjxLWZnJur1BhgAhITXraRslRx6JYBE9h9G3FkzuahWY/wCtWCkW8fBO0zo9AwlZ4XQONwBBFVTjNg6u1GVp6AJ1iGEmWby+Uuhu1H4aWMWrGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008284; c=relaxed/simple;
	bh=IxiIgt1/um8rVDGSwbMqcUYU5pJ4H8Z2Cr6OCeWhhmA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CII1RyTwwqXGo/jSrKcJsU8cNrxtzHD/d8sKkgwcFDVxM2XArhKEbb1nfBmqmrq8vfCFL5C+YXt26rlV8CForjHwd4BAsfe+NO3uVzc/nNSh0uKsxJMidhaT7XSiL5t5IHjRUjUiYBlWPhf5fk3QBc8WAkJHpwQn7hftsZnEucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9juG4cN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ac074ba920so108380a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714008282; x=1714613082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAK124w54JwFio9YSi3lq49s5Oi+2APGd79xc9vOVEc=;
        b=i9juG4cNTo9uxDIjcWoHnxFMogW+rWAbVQ2YyYVsrsE5w1J3ANtHH3uThbsDt5tzEe
         yFpsARs5Fp/Gz419tY7RokICJf/zG6ULOdu96o9ATJfFxsW+667lbxry2uMTq0wAcNaX
         oCrzNij2JHrTSHytl3BAOKYtSUG8SWzvwMr8CdQWL+l9QY8XBpEp48WlwVzxhkA+hSf0
         +3aK0QF1JfdgOnS6H2KWeFgC7Y0cCYIhDzLldvpTvR9Wvwvy/v+5Z74QEUbciw+WwTVt
         e/DK9MUuHeDWbfEcOJI5pQeKqH5tryt/MoPEy1/NF6Lz+FJr4dtIHUeQrmb6ERwobS51
         D0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714008282; x=1714613082;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BAK124w54JwFio9YSi3lq49s5Oi+2APGd79xc9vOVEc=;
        b=lDgzRWMEH4pNCKF5KGC+W/uClJt/E6dF3fXuVFadZuUMWPp+TwcYTmfTsLai6fTelX
         oQCrq49HhbuHiJtMdT35hpOmlqPTpEoyKxYiY+yFs9eKUXXnVWiXf8RQJe8SxP2LHuXe
         9gZ3szLo1v6qkP6ul0i0sjJPxDLRZTo04MR4Os2udaUX1U/1s0YOHACZHXA9XHEnzL8A
         8kkItBkJgpiVppWvfiCcGxq4ybV9xuigWTbl/SiWuLazJY4wjKis6QzG84hRYz87L8Ri
         ba5UOPDjFJGgHj88V2Uzub5TlwlbqNINGKo6834gRoiXdEh8DXNeBJX4YaQKM50ZxT9b
         khUA==
X-Forwarded-Encrypted: i=1; AJvYcCVbsDWA890ZmBB4+gAH1CT0TZ+RWYEzsx0ZtPNTWZGffUXhE54wufIVQdJaIrfd1F2Iz4WCcCykT/Ydk9YoCDbrbeB+ZwV6
X-Gm-Message-State: AOJu0YxlYmjRcZndowrNUSsJ30Arg5IKoEFK8koffDmNhjV+cJbbGqpL
	o/Cv0weMigDokEqBmXMGOKueVdEmdESHSt1t4zot9OXQsN0Zuqdo1EyNKg==
X-Google-Smtp-Source: AGHT+IGRzk36CY1Pc5LoFftQr1jMfsSnqCMYzY/I48srPwZEbe+2BFTXX4uTmubl4Hx+JOrYJjeL0A==
X-Received: by 2002:a17:902:ba88:b0:1e0:99b2:8a91 with SMTP id k8-20020a170902ba8800b001e099b28a91mr4220347pls.4.1714008281725;
        Wed, 24 Apr 2024 18:24:41 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id kg8-20020a170903060800b001ea699b79cbsm2042647plb.213.2024.04.24.18.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:24:41 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:24:28 +0900 (JST)
Message-Id: <20240425.102428.2029676913045396941.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 5/5] net: tn40xx: add PHYLIB support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <daf9400f-c7e0-4f76-9a8d-977d9f82758a@lunn.ch>
References: <7c20aefa-d93b-41e2-9a23-97782926369d@lunn.ch>
	<20240416.211926.560322866915632259.fujita.tomonori@gmail.com>
	<daf9400f-c7e0-4f76-9a8d-977d9f82758a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 16 Apr 2024 14:57:58 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > Are there variants of this device using SFP? It might be you actually
>> > want to use phylink, not phylib. That is a bit messy for a PCI device,
>> > look at drivers/net/ethernet/wangxun.
>> 
>> phylink is necessary if PHY is hot-pluggable, right? if so, the driver
>> doesn't need it. The PHYs that adapters with TN40XX use are
> 
> There is more to it than that. phylib has problems when the bandwidth
> is > 1G and the MAC/PHY link becomes more problematic. Often the PHY
> will change this link depending on what the media side is doing. If
> you have a 1G SFP inserted, the QT2025 will change the MAC/PHY link to
> 1000BaseX. If it has a 10G SFP it will use XAUI. phylink knows how to
> decode the SFP EEPROM to determine what sort of module it is, and how
> the PHY should be configured.
> 
> To fully support this hardware you are going to need to use phylink.

I updated the code to use phylink and posted v2. At least seems that
it works with 10G SFP+ as before.

I suppose that more changes are necessary for full support. For
example, with 1G SFP inserted, the MAC driver has to configure the
hardware for 1G. I'll investigate once I get 1G SFP.

Note that the original driver supports only 10G SFP+.


>> >> diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
>> >> index 4198fd59e42e..71f22471f9a0 100644
>> >> --- a/drivers/net/ethernet/tehuti/Kconfig
>> >> +++ b/drivers/net/ethernet/tehuti/Kconfig
>> >> @@ -27,6 +27,7 @@ config TEHUTI_TN40
>> >>  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
>> >>  	depends on PCI
>> >>  	select FW_LOADER
>> >> +	select AMCC_QT2025_PHY
>> > 
>> > That is pretty unusual, especially when you say there are a few
>> > different choices.
>> 
>> I should not put any 'select *_PHY' here?
> 
> Correct. Most distributions just package everything.
> 
> We are going to get into an odd corner case that since Rust is still
> experimental, i doubt distributions are building Rust modules. So they
> will end up with a MAC driver but no PHY driver, at least not for the
> QT2025. The Marvell and Aquantia PHY should just work.
> 
> Anybody who does want to use the QT2025 will either need to
> build there own kernel, or black list the in kernel MAC driver and use
> the out of tree driver. But eventually, Rust will start to be
> packaged, and then it should work out O.K.

Sure, I dropped the above in v2.

