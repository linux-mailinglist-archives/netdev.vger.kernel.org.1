Return-Path: <netdev+bounces-263077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKNLICGdpmlqRwAAu9opvQ
	(envelope-from <netdev+bounces-263077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:34:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 068E51EADB8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 09:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 015633023066
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C481538552F;
	Tue,  3 Mar 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTkOf/On"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AE38756E
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526853; cv=none; b=PKN9tcUxFG1ihTYP7iQdGLic7p47dYsgW2QCwFSnqjiGuJd5z9TcJteVgX4+W9YYiKkKuISlcZg0Sp7Fly7QkrIyu6uNF1QjHS23eqJ6CEAXGY3rKNkI9OOhJLNB/A0n/uy7LIuAw4nJhYN4zJFVeQNcYi5DOUuibrRsIQzMjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526853; c=relaxed/simple;
	bh=28/2SD0zKnxVxONz58kqvH8l9p8IW3PnbEu16NUlN4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHNRerxhLaDFJr5Xw/yk00q9yaRGX8cCpeaLYglwGaF2ZbILShf1IvqXAFWFUBnc6Z8rsECaFEBTSTzPkmUPa7vHtjBdsP5HAW4kLKohMn+dbMx7uHi+rfK3JfzkORHWk1hjMmO2o7sS1zwOn6k65z9gEJLRsvn9vv4JhdmETiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTkOf/On; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772526851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGGteXDhadojqghSFLLImSNgVRBGSngpOjwddhC7BTg=;
	b=MTkOf/OnyUQCUFfQWjfoVyUKUI/wbAQeTJo/I3S7PHHimhLiPvgv1A1SvV8AuzKDHXtBUP
	MEwXbcLJzhjFNFR5Zyvaz8suxPskhGrBUzK1i1cOTjrnco+6p2zpkH2M5mTBM3B3arx6ea
	uUkqrKq9z8kufCiaE6n4pTc4N0gzjEY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-UHN8XmceNhG8w14WNhQxuw-1; Tue,
 03 Mar 2026 03:34:08 -0500
X-MC-Unique: UHN8XmceNhG8w14WNhQxuw-1
X-Mimecast-MFC-AGG-ID: UHN8XmceNhG8w14WNhQxuw_1772526844
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63C481956048;
	Tue,  3 Mar 2026 08:34:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6964219560A2;
	Tue,  3 Mar 2026 08:33:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: lucien.xin@gmail.com
Cc: hepengtao@xiaomi.com,
	kuba@kernel.org,
	jlayton@kernel.org,
	metze@samba.org,
	davem@davemloft.net,
	kernel-tls-handshake@lists.linux.dev,
	horms@kernel.org,
	hare@suse.de,
	aahringo@redhat.com,
	tfanelli@redhat.com,
	mail@johnericson.me,
	andrew.gospodarek@broadcom.com,
	linkinjeon@kernel.org,
	dhowells@redhat.com,
	matttbe@kernel.org,
	xiyou.wangcong@gmail.com,
	dreibh@simula.no,
	jbaron@akamai.com,
	quic@lists.linux.dev,
	pc@manguebit.com,
	marc@fiuczynski.com,
	edumazet@google.com,
	pabeni@redhat.com,
	alibuda@linux.alibaba.com,
	steved@redhat.com,
	illiliti@protonmail.com,
	tom@talpey.com,
	marcelo.leitner@gmail.com,
	sd@queasysnail.net,
	linux-cifs@vger.kernel.org,
	netdev@vger.kernel.org,
	mbuhl@openbsd.org,
	smfrench@gmail.com,
	chuck.lever@oracle.com,
	daniel@haxx.se
Subject: Re: [net-next,v10,15/15] quic: add packet parser base
Date: Tue,  3 Mar 2026 09:33:51 +0100
Message-ID: <20260303083351.35558-1-pabeni@redhat.com>
In-Reply-To: <08a63705058aff77dd54fb388870f0bca6036c95.1771986861.git.lucien.xin@gmail.com>
References: <08a63705058aff77dd54fb388870f0bca6036c95.1771986861.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 068E51EADB8
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[xiaomi.com,kernel.org,samba.org,davemloft.net,lists.linux.dev,suse.de,redhat.com,johnericson.me,broadcom.com,gmail.com,simula.no,akamai.com,manguebit.com,fiuczynski.com,google.com,linux.alibaba.com,protonmail.com,talpey.com,queasysnail.net,vger.kernel.org,openbsd.org,oracle.com,haxx.se];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263077-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
quic: add packet parser base

This patch uses 'quic_packet' to handle packing of QUIC packets on the
receive (RX) path. It introduces mechanisms to parse the ALPN from
client Initial packets to determine the correct listener socket.
Received packets are then routed and processed accordingly.

> diff --git a/net/quic/packet.c b/net/quic/packet.c
> index a56edc745bb1..a23ce99a6656 100644
> --- a/net/quic/packet.c
> +++ b/net/quic/packet.c

[ ... ]

> +/* Extract the Destination Connection ID (DCID) from a QUIC Long header packet. */
> +int quic_packet_get_dcid(struct quic_conn_id *dcid, struct sk_buff *skb)
> +{
> +	u32 plen = skb->len;
> +	u8 *p = skb->data;
> +	u64 len;
> +
> +	if (plen < QUIC_HLEN + QUIC_VERSION_LEN)
> +		return -EINVAL;
> +	plen -= (QUIC_HLEN + QUIC_VERSION_LEN);
> +	p += (QUIC_HLEN + QUIC_VERSION_LEN);
> +
> +	if (!quic_get_int(&p, &plen, &len, 1) ||
> +	    len > plen || len > QUIC_CONN_ID_MAX_LEN)
> +		return -EINVAL;
> +	quic_conn_id_update(dcid, p, len);
> +	return 0;
> +}

This parsing logic looks nearly identical to what's already in
quic_packet_get_version_and_connid().  Both skip QUIC_HLEN +
QUIC_VERSION_LEN, read the length byte, validate against
QUIC_CONN_ID_MAX_LEN, and call quic_conn_id_update().

Could quic_packet_get_dcid() call quic_packet_get_version_and_connid()
with dummy parameters, or could both share a helper to extract just the
DCID portion?

> diff --git a/net/quic/path.c b/net/quic/path.c
> index 9414c4f813c5..655f38af4107 100644
> --- a/net/quic/path.c
> +++ b/net/quic/path.c
> @@ -17,6 +17,8 @@
>  #include "family.h"
>  #include "path.h"
>
> +extern int quic_packet_rcv(struct sock *sk, struct sk_buff *skb, u8 err);

Could this include packet.h instead? The canonical declaration already
exists in packet.h (after this patch). Using 'extern' here creates a
duplicate signature.

If the signature in packet.h changes later, this extern could silently
become stale depending on calling conventions. Since packet.h has no
include directives and wouldn't create a circular dependency, including
it would keep the declaration in sync.

> +
>  static int quic_udp_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	memset(skb->cb, 0, sizeof(skb->cb));


