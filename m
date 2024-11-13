Return-Path: <netdev+bounces-144596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F759C7DD9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF93BB25019
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3C18BB88;
	Wed, 13 Nov 2024 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqlbkYUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8401632FD;
	Wed, 13 Nov 2024 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534523; cv=none; b=lhhfu+S8pF4dMUadmQybOcLiyPZV2yZsX9DieJE0yvpv/lhWG1AXwreE5HLAV8QtB560WjLSTq3MtMVl7706YWloqt7uIusGFGTfKJAxgkJB/lMQAmZc+AA01fie9Mtm2G8KZraCBdxAZ32J/vyAR0erS2z7iHC1DxG7PPDnc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534523; c=relaxed/simple;
	bh=G1pW8RMgvayO+g+nNxh25Yv5VYx54o5OzkuOXLhk8aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+PXYnMrOli8RxqYsm0Dm0I4XtdEm8vvNiR1aPHoIc5A4jlJuEPmoDwMyMK7W1YVJXwgbTIE3pauFvazaf38T42ukdnX8Ub9yyKLwYkdXqEJF1dAT9hrCAoEP3nf0m4cNQYLlSPs7SH/3sX8DiMh87jeL3tUOsvJR8O4baDqMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqlbkYUS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43152b79d25so62155525e9.1;
        Wed, 13 Nov 2024 13:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731534520; x=1732139320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMBQ0m5kkXEHoCVQTc08uTx25ys042yRR7+hzveSg4Y=;
        b=CqlbkYUSEdX/3zeOSOujAmW6Ct3vH9XfcXBcdVR0wakymidG+KYrYIhfCJd7gCg5Cu
         mgPvnJVNWyVA1EVRUYM3+/13H5aOq45qXiaCsOGrt5aXoDET5Ql9UQQri3yx5tbC8ltX
         8srXsl2d4vcw0WsQOkyTbilVOzja705qsiYAWIDQO9fQxs3/wYO+xVgdp8PYtjo7LrtO
         6gEzGXxCQ5aJeBh3hj5m+Id/j0sVxDZ1bd9oLdCkcWpOHKPQio396xFyuVRn3PGVWGbF
         Njjx58fJgxYHC82wT1mrQibQ706qn+s7qsm+n320fJBS8h+hs51A5IrifEEFb+qm6WL4
         kbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731534520; x=1732139320;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMBQ0m5kkXEHoCVQTc08uTx25ys042yRR7+hzveSg4Y=;
        b=oBX25lueYcteUDQi8dgsNiy74GT7y1sTQf6CjRllk/51sGxNxmDTTT5lx+QBTLWMql
         /2Gm2lWHr2yqAOIt4mUDXrIbdz+S+HUk4SAkxDy0mfhZVDD3ovTiv90vKrDcqrocn6xu
         2qjcTLYBaPOGMckFGVGYtPjk5bPJGQlDq2LqRXxc1239P1ay/IP3ll3z7vlSGbtL8tBl
         Y2YU6pCZcEwy8XYa5YIKYQ7/mxGfxZhC+fqzESc2H5F/kkIBQbSt/dvSt2PUMzXbGSW8
         1waXGU4/rgFVJfAd5wdWqBQNV+iJU7QugDltsJVGPNxSePanH8PGe7tGNZ2HmDAU2bWm
         0Tkg==
X-Forwarded-Encrypted: i=1; AJvYcCWOuhLmALZCi903uy7RIViiGfdug/TDvblwAilkTfAYJJJFk6GagTdDm64vCwW3f4dEdUFpKysUrHZ4ERU=@vger.kernel.org, AJvYcCXFkKJHgi3ljVOpRv5y36U2BwgSWopP5ahBd67xJ+0qhYRZyA/JofamSUZspjfjPfhCEmBuYVe3@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJxbY8oSLbahjUwOkPBKs2klrHB1x765V0c/Gh4U15byNNyUy
	uakTLkQMec+gZgZKVFKKX79WKzLw2wO7oHMw9Q/HR9O+TO4b0Tf1
X-Google-Smtp-Source: AGHT+IF7IA2PJ6jEa2ayjriGxpiOGm/okZs4V0FnTFkzwl6CmZTJ3E2MG9UnN4DPJYwhj4gWZnioiw==
X-Received: by 2002:a5d:47ac:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-3820df6136cmr3727419f8f.22.1731534519604;
        Wed, 13 Nov 2024 13:48:39 -0800 (PST)
Received: from ?IPV6:2a02:3100:b00a:5a00:ad7b:78f2:9ae0:4ed8? (dynamic-2a02-3100-b00a-5a00-ad7b-78f2-9ae0-4ed8.310.pool.telefonica.de. [2a02:3100:b00a:5a00:ad7b:78f2:9ae0:4ed8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf6926ad39sm970199a12.60.2024.11.13.13.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 13:48:38 -0800 (PST)
Message-ID: <392105cb-3f73-4765-a702-7cce0c6ac62c@gmail.com>
Date: Wed, 13 Nov 2024 22:48:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to update
 eee_cfg values
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
 <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
 <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
 <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13.11.2024 11:10, Choong Yong Liang wrote:
> 
> 
> On 12/11/2024 9:04 pm, Andrew Lunn wrote:
>> On Tue, Nov 12, 2024 at 12:03:15PM +0100, Heiner Kallweit wrote:
>>> In stmmac_ethtool_op_get_eee() you have the following:
>>>
>>> edata->tx_lpi_timer = priv->tx_lpi_timer;
>>> edata->tx_lpi_enabled = priv->tx_lpi_enabled;
>>> return phylink_ethtool_get_eee(priv->phylink, edata);
>>>
>>> You have to call phylink_ethtool_get_eee() first, otherwise the manually
>>> set values will be overridden. However setting tx_lpi_enabled shouldn't
>>> be needed if you respect phydev->enable_tx_lpi.
>>
>> I agree with Heiner here, this sounds like a bug somewhere, not
>> something which needs new code in phylib. Lets understand why it gives
>> the wrong results.
>>
>>     Andrew
> Hi Russell, Andrew, and Heiner, thanks a lot for your valuable feedback.
> 
> The current implementation of the 'ethtool --show-eee' command heavily relies on the phy_ethtool_get_eee() in phy.c. The eeecfg values are set by the 'ethtool --set-eee' command and the phy_support_eee() during the initial state. The phy_ethtool_get_eee() calls eeecfg_to_eee(), which returns the eeecfg containing tx_lpi_timer, tx_lpi_enabled, and eee_enable for the 'ethtool --show-eee' command.
> 
"relies on" may be the wrong term here. There's an API definition,
and phy_ethtool_get_eee() takes care of the PHY-related kernel part,
provided that the MAC driver uses phylib.
I say "PHY-related part", because tx_lpi_timer is something relevant
for the MAC only. Therefore phylib stores the master config timer value
only, not the actual value.
The MAC driver should populate tx_lpi_timer in the get_eee() callback,
in addition to what phy_ethtool_get_eee() populates.
This may result in the master config value being overwritten with actual
value in cases where the MAC doesn't support the master config value.

One (maybe there are more) special case of tx_lpi_timer handling is
Realtek chips, as they store the LPI timer in bytes. Means whenever
the link speed changes, the actual timer value also changes implicitly.

Few values exist twice: As a master config value, and as status.
struct phy_device has the status values:
@eee_enabled: Flag indicating whether the EEE feature is enabled
@enable_tx_lpi: When True, MAC should transmit LPI to PHY

And master config values are in struct eee_cfg:

struct eee_config {
	u32 tx_lpi_timer;
	bool tx_lpi_enabled;
	bool eee_enabled;
};

And yes, it may be a little misleading that eee_enabled exists twice,
you have to be careful which one you're referring to.

ethtool handles the master config values, only "active" is a status
information.

So the MAC driver should:
- provide a link change handler in e.g. phy_connect_direct()
- this handler should:
  - use phydev->enable_tx_lpi to set whether MAC transmits LPI or not
  - use phydev->eee_cfg.tx_lpi_timer to set the timer (if the config
    value is set)

Important note:
This describes how MAC drivers *should* behave. Some don't get it right.
So part of your confusion may be caused by misbehaving MAC drivers.
One example of a MAC driver bug is what I wrote earlier about 
stmmac_ethtool_op_get_eee().

And what I write here refers to plain phylib, I don't cover phylink as
additional layer.


> The tx_lpi_timer and tx_lpi_enabled values stored in the MAC or PHY driver are not retrieved by the 'ethtool --show-eee' command.
> 
> Currently, we are facing 3 issues:
> 1. When we boot up our system and do not issue the 'ethtool --set-eee' command, and then directly issue the 'ethtool --show-eee' command, it always shows that EEE is disabled due to the eeecfg values not being set. However, in the Maxliner GPY PHY, the driver EEE is enabled. If we try to disable EEE, nothing happens because the eeecfg matches the setting required to disable EEE in ethnl_set_eee(). The phy_support_eee() was introduced to set the initial values to enable eee_enabled and tx_lpi_enabled. This would allow 'ethtool --show-eee' to show that EEE is enabled during the initial state. However, the Marvell PHY is designed to have hardware disabled EEE during the initial state. Users are required to use Ethtool to enable the EEE. phy_support_eee() does not show the correct for Marvell PHY.
> 
> 2. The 'ethtool --show-eee' command does not display the correct status, even if the link is down or the speed changes to one that does not support EEE.
> 
> 3. The tx_lpi_timer in 'ethtool --show-eee' always shows 0 if we have not used 'ethtool --set-eee' to set the values, even though the driver sets different values.
> 
> I appreciate Russell's point that eee_enabled is a user configuration bit, not a status bit. However, I am curious if tx_lpi_timer, tx_lpi_enabled, and other fields are also considered configuration bits.
> 
> According to the ethtool man page:
> --show-eee
> Queries the specified network device for its support of Energy-Efficient Ethernet (according to the IEEE 802.3az specifications)
> 
> It does not specify which fields are configuration bits and which are status bits.


