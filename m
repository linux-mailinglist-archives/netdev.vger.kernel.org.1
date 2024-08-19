Return-Path: <netdev+bounces-119921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5501695780E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1102F28305A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A831DC49B;
	Mon, 19 Aug 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8Vzvuz3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A43C482;
	Mon, 19 Aug 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107721; cv=none; b=l61zfvtUS6z3nYlGRPUfOwghFLVWu66jVbaF9YB3qayK5KiN4yxxCK4+LD53xsc/X/MVUua2uimwP558QSVtP1sPHH+R76HY+ectDclSeOcD3XoaWqOw8JFCbncoo0xHZ2cVyoLisz2ZiQvp6r/gNkhNPWuJQHguKKh32Ryhw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107721; c=relaxed/simple;
	bh=XkPX/b643fbTKf9MqSJy05P89sBc/6Vx/k+ptPE57WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ra2fNQOiKq6M/7hnlNpl2Pbt801Ngz/nLRATGLv/p+4iUYZP2pUzxw7Lo+sRQf89QJ4ZQ/zPUXFUja8eguUDsMH0QoQD9XQlxJZTPbiKUoEtksa7Uur8Y/lMKsZq7LSZK9UX79j81nEVsyBgFgIaAE4+HdwJku7vcA9+1LecIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8Vzvuz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1760C32782;
	Mon, 19 Aug 2024 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724107721;
	bh=XkPX/b643fbTKf9MqSJy05P89sBc/6Vx/k+ptPE57WQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8Vzvuz3ySZzbBFwaSZPZVzeodqyj8V2vcYfIStsSot860yKcEhdffb1A46zLgjr2
	 njNFQrKl5eHWFFrz3epityxuxiNtD3buFY6XHak8ZPcR9zvntcbgLoOAWovPtnq1l9
	 vJNxmLRNddH8uS1POrsBPyE+QBKltDjRnXhOYPu7GMdsN2zpiAkubbYXbYAPT03Vs4
	 sPCOrak8lnvYhak6JMTEZXn/imH3mLvxcDPmbBNtWBm5FJEaS2DQWO3kfJreLg9cxH
	 V4xBDoANId7S7cSuDtkr9YtTfItD+BkgqzsgS9JAkFbFNEzJ0FFLWOx1+zNT9bNSRS
	 ATNzE9RaeGgJA==
Date: Mon, 19 Aug 2024 15:48:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Parthiban.Veerasooran@microchip.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
 <ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
 <vladimir.oltean@nxp.com>, <masahiroy@kernel.org>, <alexanderduyck@fb.com>,
 <krzk+dt@kernel.org>, <robh@kernel.org>, <rdunlap@infradead.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
 <Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
 <Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
 <linux@bigler.io>, <markku.vorne@kempower.com>
Subject: Re: [PATCH net-next v6 10/14] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <20240819154838.3efa04fa@kernel.org>
In-Reply-To: <1cd98213-9111-4100-a8fa-15bb8292cbb5@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
	<20240812102611.489550-11-Parthiban.Veerasooran@microchip.com>
	<20240816100147.0ed4acb6@kernel.org>
	<1cd98213-9111-4100-a8fa-15bb8292cbb5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 06:53:51 +0000 Parthiban.Veerasooran@microchip.com
wrote:
> > This is a bit unusual. If the core decides to drop the packet it will
> > count the drop towards the appropriate statistic. The drivers generally
> > only count their own drops, and call netif_rx() without checking the
> > return value.  
>
> The first version of this patch series didn't have this check. There was 
> a comment in the 1st version to check the return value and update the 
> statistics.
> 
> https://lore.kernel.org/lkml/375fa9b4-0fb8-8d4b-8cb5-d8a9240d8f16@huawei.com/
> 
> That was the reason why it was introduced in the v2 of the patch series 
> itself. It seems, somehow it got escaped from your RADAR from v2 to v5 
> :D.

Sorry about that :( There's definitely a gap in terms of reviewing 
the work of reviewers :(

> Sorry, somehow I also missed to check it in the netdev core. Now I 
> understand that the rx drop handled in the core itself in the below link 
> using the function "dev_core_stats_rx_dropped_inc(skb->dev)".
> 
> https://github.com/torvalds/linux/blob/master/net/core/dev.c#L4894
> 
> Is my understanding correct? if so then I will remove this check in the 
> next version.

Yes!

