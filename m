Return-Path: <netdev+bounces-268899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIQrHGNTumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:25:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6922B6E4B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BEAB3069074
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEA833D51A;
	Wed, 18 Mar 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzWb5P32"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365A369999
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818512; cv=none; b=UwbwCnjt41nel6vf2Tscij5lnaquxMONj24Df6HsppS/p9tEyQXZck1bgKG/sdfjri6jjVhcbusmLki5dZVYlObbM+4n0/JF2QJO7HV6ha8Xh+OqNHR0Ii/+MHDcBCwFcS3O6S4QdT1YHu1JS18h1vG3PUBAvURT2ikvetE6bLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818512; c=relaxed/simple;
	bh=uE+cNE7U0mFNBw0jiKguaxk2YeaW18yxTGXmSVAF2mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHpw6MaELqLA1WiHTaOr+dWUG98rKEZOxcemioSiJ+QVnV4FNo3haKf3OHykWP2spVIUDa0tbBQiG+65qWBysct50L9arDh7rv6XZGxui+jxEA1X7D98ZSqTgCEjF3KTWKQF/AjY3R/m/aMx7iPqJ4aN3mXKypK4gxnTrpJRPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzWb5P32; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773818509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i48aAukTpS9/vkfz+SiAlZ+VTuL87+goLWmIkfRAULc=;
	b=VzWb5P32J/x+nai1WwNZKtuU9/FLv6o00f60ioH/4ifT/H2iTgv/gYv6/VhMB62w6PU3ZS
	yuyG87KmHtCBfPdtBZsidUImdjeYcE9UCycC531+nRyAR/aBAgKuuEcCKf4xAI7K6lwpRp
	b4Tr5K09iAb4BvSehs9U8bph8p6mmFM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-1HgfpIo5Nwejo0hApZ5ZmQ-1; Wed,
 18 Mar 2026 03:21:45 -0400
X-MC-Unique: 1HgfpIo5Nwejo0hApZ5ZmQ-1
X-Mimecast-MFC-AGG-ID: 1HgfpIo5Nwejo0hApZ5ZmQ_1773818504
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D21C1944EBF;
	Wed, 18 Mar 2026 07:21:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 657A11955F42;
	Wed, 18 Mar 2026 07:21:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: ouster@cs.stanford.edu
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [net-next,v17,09/14] net: homa: create homa_outgoing.c
Date: Wed, 18 Mar 2026 08:21:36 +0100
Message-ID: <20260318072136.269073-1-pabeni@redhat.com>
In-Reply-To: <20260316223228.2611-10-ouster@cs.stanford.edu>
References: <20260316223228.2611-10-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268899-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,common.sport:url]
X-Rspamd-Queue-Id: DD6922B6E4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: homa: create homa_outgoing.c

This file does most of the work of transmitting outgoing messages.
It is also responsible for copying data from user space into skbs.

> diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
> --- a/net/homa/homa_impl.h
> +++ b/net/homa/homa_impl.h

[ ... ]

> diff --git a/net/homa/homa_outgoing.c b/net/homa/homa_outgoing.c
> --- /dev/null
> +++ b/net/homa/homa_outgoing.c

[ ... ]

> +/**
> + * homa_xmit_unknown() - Send an RPC_UNKNOWN packet to a peer.
> + * @skb:         Buffer containing an incoming packet; identifies the peer to
> + *               which the RPC_UNKNOWN packet should be sent.
> + * @hsk:         Socket that should be used to send the RPC_UNKNOWN packet.
> + */
> +void homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk)
> +{
> +	struct homa_common_hdr *h = (struct homa_common_hdr *)skb->data;
> +	struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
> +	struct homa_rpc_unknown_hdr unknown;
                                        ^^^^^^^^^^
Does this code send uninitialized kernel stack memory over the network?
The struct homa_rpc_unknown_hdr unknown is only partially initialized.

Four fields are set:

	unknown.common.sport = h->dport;
	unknown.common.dport = h->sport;
	unknown.common.type = RPC_UNKNOWN;
	unknown.common.sender_id = cpu_to_be64(homa_local_id(h->sender_id));

But the remaining fields of homa_common_hdr (sequence, ack[3], doff,
reserved1, window, checksum, reserved2) are left uninitialized. These total
15 bytes of data.

__homa_xmit_control() copies the entire struct via memcpy():

	h = skb_put(skb, length);
	memcpy(h, contents, length);

and the packet is then transmitted over the network via ip_queue_xmit() or
ip6_xmit().

This sends uninitialized kernel stack memory contents over the wire, which is
an information leak.


> +	struct homa_peer *peer;
> +
> +	unknown.common.sport = h->dport;
> +	unknown.common.dport = h->sport;
> +	unknown.common.type = RPC_UNKNOWN;
> +	unknown.common.sender_id = cpu_to_be64(homa_local_id(h->sender_id));
> +	peer = homa_peer_get(hsk, &saddr);
> +	if (!IS_ERR(peer))
> +		__homa_xmit_control(&unknown, sizeof(unknown), peer, hsk);
> +	homa_peer_release(peer);
          ^^^^^^^^^^^^^^^^^^^^

Can this dereference an error pointer?  When homa_peer_get() fails and
returns an ERR_PTR (for example, -ENOMEM from allocation failure or
rhashtable insert error), homa_peer_release(peer) is called unconditionally on
the error pointer.

homa_peer_release() calls refcount_dec_and_test(&peer->refs), which
dereferences the invalid ERR_PTR address.

The IS_ERR check on the previous line correctly guards __homa_xmit_control
but does not guard homa_peer_release.


> +}

[ ... ]


