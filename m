Return-Path: <netdev+bounces-12398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B234737502
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD8E1C20CC0
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27CC17AC8;
	Tue, 20 Jun 2023 19:21:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEA171AA
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 19:21:44 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5391B6
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H1ZuLMtRcMYeNjIiZCRjBTQwiBsmnlaUTVkfe6aLUXA=; b=GBdPCy/ea6NkGfTH8lAX2foxED
	ltXaWsY62o4eymHgBnFDNCcR7jaMZU+YROI2qG7uTaCd9sZ4OWwPuXBk/8NRWQ+NCkAOMQ2cbQB8X
	zh8zBNv4dZpHvv0CS4xe5JBxXQTJ1OPMaODC9lIBz4vffoOPIzUbuksq+tXsqye2GLI8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qBgv3-00H3AG-Jh; Tue, 20 Jun 2023 21:21:37 +0200
Date: Tue, 20 Jun 2023 21:21:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ngbe: add Wake on Lan support
Message-ID: <331e15f7-a27f-4229-8aac-16ebea952969@lunn.ch>
References: <58725FAD2BC3AE85+20230619094226.29704-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58725FAD2BC3AE85+20230619094226.29704-1-mengyuanlou@net-swift.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static void ngbe_get_wol(struct net_device *netdev,
> +			 struct ethtool_wolinfo *wol)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	if (!wx->wol_enabled)
> +		return;
> +	wol->supported = WAKE_MAGIC;

What exactly does wol_enabled mean?

You should always return what is supported. Which makes me think
wol_enabled is more like,
wol_is_supported_by_this_version_of_firmware?

If it is this, please give it a better name than wol_enabled.

> +static int ngbe_resume(struct pci_dev *pdev)
> +{
> +	struct net_device *netdev;
> +	struct wx *wx;
> +	u32 err;
> +
> +	wx = pci_get_drvdata(pdev);
> +	netdev = wx->netdev;
> +
> +	err = pci_enable_device_mem(pdev);
> +	if (err) {
> +		wx_err(wx, "Cannot enable PCI device from suspend\n");
> +		return err;
> +	}
> +	/* make sure to complete pre-operations */
> +	smp_mb__before_atomic();

I've no idea what this actually does, but it seems to be used a lot in
pairs with smp_mb__after_atomic(). Is it actually valid to use it on
its own, not in a pair?

    Andrew

