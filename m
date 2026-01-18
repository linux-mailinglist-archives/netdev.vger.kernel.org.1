Return-Path: <netdev+bounces-250775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E8D39229
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2BCB300BED6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C13B2AA;
	Sun, 18 Jan 2026 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkC0leqU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B071B808;
	Sun, 18 Jan 2026 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768702554; cv=none; b=Sd70TAkGH/OUT94ilNo5CCikq3heB7g31wjo8EQ+qxpbWEjEgsFGFg7PY3MBtsCDeceIzdrdThHM63MZ78d1B2cYiKS1SPN2GUt8F5xCKWSyFsPdP75jIKMhgAYLkp+nMZiaFLpc0zIEYfezB4Hil2jOe21Go1dd8/+gZWRSaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768702554; c=relaxed/simple;
	bh=DkTAVOtDgAavmOBCWkEODfmCCxIZofGnZrL0HRHr1+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDsoEaJqGmyL7QNM32/HzWJbFTXe650OCfX8YwtHI2lOc+jSgaqgi01BE4fwjRw5a4iSjnQGHbk+3yvVu3JZWq/2RA5YmESavIZcFdWK4tKCS9nbSt2jKe8ahrRH5XmC8OiIfG7SS9pk+hGnacI9PajPM8OkKOVkarQcynZGkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkC0leqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52B3C4CEF7;
	Sun, 18 Jan 2026 02:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768702554;
	bh=DkTAVOtDgAavmOBCWkEODfmCCxIZofGnZrL0HRHr1+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkC0leqUxhwYx7c9VgSjbs4pehA7gDWJipY4nOB3v8Lj7P/i+eC5nHVlv320j9GT3
	 BfDGXuRszKLv6NkMGgyPybmhjCvSb1EKn11Lm/LMxbMpFRRT3KtE8TSaFoR7DfwxSu
	 0aMaCFYCQM3WGigDPntTsfXhQc5J57gW3z5Unee0nMISfGB9pXPbxUb4Z0p0ENQ/g1
	 91y95gJ2R5G44VmxP9Xvdl56Y1Ez4PAwdvoljSlOWK3Zg++D6K66bK4YtpG1ovXI0q
	 ZiE5bQm5MjqCXDJjFFKv+g5qIRCxEon/tTHgp9iw3YpIt0NWjvnPNVAmyKodfJJlrj
	 VcJY0r6o2ENoQ==
Date: Sat, 17 Jan 2026 18:15:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Sriharsha Basavapatna
 <sriharsha.basavapatna@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Shay Agroskin
 <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
 <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>, Bryan Whitehead
 <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/9] net: benet: convert to use
 .get_rx_ring_count
Message-ID: <20260117181551.0b139ca1@kernel.org>
In-Reply-To: <20260115-grxring_big_v2-v1-1-b3e1b58bced5@debian.org>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
	<20260115-grxring_big_v2-v1-1-b3e1b58bced5@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 06:37:48 -0800 Breno Leitao wrote:
> -static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
> -			u32 *rule_locs)
> -{
> -	struct be_adapter *adapter = netdev_priv(netdev);
> -
> -	if (!be_multi_rxq(adapter)) {
> -		dev_info(&adapter->pdev->dev,
> -			 "ethtool::get_rxnfc: RX flow hashing is disabled\n");
> -		return -EINVAL;
> -	}

I think we need to add this check to set_rxfh now. The error coming
from get_rxnfc/GRXRINGS effectively shielded the driver from set_rxfh
calls ever happening when there's only 1 ring. Now they will happen.

Applied the rest

