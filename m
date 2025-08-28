Return-Path: <netdev+bounces-217833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D46B39F14
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F365646D5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269751DC9B5;
	Thu, 28 Aug 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aMuhdMc9"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBC1AF0C8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388115; cv=none; b=h2J+TX/oP5nXzFWPPzqaqPPx6zCgSEn9gaSZ+gIEulsKtmum9CvrwolrdZIMQk/vT9GeY/AnauhespfZC8XwKEiVXRYF49fNQHJQ0dpoEvyQArs5WR/gqZx8WFxhpOdh7pMpZATIUKu3QVKZVYtbmB6lM1lLQBy3wEMQkrGnHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388115; c=relaxed/simple;
	bh=OfgCgq7zlRlpYjhEMCKndHxIYx10att5Gm8gFGs1y3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isL82ssRLcQs5elGOxQHpYg2SRMDubeeBRdxLtjlgMQlcCf/dUKlICMOEorW4PY4vADFVJmBM75xsiNC4fzxdnX2MNqMXE8fYHGnosvn8et34VJRhcJIHp8Z6FBv/AX8RTvLw6pd+AtMGxd3DBqe40atJmnimLqROSG1UTqGpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aMuhdMc9; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1aba83c1-2c5a-4793-bbe9-186159790024@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756388101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gv1KSKTX4neHksXd95okg0M683W0/ZW6i1hVl5Fht0=;
	b=aMuhdMc9/gB7AB3jWZ5Jl4stMvweouH3Nde/lbTgzxTTx4dcXUAi5Neur+wziZlj1o5Zms
	QgVm+V90OHleA5/mamLxVlIa5JxhwOQ2auCDe7iZwpAYGNmqT0kTgUlNVgmTBq26L77Sa7
	I3PMeEiVlryZziJvMpiXlbLF5mnjjZc=
Date: Thu, 28 Aug 2025 14:34:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/3] net: stmmac: correct Tx descriptors debugfs
 prints
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com,
 Piotr Warpechowski <piotr.warpechowski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-3-konrad.leszczynski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828100237.4076570-3-konrad.leszczynski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 11:02, Konrad Leszczynski wrote:
> From: Piotr Warpechowski <piotr.warpechowski@intel.com>
> 
> It was observed that extended descriptors are not printed out fully and
> enhanced descriptors are completely omitted in stmmac_rings_status_show().
> 
> Correct printing according to documentation and other existing prints in
> the driver.
> 
> Fixes: 79a4f4dfa69a8379 ("net: stmmac: reduce dma ring display code duplication")
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

