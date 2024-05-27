Return-Path: <netdev+bounces-98346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C88D1027
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF29280FB6
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F22208E;
	Mon, 27 May 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BLNQIN8O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40217E8EF;
	Mon, 27 May 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848214; cv=none; b=jV5KqjxBv1voAvroeHMMhumYkqtgZhqsWIOgwAgZ2k1FrWFYcHlkMIpO0odWDzI4+tIEPiYMp257HEk5XBvM61mkSpmYWWoTzjn6n4dHUfnRHQ5PvIFv7woZlZkGQmAt81EGM075mVTp0fP709jB5scSaUu0QH0voXGPuQn35n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848214; c=relaxed/simple;
	bh=T7j1+5j4XXrl86er3G4Mvu1GdfBJVXcGFioamjVXWUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwIgDGHU8KfJrX11PYM8RKXBPN2xdOnePgwNt0KNrmVjBIpLbSgk9w3vD3yV4uaE/feGjaxei61xn7c8xF5j9ZA7xekVmj767iv4RWDwIbi1O/V0UB678v4E3aHe/0db2JEwjRv+FbOuXj/XjG+ikurUgnFOi8RU2m0yVUvLCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BLNQIN8O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hKS4kDhpGM7nfRkS7MgrVHJ6ZRbC/gLbDfkWBa/zlhs=; b=BLNQIN8OuijtmaEFw+vy96KSVa
	QW9AVBFhkIRM1+6LDRqpKdVY4Cpoc/jhrYzgigbwdmkKAdfe8FbmAdhRkSLEO2s+lHf6MuMwGuAq3
	59uuvo8IR4c1IA8kVOVv0dNrvhNtvfQ1BrEm5WDYJfKZywzazFdpZ2Fivxp+gv1z8fEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBidw-00G6qp-4i; Tue, 28 May 2024 00:16:36 +0200
Date: Tue, 28 May 2024 00:16:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>, Diogo Ivo <diogo.ivo@siemens.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com
Subject: Re: [PATCH net-next v7 0/2] Add TAPRIO offload support for ICSSG
 driver
Message-ID: <57f6ed32-65cd-49e4-bfe6-c8d320e8de53@lunn.ch>
References: <20240527055300.154563-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527055300.154563-1-danishanwar@ti.com>

On Mon, May 27, 2024 at 11:22:58AM +0530, MD Danish Anwar wrote:
> This series adds taprio offload support for ICSSG driver.
> 
> Patch [1/2] of the series moves some structures and API definition to .h
> files so that these can be accessed by taprio (icssg_qos.c) file.
> 
> Patch [2/2] of the series intoduces the taprio support for icssg driver.

What is the dependency between these patches and switchdev support? It
is good to make that clear in the cover note, especially if this code
will not apply without some other patches first.

     Andrew

