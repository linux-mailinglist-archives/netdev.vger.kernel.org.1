Return-Path: <netdev+bounces-178070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1922A7456E
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063481B60FCB
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1128213233;
	Fri, 28 Mar 2025 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvY9eNGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF59213221;
	Fri, 28 Mar 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150597; cv=none; b=h8IvXg6BFIlIA4Qh8MTUpavkPa7ntiZMafiNnA+GGvUeHX9WmQoIhVoxX5RVO4aCXPMQLH4xZU5MwYW8goP9PsqaItVNYgE5h50bX/h71wrcRrfuQY/uWP6n0aC2MqGKCaTiSaLdZZarY5F61AQ7PrHPOf99m7uXyNlLLhXc7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150597; c=relaxed/simple;
	bh=nW7zIE83b7o3baRGZOQm5hGY7byhoIDbnlaKldlCgyU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPmAwCQdj4LQ9Har9cFHkWzeAVyCmc/zi/xiNc0TSjptI3ZZc+aJ2EBph+G7B+Ctme2KzOhL+1LXkGP7N/BrTp5Q46VREqtkI2y0inIPu6TprYJ0TRrcoTZ1nrvUA7JqxY1TrGhE5Pqk//z8o/hvrcNSnZGNnXZSNc2nBkCCl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvY9eNGo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so3612892a12.0;
        Fri, 28 Mar 2025 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743150593; x=1743755393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0ZCqhCnbZVt3aUx2CnCXD1Nb9xtjZIuFPWPj7IStfM=;
        b=LvY9eNGoqI470UFtKeWHD+KPXclbVM0IjPYEd7OuXGzwj3bEIKgzZn/dEvh26/wOCn
         3rPwtS6rUFzegz506xfIXdyCebMIt/ucKTwaCMWYtjApGSUD1d/oj6TkityvfIZjpxT3
         z5GgPRzRy/xtsI7gCCuiLVkl6ESmpRCKusYlov2rYGiogstRwFmNAKb9mB4MS524EqCO
         nQQoQUlTdSFtpgqppvApgf8vW2ns1mt9AM+9hO+qME4OM3r+OJGWH4ASufWEwoJSEkO7
         rN8xs29aGhy8JGCnkUXgYQxybAc6qR1aVk43fnD/2u35eKnM/QDlqXg4OibNDT4l7Jz5
         SXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743150593; x=1743755393;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0ZCqhCnbZVt3aUx2CnCXD1Nb9xtjZIuFPWPj7IStfM=;
        b=eBiFzpa5MiBOUi4q79NlyL4AdMFlGE8ynVf1iovAq2BfMpAMsmAjZUD0u8DEKPtNrN
         7qod/DGnSa9+f5MZfVzWMaIyIdxafwlRYrVso5ne4mqMTNsrp2qLbZCFGCMkPP3c91st
         d+p5sxPhCxCpfkhXwgJvx1iJWxhQTPOFwlrnWoZH1Jew29TkuP4ftuM78iPompscwEv2
         o811FmKy5IVNn5QMOuxjAxNzlJ92Fgzmv8wXUnSMuczxt463LtaihF2J5oCD2VfCM+Qn
         a55SKHSuHYHSbc7DhVj7EwU8Lvjk4KL30ncPhRYHFrXGcvcYbLSBljyNOq8id++3bUcP
         ZViA==
X-Forwarded-Encrypted: i=1; AJvYcCWa2/YWVOL2hdDw03wRtx/pGXPvnydEyZCX8Zz90tIoJlYlFgE+uhQtJirsgknjXdWQugxb3z6gBBG23F2s@vger.kernel.org, AJvYcCWxS2kLUTMgzOlWmxbEU6WW5qADKzziS+o1nu/ap+pJXivPoJqpHTdoWMiEj38Jrp1nH/WFPVhgbQAc@vger.kernel.org, AJvYcCXP+WoJmxS/Xe/S4FTB7f4RjOiD6LJs+DoBr9EYWbjXZTDEsEVFyVAOG9RQlShKRH70P5e3vixV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3i7sEl/EtsGjhXQkkCi6btYKPX+cHalP2UtHqtKf0XOsurrtp
	5ImRHYZTvpgOdWwUIM13r8gFlzMIQt9IkWc+P3wjLW1CtNW4g/kc
X-Gm-Gg: ASbGncsV+grX/jf6vdBptQyXLrHuF8Ditn7b765rbiyfnCuxCOptn00tA/gG2NF5fKN
	yXGQ9Z8rNceyMB0quq/Cce85oEc9Wa8m2spLmxn3icgNVnxqHU2LDDdGVpmZ7NNuIxbsQCC0PMC
	JW3mhpsHVh3Mn8AJy3PbgkqBIKPMavDGuAYPbAH9FUrfatcrlCu1UIKz9uAGqSnRW8b+kRDx8al
	phrZ/QMiJkn/gRIWw3z5B5TXpwFwXaO2Elvs8x6gbNhbuXAZvxJDaKBwRAYWtnsqh71C+f0IVY2
	V4X1uFmGkvrYYosdorR/UUiqCX6pAsHa/Ra9xUmSGIYms4mIlRpoXUcqmQh9hveCG1sb2Mc7XLH
	Q
X-Google-Smtp-Source: AGHT+IFU5A+tMQOAWn3YOK3TuwhlooPf9EWNcK6YYqJEI8gHr+LaC/RNLcb/nAuMocNkgltFg5R5WQ==
X-Received: by 2002:a17:907:3ea2:b0:ac6:e20f:fa48 with SMTP id a640c23a62f3a-ac6faf6a198mr640703066b.33.1743150593076;
        Fri, 28 Mar 2025 01:29:53 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac725c71e95sm48434266b.76.2025.03.28.01.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 01:29:52 -0700 (PDT)
Message-ID: <67e65e00.170a0220.1aedef.166f@mx.google.com>
X-Google-Original-Message-ID: <Z-Zd_AIsKTYJZXGk@Ansuel-XPS.>
Date: Fri, 28 Mar 2025 09:29:48 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v4 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
References: <20250327224529.814-1-ansuelsmth@gmail.com>
 <20250327224529.814-2-ansuelsmth@gmail.com>
 <Z-ZczBztZbnc8XPa@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-ZczBztZbnc8XPa@shell.armlinux.org.uk>

On Fri, Mar 28, 2025 at 08:24:44AM +0000, Russell King (Oracle) wrote:
> On Thu, Mar 27, 2025 at 11:45:12PM +0100, Christian Marangi wrote:
> > Pass PHY driver pointer to .match_phy_device OP in addition to phydev.
> > Having access to the PHY driver struct might be useful to check the
> > PHY ID of the driver is being matched for in case the PHY ID scanned in
> > the phydev is not consistent.
> > 
> > A scenario for this is a PHY that change PHY ID after a firmware is
> > loaded, in such case, the PHY ID stored in PHY device struct is not
> > valid anymore and PHY will manually scan the ID in the match_phy_device
> > function.
> > 
> > Having the PHY driver info is also useful for those PHY driver that
> > implement multiple simple .match_phy_device OP to match specific MMD PHY
> > ID. With this extra info if the parsing logic is the same, the matching
> > function can be generalized by using the phy_id in the PHY driver
> > instead of hardcoding.
> > 
> > Suggested-by: Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Too much copy'n'pasting?
>

Nono it's me creating new Tag type. Also planned to use Suggested-by:
Reviewed-by: Signed-off-by in one line. :D (joking... hope everything
else is ok so v5 will have everything with tag)

-- 
	Ansuel

