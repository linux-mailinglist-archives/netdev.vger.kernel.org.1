Return-Path: <netdev+bounces-246258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D4CE7FE9
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22EF53060884
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB7D334C35;
	Mon, 29 Dec 2025 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qWabikmz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143C308F36;
	Mon, 29 Dec 2025 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033585; cv=none; b=buULE5bWLF2HW27M92DyXLgAoKN0UMEQMZmbcpKBlfopI70lgknErLnNnr5dCyXxEw1BvzzuafG84QDYbo3FHDe2dxhdA8bmKA0cnT/6dijL3wKiyLXGGPd6umWchBEVwcxxAbmNw3X2Lry1Z2hYL2TpNy9wB5WDi/M237NA44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033585; c=relaxed/simple;
	bh=RlCvjgXQfyC7ApZl+L2NmQOn+nXcErpskISGgKt7WtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkCB9mcCpvo/6299E4FpHDsCMsmdsUPV0WCfSEHkDzK8ONoET0f+fN0xmQPdSNcOKasj86fEsg+VB187/r5acKHUid8w3NiOCmziesZNTnVcL7KRBpkUIB4RwjjidJlBQslTvcRqr6bPrGzBAM0HCMdneEgqjxcvIskCCoqFh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qWabikmz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9becA/iCsCNs2r9wSWFbwMFjyybIdKedPZ3x8RB00oI=; b=qWabikmz0dPqcDpPvpXw4yDvvn
	LVY9kUEjjybk9WB7Q+aUQ4C7iaJ3akoIhnrcdCUhjmR3T2mdIvRLkyYXPratSkSjZhPDTLw7eYp3W
	2eX8/IxzoEIAtsO5UfP/1b0xANYHuKsplQ6a6t1XXz1EgpGsa0gK4l6uVPVSJARYDkRI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vaI9R-000omE-P6; Mon, 29 Dec 2025 19:39:29 +0100
Date: Mon, 29 Dec 2025 19:39:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: yk@y-koj.net
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: netdevsim: fix inconsistent carrier state
 after link/unlink
Message-ID: <e8180dc5-fc23-4044-bd67-92fc3eebdaa0@lunn.ch>
References: <cover.1767032397.git.yk@y-koj.net>
 <ff1139d3236ab7fec2b2b3a2e22510dcd7b01a21.1767032397.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff1139d3236ab7fec2b2b3a2e22510dcd7b01a21.1767032397.git.yk@y-koj.net>

On Tue, Dec 30, 2025 at 03:32:34AM +0900, yk@y-koj.net wrote:
> From: Yohei Kojima <yk@y-koj.net>
> 
> This patch fixes the edge case behavior on ifup/ifdown and
> linking/unlinking two netdevsim interfaces:
> 
> 1. unlink two interfaces netdevsim1 and netdevsim2
> 2. ifdown netdevsim1
> 3. ifup netdevsim1
> 4. link two interfaces netdevsim1 and netdevsim2
> 5. (Now two interfaces are linked in terms of netdevsim peer, but
>     carrier state of the two interfaces remains DOWN.)
> 
> This inconsistent behavior is caused by the current implementation,
> which only cares about the "link, then ifup" order, not "ifup, then
> link" order. This patch fixes the inconsistency by calling
> netif_carrier_on() when two netdevsim interfaces are linked.
> 
> This patch solves buggy behavior on NetworkManager-based systems which
> causes the netdevsim test to fail with the following error:
> 
>   # timeout set to 600
>   # selftests: drivers/net/netdevsim: peer.sh
>   # 2025/12/25 00:54:03 socat[9115] W address is opened in read-write mode but only supports read-only
>   # 2025/12/25 00:56:17 socat[9115] W connect(7, AF=2 192.168.1.1:1234, 16): Connection timed out
>   # 2025/12/25 00:56:17 socat[9115] E TCP:192.168.1.1:1234: Connection timed out
>   # expected 3 bytes, got 0
>   # 2025/12/25 00:56:17 socat[9109] W exiting on signal 15
>   not ok 13 selftests: drivers/net/netdevsim: peer.sh # exit=1
> 
> This patch also fixes timeout on TCP Fast Open (TFO) test because the
> test also depends on netdevsim.
> 
> Fixes: 1a8fed52f7be ("netdevsim: set the carrier when the device goes up")

Stable rules say:

   It must either fix a real bug that bothers people or just add a device ID.

netdevsim is not a real device. Do its bugs actually bother people?
Should this patch have a Fixes: tag?

       Andrew

