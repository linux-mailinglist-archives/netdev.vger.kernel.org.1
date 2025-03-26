Return-Path: <netdev+bounces-177758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0BA71A07
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35F5188F828
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFE81F1905;
	Wed, 26 Mar 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsmzYU6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001F1E1E0D;
	Wed, 26 Mar 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001773; cv=none; b=BVZ8ZZ3LmVDZdY9W4ylgnjRTU4ZLy0lhqezJnF3/G422uphCYr6jeaZdIQSeMv8XMsV7H4qZLfKZgO65lEcO5T7umlojHOvzIlqitEZiBzCfSusrtxQvVIsP1Ay8/7psRXQA7aXzy852pFsvcvGkACU8STZznwBaHp3iALb62Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001773; c=relaxed/simple;
	bh=fzD10Xrzl75x3+V0T0ImuW3xAFsLTLCnDLt1yzfwsS4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4ReExyEK8nol0VhvXnAlkhzyEPG77kxWE4wI4uEt1m+yaUvwMxjnAOQxXVxwoFTLVaOFAezsFVaO4jKVJWHjdvH2ESTAgqZ18kEi043kmoqC3nG6xQPN3UdiQtLLBa1dwLwV5mTx9sMCpCCQerDqZMVNtpgw11vPVVzHrSRrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsmzYU6S; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso62157355e9.1;
        Wed, 26 Mar 2025 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743001769; x=1743606569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ce5BiQM2/fANf7gq6gy5sOXGo7Ftl1D3smnzrrXQk4=;
        b=AsmzYU6S3XWMSW3WyiHhzAC2uU+jXeY3leip6FrxDMqotaMIMv2D1Svg0I92qJ4Pme
         ZtuODhc5RSsYVa1301DGUlyWSY6oDsn01w0F102yRyy6pkzcY7oDDbJ/NW4eRdOggZpT
         j7zBkO6/lXRD14iWlFt8dpcaphXMY6N52Q7KHFia4sVjsbqFkQ86hWuUx01Og+MSMEP1
         YP3BkhtpBvMLsV06iXs0qKZVsfiRk1LMKWJ40k/mQLnGO4HE7RhBN/6cGrnoo6SAH0+8
         9lSu198W4IAz3NL0ANojqkRTdkwscKUS5fTf7MqdRVeQJNXReGt1yCP3g8+UPYKc0AY6
         Wgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001769; x=1743606569;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ce5BiQM2/fANf7gq6gy5sOXGo7Ftl1D3smnzrrXQk4=;
        b=BXYd+pcplDxa6NnoLs0C+H9S/QXqCr3qCcf0QeyWO/ovULLeLFHDhYcHNMFeAoNVJe
         tCTMry4wZs2KZXCmFfaPDAvzQGlsSx6kjzubsUnqsT7GDkiimUxB2XGx54ICiQLDlLhO
         f3azTKMdjQlp3mqHj8sTLZrCFUFHDdvFZx9K4RsFXNF2Srj9IrDeMCEVb0pxyeB4iWnC
         aS7VWDi+FIkYCPgEuvHcflUPxfQ2u+3r02rvX3PcIbjy+mZR3S6hUdpTc9DNBHIu1CnN
         oU/8DNV28Iq80B/kNiVw0+82QPkAxpo7GWQTWMt2jV7wS4vd4IjWmmoJ6cFi13dy5qGT
         d0sg==
X-Forwarded-Encrypted: i=1; AJvYcCU6bqppoMbSVagyEyEMdqhOocWd+F14qQj3zJQRuvEXhDiq7Dmm11s8J10AJB6KplXQHMZWYgzH@vger.kernel.org, AJvYcCUyzsjN6JijIeKuJU7i06EcKBVpL7VhPPSFNC9IepPwhOzcaoSl0bF4K9GbpVkR8j2v026HjG1EN258ffu6@vger.kernel.org, AJvYcCXqQi0MiqyfFNgjhM5bmJGNKTW52YEs94CnQYfHC8daL7E3tlRnrkXMhWXXz39YaiTkeohiiRPfA1EP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyye3xbd5LZlBssc9Uo8/1B7gfkLeGEQG2d+M5AkmVCPFtYiNJ
	k4QCa+FcK7U7TxNYSSD7elN99n4/SX4veLEcmbewJ90+tkZm8FId
X-Gm-Gg: ASbGncvSWGbDZv2doaTU4+Xma+D3ojKDs/aAPC1nBF0lX27QujKFIJPpt9NLiB61EIL
	wxZKRlAYvy5DMnBOUx1xFyz+/KZWZLvQ7HxZImZoLNgYdLU49JgUVl4dtUBfYNqCVDXQdjFU28C
	4MlM9R2blGgZXYY0TkfpgTmQ1HFx5AoY47L+B6jpCHDcMlu9jv9riryAmSO95zo1LiN8Tao6Mrj
	tiAeiDDexQgsi6+ma7/qo9+Q4YrLMMoqLpCsqc+4XqaGJRVc4+psjEte9lRa20n8JBcF7xxJOKa
	qp8GPQr+bVmJdIEdhsAO+CjrTnBNj1z6Ua9ArrVM6eV4Bn4QzqbUASLtvuYYEAcuFMwasTWFIDw
	m
X-Google-Smtp-Source: AGHT+IETUQMPwJWNVeDlOxoEpYq62E+au6l2JD19LeAqaVlcwIhL15hqZjmgELSkgfMolh9se1W/Xw==
X-Received: by 2002:a05:600c:15c8:b0:43d:94:cff0 with SMTP id 5b1f17b1804b1-43d51a91d05mr121962375e9.19.1743001769155;
        Wed, 26 Mar 2025 08:09:29 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdffdsm4754705e9.18.2025.03.26.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:09:28 -0700 (PDT)
Message-ID: <67e418a8.050a0220.3b7a97.7228@mx.google.com>
X-Google-Original-Message-ID: <Z-QYpcogNHEzizMD@Ansuel-XPS.>
Date: Wed, 26 Mar 2025 16:09:25 +0100
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
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <dfa78876-d4a6-4226-b3d4-dbf112e001ee@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa78876-d4a6-4226-b3d4-dbf112e001ee@lunn.ch>

On Wed, Mar 26, 2025 at 03:56:15PM +0100, Andrew Lunn wrote:
> > +#define PHY_ID_AS21XXX			0x75009410
> > +/* AS21xxx ID Legend
> > + * AS21x1xxB1
> > + *     ^ ^^
> > + *     | |J: Supports SyncE/PTP
> > + *     | |P: No SyncE/PTP support
> > + *     | 1: Supports 2nd Serdes
> > + *     | 2: Not 2nd Serdes support
> > + *     0: 10G, 5G, 2.5G
> > + *     5: 5G, 2.5G
> > + *     2: 2.5G
> > + */
> > +#define PHY_ID_AS21011JB1		0x75009402
> > +#define PHY_ID_AS21011PB1		0x75009412
> > +#define PHY_ID_AS21010JB1		0x75009422
> > +#define PHY_ID_AS21010PB1		0x75009432
> > +#define PHY_ID_AS21511JB1		0x75009442
> > +#define PHY_ID_AS21511PB1		0x75009452
> > +#define PHY_ID_AS21510JB1		0x75009462
> > +#define PHY_ID_AS21510PB1		0x75009472
> > +#define PHY_ID_AS21210JB1		0x75009482
> > +#define PHY_ID_AS21210PB1		0x75009492
> > +#define PHY_VENDOR_AEONSEMI		0x75009400
> 
> O.K. This helps.
> 
> > +static struct phy_driver as21xxx_drivers[] = {
> > +	{
> > +		/* PHY expose in C45 as 0x7500 0x9410
> > +		 * before firmware is loaded.
> > +		 */
> > +		PHY_ID_MATCH_EXACT(PHY_ID_AS21XXX),
> > +		.name		= "Aeonsemi AS21xxx",
> > +		.probe		= as21xxx_probe,
> > +	},
> > +	{
> > +		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
> > +		.name		= "Aeonsemi AS21011JB1",
> > +		.read_status	= as21xxx_read_status,
> > +		.led_brightness_set = as21xxx_led_brightness_set,
> > +		.led_hw_is_supported = as21xxx_led_hw_is_supported,
> > +		.led_hw_control_set = as21xxx_led_hw_control_set,
> > +		.led_hw_control_get = as21xxx_led_hw_control_get,
> > +		.led_polarity_set = as21xxx_led_polarity_set,
> > +	},
> 
> It is guaranteed by the current code that these entries are tried in
> the order listed here. If that was to change, other drivers would
> break.
> 
> So what you can do is have the first entry for PHY_ID_AS21XXX with
> as21xxx_probe, have the probe download the firmware and then return
> -ENODEV. PHY_ID_AS21XXX tells us there is no firmware, so this is what
> we need to do. The -ENODEV then tells the core that this driver entry
> does not match the hardware, try the next.
> 
> After the firmware download, the phylib core will still have the wrong
> ID values. So you cannot use PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1).
> But what you can do is have a .match_phy_device function. It will get
> called, and it can read the real ID from the device, and perform a
> match. If it does not match return -ENODEV, and the core will try the
> next entry.
> 
> You either need N match_phy_device functions, one per ID value, or you
> can make use of the .driver_data in phy_driver, and place the matching
> data there.
> 
> In the end you should have the correct phy_driver structure for the
> device. The core will still have the wrong ID values, which you should
> document with a comment. But that mostly only effects
> /sys/class/bus/mdio-bus/...
>

Thanks a lot for the hint on how to use .match_phy_device for this,
wasn't aware of the enforced PHY order.

I will investigate this but may I ask who creates the sysfs entry and
at what stage? After phy_register?

Cause if that is the case can't this be solved by making the PHY
function rescan the ID? Checking patch 1 of this series, it won't be
driver_release/attach but just a flag to read the PHY again and update
phy_device.

From what I observed, updating the phy_id entry in phy_device (or
c45_ids) is harmless. A rescan totally deletes the problem of having to
use the match functions.

-- 
	Ansuel

