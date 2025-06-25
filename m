Return-Path: <netdev+bounces-201137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D72AE8377
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DF7B6CD8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE089263F41;
	Wed, 25 Jun 2025 12:56:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD12620C4;
	Wed, 25 Jun 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856191; cv=none; b=FKrNKpMt0QaPKpH/6rB9fpN09ajIV1n8lXwqwLPVHxQSQGdPC8jvZsl0JyUst61uq5neKt5zOafyXwcBTyUjRaf+ejyagZ8JrXKzjSd3vs3h5H1P0CCQHVcNaHNo0C1EOARxmazNdHgDwqw58L+Ksx4IV3gFS0fUTgtVxkjgMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856191; c=relaxed/simple;
	bh=w/RXprbaQVZvFx2iClbRZYtbtUhrHNEUJEAqm6qxX/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbiVWfc6pNWMYB6+4JYfJae+5ZRqKsZFesSvfgQQzvXI0wdGjryoWzCR86d6s9kVoW8J7+hkujC1C7OIH6e5G1hABgmBV8szDS6j86WCVqXc3bpx9cUm6kATssWodSTf78ei+hBPgjL96Vn3mKLWDYxsZJhm1bvHKiyE7tRRXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<ioana.ciornei@nxp.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <wangfushuai@baidu.com>
Subject: Re: [PATCH net] dpaa2-eth: fix xdp_rxq_info leak in dpaa2_eth_setup_rx_flow
Date: Wed, 25 Jun 2025 20:55:47 +0800
Message-ID: <20250625125547.19602-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250625104339.GW1562@horms.kernel.org>
References: <20250625104339.GW1562@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-mail-ex22.internal.baidu.com (172.31.50.16)
X-FEAS-Client-IP: 172.31.50.16
X-FE-Policy-ID: 52:10:53:SYSTEM

>> When xdp_rxq_info_reg_mem_model() fails after a successful
>> xdp_rxq_info_reg(), the kernel may leaks the registered RXQ
>> info structure. Fix this by calling xdp_rxq_info_unreg() in
>> the error path, ensuring proper cleanup when memory model
>> registration fails.
>>
>> Fixes: d678be1dc1ec ("dpaa2-eth: add XDP_REDIRECT support")
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> 
> Thanks, I agree this is needed.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> But I wonder how these resources are released in the following cases:
> 
> * Error in dpaa2_eth_bind_dpni() after at least one
>   successful call to dpaa2_eth_setup_rx_flow()
> 
> * Error in dpaa2_eth_probe() after a successful call to
>   dpaa2_eth_bind_dpni()
> 
> * Driver removal (dpaa2_eth_remove())

Hi, Simon

I think these paths also leak xdp_rxq_info.
I'll add cleanup for them and send v2 shortly.

--
Regards,
Wang

