Return-Path: <netdev+bounces-217368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D6B3875F
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666C817DF28
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B030FC1E;
	Wed, 27 Aug 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrkvv4e7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC9530100E;
	Wed, 27 Aug 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310903; cv=none; b=le7bxZOGaBQu7CV9SOURMwWo4xDIfaGRQp/UTHl12+6PCxe8TkPp1k6e7lzE5SwroQQY3Iv+AzG2zVAYBGYTjzzqjmvMNmpZNp7EQgiy2cEZgzk+FlcoEc1g9d6yGHVNnMyhtnWDjdjOoetKlFLdz8RtVraTpatKmtxOKsFC51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310903; c=relaxed/simple;
	bh=SxfV7g3bJ3UTbiAX8JrQoOzoxVhuSn7Pvqg2XycEaKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhsrg3LxhOg4DQ/eW7VzIRubgfKPhOmUkNwwNctSQ0GhGvx5zFUmKhT9JJrhOWGTLYrGFAjmpde7eeOUZrOf2gOp5uqWiE5QtcQS2A3PqGmKdbGSjAMcLuIiJlTsSp4/9yJ3pVUYakdSm/bSkanBGN91dX3/H03kCtQz+/0WUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrkvv4e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4E8C4CEEB;
	Wed, 27 Aug 2025 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310902;
	bh=SxfV7g3bJ3UTbiAX8JrQoOzoxVhuSn7Pvqg2XycEaKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lrkvv4e7eJQy4Zz5yfvpinu/QMxwq/F8HNUwdmLBYgqHcq+FrQRwdSjHI/2hfYUXh
	 bqPW0Ugqtkbytgn+i8GsSDSGSLvyBmdQkZXfr2cEyjJrrcVRqcfyyaoGjuN2cIPssx
	 J0TY/n+tPQusZrDU3Dxo3AYCDWo5Ami7+Rih3hT6ZYAL+n+50F3vVm0riyeIGJMicK
	 KG9aS6zxE6emkOMe1JIxRy5YlI98UClzkWAFzf0KPxH4GeJ3r3gqXHZVj4rShTTFpK
	 6gRK8WpLbR1w1AxwE6e4UtZKFJqO81EjSl2tb3z2tUhwfA5UfnkEjHmpBOV/12Vc+J
	 iixZ9MZ9UQG7g==
Date: Wed, 27 Aug 2025 09:08:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ssantosh@kernel.org, richardcochran@gmail.com, m-malladi@ti.com,
 s.hauer@pengutronix.de, afd@ti.com, jacob.e.keller@intel.com,
 horms@kernel.org, johan@kernel.org, m-karicheri2@ti.com, s-anna@ti.com,
 glaroque@baylibre.com, saikrishnag@marvell.com, kory.maincent@bootlin.com,
 diogo.ivo@siemens.com, javier.carrasco.cruz@gmail.com,
 basharath@couthit.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
 alok.a.tiwari@oracle.com, bastien.curutchet@bootlin.com, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v14 4/5] net: ti: icssm-prueth: Adds link
 detection, RX and TX support.
Message-ID: <20250827090820.12a58d22@kernel.org>
In-Reply-To: <20250822144023.2772544-5-parvathi@couthit.com>
References: <20250822132758.2771308-1-parvathi@couthit.com>
	<20250822144023.2772544-5-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 20:09:16 +0530 Parvathi Pudi wrote:
> +	struct net_device_stats *ndevstats;

> +	ndevstats = &emac->ndev->stats;

Please don't use netdev stats, quoting the header:

	struct net_device_stats	stats; /* not used by modern drivers */

Store the counters you need in driver's private struct and implement
.ndo_get_stats64

> +	if (!pkt_info->sv_frame) {

sv_frame seems to always be false at this stage?
Maybe delete this diff if that's the case, otherwise it feels like
the skb_free below should be accompanied by some stat increment.

> +		skb_put(skb, actual_pkt_len);
> +
> +		/* send packet up the stack */
> +		skb->protocol = eth_type_trans(skb, ndev);
> +		netif_receive_skb(skb);
> +	} else {
> +		dev_kfree_skb_any(skb);
> +	}

The rest LGTM.

