Return-Path: <netdev+bounces-163790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA3A2B921
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA2B1664F1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD721519B4;
	Fri,  7 Feb 2025 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD9fAU4r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945847E9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895847; cv=none; b=W3LQD+CPngP7Ar/4k416IOrnClPX2zF5/uBbzlsZTPTDoEQGADMc6VIRHEilDnD8TsO2oZydHNP5HufC2dIzcybgvjmFtt8piAcKG2CoJ1Sq0cnSo7K7YTykKD2IFZNlug7pS5n2cBmzmQt8/laHlgJCT6A/mXf3g8ly3KPn4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895847; c=relaxed/simple;
	bh=IpOs8bZ1l+1vPpWpZ68iIFwqWwg5GZcdljkc6X5jQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tz0jdQcXOCqFP2nxFQq9r4+7Y/fNRJ96JtD51gvlGpDz/GGEmnm6V3dwJ2ub8bew3u+b4V65Itq10BKQOnvBhEfUnGmO/uAx0mL3Nv/K/OSE08/Mp+7DcTndgMMggMkDdb9/xmYZDCmPyfHt8bwLEr+I14dQuSf2r3MU/ZZ98IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD9fAU4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDF1C4CEDD;
	Fri,  7 Feb 2025 02:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738895847;
	bh=IpOs8bZ1l+1vPpWpZ68iIFwqWwg5GZcdljkc6X5jQUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OD9fAU4rrXS6DO+oUKUbCR3VXB87MKi30VaUdgAg73bSkcQ0qS5DO6C1NdgTOdbQs
	 p18r2gv6WDhuF9COK8dcOZyhE4wRl4wrqNwFdNeecQQSjC1AsZT/Te7REDRfklBKqZ
	 yp7Wc4Tg++QLrkgMgunNApTE3esj0KmFeiQYNtPDN6T8R4UE+M3FqtI5b/yoNIHAGz
	 SKB74SPsKdXgjoQOm1koOuUfGiNPLLIrWDQ7OHN5DhVbXw07HooaUvgSw2KWtDGFCR
	 g3g1XklIr3yzEIn5Wrc/gURBV4T9knlCvuJUXDSVu1H7LBMXLIrdUFJVViEAUBYaaK
	 Y0aFyoDrE2xWg==
Date: Thu, 6 Feb 2025 18:37:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v7 2/5] net: napi: add CPU affinity to
 napi_config
Message-ID: <20250206183725.7da19b5c@kernel.org>
In-Reply-To: <20250204220622.156061-3-ahmed.zaki@intel.com>
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
	<20250204220622.156061-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Feb 2025 15:06:19 -0700 Ahmed Zaki wrote:
> + *	@irq_affinity_auto: driver wants the core to manage the IRQ affinity.

"manage" is probably too strong? "store" or "remember" ?
Your commit message explains it quite nicely.

> + *			    Set by netif_enable_irq_affinity(), then driver must
> + *			    create persistent napi by netif_napi_add_config()
> + *			    and finally bind napi to IRQ (netif_napi_set_irq).
> + *
>   *	@rx_cpu_rmap_auto: driver wants the core to manage the ARFS rmap.
>   *	                   Set by calling netif_enable_cpu_rmap().
>   *
> @@ -2402,6 +2406,7 @@ struct net_device {
>  	struct lock_class_key	*qdisc_tx_busylock;
>  	bool			proto_down;
>  	bool			threaded;
> +	bool			irq_affinity_auto;
>  	bool			rx_cpu_rmap_auto;
>  
>  	/* priv_flags_slow, ungrouped to save space */
> @@ -2662,6 +2667,11 @@ static inline void netdev_set_ml_priv(struct net_device *dev,
>  	dev->ml_priv_type = type;
>  }
>  
> +static inline void netif_enable_irq_affinity(struct net_device *dev)

Similar here, "enable affinity" is a bit strong.

netif_remember_irq_affinity() would be more accurate IMHO

> +{
> +	dev->irq_affinity_auto = true;
> +}

