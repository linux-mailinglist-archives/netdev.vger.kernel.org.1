Return-Path: <netdev+bounces-305582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QUHKKcVUTWrwyQEAu9opvQ
	(envelope-from <netdev+bounces-305582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:34:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F5671F431
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:34:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cLqCAU1o;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305582-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305582-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D0F03015D71
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214903ACF17;
	Tue,  7 Jul 2026 19:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE23A960F
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:33:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452786; cv=none; b=muGnNQVImDprO5uz/zmxrCHF4Y4Pgn9Ry7VOk8Oa+JX+NNbuh4tvrTLW34VkY/9YfqliWInRzwfyqHfYlT3Y4bKGwjAhtSnrijleIw6so5wRKxy6OJlbZWa0LQoExbOsQ4ThX4Nfp40tKIxfJTS9bNkToOgKOxcT6amW0/9owuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452786; c=relaxed/simple;
	bh=yd2mvm2aUulGdQH3BWeU+jnaQyua0wu6/xxEnxPAbic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFGJTCecc4bdh939WcEm5j+7zIMnZRFchDrqKuuLp2YcYEXly7mrfrysedtRls60KCuD5zfLCHW0H698dSkXSVCZLoZmrJsPTkBwJOAHrvekbReYz7NIVDqV0Y6w4tckdJ0lVbYiWpubwubL6H7jNhu5ZweOZRQMmkBJ393MtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLqCAU1o; arc=none smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8efb708b1a0so41458536d6.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783452783; x=1784057583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bv2xBvquC1F5rWy3K5WDWw2YE3MQUKWYWOhGgD21Qos=;
        b=cLqCAU1o/W+6RafMgJoSZn04ehrr21mktbpzjMJ7tze6/0YjoJL1Bq1QKhlDrArdWp
         k1FVEttIpHG6q9jb+nMnbdImpTK50eB6pxR+xZxQtjJfoEMXEL7oVOR9kD9OX5RxHfyz
         EJYH0e1gdm8XVrl9UrdmGaf1vJJvzyLmi8cn6n0TGkirtxwxhUmsUk3lH4+BQk15la/Z
         fMmSxFRwRv7Ark2z99vxUIVDq4PvSBX/+WPnFE/5B+hVQ6nTPr6v1XPCAUWEbnuYH1hn
         5YdV3EF40+udbpXlE8OUhK72QMdSAI2OJNsqlWmUl1XRDg9B8URNNr2m/YcnVr5HGJSf
         fedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783452783; x=1784057583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bv2xBvquC1F5rWy3K5WDWw2YE3MQUKWYWOhGgD21Qos=;
        b=UnkSsrSYNoyRh6s5kaGOYBRIzgdZtZMCp5UE7L6sjCP5dAVUCLtdEH6o66y3QPpv1S
         whGHz5pX1bKyNWf53+BdCgIO6LjH+17+LOSvhUG6+nidpBgpj/GfajXTbbl4QwyJsx3c
         LVYviQZvaRdbcDeD7Y7T0NnZdr7KfXJkivyanSekg7mkEzz5fMlqLJwsodSDuCRrLCEN
         hg5QiRV6mYp1UptAmfxd3/nbjyixMKLnKs2YuWcqywpQ/uADJW8Knvbm1RW9RGsfONoa
         rr5c0Yr1LWNfBwTK/21wK3DpYZCF+0nfNZJje5rtqE+zDnbPe/OipbNpMWBW/Frf3SCF
         rVGQ==
X-Gm-Message-State: AOJu0YxH5rvldeJFsFnEHEYuUgA5p3B2JFBGwi0XC0ANuSpJbkyFK4LB
	hUNVs2e6mO3qZYgGhYtQbCWo0Jd2VZRnFHsNVYk7y26PR+ZeCVO5EBWy
X-Gm-Gg: AfdE7cn4E1OCBaa5m4D0/0zGjR+flgUxpoIoY1taR0MTLdRsrEPkoPAcMaITyZyWqJd
	PcyoZCWUjvDMsVF63jOhfDoWeru2Nj2S0LfEY+EnDQ/hIAfXirs8SQB22FOTFdzpWEtuMj5g40+
	IdeZGBQeMxG1rqQHo5bwd3UuvH0IQ31phom2lV3FKO5WywWQA4Usnfl7ZTVwOQ22nJLvYKcCX3u
	iMlb4nvKAqfNuTIRDgf1mLm2QMXYN9a/KGj0GEND7n4Slnrufv+wbVnb4jlb1TfK+9YnHohGG8m
	UJFgOz8PP+daJHPORyvHyQhkfaczlb6fQpvI8yPdLBp5Dfrhjuwhpa5PBbGYy6B5VmYMLrBg2Lk
	dLuTuUoXHJGaC7CWkMtuipuoP3BJ0YHe+gQjvtIOim1QGpJMRs5tqodcVelQd6+C5DNJOzKoui7
	prQsXM6eVVIjiVYjVzwaxkzF7hlh6hATqQ1iblwpS/5xIbSDNKo4mhHA2UcoW4Z0LYch0ajPGMK
	zT1OBqYWyIYhyJKoUtpgaPZ3yTziNSk
X-Received: by 2002:a05:6214:29c8:b0:8f0:db0e:1c28 with SMTP id 6a1803df08f44-8fcb4a06853mr84229066d6.41.1783452778600;
        Tue, 07 Jul 2026 12:32:58 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bab15sm167767906d6.43.2026.07.07.12.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:32:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 2/2] amt: make the head writable before rewriting the L2 header
Date: Tue,  7 Jul 2026 15:32:43 -0400
Message-ID: <20260707193243.3448201-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707193243.3448201-1-michael.bommarito@gmail.com>
References: <20260707193243.3448201-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305582-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8F5671F431

amt_multicast_data_handler(), amt_membership_query_handler() and
amt_update_handler() rewrite the ethernet header of the decapsulated
skb in place (eth->h_proto, eth->h_dest and, for the query, also
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
 drivers/net/amt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 1d6b2de4b73cc..f7375e40bc8f2 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2330,6 +2330,12 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	skb_pull(skb, sizeof(*eth));
 
+	/* The L2 header is rewritten below; make the head private first so a
+	 * cloned skb (for example one taken by a packet tap) is not modified.
+	 */
+	if (skb_cow_head(skb, 0))
+		return true;
+
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 	iph = ip_hdr(skb);
@@ -2413,6 +2419,11 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	eth = eth_hdr(skb);
 	/* Snapshot the outer source MAC before a later pull can free it. */
 	ether_addr_copy(h_source, oeth->h_source);
+	/* The L2 header is rewritten below; make the head private first so a
+	 * cloned skb (for example one taken by a packet tap) is not modified.
+	 */
+	if (skb_cow_head(skb, 0))
+		return true;
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
@@ -2538,6 +2549,12 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
+	/* The L2 header is rewritten below; make the head private first so a
+	 * cloned skb (for example one taken by a packet tap) is not modified.
+	 */
+	if (skb_cow_head(skb, 0))
+		return true;
+
 	iph = ip_hdr(skb);
 	if (iph->version == 4) {
 		if (ip_mc_check_igmp(skb)) {
-- 
2.53.0


