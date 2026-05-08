Return-Path: <netdev+bounces-285953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MqsEnEl/mlTnQAAu9opvQ
	(envelope-from <netdev+bounces-285953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 20:03:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA6F4FA587
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500B73036EE6
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 18:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA002F5491;
	Fri,  8 May 2026 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YR75U+hL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40F2FFDE1
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263339; cv=none; b=q0gEwQcUtOh258tvWwR7XJc+OF5QYS+11EinR/bSxjdIN/1GN6pw26UGyCe88wECqodVRy/gq2/66gvJ/5+O0XRKaNWvXpbsWUZOXZT5f7MDwM91Rtsw7CNdu45QEh6na/ta9H+tJEIOcgIhOOQx4VLsmdFev+u0OplABmu8+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263339; c=relaxed/simple;
	bh=HcJz6VMTkfApFdjleG7mQcukjTCAb0JMtV1GPbyQ3D0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=i14Okn6q7VByfBW4HkiWPMDciOAkZgVvibwS0fbcVKKLflnMQUF9+jMVQBfNytxKWCByiNXIM++oRjjux2GrQymMhKMaCZFLRIr53IM4QDmYkdvxtTvDtZSJ+PQRBZW2ttcRcXkJlzfkS/UxBN7/NCOmvG+BtakZShRHJ5N9GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YR75U+hL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778263337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGqgfA1J5FpUiR5+Nk8eHRPb/t1oc8uclHJVTxFrrAo=;
	b=YR75U+hLvZVgck038UhE4zOlhml9RUv4xk+v6ilY4h7XftdmOeTk83SiDiR422oEuoKqPj
	5ZjgYobDoD1ByhIFB2JYydoY+ee4mcHHVkET2GX+sb51+80MRQMBSThtcLwD6L7UcjmJo9
	oC5ztdZd/SIhiO2t/UxYJxX9rFnxCos=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-P0XOWXJkNMKscSXIyy0kXg-1; Fri,
 08 May 2026 14:02:14 -0400
X-MC-Unique: P0XOWXJkNMKscSXIyy0kXg-1
X-Mimecast-MFC-AGG-ID: P0XOWXJkNMKscSXIyy0kXg_1778263332
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EBDD18002C8;
	Fri,  8 May 2026 18:02:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D43F1801A63;
	Fri,  8 May 2026 18:02:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260428024400.123337-3-ebiggers@kernel.org>
References: <20260428024400.123337-3-ebiggers@kernel.org> <20260428024400.123337-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    linux-afs@lists.infradead.org,
    Marc Dionne <marc.dionne@auristor.com>, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/5] net/rxrpc: Use local FCrypt-PCBC implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <286247.1778263325.1@warthog.procyon.org.uk>
Date: Fri, 08 May 2026 19:02:05 +0100
Message-ID: <286248.1778263325@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: AAA6F4FA587
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Eric Biggers <ebiggers@kernel.org> wrote:

> +	if (skb_linearize(skb) < 0)
> +		return -ENOMEM;

It seems skb_linearize() doesn't like being used in this fashion:

	kernel BUG at net/core/skbuff.c:2295!
	...
	RIP: 0010:pskb_expand_head+0x41/0x220
	 __pskb_pull_tail+0x5e/0x2f0
	 rxkad_verify_packet_2+0xa8/0x190
	 rxkad_verify_packet+0x12c/0x150
	 rxrpc_recvmsg_data+0x1b0/0x470
	 rxrpc_kernel_recv_data+0xa6/0x210
	 afs_extract_data+0x5e/0x180
	 yfs_deliver_fs_fetch_data64+0x10b/0x200
	 afs_deliver_to_call+0xea/0x440
	 afs_read_receive+0x8d/0x150
	 afs_fetch_data_async_rx+0x12/0x20
	 process_one_work+0x18e/0x2b0

which corresponds to this:

	BUG_ON(skb_shared(skb));

Presumably this is done because fcrypt_pcbc_decrypt() doesn't handle being
called on a split buffer.  I think this may require skb_copy() to be used
instead, but that would need to be handled in rxrpc_input_call_event().

I think rxkad_decrypt_response() should be okay because the encrypted data is
extracted into a buffer first before being decrypted.

David


