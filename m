Return-Path: <netdev+bounces-124345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E5969146
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 04:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257031F22B93
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A519C54B;
	Tue,  3 Sep 2024 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf58l3ZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D7175B1;
	Tue,  3 Sep 2024 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725329068; cv=none; b=ZDcDQsZ1oH1atdXJIYsuHE8tSsQjCY2PaBvyH37oQgv+7xppg7Kg6AQ5nJS4YY6UVTEHGOncZ/ETW6sY3CTa5FnuBx5XwbrhexqM5ipg5AaMPSsTGF5nJY5JR+hwDWoORIgldEKtGYXWJD7RWf3JHk7Iusx+ilX6Is8pK6j+Rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725329068; c=relaxed/simple;
	bh=f6r63VNlYByyDFTmFXU7r1//1x15PRIiieh8kXz1qd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMw/mCqkTz2WVjJHtMfW2OFzm3vFag1Qe/SYqt0Kjzldb08hNRK9VqhyXgTQv3WRwMl1hREL5zD8KgVpgP9VH3NIgVVGTYUspRnJyUmDysTTiTzD+A9kdZ+RyB03ISYURRa3cqqvOF6u+GibQq9NjlCzM4YBvdMF/UosOX5faTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf58l3ZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ACBC4CEC2;
	Tue,  3 Sep 2024 02:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725329067;
	bh=f6r63VNlYByyDFTmFXU7r1//1x15PRIiieh8kXz1qd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gf58l3ZB2ux3D/Sy3fpWZWNoHH4opkXAvKDRP738HcsFdSpCioZpRkUbBekZ7sXpI
	 BrQKt5s7nhgasyMhGbom1JeMQLpWQsjnOG6nXNKtghQ7hUdI1PgHotN2nox3Sq3KAy
	 nHPXDOpl6hW+bEl874KLI+KQYJVad4lI1MvWO5z5lUg2zHkdREWgB7PaH8UKPxx3lh
	 wrLS7TmlpaRBDWS7ie5BN+KV/66yuq62ggyHt6aP8GLSgj+QRP0FimHp+HeLEuICPw
	 ur41zFldQYkRH+yppUxMpg9DlEEaanHbMRxDmv5ZABW2UyXSm3F9d+oMmwMgbEmfpd
	 M9IHEKfoPOqrA==
Date: Mon, 2 Sep 2024 19:04:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <jdamato@fastly.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v29 07/13] rtase: Implement a function to
 receive packets
Message-ID: <20240902190425.6eef2ee6@kernel.org>
In-Reply-To: <20240829034832.139345-8-justinlai0215@realtek.com>
References: <20240829034832.139345-1-justinlai0215@realtek.com>
	<20240829034832.139345-8-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 11:48:26 +0800 Justin Lai wrote:
> +		skb->dev = dev;

no need to assign skb->dev = dev; eth_type_trans() will do it for you

> +		skb_put(skb, pkt_size);
> +		skb_mark_for_recycle(skb);
> +		skb->protocol = eth_type_trans(skb, dev);
> +
> +		if (skb->pkt_type == PACKET_MULTICAST)
> +			tp->stats.multicast++;
> +
> +		rtase_rx_vlan_skb(desc, skb);
> +		rtase_rx_skb(ring, skb);
> +
> +		dev_sw_netstats_rx_add(dev, pkt_size);
> +
> +skip_process_pkt:
> +		workdone++;
> +		cur_rx++;
> +		entry = cur_rx % RTASE_NUM_DESC;
> +		desc = ring->desc + sizeof(union rtase_rx_desc) * entry;
> +	} while (workdone != budget);

The check needs to be at the start of the function.
NAPI can be called with budget of 0 to limit the processing 
to just Tx cleanup. In that case no packet should be received.

