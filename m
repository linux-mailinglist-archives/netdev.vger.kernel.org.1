Return-Path: <netdev+bounces-109903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1492A3B1
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02CD280D4F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598D28DA0;
	Mon,  8 Jul 2024 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="01IFZLMy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80020824A1;
	Mon,  8 Jul 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445608; cv=none; b=cIH59kAVCfSMJEXJMKXfqu3nahHxSukxBhVyr4rI+b7VhG/WdAtQ7sNdr/NiHJY3A5rEwdksPQvw0jbyb2ucmlUspwGt2mM0i+90Qqzf+zAYRJbeBrA7v1AbwOzkYbcmckPKjDczAN3qqB05/yEBbnydDkBT0ebn3Se+0FAv/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445608; c=relaxed/simple;
	bh=TwVhQwFd2HIrGcgAsh+l6s9GY5Um6UHm05UKugNwj+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnAZVHvc74D12jgKqVDYyK5JYzIp9bhS6RH7lP0E8/cmMrh3F6saFby1HBjQNfh7+hTNrL5e+4vo88wNUWEbac+U5U23JV6DiNl0iqSDQcNgySuMn0Rri3rc+ydGmmIoCrwhXUwmjeADKXaQKPyKTPp+O9FTJyk5QoK6Bw08ZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=01IFZLMy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v2SOE6gYiBbo+WYs83c/BMGhuGdwETCYDnaMqZBuTTM=; b=01IFZLMyG+No7DLk9J9nei4Mll
	qjj8s7VDqMoNuHGMTPJ1QevAKtazLPnJWvtFJ2OYhaJcRjkgUi9IKphGdch/KsB0RksLgnzH1Bgtp
	FTEdkOuXcxYXkGxCXL4vgD7ex2JtMS1V3tqvq+V6/AwblLFXHqYPMS0XoE4/ur+vUpuE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQoUX-0022lk-MW; Mon, 08 Jul 2024 15:33:17 +0200
Date: Mon, 8 Jul 2024 15:33:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Woojung.Huh@microchip.com, kernel@pengutronix.de,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] ethtool: netlink: do not return SQI value if
 link is down
Message-ID: <74128e54-51b9-4199-924e-a4e50b6f34cb@lunn.ch>
References: <20240706054900.1288111-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706054900.1288111-1-o.rempel@pengutronix.de>

On Sat, Jul 06, 2024 at 07:49:00AM +0200, Oleksij Rempel wrote:
> Do not attach SQI value if link is down. "SQI values are only valid if
> link-up condition is present" per OpenAlliance specification of
> 100Base-T1 Interoperability Test suite [1]. The same rule would apply
> for other link types.
> 
> [1] https://opensig.org/automotive-ethernet-specifications/#
> 
> Fixes: 806602191592 ("ethtool: provide UAPI for PHY Signal Quality Index (SQI)")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

