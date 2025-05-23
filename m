Return-Path: <netdev+bounces-193171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C247AC2B5E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515631B67429
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA65158535;
	Fri, 23 May 2025 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baCzaB8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A902DCBE6;
	Fri, 23 May 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035987; cv=none; b=T5RlCGJ4+ZqmbMc6bEPrrinFolGNka8n54fd/ctZ1iOkyDpjF2bC8hBW7GBGcAfj5duNvQ4rWtus8ct3ZwI1G6DlNMgMY6x7COBVL8jrg/+2yRz5zwcEi/uHEVhiVLC6GZe4Qq/KDCZxbh3sYKXxKNaJcteM1uKfzKQnMuMHN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035987; c=relaxed/simple;
	bh=pMh1q2pHISLe1mGiE+es+WmOK0AdmJJ25GW3erPjaAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6/eiDtQo6z4AHzp1yWJcRfSPehElue2mHBVtJotCwtT+6rC4NbNa0va4igZ20ljlPl1P4ok4ZTd1NLWRsfL7/er4HqYfDmPb255HjLYmFBG3a3jfKGbJfzWb5NehuZE+MO2QYr8MpRXNQL7sfyRxUu3oIqHvskrpNcvJ1uk6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baCzaB8b; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442ea341570so1634915e9.1;
        Fri, 23 May 2025 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748035983; x=1748640783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pLCkPtZ/dYHVDHhadLvAgk839erMkoL+EtT0sSHI9EI=;
        b=baCzaB8bJJZxE08PncGbKgzV34yZCMywzCO3gOdelrvzFAJtqensh8M4mFwYS1jguj
         fjecn9MXTA7O4LNYoGF950HTJzSm/0ybi62BBPNU9Jha9OY5vWOqgLCpi7m66Q56kys8
         ZCTXVZmpsyvyCayORi0OZyfV871pGhaPudiRTM+dz14xzzfWt2abbTofm6oBqdZ6zmKD
         FUS0ZKgJ2P2MEMEnbK9DrF6vV2EPy5OjdLmJ9DyJnMWfbD2lUMgi9OVCvL4yCi7uCbMG
         7xfNp+s2AXoaC1X0iJ+TAubn9f5fxApT9kyp1/0B9EGLyj1t7hTZWE0pYDpy+6yf2Lda
         yOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748035983; x=1748640783;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLCkPtZ/dYHVDHhadLvAgk839erMkoL+EtT0sSHI9EI=;
        b=CoUZCE/EznT3DD6H5c1dxTdySy5Tld879EKveBoDViHLfbYzi8MRnu7px9zjAyb02u
         3/GgtYiCTqCSOYosOis8yl6W1rGXHQJGbY9M20pc32fltyHdWa0gId1Hh76mAIJO5zHd
         kRcbzjzap7OJ4jirmQO3/NXzlxr4ox0g+6paZSzejDMG0o6BzlrWewBLqYkg1QOqIX8f
         2huT0Xg2wbjE+ukyDexpMFTlWyUf3yOmlsULbdCmPF4mPBC1ReTPJ6wZeMCfHESIiYdU
         pmFPvuEdrA1F0otvCFhuiOROuswTJ+lWtLajc1qWFHJDNjvdJx3i1ki6jZqv7LoSB6ie
         37Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUEBTkOIFexVn6wY7EEu+Fax44Ku857JJP1fhPFWviCGdUHapL8u/7u4bWsWDk8HbdsFqYcAR0G@vger.kernel.org, AJvYcCWZ7eZyZQSXKnMBJcYAEVP5d9sF1Yf9hK6BfLgKTQCidpunfNxI7RV6H4nfK4PleK3Kolk5+4lVoKLd+ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/tGrou3DCX+WX+nFpMIkPEuxF95tADPGK+JJxVDNFemwE9+7
	0/AIh76PnNvpNi+/6zMZhArVg62OUTDzGEncfM9MgPkBMqfF0ixMTcqP
X-Gm-Gg: ASbGncvFr2Yq9m9qgT+SmLMM5AliVDPY2TPpuuwxX1V1nL9h/+o+hhzrVQJvV33KSyi
	Bpq2oHQSOcBLzUrTyLqCFIDRKr0J7Z4qU8eBP1pg+b5o3A8ZL7q0M/ElOgcTjhEpCr5BbNjhNSL
	HWZ+M0X9VVKttGUqf8+gYu0leOx5Uy7vtnREzFEZr0jiu2vwUc+4cqaeEJgV8lA+HLkilMRN7CO
	dsoF9pWuuI/6ae9RLaP576kj1uLU10FNseyM1FT2RV03UWbzKAwhY09+TkJ3OrSLLh41mRyNrEr
	pFTiz49xEwNeOBkpy0zNutS+tRqIKYNfcefqBKaFdLGpgj5xHgMyheYtjP1SzLg3Pmdb2SkzkZq
	eMty0y7QBWr/0cm11jak1frS4Bqr3VV33ULU2BME0jjcS7E0/qdmx9BzMhx7Rf6B2e1vqD4RwJJ
	xH87gG8jI1bEsu
X-Google-Smtp-Source: AGHT+IGOj5kwmh6XB5+guwn/IhWvZj8wiuq7W/OcDgtl59c8v6KqlcygDAMzHfQBdO78K6LTjZxylA==
X-Received: by 2002:a05:600c:511b:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-44c9493e671mr4468925e9.25.1748035983238;
        Fri, 23 May 2025 14:33:03 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f47:3100:348b:fd2d:79a:9019? (p200300ea8f473100348bfd2d079a9019.dip0.t-ipconnect.de. [2003:ea:8f47:3100:348b:fd2d:79a:9019])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb7fsm150704315e9.26.2025.05.23.14.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 14:33:01 -0700 (PDT)
Message-ID: <a937e728-d911-4fcc-9af1-9ae6130f96c1@gmail.com>
Date: Fri, 23 May 2025 23:33:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO
 driver
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Lei Wei <quic_leiwei@quicinc.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250523203339.1993685-1-sean.anderson@linux.dev>
 <20250523203339.1993685-6-sean.anderson@linux.dev>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20250523203339.1993685-6-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.05.2025 22:33, Sean Anderson wrote:
> This converts the lynx PCS driver to a proper MDIO driver.
> This allows using a more conventional driver lifecycle (e.g. with a
> probe and remove). It will also make it easier to add interrupt support.
> 
> The existing helpers are converted to bind the MDIO driver instead of
> creating the PCS directly. As lynx_pcs_create_mdiodev creates the PCS
> device, we can just set the modalias. For lynx_pcs_create_fwnode, we try
> to get the PCS the usual way, and if that fails we edit the devicetree
> to add a compatible and reprobe the device.
> 
> To ensure my contributions remain free software, remove the BSD option
> from the license. This is permitted because the SPDX uses "OR".
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v5:
> - Use MDIO_BUS instead of MDIO_DEVICE
> 
> Changes in v4:
> - Add a note about the license
> - Convert to dev-less pcs_put
> 
> Changes in v3:
> - Call devm_pcs_register instead of devm_pcs_register_provider
> 
> Changes in v2:
> - Add support for #pcs-cells
> - Remove unused variable lynx_properties
> 
>  drivers/net/dsa/ocelot/Kconfig                |   4 +
>  drivers/net/dsa/ocelot/felix_vsc9959.c        |  11 +-
>  drivers/net/dsa/ocelot/seville_vsc9953.c      |  11 +-
>  drivers/net/ethernet/altera/Kconfig           |   2 +
>  drivers/net/ethernet/altera/altera_tse_main.c |   7 +-
>  drivers/net/ethernet/freescale/dpaa/Kconfig   |   2 +-
>  drivers/net/ethernet/freescale/dpaa2/Kconfig  |   3 +
>  .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  |  11 +-
>  drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
>  .../net/ethernet/freescale/enetc/enetc_pf.c   |   8 +-
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |   1 -
>  .../freescale/enetc/enetc_pf_common.c         |   4 +-
>  drivers/net/ethernet/freescale/fman/Kconfig   |   4 +-
>  .../net/ethernet/freescale/fman/fman_memac.c  |  25 ++--
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |   3 +
>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   6 +-
>  drivers/net/pcs/Kconfig                       |  11 +-
>  drivers/net/pcs/pcs-lynx.c                    | 110 ++++++++++--------
>  include/linux/pcs-lynx.h                      |  13 ++-
>  19 files changed, 128 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/net/dsa/ocelot/Kconfig b/drivers/net/dsa/ocelot/Kconfig
> index 081e7a88ea02..907c29d61c14 100644
> --- a/drivers/net/dsa/ocelot/Kconfig
> +++ b/drivers/net/dsa/ocelot/Kconfig
> @@ -42,7 +42,9 @@ config NET_DSA_MSCC_FELIX
>  	select NET_DSA_TAG_OCELOT_8021Q
>  	select NET_DSA_TAG_OCELOT
>  	select FSL_ENETC_MDIO
> +	select PCS
>  	select PCS_LYNX
> +	select MDIO_BUS

This shouldn't be needed. NET_DSA selects PHYLINK, which selects PHYLIB,
which selects MDIO_BUS. There are more places in this series where the
same comment applies.

>  	help
>  	  This driver supports the VSC9959 (Felix) switch, which is embedded as
>  	  a PCIe function of the NXP LS1028A ENETC RCiEP.
> @@ -58,7 +60,9 @@ config NET_DSA_MSCC_SEVILLE
>  	select NET_DSA_MSCC_FELIX_DSA_LIB
>  	select NET_DSA_TAG_OCELOT_8021Q
>  	select NET_DSA_TAG_OCELOT
> +	select PCS
>  	select PCS_LYNX
> +	select MDIO_BUS
>  	help
>  	  This driver supports the VSC9953 (Seville) switch, which is embedded
>  	  as a platform device on the NXP T1040 SoC.
> diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
> index 087d368a59e0..6feae845af10 100644
> --- a/drivers/net/dsa/ocelot/felix_vsc9959.c
> +++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
> @@ -12,6 +12,7 @@
>  #include <net/tc_act/tc_gate.h>
>  #include <soc/mscc/ocelot.h>
>  #include <linux/dsa/ocelot.h>
> +#include <linux/pcs.h>
>  #include <linux/pcs-lynx.h>
>  #include <net/pkt_sched.h>
>  #include <linux/iopoll.h>
> @@ -1033,7 +1034,7 @@ static int vsc9959_mdio_bus_alloc(struct ocelot *ocelot)
>  		if (ocelot_port->phy_mode == PHY_INTERFACE_MODE_INTERNAL)
>  			continue;
>  
> -		phylink_pcs = lynx_pcs_create_mdiodev(felix->imdio, port);
> +		phylink_pcs = lynx_pcs_create_mdiodev(dev, felix->imdio, port);
>  		if (IS_ERR(phylink_pcs))
>  			continue;
>  
> @@ -1050,12 +1051,8 @@ static void vsc9959_mdio_bus_free(struct ocelot *ocelot)
>  	struct felix *felix = ocelot_to_felix(ocelot);
>  	int port;
>  
> -	for (port = 0; port < ocelot->num_phys_ports; port++) {
> -		struct phylink_pcs *phylink_pcs = felix->pcs[port];
> -
> -		if (phylink_pcs)
> -			lynx_pcs_destroy(phylink_pcs);
> -	}
> +	for (port = 0; port < ocelot->num_phys_ports; port++)
> +		pcs_put(felix->pcs[port]);
>  	mdiobus_unregister(felix->imdio);
>  	mdiobus_free(felix->imdio);
>  }
> diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
> index 28bcdef34a6c..627c0bd7a777 100644
> --- a/drivers/net/dsa/ocelot/seville_vsc9953.c
> +++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
> @@ -10,6 +10,7 @@
>  #include <linux/mdio/mdio-mscc-miim.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/of_mdio.h>
> +#include <linux/pcs.h>
>  #include <linux/pcs-lynx.h>
>  #include <linux/dsa/ocelot.h>
>  #include <linux/iopoll.h>
> @@ -926,7 +927,7 @@ static int vsc9953_mdio_bus_alloc(struct ocelot *ocelot)
>  		if (ocelot_port->phy_mode == PHY_INTERFACE_MODE_INTERNAL)
>  			continue;
>  
> -		phylink_pcs = lynx_pcs_create_mdiodev(felix->imdio, addr);
> +		phylink_pcs = lynx_pcs_create_mdiodev(dev, felix->imdio, addr);
>  		if (IS_ERR(phylink_pcs))
>  			continue;
>  
> @@ -943,12 +944,8 @@ static void vsc9953_mdio_bus_free(struct ocelot *ocelot)
>  	struct felix *felix = ocelot_to_felix(ocelot);
>  	int port;
>  
> -	for (port = 0; port < ocelot->num_phys_ports; port++) {
> -		struct phylink_pcs *phylink_pcs = felix->pcs[port];
> -
> -		if (phylink_pcs)
> -			lynx_pcs_destroy(phylink_pcs);
> -	}
> +	for (port = 0; port < ocelot->num_phys_ports; port++)
> +		pcs_put(felix->pcs[port]);
>  
>  	/* mdiobus_unregister and mdiobus_free handled by devres */
>  }
> diff --git a/drivers/net/ethernet/altera/Kconfig b/drivers/net/ethernet/altera/Kconfig
> index 4ef819a9a1ad..9b68321e8b86 100644
> --- a/drivers/net/ethernet/altera/Kconfig
> +++ b/drivers/net/ethernet/altera/Kconfig
> @@ -5,7 +5,9 @@ config ALTERA_TSE
>  	depends on HAS_IOMEM
>  	select PHYLIB
>  	select PHYLINK
> +	select PCS
>  	select PCS_LYNX
> +	select MDIO_BUS
>  	select MDIO_REGMAP
>  	select REGMAP_MMIO
>  	help
> diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
> index 3f6204de9e6b..8bd4753a04bc 100644
> --- a/drivers/net/ethernet/altera/altera_tse_main.c
> +++ b/drivers/net/ethernet/altera/altera_tse_main.c
> @@ -32,6 +32,7 @@
>  #include <linux/of.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
> +#include <linux/pcs.h>
>  #include <linux/pcs-lynx.h>
>  #include <linux/phy.h>
>  #include <linux/platform_device.h>
> @@ -1412,7 +1413,7 @@ static int altera_tse_probe(struct platform_device *pdev)
>  		goto err_init_pcs;
>  	}
>  
> -	priv->pcs = lynx_pcs_create_mdiodev(pcs_bus, 0);
> +	priv->pcs = lynx_pcs_create_mdiodev(&pdev->dev, pcs_bus, 0);
>  	if (IS_ERR(priv->pcs)) {
>  		ret = PTR_ERR(priv->pcs);
>  		goto err_init_pcs;
> @@ -1444,7 +1445,7 @@ static int altera_tse_probe(struct platform_device *pdev)
>  
>  	return 0;
>  err_init_phylink:
> -	lynx_pcs_destroy(priv->pcs);
> +	pcs_put(priv->pcs);
>  err_init_pcs:
>  	unregister_netdev(ndev);
>  err_register_netdev:
> @@ -1466,7 +1467,7 @@ static void altera_tse_remove(struct platform_device *pdev)
>  	altera_tse_mdio_destroy(ndev);
>  	unregister_netdev(ndev);
>  	phylink_destroy(priv->phylink);
> -	lynx_pcs_destroy(priv->pcs);
> +	pcs_put(priv->pcs);
>  
>  	free_netdev(ndev);
>  }
> diff --git a/drivers/net/ethernet/freescale/dpaa/Kconfig b/drivers/net/ethernet/freescale/dpaa/Kconfig
> index 2b560661c82a..bb658f1db129 100644
> --- a/drivers/net/ethernet/freescale/dpaa/Kconfig
> +++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
> @@ -3,7 +3,7 @@ menuconfig FSL_DPAA_ETH
>  	tristate "DPAA Ethernet"
>  	depends on FSL_DPAA && FSL_FMAN
>  	select PHYLINK
> -	select PCS_LYNX
> +	select MDIO_BUS
>  	help
>  	  Data Path Acceleration Architecture Ethernet driver,
>  	  supporting the Freescale QorIQ chips.
> diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> index d029b69c3f18..806931b2b9fa 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/Kconfig
> +++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> @@ -2,8 +2,11 @@
>  config FSL_DPAA2_ETH
>  	tristate "Freescale DPAA2 Ethernet"
>  	depends on FSL_MC_BUS && FSL_MC_DPIO
> +	select OF_DYNAMIC
>  	select PHYLINK
> +	select PCS
>  	select PCS_LYNX
> +	select MDIO_BUS
>  	select FSL_XGMAC_MDIO
>  	select NET_DEVLINK
>  	help
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> index 422ce13a7c94..0dc0a265db51 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> @@ -2,6 +2,7 @@
>  /* Copyright 2019 NXP */
>  
>  #include <linux/acpi.h>
> +#include <linux/pcs.h>
>  #include <linux/pcs-lynx.h>
>  #include <linux/phy/phy.h>
>  #include <linux/property.h>
> @@ -262,7 +263,7 @@ static int dpaa2_pcs_create(struct dpaa2_mac *mac,
>  		return 0;
>  	}
>  
> -	pcs = lynx_pcs_create_fwnode(node);
> +	pcs = lynx_pcs_create_fwnode(&mac->mc_dev->dev, node);
>  	fwnode_handle_put(node);
>  
>  	if (pcs == ERR_PTR(-EPROBE_DEFER)) {
> @@ -288,12 +289,8 @@ static int dpaa2_pcs_create(struct dpaa2_mac *mac,
>  
>  static void dpaa2_pcs_destroy(struct dpaa2_mac *mac)
>  {
> -	struct phylink_pcs *phylink_pcs = mac->pcs;
> -
> -	if (phylink_pcs) {
> -		lynx_pcs_destroy(phylink_pcs);
> -		mac->pcs = NULL;
> -	}
> +	pcs_put(mac->pcs);
> +	mac->pcs = NULL;
>  }
>  
>  static void dpaa2_mac_set_supported_interfaces(struct dpaa2_mac *mac)
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index e917132d3714..f3ac430c9d4f 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -30,7 +30,9 @@ config FSL_ENETC
>  	select FSL_ENETC_MDIO
>  	select NXP_ENETC_PF_COMMON
>  	select PHYLINK
> +	select PCS
>  	select PCS_LYNX
> +	select MDIO_BUS
>  	select DIMLIB
>  	help
>  	  This driver supports NXP ENETC gigabit ethernet controller PCIe
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index f63a29e2e031..8d0950c28190 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -34,12 +34,7 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
>  static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
>  					       struct mii_bus *bus)
>  {
> -	return lynx_pcs_create_mdiodev(bus, 0);
> -}
> -
> -static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
> -{
> -	lynx_pcs_destroy(pcs);
> +	return lynx_pcs_create_mdiodev(&pf->si->pdev->dev, bus, 0);
>  }
>  
>  static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
> @@ -914,7 +909,6 @@ static const struct enetc_pf_ops enetc_pf_ops = {
>  	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
>  	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
>  	.create_pcs = enetc_pf_create_pcs,
> -	.destroy_pcs = enetc_pf_destroy_pcs,
>  	.enable_psfp = enetc_psfp_enable,
>  };
>  
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index ae407e9e9ee7..be22b036df42 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -32,7 +32,6 @@ struct enetc_pf_ops {
>  	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
>  	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
>  	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
> -	void (*destroy_pcs)(struct phylink_pcs *pcs);
>  	int (*enable_psfp)(struct enetc_ndev_priv *priv);
>  };
>  
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index edf14a95cab7..1c53036d17df 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -4,6 +4,7 @@
>  #include <linux/fsl/enetc_mdio.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
> +#include <linux/pcs.h>
>  
>  #include "enetc_pf_common.h"
>  
> @@ -248,8 +249,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>  
>  static void enetc_imdio_remove(struct enetc_pf *pf)
>  {
> -	if (pf->pcs && pf->ops->destroy_pcs)
> -		pf->ops->destroy_pcs(pf->pcs);
> +	pcs_put(pf->pcs);
>  
>  	if (pf->imdio) {
>  		mdiobus_unregister(pf->imdio);
> diff --git a/drivers/net/ethernet/freescale/fman/Kconfig b/drivers/net/ethernet/freescale/fman/Kconfig
> index a55542c1ad65..2b51b223716b 100644
> --- a/drivers/net/ethernet/freescale/fman/Kconfig
> +++ b/drivers/net/ethernet/freescale/fman/Kconfig
> @@ -3,10 +3,12 @@ config FSL_FMAN
>  	tristate "FMan support"
>  	depends on FSL_SOC || ARCH_LAYERSCAPE || COMPILE_TEST
>  	select GENERIC_ALLOCATOR
> +	select OF_DYNAMIC
> +	select MDIO_BUS
>  	select PHYLINK
> +	select PCS
>  	select PCS_LYNX
>  	select CRC32
> -	default n
>  	help
>  		Freescale Data-Path Acceleration Architecture Frame Manager
>  		(FMan) support
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
> index 3925441143fa..a6064bc80ce7 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/slab.h>
>  #include <linux/io.h>
> +#include <linux/pcs.h>
>  #include <linux/pcs-lynx.h>
>  #include <linux/phy.h>
>  #include <linux/phy_fixed.h>
> @@ -972,21 +973,21 @@ static int memac_init(struct fman_mac *memac)
>  	return 0;
>  }
>  
> -static void pcs_put(struct phylink_pcs *pcs)
> +static void memac_pcs_put(struct phylink_pcs *pcs)
>  {
>  	if (IS_ERR_OR_NULL(pcs))
>  		return;
>  
> -	lynx_pcs_destroy(pcs);
> +	pcs_put(pcs);
>  }
>  
>  static int memac_free(struct fman_mac *memac)
>  {
>  	free_init_resources(memac);
>  
> -	pcs_put(memac->sgmii_pcs);
> -	pcs_put(memac->qsgmii_pcs);
> -	pcs_put(memac->xfi_pcs);
> +	memac_pcs_put(memac->sgmii_pcs);
> +	memac_pcs_put(memac->qsgmii_pcs);
> +	memac_pcs_put(memac->xfi_pcs);
>  	kfree(memac->memac_drv_param);
>  	kfree(memac);
>  
> @@ -1033,7 +1034,8 @@ static struct fman_mac *memac_config(struct mac_device *mac_dev,
>  	return memac;
>  }
>  
> -static struct phylink_pcs *memac_pcs_create(struct device_node *mac_node,
> +static struct phylink_pcs *memac_pcs_create(struct device *dev,
> +					    struct device_node *mac_node,
>  					    int index)
>  {
>  	struct device_node *node;
> @@ -1043,7 +1045,7 @@ static struct phylink_pcs *memac_pcs_create(struct device_node *mac_node,
>  	if (!node)
>  		return ERR_PTR(-ENODEV);
>  
> -	pcs = lynx_pcs_create_fwnode(of_fwnode_handle(node));
> +	pcs = lynx_pcs_create_fwnode(dev, of_fwnode_handle(node));
>  	of_node_put(node);
>  
>  	return pcs;
> @@ -1100,7 +1102,7 @@ int memac_initialization(struct mac_device *mac_dev,
>  
>  	err = of_property_match_string(mac_node, "pcs-handle-names", "xfi");
>  	if (err >= 0) {
> -		memac->xfi_pcs = memac_pcs_create(mac_node, err);
> +		memac->xfi_pcs = memac_pcs_create(mac_dev->dev, mac_node, err);
>  		if (IS_ERR(memac->xfi_pcs)) {
>  			err = PTR_ERR(memac->xfi_pcs);
>  			dev_err_probe(mac_dev->dev, err, "missing xfi pcs\n");
> @@ -1112,7 +1114,8 @@ int memac_initialization(struct mac_device *mac_dev,
>  
>  	err = of_property_match_string(mac_node, "pcs-handle-names", "qsgmii");
>  	if (err >= 0) {
> -		memac->qsgmii_pcs = memac_pcs_create(mac_node, err);
> +		memac->qsgmii_pcs = memac_pcs_create(mac_dev->dev, mac_node,
> +						     err);
>  		if (IS_ERR(memac->qsgmii_pcs)) {
>  			err = PTR_ERR(memac->qsgmii_pcs);
>  			dev_err_probe(mac_dev->dev, err,
> @@ -1128,11 +1131,11 @@ int memac_initialization(struct mac_device *mac_dev,
>  	 */
>  	err = of_property_match_string(mac_node, "pcs-handle-names", "sgmii");
>  	if (err == -EINVAL || err == -ENODATA)
> -		pcs = memac_pcs_create(mac_node, 0);
> +		pcs = memac_pcs_create(mac_dev->dev, mac_node, 0);
>  	else if (err < 0)
>  		goto _return_fm_mac_free;
>  	else
> -		pcs = memac_pcs_create(mac_node, err);
> +		pcs = memac_pcs_create(mac_dev->dev, mac_node, err);
>  
>  	if (IS_ERR(pcs)) {
>  		err = PTR_ERR(pcs);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 67fa879b1e52..170ec691d090 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -182,9 +182,12 @@ config DWMAC_SOCFPGA
>  	tristate "SOCFPGA dwmac support"
>  	default ARCH_INTEL_SOCFPGA
>  	depends on OF && (ARCH_INTEL_SOCFPGA || COMPILE_TEST)
> +	select OF_DYNAMIC
>  	select MFD_SYSCON
> +	select MDIO_BUS
>  	select MDIO_REGMAP
>  	select REGMAP_MMIO
> +	select PCS
>  	select PCS_LYNX
>  	help
>  	  Support for ethernet controller on Altera SOCFPGA
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 72b50f6d72f4..325486c06511 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -8,6 +8,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_net.h>
> +#include <linux/pcs.h>
>  #include <linux/phy.h>
>  #include <linux/regmap.h>
>  #include <linux/mdio/mdio-regmap.h>
> @@ -414,7 +415,7 @@ static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv)
>  	if (IS_ERR(pcs_bus))
>  		return PTR_ERR(pcs_bus);
>  
> -	pcs = lynx_pcs_create_mdiodev(pcs_bus, 0);
> +	pcs = lynx_pcs_create_mdiodev(priv->device, pcs_bus, 0);
>  	if (IS_ERR(pcs))
>  		return PTR_ERR(pcs);
>  
> @@ -424,8 +425,7 @@ static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv)
>  
>  static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv)
>  {
> -	if (priv->hw->phylink_pcs)
> -		lynx_pcs_destroy(priv->hw->phylink_pcs);
> +	pcs_put(priv->hw->phylink_pcs);
>  }
>  
>  static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv *priv,
> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index 6d19625b696d..f274ebffaae3 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -26,10 +26,15 @@ config PCS_XPCS
>  	  DesignWare XPCS controllers.
>  
>  config PCS_LYNX
> -	tristate
> +	tristate "NXP Lynx PCS driver"
> +	depends on PCS && MDIO_BUS
>  	help
> -	  This module provides helpers to phylink for managing the Lynx PCS
> -	  which is part of the Layerscape and QorIQ Ethernet SERDES.
> +	  This module provides driver support for the PCSs in Lynx 10g and 28g
> +	  SerDes devices. These devices are present in NXP QorIQ SoCs,
> +	  including the Layerscape series.
> +
> +	  If you want to use Ethernet on a QorIQ SoC, say "Y". If compiled as a
> +	  module, it will be called "pcs-lynx".
>  
>  config PCS_MTK_LYNXI
>  	tristate
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index 23b40e9eacbb..bacba1dd52e2 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -1,11 +1,15 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> -/* Copyright 2020 NXP
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2022 Sean Anderson <seanga2@gmail.com>
> + * Copyright 2020 NXP
>   * Lynx PCS MDIO helpers
>   */
>  
>  #include <linux/mdio.h>
>  #include <linux/phylink.h>
> +#include <linux/of.h>
> +#include <linux/pcs.h>
>  #include <linux/pcs-lynx.h>
> +#include <linux/phylink.h>
>  #include <linux/property.h>
>  
>  #define SGMII_CLOCK_PERIOD_NS		8 /* PCS is clocked at 125 MHz */
> @@ -343,16 +347,16 @@ static const phy_interface_t lynx_interfaces[] = {
>  	PHY_INTERFACE_MODE_USXGMII,
>  };
>  
> -static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
> +static int lynx_pcs_probe(struct mdio_device *mdio)
>  {
> +	struct device *dev = &mdio->dev;
>  	struct lynx_pcs *lynx;
> -	int i;
> +	int i, ret;
>  
> -	lynx = kzalloc(sizeof(*lynx), GFP_KERNEL);
> +	lynx = devm_kzalloc(dev, sizeof(*lynx), GFP_KERNEL);
>  	if (!lynx)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>  
> -	mdio_device_get(mdio);
>  	lynx->mdio = mdio;
>  	lynx->pcs.ops = &lynx_pcs_phylink_ops;
>  	lynx->pcs.poll = true;
> @@ -360,32 +364,64 @@ static struct phylink_pcs *lynx_pcs_create(struct mdio_device *mdio)
>  	for (i = 0; i < ARRAY_SIZE(lynx_interfaces); i++)
>  		__set_bit(lynx_interfaces[i], lynx->pcs.supported_interfaces);
>  
> -	return lynx_to_phylink_pcs(lynx);
> +	ret = devm_pcs_register(dev, &lynx->pcs);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "could not register PCS\n");
> +	dev_info(dev, "probed\n");
> +	return 0;
>  }
>  
> -struct phylink_pcs *lynx_pcs_create_mdiodev(struct mii_bus *bus, int addr)
> +static const struct of_device_id lynx_pcs_of_match[] = {
> +	{ .compatible = "fsl,lynx-pcs" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lynx_pcs_of_match);
> +
> +static struct mdio_driver lynx_pcs_driver = {
> +	.probe = lynx_pcs_probe,
> +	.mdiodrv.driver = {
> +		.name = "lynx-pcs",
> +		.of_match_table = of_match_ptr(lynx_pcs_of_match),
> +	},
> +};
> +mdio_module_driver(lynx_pcs_driver);
> +
> +struct phylink_pcs *lynx_pcs_create_mdiodev(struct device *dev,
> +					    struct mii_bus *bus, int addr)
>  {
>  	struct mdio_device *mdio;
>  	struct phylink_pcs *pcs;
> +	int err;
>  
>  	mdio = mdio_device_create(bus, addr);
>  	if (IS_ERR(mdio))
>  		return ERR_CAST(mdio);
>  
> -	pcs = lynx_pcs_create(mdio);
> -
> -	/* lynx_create() has taken a refcount on the mdiodev if it was
> -	 * successful. If lynx_create() fails, this will free the mdio
> -	 * device here. In any case, we don't need to hold our reference
> -	 * anymore, and putting it here will allow mdio_device_put() in
> -	 * lynx_destroy() to automatically free the mdio device.
> -	 */
> -	mdio_device_put(mdio);
> +	mdio->bus_match = mdio_device_bus_match;
> +	strscpy(mdio->modalias, "lynx-pcs");
> +	err = mdio_device_register(mdio);
> +	if (err) {
> +		mdio_device_free(mdio);
> +		return ERR_PTR(err);
> +	}
>  
> +	pcs = pcs_get_by_dev(dev, &mdio->dev);
> +	mdio_device_free(mdio);
>  	return pcs;
>  }
>  EXPORT_SYMBOL(lynx_pcs_create_mdiodev);
>  
> +static int lynx_pcs_fixup(struct of_changeset *ocs,
> +			  struct device_node *np, void *data)
> +{
> +#ifdef CONFIG_OF_DYNAMIC
> +	return of_changeset_add_prop_string(ocs, np, "compatible",
> +					    "fsl,lynx-pcs");
> +#else
> +	return -ENODEV;
> +#endif
> +}
> +
>  /*
>   * lynx_pcs_create_fwnode() creates a lynx PCS instance from the fwnode
>   * device indicated by node.
> @@ -396,40 +432,12 @@ EXPORT_SYMBOL(lynx_pcs_create_mdiodev);
>   *  -ENOMEM if we fail to allocate memory
>   *  pointer to a phylink_pcs on success
>   */
> -struct phylink_pcs *lynx_pcs_create_fwnode(struct fwnode_handle *node)
> +struct phylink_pcs *lynx_pcs_create_fwnode(struct device *dev,
> +					   struct fwnode_handle *node)
>  {
> -	struct mdio_device *mdio;
> -	struct phylink_pcs *pcs;
> -
> -	if (!fwnode_device_is_available(node))
> -		return ERR_PTR(-ENODEV);
> -
> -	mdio = fwnode_mdio_find_device(node);
> -	if (!mdio)
> -		return ERR_PTR(-EPROBE_DEFER);
> -
> -	pcs = lynx_pcs_create(mdio);
> -
> -	/* lynx_create() has taken a refcount on the mdiodev if it was
> -	 * successful. If lynx_create() fails, this will free the mdio
> -	 * device here. In any case, we don't need to hold our reference
> -	 * anymore, and putting it here will allow mdio_device_put() in
> -	 * lynx_destroy() to automatically free the mdio device.
> -	 */
> -	mdio_device_put(mdio);
> -
> -	return pcs;
> +	return pcs_get_by_fwnode_compat(dev, node, lynx_pcs_fixup, NULL);
>  }
>  EXPORT_SYMBOL_GPL(lynx_pcs_create_fwnode);
>  
> -void lynx_pcs_destroy(struct phylink_pcs *pcs)
> -{
> -	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);
> -
> -	mdio_device_put(lynx->mdio);
> -	kfree(lynx);
> -}
> -EXPORT_SYMBOL(lynx_pcs_destroy);
> -
> -MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
> -MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION("NXP Lynx PCS phylink driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/pcs-lynx.h b/include/linux/pcs-lynx.h
> index 7958cccd16f2..a95801337205 100644
> --- a/include/linux/pcs-lynx.h
> +++ b/include/linux/pcs-lynx.h
> @@ -6,12 +6,13 @@
>  #ifndef __LINUX_PCS_LYNX_H
>  #define __LINUX_PCS_LYNX_H
>  
> -#include <linux/mdio.h>
> -#include <linux/phylink.h>
> +struct device;
> +struct mii_bus;
> +struct phylink_pcs;
>  
> -struct phylink_pcs *lynx_pcs_create_mdiodev(struct mii_bus *bus, int addr);
> -struct phylink_pcs *lynx_pcs_create_fwnode(struct fwnode_handle *node);
> -
> -void lynx_pcs_destroy(struct phylink_pcs *pcs);
> +struct phylink_pcs *lynx_pcs_create_mdiodev(struct device *dev,
> +					    struct mii_bus *bus, int addr);
> +struct phylink_pcs *lynx_pcs_create_fwnode(struct device *dev,
> +					   struct fwnode_handle *node);
>  
>  #endif /* __LINUX_PCS_LYNX_H */


