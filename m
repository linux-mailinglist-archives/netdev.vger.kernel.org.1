Return-Path: <netdev+bounces-297996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hh98ILNvKmo9pQMAu9opvQ
	(envelope-from <netdev+bounces-297996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:20:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A466FCA8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:20:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=cMngd2Nc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297996-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297996-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94DD3300C330
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6819377020;
	Thu, 11 Jun 2026 08:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F925373BE4
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:20:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166001; cv=none; b=TVNVcU7Q61ZoIgY5RqRLO8fELL8DO8ZWI9xEgV1njNBvhonO1LX83IQluv5tvqWOfy01wsvMhg7IRZMTp6niemleGfFP9pvgCeMrICkC58fByE0op1VoHZVf40El8Wxi8DFQxwnwOlNMB2Vm723ThW05aEi3av5AdbyI12+LXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166001; c=relaxed/simple;
	bh=zfUHBvOS9rLd1Jwao3dD4EjPfWEHPV7ZqtcvIiZwq2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwnMqkQCQUrw1MgJP+4uiVneT9ArPkUAt+wuv/VuOd9ui4dzcTvg8Qj1wBy/YvYA1cmpczlmq0Q8urN3ijNIRoGnxC27aaHaUpDmW9dYHj1QNs9FhhZRPfbfAVMV/wzNjIc5ijqtJpdTu/OUlwkRnx6twXkyAQXuu0yxT9AMjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMngd2Nc; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781165999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2Tbl5YSafMDU9v5maENUMhUQohNtmwiAB1oNrOT/RY=;
	b=cMngd2Ncv+kXj3bPOKZ5slEEuXnhsc4sH5oTbUZe4n2FmyIEuuokglL6aTHQ6b3p5YXSDp
	MrDGdAjyUfjnNTTlZR2643ukhgoBd9zWixjQTfrhvbDKNnWoPvgTrfVp/2bfC7ADrvBj+o
	/gS+mH397otsqaO+0qbRz0oXHlTDjQw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-ybql3r6cPaOiNFqK4AmwzA-1; Thu,
 11 Jun 2026 04:19:53 -0400
X-MC-Unique: ybql3r6cPaOiNFqK4AmwzA-1
X-Mimecast-MFC-AGG-ID: ybql3r6cPaOiNFqK4AmwzA_1781165989
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A43D41955F26;
	Thu, 11 Jun 2026 08:19:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.53])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83A8C1954B0B;
	Thu, 11 Jun 2026 08:19:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lucien.xin@gmail.com
Cc: netdev@vger.kernel.org,
	quic@lists.linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	metze@samba.org,
	mbuhl@openbsd.org,
	tfanelli@redhat.com,
	hepengtao@xiaomi.com,
	dreibh@simula.no,
	linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	linkinjeon@kernel.org,
	tom@talpey.com,
	kernel-tls-handshake@lists.linux.dev,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	steved@redhat.com,
	hare@suse.de,
	aahringo@redhat.com,
	dhowells@redhat.com,
	matttbe@kernel.org,
	mail@johnericson.me,
	xiyou.wangcong@gmail.com,
	alibuda@linux.alibaba.com,
	jbaron@akamai.com,
	illiliti@protonmail.com,
	sd@queasysnail.net,
	marcelo.leitner@gmail.com,
	daniel@haxx.se,
	andrew.gospodarek@broadcom.com,
	mef@scarletmail.rutgers.edu,
	paul@jakma.org
Subject: Re: [PATCH net-next v13 07/15] quic: add connection id management
Date: Thu, 11 Jun 2026 10:19:28 +0200
Message-ID: <20260611081928.137149-1-pabeni@redhat.com>
In-Reply-To: <0565988e6b54dac937fa00cdb3b09adef9650be6.1780855297.git.lucien.xin@gmail.com>
References: <0565988e6b54dac937fa00cdb3b09adef9650be6.1780855297.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297996-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:lucienxin@gmail.com,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 213A466FCA8

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Now I have enough information to produce the report.

commit e00266d0eea858a744fd827548eb8ebc6868f92c
Author: Xin Long <lucien.xin@gmail.com>

quic: add connection id management

This commit introduces struct quic_conn_id_set for managing QUIC
Connection IDs along with helpers to add, remove, and look up source
and destination CIDs, including a global hash table for source CID
lookup on the RX path.

> diff --git a/net/quic/connid.c b/net/quic/connid.c
> new file mode 100644
> index 000000000000..b1a39feb827e
> --- /dev/null
> +++ b/net/quic/connid.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* QUIC kernel implementation
> + * (C) Copyright Red Hat Corp. 2023
> + *
> + * This file is part of the QUIC kernel implementation
> + *
> + * Initialization/cleanup for QUIC protocol support.
> + *
> + * Written or modified by:
> + *    Xin Long <lucien.xin@gmail.com>
> + */
> +
> +#include <linux/quic.h>
> +#include <net/sock.h>
> +
> +#include "common.h"
> +#include "connid.h"
> +
> +/* Lookup a source connection ID (scid) in the global source connection ID hash
> + * table.
> + */
> +struct quic_conn_id *quic_conn_id_lookup(struct net *net, u8 *scid, u32 len)
> +{
> +	struct quic_shash_head *head = quic_source_conn_id_head(net, scid, len);
> +	struct quic_source_conn_id *s_conn_id;
> +	struct quic_conn_id *conn_id = NULL;
> +	struct hlist_nulls_node *node;
> +
> +	hlist_nulls_for_each_entry_rcu(s_conn_id, node, &head->head, node) {
> +		if (net != sock_net(s_conn_id->sk))
> +			continue;
> +		if (s_conn_id->common.id.len != len ||
> +		    memcmp(scid, &s_conn_id->common.id.data, len))
> +			continue;
> +		if (likely(refcount_inc_not_zero(&s_conn_id->sk->sk_refcnt)))
> +			conn_id = &s_conn_id->common.id;
> +		break;
> +	}

[Critical]
Can s_conn_id->sk be freed while this RCU walk is running?  The
s_conn_id itself is freed via call_rcu() in quic_source_conn_id_free(),
but the struct sock it points to does not appear to be RCU-protected.

A grep across this series for SOCK_RCU_FREE and SLAB_TYPESAFE_BY_RCU
under net/quic returns no matches, and quic_init_sock() does not call
sock_set_flag(sk, SOCK_RCU_FREE), so sk_destruct() will free the sock
synchronously rather than after a grace period.

Consider this sequence:

  CPU0 (RX path, rcu_read_lock held)        CPU1 (close path)
  hlist_nulls_for_each_entry_rcu(..)
    /* sees s_conn_id still linked */
                                            sk_destruct()
                                              quic_destroy_sock()
                                                quic_conn_id_set_free()
                                                  /* unhash + call_rcu
                                                     defers s_conn_id
                                                     free, but not sk */
                                              sk_prot_free()  /* sk gone */
    sock_net(s_conn_id->sk)         /* UAF read of freed sock */
    refcount_inc_not_zero(
        &s_conn_id->sk->sk_refcnt)  /* UAF refcount op */

Once quic_packet_get_sock() (in the later 'quic: add packet parser
base' patch) wires this lookup into every short- and long-header
packet, an incoming packet racing with close() on the matching socket
would dereference freed sock memory.

Would setting SOCK_RCU_FREE on the QUIC sockets, switching the proto
slabs to SLAB_TYPESAFE_BY_RCU, taking sock_hold() when the sk pointer
is stored in s_conn_id, or otherwise gating the sk free behind an RCU
grace period address this?

> +
> +/* Check if a given stateless reset token exists in any connection ID in the
> + * connection ID set.
> + */
> +bool quic_conn_id_token_exists(struct quic_conn_id_set *id_set, u8 *token)
> +{
> +	struct quic_common_conn_id *common;
> +	struct quic_dest_conn_id *dcid;
> +
> +	dcid = (struct quic_dest_conn_id *)id_set->active;
> +	if (memchr_inv(dcid->token, 0, QUIC_CONN_ID_TOKEN_LEN) &&
> +	    !memcmp(dcid->token, token, QUIC_CONN_ID_TOKEN_LEN))
> +		return true; /* Fast path. */
> +
> +	list_for_each_entry(common, &id_set->head, list) {
> +		dcid = (struct quic_dest_conn_id *)common;
> +		if (common == id_set->active)
> +			continue;
> +		if (memchr_inv(dcid->token, 0, QUIC_CONN_ID_TOKEN_LEN) &&
> +		    !memcmp(dcid->token, token, QUIC_CONN_ID_TOKEN_LEN))
> +			return true;
> +	}
> +	return false;
> +}

[Medium]
Is memcmp() the right comparison primitive for the stateless reset
token here?  RFC 9000 section 10.3 treats the token as a secret that
authorises tearing down a connection, and the commit message states
this helper is used during stateless reset processing on incoming
packets.

lib/string.c's memcmp() returns at the first differing byte (and
performs unaligned word-sized loads on architectures that allow it),
so the time taken to return false leaks how many leading bytes of the
supplied token match a stored token.  Would crypto_memneq() from
<crypto/algapi.h>, which is constant-time, be more appropriate for
comparing the token bytes?

> +
[ ... ]
> +/* Add a connection ID with sequence number and associated private data to the
> + * connection ID set.
> + */
> +int quic_conn_id_add(struct quic_conn_id_set *id_set,
> +		     struct quic_conn_id *conn_id, u32 number, void *data)
> +{
[ ... ]
> +	/* Locate insertion point to keep list ordered by number. */
> +	list = &id_set->head;
> +	list_for_each_entry(common, list, list) {
> +		if (number == common->number)
> +			return 0; /* Ignore if it already exists on the list. */
> +		if (number < common->number) {
> +			list = &common->list;
> +			break;
> +		}
> +	}
[ ... ]
> +	list_add_tail(&common->list, list);
> +
> +	if (number == quic_conn_id_last_number(id_set) + 1) {
> +		if (!id_set->active)
> +			id_set->active = common;
> +		id_set->count++;
> +
> +		/* Increment count for consecutive following IDs. */
> +		list_for_each_entry_continue(common, &id_set->head, list) {
> +			if (common->number != ++number)
> +				break;
> +			id_set->count++;
> +		}
> +	}
> +	return 0;
> +}

[Medium]
Does this function correctly maintain id_set->count when a CID is
inserted before all existing entries?  The loop above explicitly
handles the "number < common->number" case, suggesting out-of-order
insertion is intended to be supported.

Consider starting from list=[5], count=1 (so first=5, last=5) and
calling quic_conn_id_add(..., number=3, ...):

  - The location loop sets list = &common(5)->list and breaks.
  - list_add_tail() inserts common(3) before common(5),
    yielding list=[3, 5].
  - The post-insert check evaluates:
        quic_conn_id_last_number(id_set)
            = quic_conn_id_first_number(id_set) + count - 1
            = 3 + 1 - 1
            = 3
    so the test "number == last + 1" becomes "3 == 4" and the count
    update branch is skipped.

The end state is list=[3, 5] with count still 1, so entry 5 is
silently uncounted.  A subsequent quic_conn_id_remove(id_set, 3)
then trips the WARN_ON_ONCE(number >= last_number) because
last_number reads as 3.

Should the count adjustment also handle the case where the inserted
CID lowers first_number?

> +
> +/* Remove consecutive connection IDs from the set with sequence numbers less
> + * than or equal to a number.
> + */
> +void quic_conn_id_remove(struct quic_conn_id_set *id_set, u32 number)
[ ... ]
-- 
This is an AI-generated review.


