Return-Path: <netdev+bounces-99748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD408D6313
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2351C21344
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C58158D8C;
	Fri, 31 May 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pN4EV1jY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB833CF1;
	Fri, 31 May 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162515; cv=none; b=NAUYHstqnCWOBPRehO1rbrQkPKxtugIsVkFJ0G/0hTuGPI2Lg3QuxfMRfHyPBkXnWQeMSQrDggbI/u3hcGG8AzrV189wlPKtfGJ4QtAS0yGy6ROkkDZcKmrRhBCS4qeXCJBF1xyvr7Sx89QpTRvO8EyVHDIGLLF3rBSLG/xOgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162515; c=relaxed/simple;
	bh=RCxKlMkz2hwtL0o/rwKf34aSNTRYA9l7vN2VAKV+xtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcwC6lutUtQ/9+kuVr1arOnj6WptOrnSM8xjGl0JJ17XzWrbp1E4q18sPYLCjWtA8MZ0bzn56Cgx1wRHlZgtBKSDtaZblpkeBajN4XvAbDX1eWsaubjZjBfIcWdX3/FzYqh29UEtEQjVwZ0ql2uprbmPR3Y0Sk4cnkx3cXT26tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pN4EV1jY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vgm/OpbOd3cmMPFc8u81IplmaIz3UZVMWUU0TbmKPI4=; b=pN4EV1jYOQbw5L36gUcI2rJiYl
	vU2G4SxRbmLRYpHxvqkFvZNuuA7cNptVkp7xSP5O4tv9/oD5yuJMtSPLmvdhiJgneeqpoUQFGpcAE
	IyC3givwc+xtYxWiMzhFtKg2Sr+PGzUodCaLzrrIcIQyt4JD6DbhSfPqnrwyrrFMmFi4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sD2P4-00GT67-D1; Fri, 31 May 2024 15:34:42 +0200
Date: Fri, 31 May 2024 15:34:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
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
	linux-kernel@vger.kernel.org, srk@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v8 2/2] net: ti: icssg_prueth: add TAPRIO
 offload support
Message-ID: <e0fe45c7-ea81-4d5f-bb42-6bec73a7d895@lunn.ch>
References: <20240529110551.620907-1-danishanwar@ti.com>
 <20240529110551.620907-3-danishanwar@ti.com>
 <7143f846-623d-465f-a717-8c550407d012@intel.com>
 <a5895c1f-4f89-4da7-8977-e1d681a72442@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5895c1f-4f89-4da7-8977-e1d681a72442@ti.com>

> When I had posted this series (v8) the ICSSG switch series was not
> merged yet and I had rebased this series on net-next/main. When you
> tested it, the ICSSG Series was merged and as it resulted in conflict.
> 
> I will rebase it on the latest net-next and make sure that their is no
> conflict and post next revision.

This is what i asked about, what are the build dependencies. Please
always state them in the cover note.

In general, we recommend what when you have two or more patch series
for a driver floating around, mark all but one RFC, so you get
comments on them, but it is clear there is no need to try to apply
them because of dependency conflicts.

       Andrew

