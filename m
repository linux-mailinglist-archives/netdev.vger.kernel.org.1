Return-Path: <netdev+bounces-280992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEhFEFZu62l2MwAAu9opvQ
	(envelope-from <netdev+bounces-280992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:21:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D17C45EEDD
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31CAE3005179
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E275377000;
	Fri, 24 Apr 2026 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMkWpvEn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE56366558;
	Fri, 24 Apr 2026 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036878; cv=none; b=kBSwg70pU0xSUwpOENKZjvPcMnijnkZwfSWYacg/wXkOzhlaKmY7YaUuVNPkANhJiediZvPOSp/dDFUk/rV2MISgHkDsLDpNUTU0fCKgOHPX1clRK1grK+gHCJ6rluNAtknA1sgB/x07pgaaWVjonanatb9a+m1/JbZyiZPtiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036878; c=relaxed/simple;
	bh=M1D7kI8zdMSMgAR3ek5eSiS/trHp74trKeuUDZ2Wblc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jv+btmSbYs67HvwR3o8QqjqtuwaF1aqCzkqnZsWXULEVN0Ej73yQtV6OOxJYiBZ7ZKjx2hFQcvoP5HOrIZNiYOEaf/mMSU47DcyCMogN48gaMlieYYJZ+X4sj4GOMI4f51avbutEtg3r5IfCHzwUFGDcGlx6nANeWhI2EgDCs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMkWpvEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DAEC19425;
	Fri, 24 Apr 2026 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777036878;
	bh=M1D7kI8zdMSMgAR3ek5eSiS/trHp74trKeuUDZ2Wblc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMkWpvEn3tvwvFRB2F3yHj24YoM8zRxN5fRUooShcWXFvCzJJxU7Mo+rg1zhPnXPX
	 oTcFLddEd2yI5B2Q32n6nSQbcpzyRcZBp3NbvyH0ZwNCHHgCDJwZiB2cjjF8uec329
	 euyYJW2gjHAswXX6Tsv85a580gqhmv/wbSxyhat4u67WaW2NBztKbfLW2BclZygAn5
	 /rFzneImy0h1sZ/vQTmDrYaum7/Y7sRgmX322ZxFGlRV6h32Qpky4aUHXZjS+hUh6+
	 RlNdYflh9rMfafJyOhYQkMZRmWZ4rkNEIqYFo0IvUcMIdQnxLhciODLNsBKkLfzM6f
	 4Yc3xHni6DEbA==
From: Simon Horman <horms@kernel.org>
To: shardulsb08@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardul.b@mpiricsoftware.com
Subject: Re: [PATCH v2] mptcp: do not drop partial packets
Date: Fri, 24 Apr 2026 14:20:52 +0100
Message-ID: <20260424132052.1066934-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
References: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D17C45EEDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280992-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
mptcp: do not drop partial packets

This commit modifies the handling of out-of-order packets where
map_seq < ack_seq < end_seq. Instead of dropping the entire packet,
it skips the already-acknowledged bytes and enqueues the remainder.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fbffd3a43fe86..4e9fba692a701 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -397,12 +397,24 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)

[ ... ]

> +	/* Partial packet: map_seq < ack_seq < end_seq.
> +	 * Skip the already-acked bytes and enqueue the new data.
> +	 */
> +	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> +	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
> +	msk->bytes_received += copy_len;
> +	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);

Should MPTCP_SKB_CB(skb)->map_seq also be advanced here to reflect the newly
adjusted offset?

If map_seq remains stale after skipping the already-acked bytes, does this
cause mptcp_inq_hint() to overestimate the amount of unread data? 

Looking at the hint calculation, it calculates the unread bytes using
READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq for the first
enqueued SKB.

If inq_hint is artificially large, could this corrupt the ioctl(FIONREAD)
and TCP_INQ cmsg values returned to userspace?

Furthermore, could this suppress receive window auto-tuning? In
mptcp_rcv_space_adjust(), an artificially large inq_hint might cause
the calculation copied -= mptcp_inq_hint(sk) to become negative, which
would stall window growth.

> +
> +	skb_set_owner_r(skb, sk);
> +	__skb_queue_tail(&sk->sk_receive_queue, skb);
> +	return true;
>  }

