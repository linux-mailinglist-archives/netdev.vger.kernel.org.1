Return-Path: <netdev+bounces-127685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F454976199
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B21B225CF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DF9188931;
	Thu, 12 Sep 2024 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uCt9mS7O"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5B76025;
	Thu, 12 Sep 2024 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123031; cv=none; b=sobaXPFFJdXIOlK3z2VsDhuToRwF7HwPPfk/kPliavwIy/tW18bKKPcBJoN3+wUVoT7Pn+ASrBL6yl4zRLN6n6huufMXn2chNneA+umIVNv97sOy2QeTTOti+OVpi1xcmWIj6i3mZzULvpSb2owIe/nzglrj20j8fNHlR4iM6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123031; c=relaxed/simple;
	bh=qeNsWCt9z5UTP8IEj9tHoZL98cbir8dTzUVV16Yp8Ts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM23EWwtDW/SZU6ErVC+ZWPJXaV0nHnEG7coypWtMfKCSKaqvTXoQp8A8oPUuHYTm7jYKXKuoS/YbI7XZw70/A+kOnW9MrevLT8r9oas89HDaS/sfwjWz05TITUtMtDDW6K0VXnUzUDaAkaD7AACTmKpRZRfXi8hI27UmKPOdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uCt9mS7O; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726123030; x=1757659030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qeNsWCt9z5UTP8IEj9tHoZL98cbir8dTzUVV16Yp8Ts=;
  b=uCt9mS7OVhx338fZm0Pp5q3m06cgrhtqUxN7d1SnVD4+d8BIYtKzOxsj
   MvyuZWmOzL+yJDWPPCNlFcLD49Ll514Fy+pQtE/hwOMoVnNYpsCX05HkM
   PG+4y/Lq0zxYGKSMzB1RcLh3c6gOsL+oKJ+NC0oLuQSlMUSuGO0L66QsW
   A+m66RxpLEcTb1Gq9vRDe7kn4WyQqwk/+Lq+VA5SFUXeu+UyqyDKXFEGo
   yi9qvHS23scZ4VqOCkFHhnUUpxZ8yfxcRa1zJQyQynN35oIVEdSsfH4+T
   oj2/oWvXQDXvb9+hxvsa/FsMmOvNYzykz3X2+CFFTcMrnSLG5i9Wv11dI
   Q==;
X-CSE-ConnectionGUID: cjNbTOIoQw6D7589WuCtXQ==
X-CSE-MsgGUID: P0YxrzdCTz+9dFHcq7QoTQ==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="31685147"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 23:37:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 23:36:47 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Sep 2024 23:36:46 -0700
Date: Thu, 12 Sep 2024 12:02:57 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>, <andrew@lunn.ch>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
Message-ID: <ZuKLGYThw8xBKw7E@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
 <c93c4fe2-e3bb-4ee9-be17-ca8cb9206386@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c93c4fe2-e3bb-4ee9-be17-ca8cb9206386@wanadoo.fr>

Hi Christophe,

The 09/11/2024 18:54, Christophe JAILLET wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Le 11/09/2024 à 18:10, Raju Lakkaraju a écrit :
> > Register software nodes and define the device properties.
> > software-node contains following properties.
> >    - gpio pin details
> >    - i2c bus information
> >    - sfp signals
> >    - phylink mode
> > 
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> 
> Hi,
> 
> ...
> 
> > +static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
> > +{
> > +     struct pci1xxxx_i2c *i2c_drvdata;
> > +
> > +     i2c_drvdata = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_I2C_ID);
> > +     if (!i2c_drvdata)
> > +             return -EPROBE_DEFER;
> > +
> > +     adapter->i2c_adap = &i2c_drvdata->adap;
> > +     snprintf(adapter->nodes->i2c_name, sizeof(adapter->nodes->i2c_name),
> > +              adapter->i2c_adap->name);
> 
> strscpy() ?
> 

Accepted. I will fix.
Here snprintf( ) does not take any format string, we can use strscpy( ).
 
> > +     netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
> > +               adapter->i2c_adap->name);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
> > +{
> > +     struct aux_bus_device *aux_bus;
> > +     struct device *gpio_dev;
> > +
> > +     aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
> > +     if (!aux_bus)
> > +             return -EPROBE_DEFER;
> > +
> > +     gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
> > +     snprintf(adapter->nodes->gpio_name, sizeof(adapter->nodes->gpio_name),
> > +              dev_name(gpio_dev));
> 
> strscpy() ?
> 

Accepted. I will fix.
 
> > +     netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
> > +               adapter->i2c_adap->name);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
> > +{
> > +     struct aux_bus_device *aux_bus;
> > +     struct device *gpio_dev;
> > +
> > +     aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
> > +     if (!aux_bus)
> > +             return -EPROBE_DEFER;
> > +
> > +     gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
> > +     snprintf(adapter->nodes->gpio_name, sizeof(adapter->nodes->gpio_name),
> > +              dev_name(gpio_dev));
> 
> strscpy() ?

Accepted. I will fix.
 
> > +     netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
> > +               adapter->i2c_adap->name);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
> > +{
> > +     struct aux_bus_device *aux_bus;
> > +     struct device *gpio_dev;
> > +
> > +     aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
> > +     if (!aux_bus)
> > +             return -EPROBE_DEFER;
> > +
> > +     gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
> > +     snprintf(adapter->nodes->gpio_name, sizeof(adapter->nodes->gpio_name),
> > +              dev_name(gpio_dev));
> 
> strscpy() ?
> > +     netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
> > +               adapter->nodes->gpio_name);
> > +     return 0;
> > +}
> > +
> 
> ...

-- 
Thanks,                                                                         
Raju

