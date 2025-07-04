Return-Path: <netdev+bounces-204195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E763BAF974D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C861BC7C7E
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B731DF982;
	Fri,  4 Jul 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFSPoo/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BA4501A;
	Fri,  4 Jul 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644342; cv=none; b=GsUOMCiyvbCmRtioYkBobePoE79fnI1TlsGu5sPG4a/RU2mkbdLUdXjFZOlhwREER14dvgGN30WZbeHG08hNdfuA43CFN5NY+IL84kUyvhxrg/NRvjPU2gwkT1aF69LVqgIBzjeN9w2X4O7S0xpXqbg6SSV9rBWAMeGjhS7KaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644342; c=relaxed/simple;
	bh=PqIUZzW3hHwEWkUH6fgIl0ek+eo73zsrYyKZoR9Fv6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb+NtZlY/5zxRrnxwzUOBBmsoCm9ynmPK7799e3qpC493/M+rJ4ke9HKMF9IJDcwKsWyov7MCutbyPyylFtxh7mv4SSwpBhrWCtmAHQkrs1gjiGDKgAqE4DPAnJA4dCWeKaiPxZcWjTCBzwgGMN4x3sk0A02DzK76hxCs9Tky3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFSPoo/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEB9C4CEE3;
	Fri,  4 Jul 2025 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751644342;
	bh=PqIUZzW3hHwEWkUH6fgIl0ek+eo73zsrYyKZoR9Fv6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFSPoo/PAr6t5QxwTQa93VHluA6zVV68bERPo2F9zwJD6o08v5Hh0nP0nPfs0FhvA
	 ofNKBk24ju9pWmn8wZ1rx5Fb18DWXisSM2TXl3Po+VHtVcv+tI9ijvUWVz7Re3q1I2
	 1VQ5lx9zuevQMdeAXr1O3l1MfW2ZZpF3EeXTFPn7Yw8mswb7Rfya73iVddfrk1Z6+5
	 s9O97IcnMhL3IlO2f3Hg0lmzldqOo4odLjfilacbtzWRO0VCoBUF5TtsmVD1JLkdi3
	 AYvGiUV/aczZIUlY23wRM4T3u/w7DBU31CENSvtesiXES9s/Unzz+umjBu3KhdgmCH
	 JE2dzoSCuL+9Q==
Date: Fri, 4 Jul 2025 16:52:16 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/4] net: hns3: fix concurrent setting vlan filter
 issue
Message-ID: <20250704155216.GF41770@horms.kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702130901.2879031-2-shaojijie@huawei.com>

On Wed, Jul 02, 2025 at 09:08:58PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> The vport->req_vlan_fltr_en may be changed concurrently by function
> hclge_sync_vlan_fltr_state() called in periodic work task and
> function hclge_enable_vport_vlan_filter() called by user configuration.
> It may cause the user configuration inoperative. Fixes it by protect
> the vport->req_vlan_fltr by vport_lock.
> 
> Fixes: fa6a262a2550 ("net: hns3: add support for VF modify VLAN filter state")

I think the commit sited above is for the VF driver, whereas this
patch addresses PF driver code. I think the following is the
correct tag:

Fixes: 2ba306627f59 ("net: hns3: add support for modify VLAN filter state")

> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


