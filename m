Return-Path: <netdev+bounces-101108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B28FD5FE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487281C23F0A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C7513AA3F;
	Wed,  5 Jun 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acf2C2w+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F9DF78;
	Wed,  5 Jun 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613284; cv=none; b=ARsLRxiPuWzLKLn9eL3nkOudm5Bt7pUdbHPWU3FC52Wh0RQchBs7+QmzmSBsx+MPFlngtu76yCk9B119Vil0aFgG5/qzB0cRuH2YR18q1/NVhU1XeJ5H4/PJB9JqHdSYYYrBVfcalf+R6/urtBIL5iQieo3cX1DwSVnsFNY+zrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613284; c=relaxed/simple;
	bh=/s34kC5Ydbni4JsHlkkvvQHmMGbSTS4IyJ8sKyCtSpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSrcVIjaOshvPsR1gr0b9o6B0rdzN6TX1WM7M6i337EWLd3VIpfMPZbis2htvM/47HhBT7ZvwHCv7oUu4d3ymNNjWQ4AdONP6YhGl76qeZlA9RoZKAVPeDD+NjwIRS3w5oZ8LUIA8SJrFBPMzXCOWAlgUjmgBIcpO2TkwRblTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Acf2C2w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30A7C2BD11;
	Wed,  5 Jun 2024 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613284;
	bh=/s34kC5Ydbni4JsHlkkvvQHmMGbSTS4IyJ8sKyCtSpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Acf2C2w+3YFnEUeVGM7A9zMfKJRwgPMk//9WtwakjR7w8EHiIoH0miTOBFY6QblEy
	 7gVTrW8fJHLaT6v+E3dnUQ2rIwwxQX9FQzdEBcPVFu7W1OtHfPDn8fOrj+Mh0SMXgu
	 gD6u19h1z0qyqJNzrSgAihFzOMI6qKnb9sN0a0Naj12LMIiZ8aS/6zNj8AB9KCHXpm
	 rkgRWBa8qdRpmW12T3R1K+1oyxS1XTBvw69KIRqzeMTsZKW7h1BhWtma1In5lWnx9b
	 vCplEcKyTkQbm4fmjGXkeM7x0IjZY5MLo238cCj3FURSY4Etf2/WOGg2C7Kc9N3VZs
	 CvDv4fQaXSacA==
Date: Wed, 5 Jun 2024 19:47:59 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] net dsa: qca8k: fix usages of
 device_get_named_child_node()
Message-ID: <20240605184759.GT791188@kernel.org>
References: <20240604161551.2409910-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604161551.2409910-1-andriy.shevchenko@linux.intel.com>

On Tue, Jun 04, 2024 at 07:15:51PM +0300, Andy Shevchenko wrote:
> The documentation for device_get_named_child_node() mentions this
> important point:
> 
> "
> The caller is responsible for calling fwnode_handle_put() on the
> returned fwnode pointer.
> "
> 
> Add fwnode_handle_put() to avoid leaked references.
> 
> Fixes: 1e264f9d2918 ("net: dsa: qca8k: add LEDs basic support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


