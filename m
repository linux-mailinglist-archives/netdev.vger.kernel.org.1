Return-Path: <netdev+bounces-146848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D89D64DF
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EA7161802
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5015F40B;
	Fri, 22 Nov 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHI71AGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DA1CA9C
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307290; cv=none; b=MOGCx61bx6EwmYl3YrvEmZwjYJMGtSkTsOWMfdRxLIxwe3gJMrccVLCbWU62uemMbU5beThtkrmPR0PDIuY/WcR1ajSdK30lcoB0nkXsWOvwgDKpAUXap70qxZOkExf6nTSPuM/l5LzgunLTeYIvoC0S5/J4kU865nW58TZ/IIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307290; c=relaxed/simple;
	bh=AYP7Q+8xyhKsgGdnNBF3cR9RQpMLYQgEC2KZmyRvo4s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SUzPxo0jHttME2Fhxf5obWZhvJEhVjb6OaBX33HgIJv6uxKKN0TY3qHuKWKPCwk6YTIWnG0GagiQ4JDKQkEyM1CL1fAW2OOE7bG/8wFOmwZaL0oM7GhfPk6rRpJXMDoVhI8GgR1cmXtkBc4PDmIZHeuYkdYeoDjtXFkDJdggwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHI71AGf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d036963a6eso70796a12.3
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 12:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307287; x=1732912087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b0UeWwRZTTiCu0IjkqjrRJHW32YdupkbJ7ks/Q+pn+M=;
        b=dHI71AGfS9bS0qerzlnG/cLCBU3PtJVE1kRK8bFPeOcUrfigTB0eaz3YiJVQ/q3wJj
         CrSfLllkzVRlRk1gCQu14I5yJrMtHEAjnPyoZQiHgAV1ukI34LaXn/GAG7j/fgD9V3jm
         n7uJdYA280wpdxavU5j4KN85fjGlIl6bbega5fq2LySsZCFEuXJtD2KC01HPtLKw4JOD
         HVEVgOWA65I9Uys/OWDLhby2ct+P5Z+iA5qFybF8lBBkCsF/Ic+l7wfFe9DE33zyd8hl
         0Bc8D0I7yuCKRYKiEmXZo0MHApK5mFC3YUQrk6jZN1962RsnQUGnJluaPoQRUe2MdFqR
         KcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307287; x=1732912087;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0UeWwRZTTiCu0IjkqjrRJHW32YdupkbJ7ks/Q+pn+M=;
        b=ri3I9I+d8J6swvuyr7yX1zIC/VSVCLJc4NI58LmYb8qoi5VoSYmxDbp4VIFdQzrlh2
         HrTZ6ObF+vMbi6vhOpe84DCncN4eUw4k5F8vAMI+XghazO7bWmFTeMtWsQ9h/KfPUkpY
         egfTcmktjRZVoIGf6ZFiTwc8AttnDj/a3ly1hxFqOMDU58Z2n3fWM0pmSFWmGZuMJhpk
         orrgQxG36GfDcqNf65qUzq4icLxDkkarJZgWvhH/4lJ9wXGn3KAj9WvTRznSRkwaR7Qt
         S+IB25xOhM31R8LjRSU0RcZi8CLzTBQ1qpndUBxQvOjqZklTcFdpCeAKVlepVE6mWFwf
         VP2A==
X-Forwarded-Encrypted: i=1; AJvYcCV3NJ2mmiKMbfQu9jx67YXiIZjtYepvRUjz4fOwG+Vc/xsjG/xFMuNrka1HdKdoI30JH773DKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzswzEElv6sMN9tvLbUZ6/DVDYOUhlrYAKZHw1wDZva8BN4IPEF
	CcuXgqOK6FGZ3yfKFwoQlADesH9BRf/LPgehhmqTqXywaQcOZz53
X-Gm-Gg: ASbGncuKKf22GfKmUMbGU4W6+Q6fGG87wxj+ZHtSKQs/Asy3lz0poc1b89/hbrJdKgJ
	l/jr4OYloxPuiXLu0f3i/9OF24YILKgl/qKnTibD6iPZBIIi5wFlNWvGg6gLuS4YB45HOeMy1iY
	1621c6SVnsFRRECG0Cv52I5KYo1Kz2L9yBihx6dy4EcY4qidazToX6mAJu2wRDDy6s6KMLAqPJb
	Dojy7bot+uFhLd+UEUlhIN3+yYl/lJ6RYFkGVezlkJl01J3bYmFTYr61AnGtHCfbqXj8ZOsBksv
	aAY4thygJ+8FH1pNjXsHTPFFoaQOKQkHWlgWlhyES9sTXV5dSeRNujB/ingZ6CKoq4qwnOIt06o
	KwD1iDi54+P0wwzxtxUIeh5E5h8UIsQHAy2zbv6vZDg==
X-Google-Smtp-Source: AGHT+IGcSPCadlmuuPzyDSvMmmvaVoKnPcpECgYXsOUvhUKqdOSYOxqXmyoFkGt5FsAzZ9l2rh+9aQ==
X-Received: by 2002:a17:906:cc47:b0:aa4:7905:b823 with SMTP id a640c23a62f3a-aa509a086f5mr355324766b.32.1732307286552;
        Fri, 22 Nov 2024 12:28:06 -0800 (PST)
Received: from ?IPV6:2a02:3100:a006:e900:3c67:b590:8a92:868e? (dynamic-2a02-3100-a006-e900-3c67-b590-8a92-868e.310.pool.telefonica.de. [2a02:3100:a006:e900:3c67:b590:8a92:868e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa50b57cbfasm136594566b.162.2024.11.22.12.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 12:28:05 -0800 (PST)
Message-ID: <77732422-1675-4e64-a6e5-42e21f2a2caa@gmail.com>
Date: Fri, 22 Nov 2024 21:28:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
From: Heiner Kallweit <hkallweit1@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <E1tESfx-004evI-NH@rmk-PC.armlinux.org.uk>
 <f430fb95-362d-4436-8b33-0eebc15333a8@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <f430fb95-362d-4436-8b33-0eebc15333a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.11.2024 21:04, Heiner Kallweit wrote:
> On 22.11.2024 13:22, Russell King (Oracle) wrote:
>> ---
>>  drivers/net/phy/phy-c45.c |  2 +-
>>  drivers/net/phy/phy.c     | 32 ++++++++++++++++++--------------
>>  include/linux/phy.h       |  1 +
>>  3 files changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
>> index 96d0b3a5a9d3..944ae98ad110 100644
>> --- a/drivers/net/phy/phy-c45.c
>> +++ b/drivers/net/phy/phy-c45.c
>> @@ -1530,7 +1530,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
>>  		return ret;
>>  
>>  	data->eee_enabled = is_enabled;
>> -	data->eee_active = ret;
>> +	data->eee_active = phydev->eee_active;
>>  	linkmode_copy(data->supported, phydev->supported_eee);
>>  
>>  	return 0;
>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>> index 4f3e742907cb..e174107b96e2 100644
>> --- a/drivers/net/phy/phy.c
>> +++ b/drivers/net/phy/phy.c
>> @@ -990,14 +990,14 @@ static int phy_check_link_status(struct phy_device *phydev)
>>  		phydev->state = PHY_RUNNING;
>>  		err = genphy_c45_eee_is_active(phydev,
>>  					       NULL, NULL, NULL);
>> -		if (err <= 0)
>> -			phydev->enable_tx_lpi = false;
>> -		else
>> -			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
>> +		phydev->eee_active = err > 0;
>> +		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
>> +					phydev->eee_active;
>>  
>>  		phy_link_up(phydev);
>>  	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
>>  		phydev->state = PHY_NOLINK;
>> +		phydev->eee_active = false;
>>  		phydev->enable_tx_lpi = false;
>>  		phy_link_down(phydev);
>>  	}
>> @@ -1685,16 +1685,20 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
>>  static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
>>  				      struct ethtool_keee *data)
>>  {
>> -	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
>> -	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
>> -		eee_to_eeecfg(&phydev->eee_cfg, data);
>> -		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
>> -		if (phydev->link) {
>> -			phydev->link = false;
>> -			phy_link_down(phydev);
>> -			phydev->link = true;
>> -			phy_link_up(phydev);
>> -		}
>> +	bool enable_tx_lpi = data->tx_lpi_enabled &&
>> +			     phydev->eee_active;
>> +
>> +	eee_to_eeecfg(&phydev->eee_cfg, data);
>> +
>> +	if ((phydev->enable_tx_lpi != enable_tx_lpi ||
>> +	     phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) &&
>> +	    phydev->link) {
>> +		phydev->enable_tx_lpi = false;
>> +		phydev->link = false;
>> +		phy_link_down(phydev);
>> +		phydev->enable_tx_lpi = enable_tx_lpi;
>> +		phydev->link = true;
>> +		phy_link_up(phydev);
> 
> This part collides with a pending patch:
> https://patchwork.kernel.org/project/netdevbpf/patch/a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com/
> I think you have to rebase and resubmit once the pending patch has been applied.
> 

Merge of both changes should result in something like this:

static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
                                      const struct eee_config *old_cfg)
{
        bool enable_tx_lpi;

        if (!phydev->link)
                return;

        enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled && phydev->eee_active;

        if (enable_tx_lpi != old_cfg->tx_lpi_enabled ||
            phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
                phydev->enable_tx_lpi = false;
                phydev->link = false;
                phy_link_down(phydev);
                phydev->enable_tx_lpi = enable_tx_lpi;
                phydev->link = true;
                phy_link_up(phydev);
        }
}


