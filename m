Return-Path: <netdev+bounces-47752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D927EB370
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A423B2811C8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7FD4174C;
	Tue, 14 Nov 2023 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TLLqK58I"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13D16421
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 15:22:51 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1811F
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:22:50 -0800 (PST)
Message-ID: <b6f7e7b9-163b-4c84-ad64-53bb147e8684@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699975368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeUd6dlhGzkkOjCSLGek3W6vZLbqao2ignx8q6Cp7bE=;
	b=TLLqK58IakiTKMnW9T1/cmA19BfqWGuS0EO2BCJhJFbBI47OhN3YV62Nz+UMQxtN6c58rR
	fUNAx5Ko6vy7ZfQBjEfiNIL0M1MUzKF07mAruZl2CIxPmD6hQ00recOLfGaQrXIB16eh7u
	NuIIhycN5Mg1Bu7R2Uh8bQC//EpaRsw=
Date: Tue, 14 Nov 2023 10:22:43 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next 08/14] net/mlx5e: Introduce lost_cqe statistic counter
 for PTP Tx port timestamping CQ
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20231113230051.58229-1-saeed@kernel.org>
 <20231113230051.58229-9-saeed@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231113230051.58229-9-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2023 15:00, Saeed Mahameed wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Track the number of times the a CQE was expected to not be delivered on PTP
> Tx port timestamping CQ. A CQE is expected to not be delivered of a certain
> amount of time passes since the corresponding CQE containing the DMA
> timestamp information has arrived. Increment the late_cqe counter when such
> a CQE does manage to be delivered to the CQ.
> 

It looks like missed/late timestamps is common problem for NICs. What do
you think about creating common counters in ethtool to have general
interface to provide timestamps counters? It may simplify things a lot.

