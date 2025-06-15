Return-Path: <netdev+bounces-197922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97ECADA423
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 23:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9B416AC73
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4388A264F9F;
	Sun, 15 Jun 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="UnsLciyz"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE82E11C1;
	Sun, 15 Jun 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750022411; cv=none; b=HHqg3rwfmd/xUg5EjJW/FOGgnuI3Pp2YYGHfF8BbW5LHTKoLgsTAx++t8Hg25r/RSNhABC8ca+cZIZPMqtQlZI9d19WAXonc4C9jbovzABGQkJuKMTxRV6j64wou232DKU0C8ju7SAztGgiZmFakjHgF5CZ0WW6LUZf3Nk7j9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750022411; c=relaxed/simple;
	bh=pF+VDK1lSRfixNDioJbH2C3rL1LTsFMEIzBiMO47TWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcWdNh2Auor8pL1TYnElrIwAvSe1ewnxPWlUPOXJoSpLTXnYvf43uzM+CPi8RDXxJbZF43AMrzt5hjiL1AzqF/MjyiI7XQIDqV2JrvdG6p0kzmcju2q4XgH5LSWI1BPVp2sFFs9bKQCVi1VmOT2oSdJNV5Ky963QVd1RVebdOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=UnsLciyz; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uQulf-005JRR-6V; Sun, 15 Jun 2025 23:19:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=jg26rz8Cov6nRtFe2RUQWQxJ0BOrZ21SgyWVv8qLzC4=; b=UnsLciyz3Dm6k462gQVv4fHbKX
	r5TreUK1T6Ayt0Lhc3L+Ie4reAKTSh6J274aCho9bt+eCZ+SUUsHfzn4H/b4jsAEVHff2iDjcfXQq
	bLnGUsGFtnjyNufY8yiWMEhMqFoQf8EA+q98NAEK9PVXkZzvpxY6XbEDKPhb8QvJZopMDHhQek7qv
	LHauQf/SfBVaMcUkRigD/BGXLLofbBXRK0a/wvmQX0jwbdjDjaPmMDha9UTt4KL0vAT21A1hGe3t5
	zsr/IfZQ6haspVwSFmm9j40EppQ7Xyn6BTh/ieuBzoDQey7Q1GxHFG9uDFzj+Tw2plK5Iz8rwDlPw
	s+0efCXA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uQule-0004SV-C3; Sun, 15 Jun 2025 23:19:54 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uQulX-000Hqv-Iv; Sun, 15 Jun 2025 23:19:47 +0200
Message-ID: <972af569-0c90-4585-9e1f-f2266dab6ec6@rbox.co>
Date: Sun, 15 Jun 2025 23:19:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Drop unused @sk of
 __skb_try_recv_from_queue()
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407-cleanup-drop-param-sk-v1-1-cd076979afac@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250407-cleanup-drop-param-sk-v1-1-cd076979afac@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/25 21:01, Michal Luczaj wrote:
> __skb_try_recv_from_queue() deals with a queue, @sk is never used.
> Remove sk from function parameters, adapt callers.
> 
> No functional change intended.

Looking at datagram.c, it's a similar story with skb_free_datagram(): its
@sk is unused since commit 4890b686f408 ("net: keep sk->sk_forward_alloc as
small as possible").

All this function does is `consume_skb(skb)`. Would it be worth dropping
the `sk` parameter? Or making callers directly invoke consume_skb()?

$ git grep skb_free_datagram | wc -l
52

Thanks,
Michal


