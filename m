Return-Path: <netdev+bounces-227261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C1BAAE87
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1CE1921C29
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835453363;
	Tue, 30 Sep 2025 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITu6FA1K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE234BA4D;
	Tue, 30 Sep 2025 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196823; cv=none; b=BJUuesEdor/HnNi9kIW75uz9sS7EyCVzvEqXAJqv+Oj6KX5TStYMmDJEDbE/vhP7Z13q0IqIjJm3UJTWul4OzkJJYWud1/YtScTcdgaiujPoS0WQ0j0Om2nZBLXf3L2VvLzNaUIXWQeJk+d1oJlSEG6EU6kmNz6crNgitU5Uxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196823; c=relaxed/simple;
	bh=44w7ektIoeE7rQ4mLMBD+KB9pgnJZsRCQRaLlXrhHP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuxtQYuTu2MA576RArVSf+fhrEWz8ds0f430qBjdA+S6wLZMipoONMRkEF2RGDciX6Ks8Pc8M9L0fzWHE4qYQzz4u7RXAbc+bMLwGLzuZ9QBIHDtg+EbjShPGk6IZhH0IXeDve2xqZLPqR1GF3tGXS8QHZDaruednTTHNzYNE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITu6FA1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8389C4CEF4;
	Tue, 30 Sep 2025 01:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759196822;
	bh=44w7ektIoeE7rQ4mLMBD+KB9pgnJZsRCQRaLlXrhHP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ITu6FA1K17i4ngEH2m8uFlcDOw2Yu/IX+Y7kSiSs4MY+vPy3HK2rHu5AVDUhnLE2d
	 QjgMzdWrqVaqHCLB0T04ayHXxa2xQW+CdZ/1UPUcgPBZjxENX7C5LhfgHZbmU2qyTf
	 OQ/YuTaY1oq8+cEiwS7/v8rVIDLcugMgI+Q1mxK4m5g8B2+NTe16BF9la4RLIOIH/V
	 qrtpcSCSjxZ5LEB3iph2TDSaw94R3mrWsSW3APmfRagI/IZgQV3yd9rBE6dahmi2ws
	 DR/MEo7MBMkRcvJMJ/eaKtGeeNnBc97QhpTwyhTl1/H/+aXyQWky2/wUIqnaO/t3/F
	 OUEAisZwhdZyQ==
Date: Mon, 29 Sep 2025 18:47:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
 <vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
 <rosenp@gmail.com>, <christophe.jaillet@wanadoo.fr>,
 <steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 0/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Message-ID: <20250929184700.50628a5f@kernel.org>
In-Reply-To: <20250929091302.106116-1-horatiu.vultur@microchip.com>
References: <20250929091302.106116-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 11:13:00 +0200 Horatiu Vultur wrote:
> The first patch will update the PHYs VSC8584, VSC8582, VSC8575 and VSC856X
> to use PHY_ID_MATCH_MODEL because only rev B exists for these PHYs.
> But for the PHYs VSC8574 and VSC8572 exists rev A, B, C, D and E.
> This is just a preparation for the second patch to allow the VSC8574 and
> VSC8572 to use the function vsc8584_probe().
> 
> We want to use vsc8584_probe() for VSC8574 and VSC8572 because this
> function does the correct PTP initialization. This change is in the second
> patch.

This doesn't apply cleanly to net. If it was generated against net-next
- perhaps wait a couple of days until trees converge before reposting?
-- 
pw-bot: cr

