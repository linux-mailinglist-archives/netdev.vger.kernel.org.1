Return-Path: <netdev+bounces-251205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4077AD3B4BE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15041300899D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60232D0C9;
	Mon, 19 Jan 2026 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB+bXX/2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DB311979;
	Mon, 19 Jan 2026 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844717; cv=none; b=ttLpLD0uTNVGDJ+grSgMGp/9Rm6Fp040u0XJkY7yQM/ju5ZhDdxqyoRYJs5nQpJ4guvsZJDEsOb5rbEMfhg5+V71HYtZ2BIsEeILBWHyxhsxjgi7K7SZWYZrAjC74CY/0rHDNV2OR+MbfHiT5+WaSRJLasvRAYiE96lUImRvJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844717; c=relaxed/simple;
	bh=QZppzWwMaxmLDfvLc0EL4sJUn0FxeL+jQ+zzwKRWA+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V169AkD/l/E419CH8uG1SR7iAzTlsvFVaLFekDJ4Bas29H3ZKxxTfMvEVa8ffSDLkkt3Zd+0WXM2BwlD+cOKUIvat0nUUbaJj3B/FYMTN/qHHVzOTyJXfvEvHUXJTCD3irBay8cKorgQe6en1tVaoKuqsRlb1+hdrgJWUWw7R5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB+bXX/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907E0C116C6;
	Mon, 19 Jan 2026 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768844716;
	bh=QZppzWwMaxmLDfvLc0EL4sJUn0FxeL+jQ+zzwKRWA+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WB+bXX/2wcQQZczTXvNBPixTycuoTgDFwCzKDyue0qGjEdd9b8ONdUpO2GxVnn1fr
	 1O05KLhgXPr12NR2L3PqTQSRcOnr4OMi6MrkEkc1cxj60aeKmRFMoYK2qTZ1/h3yxS
	 goAmTmr7kPJhQzlPiGbnEZ7PbyM03xP1ai7o6m+m2Jpfj9PRNup+qlCNsAH5s2SNHj
	 CoorInrneQKQGQQm1K7A4uVbQaOBF+sEG5B3CGcmzTN6g/1Ktg3RoShBk2AKAKJ254
	 /lFdKrjjxKSQfYMEjXeS+DG9eqoQP0yixST+O8fgbr2j7PDkGqyZECXlq3cYS0ATpY
	 rC6W4TmQK42Zw==
Date: Mon, 19 Jan 2026 09:45:14 -0800
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
Message-ID: <20260119094514.5b12a097@kernel.org>
In-Reply-To: <l66l2ijd45fkwniaesgau5jdzoxrdyt4t7tnsd6dpo4dlefytf@tugyhkn2th36>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
	<20260115-grxring_big_v2-v1-1-b3e1b58bced5@debian.org>
	<20260117181551.0b139ca1@kernel.org>
	<ziyd3327jr7miqgv2e252w4wpizphomkvxxge6nbjwtg4pyvf4@gvwwi2r7rykl>
	<l66l2ijd45fkwniaesgau5jdzoxrdyt4t7tnsd6dpo4dlefytf@tugyhkn2th36>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 04:56:49 -0800 Breno Leitao wrote:
> > > I think we need to add this check to set_rxfh now. The error coming
> > > from get_rxnfc/GRXRINGS effectively shielded the driver from set_rxfh
> > > calls ever happening when there's only 1 ring. Now they will happen.  
> > 
> > You are absolutely correct. The ethtool core calls
> > get_rxnfc(ETHTOOL_GRXRINGS) _before_ allowing RSS configuration via
> > set_rxfh, and if it fails, ethtool_set_rxfh() will fail as well. And
> > with the current change, ethtool_set_rxfh() will not fail if the adapter
> > is not multi-queue.  
> 
> Upon further consideration, should we implement this limitation directly within
> the ethtool infrastructure?

That may cause some regressions, we're getting the number of currently
configured Rx rings. If we were to check how many Rx rings the device
has that'd make sense. But since we can only access currently
configured rings, in theory, if the device has multiple rings,
just only one is active now - changing config for the RSS key or
function should work just fine. IOW

 # change key
 # increase ring count to make they key meaningful

Used to work.

