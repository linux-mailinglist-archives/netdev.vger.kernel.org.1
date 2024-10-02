Return-Path: <netdev+bounces-131407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F7098E75F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5081C263B1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FCD1BE223;
	Wed,  2 Oct 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wylyAaLw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B0E19F41B;
	Wed,  2 Oct 2024 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912794; cv=none; b=nGjrIYkg1EvHGt60Gu5SRIj26UpaSBS0wsfEBMcMxs5K+deYfMCO67F6Eif+S1necQ+oyn5AvJiVzJe4HMBAED1a/RKL/0rv1uGhBHa1Mthupdp8vFy0SPZkYTir4UhYilYxd3urGLf6iy2qk/p41OtP+cjWyddoZYUnrafH/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912794; c=relaxed/simple;
	bh=kyPX9+MkoSYbSJKOPLmnG8kT3LEDjS9a9EAKQP/LQ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW9+uLr2V6qQnVAsdHxcJN1EbjR3PnFqpvtP/FI7uRNWkUa3HO7rRlDHAvtgM2rROs8U4rti6YIhp+dq4WOdL9XV6dpMJrRDfnohenj6laIs/kJ53BKbh0j5usgUYbK8FDtyi27CBmR+cbupB1BaFpK+SfbTvxDoCJ/0kcJ6dKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wylyAaLw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nFVNgxu68ONj5Q0UYVegcSn+ueUJyZ0C32PCbZqlBR8=; b=wylyAaLw1lyDzuRFnhvbNZ5NGL
	v3SWscriNNeJDr3p+du46EFUnfLxHQGobSM0AoUQlrkgbciDmuklTO0f5Mm3zLQE+Xk8BIqf1Os/j
	vsf73uSOTorpnDpFXkboqkQrVLgOYrfzQ3QOQSpL51+d+GRkVBrkeajsHJprQaayydSA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw930-008uFI-Pm; Thu, 03 Oct 2024 01:46:22 +0200
Date: Thu, 3 Oct 2024 01:46:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 10/12] net: pse-pd: Register regulator even for
 undescribed PSE PIs
Message-ID: <b78344a8-d753-4708-ac61-9c59ffdd5967@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-10-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-10-787054f74ed5@bootlin.com>

On Wed, Oct 02, 2024 at 06:28:06PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Ensure that regulators are registered for all PSE PIs, even those not
> explicitly described in the device tree. This change lays the
> groundwork for future support of regulator notifiers. Maintaining
> consistent ordering between the PSE PIs regulator table and the
> regulator notifier table will prevent added complexity in future
> implementations.

Does this change anything visible to the user?

Is it guaranteed that these unused regulators are disabled?  Not that
they were before i guess. But now they exist, should we disable them?

	Andrew

