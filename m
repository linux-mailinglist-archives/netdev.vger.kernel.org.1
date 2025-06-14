Return-Path: <netdev+bounces-197842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1247ADA041
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAE87A3B34
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05281202C58;
	Sat, 14 Jun 2025 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="slzuC1CQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC572201004
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749940047; cv=none; b=mgVZw/DnBcv4b0AKleIiwUe+MjTEl/zVKBK9jKzh0bojTZCiidleThnGkpRfFHwqohKPAf6b1KYn5hbmh+9ipd22L4EUTOIWrAT1D6kKyfnq7DSnAi0KkakyB3FyQx41nGVjvi0+bO6l60K70M25RfGuQlQOychdOapIF960YJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749940047; c=relaxed/simple;
	bh=+q934hpbLJvWQkTpkPzKRxXboIlYxkPi8Ikc0MHjZa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAtm37w63UKqOWKe5/wWva+cFKn7eXbhbd8WQSZUfHkxe/KnII6Wi38MDQs4VhXYWbmtUTPiXG6IglO4uIY8tCwPZDdIzBYFZ9TuICPaETWLyeKSK+g3pkbAspxnrtUIKWaUUMVHvEj9SsrE133hOGD4HpYU5GLKyNjAzBmoGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=slzuC1CQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uSSbuO6Jo7RUi7MfT6qlh9CTeMaNOIaCgD0TQ3iSjys=; b=slzuC1CQV60VpxE70BYVdcH8gN
	O6VPWlIUZnXT44ceKzwX9vHM6DaWZSMxkm5HjHNaQsySm6n/3DrV/mu4ILGh3wXlXnOn65rm2OCJ5
	rfuO8wiMx4p1YHHcDvqKmQRhfNSo31UXMh+A+ckv92xUC5AKBz0kVxirAg7kK87nmrX4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQZLO-00FseL-MH; Sun, 15 Jun 2025 00:27:22 +0200
Date: Sun, 15 Jun 2025 00:27:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, kernel-team@meta.com, edumazet@google.com
Subject: Re: [net-next PATCH v2 5/6] fbnic: Add support for reporting link
 config
Message-ID: <a0f564fe-9d0a-4ebb-937c-e2256f8929bb@lunn.ch>
References: <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
 <174974093397.3327565.18236629132584929783.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174974093397.3327565.18236629132584929783.stgit@ahduyck-xeon-server.home.arpa>

> +static void
> +fbnic_phylink_set_supported_fec_modes(unsigned long *supported)
> +{

I know naming is hard, but can this be called
fbnic_phylink_get_supported_fec_modes() because ...

> +int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
> +					struct ethtool_link_ksettings *cmd)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	int err;
> +
> +	err = phylink_ethtool_ksettings_get(fbn->phylink, cmd);
> +	if (!err) {
> +		unsigned long *supp = cmd->link_modes.supported;
> +
> +		cmd->base.port = PORT_DA;
> +		cmd->lanes = (fbn->aui & FBNIC_AUI_MODE_R2) ? 2 : 1;
> +
> +		fbnic_phylink_set_supported_fec_modes(supp);

... calling a _set_ function in ksettings_get() looks odd.

    Andrew

---
pw-bot: cr

