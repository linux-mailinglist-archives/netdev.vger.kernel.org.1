Return-Path: <netdev+bounces-203603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3DFAF67E8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFB53B246C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A11D5CE5;
	Thu,  3 Jul 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxMjs3vQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67C2DE710
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509325; cv=none; b=tmH/pLPQSRigVFvHvi1jtxfY2NgZs6Gd6vN7tdSI7BnaLZ4bQcuDP/ftqSBb9fgdGsa85iYWFZptjx08aCJ3T4neaSMuAgK69udaYKJ1yh/XGccbX0V7VMhEsIE1G4CQGmmgKdhCFjypO+vPqp+mBC8r3OyMn2zUB2a/GwGbBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509325; c=relaxed/simple;
	bh=ObP7kc6RJzb5bHzh/RWAmxwEodtxHRym45+IX3eOfTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tR+RLKNbXFyMWlplApIJGoB2WjYSIKJB3A37BDoOVx/fMRSAOo2Xoq6FMHGmLGV/bZzD0sYsbv7o9di9qPJztfeyGlnpJBSg78dAxP+MwMwy82iEVsv+4S2z4ASLxXSXiRGOdmedVYs9gaipuDyLWktDmG0+l6YIm+6DC8gzCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxMjs3vQ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9565e540-3dc5-4831-b9bb-7453e5979a21@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751509321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=934E9G/VFk13K7ue7jt2ZAeg69cidVPg44xfl0uq5KI=;
	b=gxMjs3vQ3tOa+mTvpJv6AjmHN0EyRg0DcW5fQzAaRbnPbRuI111+pbCJRpbIBCXJmmtwMH
	5Etpal8fel6d5RO2Ft4TpaiVEznDYLn91e58qEhESQ8Z7DOrIljjOprRFMDuG5Hj5WIiHe
	jURBv2u3HB7Zw7nGfB7qGGa/+ABJh3M=
Date: Thu, 3 Jul 2025 10:21:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: stmmac: Fix interrupt handling for
 level-triggered mode in DWC_XGMAC2
To: EricChan <chenchuangyu@xiaomi.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, xiaojianfeng
 <xiaojianfeng1@xiaomi.com>, xiongliang <xiongliang@xiaomi.com>
References: <20250703020449.105730-1-chenchuangyu@xiaomi.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250703020449.105730-1-chenchuangyu@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 7/3/25 10:04 AM, EricChan 写道:
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
> configurations. It has been tested on the hardware device (not publicly
> available), and it can properly trigger the RX and TX interrupt handling
> in both the INTM=0 and INTM=2 configurations.
Is there anyone willing to help test this patch on a publicly
available DWC_XGMAC2 hardware device (if such a public device exists)?


Thanks,
Yanteng

