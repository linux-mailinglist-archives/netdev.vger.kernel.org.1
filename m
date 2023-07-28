Return-Path: <netdev+bounces-22237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C1766A45
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBF628267D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D311CA1;
	Fri, 28 Jul 2023 10:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F411C8E
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:24:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D88744AF
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YgOvIj46rn6WG8SsqJCZ73qqmnBpMmVUn9IYzY/5sic=; b=RGSFgEXmveK6T+DQWOsO0XaSsI
	tAVc+u/h+q86BrTUaGNam9I5zmhMbx69eAQq9LAVnnwYHugy8iKyA4RMtuEv5tLvrjNzvCZek/5mW
	drUchDa/rldYNwynBdGCuUEdcudznOqQ1tsfnB/PbgB51KrDB2LLq6CKroMmgpwYGTXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPKdf-002WZe-3Y; Fri, 28 Jul 2023 12:24:03 +0200
Date: Fri, 28 Jul 2023 12:24:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "'Russell King (Oracle)'" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for
 SGMII mode
Message-ID: <be6b8423-0045-49bf-acfc-92ffa9028316@lunn.ch>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-5-jiawenwu@trustnetic.com>
 <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk>
 <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com>
 <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk>
 <03f101d9bedd$763b06d0$62b11470$@trustnetic.com>
 <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk>
 <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk>
 <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> There is a question about I2C MII read ops. I see that PHY in SFP-RJ45 module
> is read by i2c_mii_read_default_c22(), but it limits the msgs[0].len=1.
> 
> A description in  the SFP-RJ45 datasheet shows:

Please give a link to this document.

The problem with copper PHYs embedded inside SFPs is that there is no
standardised protocol to talk to them. Each PHY vendor does their own
thing. At the moment, two different protocols are supported, ROLLBALL
and the default protocol. It might be another protocol needs to be
added to support the SFP you are testing with. So we need to see the
protocol specification.

      Andrew

