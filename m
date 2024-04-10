Return-Path: <netdev+bounces-86689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC43289FF1A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1769B24D68
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C3181CF2;
	Wed, 10 Apr 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H5HP2zPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB85181CEE
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771314; cv=none; b=CWC9sd/RSln6ORTFj5jppJjE1TQWvQfceqzoVKT68PgO6snjp2e/PpTrJy0BXRIYSWWyjiXIQu0VO+7BWXjWYSHzelmspRXEQrIAQcInfIvNC9Ia1ZzMpe9U7HN1fy8A77DG/sIPe9f7Hsal/iF5tvBJ5IEsbzwn4bQZY/K5fE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771314; c=relaxed/simple;
	bh=TpFEpDu/6V3SwLxPe0MaIX12zswwZP/+vvzuV3XoEV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZDXeBltA0l4EKdf53X8rVfGJdbwNMHNMumWxzOuW4JM5VjoZqrI2g15QogS3Qj6r8SEaeGL7xLtF0rHjf7Fqzvl8+l/89aGFlYruprni8c/s8g8zX7LUxijmKWHqCuvD56NxkzsS3Mb73+glyZjhTIAhlO7bsJuUk3TOUGdJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H5HP2zPe; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78d555254b7so7118285a.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712771311; x=1713376111; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0Mq8gcS41ZQOFK0XwYxIr8ph50JC6SfRs5GTbp3d8Q=;
        b=H5HP2zPeDv2E2cqdJy2CFIFiwMdsw+0YhvRAtZqHUbVnJSNB8eVQDwZEg2Ty/3qLv4
         6IvzlP7zTNGIDdHopbvvAj07SdqR1d/xjUPO/wQVr8Rk2SphDIS6ZulmliDR2EGGb2W1
         H+gqoEYt1oQwtbynV3o9EfQJBPDp8z6gtjcGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771311; x=1713376111;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0Mq8gcS41ZQOFK0XwYxIr8ph50JC6SfRs5GTbp3d8Q=;
        b=LwGWPKyagZZYpmH/+FDQYCYiml4sBxNvBhDz2dcCmoV0bpKa9klBCusk4oslUTGsMG
         k2Pssg+qOh06mf23AvzN2ksmIZVuonhrFatSh90bzrZAG2xVF8NhqPXi75CkuvMB3+MU
         UMzsS891UFjD9P2v0smE7gJnF1fNhwarpY0xyEZiacywPmcp0aklqT/ENy9m4k0pykjM
         5jiTlHpU7hXjQk0KJePITJJbGePPq9WJU/LsfCLOjzMXGiPR1Jm+m9vSTZTob6FX6U1L
         Ei/bMIABrYsV6NBlnQdlEG/on+8B0rNr1e1ECX0Se1iuUbArZ3sZJXvqV/BaJ9KcLxGv
         b8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUa7vMUIxsaynZqWf5mFBm5YULHdhG7dHffjhZOFZ8iTDav9c3nhdgaLTqGT6Ib8cdyTpX43Dv/v3JMMWCJVpiibQqKqNx6
X-Gm-Message-State: AOJu0YwEIEcAOQ0uHZ1oKRg13q5z2Yp9oQ2zpu/QuEUgXGKw+kI1VsaV
	o3UyQ71T6HMH9+3p2pyEll5WeaLKSzkfLma7uowPEXUSsO3+i5Hg9AQttpL5fQ==
X-Google-Smtp-Source: AGHT+IH0L9wHu1DKqOmI5RHOKUFgErb3N4xY+RZ2e4Z6dPE3uVZuWkSPwHJD0HeorZ7kVy7Z8Hszcg==
X-Received: by 2002:a05:620a:318b:b0:78e:ba4f:fd18 with SMTP id bi11-20020a05620a318b00b0078eba4ffd18mr750272qkb.31.1712771310819;
        Wed, 10 Apr 2024 10:48:30 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a220400b0078d67886632sm3079858qkh.37.2024.04.10.10.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:48:30 -0700 (PDT)
Message-ID: <c2a16e3c-374c-4fd1-9ca7-bf0aeb5ed941@broadcom.com>
Date: Wed, 10 Apr 2024 10:48:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: genet: Fixup EEE
To: Andrew Lunn <andrew@lunn.ch>
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org
References: <20240408-stmmac-eee-v1-1-3d65d671c06b@lunn.ch>
 <4826747e-0dd5-4ab9-af02-9d17a1ab7358@broadcom.com>
 <67c0777f-f66e-4293-af8b-08e0c4ab0acc@lunn.ch>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <67c0777f-f66e-4293-af8b-08e0c4ab0acc@lunn.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000095c2c90615c1a55f"

--00000000000095c2c90615c1a55f
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 4/9/2024 2:37 PM, Andrew Lunn wrote:
> On Tue, Apr 09, 2024 at 01:41:43PM -0700, Florian Fainelli wrote:
>> On 4/8/24 17:54, Andrew Lunn wrote:
>>> The enabling/disabling of EEE in the MAC should happen as a result of
>>> auto negotiation. So move the enable/disable into bcmgenet_mii_setup()
>>> which gets called by phylib when there is a change in link status.
>>>
>>> bcmgenet_set_eee() now just writes the LPI timer value to the
>>> hardware.  Everything else is passed to phylib, so it can correctly
>>> setup the PHY.
>>>
>>> bcmgenet_get_eee() relies on phylib doing most of the work, the MAC
>>> driver just adds the LPI timer value from hardware.
>>>
>>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>>> ---
>>>    drivers/net/ethernet/broadcom/genet/bcmgenet.c | 26 ++++++--------------------
>>>    drivers/net/ethernet/broadcom/genet/bcmgenet.h |  6 +-----
>>>    drivers/net/ethernet/broadcom/genet/bcmmii.c   |  7 +------
>>>    3 files changed, 8 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>>> index b1f84b37032a..c090b519255a 100644
>>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>>> @@ -1272,13 +1272,14 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
>>>    	}
>>>    }
>>> -void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
>>> -			     bool tx_lpi_enabled)
>>> +void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
>>>    {
>>>    	struct bcmgenet_priv *priv = netdev_priv(dev);
>>> -	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
>>> +	u32 off;
>>>    	u32 reg;
>>> +	off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
>>> +
>>>    	if (enable && !priv->clk_eee_enabled) {
>>>    		clk_prepare_enable(priv->clk_eee);
>>>    		priv->clk_eee_enabled = true;
>>> @@ -1293,7 +1294,7 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
>>>    	/* Enable EEE and switch to a 27Mhz clock automatically */
>>>    	reg = bcmgenet_readl(priv->base + off);
>>> -	if (tx_lpi_enabled)
>>> +	if (enable)
>>>    		reg |= TBUF_EEE_EN | TBUF_PM_EN;
>>>    	else
>>>    		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
>>> @@ -1311,15 +1312,11 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
>>>    		clk_disable_unprepare(priv->clk_eee);
>>>    		priv->clk_eee_enabled = false;
>>>    	}
>>> -
>>> -	priv->eee.eee_enabled = enable;
>>> -	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
>>>    }
>>>    static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
>>>    {
>>>    	struct bcmgenet_priv *priv = netdev_priv(dev);
>>> -	struct ethtool_keee *p = &priv->eee;
>>>    	if (GENET_IS_V1(priv))
>>>    		return -EOPNOTSUPP;
>>> @@ -1327,7 +1324,6 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
>>>    	if (!dev->phydev)
>>>    		return -ENODEV;
>>> -	e->tx_lpi_enabled = p->tx_lpi_enabled;
>>>    	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
>>>    	return phy_ethtool_get_eee(dev->phydev, e);
>>> @@ -1336,8 +1332,6 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
>>>    static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
>>>    {
>>>    	struct bcmgenet_priv *priv = netdev_priv(dev);
>>> -	struct ethtool_keee *p = &priv->eee;
>>> -	bool active;
>>>    	if (GENET_IS_V1(priv))
>>>    		return -EOPNOTSUPP;
>>> @@ -1345,15 +1339,7 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
>>>    	if (!dev->phydev)
>>>    		return -ENODEV;
>>> -	p->eee_enabled = e->eee_enabled;
>>> -
>>> -	if (!p->eee_enabled) {
>>> -		bcmgenet_eee_enable_set(dev, false, false);
>>> -	} else {
>>> -		active = phy_init_eee(dev->phydev, false) >= 0;
>>> -		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
>>> -		bcmgenet_eee_enable_set(dev, active, e->tx_lpi_enabled);
>>> -	}
>>> +	bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
>>>    	return phy_ethtool_set_eee(dev->phydev, e);
>>>    }
>>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
>>> index 7523b60b3c1c..bb82ecb2e220 100644
>>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
>>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
>>> @@ -644,8 +644,6 @@ struct bcmgenet_priv {
>>>    	bool wol_active;
>>>    	struct bcmgenet_mib_counters mib;
>>> -
>>> -	struct ethtool_keee eee;
>>>    };
>>>    #define GENET_IO_MACRO(name, offset)					\
>>> @@ -703,7 +701,5 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
>>>    void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
>>>    			       enum bcmgenet_power_mode mode);
>>> -void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
>>> -			     bool tx_lpi_enabled);
>>> -
>>> +void bcmgenet_eee_enable_set(struct net_device *dev, bool enable);
>>>    #endif /* __BCMGENET_H__ */
>>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> index 9ada89355747..25eeea4c1965 100644
>>> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
>>> @@ -30,7 +30,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
>>>    	struct bcmgenet_priv *priv = netdev_priv(dev);
>>>    	struct phy_device *phydev = dev->phydev;
>>>    	u32 reg, cmd_bits = 0;
>>> -	bool active;
>>>    	/* speed */
>>>    	if (phydev->speed == SPEED_1000)
>>> @@ -88,11 +87,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
>>>    		reg |= CMD_TX_EN | CMD_RX_EN;
>>>    	}
>>>    	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
>>> -
>>> -	active = phy_init_eee(phydev, 0) >= 0;
>>> -	bcmgenet_eee_enable_set(dev,
>>> -				priv->eee.eee_enabled && active,
>>> -				priv->eee.tx_lpi_enabled);
>>
>> You can keep the call to bcmgenet_eee_enable_set() where it currently is and
>> just change the arguments?
> 
> Hi Florian
> 
> bcmgenet_eee_enable_set() configures the hardware. We should only call
> that once auto-neg has completed and the adjust_link callback is
> called. Or in the case EEE autoneg is disabled, phylib will
> artificially down/up the link in order to call the adjust_link
> callback.
> 
> bcmgenet_eee_enable_set() is currently called in bcmgenet_set_eee(),
> which is the .set_eee ethtool_op. So that is the wrong place to do
> this. That is what the last hunk in the patch does, it moves it to
> bcmgenet_mii_setup() which is passed to of_phy_connect() as the
> callback.
> 
> Or am i missing thing?

You are not, I was missing the two call sites for bcmgenet_mac_config() 
and indeed only the one in bcmgenet_mii_setup() is meaningful here.

I am seeing a functional difference with and without your patch however, 
and also, there appears to be something wrong within the bcmgenet driver 
after PHYLIB having absorbed the EEE configuration. Both cases we start 
on boot with:

# ethtool --show-eee eth0
EEE settings for eth0:
         EEE status: disabled
         Tx LPI: disabled
         Supported EEE link modes:  100baseT/Full
                                    1000baseT/Full
         Advertised EEE link modes:  100baseT/Full
                                     1000baseT/Full
         Link partner advertised EEE link modes:  100baseT/Full
                                                  1000baseT/Full

I would expect the EEE status to be enabled, that's how I remember it 
before. Now, with your patch, once I turn on EEE with:

# ethtool --set-eee eth0 eee on
# ethtool --show-eee eth0
EEE settings for eth0:
         EEE status: enabled - active
         Tx LPI: disabled
         Supported EEE link modes:  100baseT/Full
                                    1000baseT/Full
         Advertised EEE link modes:  100baseT/Full
                                     1000baseT/Full
         Link partner advertised EEE link modes:  100baseT/Full
                                                  1000baseT/Full
#

there is no change to the EEE_CTRL register to set the EEE_EN, this only 
happens when doing:

# ethtool --set-eee eth0 eee on tx-lpi on

which is consistent with the patch, but I don't think this is quite 
correct as I remembered that "eee on" meant enable EEE for the RX path, 
and "tx-lpi on" meant enable EEE for the TX path?
-- 
Florian

--00000000000095c2c90615c1a55f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQeQYJKoZIhvcNAQcCoIIQajCCEGYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3QMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJc5at+ONRafE/tm
vEMDaMd4RnOzJBLPk4HMQbauzo1dMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDQxMDE3NDgzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBj+n60H9kGeS1q/iO/Gwxq/noqPdHl79p9
yM2mGK7gLbkXLpQW3bh5cUmV1uhJegsb9Q5pYBHNjT8GCxe+c8zHHHxPQkVx8UhCEUguzRObfqBH
BDicK7KbsH61dw/gZG5px1w40PCdtFcZ9kyIN/gOEiGMRPIDies+wy2GqhSa+v64koKku6UHYK94
9rb5QFkLBQoSgeZemGWudgr5Ekrslw7BgmxS1V8wvnpe8b3S7iD/BUSXR7Dap6OzZR0Uk9bmIG63
KcWgZbr687jilcm1bPbHL12l2K++eFQArG6fxujmEEDiTCckTX/icacgR2maPIa96sxyA5gPW/rL
UoCp
--00000000000095c2c90615c1a55f--

