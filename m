Return-Path: <netdev+bounces-274299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODIJFKG8zWlmgQYAu9opvQ
	(envelope-from <netdev+bounces-274299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:47:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF50382114
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BB88301074D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0591F0E25;
	Thu,  2 Apr 2026 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeSazap3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7F81AA8;
	Thu,  2 Apr 2026 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775090844; cv=none; b=JGYQFwbII1wPdSR5cAr+I8oi+wnx4AGR3/ljm0k3NTfzgZf4yPcyNL8GYTAePIqeTg2phW0D7PA3f5ld7kRIbgdotHaDanystqK6Ou7YRp5gTnYGxO2CAp5e8Bjk9NR96gA1XyBFj3JW4TLnJzpmAE8q8S4JRv6HUkwSivJWzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775090844; c=relaxed/simple;
	bh=3p1fnW5MX3EnZtoqcWfyNop4bYqqNpCKVhbv8HqI18s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeU/AkFLZ7YxGspNVe+FjD4fNljcV7eo2R9FWRQ0lvo/dANJA2qYHZYGx3NIyPy5HuRHbCgoAQWLB4Lq9zG4U1cSGqv+TmqBZ5YHkuq7UgJpUJbUtWH5n/Lsjvqjvk5g3IejuAqSuJfXoaTJ2aL24/TIw6SJftcvozjo91LphB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeSazap3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527DFC4CEF7;
	Thu,  2 Apr 2026 00:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775090843;
	bh=3p1fnW5MX3EnZtoqcWfyNop4bYqqNpCKVhbv8HqI18s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jeSazap3atrQmxJ4zG6VNNVqwN9fMSW4Sk/aZziTZ14qESdyzb2ItT2pxbPZusRn/
	 fGVeZ+NuprTUJfmfMUxrDlWae1NY4+A+EnTHY/F+pa6uX6LAxyoj+AWbjff7JSZdxq
	 zwglRb9mWLDnVYrDCNxqVlVsH0EDtJR3HEhXoQOk3A9bF6UVhnh0CW9fDHkTipKBff
	 fdrU0vlYg8VOMsw/7qqSEsJXfvkUn2LWlJt49L1J+tHDAwYQtTpwZlFayxIGRqMXU5
	 kdLZ10I52i5KEZeZ069HV2kWiR70VJTH8wE15BVl6bovI2fqv0k5cILv2oRe/3GR9V
	 EuFK/Xl4W4VSA==
Date: Wed, 1 Apr 2026 17:47:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fei Liu
 <feliu@redhat.com>
Subject: Re: [PATCH net v3] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Message-ID: <20260401174716.6b9fd993@kernel.org>
In-Reply-To: <20260331-b4-fib6_metric_set-kmemleak-v3-1-88d27f4d8825@gmail.com>
References: <20260331-b4-fib6_metric_set-kmemleak-v3-1-88d27f4d8825@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274299-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,linux.dev,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EF50382114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 12:17:18 +0800 Hangbin Liu wrote:
> -	if (f6i->fib6_metrics == &dst_default_metrics) {
> +	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
> +		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
>  		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);

Orthogonal, but I forgot to reply - could you poke at making
cmpxchg() take const on the second argument? The type of the
first and third args must obviously match exactly but the
second one is just a reference, it should be okay to make
it const :/

