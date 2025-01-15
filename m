Return-Path: <netdev+bounces-158664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD3A12E4E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C583A3AFF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4D1DC197;
	Wed, 15 Jan 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bKcCxzio"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8F19CC2A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980364; cv=none; b=rZnDzlZTAfNdced+BBqLcFVLHPrhGKBQUbj3o8/ohFFtYyis2J3oBSwwu97XYfewJc8LIguHhqiUYJunUm/RYpHbsdWG6+WBmvbYdLetVY8U+o8Vz+fwSsJVrZ8zRwvSnlqjYwaC1+PFnbSVAzSdGOQ3lf32TC38uMZhyVmRT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980364; c=relaxed/simple;
	bh=MXbAlLu9pVzUu6uAAGHpuvLE0y422jLnih0GnaszHXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4idIRNQ8RntZqPC6IVTCqIafWchlX3NEWvMcuqfaALy1FaWWpsjy3EC1uiGZijoFUK+P362nabJMs4PUhqOLfcB8UMRItFb9vdyT/VD/PDNk3g9EXb9nxTC77OuQKCa8i/RosuaLfQQE417IklL/6FCG4RQRCzZ+8/oq7mjo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bKcCxzio; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0071f8d-b7c8-48c2-b4c6-96074f4c4849@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736980345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXbAlLu9pVzUu6uAAGHpuvLE0y422jLnih0GnaszHXE=;
	b=bKcCxzioUOiB+sXouYofZ97y2CMonCwS3/2Z1Ny6YgHq1oRgZyPdbXVH4+QrP7KM5raovC
	Vb/SxLq/cC3nFgWmiWzySzEKB1HEuN/kbuuhtggM4NX6eM5e/lJX60edGRSBA8ni/aVvaP
	/R5DRXDuyaoSkplJG7RKlCOKOoilQ/I=
Date: Wed, 15 Jan 2025 14:32:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 07/15] net-timestamp: support SCM_TSTAMP_SCHED
 for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-8-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-8-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> +static void __skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)

nit. Remove the "__" prefix. There is no name conflict.


