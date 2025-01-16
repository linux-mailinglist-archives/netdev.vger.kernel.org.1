Return-Path: <netdev+bounces-158718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99479A130E0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEFD3A598A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE49225D6;
	Thu, 16 Jan 2025 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5eaGIxR"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A029A1
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736991753; cv=none; b=pMF4/DbcO0n0JOcqP8mDg2eyN7tp387Bz7kwSEegwAUx7B9/jMJdkz7ognVxnMv7LfFwmV6keC8lznrvBo/gCqBP2kseuaXCwP0Jw3D/6Cl+Fndj+iYYWVEaNwSS6Eb8ptEGqHyDsmLdWZSudcf6DLYkPFNHJYA5DUrN+vqc08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736991753; c=relaxed/simple;
	bh=njj52WhQMQZOfH2kXflonVWbgm+vByvjDK+FYp02Htg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLye5wVQhn/pNoQDrZkzxsVythN2tRHueeLpM2j6dnBKL27ZsGkbNNcAg6e52i6Sddk9meqyLTumgdnmmMdVcmjqzw57/+lZqDWjvhpJ9srg+cfNfxfg92u5AS5MX1YtEia6vJY8mxcUck0AnG6wA0T/MOwJxN4XhnqscVjNTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5eaGIxR; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11039148-82ea-4dea-8734-47eabdb268ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736991744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLy/3JATL1k66rTb0dW5NsSlSQ5yJgsR+7thbR9U3cw=;
	b=C5eaGIxRV3ayQge6Xj4XKsfcnmm9nAKRFjEtmoxnEM3iXQAmnz3ETiDyzMWfvf29mvHvzI
	jKcdzoL7Sn9PEfibkgxo12/Bxba0zl6cUls9Mg6TgpsYsi1Ax7Ua/M8ZryYibtZSdgM4zR
	EMZzeYExnsimcrX8VVLdnN4YJTaifKo=
Date: Thu, 16 Jan 2025 09:42:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: mii: Fix the Speed display when the network cable is
 not connected
To: Xiangqian Zhang <zhangxiangqian@kylinos.cn>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250115111805.3894377-1-zhangxiangqian@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250115111805.3894377-1-zhangxiangqian@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/15 19:18, Xiangqian Zhang 写道:
> Two different models of usb card, the drivers are r8152 and asix. If no
> network cable is connected, Speed = 10Mb/s. This problem is repeated in
> linux 3.10, 4.19, and 5.4. Both drivers call
> mii_ethtool_get_link_ksettings, but the value of cmd->base.speed in this
> function can only be SPEED_1000 or SPEED_100 or SPEED_10.
> When the network cable is not connected, set cmd->base.speed
> =SPEED_UNKNOWN.
> 
> v2:
> https://lore.kernel.org/20250111132242.3327654-1-zhangxiangqian@kylinos.cn
So, you've already sent a v2. This patch should be sent as v3.

Also, the link to v2 should not be included in the commit message. 
Instead, it should be placed here:

---
v2: 
https://lore.kernel.org/20250111132242.3327654-1-zhangxiangqian@kylinos.cn

  drivers/net/mii.c | 3 +++
  1 file changed, 3 insertions(+)

Thanks,
Yanteng

