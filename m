Return-Path: <netdev+bounces-118494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39163951C81
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DDB1F22460
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEC1B29BD;
	Wed, 14 Aug 2024 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eeN88CA9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE21B1511;
	Wed, 14 Aug 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644307; cv=none; b=hMBX1PpRgojvNcDr6tK7CWUdBSabTsM8blD2jENpKQdamJdbIkYM/48YncMcwGwmVPdxiAcHQxlNhaKJGK8xn/iR5MInHUy2UT6xKK3P5p5Q2C7kSS0ZZpGh3Uau/19Km2Bk+ajyAj3Lzlxw9NJSMLhS1SSmX4QqexFYb1ib2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644307; c=relaxed/simple;
	bh=WaW8XJhQ4GbhzVN9r23OnvUiWdFyZC7BBI3roPBU95k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv+ms8g7rwA3CurG3e1p1wHlTe1vEcEVVlrwiLf2RYPbhZqpd0Xuhu9GS9weVFqwFzdnyLj5TjmJM+cpNCNNC8vP512KCVDwKK2zkaO9rHv7vHgurCTk+a0PVgonebsXVI6a/pmZPeyrxooQIGMNGe0EYGDxagW+a/t3eeVEDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eeN88CA9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wlM/hae8prT81TJB4/2Vep7uUBYL04hYC/AkxXS65d0=; b=eeN88CA9Xh6FhCB6yfOaLumHRu
	iWT4BiTCndJ/DhPhgn5P7FzRI1/7QZYiqtsOmwYdCEoMeR2Xu/I7kFBThlXiw9hEQVWFPe5geI7mm
	qVRAKkSAQWuZxJATUWKFG34qe38i9qU9OnNu6ubuRcqJ9OA8yfbEZStNoyNYmrZ0OsUg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1seEcP-004loK-NX; Wed, 14 Aug 2024 16:04:53 +0200
Date: Wed, 14 Aug 2024 16:04:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 0/7] Introduce HSR offload support for ICSSG
Message-ID: <c2f99f7e-4f36-47eb-aee5-795d41be819e@lunn.ch>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <d061bfb6-0ccc-4a41-adad-68a90a340475@lunn.ch>
 <69043091-dd59-4b7a-aae0-34f9695b378d@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69043091-dd59-4b7a-aae0-34f9695b378d@ti.com>

> We have these 3 firmwares only for ICSSG.

O.K. But i also hope you have learned from this and the next
generation of the hardware with have more RAM for firmware, so you
only need one firmware image for everything.

     Andrew

