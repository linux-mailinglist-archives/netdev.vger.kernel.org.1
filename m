Return-Path: <netdev+bounces-225590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E9FB95C03
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455FB189B05E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8FC322A34;
	Tue, 23 Sep 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="of1pDfB8"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B32E8881
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628501; cv=none; b=NdFrLTmdVC5+T8OsYNUa5Sjvu1KZxk6H5pCuHR77Cr1JlpZQa+X+97gW5+QHnUA9fmny8dR6JnKTRtHNaBsI8X8fdkb+iusoZg8z/bb6dFFL7Ox96quO3Eqbs53pB4BtC88OgoiZkszIa8L47xymankip1D4obrnGuHmwgYsAnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628501; c=relaxed/simple;
	bh=QA6cRqhcpdLpAWirm6EGftRJEfBt1QUnxbDN9YyZymg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2DPgFWoNhZXs52leeDgGCijLu0ekLR5xCoVy0bQ12YL/nzoBe7BLoAZL8HvEhZmUovru+JgTcoW3gcD66Ga60tu+ncRljNmHSejKZMHCX2dv8d93olCn8VTV9gr53yq25A3Jy6PO16oIh2zK64fDdkvr1NGYXnVR0JWrifWWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=of1pDfB8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <178b8313-654d-411a-b9b6-c5e468ab1c80@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758628487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ6TFLUv8Lt32fbF+Mh4OLsiVkeX5RLzlYeIcdSd4OU=;
	b=of1pDfB8UiuM+oOq/XljmA059f1LAgZq6bMrFXp1hQ3MYyBMeoZgshZdLUEWwx7Ijl0V7y
	wSstXglVnfR5LnL9tgaXyO7F9ZZDsN0h5i27sZ/ZEQoB9Us7DelARS9op3+6BPrMQ0kWtu
	Ntw3xhgLyOXwl6Pd6Tp1842LbvLWD7M=
Date: Tue, 23 Sep 2025 12:54:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] octeontx2-pf: Fix potential use after free in
 otx2_tc_add_flow()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aNKCL1jKwK8GRJHh@stanley.mountain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aNKCL1jKwK8GRJHh@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/09/2025 12:19, Dan Carpenter wrote:
> This code calls kfree_rcu(new_node, rcu) and then dereferences "new_node"
> and then dereferences it on the next line.  Two lines later, we take
> a mutex so I don't think this is an RCU safe region.  Re-order it to do
> the dereferences before queuing up the free.
> 
> Fixes: 68fbff68dbea ("octeontx2-pf: Add police action for TC flower")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

