Return-Path: <netdev+bounces-113193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936D93D2C4
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99E52818AE
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CBA17B41B;
	Fri, 26 Jul 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyE8l0a/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72A178399
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995624; cv=none; b=d+jhYyRYFSBKDVqY7fLiPE+UBHHrsvsS7Bp5r8/e5SSfjcmc1XYhYfx/DPDkVpUTST1jvP9LpfeW6fDSqtNQUeFCCvXuFDk3FvCKo1w2OhG91Ckj062UpTntYnFy8QskiCu26AknhBkPQkuCEC5gT3HNtwPaf2yCFeSC7BB/2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995624; c=relaxed/simple;
	bh=Qnti6MN/VkxTOBCQfUMUJjrKVzl+gAkHfmZCS7vXg7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PZyqzSExL88SnjikoKtDGagrklbWGJwA+ca8IMnXQai6JwaL5cMOwFcEBv9sl2luWa6nEjxd9xB/wf9kOWjkgLbDHnyWVa8e9q9kzxKMtqVvsCWJbokPZAFeVmd+/cBIS3IXwzay/tPT1SuDRWhLX1QBpXL1D80krlxGvZW3AE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyE8l0a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CFAC32782;
	Fri, 26 Jul 2024 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721995624;
	bh=Qnti6MN/VkxTOBCQfUMUJjrKVzl+gAkHfmZCS7vXg7I=;
	h=Date:From:To:Cc:Subject:From;
	b=uyE8l0a/EdG2pO9Aajfwr8+EZsO9gyCEquppBHXUZEfg6OcF2MExFORxH8hXSxwxU
	 gH4rxO2RJBXG3SCab8eLq7JJX6L6nRN8//ZG9FObRg118AJTp2nmdeM841Gyy9a8I7
	 kYpn+B4Zp5FsP3w1VaJ4x4MuKtdUbeKCZHMcBVULG+Hct3aDM1QvesTEmJDBTOreBb
	 hK84kMLGg/D0zF5uBn9d8tvqC9xZw46mxaa09W2NyRkG4nqaQNg+OfMJqMrq6CBq8N
	 74E9l25WJ84PhHSPMLuyyOwIG3OelpaA7CvCVLfEudB1oX35JwfnGVbuSuW5+GoqfW
	 gI8zeQLAW7IeQ==
Date: Fri, 26 Jul 2024 13:07:00 +0100
From: Simon Horman <horms@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: net: xilinx: axienet: Query about checksum partial implementation
Message-ID: <20240726120700.GA1694627@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Radhey, all,

I am wondering if you could shed some light on the following
checksum partial handling in the axienet_rx_poll():

                        /* if we're doing Rx csum offload, set it up */
                        if (lp->features & XAE_FEATURE_FULL_RX_CSUM) {
				...
                        } else if ((lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) != 0 &&
                                   skb->protocol == htons(ETH_P_IP) &&
                                   skb->len > 64) {
                                skb->csum = be32_to_cpu(cur_p->app3 & 0xFFFF);
                                ...
                        }

In particluar the "skb->csum =" line.

The type of cur_p->app3 is u32, and 0xFFFF is also host byte order.
So far so good. But after the bitwise operation it is treated
as a big-endian value by passing it to be32_to_cpu.

Perhaps I am missing something obvious, but my question is how does that work?

* Was it only tested on big endian sysgtems where be32_to_cpu() is a no-op

* Was it only tested on little endian systems where be32_to_cpu()
  is a byteswap and somehow that works (how?).

* Is the code unecessised because the XAE_FEATURE_FULL_RX_CSUM branch is
  always taken?

  A grep of dts files shows up arch/microblaze/boot/dts/system.dts which
  sets sets xlnx,rxcsum to 0, which corresponds to XAE_NO_CSUM_OFFLOAD.

* Something else

Flagged by Sparse

The in quesoitn code seems to have been introduced by
8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")



