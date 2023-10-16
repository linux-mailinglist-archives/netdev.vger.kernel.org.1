Return-Path: <netdev+bounces-41586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB77CB5BD
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F728163F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A73381DD;
	Mon, 16 Oct 2023 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm29Z0OD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9537CBC
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 21:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617DDC433C8;
	Mon, 16 Oct 2023 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697493250;
	bh=dsjl7kpO+a5ffvGfGBAiPokx4K+LHRouUIS1choW8ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jm29Z0ODHKXQvQMr/SDv46IbAojo8d8W/6AhBAQ8gZfdtFkFET16+krmSYQ6sI0Cz
	 Lvv6IKu9I0+xoeokkZqjdZiSecQvl20eu9Yaa32r4zAYRPAvnjbNz7rvgyHFQQ0Ysk
	 GdmvMal3V/53qgiwUPZ/F9sBZuT4YthtPPiOhqFUJb0Ez8rYAgKpG3p1khGwJ5HxLC
	 6Pw88CujJiIx/Wfb4+oJ3kJSuxu0SFwarpr55XDDYOoxrlOHqdoq/4VxXuO+B08E7o
	 SSiXEdMZKQaAZJMPh89KWfldNi/7UWolyvReJCDNxKpf+KRCewFiFz1N+E2c/ulRox
	 O8eTA3jYe/UwA==
Date: Mon, 16 Oct 2023 14:54:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <egallen@redhat.com>,
 <hgani@marvell.com>, <mschmidt@redhat.com>, <netdev@vger.kernel.org>,
 <sedara@marvell.com>, <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: Re: [net PATCH v2] octeon_ep: update BQL sent bytes before ringing
 doorbell
Message-ID: <20231016145408.539968d1@kernel.org>
In-Reply-To: <20231012101706.2291551-1-srasheed@marvell.com>
References: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
	<20231012101706.2291551-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 03:17:06 -0700 Shinas Rasheed wrote:
> -	netdev_tx_sent_queue(iq->netdev_q, skb->len);
>  	iq->stats.instr_posted++;
>  	skb_tx_timestamp(skb);

The skb_tx_timestamp() here will do the same exact UAF, no?
I think you should move them both.
-- 
pw-bot: cr

