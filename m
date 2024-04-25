Return-Path: <netdev+bounces-91281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B748B2051
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D264F283CE2
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8144484DEE;
	Thu, 25 Apr 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Vcw3yePY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37784FAA
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044778; cv=none; b=V2ieMnaNJ3vgfQTyr28TMFXYHM7p2Hv0nyGr348AJd7FtT0q1Lp/YixSEokIb6XtW813rVZwdjBsPGeueYEZca1CyiiEATk5BsuZkJvMAs76XCibzrS7EZCo7iJjY7d3MVCs5s3jhftk2ojYOKAi9RYWnxJsUDGFTmn+EmxjF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044778; c=relaxed/simple;
	bh=tkgtyJwdbFCFBrHIEEld1vmmCFP2S/tt4aLdBTHLtGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb9Vy05XaHUZfbEGAgGFKu74+b6DXWj4JVOAkNdBA6UC4Td2HnlzvoWTAMYRvbN4/ofrbXbSfjoCrGJtmCNGBwq42ef7vtP2ipHD52urQYX17rA3/UuPekCOy1rMsEuqc1eCgDYvhTPxYMO5vQxgjrJ5nNIJJ++qLBnTehbWSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Vcw3yePY; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso120151366b.2
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714044774; x=1714649574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rJ2/29KrTeCdE3Im5UIccJSaxwFfI4xxPRQMpsKqfo=;
        b=Vcw3yePYvtYIv49aAVJcovQ5M68EBnFJYzGrozMPaYNFUk/nLzO4jzCOGerqIJINee
         gzYNi01M1cebLH47dN/O2ydcq4Exo0UY50u92X0BRCdhfARvo3tCSODH3V4LAcqoKxZD
         rqH7dEtcsxBKU8SsaZnapWk5uxkXllgipzONusTTT7Dg8f6Fiy7QGnULE0DJNGiUwap4
         cGRdKNXwOmKehSz6FslkfkdY+6IYUwbHSk3s9yhpfB3ZX06MH81MzXnjMiv6WPm/z+Kx
         QCXSkvcD8RWC9V+bnmWtM1Z0t+UDV+JHwMtlmhDAczL1Ievyv1MTdJTgJAhbLnMjYGsY
         q1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714044774; x=1714649574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rJ2/29KrTeCdE3Im5UIccJSaxwFfI4xxPRQMpsKqfo=;
        b=L0bx1zLM4CKTwCgWRu7GLsg8KYnCEbevAnmtRQ5aSNfRnwRrblpGNdn1sBtUKXTCoO
         CEFO79WIZxoB/CVyv/yyARq+G/ShwPCXTUAeJf2LjEjuX/grPfD4F90AgLanp4isjqDh
         U0ek/b2uAq0KF/Ket7fz+F3guCJlRUaio9Ucbvv217QW523zVL9Om3/+tFOUmAYHkd/3
         S81+SEhR9jamtgbFfIVOIX7f9Fj0iyXHaraY0g6XswrlD/cwmGNIfZA4qcKD+KvwwVH+
         wirDS8zTVRqyThYyOLV/+aqVgYXpPe71gIrO47XDkmaO2ryH/1meSoWvPHhv0YMipHpq
         j99g==
X-Gm-Message-State: AOJu0YwDd/30fM5Q8XlDlKirsenOu2EeDJWE+vu6w4rvKVr/3SI917rP
	dYfGum6uitaof0W/8Qq6zW+emE4fJh7ilVAIZ/9sAtPNttuhZtEj2U+vsxrrs2w=
X-Google-Smtp-Source: AGHT+IFYiZkHdP22CAroaU6IfT0woR6w3E7/ZJNHons1jxQjsKqRVxA0aUE9uCVbYxKtkD8vRPJVXA==
X-Received: by 2002:a17:906:dd2:b0:a55:5ba6:ace9 with SMTP id p18-20020a1709060dd200b00a555ba6ace9mr3884465eji.9.1714044773668;
        Thu, 25 Apr 2024 04:32:53 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906319000b00a5544063372sm9444067ejy.162.2024.04.25.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 04:32:52 -0700 (PDT)
Date: Thu, 25 Apr 2024 13:32:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next v2 0/6] add ethernet driver for Tehuti Networks
 TN40xx chips
Message-ID: <Zio_YgfX9SO9DHc4@nanopsycho>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425010354.32605-1-fujita.tomonori@gmail.com>

Thu, Apr 25, 2024 at 03:03:48AM CEST, fujita.tomonori@gmail.com wrote:
>This patchset adds a new 10G ethernet driver for Tehuti Networks
>TN40xx chips. Note in mainline, there is a driver for Tehuti Networks
>(drivers/net/ethernet/tehuti/tehuti.[hc]), which supports TN30xx
>chips.
>
>Multiple vendors (DLink, Asus, Edimax, QNAP, etc) developed adapters
>based on TN40xx chips. Tehuti Networks went out of business but the
>drivers are still distributed under GPL2 with some of the hardware
>(and also available on some sites). With some changes, I try to
>upstream this driver with a new PHY driver in Rust.
>
>The major change is replacing a PHY abstraction layer with
>PHYLIB. TN40xx chips are used with various PHY hardware (AMCC QT2025,
>TI TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
>MV88E2010). So the original driver has the own PHY abstraction layer
>to handle them.
>
>I've also been working on a new PHY driver for QT2025 in Rust [1]. For
>now, I enable only adapters using QT2025 PHY in the PCI ID table of
>this driver. I've tested this driver and the QT2025 PHY driver with
>Edimax EN-9320 10G adapter. In mainline, there are PHY drivers for
>AQR105 and Marvell PHYs, which could work for some TN40xx adapters
>with this driver.
>
>The other changes are replacing the embedded firmware in a header file
>with the firmware APIs, handling dma mapping errors, removing many
>ifdef, fixing lots of style issues, etc.
>
>To make reviewing easier, this patchset has only basic functions. Once
>merged, I'll submit features like ethtool support.
>
>v2:
>- split mdio patch into mdio and phy support
>- add phylink support
>- clean up mdio read/write
>- use the standard bit operation macros
>- use upper_32/lower_32_bits macro
>- use tn40_ prefix instead of bdx_
>- fix Sparse errors
>- fix compiler warnings
>- fix style issues
>v1: https://lore.kernel.org/netdev/20240415104352.4685-1-fujita.tomonori@gmail.com/
>
>[1] https://lore.kernel.org/netdev/20240415104701.4772-1-fujita.tomonori@gmail.com/
>
>FUJITA Tomonori (6):
>  net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
>  net: tn40xx: add register defines
>  net: tn40xx: add basic Tx handling
>  net: tn40xx: add basic Rx handling
>  net: tn40xx: add mdio bus support
>  net: tn40xx: add PHYLIB support

In all patches, could you please maintain prefixes tn40_/TN40_ for all
function, struct and define names?

