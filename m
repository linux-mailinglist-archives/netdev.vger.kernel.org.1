Return-Path: <netdev+bounces-45784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B62D7DF8D6
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A1E281B86
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BA20317;
	Thu,  2 Nov 2023 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CMQEoFk5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F4208A1;
	Thu,  2 Nov 2023 17:37:54 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B218E;
	Thu,  2 Nov 2023 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AwjL71MzeBAOU4MURIsg1EVjWrpke9ZuNN+nhEn3EhY=; b=CMQEoFk5VPoCoRlU0pe6Wb6hoA
	HzwVTLgbLMW4t31pglN1w4Nh6mnQVi7iCY/UaZ3uEEpl1VteLIZhNjYVya78nsTqkK2s10hP/4pYJ
	oUk3WgTzgerJADJWK8EYHQk+226dl88aUocz1ggjHNl4nlkxBF1Rh03pUGM9qUoIAUOA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qybdU-000lnS-4G; Thu, 02 Nov 2023 18:37:40 +0100
Date: Thu, 2 Nov 2023 18:37:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 3/4] net: phy: aquantia: add firmware
 load support
Message-ID: <e632a285-9cb2-4dc9-a4a2-f57e454b8ffe@lunn.ch>
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
 <20231102150032.10740-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102150032.10740-3-ansuelsmth@gmail.com>

> +/* AQR firmware doesn't have fixed offsets for iram and dram section
> + * but instead provide an header with the offset to use on reading
> + * and parsing the firmware.
> + *
> + * AQR firmware can't be trusted and each offset is validated to be
> + * not negative and be in the size of the firmware itself.
> + */
> +static inline bool aqr_fw_validate_get(size_t size, size_t offset, size_t get_size)
> +{
> +	return size + offset > 0 && offset + get_size <= size;
> +}

Please don't user inline in .c files. The compiler is better at
deciding than we are.

Also, i wounder about size + offset > 0. size_t is unsigned. So they
cannot be negative. So does this test make sense?

> +static int aqr_fw_boot(struct phy_device *phydev, const u8 *data, size_t size,
> +		       enum aqr_fw_src fw_src)
> +{
> +	u16 calculated_crc, read_crc, read_primary_offset;
> +	u32 iram_offset = 0, iram_size = 0;
> +	u32 dram_offset = 0, dram_size = 0;
> +	char version[VERSION_STRING_SIZE];
> +	u32 primary_offset = 0;
> +	int ret;
> +
> +	/* extract saved CRC at the end of the fw
> +	 * CRC is saved in big-endian as PHY is BE
> +	 */
> +	ret = aqr_fw_get_be16(data, size - sizeof(u16), size, &read_crc);
> +	if (ret) {
> +		phydev_err(phydev, "bad firmware CRC in firmware\n");
> +		return ret;
> +	}

So if size < sizeof(u16), we get a very big positive number. The > 0
test does nothing for you here, but the other half of the test does
trap the issue.

So i think you can remove the > 0 test.

   Andrew

