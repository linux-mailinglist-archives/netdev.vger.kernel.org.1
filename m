Return-Path: <netdev+bounces-211486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11CB193C7
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 13:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607DE174281
	for <lists+netdev@lfdr.de>; Sun,  3 Aug 2025 11:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE86622541F;
	Sun,  3 Aug 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="pCHdnDKS"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93631EDA3C;
	Sun,  3 Aug 2025 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219464; cv=none; b=BTU27KMxYc9m4T6bK8dViqVTujeHB6BDYJmXxD+qL1WDVAK8VXUFf/1OoK9tEYitfD/kqYBgJ3MDeeVBV5ldPU5VcxdZp5DyN+bU8KPpABXxhTXk5o3xckVNUxB8jJZ6dYM48vE1M2g/8oNT7K6xrYMNxFQN92ZVFL7kfWLQFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219464; c=relaxed/simple;
	bh=mH95pA4cftJ6NN9CFstldZceXxZhqt1S9l4BVHuUz3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtzTECtDAm54PHPSemKxXB7t5k3oESL177XDFMxb089+QEM71c+YwMl7WOZhGwf7/+fDTAbQEoaRPYPlTcKgepbJqGcKUcEM8QzFf3KcPTtR4Ax10hoS2eWjqem5v6Wn1gi2qBL+OWHkpxsOWllfismBwhz417qFG7fOTYApxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pCHdnDKS; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uiVWX-003vz3-8i; Sun, 03 Aug 2025 12:01:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=EL2StWgKuIJqWqQKx+j/2xqZwCUiP1U+Ud26xxbj8xY=; b=pCHdnDKSQFO018x3pvWq6uST1m
	zncPtEk6In+1fV6Fjc35EpfscsPPoMNvCXCU40E2qTqGzbg1XCtZhn+uxu6Ygx8P3kbIYeNUHWqly
	hVCj1LxCgumxoXux0XHJ27BOFRFiMjnZqY+e9eX7as8IcEVaE4SJvYTL7TFCgubWvEnN/aR/EXVyJ
	TVJ+yWjk5BJIUiFqGaII2YMfaEghgqi3uYg0CKpHhZk5Kfbvco0aXkMrYH8Bqw+DmZMnY2RDK7H4L
	qRErh/h9O9riaJI82HUGl35NrbY8R9GbdrZ746REt9EBpHbScDXwqW/SsFk2CBzFmH1e2MvRPLvDo
	4O4w/0mA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uiVWW-000606-7S; Sun, 03 Aug 2025 12:01:00 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uiVWB-002JcU-1D; Sun, 03 Aug 2025 12:00:39 +0200
Message-ID: <b6a2219b-32dd-4bb6-b848-45325e4e4ab9@rbox.co>
Date: Sun, 3 Aug 2025 12:00:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] kcm: Fix splice support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250725-kcm-splice-v1-1-9a725ad2ee71@rbox.co>
 <20250730180215.2ad7df72@kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250730180215.2ad7df72@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/25 03:02, Jakub Kicinski wrote:
> On Fri, 25 Jul 2025 12:33:04 +0200 Michal Luczaj wrote:
>> Flags passed in for splice() syscall should not end up in
>> skb_recv_datagram(). As SPLICE_F_NONBLOCK == MSG_PEEK, kernel gets
>> confused: skb isn't unlinked from a receive queue, while strp_msg::offset
>> and strp_msg::full_len are updated.
>>
>> Unbreak the logic a bit more by mapping both O_NONBLOCK and
>> SPLICE_F_NONBLOCK to MSG_DONTWAIT. This way we align with man splice(2) in
>> regard to errno EAGAIN:
>>
>>    SPLICE_F_NONBLOCK was specified in flags or one of the file descriptors
>>    had been marked as nonblocking (O_NONBLOCK), and the operation would
>>    block.
> 
> Coincidentally looks like we're not honoring
> 
> 	sock->file->f_flags & O_NONBLOCK 
> 
> in TLS..

I'm a bit confused.

Comparing AF_UNIX and pure (non-TLS) TCP, I see two non-blocking-splice
interpretations. Unix socket doesn't block on `f_flags & O_NONBLOCK ||
flags & SPLICE_F_NONBLOCK` (which this patch follows), while TCP, after
commit 42324c627043 ("net: splice() from tcp to pipe should take into
account O_NONBLOCK"), honours O_NONBLOCK and ignores SPLICE_F_NONBLOCK.

Should KCM (and TLS) follow TCP behaviour instead?

Thanks,
Michal


