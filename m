Return-Path: <netdev+bounces-270400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCPGBAz1wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:08:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA02EE122
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E74E7300613B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376836EA82;
	Mon, 23 Mar 2026 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWFwbUKZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0136D500
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253297; cv=none; b=H0HBEBCumeSUwNwN0ltQe/tnBgxMmmH7RwdYqwZywy9bA34VuLIAUXGL79BqW9RadLyXb/tPsgHdvbhMvqo+Glb1OTV9j3oFl+gWvZBmXO39M/ofGAFgZXQaCQo0eC7IWX/7iDkjulrjcX8FqyBsI2Zu+MS3PRKme8y10XQF4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253297; c=relaxed/simple;
	bh=5Zy0XUwX6iIi5GwhjGoPNY3Vg2jY5I/S4eF+tYiFOFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+0SqDKiMPGc3czuqcJLzpz1hnYn455c5oQuH/uTCkkUTn9W4aqh1ugypipLoN5lmipwT4GGU+E41u1TeJiAo7mMFC3Gcsi7o6cSHOYLV24qg8edrk9yuJB5JERwIAq6Ml8uQ+6JCGUQ1C/361UFfYr7ULdAze/fTIo+DLIKq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWFwbUKZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c73ba417c6eso1500705a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253295; x=1774858095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/oxuEK0aKiR5BZiJwQM9QbFzk9FiV34b8im9vtCPOQo=;
        b=XWFwbUKZWo7I3MG3tqXs8n0H4sRxFopjfXPGPFNcbMZKUu9ob+LOAD7gOq5j2nuA/X
         SZqmeBdfuZgAcfVUtUUx3/m+RIZ3mAtmrgx4crJLSj1uCP4QmtmMbXOp4hyckRkY2XyF
         rsYS8KX8Vv6mtlMvf90hGC1PDsmJurpXe7iSnSKf1+aGPo2vrX3JEO+v/zolES91AWm6
         +jMGK3AbIFCydspdkPFlCWUMwEXuKqLvdQOYRewVHX91HbrGDrGEiuj4W+dPuQHr6wPv
         z9poGwhtAdUGB/ACXoZV3A3EgwtvM+TsqS04Ia+US+OepwuSqWQ+W9WIUilDuKk5ARUY
         XoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253295; x=1774858095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oxuEK0aKiR5BZiJwQM9QbFzk9FiV34b8im9vtCPOQo=;
        b=qaup2yLVLB2clxJ2Bh4zimX44nhElLv48vFedegb+m4eH45vPopnxUD8YaiECNTx1V
         LPXhOKkRdVA/4xbgWKqJpOJD7bL/SgEGUj3GO0yDku00cwV7ICqBOjmJMOlU5lUJa5oQ
         oo8Ho7ANkmRXAjDeaXDHeIgC6+PT5M07yydAMvmxpzJiDXA7d/uzWTPEMXa7YYAGKzel
         eyYwBYGTumvv3/AemonUcuqCLtGq/xbHQ1oyRvKTFMyJBk6W22x7Ef7SRsqBmKgpTJuJ
         jFRh5y3TFGfX3/yCCbVmf52yKl3LcOiVGRtf2cx/3mKKVCY7ZxxPjO58g+loDVB4jVxr
         cSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq7RZ/wOdZeF1ZRFlWhkoFoG+gTsJrqCrR8HPZUx1+0HOXK2QMZWhT4nn8lPZNNB4x15q9uWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZPQUfmEu03qU8gIcQ0mBZBSIiNHpAwvomWKOCWq1wad3ouS2
	sGazr/t4V6n6uYhT/ornnGEumDIEmMkfuGCr2ABEpK7wgtvvIuTowr+/
X-Gm-Gg: ATEYQzz+TTlGMuiDVr7eP0us+PHM++I6sDZtlcJflsvp6cH5vyQ3o/dYLZEUQ0Ol9fq
	1m5E5GjOEyTvCtcsYXp2Ps5fTg71H61YbL73yZZHx+gOyhRl3LUi9aNpCUkJt0TA52Fv7SYwm+2
	TmRKM/bh0+gvJChckSdTpCRU6bK6Cn0wyGb+fz42TQa/dUW34134O0t05WNAku3AL+WrmjJSmhM
	Zy65pYjDKP5+s2bN7ee5hd5ishSzYJCideOKrdkWVimJGvjX+jMKzpp+w+uMkNz1kTc52yy44Qw
	9VZzYCDuEGBhtXU/HEr7AD+ADKkrDd8+OvyYgVCR66eQuSI+uGXH+JTI/vCIQaGKEGvuTJjjGpP
	S4MSO23Fx4RhoHFLH5vMYPKAPCfXL6bQBnXNIQh0LXPJmV0mBzAE9YPDLYlkIhwo6Cs+hr1lclp
	aRDRZd9NrYcYp6xSLzrl1CFV8E/QnSDG4kGl1wteoO1SUkBqK0siQJszBLnEZHb5jeZNjhxPRQ9
	kVDwQwk9ug=
X-Received: by 2002:a17:903:1a0f:b0:2b0:4f82:74b1 with SMTP id d9443c01a7336-2b0827c165emr102975785ad.44.1774253294945;
        Mon, 23 Mar 2026 01:08:14 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083549f63sm99706195ad.30.2026.03.23.01.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:08:14 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp
Date: Mon, 23 Mar 2026 16:07:29 +0800
Message-ID: <20260323080727.2932866-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nwl.cc,kernel.org,vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-270400-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5CA02EE122
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

process_sdp() declares union nf_inet_addr rtp_addr on the stack and
passes it to the nf_nat_sip sdp_session hook after walking the SDP
media descriptions. However rtp_addr is only initialized inside the
media loop when a recognized media type with a non-zero port is found.

If the SDP body contains no m= lines, only inactive media sections
(m=audio 0 ...) or only unrecognized media types, rtp_addr is never
assigned. Despite that, the function still calls hooks->sdp_session()
with &rtp_addr, causing nf_nat_sdp_session() to format the stale stack
value as an IP address and rewrite the SDP session owner and connection
lines with it.

With CONFIG_INIT_STACK_ALL_ZERO (default on most distributions) this
results in the session-level o= and c= addresses being rewritten to
0.0.0.0 for inactive SDP sessions. Without stack auto-init the
rewritten address is whatever happened to be on the stack.

Fix this by pre-initializing rtp_addr from the session-level connection
address (caddr) when available, and tracking via a have_rtp_addr flag
whether any valid address was established. Skip the sdp_session hook
entirely when no valid address exists.

Fixes: 4ab9e64e5e3c ("[NETFILTER]: nf_nat_sip: split up SDP mangling")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/netfilter/nf_conntrack_sip.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 4ab5ef71d96db..17af0ff4ea7ab 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1040,6 +1040,7 @@ static int process_sdp(struct sk_buff *skb, unsigned int protoff,
 	unsigned int port;
 	const struct sdp_media_type *t;
 	int ret = NF_ACCEPT;
+	bool have_rtp_addr = false;
 
 	hooks = rcu_dereference(nf_nat_sip_hooks);
 
@@ -1056,8 +1057,11 @@ static int process_sdp(struct sk_buff *skb, unsigned int protoff,
 	caddr_len = 0;
 	if (ct_sip_parse_sdp_addr(ct, *dptr, sdpoff, *datalen,
 				  SDP_HDR_CONNECTION, SDP_HDR_MEDIA,
-				  &matchoff, &matchlen, &caddr) > 0)
+				  &matchoff, &matchlen, &caddr) > 0) {
 		caddr_len = matchlen;
+		memcpy(&rtp_addr, &caddr, sizeof(rtp_addr));
+		have_rtp_addr = true;
+	}
 
 	mediaoff = sdpoff;
 	for (i = 0; i < ARRAY_SIZE(sdp_media_types); ) {
@@ -1091,9 +1095,11 @@ static int process_sdp(struct sk_buff *skb, unsigned int protoff,
 					  &matchoff, &matchlen, &maddr) > 0) {
 			maddr_len = matchlen;
 			memcpy(&rtp_addr, &maddr, sizeof(rtp_addr));
-		} else if (caddr_len)
+			have_rtp_addr = true;
+		} else if (caddr_len) {
 			memcpy(&rtp_addr, &caddr, sizeof(rtp_addr));
-		else {
+			have_rtp_addr = true;
+		} else {
 			nf_ct_helper_log(skb, ct, "cannot parse SDP message");
 			return NF_DROP;
 		}
@@ -1125,7 +1131,7 @@ static int process_sdp(struct sk_buff *skb, unsigned int protoff,
 
 	/* Update session connection and owner addresses */
 	hooks = rcu_dereference(nf_nat_sip_hooks);
-	if (hooks && ct->status & IPS_NAT_MASK)
+	if (hooks && ct->status & IPS_NAT_MASK && have_rtp_addr)
 		ret = hooks->sdp_session(skb, protoff, dataoff,
 					 dptr, datalen, sdpoff,
 					 &rtp_addr);
-- 
2.43.0


