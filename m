Return-Path: <netdev+bounces-274333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FLUIUDZzWmliQYAu9opvQ
	(envelope-from <netdev+bounces-274333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:49:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E417C382D4F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B04C303C00B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54033CE88;
	Thu,  2 Apr 2026 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItUuchsa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF32248AF;
	Thu,  2 Apr 2026 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098139; cv=none; b=P84gtgcI2GOuL2PnJYgLlTY9wf6QiZikhxupP6vILGpn2ujDw/w7evpIepIFbDA/m5dIvjms2sopvdjAABCEq+Bj7m3iTRkAvwdGQU+/CwU6UUKXjuzm+gQ+0YutqfbvCE5d7P+CjFdCqfZVpUzMvTYL0Nwfvtg39Oegz6jrlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098139; c=relaxed/simple;
	bh=/y7BtDXtMVn+5QZbRGNzHP7nGB8piHZSMw4Q3vnLvEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiHbJDWS9r9rZhDSNk9ayKqrRHwrH1lYgIEnUihjMoDRESZTAAXvaNiS+wbx9ENf6aEVH0UnI466uDNOe43ZqpA9dJRaA97CTzisleajLvtISVQK/H0ust3uSFcsoS/lnyhRnZQtxxlAq+JzoDWquUq5BR5t0Ihee8Ktm7nCwmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItUuchsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1FBC4CEF7;
	Thu,  2 Apr 2026 02:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098139;
	bh=/y7BtDXtMVn+5QZbRGNzHP7nGB8piHZSMw4Q3vnLvEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItUuchsaF+APiA+A78Wcgv8QRRBV4wifMs3FyUNJVBiXzXGHvIcMKfsI09Guah7KK
	 thmfxnO58m7yB6KUVvMfcxd7tZUZSitB0PcBLMBU6LEQ+cO9k1fQa5QA11bekg7M6J
	 X9V/uZM9aZUp1MVl93QBFGPxD6OchRcOZBYci2TUIB97DmlGYhtOVZD6hkdx+zt1F6
	 6w3roWmzqIB651UACtcUX9yKEhL/nnPRXqe0igXDPLZVtZxGp1KUCizn9qoQp49z+S
	 JoqnqoFz5ZEJF5s1I2fO03/+YdFuzLF6xS2Wy/nUyiM3Sa5zq8f9I3G4BNzAqEgD2g
	 Gkw3KvY/bB4Wg==
From: Jakub Kicinski <kuba@kernel.org>
To: ms@dev.tdt.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	yimingqian591@gmail.com,
	linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH net v2] net/x25: Fix overflow when accumulating packets
Date: Wed,  1 Apr 2026 19:48:55 -0700
Message-ID: <20260402024855.842920-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327-x25_fraglen-v2-1-143911c3f62a@dev.tdt.de>
References: <20260327-x25_fraglen-v2-1-143911c3f62a@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274333-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E417C382D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/x25: Fix overflow when accumulating packets

This commit adds a check to prevent x25_sock.fraglen from overflowing
during packet accumulation. It also resets the fragment length when
purging the fragment queue.

> diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
> index b981a4828d08..cb84c683d249 100644
> --- a/net/x25/x25_in.c
> +++ b/net/x25/x25_in.c
> @@ -34,6 +34,12 @@ static int x25_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
>  	struct sk_buff *skbo, *skbn = skb;
>  	struct x25_sock *x25 = x25_sk(sk);
>  
> +	/* make sure we don't overflow */
> +	if (x25->fraglen + skb->len > USHRT_MAX) {
> +		kfree_skb(skb);
> +		return 1;
> +	}

Does this cause the skb to be freed twice?

When x25_queue_rx_frame() frees the skb and returns 1, the caller
x25_state3_machine() leaves its local queued variable as 0 and returns 0.

This 0 value propagates up through x25_process_rx_frame() to callers
like x25_backlog_rcv() or x25_lapb_receive_frame(). Since the return
value indicates the packet was not consumed by the protocol stack, these
upper-level functions will call kfree_skb(skb) again on the already
freed skb.

Would it be safer to return 1 without calling kfree_skb(skb) here so
the callers can handle freeing the unconsumed packet?
-- 
pw-bot: cr

