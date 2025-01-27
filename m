Return-Path: <netdev+bounces-161172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B7A1DBDF
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AB33A544B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800391F60A;
	Mon, 27 Jan 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYRysFLP"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1FC18CBFB
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001318; cv=none; b=CsmJeMAobdQlqzI5dvXiydVjjIBCM9WWXpx11Q8K1C9WYisFO5Msn9tqam86w77a6SIzoECk/0BzL/4WmwMI3RbfULEQhiGoK6DX1xIJBkyXSnnhBU85lcGCPncT6dXUVRDeRLBb5aSSX/5WKrbrDEPKpO66/awQG2Z9xWzYOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001318; c=relaxed/simple;
	bh=Z+f+9zKrAALVl/kIAEOH9f5WC0AAsjimQSz8jmtCk1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0vYNQPD8LmvONqxTUpyWkFn1mFtlontlNvi9OCV/fKJ1HMNS8GpOzEGon4uCE0RiDn8KORxpiNXLArPDTl2wmqg5SASMxilNVnDmxflm8aQyDDK/VdE/8FSBOaakNtZjtisupte7AV2ruoASALjt2XS2hxv3C+lsTS62MoQhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYRysFLP; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4bff9efc-eab6-42a1-a2a6-5d4b3c4dccee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738001313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skIdayWsGtfDhykxkY/c0m0d2sHBVaGb3+BX3PRUykM=;
	b=tYRysFLPxndKuoa69oKSeNlP7zHJCGIKrn/8f94kYnNXpRG/1RqyBha2Se3VYTk4yOG6hC
	ae+n2I/IiCqODvCIcfexrFrDWqrEX/SvgpRQQJtleE3e9HzFyUQioF/kBuVqQzd6xCC5Ni
	BcPG7OIG8G7Srj8MVU52/dufyPOh+Os=
Date: Tue, 28 Jan 2025 02:07:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 1/3] net: stmmac: Limit the number of MTL queues to
 hardware capability
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
 <20250127013820.2941044-2-hayashi.kunihiko@socionext.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250127013820.2941044-2-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 1/27/25 09:38, Kunihiko Hayashi 写道:
> The number of MTL queues to use is specified by the parameter
> "snps,{tx,rx}-queues-to-use" from stmmac_platform layer.
> 
> However, the maximum numbers of queues are constrained by upper limits
> determined by the capability of each hardware feature. It's appropriate
> to limit the values not to exceed the upper limit values and display
> a warning message.
> 
> This only works if the hardware capability has the upper limit values.
> 
> Fixes: d976a525c371 ("net: stmmac: multiple queues dt configuration")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,
Yanteng



