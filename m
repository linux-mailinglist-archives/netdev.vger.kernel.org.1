Return-Path: <netdev+bounces-297998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ue7NOThwKmpmpQMAu9opvQ
	(envelope-from <netdev+bounces-297998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:22:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCE466FD03
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:22:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NlcJUzdq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297998-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297998-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F69F300D179
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F33644A4;
	Thu, 11 Jun 2026 08:20:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62A377541
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:20:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166045; cv=none; b=TomFk/c4v8iGK+z/MH12sS0JQUhH18UWWpiB0JvasXi3wgm5wIoR+7Y90r/3RJzCH3ygQ+eR1wRFH73AhQ4+kf4P8z/FWnOmtp/XV7vtcLkHvPmHzVJ4z1WZ4cKQj2TmsTtlS2uUgDW4tqkTNhsS3KhaBDbe4JicjJ+QncA8jIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166045; c=relaxed/simple;
	bh=kkcQnZHnYFny0i1w/9shp6dqBz5e0LrlromRHt8KlPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bH+IJi0PqTSmon3NT5QgqPBbksYB9EKPsEoxUaC/KDNvft3EOxPI5aF/wRscE+7TdqE/luIWYxYUSPLHHpUy4lFAYJch1+kQsmZyPMOZ8ngbyq1KioclMviODbob9+fqGrAvEH923h58OttcW0hGmSn9XK+TRL/wjRbjD+8YVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlcJUzdq; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3hQIL6Il9n0pGlq7JeeRoDQSxplVOOUfBIF2DUxuG8=;
	b=NlcJUzdqT0wWJh+MMZvKt2iREAggK3w908jdWujFLxtFkWQt9DViMHcOEzNQtfK9a1NbUB
	V3q5ljdbyoYIu7ZnatBZFSh9t6rB+JeVIi4HywC8MdbAihJqhEMYGeO0esLqnBcF8/KOgy
	aDNQjy4WS8br4Y8WCba85OdxcVBRDWU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-cWV9Wn1UPYSFUoUMAlqHmA-1; Thu,
 11 Jun 2026 04:20:38 -0400
X-MC-Unique: cWV9Wn1UPYSFUoUMAlqHmA-1
X-Mimecast-MFC-AGG-ID: cWV9Wn1UPYSFUoUMAlqHmA_1781166035
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E188B1944D1C;
	Thu, 11 Jun 2026 08:20:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C66531800347;
	Thu, 11 Jun 2026 08:20:23 +0000 (UTC)
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
Subject: Re: [PATCH net-next v13 15/15] quic: add packet parser base
Date: Thu, 11 Jun 2026 10:20:08 +0200
Message-ID: <20260611082008.138377-1-pabeni@redhat.com>
In-Reply-To: <0b03854cabaac243a0cdf42375c66cd033750bd0.1780855297.git.lucien.xin@gmail.com>
References: <0b03854cabaac243a0cdf42375c66cd033750bd0.1780855297.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,redhat.com,samba.org,openbsd.org,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297998-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FCE466FD03

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
quic: add packet parser base

This patch adds the QUIC packet RX parser, including ALPN extraction
from the Client Initial to demux to the right listener, an ICMP-driven
PMTU update path, and a per-net backlog/work for deferred parsing.

> diff --git a/net/quic/packet.c b/net/quic/packet.c
> index ba5204aceda6..430fc06d0012 100644
> --- a/net/quic/packet.c
> +++ b/net/quic/packet.c

[ ... ]

> +static int quic_packet_get_alpn(struct quic_data *alpn, u8 *p, u32 len)
> +{
> +	int err = -EINVAL, found = 0, exts = 0;
> +	u64 length, type;
> +

[ ... ]

> +	while (len >= 4) { /* Scan extensions for ALPN (TLS_EXT_alpn). */
> +		if (!quic_get_int(&p, &len, &type, 2))
> +			break;
> +		if (!quic_get_int(&p, &len, &length, 2))
> +			break;
> +		if (len < (u32)length) /* Incomplete TLS extensions. */
> +			return 0;

[Medium]
Should this branch be treated as a parse failure rather than a success?

The other length-bound checks in this same function return err (-EINVAL)
when a declared length exceeds the remaining buffer, but this one returns
0 without populating alpn. The callers initialise alpn as

	struct quic_data alpns = {};

and quic_listen_sock_lookup() then takes the no-ALPN branch:

    if (!alpns->len) { /* No ALPNs or parse failed */
        sk_nulls_for_each_rcu(tmp, node, &head->head) {
            ...
            if (... && (!alpns->data || !quic_alpn(tmp)->len)) {

Because alpns->data is still NULL, the match collapses to true and any
listener bound to the address/port will match, including ones that
registered a specific ALPN list. Can a peer reach an ALPN-restricted
listener by sending a Client Initial with one extension whose declared
length is larger than what is left in the ClientHello?

Would returning err here (or always assigning alpn->data before
returning) match the comment in quic_listen_sock_lookup() that
distinguishes "TLS parsing succeeded but no ALPN was found" from "parse
failed"?

> +		if (type == TLS_EXT_alpn) { /* Found ALPN extension. */
> +			if (length > QUIC_ALPN_MAX_LEN)
> +				return err;
> +			len = length;
> +			found = 1;
> +			break;
> +		}
> +		/* Skip non-ALPN extensions. */
> +		p += length;
> +		len -= length;
> +		if (exts++ >= TLS_MAX_EXTENSIONS)
> +			return err;

[Low]
Is the post-increment intended here? With TLS_MAX_EXTENSIONS == 128, the
check (exts++ >= 128) first becomes true when exts has already reached
129, so 129 extensions are consumed before bail-out even though the
constant name suggests a cap of 128. Would

	if (++exts > TLS_MAX_EXTENSIONS)
		return err;

(or moving the check to the loop top) better reflect the intended limit?

> +	}

[ ... ]

> +static int quic_packet_parse_alpn(struct sk_buff *skb, struct quic_data *alpn)

[ ... ]

> diff --git a/net/quic/socket.c b/net/quic/socket.c
> index 8f348d7c678b..19b164baf55d 100644
> --- a/net/quic/socket.c
> +++ b/net/quic/socket.c

[ ... ]

> +struct sock *quic_sock_lookup(struct sk_buff *skb, union quic_addr *sa,
> +			      union quic_addr *da, struct sock *usk,
> +			      struct quic_conn_id *dcid)
> +{

[ ... ]

> +	rcu_read_lock();
> +begin:
> +	sk_nulls_for_each_rcu(tmp, node, &head->head) {
> +		if (net != sock_net(tmp))
> +			continue;
> +		paths = quic_paths(tmp);
> +		odcid = quic_path_orig_dcid(paths);
> +		if (quic_cmp_sk_addr(tmp, quic_path_saddr(paths, 0), sa) &&
> +		    quic_cmp_sk_addr(tmp, quic_path_daddr(paths, 0), da) &&
> +		    quic_path_usock(paths, 0) == usk &&
> +		    (!dcid || !quic_conn_id_cmp(odcid, dcid))) {
> +			sk = tmp;
> +			break;
> +		}
> +	}

[High]
Is the sk memory itself RCU-protected here? sk_nulls_for_each_rcu()
dereferences fields of tmp (sock_net(tmp), quic_paths(tmp),
quic_path_saddr(...), etc.) before any reference is taken. That is only
safe when the sk allocation is freed via RCU.

quic_init_sock() does not call sock_set_flag(sk, SOCK_RCU_FREE), and
neither quic_prot nor quicv6_prot sets slab_flags to SLAB_TYPESAFE_BY_RCU,
so sk_destruct() (and quic_sock_destruct()) runs synchronously on the
last sock_put(). Can a parallel close on tmp free the sock between
sk_nulls_for_each_rcu() exposing it and the field dereferences above?

The same shape appears in quic_listen_sock_lookup() further down, where
quic_alpn(tmp)->len is read inside the RCU walk before
refcount_inc_not_zero().

> +	if (sk && unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +		sk = NULL;
> +	rcu_read_unlock();
> +	return sk;
> +}

[ ... ]

> +struct sock *quic_listen_sock_lookup(struct sk_buff *skb, union quic_addr *sa,
> +				     union quic_addr *da,
> +				     struct quic_data *alpns)
> +{

[ ... ]

> +	rcu_read_lock();
> +	if (!alpns->len) { /* No ALPNs or parse failed */
> +		sk_nulls_for_each_rcu(tmp, node, &head->head) {

[ ... ]

> +			a = quic_path_saddr(quic_paths(tmp), 0);
> +			if (net == sock_net(tmp) &&
> +			    quic_cmp_sk_addr(tmp, a, sa) &&
> +			    quic_path_usock(quic_paths(tmp), 0) == skb->sk &&
> +			    (!alpns->data || !quic_alpn(tmp)->len)) {

[ ... ]

> @@ -48,6 +196,9 @@ static void quic_sock_destruct(struct sock *sk)
>  	for (i = 0; i < QUIC_CRYPTO_MAX; i++)
>  		quic_crypto_free(quic_crypto(sk, i));
>  
> +	/* Deferred ALPN free for RCU readers in quic_listen_sock_lookup(). */
> +	quic_data_free(quic_alpn(sk));
> +

Without SOCK_RCU_FREE or SLAB_TYPESAFE_BY_RCU on quic_prot/quicv6_prot,
does moving the alpn free into the destruct callback actually defer it
past an RCU grace period? quic_sock_destruct() is invoked from
sk_destruct() on the final sock_put() and is not itself an RCU callback,
so the comment's "Deferred ALPN free for RCU readers" assumption seems to
rely on a guarantee that is not configured on this protocol. Should this
patch also set sock_set_flag(sk, SOCK_RCU_FREE) in quic_init_sock(), or
alternatively take refcount_inc_not_zero() in the lookup helpers before
touching any fields of tmp?

>  	quic_sk_destruct(sk);
>  }
>  

[ ... ]
-- 
This is an AI-generated review.


