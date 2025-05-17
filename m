Return-Path: <netdev+bounces-191257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43D9ABA799
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4C79E852F
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D57263A;
	Sat, 17 May 2025 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVzeSZ89"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2EE4317D;
	Sat, 17 May 2025 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747446531; cv=none; b=E/kVOaIZYBsDhIu+OnN1noA0VU5lXvWVnAFJ6TWy4p4Azcvf5anrroDAtCvMMMwEoh6wlvfVZwjBeywTH3kcbET2HmtgTwO7FCVanmaOEaCZQMLNG2PC0ZbMB6OZ3ZOhxs6M+hSRO8yGVWqfqwjm2htKzVqidwfV/Q94JOjp1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747446531; c=relaxed/simple;
	bh=Irmfps1EQF9ywNKfDkjs3MqofSer0uMZcHX8vVuhjvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLfPlymw5raWDBy8CYZVRn2Iqqi1xNoQlavTmw5+Ts8c1n5izCIIj4B5OQoqDGOM3C6rZnG/4jVZi596d+BzYqW+dqmi7y/A7cG8SYu6ZomX+iIN5mh7uueTcRM08n+degfYTK+/E7GhWr59o2a9QpBZyDuiYdcTSsf7CtQrSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVzeSZ89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F087C4CEE4;
	Sat, 17 May 2025 01:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747446530;
	bh=Irmfps1EQF9ywNKfDkjs3MqofSer0uMZcHX8vVuhjvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVzeSZ89RduZqfREyKlf2nA8TGzMA1ShpyBt46dlB+NMt5QL2mLf9lmD3IyFIE1kV
	 fvP3ir4lp2shP1Ksu1bcxHJmessWHLAby6kv1bmtK3VB92VSqmviDd0iTb7bkewzYU
	 4fRDET0yrfj5kabpdpQS6zRoo8Eq3TVmnvxmhOAo+ypKjBgwc8hPFKedcVQK9yQFXU
	 fIFZtXv2g1n49ZLzIasm9lHCcArSBMS1PotF8zPzem2BNgGJhjGR9eOojMg+wW2mVn
	 etDvPko3JJHuehmdsy34pn2tpqWZLOyi/7rAOFknYwN7tIJUg9mCDdOX9VduTzPMMw
	 DboOtN7V9oCoQ==
Date: Fri, 16 May 2025 18:48:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 3/4] net: selftests: add checksum mode
 support and SW checksum handling
Message-ID: <20250516184849.27d795c1@kernel.org>
In-Reply-To: <20250515083100.2653102-4-o.rempel@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
	<20250515083100.2653102-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 10:30:59 +0200 Oleksij Rempel wrote:
> +enum net_test_checksum_mode {
> +	NET_TEST_CHECKSUM_COMPLETE,

Why COMPLETE? that means skb has checksum of the complete data.
If packet requires no checksumming you should probably use CHECKSUM_NONE

> +	switch (iph->protocol) {
> +	case IPPROTO_TCP:
> +		if (!pskb_may_pull(skb,
> +				   transport_offset + sizeof(struct tcphdr)))

Why are you so diligently checking if you can pull for the SW sum but
not for the HW sum? Both of them update the same header fields :)

> +static int net_test_setup_hw_csum(struct sk_buff *skb, struct iphdr *iph)
> +{
> +	u16 csum_offset;
> +
> +	skb->ip_summed = CHECKSUM_PARTIAL;
> +	skb->csum = 0;
> +
> +	switch (iph->protocol) {
> +	case IPPROTO_TCP:
> +		if (!tcp_hdr(skb))
> +			return -EINVAL;
> +		tcp_hdr(skb)->check = 0;

this filed should be filled with pseudo header checksum for HW offload,
not with 0, like the existing code did
-- 
pw-bot: cr

