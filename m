Return-Path: <netdev+bounces-301803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eNd8GvFfPGrPnQgAu9opvQ
	(envelope-from <netdev+bounces-301803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:53:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27B6C1D4A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:53:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LUze095b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301803-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301803-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13623024A53
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9A3B52F4;
	Wed, 24 Jun 2026 22:53:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4373264FD
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:53:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341596; cv=none; b=eKfjfZDbTWAeFAroKtMtCtBwZz6tSmGx6KB2GTi0G597HZYLtCojPPQqEQSmGI6jrPuml8WcLmV6WEMX4FHdmntVmRHcVnmkB+EG3/jVu1lDhEsRHNxQXjh2Z3poyY/Blam6TsIWtwhaLGlZ/pFoO9kqJzGYj+d+55jXOZPu/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341596; c=relaxed/simple;
	bh=imRuHVBhKfABF7GDG7+dYgzzSoSRS/FeqP+1jjPolUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NW5iZv/mGBj5TEkYsbz3eXDY/nFQqApCMPBooQIcPYxCyGjjuXhkyvh/hUsjrNIuKj1+DFSvrv03Qg+yF2kGrcMSR4RbdPQde3RSLqWRy/b71JCqyQJ4oB2vP+QU6NGP9CoU+D3Hbb2gz/wgiVgybRceTIFtkRzMmzAFF8RcFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUze095b; arc=none smtp.client-ip=209.85.219.54
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8dcd895a4c0so17165496d6.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782341594; x=1782946394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia6bejGY2180aBdl76NYMpgDPjwVDmZWAHJ4Wp5NX0I=;
        b=LUze095bvJCYaHv1Edi32G/Qp08NVta8Kb/Ss/VLCCq5fGV05s4m4myvognvpeN4Ns
         t5A41U3Hy6Z+QONFQWNw8k9yWMg+UtnYtJg66LMrlCIeXlLJ69rnVIWiyQ2Cb8Vks2NL
         JX6KSSGSbAKwrLqVPruttmILsxXHui16/TSqU7X5aSjCS1Tno11fQGbZZOkt5YE+HBr3
         dlJzt8rk9gTAe+ZQ3gK9V5WjRp+XikqP+tXf0zU6xfhVFmvsdiLsWWfeL/ClwIDBM25e
         wLToMhnRyAxUSA8sGwyFNd5QIf6Mx1eAB8WyH2kRb934pRjM2eIjna42ZsojqPE9oUlG
         RWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782341594; x=1782946394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia6bejGY2180aBdl76NYMpgDPjwVDmZWAHJ4Wp5NX0I=;
        b=p7Ad8qD6KnKYBvfyUVJwjTj96hyGdHFc0T16zySj6duWbQ3Yl3JG4xdZGKRaip0+0N
         SLBXF1kcKRRoCNMkigTZtGO4SmmeYlo39zrGWku2kqkkecaHAnzi7mep5bC+h5/jBPvy
         phnk7b0eCvbsatiEpe7hcvhf2qRl8ePgm7iXYyQkAQ9r1iLMBPbRdihA7fgBkq9gxppO
         5qG5XRoKbPopvXZWKhweMU+4LHM2eqPXGxIbHImN0Fy4JqjyWkOwKRFn1guFRhsVZfff
         HDDOulxlFvbZZLgalpo8nvcqyBRYcydy8hyFLdeFKGWY/c1aZbd2PinLHhAvEr/SyDQT
         J2gQ==
X-Gm-Message-State: AOJu0YzxyBo3ucbXRG2UlMlagHkO79PijKiR15Bt7G7wVKO3Y1x46+rY
	0urGQTLm1GNHK9IHJU0kfRRKYhkcQlNtjfLWwFFCVVH92eO8odp1zIie1HiDCg==
X-Gm-Gg: AfdE7cm5QPZQ5Mh//dx9pt2Gtvrqj2LvN4fOq0wF8OHO6XqFLe/oCEgEZs39MfPJVLK
	lMnbYjTGIC260XvF8vq99nsPJakzyrriV4YYsmalvFP6wogZVVp1m+mcG2U/zoQFNdYquMCT0Pp
	FeC+ug0P9swyJw4RcStuQLhvbi3+vBGs/chZaj1nzuPMq7QE6aKNMh4dFq9/KbVgfq+SA+c7iy2
	eSa3Lo6RZQwBiSDh6M9VAqhFU2haZJi31BBqx97Xx+kJ8xKj2mARpxGgu8LXMisPVH5M1h2O6eb
	lEA58YyPDndvc76QMyix6C4sc0HP1AD0NTpD59iGJGntSVfcX9nfhcRq6BzPfUpcjbb/SesgNsi
	yRJ/RZ3x+UB6gS5bEx3oCovPmYKe88cFhF94uHUPTxHgxckFcZRAxKFNLI0O5MooK3gK/3kkyYu
	CMJnKJroUDYcp3uIHXcT9m41p/hA+tppYNuYFB8AamNPhSPvYNXC8TnNhd8sFlg8DfQaTewrtoi
	Nn6IBS/1K2AmlomU0GffCZsEob+Gavd7+WqNjitmyVSDtqNm6QAHwo=
X-Received: by 2002:a05:6214:4381:b0:8ce:aace:eaf7 with SMTP id 6a1803df08f44-8e6d6f62ad7mr2950566d6.39.1782341593853;
        Wed, 24 Jun 2026 15:53:13 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdf302sm171758536d6.30.2026.06.24.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:53:13 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net v3] sctp: add INIT verification after cookie unpacking
Date: Wed, 24 Jun 2026 18:53:12 -0400
Message-ID: <ebcbbac574815b0850f371b4bdb02f2e602b94d3.1782341592.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301803-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF27B6C1D4A

In SCTP handshake, the INIT chunk is initially processed by the server
and embedded into the cookie carried in INIT-ACK. The client then
returns this cookie via COOKIE-ECHO, where the server unpacks it and
reconstructs the original INIT chunk.

When cookie authentication is enabled, the cookie contents are protected
against tampering, so reusing the unpacked INIT without re-verification
is safe.

However, when cookie authentication is disabled, the reconstructed INIT
can no longer be trusted. In this case, the INIT must be explicitly
validated after unpacking to avoid processing potentially tampered data.

Add sctp_verify_init() checks after cookie unpacking in COOKIE-ECHO
processing paths (sctp_sf_do_5_1D_ce() and sctp_sf_do_5_2_4_dupcook())
when cookie_auth_enable is disabled. On failure, the new association is
freed and the packet is discarded.

Also tighten cookie validation in sctp_unpack_cookie() by verifying the
embedded chunk type is SCTP_CID_INIT before treating it as an INIT
chunk.

Finally, update sctp_verify_init() to validate parameter bounds using
the actual embedded INIT length instead of chunk->chunk_end, since the
INIT stored in COOKIE-ECHO may not span the entire chunk buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v2:
  - Because of sctp_abort_on_init_err() param change in patch 1/2,
    pass cid and not chunk.
  - Use SCTP_PAD4() around ntohs(peer_init->chunk_hdr.length) when
    checking param.v in sctp_verify_init() to make Sashiko happy.
v3:
  - Validate the embedded INIT chunk type in sctp_unpack_cookie(), as
    noted by Sashiko.
  - Discard the packet if embedded INIT chunk validation fails,
    consistent with malformed cookie handling.
---
 net/sctp/sm_make_chunk.c |  5 ++++-
 net/sctp/sm_statefuns.c  | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 41958b8e59fd..8adac9e0cd66 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1761,6 +1761,8 @@ struct sctp_association *sctp_unpack_cookie(
 	bear_cookie = &cookie->c;
 
 	ch = (struct sctp_chunkhdr *)(bear_cookie + 1);
+	if (ch->type != SCTP_CID_INIT)
+		goto malformed;
 	chlen = ntohs(ch->length);
 	if (chlen < sizeof(struct sctp_init_chunk))
 		goto malformed;
@@ -2298,7 +2300,8 @@ int sctp_verify_init(struct net *net, const struct sctp_endpoint *ep,
 	 * VIOLATION error.  We build the ERROR chunk here and let the normal
 	 * error handling code build and send the packet.
 	 */
-	if (param.v != (void *)chunk->chunk_end)
+	if (param.v != (void *)peer_init +
+		       SCTP_PAD4(ntohs(peer_init->chunk_hdr.length)))
 		return sctp_process_inv_paramlength(asoc, param.p, chunk, errp);
 
 	/* The only missing mandatory param possible today is
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 8e920cef0858..d23d935e128e 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -707,11 +707,12 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 					 struct sctp_cmd_seq *commands)
 {
 	struct sctp_ulpevent *ev, *ai_ev = NULL, *auth_ev = NULL;
+	struct sctp_chunk *err_chk_p = NULL;
 	struct sctp_association *new_asoc;
 	struct sctp_init_chunk *peer_init;
 	struct sctp_chunk *chunk = arg;
-	struct sctp_chunk *err_chk_p;
 	struct sctp_chunk *repl;
+	enum sctp_cid cid;
 	struct sock *sk;
 	int error = 0;
 
@@ -785,6 +786,19 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 		}
 	}
 
+	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
+	cid = peer_init->chunk_hdr.type;
+	if (!sctp_sk(sk)->cookie_auth_enable &&
+	    !sctp_verify_init(net, ep, asoc, cid, peer_init, chunk,
+			      &err_chk_p)) {
+		sctp_association_free(new_asoc);
+		if (err_chk_p)
+			sctp_chunk_free(err_chk_p);
+		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+	}
+	if (err_chk_p)
+		sctp_chunk_free(err_chk_p);
+
 	if (security_sctp_assoc_request(new_asoc, chunk->head_skb ?: chunk->skb)) {
 		sctp_association_free(new_asoc);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
@@ -798,7 +812,6 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	/* This is a brand-new association, so these are not yet side
 	 * effects--it is safe to run them here.
 	 */
-	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
 	if (!sctp_process_init(new_asoc, chunk,
 			       &chunk->subh.cookie_hdr->c.peer_addr,
 			       peer_init, GFP_ATOMIC))
@@ -2215,10 +2228,12 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 					void *arg,
 					struct sctp_cmd_seq *commands)
 {
+	struct sctp_chunk *err_chk_p = NULL;
 	struct sctp_association *new_asoc;
+	struct sctp_init_chunk *peer_init;
 	struct sctp_chunk *chunk = arg;
 	enum sctp_disposition retval;
-	struct sctp_chunk *err_chk_p;
+	enum sctp_cid cid;
 	int error = 0;
 	char action;
 
@@ -2287,6 +2302,21 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 	switch (action) {
 	case 'A': /* Association restart. */
 	case 'B': /* Collision case B. */
+		peer_init = (struct sctp_init_chunk *)
+				(chunk->subh.cookie_hdr + 1);
+		cid = peer_init->chunk_hdr.type;
+		if (!sctp_sk(ep->base.sk)->cookie_auth_enable &&
+		    !sctp_verify_init(net, ep, asoc, cid, peer_init, chunk,
+				      &err_chk_p)) {
+			sctp_association_free(new_asoc);
+			if (err_chk_p)
+				sctp_chunk_free(err_chk_p);
+			return sctp_sf_pdiscard(net, ep, asoc, type, arg,
+						commands);
+		}
+		if (err_chk_p)
+			sctp_chunk_free(err_chk_p);
+		fallthrough;
 	case 'D': /* Collision case D. */
 		/* Update socket peer label if first association. */
 		if (security_sctp_assoc_request((struct sctp_association *)asoc,
-- 
2.47.1


