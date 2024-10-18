Return-Path: <netdev+bounces-137084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707519A4557
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC4E1C21C28
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E342038B6;
	Fri, 18 Oct 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nLTrTOpV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D7370;
	Fri, 18 Oct 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274269; cv=none; b=OnIq0wOLhcduJblLDOhTMqPbgBuQRjjXAI/a17tX/4TIErXIO4V8+Xcvl/HyZ0B3FS+SqDHAm83BoEz+CGTNX2Tauvg+xHa/WWXv0DU5bO6GO8EvIEkgnG7Ru4USNVu6VHz4ZqcNmknGDT+/PzBjmRiA59SHHYNTttyjZRsAXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274269; c=relaxed/simple;
	bh=xtS8n8Jq0YVcFkpXW1vVP5q+qR5OCdPNc8aBh0XW/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPUaxw1yUbc+iWmwVZ+HVomusb2xuJIC2LKkxhmTXKO6zEDGs+tsFPoT64F+ip6JwvIWMewM+pcppi+1U1VZJ+QRk+QpznjsOA/E9iRVgsWHt85vBSCsjr3nsqg4XX6Iybvuex2fnFmbcsjISRCfVThfRA5wIG40QUqC+qPu+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nLTrTOpV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1XH3C6puuyO0GVVr6J8qrsqvdtJ7rHyrQHKdm3F9rb4=; b=nL
	TrTOpVyJJvFhO65Oehti5rMuApOhKObSUrasY80TmEwQJofwJOV26EQGFrFOT6NzeYcEeFfeppBkC
	x3MjNgWrJaAel7zx1+1xZaw9XKHaR/GRYu2oFTdDxM3PRP7qamUc6+xk87pl4TUZsDoI0GVuDlzaz
	Ri6BE7b9AuV777Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1rDx-00AYTW-Py; Fri, 18 Oct 2024 19:57:17 +0200
Date: Fri, 18 Oct 2024 19:57:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fan =?utf-8?B?SGFpbG9uZy/ojIPmtbfpvpk=?= <hailong.fan@siengine.com>
Cc: Simon Horman <horms@kernel.org>,
	"2694439648@qq.com" <2694439648@qq.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] net: stmmac: enable
 MAC after MTL configuring
Message-ID: <9a11c47e-0cd6-4741-a25b-68538763110a@lunn.ch>
References: <tencent_6BF819F333D995B4D3932826194B9B671207@qq.com>
 <20241017101857.GE1697@kernel.org>
 <bd7a1be5cec348dab22f7d0c2552967d@siengine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd7a1be5cec348dab22f7d0c2552967d@siengine.com>

On Fri, Oct 18, 2024 at 01:15:30AM +0000, Fan Hailong/范海龙 wrote:
> Hi
> 
> For example, ETH is directly connected to the switch, which never power down and sends broadcast packets at regular intervals. 
> During the process of opening ETH, data may flow into the MTL FIFO, once MAC RX is enabled.
> and then, MTL will be set, such as FIFO size. 
> Once enable DMA, There is a certain probability that DMA will read incorrect data from MTL FIFO, causing DMA to hang up. 
> By read DMA_Debug_Status, you can be observed that the RPS remains at a certain value forever. 
> The correct process should be to configure MAC/MTL/DMA before enabling DMA/MAC

What Simon is asking for is that this is part of the commit message.

Please also don't top post.

    Andrew

---
pw-bot: cr

