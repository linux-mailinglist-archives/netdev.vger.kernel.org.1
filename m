Return-Path: <netdev+bounces-259123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH7INfWzlGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:31:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B75A14F29A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DE493022541
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE132372B4D;
	Tue, 17 Feb 2026 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ya2+1gpq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AA2773E4
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353068; cv=none; b=MFpMBHBsDGk5Eyrnal5Hsb/h9Kobnjfy0/jxIbVJIgLx6dKy9pTLq1B4czTSKYRSlKqar8OHjFyEaGuje/baAvUGLXhtBki3VNHTc7SXnSuFcoDF0lYEyLzZfa6ISbgd4meKe0a6HFdj84hsNhMOT7b//PARgNEUL1RAZ4YWV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353068; c=relaxed/simple;
	bh=NQafRO4kmlubbKKSiB/5xbP0mNzPXDHGtvZY73y5kU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1KbUCPoEEfLeu/D/WFFp2Lqj+E1AkYPQwcZmaAoygOoaM5xUJkrmfsV422XYAIGhJQoFAmQr4sY/HDpM3u51HYNorMdLxC1+f6VlWCIUuoPJ7U/AZn+EQLZjkJEs4uwbV2/tC7TleRXSwrZ3zVxu4py7wiPbgSLRSFx4pGSesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ya2+1gpq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZcgBe0js/+2Uk2jhP+nO203xbec6qDbykWUCSsUEEFI=; b=ya2+1gpqbEv75dfV4Mv2Uk6zyK
	aTPHRvYlaYCDZKyrw2xK6LjVSuG3Unld6I4Akp5Xq/NcHMDgZCW7xg8UBUHf0qwTxHbyMYlUGiZA2
	aLjntVtvoOZ3TlTaLDWn2MU2hi3EqW0PRdOBe6XaZWLIOwiHsKw7f05bgjJLvY+JXFmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsPqj-007fxL-FV; Tue, 17 Feb 2026 19:31:05 +0100
Date: Tue, 17 Feb 2026 19:31:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, bjorn@mork.no,
	o.rempel@pengutronix.de
Subject: Re: [RFC net-next 1/3] net: usb: divorce private data and cdc state
 in usbnet
Message-ID: <64f854e8-2cde-428c-83b4-e9688aa8c30f@lunn.ch>
References: <20260210151416.42254-1-oneukum@suse.com>
 <20260210151416.42254-2-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210151416.42254-2-oneukum@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259123-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 4B75A14F29A
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 04:11:12PM +0100, Oliver Neukum wrote:
> This allows use of cdc helpers together with private dara.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/asix_common.c    |  4 +--
>  drivers/net/usb/asix_devices.c   | 18 +++++-----
>  drivers/net/usb/ax88172a.c       |  2 +-
>  drivers/net/usb/ax88179_178a.c   |  2 +-
>  drivers/net/usb/cdc_ether.c      | 12 ++-----
>  drivers/net/usb/cdc_mbim.c       | 18 +++++-----
>  drivers/net/usb/cdc_ncm.c        | 58 ++++++++++++++++----------------
>  drivers/net/usb/cx82310_eth.c    |  6 ++--
>  drivers/net/usb/dm9601.c         |  2 +-
>  drivers/net/usb/huawei_cdc_ncm.c | 10 +++---
>  drivers/net/usb/mcs7830.c        |  2 +-
>  drivers/net/usb/net1080.c        |  2 +-
>  drivers/net/usb/qmi_wwan.c       | 33 +++++++++---------
>  drivers/net/usb/rndis_host.c     |  6 ++--
>  drivers/net/usb/sierra_net.c     |  7 ++--
>  drivers/net/usb/smsc75xx.c       | 40 +++++++++++-----------
>  drivers/net/usb/sr9700.c         |  1 +
>  drivers/net/usb/sr9800.c         | 10 +++---
>  include/linux/usb/usbnet.h       | 27 ++++++++-------
>  19 files changed, 125 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
> index 4f03f4e57655..d97a1920cb6e 100644
> --- a/drivers/net/usb/asix_common.c
> +++ b/drivers/net/usb/asix_common.c
> @@ -441,7 +441,7 @@ int asix_write_gpio(struct usbnet *dev, u16 value, int sleep, int in_pm)
>  void asix_set_multicast(struct net_device *net)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> -	struct asix_data *data = (struct asix_data *)&dev->data;
> +	struct asix_data *data = (struct asix_data *)&dev->private;

Would it make sense to add a usbnet_priv() macro? It is a common thing
to see: mux_chip_priv(), iio_priv(), pci_host_bridge_priv(),
shost_priv() etc.

	Andrew

