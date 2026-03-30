Return-Path: <netdev+bounces-273385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNdMDlYMy2msDQYAu9opvQ
	(envelope-from <netdev+bounces-273385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:50:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C763626F4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 938EA302E318
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483313BED40;
	Mon, 30 Mar 2026 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwld01rk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615B3BD64A
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914625; cv=none; b=oOY1FrZCYhX7IyZapogwQ+3udgIpsYArEunPhKZIIgNY0X3Zy52hv9jAKqLyKqPv02PsSR30Yvj2jJ4QmcA7k0um5kbfYooNvGCyQW7Qt/PDAxkxAe4tELMg6JgjuL3FNqVpK7K1l0A5HN6too4pqM8mjiFTKvV/GaKMxlcosnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914625; c=relaxed/simple;
	bh=IKu99eJLKxEb+cabwk6c0H/g6/VfIhKW1QY/qwKQT/o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=J+d53h/yVn73EjbTOaeaZiXyh7YkJF1VZ0F/GDhA3Ox7r8abr5uYevIrx0mH5pDgxGiI5ajdEstEZQWxbGfAjb73OFiGPgyw2pdxRbdsQpNAvSNF+TTVPQUSgLMT9AJ3abbK/BLkuX6lj8KFJBuBwKyUzXBlqs1uffExUJY4Il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jwld01rk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774914623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4//0gHIbpafUUo1kR2n1Am7xkOI04D7fEcFujAkL3aw=;
	b=Jwld01rkrqHbupodp+Fg05aCHVJ6luaux00YHFZ8tS6eyGvivceKG6pOG+QHQY/VuZxE4r
	iY0qyFU5eLUKVQqrGXCRRxR80dKQ1Rxba0rOfb9mKMYU1k3R+pfUgWrdUgdMOtcxx2WhqK
	pbY7UR9V/7Schq0RNNwELkNKVg5AUbg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-zqA9f9snPU-ZRNj8WWh5tg-1; Mon,
 30 Mar 2026 19:50:17 -0400
X-MC-Unique: zqA9f9snPU-ZRNj8WWh5tg-1
X-Mimecast-MFC-AGG-ID: zqA9f9snPU-ZRNj8WWh5tg_1774914615
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D644180035C;
	Mon, 30 Mar 2026 23:50:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.35.245])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6465018002A6;
	Mon, 30 Mar 2026 23:50:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjDKfhS5TvEfrsOgBgAvFMPfAd3wT=Um2AQb4txHq5sAQ@mail.gmail.com>
References: <CAHk-=wjDKfhS5TvEfrsOgBgAvFMPfAd3wT=Um2AQb4txHq5sAQ@mail.gmail.com> <20260326131838.634095-1-dhowells@redhat.com> <20260326131838.634095-5-dhowells@redhat.com> <20260329121208.6092419d@kernel.org> <CAHk-=wiJ6gEELLviexdmSHnyjVoG7MFo8Qwhd1zxs_tCnL-=gQ@mail.gmail.com> <1179840.1774867765@warthog.procyon.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
    netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    John Johansen <john.johansen@canonical.com>,
    Minas Harutyunyan <hminas@synopsys.com>,
    Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
    linux-usb@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add on_list() also
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1317860.1774914607.1@warthog.procyon.org.uk>
Date: Tue, 31 Mar 2026 00:50:07 +0100
Message-ID: <1317861.1774914607@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273385-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,warthog.procyon.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8C763626F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Dammit, you should *KNOW* that already from core logic. Not with a
> flag, not with a function to ask, but from how things work. The whole
> "am I on a list or not" should not be a list issue, it should be
> obvious.

The circumstance in question is this: There's a list of outstanding calls
attached to the rxrpc network namespace.  Calls may hang around on it beyond
the life of the socket that created them for a little bit to deal with network
protocol cleanup, timer cleanup, work func cleanup.  Under normal operation,
calls are removed as the last ref is put.

However, should the namespace be deleted, rxrpc_destroy_all_calls() trawls the
list to report any calls that haven't been cleaned up and the calls are
deleted from the list as it reports them so that the spinlock doesn't have to
be kept held.  It used to do other work here too, IIRC, but that's no longer
the case, so perhaps this loop is not needed now, and a warning will suffice
if the list is not empty (or I could just report, say, the first 10 calls and
not worry about calling cond_resched()).  The wait at the bottom of the
function should be sufficient to hold up namespace deallocation.

If I don't delete entries in rxrpc_destroy_all_calls(), then rxrpc_put_call()
only needs list_empty() to guard against the call not having being queued yet.
I could have a flag for that, but it would be superfluous.

Note that the reason for the RCU walking is because /proc/net/rxrpc/calls
walks over the same list, so I still need the next patch which switches to
list_del_rcu().

David


