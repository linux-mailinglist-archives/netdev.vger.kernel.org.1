Return-Path: <netdev+bounces-187411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C86AA700D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C011BA6FFB
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C745231821;
	Fri,  2 May 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR7iLjNR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC61EA7F1
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746183042; cv=none; b=PTmHj5ZTwp+Mf/YPQDBhBL06xO9CfJXD1rCyIAd5Ijp4RnS5zm9VslFB00+2o2Fx7BlNFhTPXrNv4yri64DSk3X7rSkXiJNjTNk3AEJkzfNAMQ1TQcLbaoOFIGTV/vHADecjq8ZHI4zE1vIcdlDfiuvucgphm1T5gNEqxpsdq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746183042; c=relaxed/simple;
	bh=wrzFBHEYhQS79ozfsvgqbdmhczXl3MtFwdCsFVzJURk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpS6+LBSFmlVMKBa4Hvkq17bVPa5dwkl18xu4iFhdlk4qTKlkM5VqanSgyRfFH5wikUKOzrRw/QCBcibBxxjfUWwJ7Ql7eyZiCsls9YB7PZjHYM00msOX4OdlD7CQfTIeDGBjTDKYhQh/3nON1czT2Gv/+ZC28Bia8XMPdGRJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR7iLjNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC587C4CEE4;
	Fri,  2 May 2025 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746183042;
	bh=wrzFBHEYhQS79ozfsvgqbdmhczXl3MtFwdCsFVzJURk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bR7iLjNRCtLLRssgZFJ0YD6ZP25w0Xut4r07Q9zQ8sKxxFvhLchiq/TCI9tsqSNFE
	 1tIeTNfW2guhVwobwxWSyhbpfNOw0BJmzyjZ290XLabZf75VS60iYyez3DIid2Y6Fe
	 ITVD4phUwNjtLry4Qucxxgi6cmw3O0cxKNELRm7GcOoR73/M4omr6r2b5Mh4rsJdgx
	 Dm8Z1lFX7S8qpZMrUFta3L0cLMI3Mf6YKdOHDAsRMP/EvdJX/rpPgKxrFq833DoNVZ
	 2xkr91RznxtVP7r3wlCPlnCtUFO7HOYuOWInDeWC2laKk7TV43tITH518OKTGExD++
	 rzNM95+MWFkAg==
Date: Fri, 2 May 2025 11:50:38 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net PATCH 2/6] fbnic: Gate AXI read/write enabling on FW mailbox
Message-ID: <20250502105038.GJ3339421@horms.kernel.org>
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614220363.126317.10550539950263575976.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174614220363.126317.10550539950263575976.stgit@ahduyck-xeon-server.home.arpa>

On Thu, May 01, 2025 at 04:30:03PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> In order to prevent the device from throwing spurious writes and/or reads
> at us we need to gate the AXI fabric interface to the PCIe until such time
> as we know the FW is in a known good state.
> 
> To accomplish this we use the mailbox as a mechanism for us to recognize
> that the FW has acknowledged our presence and is no longer sending any
> stale message data to us.
> 
> We start in fbnic_mbx_init by calling fbnic_mbx_reset_desc_ring function,
> disabling the DMA in both directions, and then invalidating all the
> descriptors in each ring.
> 
> We then poll the mailbox in fbnic_mbx_poll_tx_ready and when the interrupt
> is set by the FW we pick it up and mark the mailboxes as ready, while also
> enabling the DMA.
> 
> Once we have completed all the transactions and need to shut down we call
> into fbnic_mbx_clean which will in turn call fbnic_mbx_reset_desc_ring for
> each ring and shut down the DMA and once again invalidate the descriptors.
> 
> Fixes: 3646153161f1 ("eth: fbnic: Add register init to set PCIe/Ethernet device config")
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")

nit: No blank linke here please.

> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

The nit above aside, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

