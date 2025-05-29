Return-Path: <netdev+bounces-194258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F248AC80E4
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 18:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4864A3E0F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D022DFA6;
	Thu, 29 May 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aNADSTtT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FD22DF8E;
	Thu, 29 May 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536202; cv=none; b=UzCg8xDQ1K65bkq0MzKeGpgUXTtqpIfCbSg+/5Z8A2kZlnUYAMo8Di6eqQZ8xgUQp0FizyiL1Y4+bGqzlLieugpzLpVYIQ4TSeuRJ0pT1i7aVwV2qowyRSYHZE21qcjwCneHpzTRHcdKcUlWuyPrQFt3iOtZg/ei6UJ6axMaeUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536202; c=relaxed/simple;
	bh=cHC5WHbEaJiuhxsuxlzB9f6LP8cIKNXdNA6XZ3a5How=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fInYbKeKq+WPsPcO/chSmf/xVp6QyQocC8Zz94H0RCrduUA28RcEJmaCBT5pLqX2vuqRLCxXAalSHq5ip2jU56w/S49/R0eqtpS7KuLASoZlqIUhQbQYsIkaf01r0e3yq26awDqr8gvSAO1zMEnZKNF3HgM8Qro2/h4ntTytNPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aNADSTtT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2ROEfGs105IHaeH5xuCxgG1C8SsFk2j1G03w+ZOsJUg=; b=aNADSTtTgd5KKMFX4Rm0nf0gHl
	HzZWzw7JvPDyh9a18qfJZxA/TUZljPkO7xFQdYpTgj+hmSgqlctoifkmV3ngNW5RF4ELFPpRuTW8d
	IZMMlCgcvUcX4dzZGbjF5JKsD54f/Wz5TGgwK5aBDbdib3jANcJNiRNSxCA9tAyfpw0E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKg8W-00EHbS-FC; Thu, 29 May 2025 18:29:44 +0200
Date: Thu, 29 May 2025 18:29:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and report
 coalesce parameters in DMAengine flow
Message-ID: <6c99b7f5-b529-4efd-a065-1e0ebf01468e@lunn.ch>
References: <20250525102217.1181104-1-suraj.gupta2@amd.com>
 <679d6810-9e76-425c-9d4e-d4b372928cc3@linux.dev>
 <BL3PR12MB6571ABA490895FDB8225CAEBC967A@BL3PR12MB6571.namprd12.prod.outlook.com>
 <d5be7218-8ec1-4208-ac24-94d4831bfdb6@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5be7218-8ec1-4208-ac24-94d4831bfdb6@linux.dev>

> Yeah, but the reason is that you are trading latency for throughput.
> There is only one queue, so when the interface is saturated you will not
> get good latency anyway (since latency-sensitive packets will get
> head-of-line blocked). But when activity is sparse you can good latency
> if there is no coalescing. So I think coalescing should only be used
> when there is a lot of traffic. Hence why I only adjusted the settings
> once I implemented DIM. I think you should be able to implement it by
> calling net_dim from axienet_dma_rx_cb, but it will not be as efficient
> without NAPI.
> 
> Actually, if you are looking into improving performance, I think lack of
> NAPI is probably the biggest limitation with the dmaengine backend.

It latency is the goal, especially for mixing high and low priority
traffic, having BQL implemented is also important. Does this driver
have that?

	Andrew

