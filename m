Return-Path: <netdev+bounces-58590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CB817534
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42414282167
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02543A1C8;
	Mon, 18 Dec 2023 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p6JZmqlP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEC3A1B6;
	Mon, 18 Dec 2023 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=oJskJN4R/iyEsuEHtoL4otuKCFa7wjBQnbjBdPls1FE=; b=p6
	JZmqlPoPSkXH7+rUb12CNgWmirtpk2vBlE7uCixmqphuax0C8UqQvPH8wgPUa8NlotmyslGw4/CRU
	Y2pfXXSfBiaNG2NEhd7HBwdV79YjHCfXARQQfZ2/9SCPQfe0MaihpDWSZY9DfyRHrzIPWWruhvngx
	/S2lnfjf/Ry//r8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rFFXK-003G9h-Au; Mon, 18 Dec 2023 16:28:06 +0100
Date: Mon, 18 Dec 2023 16:28:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v6 5/9] net: stmmac: Add Loongson-specific register
 definitions
Message-ID: <bc36a2a1-1c3c-4adb-8c8a-d4e4427a6999@lunn.ch>
References: <cover.1702458672.git.siyanteng@loongson.cn>
 <40eff8db93b02599f00a156b07a0dcdacfc0fbf3.1702458672.git.siyanteng@loongson.cn>
 <8a7d2d11-a299-42e0-960f-a6916e9b54fe@lunn.ch>
 <033fedc9-1d96-408e-911b-9829c6a5e851@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <033fedc9-1d96-408e-911b-9829c6a5e851@loongson.cn>

On Mon, Dec 18, 2023 at 06:22:04PM +0800, Yanteng Si wrote:
> 
> 在 2023/12/16 23:47, Andrew Lunn 写道:
> > On Wed, Dec 13, 2023 at 06:14:23PM +0800, Yanteng Si wrote:
> > > There are two types of Loongson DWGMAC. The first type shares the same
> > > register definitions and has similar logic as dwmac1000. The second type
> > > uses several different register definitions.
> > > 
> > > Simply put, we split some single bit fields into double bits fileds:
> > > 
> > > DMA_INTR_ENA_NIE = 0x00040000 + 0x00020000
> > > DMA_INTR_ENA_AIE = 0x00010000 + 0x00008000
> > > DMA_STATUS_NIS = 0x00040000 + 0x00020000
> > > DMA_STATUS_AIS = 0x00010000 + 0x00008000
> > > DMA_STATUS_FBI = 0x00002000 + 0x00001000
> > What is missing here is why? What are the second bits used for? And
> 
> We think it is necessary to distinguish rx and tx, so we split these bits
> into two.
> 
> this is:
> 
> DMA_INTR_ENA_NIE = rx + tx

O.K, so please add DMA_INTR_ENA_NIE_RX and DMA_INTR_ENA_NIE_TX
#define's, etc.

> We will care about it later. Because now we will support the minimum feature
> set first, which can reduce everyone’s review pressure.

Well, you failed with that, since you did not provide the details what
these bits are. If you had directly handled the bits separately, it
would of been obvious what they are for.

      Andrew

