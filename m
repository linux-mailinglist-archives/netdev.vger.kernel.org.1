Return-Path: <netdev+bounces-217837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF46B39F39
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2142618968C4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E130F556;
	Thu, 28 Aug 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xILv77lw"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0E30EF8E
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388391; cv=none; b=BNTVMsiWt1rCZLE0UjG5RLuRG03T6ZOBtzXtBbl5hFhANUvdkrwGpp7k8zSmbn7DP1vnSAJJyRXLHhY3II7ApHlW8+3hSCps2fPEsIWrhm0Kxwi8crjqCAcB6X3/5His53GgkwbKD6RolBHam4ha1w5uENLLQHOa0sknqOsFddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388391; c=relaxed/simple;
	bh=MR2Qheg85HZS0UydqrFiXrApwGfKPFINagv8Bzc/oCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJiO5Q6dBI45FcR9Q5HpdaWidfO9k1prUIt0yjg3zB19FgH2EjobXBh7wJ7DbLpMR0IvuEmHXvr62wF3LJDhvojwKW20gTnoM5euwdmzefI6AeXYfhZny/7PCySIOX2mYKZiB1JKgWMNZBoRTUrGcwBxbHQ2Osgxxl3w8ORhskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xILv77lw; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <75adbd82-219f-4702-a347-be2e5217f71e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756388377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsgg6MvCxdIq5tLS8ChAkgb6McszBQnzFz/kMYqM7WY=;
	b=xILv77lwkEYkZ7s9oSTOzoPg00BPAp8Ves3Z5lqjMWmLJOCZjOHuZbg9jZWg4GWW7MWTTQ
	e9p4quERzYmb6FAkhq2ZFFbO76D+BT5Xe5sYgoHnuKNmCpADPe+tRHky+fEM/0nwH8C6JZ
	tPH150LGtQeLiH2lIPYM+QIZYF9Pza4=
Date: Thu, 28 Aug 2025 14:39:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 3/3] net: stmmac: check if interface is running before
 TC block setup
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com,
 Karol Jurczenia <karol.jurczenia@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-4-konrad.leszczynski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828100237.4076570-4-konrad.leszczynski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 11:02, Konrad Leszczynski wrote:
> From: Karol Jurczenia <karol.jurczenia@intel.com>
> 
> If the interface is down before setting a TC block, the queues are already
> disabled and setup cannot proceed.
> 
> Fixes: 4dbbe8dde8485b89 ("net: stmmac: Add support for U32 TC filter using Flexible RX Parser")
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 70c3dd88a749..202a157a1c90 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6247,6 +6247,9 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
>   	struct stmmac_priv *priv = cb_priv;
>   	int ret = -EOPNOTSUPP;
>   
> +	if (!netif_running(priv->dev))
> +		return -EINVAL;
> +

The check looks valid, but I'm not quite sure of the error code.
Anyways,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

