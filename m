Return-Path: <netdev+bounces-179939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE37FA7EF50
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF118915CC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C18121ABBC;
	Mon,  7 Apr 2025 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zk1qfI4o"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE8215F43;
	Mon,  7 Apr 2025 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057861; cv=none; b=VnpI8l4Me0P1PvNmJW+D6cszTkBJilv00WjJ20GoMjVNqG4VO9BzUOSmpfSjx0iVdPMWNchX/oTQUBX9psZ2+6FqqX/K6Fsy9j0s/BmOZBWVyEioA2mD2Np0pcE6TG484BkR3VRX/0eCPG0wLiptyipWn31JsGMV+/pR8UQugwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057861; c=relaxed/simple;
	bh=G8HBEsHNEI0sJGgfxNrWXXn1MJdNjzeXSWy4JVY8JD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLgtRH2umXkNXOv03XrdZwBuHi/aD9EdV02PjhLTsN7u1IA6OmuN6BjIlPxvwWaeq2ngEZpZYayz4RlBm8nj0cumd0avL/SKfnph81XV0+s9NBxeJtada+o2G8l1tcZA+i4Hg1CQwDYPvQIGQcAb+SS0Lf+coN9mSDGsgBb9XCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zk1qfI4o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w9ovsHoE8JgQH4oLggs1TAJXs8X7Tpangv6cT0yEWGE=; b=zk1qfI4oag4BvCspUMOS1Nf+MT
	fMx1LRMlR/se1AMr09cj03hH1ctbqgnxT1ENKy9/oNMx4oSZU0+iQ6rUdnjhNx8vgu3x28Pf8qEmp
	4f96vidN8sCC5ZQYYFAmFxwy2fPRR6cKawgwxQrKaqQHgPq1LzRAwYzZh5bXhEG0QbGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u1t7O-008Iqo-J2; Mon, 07 Apr 2025 22:30:54 +0200
Date: Mon, 7 Apr 2025 22:30:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Pazdan <mpazdan@arista.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 2/2] ice: add qsfp transceiver reset and presence pin
 control
Message-ID: <6ad4b88c-4d08-4a77-baac-fdc0e2564d5b@lunn.ch>
References: <20250407123714.21646-1-mpazdan@arista.com>
 <20250407123714.21646-2-mpazdan@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407123714.21646-2-mpazdan@arista.com>

On Mon, Apr 07, 2025 at 12:35:38PM +0000, Marek Pazdan wrote:
> Commit f3c1c896f5a8 ("ethtool: transceiver reset and presence pin control")
> adds ioctl API extension for get/set-phy-tunable so that transceiver
> reset and presence pin control is enabled.

As the name get/set-phy-tunable suggests, these are for PHY
properties, like downshift, fast link down, energy detected power
down.

What PHY are you using here?

     Andrew

