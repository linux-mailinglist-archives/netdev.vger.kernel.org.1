Return-Path: <netdev+bounces-208185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1587B0A65B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C653A2135
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031302DC32D;
	Fri, 18 Jul 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpqpYlSK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03513398B;
	Fri, 18 Jul 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848864; cv=none; b=jg3w8d0Inu4wJ3qc5LgJpHZjQGl98u1oAFQKKtVcwU/0AhZDwr1oqHs39PTaK+vp3ZHjjJ7rFhTT633bHIO+FSWPxolVjCb06Lh6mcEwY0hPmACHtV0pj3/SeEe4Fej9UO1HplMUROQGe3knqtUDit4mI0QAKZ/uvJ1ythfNF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848864; c=relaxed/simple;
	bh=OnxfV2yPEQVTv3ciBTrkkEXKVRS4lJt/Hwo5k2TvS+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGb/I9/Fu3htTARrlXXOiWPn8FmJv6FOIx1IZebeK6hA0hHKX/L6x0ZvHmaV6c+4f3bp8Eed149WjxqdI6HClhJhENP1EJ7IBRhl/cuGTNWgZm6bNih8z5FIhBoz3M1LAP5Q/LDJIIRM8Q4BSKXgNtH4Hr0GuPNijamDQd40BHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpqpYlSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F856C4CEEB;
	Fri, 18 Jul 2025 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752848864;
	bh=OnxfV2yPEQVTv3ciBTrkkEXKVRS4lJt/Hwo5k2TvS+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpqpYlSKyInOvbiMDs64WIZazYcsXfGEF5wAu3XhfYchOKHJ2U2M0wtuP86c4aFvG
	 nrUlAcH5WpOlDuZGAK0+iBwCYanToDXMxe0khgDz/PW72ZnJC4TAo5li5LAiZ+HQrO
	 QnvXSgQms2eMnTdzs4TLlc5rsZjbZp1anpZ6mqUjbwqKSZKj/aEc8b/zt4Z1Vvbuxv
	 Hb6snd5Mkh0365llavrBzHGuAxohxjZ4EfdMrqXwW4DJAYGaFcc/aGCajJOSZ/3WBq
	 gSWFlGCdagzcUnz909IN35j7TiqN/iNPLvepKR3xzK4bvVcid9+BZneRwyNBtrnIE4
	 0yJ76B4jfOvjg==
Date: Fri, 18 Jul 2025 15:27:39 +0100
From: Simon Horman <horms@kernel.org>
To: Himanshu Mittal <h-mittal1@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
	m-malladi@ti.com, pratheesh@ti.com, prajith@ti.com
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
Message-ID: <20250718142739.GD2459@horms.kernel.org>
References: <20250717094220.546388-1-h-mittal1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717094220.546388-1-h-mittal1@ti.com>

On Thu, Jul 17, 2025 at 03:12:20PM +0530, Himanshu Mittal wrote:
> Fixes overlapping buffer allocation for ICSSG peripheral
> used for storing packets to be received/transmitted.
> There are 3 buffers:
> 1. Buffer for Locally Injected Packets
> 2. Buffer for Forwarding Packets
> 3. Buffer for Host Egress Packets
> 
> In existing allocation buffers for 2. and 3. are overlapping causing
> packet corruption.
> 
> Packet corruption observations:
> During tcp iperf testing, due to overlapping buffers the received ack
> packet overwrites the packet to be transmitted. So, we see packets on
> wire with the ack packet content inside the content of next TCP packet
> from sender device.
> 
> Details for AM64x switch mode:
> -> Allocation by existing driver:
> +---------+-------------------------------------------------------------+
> |         |          SLICE 0             |          SLICE 1             |
> |         +------+--------------+--------+------+--------------+--------+
> |         | Slot | Base Address | Size   | Slot | Base Address | Size   |
> |---------+------+--------------+--------+------+--------------+--------+
> |         | 0    | 70000000     | 0x2000 | 0    | 70010000     | 0x2000 |
> |         | 1    | 70002000     | 0x2000 | 1    | 70012000     | 0x2000 |
> |         | 2    | 70004000     | 0x2000 | 2    | 70014000     | 0x2000 |
> | FWD     | 3    | 70006000     | 0x2000 | 3    | 70016000     | 0x2000 |
> | Buffers | 4    | 70008000     | 0x2000 | 4    | 70018000     | 0x2000 |
> |         | 5    | 7000A000     | 0x2000 | 5    | 7001A000     | 0x2000 |
> |         | 6    | 7000C000     | 0x2000 | 6    | 7001C000     | 0x2000 |
> |         | 7    | 7000E000     | 0x2000 | 7    | 7001E000     | 0x2000 |
> +---------+------+--------------+--------+------+--------------+--------+
> |         | 8    | 70020000     | 0x1000 | 8    | 70028000     | 0x1000 |
> |         | 9    | 70021000     | 0x1000 | 9    | 70029000     | 0x1000 |
> |         | 10   | 70022000     | 0x1000 | 10   | 7002A000     | 0x1000 |
> | Our     | 11   | 70023000     | 0x1000 | 11   | 7002B000     | 0x1000 |
> | LI      | 12   | 00000000     | 0x0    | 12   | 00000000     | 0x0    |
> | Buffers | 13   | 00000000     | 0x0    | 13   | 00000000     | 0x0    |
> |         | 14   | 00000000     | 0x0    | 14   | 00000000     | 0x0    |
> |         | 15   | 00000000     | 0x0    | 15   | 00000000     | 0x0    |
> +---------+------+--------------+--------+------+--------------+--------+
> |         | 16   | 70024000     | 0x1000 | 16   | 7002C000     | 0x1000 |
> |         | 17   | 70025000     | 0x1000 | 17   | 7002D000     | 0x1000 |
> |         | 18   | 70026000     | 0x1000 | 18   | 7002E000     | 0x1000 |
> | Their   | 19   | 70027000     | 0x1000 | 19   | 7002F000     | 0x1000 |
> | LI      | 20   | 00000000     | 0x0    | 20   | 00000000     | 0x0    |
> | Buffers | 21   | 00000000     | 0x0    | 21   | 00000000     | 0x0    |
> |         | 22   | 00000000     | 0x0    | 22   | 00000000     | 0x0    |
> |         | 23   | 00000000     | 0x0    | 23   | 00000000     | 0x0    |
> +---------+------+--------------+--------+------+--------------+--------+
> --> here 16, 17, 18, 19 overlapping with below express buffer
> 
> +-----+-----------------------------------------------+
> |     |       SLICE 0       |        SLICE 1          |
> |     +------------+----------+------------+----------+
> |     | Start addr | End addr | Start addr | End addr |
> +-----+------------+----------+------------+----------+
> | EXP | 70024000   | 70028000 | 7002C000   | 70030000 | <-- Overlapping
> | PRE | 70030000   | 70033800 | 70034000   | 70037800 |
> +-----+------------+----------+------------+----------+
> 
> +---------------------+----------+----------+
> |                     | SLICE 0  |  SLICE 1 |
> +---------------------+----------+----------+
> | Default Drop Offset | 00000000 | 00000000 |     <-- Field not configured
> +---------------------+----------+----------+
> 
> -> Allocation this patch brings:
> +---------+-------------------------------------------------------------+
> |         |          SLICE 0             |          SLICE 1             |
> |         +------+--------------+--------+------+--------------+--------+
> |         | Slot | Base Address | Size   | Slot | Base Address | Size   |
> |---------+------+--------------+--------+------+--------------+--------+
> |         | 0    | 70000000     | 0x2000 | 0    | 70040000     | 0x2000 |
> |         | 1    | 70002000     | 0x2000 | 1    | 70042000     | 0x2000 |
> |         | 2    | 70004000     | 0x2000 | 2    | 70044000     | 0x2000 |
> | FWD     | 3    | 70006000     | 0x2000 | 3    | 70046000     | 0x2000 |
> | Buffers | 4    | 70008000     | 0x2000 | 4    | 70048000     | 0x2000 |
> |         | 5    | 7000A000     | 0x2000 | 5    | 7004A000     | 0x2000 |
> |         | 6    | 7000C000     | 0x2000 | 6    | 7004C000     | 0x2000 |
> |         | 7    | 7000E000     | 0x2000 | 7    | 7004E000     | 0x2000 |
> +---------+------+--------------+--------+------+--------------+--------+
> |         | 8    | 70010000     | 0x1000 | 8    | 70050000     | 0x1000 |
> |         | 9    | 70011000     | 0x1000 | 9    | 70051000     | 0x1000 |
> |         | 10   | 70012000     | 0x1000 | 10   | 70052000     | 0x1000 |
> | Our     | 11   | 70013000     | 0x1000 | 11   | 70053000     | 0x1000 |
> | LI      | 12   | 00000000     | 0x0    | 12   | 00000000     | 0x0    |
> | Buffers | 13   | 00000000     | 0x0    | 13   | 00000000     | 0x0    |
> |         | 14   | 00000000     | 0x0    | 14   | 00000000     | 0x0    |
> |         | 15   | 00000000     | 0x0    | 15   | 00000000     | 0x0    |
> +---------+------+--------------+--------+------+--------------+--------+
> |         | 16   | 70014000     | 0x1000 | 16   | 70054000     | 0x1000 |
> |         | 17   | 70015000     | 0x1000 | 17   | 70055000     | 0x1000 |
> |         | 18   | 70016000     | 0x1000 | 18   | 70056000     | 0x1000 |
> | Their   | 19   | 70017000     | 0x1000 | 19   | 70057000     | 0x1000 |
> | LI      | 20   | 00000000     | 0x0    | 20   | 00000000     | 0x0    |
> | Buffers | 21   | 00000000     | 0x0    | 21   | 00000000     | 0x0    |
> |         | 22   | 00000000     | 0x0    | 22   | 00000000     | 0x0    |
> |         | 23   | 00000000     | 0x0    | 23   | 00000000     | 0x0    |
> +---------+------+--------------+--------+------+--------------+--------+
> 
> +-----+-----------------------------------------------+
> |     |       SLICE 0       |        SLICE 1          |
> |     +------------+----------+------------+----------+
> |     | Start addr | End addr | Start addr | End addr |
> +-----+------------+----------+------------+----------+
> | EXP | 70018000   | 7001C000 | 70058000   | 7005C000 |
> | PRE | 7001C000   | 7001F800 | 7005C000   | 7005F800 |
> +-----+------------+----------+------------+----------+
> 
> +---------------------+----------+----------+
> |                     | SLICE 0  |  SLICE 1 |
> +---------------------+----------+----------+
> | Default Drop Offset | 7001F800 | 7005F800 |
> +---------------------+----------+----------+
> 
> Rootcause: missing buffer configuration for Express frames in
> function: prueth_fw_offload_buffer_setup()
> 
> Details:
> Driver implements two distinct buffer configuration functions that are
> invoked based on the driver state and ICSSG firmware:-
> - prueth_fw_offload_buffer_setup()
> - prueth_emac_buffer_setup()
> 
> During initialization, driver creates standard network interfaces
> (netdevs) and configures buffers via prueth_emac_buffer_setup().
> This function properly allocates and configures all required memory
> regions including:
> - LI buffers
> - Express packet buffers
> - Preemptible packet buffers
> 
> However, when the driver transitions to an offload mode (switch/HSR/PRP),
> buffer reconfiguration is handled by prueth_fw_offload_buffer_setup().
> This function does not reconfigure the buffer regions required for
> Express packets, leading to incorrect buffer allocation.
> 
> Fixes: abd5576b9c57 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
> Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>

Thanks for the updated patch description.

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I did spend some time looking over the mappings described
above and correlating them with both the code and the "Details" above.
I agree with the analysis above and that the patchset addresses
the problem as described.

...

