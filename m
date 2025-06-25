Return-Path: <netdev+bounces-201342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9A0AE912B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50A71C25922
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271FC2153F1;
	Wed, 25 Jun 2025 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwrYSOnL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B4214A9B
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891175; cv=none; b=YwEB6k/Er5w7k6tvE1wHzskOS0xaMDbvMzxSFVZoRnA7dvqnPqOoUESlh5Vkj0BYPIxCyeT+6IfsJ1OVSdqJWqymPI0IdXkZyJHsx7kg9z2N6/9SrHPFe/PALIANxUAfei5ydXQYba2p663jLFRz22t3n7lxJNRILnaJSokDH1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891175; c=relaxed/simple;
	bh=GcuNJbTYdXYziN1YijGv29rtLzd+WmmzNrw+qRJrnng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OI9sA9njcPDxiBwKLbxol2UNl8IS9GqdkiKP4rX5FFaFqE5ydY55rH2P3jn0N1HPxrUCWyQHRJ1VcYP03f/5eUuD+as9gKAfC7at4X8wvqBcRVqGkAKYDCMwrrQuH1vFchM2D3LVrLFPgKc+R0DEoTk+X2Q/ZS5J4Rgsh+JeNpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwrYSOnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58653C4CEEA;
	Wed, 25 Jun 2025 22:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891174;
	bh=GcuNJbTYdXYziN1YijGv29rtLzd+WmmzNrw+qRJrnng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TwrYSOnLz0kbxjQHL1jipsW+C8ZqtaxWWos0jTM4FqG5a/w6Hl6q4ot2W7fQN8+ZV
	 hbXJd64nBJxA/NdDa/ti7ABo4pZEzL5uF1f8i9qiHb1UvB0Im/jjpV5BTbr0Xn1wg2
	 YQQhT19yiVYqUe696FQT2MB9cW9Fo97IBmu5nkx6kyikCMazXups6s7SL+iMvAGgAy
	 POwfLjZuAqEEAcsWDXK1v96Ywz+cUxra82OuzDP/8Tnw8toATwVBVCtx2apBEX+7y2
	 mg1n32yAUjd3KpvwrsplLZZk8UQ1YwJ8BW6IdNxnfbi9ttRDQjQNFrV1xvvshT/2X3
	 sJSvhOZDNu4Qw==
Date: Wed, 25 Jun 2025 15:39:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: EricChan <chenchuangyu@xiaomi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, Feiyang Chen <chenfeiyang@loongson.cn>,
 Serge Semin <fancer.lancer@gmail.com>, Yinggang Gu
 <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, <netdev@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, xiaojianfeng
 <xiaojianfeng1@xiaomi.com>, xiongliang <xiongliang@xiaomi.com>
Subject: Re: [PATCH] net: stmmac: Fix interrupt handling for level-triggered
 mode in DWC_XGMAC2
Message-ID: <20250625153933.7757fde3@kernel.org>
In-Reply-To: <20250625025134.97056-1-chenchuangyu@xiaomi.com>
References: <20250625025134.97056-1-chenchuangyu@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 10:51:34 +0800 EricChan wrote:
> According to the Synopsys Controller IP XGMAC-10G Ethernet MAC Databook
> v3.30a (section 2.7.2), when the INTM bit in the DMA_Mode register is set
> to 2, the sbd_perch_tx_intr_o[] and sbd_perch_rx_intr_o[] signals operate
> in level-triggered mode. However, in this configuration, the DMA does not
> assert the XGMAC_NIS status bit for Rx or Tx interrupt events.
> 
> This creates a functional regression where the condition
> if (likely(intr_status & XGMAC_NIS)) in dwxgmac2_dma_interrupt() will
> never evaluate to true, preventing proper interrupt handling for
> level-triggered mode. The hardware specification explicitly states that
> "The DMA does not assert the NIS status bit for the Rx or Tx interrupt
> events" (Synopsys DWC_XGMAC2 Databook v3.30a, sec. 2.7.2).
> 
> The fix ensures correct handling of both edge and level-triggered
> interrupts while maintaining backward compatibility with existing
> configurations.

Could you please add a Fixes tag pointing to the commit in which 
the problem was introduced?

If the device you're working with is publicly available it may
also be worth mentioning what it is in the commit message.
Or at least mentioning whether you tested this on real HW,
or in simulation, or not at all.
-- 
pw-bot: cr

