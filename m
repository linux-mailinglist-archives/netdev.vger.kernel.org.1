Return-Path: <netdev+bounces-98818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B74518D28D9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7351F24BB3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00713D880;
	Tue, 28 May 2024 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrGSYBqf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473722089
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940123; cv=none; b=Ejrt129NyI3PxHaeLlhWByQBQ+PhrnTicDDxMU9W6tRNXEDL1N9wFG/b7I7QiLeMIiLIKwn3LYT5V1Y9K6YEXuoQpmVK+w4Jm00J8qDRXsm0DFIM0x1SAz3A5Dan91msxeN+efY/ToMuaXYt6a5Cehra7ThofMKNAZUIlsu3kHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940123; c=relaxed/simple;
	bh=I6SoYR0m5piLu7nhQTpbFxRXhfTDYkB5dml6u5IicMY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=boy6aw+adwwy1z/BKf4JRgFbEDdbr67cBmOEdn3GOyi8adU79TzqQas5uBROYsQU6uvz049HB8yeR/hTgwsVNn+x3COmZ+fw1H/lgQ+A9ZqpUq5EkTrdx68XxMw+5+eWYxusFZI8GWXWzxF0IzxXyqOOIabYsTKuNfdjIaW5VKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrGSYBqf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2bdd6b73a3aso248481a91.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716940121; x=1717544921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghE40Sk0xeRmLlvwXNd5FCcjWOm+Q5WpSsRYEynwTe0=;
        b=HrGSYBqfXgTRBHI7phXLMd/OVpX1TygCLOciTle8dvJ54cR94RntqMhq8u/HsvaDd2
         GnboVQ4OPM7I/H9ry6++vT59clZoSwxI8KKnL+SBcIw2qyPcqUdKXQwE/eLadTNMHWRO
         fF/eBBdUzVPuOOVKBiTtHipKvSuSgglsgE6CuplpEOEvLAlUxELtQ99AGfZz8Ft6+EKI
         XbIQ3xWx2V2L5zggiOE7r8SMp4PQFtwTzQphZOjbk1s1QNkOxQivjqw7xOLERmHrrCFw
         E5QhtrQk5xNKCCpxyoFqI6zEIVf1I9sWFvrC1SP4R2ZQ+zDS20FKQNy9S+0+xXQAHC0B
         XyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716940121; x=1717544921;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghE40Sk0xeRmLlvwXNd5FCcjWOm+Q5WpSsRYEynwTe0=;
        b=DxaTQtbj/SG9GXfBINS1NAYXQWghyqDUMHHnwIZLP+zGMfQItQftWJer9bNyIMeFHm
         Iqrh/Ra7IIPVwOnVPaAtDffX1UE/0hpddLMtJmAz6zpDTZ8qDcyrq8/j8SIcffBPL7g4
         WEVId+rQddSzKFxjDnO6eYybyL2x+lzdYfVxzbsl0/ZAtRqHh3XdDoD/XDOrsUrBlJAy
         Xn3tEQl95udchCcir1brnBEwxhgwAhDbEKS239XUj91BzSm6/2Kl04LKvk5jAf6iEb4Q
         bh3vXs4DsUYj4lCR4498vaLXXps7RdERLCbXWlamg4/dJMXjgh2Z93Iovnkpm8de4e24
         Ut1g==
X-Forwarded-Encrypted: i=1; AJvYcCXtNcQvGGC+5EPwDuxVzIHJsEuwSzFIPFA8XR/OeJQjNSyhKlJ1wPBdsbsCOotz8oPAhNbF8XUvTwWSiBXGsECXRFXwFn11
X-Gm-Message-State: AOJu0YyEU/qjsTEGnLAekOpIHTC58pJSDw6ulPS9im7/7zbftI20ACz/
	iAFBrIqYA3io0gDA1ys9uVBZGsncfOhhICEhmZ7JIrhfqgvf16/m
X-Google-Smtp-Source: AGHT+IEhalebMbhBGjSihT0FzkiXHYlB4pByz67vBlaGRghZoH8v/D9onCl87Icaij/VR2RD9Z3low==
X-Received: by 2002:a05:6a20:da87:b0:1af:5385:3aff with SMTP id adf61e73a8af0-1b212e144c7mr17383571637.3.1716940121092;
        Tue, 28 May 2024 16:48:41 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701c32ad271sm1815221b3a.12.2024.05.28.16.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:48:40 -0700 (PDT)
Date: Wed, 29 May 2024 08:48:26 +0900 (JST)
Message-Id: <20240529.084826.1300161327983399018.fujita.tomonori@gmail.com>
To: linux@armlinux.org.uk
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v7 6/6] net: tn40xx: add phylink support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZlXH4nl89Z8P3jA5@shell.armlinux.org.uk>
References: <20240527203928.38206-1-fujita.tomonori@gmail.com>
	<20240527203928.38206-7-fujita.tomonori@gmail.com>
	<ZlXH4nl89Z8P3jA5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
Thanks for reviewing the patch!

On Tue, 28 May 2024 13:02:42 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, May 28, 2024 at 05:39:28AM +0900, FUJITA Tomonori wrote:
>> This patch adds supports for multiple PHY hardware with phylink. The
>> adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
>> TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.
>> 
>> For now, the PCI ID table of this driver enables adapters using only
>> QT2025 PHY. I've tested this driver and the QT2025 PHY driver (SFP+
>> 10G SR) with Edimax EN-9320 10G adapter.
>> 
> i> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> A few comments - I don't recall seeing previous versions of these
> patches, despite it being at version 7.

Sorry, my bad. The first version doesn't use phylink. I should have
added you to the CC list when I changed the driver to use phylink over
phylib according to Andrew's comment.

To provide some background, a vendor released this driver but it
hasn't been merged into the tree. The vendor went out of
bushiness. I'm trying to get the original driver to be mainline
quality. I don't have hardware spec doc.


>> @@ -1082,6 +1083,10 @@ static void tn40_link_changed(struct tn40_priv *priv)
>>  				 TN40_REG_MAC_LNK_STAT) & TN40_MAC_LINK_STAT;
>>  
>>  	netdev_dbg(priv->ndev, "link changed %u\n", link);
>> +	if (link)
>> +		phylink_mac_change(priv->phylink, true);
>> +	else
>> +		phylink_mac_change(priv->phylink, false);
> 
> This is only useful if you have a PCS, and I don't see anything in the
> driver that suggests you do. What link is this referring to?

When I plug the fiber, the above function is triggered with the link
on. With the fiber unplugged, the function is called with the link
off.

The original driver resets the MAC when the link is down. It
configures the MAC according to the cable speed (seems the original
driver is tested with only 10G though).


> In any case, you could eliminate the if() and just pass !!link if it's
> not already boolean in nature (the if() suggests it is, so passing just
> "link" would also work.)

Oops, right.


>> @@ -1381,10 +1389,17 @@ static int tn40_open(struct net_device *dev)
>>  	struct tn40_priv *priv = netdev_priv(dev);
>>  	int ret;
>>  
>> +	ret = phylink_connect_phy(priv->phylink, priv->phydev);
>> +	if (ret)
>> +		return ret;
>> +
>>  	tn40_sw_reset(priv);
>> +	phylink_start(priv->phylink);
> 
> At this point, the link could have come up (mac_link_up() could well
> be called.) Is the driver prepared to cope with that happening right
> _now_ in the tn40_open sequence? If not, you will need to move this
> to a point where the driver is ready to begin operation.

Understood, I'll change the order.


> phylink_stop() is its opposite, and you need to call that at the
> point where you want the link to be taken down (iow, where you want
> .mac_link_down() to be guaranteed to have been called if the link
> was already up.)

I see. The usage of phylink_stop() looks fine.


>> @@ -143,6 +143,9 @@ struct tn40_priv {
>>  	char *b0_va; /* Virtual address of buffer */
>>  
>>  	struct mii_bus *mdio;
>> +	struct phy_device *phydev;
>> +	struct phylink *phylink;
>> +	struct phylink_config phylink_config;
> 
> So phylink_config is embedded in tn40_priv - that's fine. What this does
> mean is you can trivially go from the phylink_config pointer to a
> pointer to tn40_priv *without* multiple dereferences:
> 
> static inline struct tn40_priv *
> config_to_tn40_priv(struct phylink_config *config)
> {
> 	return container_of(config, struct tn40_priv, phylink_config);
> }

I'll update the code.

>> +static void tn40_link_up(struct phylink_config *config, struct phy_device *phy,
>> +			 unsigned int mode, phy_interface_t interface,
>> +			 int speed, int duplex, bool tx_pause, bool rx_pause)
>> +{
>> +	struct net_device *ndev = to_net_dev(config->dev);
>> +	struct tn40_priv *priv = netdev_priv(ndev);
>> +
>> +	tn40_set_link_speed(priv, speed);
>> +	netif_wake_queue(priv->ndev);
>> +}
>> +
>> +static void tn40_link_down(struct phylink_config *config, unsigned int mode,
>> +			   phy_interface_t interface)
>> +{
>> +	struct net_device *ndev = to_net_dev(config->dev);
>> +	struct tn40_priv *priv = netdev_priv(ndev);
>> +
>> +	tn40_set_link_speed(priv, 0);
>> +	netif_stop_queue(priv->ndev);
> 
> Shouldn't the queue be stopped first?

Indeed, I'll fix.

>> +}
>> +
>> +static void tn40_mac_config(struct phylink_config *config, unsigned int mode,
>> +			    const struct phylink_link_state *state)
>> +{
>> +}
> 
> Nothing needs to be done here?

Seems that nothing is necessary here.

When I try something like 1G SFP or BASE-T in the future, I might find
something.

>> +
>> +static const struct phylink_mac_ops tn40_mac_ops = {
>> +	.mac_config = tn40_mac_config,
>> +	.mac_link_up = tn40_link_up,
>> +	.mac_link_down = tn40_link_down,
>> +};
>> +
>> +int tn40_phy_register(struct tn40_priv *priv)
>> +{
>> +	struct phylink_config *config;
>> +	struct phy_device *phydev;
>> +	struct phylink *phylink;
>> +
>> +	phydev = phy_find_first(priv->mdio);
>> +	if (!phydev) {
>> +		dev_err(&priv->pdev->dev, "PHY isn't found\n");
>> +		return -1;
>> +	}
>> +
>> +	config = &priv->phylink_config;
>> +	config->dev = &priv->ndev->dev;
>> +	config->type = PHYLINK_NETDEV;
>> +	config->mac_capabilities = MAC_10000FD | MLO_AN_PHY;
> 
> MLO_AN_PHY is not a MAC capability, it shouldn't be here.

I don't know why I use MLO_AN_PHY here. I thought that I tried to
imitate wangxun driver but I can't find. I'll drop it in the next
version.

Thanks a lot!

