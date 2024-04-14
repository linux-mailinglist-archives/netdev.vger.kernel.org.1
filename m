Return-Path: <netdev+bounces-87686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349D8A4160
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 11:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4641F21C63
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2721A06;
	Sun, 14 Apr 2024 09:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFF22F1C
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085338; cv=none; b=b3Xx50p0pqYAnF0oxyPvdsr0L4QA/14LwaeL6XChhb5k5IdNDmTDbi2IxEW3WI/+5TyiIyfm/vh/lJD92H1N1JpozsNZ3Dx72GMiVRhMgD1Ltc/wyhJbEUV5mwvl9Eb1YZKWdXjN/TSqeUfHSj8YaM5SXbQVXl0ZdTY1IGLZB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085338; c=relaxed/simple;
	bh=5EBOVlz6g0+BDHj6NlnzUd7o+7ETS/IAXoZ/V+ChMR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4eedErGHFK4+HKIMi8KR2Evb76MvE7SKv+h6ZWLLOZTK6NP3/fdBEwbct2D4awpr/+PqlsC8MzT52tF1vXDkZy291CxHAY7xLRXxnrx5pHDTHNm+lP5S4Y4FCGb16qCQ79wRrH8s8nd4mOWBP7n+taUCeNeRnzFWZUyesNn6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B0CB43001F874;
	Sun, 14 Apr 2024 11:02:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8F6CBEE4D; Sun, 14 Apr 2024 11:02:06 +0200 (CEST)
Date: Sun, 14 Apr 2024 11:02:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kurt Kanzenbach <kurt@linutronix.de>,
	Roman Lozko <lozko.roma@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, Sasha Neftin <sasha.neftin@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] igc: Fix deadlock on module removal
Message-ID: <Zhubjkscu9HPgUcA@wunner.de>
References: <20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-igc_led_deadlock-v1-1-0da98a3c68c5@linutronix.de>

[cc += Roman Lozko who originally reported the issue]

On Sun, Apr 14, 2024 at 09:44:10AM +0200, Kurt Kanzenbach wrote:
> unregister_netdev() acquires the RNTL lock and releases the LEDs bound
> to that netdevice. However, netdev_trig_deactivate() and later
> unregister_netdevice_notifier() try to acquire the RTNL lock again.
> 
> Avoid this situation by not using the device-managed LED class
> functions.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

This patch is almost a 1:1 copy of the patch I submitted on April 5:

https://lore.kernel.org/all/ZhBN9p1yOyciXkzw@wunner.de/

I think it is mandatory that you include a Signed-off-by with my name
in that case.  Arguably the commit author ("From:") should also be me.

Moreover this is missing a Reported-by tag with Roman Lozko's name.

AFAICS the only changes that you made are:
- rename igc_led_teardown() to igc_led_free()
- rename ret to err
- replace devm_kcalloc() with kcalloc()
  (and you introduced a memory leak while doing so, see below)

Honestly I don't see how those small changes justify omitting a
Signed-off-by or assuming authorship.

I would have been happy to submit a patch myself, I was waiting
for a Tested-by from Roman or you.


> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -164,6 +164,8 @@ struct igc_ring {
>  	struct xsk_buff_pool *xsk_pool;
>  } ____cacheline_internodealigned_in_smp;
>  
> +struct igc_led_classdev;

Unnecessary forward declaration, this compiled fine for me without it.


>  int igc_led_setup(struct igc_adapter *adapter)
>  {
>  	struct net_device *netdev = adapter->netdev;
> -	struct device *dev = &netdev->dev;
>  	struct igc_led_classdev *leds;
> -	int i;
> +	int i, err;
>  
>  	mutex_init(&adapter->led_mutex);
>  
> -	leds = devm_kcalloc(dev, IGC_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
> +	leds = kcalloc(IGC_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
>  	if (!leds)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < IGC_NUM_LEDS; i++)
> -		igc_setup_ldev(leds + i, netdev, i);
> +	for (i = 0; i < IGC_NUM_LEDS; i++) {
> +		err = igc_setup_ldev(leds + i, netdev, i);
> +		if (err)
> +			goto err;
> +	}
> +
> +	adapter->leds = leds;
>  
>  	return 0;
> +
> +err:
> +	for (i--; i >= 0; i--)
> +		led_classdev_unregister(&((leds + i)->led));
> +
> +	return err;
> +}

"leds" allocation is leaked in the error path.

This memory leak was not present in my original patch.  Not good!

Thanks,

Lukas

