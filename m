Return-Path: <netdev+bounces-47857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3004E7EB932
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8692811DB
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3869C2E82E;
	Tue, 14 Nov 2023 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5ZscZ+b4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C502E82A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 22:14:11 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB1D5;
	Tue, 14 Nov 2023 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QKV+COsbMm3ctH/hvmRLz2+UD4oEDJrHvUBihvmpKl0=; b=5ZscZ+b4Y6Fa5+ao0U5ZLxtWL/
	Lvg+gL3+5QOL1DpachQ++s1Iw7cMVRqFXKshdJLB1KtLBaD3enJOqz4X3Da5XUADRRBDKgywLcodR
	JwgYk/u01L9eGzQLiWbMpydD6tygpbJP08J/j351y6srY0SMbVqK7akgSjpkCRFuW9YA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r31fN-000CJm-U0; Tue, 14 Nov 2023 23:13:53 +0100
Date: Tue, 14 Nov 2023 23:13:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tan Tee Min <tee.min.tan@intel.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: fix FPE events losing
Message-ID: <6caf2c31-70f9-4866-888c-cb6af3839845@lunn.ch>
References: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>

On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrote:
> The 32-bit access of register MAC_FPE_CTRL_STS may clear the FPE status
> bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS control bits to
> avoid unexpected access of MAC_FPE_CTRL_STS status bits that can reduce
> the FPE handshake retries.
> 
> The bit[19:17] of register MAC_FPE_CTRL_STS are status register bits.
> Those bits are clear on read (or write of 1 when RCWE bit in
> MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> MAC_FPE_CTRL_STS control bits makes side effects that clear the status
> bits. Then the stmmac interrupt handler missing FPE event status and
> leads to FPE handshake failure and retries.

Is it possible to call the core of stmmac_fpe_irq_status() to extract
the information from these bits and then call
stmmac_fpe_event_status()?

Alternatively, can you actually set RCWE in MAC_CSR_SW_Ctrl and add a
mask to dwmac5_fpe_configure() etc so they don't write 1 to these
bits? That seems safer than assuming 8 bit reads work.

      Andrew


