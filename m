Return-Path: <netdev+bounces-296330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W2rvDdv4JWoVQAIAu9opvQ
	(envelope-from <netdev+bounces-296330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 01:03:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D6A651DD6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 01:03:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c9Gx+XcF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296330-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296330-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6BFD300A742
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 23:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F66D311954;
	Sun,  7 Jun 2026 23:03:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E124728F
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 23:03:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780873432; cv=none; b=qXZ3IAQ0O0c9hn844y6wnaPxy3ucqRaKxz0j/QJoDKSsF38KDix1jWshYS0MwruMdrdMlRkFok5LQvrG1BnvHMQnf6QshFEmdM5/xZPVkEdjg9W+yMhG1mOtwUkuZRhcd9u2aNv3WVMWwUDbmXOOAJHqZXSVsxzMolYCYR+OLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780873432; c=relaxed/simple;
	bh=m0wEFQkMtZz5SQCdbiHDqtirXnWw0Igz/FyAP/Tc19g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOIBcfS/MRLUndiXrGTgN9GobqlSwjKNoC07thTDgmsMHfzSbtJ9wslvmhQTxZrb5Ju7cB77Ej/WRieZ4OFbeKr1nxDrBZsLCCf66tzKURu6Q6wytBXm+wjHWEqdOn1tTnq9Opxtmsmlnvp4bnyNe5QtMtYdoHFfB08KOhUKjCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9Gx+XcF; arc=none smtp.client-ip=209.85.219.46
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccce57762cso39433796d6.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780873430; x=1781478230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pbu6f2Dp8cbPNFNRei+jWtIPkS20L3y3tFhoh3dhkkw=;
        b=c9Gx+XcFuLCjEDc9ibdVPA3d587iNLPlt1OeuQmxZttxpUaST/2vDnk0Liowdj4tv/
         BsWtQJguOCcdTF22QymcmaBe2wRXr3jTAvdzt7veufQGn4HiAhdNvczmj/2waZRv7vhN
         XXtgTZr3VeADtNSh7Y3D9iRtljd4MU8ArYcKJRkLCD55bzNagxBQnQDtbEe/tXtSNd/z
         YwtdI05W7j/MY5goIjq7Ul/Or6HAxtlcje9dOVciP3WC9eF3fpGf12n6rj8Vj2hHy0id
         4XxYwmXJ2hBmaifKrC2+Cp8TB8iuDbe+uFL38adeByqy9aLB4SH3HvAenMCGx93V4YAl
         F5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780873430; x=1781478230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbu6f2Dp8cbPNFNRei+jWtIPkS20L3y3tFhoh3dhkkw=;
        b=bQ0WHM2Ly1dh1W3EF2Q2y0y2fj0NxpPum4T/y9K7qSo7aIbZEMH5n2beaB+/+Aa5+N
         MqCthpb58AYAOabIvk6hnJ6cVqOKcQPbDQo78SxP6wgZ4shS4L+nX2mps/vnEuiWkd4R
         VifiTHmtH6qYh7JUH2hDh152GtT5n3s9d+0qWjN3Gb7utYWG4v6tungN++2LTJPYT9cO
         lNM1e1DQv6MrMbmSF5e3HHyGIe3wLU2z7uyQMjdAfxZt3wC8HG9huN3CeGNLb5vIvTuV
         8XtBSUYtRG1H7nIxdlUi1xkEsx/xC3EfZJxouonQKv8rjSwoyejzwWX7Fa4D8wcp10Xn
         qwfA==
X-Gm-Message-State: AOJu0Yzdvg8CY0mfRuCwr5pPA+vjuIWzirLsReulUA6tkvNmymPkjUXW
	DGFV+/n6YXHgUh+LLVwqVX866xFr5ME5mfl+B/8lUvX5E1kEIetB3ADzSTPYOqHH
X-Gm-Gg: Acq92OE0LvGpJue1vzXfr4HUptbcH6mBfGeq/KYwhaD6VP2DS1qv8YFLsAHkRIAat3H
	HkKF4j3AYQGfOuQZiKYK3byhMzBjUkvM9LXRjWtXhE200Fxt7Ak5D8cbBxXA/IIRy8Od0FDq6oj
	55BxkZxyAtIYU0G7ojNQfDRHH532//8Yv70L8FDDgalamz7h6BqXVjaXyfA/iEHCRCnyJN+d+rj
	ES0NkJ9zZnYwDOhh08hvbrH/MIn61CboRch4UCLx++2GyGRkY7br5yfdSo6c8gulkjZ/OlyynOk
	seq9+mEF0dOpq1ql+A+O48EdOAMhc1oGLhRqgqabIcrBc2+/HcVk4zg3+s5vreVQg7I+OK2evsH
	S0+ttDGZ0MXqVnV6WWxv3D/GtOgqrCCi7OOMR4SXUwGMMO3VsdsikxFwvY/HY6yQPgKCn5W31ku
	/zcki1TqI6aEwXKUaa3sV+43TNYLysVlVh+vJAg7SJp5iSjjGqfmT2n204iCBn9UN30Uqh8Bom+
	EePLsAiSj6s44LX/dzmSPVF4FEnQfD1vuNxoMGFrZ434qeIiXLBSjAC9bH/WAOpL+Sc773usoq6
X-Received: by 2002:a05:6214:2349:b0:8ac:b258:71d1 with SMTP id 6a1803df08f44-8cee5f9f71amr206612146d6.3.1780873430098;
        Sun, 07 Jun 2026 16:03:50 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2629cesm143921966d6.41.2026.06.07.16.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 16:03:49 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: validate embedded INIT chunk and address list lengths in cookie
Date: Sun,  7 Jun 2026 19:03:47 -0400
Message-ID: <75af23a89adf881a0895d511775e4770da367cbf.1780873427.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296330-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89D6A651DD6

sctp_unpack_cookie() only checked that the embedded INIT chunk length
did not exceed the remaining cookie payload, but did not ensure that the
INIT chunk is large enough to contain a complete INIT header.

A malformed COOKIE_ECHO can therefore carry a truncated INIT chunk whose
length field is smaller than sizeof(struct sctp_init_chunk).  Later,
sctp_process_init() accesses INIT parameters unconditionally, which may
lead to out-of-bounds reads.

In addition, raw_addr_list_len is not fully validated against the
remaining cookie payload. When cookie authentication is disabled, an
attacker can supply an oversized raw_addr_list_len and cause
sctp_raw_to_bind_addrs() to read beyond the end of the cookie. The
address parser also lacks sufficient bounds checks for parameter headers
and lengths, allowing malformed address parameters to trigger
out-of-bounds reads.

Fix this by:

- requiring the embedded INIT chunk length to be at least sizeof(struct
  sctp_init_chunk);
- validating that the INIT chunk and raw address list together fit
  within the cookie payload;
- verifying sufficient data exists for each address parameter header and
  payload before parsing it.

Note that sctp_verify_init() must be called after sctp_unpack_cookie()
and before sctp_process_init() when cookie authentication is disabled.
This will be addressed in a separate patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/bind_addr.c     | 11 ++++++++++-
 net/sctp/sm_make_chunk.c |  9 +++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/sctp/bind_addr.c b/net/sctp/bind_addr.c
index 75e3e61d494e..31737f144c7f 100644
--- a/net/sctp/bind_addr.c
+++ b/net/sctp/bind_addr.c
@@ -275,6 +275,16 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp, __u8 *raw_addr_list,
 		param = (struct sctp_paramhdr *)raw_addr_list;
 		rawaddr = (union sctp_addr_param *)raw_addr_list;
 
+		if (addrs_len < sizeof(*param)) {
+			retval = -EINVAL;
+			goto out_err;
+		}
+		len = ntohs(param->length);
+		if (addrs_len < len) {
+			retval = -EINVAL;
+			goto out_err;
+		}
+
 		af = sctp_get_af_specific(param_type2af(param->type));
 		if (unlikely(!af) ||
 		    !af->from_addr_param(&addr, rawaddr, htons(port), 0)) {
@@ -291,7 +301,6 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp, __u8 *raw_addr_list,
 			goto out_err;
 
 next:
-		len = ntohs(param->length);
 		addrs_len -= len;
 		raw_addr_list += len;
 	}
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 85264862fb6b..1741a9f33d8c 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1731,8 +1731,8 @@ struct sctp_association *sctp_unpack_cookie(
 	struct sk_buff *skb = chunk->skb;
 	struct sctp_cookie *bear_cookie;
 	struct sctp_chunkhdr *ch;
+	unsigned int len, chlen;
 	enum sctp_scope scope;
-	unsigned int len;
 	ktime_t kt;
 
 	/* Header size is static data prior to the actual cookie, including
@@ -1761,7 +1761,12 @@ struct sctp_association *sctp_unpack_cookie(
 	bear_cookie = &cookie->c;
 
 	ch = (struct sctp_chunkhdr *)(bear_cookie + 1);
-	if (ntohs(ch->length) > len - fixed_size)
+	chlen = ntohs(ch->length);
+	if (chlen < sizeof(struct sctp_init_chunk))
+		goto malformed;
+	if (chlen > len - fixed_size)
+		goto malformed;
+	if (bear_cookie->raw_addr_list_len > len - fixed_size - chlen)
 		goto malformed;
 
 	/* Verify the cookie's MAC, if cookie authentication is enabled. */
-- 
2.47.1


