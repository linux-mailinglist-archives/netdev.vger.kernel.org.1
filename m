Return-Path: <netdev+bounces-98345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDB8D101D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843312831E5
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4281667EE;
	Mon, 27 May 2024 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ifvxj+uF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2467252F6D;
	Mon, 27 May 2024 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848092; cv=none; b=CdhsvY34TJNLAqw0TnPAo7w7JLQPwu3NGjwX4phQIGTtL40dyvw81Cxtsjb+FLyTZWIgS+eIsFjGMukCKgqpmDM8hSSMOqfWJf4PXqWnrl9QP72sSda3B/R7RvDsGDN4mcuLpub2HPpFS9O8tgL3/UxeXZxYgUPcQaX0+3EZiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848092; c=relaxed/simple;
	bh=aaFgdQAdOzX4wdwXTMpoJicnNbjCMX9iIPAoAWjz+Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqrmXr5phFDzrS2ZTbETzbI+eOXEk0OYdJDPPKfo/5KnCqDndZqkva8ym/KqeUl1Thg8KDT7Gp2JTW4qNMn/oAIaJMZSxvusUs/WODx9ZnggepN4yGjWKNW0EQX6FR6nevbQyvEvzelaVzYynBhLMX7tRE1evol87OqF32ReXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ifvxj+uF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TjkH2PgIRV3+xAaq85xY8qqg6XRzK9pvPOKeajwlTek=; b=Ifvxj+uFOQMbcLROT38af4Xaod
	bGcWlIwE1IjwVPpPHJkV8KcoApMn2DgqjwKg77Exc2dv9WAK9LDXF3ui+vX0sfkPQI533vxBfzUid
	lOkMqJrJrlHGkxTKRgAbMZ1ZJAcUPWabbnrJnuPMToVSrJ6mkdumD7cQGB6w6s1+YJzw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBic1-00G6oW-Gi; Tue, 28 May 2024 00:14:37 +0200
Date: Tue, 28 May 2024 00:14:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v5 2/3] net: ti: icssg-switch: Add switchdev
 based driver for ethernet switch support
Message-ID: <372a9f0c-7758-4942-b71e-a959d5f11efc@lunn.ch>
References: <20240527052738.152821-1-danishanwar@ti.com>
 <20240527052738.152821-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527052738.152821-3-danishanwar@ti.com>

On Mon, May 27, 2024 at 10:57:37AM +0530, MD Danish Anwar wrote:
> ICSSG can operating in switch mode with 2 ext port and 1 host port with
> VLAN/FDB/MDB and STP offloading. Add switchdev based driver to
> support the same.
> 
> Driver itself will be integrated with icssg_prueth in future commits
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

