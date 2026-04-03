Return-Path: <netdev+bounces-275230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ00IOs00Gnm4gYAu9opvQ
	(envelope-from <netdev+bounces-275230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:45:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E35A39884F
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DCEA3003498
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098223CAE6D;
	Fri,  3 Apr 2026 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J12D1YOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FE303C9C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252675; cv=none; b=gXas+WLZ3vojHz93rGkrCGqnwfHtoBtMCmCyxiPopwgZ+FOyJwNnoxKOjVsf0cJxdo4OdI/KH3TrOoSVyuj86wjJWJZF9yzO7AbeRWNYeYq5TlKruAPu4rS2n9iKTunRKlA9ylRQoSy8y9cUTBcuUJeB4OsvlFOUdp9kPJWjbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252675; c=relaxed/simple;
	bh=kD2mhRtWb5aYeIEmE0f5JFYLQ6jAMpfpNSLm7FgcG4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXYejBjqhTsrnz1buxpFMQfEQNpbXJnWTFYPHMhJ2lfM0F/SSBJugu9B0YAOaFaXCQpksbKwpcNn7U1uDgDrP0QoQrxc+ywBfiPoaGE528/sBDuuaWFAlBZWT99JmVo+UJ+tSyqB3RSjVZrbsb5IOdjZNo1jpH3f6iqMPzSh3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J12D1YOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA34FC4CEF7;
	Fri,  3 Apr 2026 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775252675;
	bh=kD2mhRtWb5aYeIEmE0f5JFYLQ6jAMpfpNSLm7FgcG4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J12D1YOCIhyYAQYtfu7Lny8mmX8+FB3eTSXxOyOt06kWNVFZ5QGQVNUqzcFt6NPAB
	 lzC+Sy4Eda/DploYUI7H8is24TTF+P8wFhXYJ5zD91XE8a81S909svBQR3LqkFna9L
	 szqPxud5GRaGjCOC0KBhG12pr5XkrbYgD4GF8lcDf+DgXwnsr59D/lJe31zgAp7TZe
	 uPFNTmFM6LjnvOPMPbz3TuXwIEGj+37cMo+bRkZhkId6HHW/UpENPtPd88+2pbfBQY
	 89BvHWCU5w30kJZBkw8CIO57g6z3CA8tfvfY7/oNW8v5vTW0V+c/RCssQfpsdLxiGM
	 +E3cqJLpl0Jbw==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	yimingqian591@gmail.com,
	justin.iurman@gmail.com
Subject: Re: [PATCH net] ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
Date: Fri,  3 Apr 2026 14:44:19 -0700
Message-ID: <20260403214418.2233266-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402101732.1188059-1-edumazet@google.com>
References: <20260402101732.1188059-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-275230-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6E35A39884F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "more bugs to fix.."
---
ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()

This commit fixes potential NULL pointer dereferences in
__ioam6_fill_trace_data() by checking __in6_dev_get() and using
skb_dst_dev_rcu(). It also adds missing READ_ONCE() annotations.

> diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
> index 3978773bec42..05a0b7d7e2aa 100644
> --- a/net/ipv6/ioam6.c
> +++ b/net/ipv6/ioam6.c
> @@ -710,7 +710,9 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
>  				    struct ioam6_schema *sc,
>  				    unsigned int sclen, bool is_input)
>  {
> -	struct net_device *dev = skb_dst_dev(skb);
> +	/* Note: skb_dst_dev_rcu() can't be NULL at this point. */
> +	struct net_device *dev = skb_dst_dev_rcu(skb);

Could this code lead to an out-of-bounds access of the dev->_tx[] array
further down in this function?

While reviewing this patch, a pre-existing regression was noticed when
trace->type.bit6 is set:

    if (trace->type.bit6) {
        ...
        queue = skb_get_tx_queue(dev, skb);
        qdisc = rcu_dereference(queue->qdisc);

When is_input is true, the packet is on the RX path and skb->queue_mapping
contains the RX queue index of the ingress device.

If the ingress device has more RX queues than the egress device (dev) has
TX queues, skb_get_queue_mapping(skb) will exceed dev->num_tx_queues.

Since skb_get_tx_queue() does not clamp the index, will it return an
out-of-bounds pointer into the egress device's dev->_tx array, causing
dereferencing queue->qdisc to read invalid memory?

