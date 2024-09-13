Return-Path: <netdev+bounces-128229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB74A9789EB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD03B20E4B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C498146D59;
	Fri, 13 Sep 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/80441E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8757C8D;
	Fri, 13 Sep 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259365; cv=none; b=TYNdP99/11uESeOMqTS275KmqqYcBmWqRLsRkALM3sFB6bKUu76V0m7rcUcJx1mTcEj7/kNlMUrzAyu+N2dNIuXOcx4gPLDpvJZ9QRm5imWQkf5z+l8Vk2erk0HOadX/H5LjKIMDvc5SgHY58gydDDnU2ovLiE4PW51bDksMYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259365; c=relaxed/simple;
	bh=Eraz0blgc4Pzkzc8lSujYmFedwYBhnjbjZ7Rod7oKS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgJeOnKMmfTrv0eZCnRWP1txY7i33O2bUN7Ksdnlm0BMNznjkLQmEhEJfEzPkjRM8IgazSEEDSf25rTrAnnB2gajrilPIUj2yOzTyewxKqYJt34AcTxEyRWn+hmF6sQmAmA/RMb+KwmJj04EwT7J6AOtFqCaA1gFq/NK2GD9Xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/80441E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb0d0311fso4061355e9.1;
        Fri, 13 Sep 2024 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726259362; x=1726864162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5xolFhNsDxZ0oUZ4unxP8L8jNHdIcN6NCApuBWLejIs=;
        b=M/80441EeAGcnV7CNET8qJRkn5HLcmndOWz3TZswntNWz1aqsjnehJ9Bd+t/tnN8ex
         3DsPJ1lvN8jdUD8LM5uk7KpvKQpxw6iG4RCKbuiaB28dUW3uH0MGPsM8uEKcuqhdmZVs
         llSP7nQhFwMJyPTrc+Jo+za/M/sDe5N39OpMWc5nhWjBia+7WZbE3F8tHcoNBrIRVCMl
         HVNgLG70YbY/ZJRkyFvtGGg+wTIcO8FqWiDh0GZx/Drbr4PMvFTaZesjvaXvqrhcDPxw
         WqcIAjn+zmjpJXpqYeaklUUvojiEHf0sEY7J2cNnhJ0CI1MNi52J6o9uFvTeTBOGdq/c
         CVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726259362; x=1726864162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xolFhNsDxZ0oUZ4unxP8L8jNHdIcN6NCApuBWLejIs=;
        b=p3CjFfAWkze3K05JMTGYDJALjdioup42vlkuujJ9QYWVwrkgHOCuTJUJIMUSlUtM7C
         +ca9xyJsyMEnZmeNjhZ01agj1CrSjSCUrRjDApVTdJ+YzKgJUv4d8HyZ+rBPKmwyYSKt
         U0suw9gOygGD4aqBYaiYEpVohinvFtfDADIHejW2LWQ03SIGbvBTCW/tl2qWszir3ZmH
         9oYeF1QWJWGj1XpGRUShcRE67FwxALDFq88JSIovWXThaEG7nUe8FVeytYgkijvNDj2p
         pExK1Vl7YqthoIQqc3oovuvBLiGNabcKgxMxrv7xtFYx8UB0JwG/evnyUIphGczGiW4H
         Or2g==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ8LIWGzpVfab1yaLnCUqC4vnvyLJZeSZ4JYvsw2UpeMfdJ9G42q8VraixhaNl61pCVHDKa8Ud5fch1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Cj3JbqYyR5+X8p9p9SZIoBS8WF9fOBFv0Erza4vLv+fnKGVw
	ldFhiZXqeTEhFg2jfj49JLVqLN8Yndb73KnWJtWPFWjnFgD3o8HM
X-Google-Smtp-Source: AGHT+IGpvt0S5W8aCBGJ6NArrRUubl0oaLk1rGoOiTAa8dDF48WlXMqbFY0nwTaGKoLmpUpJSlcmPQ==
X-Received: by 2002:a05:600c:3506:b0:42c:ba6c:d9b7 with SMTP id 5b1f17b1804b1-42cdb57e85emr30075965e9.5.1726259361289;
        Fri, 13 Sep 2024 13:29:21 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b189a83sm35598185e9.34.2024.09.13.13.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 13:29:19 -0700 (PDT)
Date: Fri, 13 Sep 2024 23:29:16 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
	"claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>,
	"woojung.huh@microchip.com" <woojung.huh@microchip.com>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"george.mccollister@gmail.com" <george.mccollister@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux@rempel-privat.de" <linux@rempel-privat.de>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"sean.wang@mediatek.com" <sean.wang@mediatek.com>,
	"kurt@linutronix.de" <kurt@linutronix.de>,
	"m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"Landen.Chao@mediatek.com" <Landen.Chao@mediatek.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 net 2/5] net: dsa: be compatible with masters which
 unregister on shutdown
Message-ID: <20240913202916.t7bpdc6ubfdpv47s@skbuf>
References: <20210917133436.553995-1-vladimir.oltean@nxp.com>
 <20210917133436.553995-3-vladimir.oltean@nxp.com>
 <2d2e3bba17203c14a5ffdabc174e3b6bbb9ad438.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d2e3bba17203c14a5ffdabc174e3b6bbb9ad438.camel@siemens.com>

Hi Alexander,

On Wed, Sep 04, 2024 at 08:31:13AM +0000, Sverdlin, Alexander wrote:
> > +static void lan9303_mdio_shutdown(struct mdio_device *mdiodev)
> > +{
> > +	struct lan9303_mdio *sw_dev = dev_get_drvdata(&mdiodev->dev);
> > +
> > +	if (!sw_dev)
> > +		return;
> > +
> > +	lan9303_shutdown(&sw_dev->chip);
> > +
> > +	dev_set_drvdata(&mdiodev->dev, NULL);
> >  }
> 
> This unfortunately didn't work well with LAN9303 and probably will not work
> with others:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> CPU: 0 PID: 442 Comm: kworker/0:3 Tainted: G           O       6.1.99+gitb7793b7d9b35 #1
> Workqueue: events_power_efficient phy_state_machine
> pc : lan9303_mdio_phy_read+0x1c/0x34
> lr : lan9303_phy_read+0x50/0x100
> Call trace:
>  lan9303_mdio_phy_read+0x1c/0x34
>  lan9303_phy_read+0x50/0x100
>  dsa_slave_phy_read+0x40/0x50
>  __mdiobus_read+0x34/0x130
>  mdiobus_read+0x44/0x70
>  genphy_update_link+0x2c/0x104
>  genphy_read_status+0x2c/0x120
>  phy_check_link_status+0xb8/0xcc
>  phy_state_machine+0x198/0x27c
>  process_one_work+0x1dc/0x450
>  worker_thread+0x154/0x450
> 
> as long as the ports are not down (and dsa_switch_shutdown() doesn't ensure it),
> we cannot just zero drvdata, because PHY polling will eventually call
> 
> static int lan9303_mdio_phy_read(struct lan9303 *chip, int addr, int reg)
> {
>         struct lan9303_mdio *sw_dev = dev_get_drvdata(chip->dev);
> 
>         return mdiobus_read_nested(sw_dev->device->bus, addr, reg);
> 
> There are however multiple other unsafe patterns.
> I suppose current
> 
> dsa_switch_shutdown();
> dev_set_drvdata(...->dev, NULL);
> 
> pattern is broken in many cases...

Unfortunately the code portion which you've quoted for your reply does not
show the full story. dsa_switch_shutdown(), at the time of this patch,
was implemented like this (stripped of comments):

void dsa_switch_shutdown(struct dsa_switch *ds)
{
	struct net_device *master, *slave_dev;
	LIST_HEAD(unregister_list);
	struct dsa_port *dp;

	mutex_lock(&dsa2_mutex);
	rtnl_lock();

	list_for_each_entry(dp, &ds->dst->ports, list) {
		if (dp->ds != ds)
			continue;

		if (!dsa_port_is_user(dp))
			continue;

		master = dp->cpu_dp->master;
		slave_dev = dp->slave;

		netdev_upper_dev_unlink(master, slave_dev);
		unregister_netdevice_queue(slave_dev, &unregister_list);
	}
	unregister_netdevice_many(&unregister_list);

	rtnl_unlock();
	mutex_unlock(&dsa2_mutex);
}

I believe you would be wrong to blame this patch for exiting with the
slave/user ports still running (and thus ds->ops->phy_read() still
callable), because, as you can see, it doesn't do that - it unregisters
them, which also stops the net_device prior. So, both phylink_stop() and
phylink_destroy() would be called.

The patch had other problems though, and that led to the rework in
commit ee534378f005 ("net: dsa: fix panic when DSA master device unbinds
on shutdown"), rework which is in fact to blame for what you're reporting.

Given that we are talking about a fix to a fix, it doesn't really matter
in terms of backporting targets which one it is, but for correctness sake,
it is the later patch that fixed some things while introducing the race
condition.

