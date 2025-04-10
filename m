Return-Path: <netdev+bounces-181173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A8A83FD4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B304C8A6410
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4711C26B979;
	Thu, 10 Apr 2025 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2NrZqq1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D21EBA03;
	Thu, 10 Apr 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279054; cv=none; b=Qa6r8+3BiYNXrRc7RYUuGkfjVsdDYnMy7RRbgnz7W47u0PnE0yT0C61zpIN66F4VPQeb6PFioBA4+7wL481FXN6/wtxAb848+nYrLScX5ZKY1pHHvPJc7DCcdQLufQRIL/I6ZsRycxT7stw5fF9vKi2vZCoEkvcH2otqTYpUKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279054; c=relaxed/simple;
	bh=/kk9NyReDtb2BuDnaMTjVK5Lo5QK/7Pw0BDVBZ7GiL8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMq7clk4NMkTeleqdP3GMFBGlhdBZcf8MHiAmJ4jhwH6kMfvUZU4kEpqk1CJXi2BKGshO0PTnf5aIxCfXHVmmSPWWLc5IJiDzlLbbrNIapvxbj5hHH9ZgmdVzCXv5R/+JTu0dl6EFJMnGXTeurkOuVuC1yJoQJiytSqFvxTZ4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2NrZqq1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39bf44be22fso302914f8f.0;
        Thu, 10 Apr 2025 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744279051; x=1744883851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=24u0lbx/jlqGBOrM49fJ50Qb6J6xU4FU1OzZPWOiqeo=;
        b=X2NrZqq1GpiOI1/JZMzMKMlofnjIw6zjDyUeZ4xhH4LXNCQmQ55IPexZEPEtld14GU
         zyv/15Wvr9Z1wKffrw7fjcRXj7GAyCu2qrPOC+HJebyJwWSrC3/1XQxbeZo1r0oJRruC
         gNnpqQ544z6vggRc0pCJ/ABuC//6X7LLbmz9et5Nft8DEB8Dkq5IUUF1E8LcmpewgG/d
         FsGRmO0h0DEFuPcmpnvtV+uYJZD+ueL45hPIy1m1eYN21fZNnzb8MDjVKfQZCHg2SP6g
         4HBHjdMPoJx3CRB0ttTEVw7Z3FG86ofOArwFU6GyAcc8Zkaq89gloWzQknjfInZhTdY+
         bq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744279051; x=1744883851;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24u0lbx/jlqGBOrM49fJ50Qb6J6xU4FU1OzZPWOiqeo=;
        b=oVO6b1wQ8a4bTbqbVqpu8Ep7KYLkz8FqMmaPeBOfxW9tSVZcyXi8fjvSpqCXwj+KDa
         6H5FDD1F9MTVZYCCS2VzJIEwbxEJp3T514etaep6TpTUNolHfwgUGa+KNSE/EI8DoQt1
         Enbl+JtsVFv7xlAFbUBmEr6gUBtav2zwBbqzOjmNPcERDoFAfKoOEsIxAxxoN4/yUbvm
         qZdbdxl2KSb6y+D+jH4r1mv4arIpaxE+Em93w9uuLTO82aZUN01MylJozjGtEGGHZS/+
         THPYWTsNurkhhk7WPeRcqKQno+MVQ+UkgH70LrODAN24NK+9fJP/N0JPugqPkAib0dDJ
         52vA==
X-Forwarded-Encrypted: i=1; AJvYcCWIAqHIdAYrL1Gk7VOH3wdNUP0HY3HAM3q6MV0NlRiyt0O/69sfbDfIkumF5CeMy/8iecS+3Ixv+F5f@vger.kernel.org, AJvYcCXUJfEUcq0KXyA0EPmsW/ZLNbs0d6lRxODBmw+vqMS9gI4pPQQay3wnkK2VB9r982LJmJ1JjHHHytGY64Oh@vger.kernel.org, AJvYcCXsLDsLmllej03IXYViWHwFG2kDJAi4/bY8JiltAMW0+J+/JCBbKtqlnZFbs3PJJer0UAlteXpZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80DLqNjKSewP1+3xQ4yrVzmmNgp6Dj5N7b7n+4G6YYd8oR2kr
	7yLJkUuKZR/rw30FZPpjuZbT0yu/z5bQjMPCXXMmun9lR7N87e5e
X-Gm-Gg: ASbGnctC1MqxOTJfNWM1d7QUCyz8uz7xRn02SsAj9vHGJdZJeSvnpUCvCgWPsxPESRl
	OVW2uD6n3mU+7RXoluYAJ6FnrWn0thnC1EnI1FS2+mj83KFcpCGEWWCzKZzBuKE21bcyj9alLlw
	56i6h9PNh1VXbLsL1IUYfFjtUzrj2ZpT2zU74QDjniDE+Apii7H9mOFCc2t0bzEbBw2BDqcd/tO
	p8z8LxW8wb58EYYDMsVDvXTTZ6+b0Eq4f5FRa5aq+OdRERgkZ9otGhzXSTmUECxrTCZyxh0GdIr
	Jnejr0kWKhrrPJSllkYR5bQAaYFMQlC8Ql+Z/mHTTeAbRsntj6Sxq8m3oaAvdjBdV7Z9u89A
X-Google-Smtp-Source: AGHT+IE58M1HHQWKqzCQdGjeJyL9Osn17eJM3EClSGj5N32ts1ksXfvd5nmCgCyyrGh3HFfShAJ/VA==
X-Received: by 2002:a05:6000:2910:b0:391:3988:1c7c with SMTP id ffacd0b85a97d-39d8f4698d8mr1412178f8f.24.1744279050549;
        Thu, 10 Apr 2025 02:57:30 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207cb692sm52555795e9.40.2025.04.10.02.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:57:30 -0700 (PDT)
Message-ID: <67f7960a.050a0220.3a2285.9d15@mx.google.com>
X-Google-Original-Message-ID: <Z_eWBDea_YeXlLNr@Ansuel-XPS.>
Date: Thu, 10 Apr 2025 11:57:24 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
References: <20250407200933.27811-1-ansuelsmth@gmail.com>
 <20250407200933.27811-6-ansuelsmth@gmail.com>
 <29bbd0c3-a64d-4aef-a0b2-5ec4999ff7e1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29bbd0c3-a64d-4aef-a0b2-5ec4999ff7e1@lunn.ch>

On Wed, Apr 09, 2025 at 06:29:59PM +0200, Andrew Lunn wrote:
> > +static int aeon_ipc_get_fw_version(struct phy_device *phydev)
> > +{
> > +	u16 ret_data[8], data[1];
> > +	u16 ret_sts;
> > +	int ret;
> > +
> > +	data[0] = IPC_INFO_VERSION;
> > +	ret = aeon_ipc_send_msg(phydev, IPC_CMD_INFO, data,
> > +				sizeof(data), &ret_sts);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_ipc_rcv_msg(phydev, ret_sts, ret_data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	phydev_info(phydev, "Firmware Version: %s\n", (char *)ret_data);
> 
> Maybe don't trust the firmware to return a \0 terminated string?
> 
> > +static int as21xxx_match_phy_device(struct phy_device *phydev,
> > +				    const struct phy_driver *phydrv)
> > +{
> > +	/* Sync parity... */
> > +	ret = aeon_ipc_sync_parity(phydev, priv);
> > +	if (ret)
> > +		goto out;
> > +
> > +	/* ...and send a third NOOP cmd to wait for firmware finish loading */
> > +	ret = aeon_ipc_noop(phydev, priv, &ret_sts);
> > +	if (ret)
> > +		goto out;
> > +
> > +out:
> > +	mutex_destroy(&priv->ipc_lock);
> > +	kfree(priv);
> > +
> > +	/* Return not maching anyway as PHY ID will change after
> > +	 * firmware is loaded. This relies on the driver probe
> > +	 * order where the first PHY driver probed is the
> > +	 * generic one.
> > +	 */
> > +	return ret;
> > +}
> 
> This is not obvious. ret is either an error code, and we want to
> return it. Or it is 0 because aeon_ipc_noop() returned 0 on success.
> But the code then turns that 0 success into a false, does not match.
> I think this last bit needs commenting on.
> 
> With those two fixed, you can add my Reviewed-by:
>

Hi Andrew,

I just sent v7 but I didn't add the review tag just to make sure you are
ok with the additional comments and handling of NULL terminated string.

-- 
	Ansuel

