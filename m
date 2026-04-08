Return-Path: <netdev+bounces-276441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EInXEUgz1mlZBwgAu9opvQ
	(envelope-from <netdev+bounces-276441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:51:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A38273BAF17
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 581B93018AF3
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C983A7F4D;
	Wed,  8 Apr 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPxXKrBf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B563B5840
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645390; cv=none; b=stLlXqD2dAIGyJrTAZ32tpeqs9oGzYM7FRuN1BmoB7J8Tux4SA+9Acrj40Il04R7wRl6Y/9284Rq60SWytP7Gzd3h/oFwl8c2gXFZqrdTVIG8SlY3p6RnV9SgVpg8qqqZI1Jqfl1D09EYNO2CVdPItCujVMQAg4ZtqVsCzLsqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645390; c=relaxed/simple;
	bh=t9IrrhkyhSb+z4eBX7dNZ41JDmozsK3DB5R1DCT1/SQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YeKpyjRUakXrThN3uBifRKE0TEXkrqMk/LeCZb6UlhdmDBb/RqgZM3kOJiztUnXvOybk5ap4g1VKD1VDe8jNRH87yD5NNMtQk/huJ0QG6NDJnP2mF+iHGrlpIgjcXueGotlofz3aD4g5xgCVznCAObebJ3Osyml4JzrpJZm9CFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPxXKrBf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775645387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4GtPMCSGxRJRore04Jxbs3MaKsOa0cc8ai4mLy6aCQ=;
	b=YPxXKrBfrW8DO8SJ9X0VVcxHvRVOyhc0EOT2KdeXVB/NmQzHi81y7FDNxiz+LrkyTOzLaa
	RtPOGBH3mkLtmTUXIoS4yeJW3VssOyDN/exrk9MF3VsP7AtC9o4WqIQIuU/qaj4kB0WK0C
	ShpL3ehzd4mqg4KF2OJBYUHU6IQJtzw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-QHcjOIFpPY27KWU6y1-HDw-1; Wed,
 08 Apr 2026 06:49:44 -0400
X-MC-Unique: QHcjOIFpPY27KWU6y1-HDw-1
X-Mimecast-MFC-AGG-ID: QHcjOIFpPY27KWU6y1-HDw_1775645382
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6599C19560A1;
	Wed,  8 Apr 2026 10:49:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A67A41800762;
	Wed,  8 Apr 2026 10:49:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260401192244.6ad86fc9@kernel.org>
References: <20260401192244.6ad86fc9@kernel.org> <aa7aeb86-2430-4c67-9d5d-bb27ad037865@allelesecurity.com> <20260401105614.1696001-1-dhowells@redhat.com> <20260401105614.1696001-16-dhowells@redhat.com> <1938758.1775071956@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com,
    Anderson Nascimento <anderson@allelesecurity.com>,
    netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Luxiao Xu <rakukuip@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
    Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
    Xin Liu <bird@lzu.edu.cn>, Ren Wei <enjou1224z@gmail.com>,
    Ren Wei <n05ec@lzu.edu.cn>, Simon Horman <horms@kernel.org>,
    stable@kernel.org
Subject: Re: [PATCH net v4 15/15] rxrpc: fix reference count leak in rxrpc_server_keyring()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2234186.1775645373.1@warthog.procyon.org.uk>
Date: Wed, 08 Apr 2026 11:49:33 +0100
Message-ID: <2234187.1775645373@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,allelesecurity.com,vger.kernel.org,auristor.com,davemloft.net,google.com,lists.infradead.org,gmail.com,lzu.edu.cn,kernel.org];
	TAGGED_FROM(0.00)[bounces-276441-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: A38273BAF17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> wrote:

> And in return maybe you can scan the AI output and tell me
> if any of it is legit? ;)
> 
> https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com

PATCH 2
-------
The complaint it makes about overflows in relation to patch 2:

	net/rxrpc/key.c:rxrpc_preparse_xdr_yfs_rxgk() {
	    ...
	    keylen = ntohl(key[-1]);
	    _debug("keylen: %x", keylen);
	    keylen = round_up(keylen, 4);
	    ...
	    tktlen = ntohl(ticket[-1]);
	    _debug("tktlen: %x", tktlen);
	    tktlen = round_up(tktlen, 4);
	    ...
	}

is actually addressed by:

	[PATCH net v4 05/15] rxrpc: Fix RxGK token loading to check bounds

I guess it doesn't look forward through the patches?


PATCH 8
-------
In regards to patch 8, it asks:

	Does this change introduce an asymmetric behavior between configuring
	RXRPC_SECURITY_KEY and RXRPC_SECURITY_KEYRING?

Yes, but it's then correct.  An AF_RXRPC server socket can also make client
calls - and, indeed, the kernel AFS client requires this.  The kernel AFS
client makes filesystem access/manipulation client calls but also listens for,
amongst other things, change notifications from the server.

With regards to its complaint about patch 12, I should really switch to using
lib/crypto/ to avoid using any memory allocation, but, yes, it has a point and
that crypto_skcipher_decrypt() (and encrypt) can fail too.

"sp->len < 8" is checked for at the beginning of the functions
rxkad_verify_packet_2(), so it must be at least one block in size.  rxkad uses
pcbc to wrap fcrypt which should take care of the non-block alignment.

I'll add a patch to add error handling.


PATCH 13
--------
For patch 13, it says:

	Are there integer overflows in rxgk_verify_response() when handling
	token_len?

Yeah - I do the round up before the check.  I'll add a patch to check that the
raw token_len <= len too (len must be < 65536 as the response must fit in a
single UDP packet).

It also says:

	Does rxgk_verify_response() leak the rxgk_context structure (gk)?

Yep.  Another patch for that.

And:

	Does rxgk_do_verify_authenticator() still perform an out-of-bounds
	read if the authenticator is smaller than 24 bytes?

Unfortunately, yes.  Add one for that.

Further, it says:

	Can modifying conn->channels[i].call_counter here cause a data race?

It shouldn't, since the value is only used to allocate the number for a call
that is set in callNumber in the Rx header for that call (well, the number may
also be copied inside the encrypted payload) but it's only *interpreted* by
the peer.

The way Rx works is that there's a separate callNumber space on each channel
on each connection.  Only one call can be in progress on a given channel (the
channel number is in the bottom two bits of the connection ID field), and
calls on a channel are numbered consecutively.  Seeing a new incoming call
with the next higher callNumber implicitly completes and ACKs the previous
call on that channel (potentially rendering explicit ACK packets unnecessary
on a busy channel).

If, however, a connection becomes idle, the server can just discard its record
of it.  Should the client resume activity on that connection, the RESPONSE
packet conveys the client's call counter for each channel, from which the
server reinitialises the counters.

rxrpc_expose_client_call() cranks the counter for the client side;
rxgk_do_verify_authenticator() sets the counter for the server side.  This
sets the expectation in a secure environment of what callNumbers should be
next on a connection to help prevent replay attacks.

If the server sees the call ID revert more than 1 (to allow for duplicate
packets from the previous call), it should abort the connection.

So I think nothing needs to be fixed here, as a secure connection isn't
allowed to proceed until the RESPONSE packet is fully parsed and the transport
security set up.


PATCH 14
--------
For patch 14, it says:

	While this fixes the panic for auth_len, can a maliciously large
	token_len (e.g., 0xFFFFFFFF) cause an integer overflow in the same
	function that leads to the exact same BUG_ON() panic?

but this is the same as the first thing it says against patch 13.  I've added
a patch to check token_len.

Ditto for:

	Does this function also unconditionally leak the rxgk_context
	allocated for the transport key?

It then says:

	Are there memory leaks and data races if duplicate RESPONSE packets
	are processed concurrently?

That can't happen as there's a single work item, conn->processor, that
processes all connection-level events, including CHALLENGE and RESPONSE
issuing and parsing for that connection.  Each connection has its own totally
independent security context, so there shouldn't be interference between two
connections.

And finally, it says:

	If rxrpc_process_event() does not verify if the connection is already
	secured before invoking the verify_response() callback, duplicate
	packets would cause rxgk_verify_response() to unconditionally
	overwrite conn->key with the new key, leaking the previous key's
	reference.

	Additionally, if rxgk_init_connection_security() unconditionally
	overwrites conn->rxgk.keys[] without putting the old key or holding
	conn->security_use_lock, could this cause another rxgk_context leak
	and race against concurrent read accesses in rxgk_get_key()?

These are both addressed by a patch I've been sent that I'll add.


PATCH 15
--------
Regarding patch 15, which provides an alternative fix to patch 8, I previously
asked you to drop patch 15 - but I'm thinking now it's probably better to keep
patch 15 and drop patch 8 (and change patch 15 to return -EINVAL).

David


