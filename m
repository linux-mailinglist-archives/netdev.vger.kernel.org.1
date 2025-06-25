Return-Path: <netdev+bounces-201325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD5AE9055
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DCD189CFD5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CD2571C8;
	Wed, 25 Jun 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZF1Q+HKo"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DF251793;
	Wed, 25 Jun 2025 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887860; cv=none; b=eGid83aIlItQf4veJ4cdX1MjntUbLJqsb4GmmUyl4ikvFi0EguBhq1KXTJuyIVxFGTxO+v3gtowkASG5fEITWdKPqpxfncPxXgFs4ERUWCBnoVuG0lKrQRcYtk5U0KMT7DiZBUomH5rKlJiZatK+k4Zdxk0FYyaWn0PagbxrA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887860; c=relaxed/simple;
	bh=I2Of1uh4993NVFXiTuLKuBgYnWXxPqk2z4vndpccvL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfsWoWewNpKWYfUUApBq4hBEsf1jJQ2tFS1QM494rI2hVfxjlx215T4s1IWLTK4kKxZxYW7OMk82UuyWstrpuKZLV9oBccJWgAWG6wOfXUV+WD42geAE/VPbRdmHfdVDS9W8Xnm4q1gfWFx4vguiIekbwzBWIRdWqc72w98XCAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZF1Q+HKo; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUXuc-00FLI1-8r; Wed, 25 Jun 2025 23:44:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Ggmzr/eQWwOW6GTpvo4RpZdFy/B9ZT3dzPOMeQj0zRQ=; b=ZF1Q+HKoZdPQURkLDdLIiffP02
	Q5TMNPCaYiM6V4FyJ5oEJ8tdXAk7Na7be1vcg1nhWcHDz8B8smQEjYdGTv3BOvkqp39FwnMLoZw62
	4lUoiN+seYXBMC3xgN1e6FykNatsfsqPDW4Gcwc38x/oVxCrXcVsDWFYCup5nVA2nnmkBlEf+VzaC
	GZ4zFvpSouJeepDQDYiQpmgHfydKWt0Bn080wbjC8uV3iSrIy0Mm3Iig8CEBoXO5qhwq74qXjQqjA
	qRZtCZLr7Qz6+9i4EMrZu9Sc2iHpbUTh18o6ekVuz3eHsOAlwEseiqlGAEjIjIcINR+l7D5XtSXkK
	bsWHuk3g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUXua-0003v2-H7; Wed, 25 Jun 2025 23:44:08 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUXuP-0062ik-Ei; Wed, 25 Jun 2025 23:43:57 +0200
Message-ID: <05138641-9a78-494b-b13a-dd07fe10191c@rbox.co>
Date: Wed, 25 Jun 2025 23:43:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] net: splice: Drop nr_pages_max
 initialization
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Ayush Sawal <ayush.sawal@chelsio.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
 <20250624-splice-drop-unused-v1-6-cf641a676d04@rbox.co>
 <20250625100610.GO1562@horms.kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250625100610.GO1562@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 12:06, Simon Horman wrote:
> On Tue, Jun 24, 2025 at 11:53:53AM +0200, Michal Luczaj wrote:
>> splice_pipe_desc::nr_pages_max was initialized unnecessary in commit
>> 41c73a0d44c9 ("net: speedup skb_splice_bits()"). spd_fill_page() compares
>> spd->nr_pages against a constant MAX_SKB_FRAGS, which makes setting
>> nr_pages_max redundant.
>>
>> Remove the assignment. No functional change intended.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>> ---
>> Probably the same thing in net/smc/smc_rx.c:smc_rx_splice()?
> 
> Yes, it seems so to me.

OK, tomorrow I'll post v2 with smc_rx_splice() taken care of.

Thanks,
Michal


