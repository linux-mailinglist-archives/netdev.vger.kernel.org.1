Return-Path: <netdev+bounces-269927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOiQJ0lWvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:14:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 214512DBAC3
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A7D631151AA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6AD279DA6;
	Fri, 20 Mar 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="X5BvEpkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FA3148B4
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015755; cv=none; b=rL6Zu5ajKvucdgcCgjtkELdhgakp/WVXa/l4ZCPUAX8NNFDbEeMVDoeuZ69MsfrLW8Swli3uu4MjQwJ2q2gTVwHKp0/jh0ExAn7Uzy/zm7FAFctUho15c/epawfHhzfUU+XYXATMsepCCV6wBeqkYLpIvkgJcOTxWo0mjhP1+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015755; c=relaxed/simple;
	bh=dXfsihbB/0u17xAbJe/nwOIJEY3qa5b9DOczSyGYNmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rV05VE4P1yvh/3q/g3k6q02p3OJp9FDRfHy3MnhnZmhPT/vhw1jo7KiVzJNAiWjxuDkbJ+1kek7BINpu7GD9eK3S6lrxhklhn0FXMeGzlky2Yqu9H6WEZX56oO3qmktZBjFfBP362tTxvSf/QJxzNLPygJooMdu3T2Xn+N8h8cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=X5BvEpkQ; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so319074366b.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774015753; x=1774620553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GebID9Fz+svTro9iiiZ+sDepPKQe8Gm/XzKmqqFUaQw=;
        b=X5BvEpkQOaw4JNlVwqDEDnxFP9//s4w8EAtABPsAVzo5YZb37gF3r1ouTk/+wxnkU4
         gm5KRhz7C7m7zKj7YydI0fjlx2Vu9lEBMQkVZJ/en7F0Ikj2Omvl5T6GOryPb5cvTwIC
         63ukoMVtK29c0P4wVZdsUgQxckMKKwedyETairjrvIKXzI+Y6BgEcqQsA9uZ2BUsVALI
         2eojnTmOWPpglHWEuX2yksUUQ/C3XKaVNVN5ZnC4n5tXfXr9U+O6vVARhe7/S5Z7mZwG
         HRVZBDfkX6xgmgBv4UnSZJqbLRnMRemvk6uRRxKs0H83zHTj2qUyevzYGkiUxUtdWzVs
         eLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015753; x=1774620553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GebID9Fz+svTro9iiiZ+sDepPKQe8Gm/XzKmqqFUaQw=;
        b=K/nFLhmdgTb05SmtUNAAKdiFAoj6Xe2I5cSHMFLTY13fWjctaBKGuP6yaH+3eChaFI
         MBHjqBss7s9KoZavzVMzkSWzZI/cigrgTX7tUlfaF78sBHODjjYj2vwcJUVRu5JLRb/x
         ID4T3MM30P6XvQ74C76Q9mW7Hw5W/jxl7lsu+KIBkO7jcSX3DeZ+1q0+qR5kUegVc6J/
         oWSqoMZNWibyhd4b6fIe0xqk+JOQRinTBsR6Cpca1Fq6PF7+Wy1wLjcaMp6tqtrWA9zq
         T2CZLKqDOVlVxMjPHWFaMbTHPIu0uZebXc7OSM+u/4VHG9UsRyjsH8yqcSh7qDRKvqKk
         loyA==
X-Gm-Message-State: AOJu0Yx96cmn4+68kaNiZDAFI2AlDF5G64e6QFqlpMkGz8qrB0Ob9jsS
	F3+RMowQaQ//1DacOra+6V7EYHlMTbt7IXEaOhVkfLJf5X4bY6eVqMTepQCSV7WU9sOwHKDRvfM
	rqL3SFNXUH8rAb4zvj/xScHpRlr3coQs+aIbD
X-Gm-Gg: ATEYQzweJLRymmEIQjnv+QNalEze8EUbbOKb4I1ctmifcMLNOWbua12+PmbyWkGhHxa
	EADf8Bgi01ImK5Q1h+dY8HQggYzAlFVZnoDQFX7Qq7ZBmxcdxdZEvZYTT9t3dU7u2ZzmJABGcRQ
	zldiqcvLg5wXRpTiJJs5AM7iENwQdrRxvZFJR34vNbJgE979jMhvYHPBAEMngFxAG9VXnztBEX7
	k7C3WYrWFAZ7koQpYV6IQToayGaP/fVOKoyMyrXzncKdLusOf6bKJSmeLxebSZ3nUOg6CWrKiQ9
	EadjKrno29j0vJRZKQetrMaQKhkPXSGzrvFvngmKBsKb10SFJTFlLBAOswhj3njQtCfLf0Up/9q
	IwloTtyyiaNH0HGkKBkncJQeluKzZdytzW3VqD6BkyncGVez3QHAXIdaRw1Qr0Nk+dBU6hb3g/w
	==
X-Received: by 2002:a17:907:d501:b0:b97:900b:136a with SMTP id a640c23a62f3a-b982f20bfb2mr218536366b.4.1774015752796;
        Fri, 20 Mar 2026 07:09:12 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b9832dc4773sm17453166b.5.2026.03.20.07.09.12;
        Fri, 20 Mar 2026 07:09:12 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 9A8CB1C282;
	Fri, 20 Mar 2026 15:09:12 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	andrea.mayer@uniroma2.it,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH iproute2-next v2 2/3] seg6: add tunsrc support in iproute_lwtunnel
Date: Fri, 20 Mar 2026 15:08:46 +0100
Message-Id: <20260320140847.1730633-3-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260320140847.1730633-1-justin.iurman@6wind.com>
References: <20260320140847.1730633-1-justin.iurman@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,uniroma2.it,gmail.com,6wind.com];
	TAGGED_FROM(0.00)[bounces-269927-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.861];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid,saddr.family:url]
X-Rspamd-Queue-Id: 214512DBAC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the new optional "tunsrc" parameter. Now, a tunnel
source address can be configured per route and has priority over the
configured per-netns source address (if any).

Example:
ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
    segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0

Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 ip/iproute_lwtunnel.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index a7885dba28c1..00b4f7565be6 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -266,6 +266,13 @@ static void print_encap_seg6(FILE *fp, struct rtattr *encap)
 	print_string(PRINT_ANY, "mode",
 		     "mode %s ", format_seg6mode_type(tuninfo->mode));
 
+	if (tb[SEG6_IPTUNNEL_SRC]) {
+		print_color_string(PRINT_ANY, COLOR_INET6,
+				   "tunsrc", "tunsrc %s ",
+				   rt_addr_n2a_rta(AF_INET6,
+						   tb[SEG6_IPTUNNEL_SRC]));
+	}
+
 	print_srh(fp, tuninfo->srh);
 }
 
@@ -953,6 +960,8 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
 	char segbuf[1024] = "";
+	bool tunsrc = false;
+	inet_prefix saddr;
 	int argc = *argcp;
 	int encap = -1;
 	__u32 hmac = 0;
@@ -967,6 +976,22 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			encap = read_seg6mode_type(*argv);
 			if (encap < 0)
 				invarg("\"mode\" value is invalid\n", *argv);
+		} else if (strcmp(*argv, "tunsrc") == 0) {
+			NEXT_ARG();
+			if (encap == -1)
+				invarg("\"tunsrc\" provided before \"mode\"\n",
+				       *argv);
+			if (encap == SEG6_IPTUN_MODE_INLINE)
+				invarg("\"tunsrc\" invalid with inline mode\n",
+				       *argv);
+			if (tunsrc)
+				duparg2("tunsrc", *argv);
+
+			get_addr(&saddr, *argv, AF_INET6);
+			if (saddr.family != AF_INET6 || saddr.bytelen != 16)
+				invarg("\"tunsrc\" value is invalid\n", *argv);
+
+			tunsrc = true;
 		} else if (strcmp(*argv, "segs") == 0) {
 			NEXT_ARG();
 			if (segs_ok++)
@@ -1005,6 +1030,12 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			  sizeof(*tuninfo) + srhlen))
 		goto out;
 
+	if (tunsrc) {
+		if (rta_addattr_l(rta, len, SEG6_IPTUNNEL_SRC,
+				  &saddr.data, saddr.bytelen))
+			goto out;
+	}
+
 	*argcp = argc + 1;
 	*argvp = argv - 1;
 	ret = 0;
-- 
2.39.2


