Return-Path: <netdev+bounces-306872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kklaLURfUmrLOwMAu9opvQ
	(envelope-from <netdev+bounces-306872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:20:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05207741F1B
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:20:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dsyq3Cga;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306872-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306872-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EA8C3036398
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A72D7DF1;
	Sat, 11 Jul 2026 15:19:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1807381EB4
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:19:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783185; cv=none; b=OBqS/6NLa5VM3kka46QFVbkY/DD7wGTC63nl5llAoa8Vl6nqqcXqJ99J9yEWAGskVQ/cKO0/4DcWVx6kRh+PWl2sYckmotvEeEcJnLi4f38S47bF7o7sFFQPTM2Fat1yw3nTBhBBPpmq0PQ668o//pb4Uz3ex15xoIMjJ3kamec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783185; c=relaxed/simple;
	bh=LQIM3sBGvUqM9efCOb/AIjOUmu6tNvZEUwHUeE2z90I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhN7HcoBPAahu6VDePy5kJ+GuPx8GwgPJyuZMd92pRSf9CaWdsEpGw54tdnxciLcq0qBslpS0BBNwBcCUuyUwSb41EGSTtE3MyouMGVMRUoco1z5wSUoH/MqeOPYq3lYo7qDORvDDZnvP/JLMkiS8vHKIy9YgskK7CXDosTQEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsyq3Cga; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-922ff615c14so146826385a.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783783183; x=1784387983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BG2xjmjBbV5AQK/a/AQpxcpCL6NEh8yOHX50gnWQjos=;
        b=dsyq3Cga9QBG6oV17iVpysC04tH+/KvLCcOnz45NsPkoGMV3inV3L7FVledU/uxZ1N
         rtphRWj8QFYGGxfAbk0WPd3i4kNb0NDXrfgx/eFjw7qCBEJiQ1YlaVFd158Omn+3j6ep
         KDmnGPFpUjqw2tLCCzJ/ZgMgs/trhxYIFuWfvR8+K9QC6327iHNGGoCXX/o/SCIwIJzm
         Dj8gNLRrXkQwmnqfsYefBayJLzK3HfzMH07z8o/HHmUu9MImyZJd4edfOBdklNXkbgSs
         AyrzPp3LKEqlqfCD3zC7wc6oODaVsoOBq6ZV1eI5m0K0Da2RcSwVtTuKf3BMvsNA4iQx
         keEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783183; x=1784387983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BG2xjmjBbV5AQK/a/AQpxcpCL6NEh8yOHX50gnWQjos=;
        b=sUhEq2T7P6i5kXqCmRtaCzqkxRfX6eWXjfbRARQnQ+u26bHxjHOvHO5P4A7LSdOzme
         mh9aVBWU4ZRs/1qrmaCPzSxbXog+Fk0W2uOsk0FEXzbS/bxYVmPZ+Hw3XDHmfPg8cDqN
         PjpB1YDR4MxsX7H68qQB5GddbJcLnU5z69SON1gk59zkcXWj3DkbidkGt0ZItqX4xEeo
         L44PlxbpNyxs1NqhjJEKPndUneSJMDjkP4z0hFrgTeCiH1typcs56tez19PlDQnQip+J
         pQxW3/VDH1frppVDUGv5ueWEPZ9/XnzYlL6wh5qd7ugbyM4rgd1wcfe8TrTbEidClcFG
         9RLA==
X-Gm-Message-State: AOJu0Yyai+oVbv/qYXdaZccToOvpL7KOTSsXFkBsBFjQsZnPxX3ApCY5
	aTuR6PspdN2q0wg8FlALQgHIOlu9/AyNFQrJeSPD1S9gQ3rqka3+AJ7epcSQ8K8bs7k=
X-Gm-Gg: AfdE7ckIIsqrWoGdIh3opS9F3EVbqXik72eOSJbbo5Y5zfauR/SgfQxvWGG2kDGR9gA
	goaWy69l68NEy1/syIHwxKanVfhj77pXnsArcUYcanJdXnc6e+9qwxkbFmxgERf5zGg1O0hH/lr
	efpTf7gXbzSdfwz/vDBcL7uql645vRNjsrvJle7FEfvs9nK6pCmdxo4QiZ4PVbqVC9I9wo3r7wI
	DRJrRcQKb3nK78kSl0Jow82XOZsOerrGUqqz6YKYdEcbbH8eKwSNrvq9n/goPfRFSxeTsTT4JTA
	aHeN0b0AvwJThAT+6KViDsG2evhoz1PzIR29uSNX6mKXM12nss3WLshGbabs7vLGwOlBACwWXYo
	97sLOIKXbNQIxEi/2XSaAK5PFEL1VNRLkBIgw+FF/yZHXJhrFJlgKCk7WqL+JhhwgnOd4jQT9R3
	TiY6+L2rqEWzPnm/gN4gJv+uQX6r2H43PlrkIQXdRN3oDOs72D9tOxvQhRBU95LWYW8MAUdwz0h
	WM5FU6heA==
X-Received: by 2002:a05:620a:2995:b0:92e:c118:18b8 with SMTP id af79cd13be357-92ef2d01681mr351641285a.87.1783783182650;
        Sat, 11 Jul 2026 08:19:42 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a082sm467704685a.7.2026.07.11.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:19:41 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 2/2] amt: make the head writable before rewriting the L2 header
Date: Sat, 11 Jul 2026 11:19:34 -0400
Message-ID: <20260711151934.2955226-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711151934.2955226-1-michael.bommarito@gmail.com>
References: <20260711151934.2955226-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306872-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05207741F1B

amt_multicast_data_handler(), amt_membership_query_handler() and
amt_update_handler() rewrite the ethernet header of the decapsulated skb
in place (eth->h_proto, eth->h_dest and, for the query, also
eth->h_source) before handing it up the stack.  The skb head may be
shared, for example when a packet tap has cloned it on the underlay
interface, so writing through it corrupts the other reader's copy.

Call skb_cow_head() before the rewrite so the head is private.  It is
placed before the pointers into the head are (re-)derived, so a
reallocation caused by the copy is picked up by those derivations.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/amt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 35e77af76bd9d..b733309b866ff 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2320,6 +2320,9 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	skb_pull(skb, sizeof(*eth));
 
+	if (skb_cow_head(skb, 0))
+		return true;
+
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 	iph = ip_hdr(skb);
@@ -2396,6 +2399,8 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	skb_reset_network_header(skb);
 	eth = eth_hdr(skb);
 	ether_addr_copy(h_source, oeth->h_source);
+	if (skb_cow_head(skb, 0))
+		return true;
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
@@ -2521,6 +2526,9 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
+	if (skb_cow_head(skb, 0))
+		return true;
+
 	iph = ip_hdr(skb);
 	if (iph->version == 4) {
 		if (ip_mc_check_igmp(skb)) {
-- 
2.53.0


