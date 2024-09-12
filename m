Return-Path: <netdev+bounces-127616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6366975DF0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868E81F236CF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A5D15CB;
	Thu, 12 Sep 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9zA0104"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DE10E4;
	Thu, 12 Sep 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726100573; cv=none; b=duwYdEQ30alTQGjGc1O1NZhzJFZ1HOB7xRDnGBT6lmxd7e5/4UK6DicnJCK5g5gCW/d4w2NMGQC8OcwU6YAHO3dxMaDOzzKQ2Y80iPvpjQXG3Q43xzL5vqiVerN1I+WhM+j4D6cy2LXgKNRqO+efi4X6XMqO76R3qxdEcDYKBlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726100573; c=relaxed/simple;
	bh=8cMjrqHTWFzw+KhmPj8s2jY6qjIvJKaLHiyrEaJXs4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+5RwloeLTIecLwpE5Na0bEliBZ+dIlF5s3n12HNyOkkufyvb+noz5asyqjq2WKWbPvLTX9zkkGtiW9wT3zXgPWEN/nF3wfrcR2rK4vK8RTTlxn4dk9cDCZW7Si9ebtiq79TCryXor1TaRmk5GRM37Qsq4Mjbwb5HMUythZiXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9zA0104; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEA4C4CEC5;
	Thu, 12 Sep 2024 00:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726100572;
	bh=8cMjrqHTWFzw+KhmPj8s2jY6qjIvJKaLHiyrEaJXs4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9zA01047YrfJghz1RE6O0b3a45xLYYpp4iigdxVj+dK5JH63r5KCmk9Uh1XYMHmS
	 ACreeVMQzlF55dCJdKcqHNa3Zgt1yztm9dldKhrRgLbDu0GxpsviyY7pIjWC4T/yeo
	 S+aSXXLJJ7DRkSJCMP9SazP/v/qE4jSGZlXclrSTbjadrMjXBUEfzf37bnO1xaFw8h
	 EQyE9QfKfJeMb+SbCtptDGUlNLhUouGWSPScr2djqsJdTxNTPwTY4aSGqp1z4vMab4
	 kwBfZSo5Zb7i3flIBtbrxkr95ZMIi7IKc1tK7ea+8H7l6XtoXLzUOyPpIfJ1cJfbAK
	 YChPpEScWQaGg==
Date: Wed, 11 Sep 2024 17:22:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Brett Creeley <bcreeley@amd.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, corbet@lwn.net,
 michael.chan@broadcom.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, hkallweit1@gmail.com,
 kory.maincent@bootlin.com, ahmed.zaki@intel.com, paul.greenwalt@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, aleksander.lobakin@intel.com, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next v2 1/4] bnxt_en: add support for rx-copybreak
 ethtool command
Message-ID: <20240911172251.4d57b851@kernel.org>
In-Reply-To: <CAMArcTVH9fRU3kHf8g4U+e3fawMGiBNy1UctWG1Ni5rS=x6QQA@mail.gmail.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
	<20240911145555.318605-2-ap420073@gmail.com>
	<a5939151-adc6-4385-9072-ce4ff57bf67f@amd.com>
	<CAMArcTVH9fRU3kHf8g4U+e3fawMGiBNy1UctWG1Ni5rS=x6QQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 00:53:31 +0900 Taehee Yoo wrote:
> > if (netif_running(dev)) {
> > bnxt_close_nic(bp, false, false);
> > bp->rx_copybreak = rx_copybreak;
> > bnxt_set_ring_params(bp);
> > bnxt_open_nic(bp, false, false);
> > } else {
> > bp->rx_copybreak = rx_copybreak;
> > }  
> 
> I think your suggestion is much safer!
> I will use your suggestion in the v3 patch.

This is better but Andy mentioned on another thread that queue reset
should work, so instead of full close / open maybe we can just do:

	for (/* all Rx queues */) {
		bnxt_queue_stop();
		bnxt_queue_start();
	}

when the device is already running?

