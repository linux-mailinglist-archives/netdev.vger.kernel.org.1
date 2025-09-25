Return-Path: <netdev+bounces-226481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2163BA0EFF
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26C4176A6C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501E30E853;
	Thu, 25 Sep 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vROjpSYr"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967930E0CD
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822473; cv=none; b=gFd7YyqOw6Pwp3/LGI1PTP4lpjcPE05F5uGgkDmK0rs63qHg6tktR7e8fFUkfrZIVfJk/mlzGVv3UF/l6E42b0p+fjFr4XQectsLYjMJVhiO8Z4rvVUFfG1xKUc5SGja48/CPvYkzr3t/ksZAQjNDX1UIukZ7d3fHuaw53mCJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822473; c=relaxed/simple;
	bh=gQJx0hw8ktpOVzMQgzJ4UPoa4UdFT7S097c0TWcF5tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tzb1LT6rdXhr5oXq8G5V3R2VgfZth6/mAUXBtJRPIfEN8Fyzxgn81NKjl2R2Z3T3UlVdgy/fXQ1fxus38xkPREV5wu+T1BowHXmsViCC1p3En/LzV2pDfeDZELTB42tuNjh3rFLmFAVKHowDZjd8PmqNr5N02X7e9XiAMRthm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vROjpSYr; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac326390-3a3b-4d2d-9be8-f9ec2152eb6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758822469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltxiZCxj4vl+4564rdV2K0enablBoYFfJi76z7YT/pg=;
	b=vROjpSYrAmjkgNq+rdHra4kZh80mMNaBnPoq+Z/Ax/5u0cVg2cUlR+uqus4Q/8f7yz/RRV
	sXIBsogKceCOif3eCHogeJpB5FpoOd12GerknH/iXceDSe29LNzTsxBa/9J5P8AD250mq6
	WJBppgeaGYkCKapQiZkB5QJ1fIR1lFc=
Date: Thu, 25 Sep 2025 10:47:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/1] selftests: drv-net: Reload pkt pointer after
 calling filter_udphdr
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, stfomichev@gmail.com, kernel-team@meta.com
References: <20250925161452.1290694-1-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250925161452.1290694-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/25/25 9:14 AM, Amery Hung wrote:
> Fix a verification failure. filter_udphdr() calls bpf_xdp_pull_data(),
> which will invalidate all pkt pointers. Therefore, all ctx->data loaded
> before filter_udphdr() cannot be used. Reload it to prevent verification
> errors.
> 
> The error may not appear on some compiler versions if they decide to
> load ctx->data after filter_udphdr() when it is first used.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

