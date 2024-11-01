Return-Path: <netdev+bounces-140961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4539B8E25
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E9B281EB9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F4158DD1;
	Fri,  1 Nov 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn+KO3AN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF90158870;
	Fri,  1 Nov 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454566; cv=none; b=SIemmMTlDIAbyxzVh47YnNIiWEtRr3HPEOUVm/FOTLgYDZqB8RVlhOol1UyOgbvwJqzx6P0Ussvf3+FrCt9QPpOvoqLX5Nh6D4zr3vinf6nEggp3xXpxkrD+arLSh3B6G5WRj29Wd5hZ3gpyuXZyGaEQhkjd1gBWc650GMFBgOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454566; c=relaxed/simple;
	bh=UaT2w3WUjeQmmtc7DUzt+bO37zf6ZvCHNpF26QbAeOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPUL7Zu/ECQOyM0KP7V5eseNZ+sZYXlB5pLaLyAPq48nNiv2vZ5fjDMlc+8DldZDtWKK7JFVXIEh/6qZlVLEn3K0reTRT+flihYLWC+KUI368CD6Q3jcVnOUp0UvLbKCYTb6p2MCcGngAQ1rRrRP0O1MUodohc7bptxDfDYsXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn+KO3AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE89C4CECF;
	Fri,  1 Nov 2024 09:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730454566;
	bh=UaT2w3WUjeQmmtc7DUzt+bO37zf6ZvCHNpF26QbAeOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn+KO3ANmKWxM4eW/WzmbhWh1k41gYf0bsyhD+DC997Xhco1jF2xB6JJghapHU48T
	 2W16XoUsMRHPbyCsNdpHDlIrc1PA1MoNsF7YiHDPe0GNRBVMJes9T7wnTSx7McZ40g
	 uVCsVj/td21xZVNbIxYhTi8qIONuJMrXYDKr/JohrJsrb9+Zw9q34Li/lNt9QLJYw3
	 jlwaoegZQMyTioqltvJ2hu3OlKW1SqdUb5Rui9FUz+E6lzXq6wmt2XqX5ud4PVXOSK
	 lX7G9NIiAz4CjU8L5hUmncaIUCWSEDmN3vLZv3q2TyzDl+LqlU3fe/uadPnYt49yOa
	 8ZieAeQyf0XGw==
Date: Fri, 1 Nov 2024 09:49:20 +0000
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH intel-next] ice: Add support for persistent NAPI config
Message-ID: <20241101094920.GA1838431@kernel.org>
References: <20241021223551.508030-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021223551.508030-1-jdamato@fastly.com>

On Mon, Oct 21, 2024 at 10:35:51PM +0000, Joe Damato wrote:
> Use netif_napi_add_config to assign persistent per-NAPI config when
> initializing NAPIs. This preserves NAPI config settings when queue
> counts are adjusted.
> 
> Tested with an E810-2CQDA2 NIC.

...

> Signed-off-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Simon Horman <horms@kernel.org>


