Return-Path: <netdev+bounces-283302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOEECow09Wm4JQIAu9opvQ
	(envelope-from <netdev+bounces-283302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:17:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 764AD4B03C2
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5EB1301AF68
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 23:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C92F37CD4A;
	Fri,  1 May 2026 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9Acgwbd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909B378D93;
	Fri,  1 May 2026 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677148; cv=none; b=LR4qdp99m1avv2xkv2YZU0iaOS7r8BGDU/iWrWKnGILbN50CGqh9V2rTlmLLZgz8JRszoRITNGZl9b96WsalMe2wiSYTfP0BB8A44G0y8uzs4TNsz5HWWFvWVsfxa3gjZBsZjNHpGbB9yPU2bzHwdfrjZNPTj50bdOE1JVeR1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677148; c=relaxed/simple;
	bh=MX8uk4M0dr55PRK3sOFuIVKHpdprXAxlUcHnQp1HpFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpKdtVi9PpLaNLroA1m604TF2lkrsEt663ewYjKZBsUhZJWBnZlp5QkOfTMjNam57uFVeCLOas5OcabfZnYkES7mgkqsKRTX59HCpLbsvq8g/rsqusEuaI2+g5h8xn39M7kRFYUSseI9GRCGkR+eQv52XGpio92ufN9fwFwgxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9Acgwbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53106C2BCB4;
	Fri,  1 May 2026 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777677147;
	bh=MX8uk4M0dr55PRK3sOFuIVKHpdprXAxlUcHnQp1HpFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r9AcgwbdlqHIQMr13JvkN64CRPkhssYxCUdgTY4V+8dulzbilUwLp6+lHkJMAvhwd
	 2ckim2B1D4HSOvWQP2q8q6J6J/GSbor59U9ge8RE+IvYy0K7/ndd5dXfCsBsbvgxNc
	 6s3LJ8TNnEW1F/z91BADqeFlF2gHVwWxGWt9UN9/41cEETgi8EE0ZIgeP9z7SAK+Kl
	 uMbgfxyDs+8HDSonbLYodcijqHxY3uoi2ePPVmV7zx3EjLE2KvseTYjwlSzzNrqjIg
	 9LiAl37HwjOCqzZaQ8C8q05LsRSiBg8AoRWK3GGgBTUBCQgEeDYYI0ce6eEluZGgbf
	 4WYftLNKwS8kw==
Date: Fri, 1 May 2026 16:12:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dao Zhong Ma <cz1346219@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 antonio@openvpn.net, sd@queasysnail.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH 1/1] ovpn: tcp - defer TX from softirq to workqueue
Message-ID: <20260501161226.0239262c@kernel.org>
In-Reply-To: <20260501145425.757147-2-cz1346219@gmail.com>
References: <20260501145425.757147-1-cz1346219@gmail.com>
	<20260501145425.757147-2-cz1346219@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 764AD4B03C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283302-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri,  1 May 2026 22:54:25 +0800 Dao Zhong Ma wrote:
> ovpn_tcp_send_skb() holds sk->sk_lock.slock while performing the full TCP
> send in softirq context. This can hold the spinlock for a long time
> (large skb), blocking lock_sock() users. This can starve the RCU GP
> kthread and trigger RCU stalls warnings and hung tasks.
> 
> Defer the TCP send operation to process context:
> - In interrupt context, only enqueue the skb under the spinlock
>   schedule tcp_tx_work.
> - In process context, dequeue and flush the send queue under lock_sock()
> 
> This reduces the softirq critical section to a short duration, allowing
> lock_sock() users to make progress and preventing RCU stalls.

This appears to break the ovpn selftests

