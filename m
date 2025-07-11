Return-Path: <netdev+bounces-206192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B8B01F5D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF23C1CC029C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BBD287265;
	Fri, 11 Jul 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz8Vykjg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270196ADD;
	Fri, 11 Jul 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245010; cv=none; b=NG7vuYGYyDRxmgQNYL6rfv6+9TGlTfaxwhHM7URtvcGL+ZNztrAiATquNl+TBdOxqclcjCrgznXsdn9NjW4Stg2oJsmw7RG9fgZ1t2Wxo7c8Gn0kwntWXCzpTUypi6nDCMZ88tDV7jzctleKB8haFX/oxf6Eq3IisMOs7NFlhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245010; c=relaxed/simple;
	bh=UEqcf9BWe9KSrJPz14kGQMwOPOmc8OadmITUFSWpuEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYlZYy6kvun/kb3ol/RHwtemwdizOWCrhnrgHMFRN6bQz8gPbIWqRdWr1OyqDHGYVI83DOlhcULwXGi//7XWZQNdv9SPQ0eoMr+D+ILnIqI9MAigTgBOn+dcskhend46wLbZhx8XOeF5MHJZBXGOh0bDLxHX8Jc/+bBJKmLCIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz8Vykjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B982C4CEF0;
	Fri, 11 Jul 2025 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752245009;
	bh=UEqcf9BWe9KSrJPz14kGQMwOPOmc8OadmITUFSWpuEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz8VykjguiAuVoV0hyJ3PDMgg7yAmfztLYWKJncQAujXcfRYc+kNt3brvzbT9mrQr
	 AoTZ61ZcWxsrcWUchqUjn1BbWSSCdumE55cPlAKNS+v6Tv2xkexyoowYoafUKd3DzI
	 U1F+2HQ0Bm2e2HBXXSQo811niX5aGl72URCbAQ/YeQ0Tf9oKI+auExS2hxYU65V/dZ
	 bI4XZPP2obDEOwXc9NE+EssbLNyejXj0hMmoLwL/JhJzrURHLD85K0KQjInQw0w3hS
	 viMtmI6ksFRptGf0lg7tnPBCNcN7wfkS+qDlnapO3FZlVmUFZ4DwQvG/PwzBY4HwfJ
	 5CdWWhQa0J0/g==
Date: Fri, 11 Jul 2025 15:43:23 +0100
From: Simon Horman <horms@kernel.org>
To: Himanshu Mittal <h-mittal1@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
	m-malladi@ti.com, pratheesh@ti.com, prajith@ti.com
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
Message-ID: <20250711144323.GV721198@horms.kernel.org>
References: <20250710131250.1294278-1-h-mittal1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710131250.1294278-1-h-mittal1@ti.com>

On Thu, Jul 10, 2025 at 06:42:50PM +0530, Himanshu Mittal wrote:
> Fixes overlapping buffer allocation for ICSSG peripheral
> used for storing packets to be received/transmitted.
> There are 3 buffers:
> 1. Buffer for Locally Injected Packets
> 2. Buffer for Forwarding Packets
> 3. Buffer for Host Egress Packets
> 
> In existing allocation buffers for 2. and 3. are overlapping causing packet
> corruption.
> 
> Packet corruption observations:
> During tcp iperf testing, due to overlapping buffers the received ack
> packet overwrites the packet to be transmitted. So, we see packets on wire
> with the ack packet content inside the content of next TCP packet from
> sender device.
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

Thanks for the detailed explanation with these tables.
It is very helpful. I follow both the existing and new mappings
with their help. Except for one thing.

It's not clear how EXP was set to the values on the line above.
Probably I'm missing something very obvious.
Could you help me out here?

> | PRE | 70030000   | 70033800 | 70034000   | 70037800 |
> +-----+------------+----------+------------+----------+
> 
> +---------------------+----------+----------+
> |                     | SLICE 0  |  SLICE 1 |
> +---------------------+----------+----------+
> | Default Drop Offset | 00000000 | 00000000 |     <-- Field not configured
> +---------------------+----------+----------+

...

