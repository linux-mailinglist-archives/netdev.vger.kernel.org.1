Return-Path: <netdev+bounces-286795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VzT/BLkiAmonoQEAu9opvQ
	(envelope-from <netdev+bounces-286795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871B5148D6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2B3C3037982
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4878496911;
	Mon, 11 May 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntN1qsRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCA4A3406
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524776; cv=none; b=eQtEpEk8y5eDRGlpkt5ZrfPS08/LQMpbCeKnssAi0xBHScIvib+bCKbBLoPIKqPcX3oEdEt0W98hlYH+qQ61jiRybUvFXYntiDZqJ8P457K2AMcAlYl/nq039ueH2kOn5gUKc7RZQI7N8SkA4Yogx1DHRXCR27dHmZ2EJjgBhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524776; c=relaxed/simple;
	bh=GqVZs8zJ+e4qdfvclPHUUJ+ZINRCpLhXMgyA5FYl9Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8ChWQpeq6QmdAxAr2jtgMd76J1NGiOWnV5dOmwz2v7daXjwjrLEf2nMfySTDDqwKIo8NQl/ZHFy/je8GuOa9l6Z75y7tPLjbmzg94qQiHNWiz8xG4/nb3s5sRRBa6fwk0TcevR1YkszS906c+uKi7wAldm3eFhVsJ3ErYvwelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntN1qsRZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ad135063so37874615e9.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778524766; x=1779129566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzrJ0rRaKTeyq4xW+5roaJSiPu1ORCM0ICUJz55SJUE=;
        b=ntN1qsRZS7NGKveRViAxGRAefaHezw8gJbDt248gnQtQ9is5aX7UeV5SG51KoRFODy
         HgJZnhzzFbByYgx6PCk4x98cYSEzosGnSHECkcD7/J1NHkn2nWw5US1PYJc/9v0z9f+W
         aUhY51qaHky/F0y4SRx3enWAhOZyZED1+4YIGQVYyrAwwncUZqV404K4D/us+U2i8A4f
         6sv6a0mxPTzGgt/aMNS4WMKGHudUWIx1h0aVqRKyR+Sal0GzJs/MB6B9yVA+ZDmF+7sD
         cum+6iGyIY/JYOhIz1Ymwcool4Lsh93nhSdSTPSlKvlAo7FFE4Br57icleTHVbVxk9Ua
         baZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524766; x=1779129566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzrJ0rRaKTeyq4xW+5roaJSiPu1ORCM0ICUJz55SJUE=;
        b=VlxSrwK5b2N2Kmwf8OZTAE+/QNDEOgTU2a8XrzG5d/n5FO6hstcPn/QgPu0wQoI95t
         7Gyi8yuuyVXx4Eo7zi55U0lVLTv9lGwv1YLe9Lih4Hy5HEnzyQ6kUPbF9ZzxkE4CURHb
         de+MzIzHtIVRQOMWJBpGdxDa7HyfDAB4ISt+1juRXUUZlasFSrHlKXgUM44F6Osa4wH8
         VHVuFE6HB9dMYPWYuIcTB7SA6bhqXayQirgKlb70JXeCj5wcxj9BhOQcVZNJ3TOU9Rya
         ypzBVSQjOOYPaImPdodILZS8GqHdwBOzLwJztRR9NuilDOrFdL1xjnGzEveqZbsjWrHu
         ZjAw==
X-Gm-Message-State: AOJu0Yzh3pZaZ6t7c2ha3CxLuqmOXy0oEZdOYms8X3eiqrvlaYhk83FT
	Duye0y0rNctnNEBFo7OyRnuGPJOQJkPt+gnfd8/AmpwQAKHINKDbm1A8tx4Ni6sB
X-Gm-Gg: Acq92OHNj/JhOwI0gArdTnlJxCMF+qPIctJs9a6ADYTygQtAiKVh+ZIhugq+Y8PbiQC
	PD26yoy06Qq18YaoQLfVQZwP6iJMVwwFGb27CsgOK8GD/9XmkPy9TOADfJJYgVKzGy5OGCzh7Wk
	5eNQRu0dYc/1e/74umJCwNG2F3s/y7YDQaTepE51G1qFT8AtJdafL5KXMpaORGQZDm5Ap0KdPAH
	GAHtKvXkITSzyHmbu442bZ4JU0yYcvzMurSAVhhB7skV7ccn+2nZDLEGbvREjQhS/ps2SfthoB2
	39IwIQhZS0ZJaBK174qtltLk0SK8+VTc+Zm5hzw7CJZPgUStDuI23LPHPXIv9ki+uAce66Qg6iE
	97iROrcy3bzkLkMWnem/c4VdRKbD4oS6QS4naJHjWDQbEcbw0RwOT/ul3PQbJainN38orvJdwKi
	+75MOVYAhbYJtQBNnXTkR1b9gJKKrRNcE=
X-Received: by 2002:a05:600c:6290:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48e51f3fd58mr445045085e9.20.1778524766023;
        Mon, 11 May 2026 11:39:26 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f41a8b1sm332145e9.7.2026.05.11.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:39:25 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com,
	alexanderduyck@gmail.com,
	Claude Assistant <noreply@anthropic.com>
Subject: [PATCH iproute2-next v3 3/6] netshaper: Extend show output with parent, bw-min and weight
Date: Mon, 11 May 2026 11:39:12 -0700
Message-ID: <20260511183915.797792-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511183915.797792-1-mohsin.bashr@gmail.com>
References: <20260511183915.797792-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5871B5148D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286795-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com,anthropic.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Extend print_netshaper_attrs() to display parent scope/id, bw-min,
and weight fields in the show output. Replace the switch-based
iteration with direct attribute checks for cleaner output formatting.
Use print_rate() for bandwidth display so that sub-Mbps rates
like 100kbit render correctly instead of truncating to 0 mbps.

Reviewed-by: Claude Assistant <noreply@anthropic.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 100 +++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 186076a1..83bfd2f6 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -71,53 +71,83 @@ static int parse_rate(const char *str, __u64 *rate_bps)
 
 static void print_netshaper_attrs(struct nlmsghdr *answer)
 {
-	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
+	struct rtattr *handle_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
+	struct rtattr *parent_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
 	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
+	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
 	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
-	struct rtattr *handle_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
-	__u32 bw_max_mbps, scope, id;
-	__u64 bw_max_bps;
+	__u32 scope, id;
 	int ifindex;
 
 	parse_rtattr_flags(tb, NET_SHAPER_A_MAX,
 			   (struct rtattr *)((char *)ghdr + GENL_HDRLEN),
 			   len, NLA_F_NESTED);
 
-	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
-		if (!tb[i])
-			continue;
-		switch (i) {
-		case NET_SHAPER_A_BW_MAX:
-			bw_max_bps = rta_getattr_uint(tb[i]);
-			bw_max_mbps = (bw_max_bps / 1000000);
+	if (tb[NET_SHAPER_A_IFINDEX]) {
+		ifindex = rta_getattr_u32(tb[NET_SHAPER_A_IFINDEX]);
+		print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
+				   "dev: %s ", ll_index_to_name(ifindex));
+	}
 
-			print_uint(PRINT_ANY, "bw-max", "bw-max: %u mbps\n",
-				   bw_max_mbps);
-			break;
-		case NET_SHAPER_A_IFINDEX:
-			ifindex = rta_getattr_u32(tb[i]);
-			print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
-					   "dev: %s\n",
-					   ll_index_to_name(ifindex));
-			break;
-		case NET_SHAPER_A_HANDLE:
-			parse_rtattr_nested(handle_tb, NET_SHAPER_A_HANDLE_MAX,
-					    tb[NET_SHAPER_A_HANDLE]);
-			if (handle_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
-				scope = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_SCOPE]);
-				print_string(PRINT_ANY, "scope",
-					     "scope: %s\n",
+	if (tb[NET_SHAPER_A_HANDLE]) {
+		parse_rtattr_nested(handle_tb, NET_SHAPER_A_HANDLE_MAX,
+				    tb[NET_SHAPER_A_HANDLE]);
+		if (handle_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
+			scope = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_SCOPE]);
+			if (scope <= NET_SHAPER_SCOPE_MAX)
+				print_string(PRINT_ANY, "scope", "scope %s ",
 					     net_shaper_scope_names[scope]);
-			}
-			if (handle_tb[NET_SHAPER_A_HANDLE_ID]) {
-				id = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_ID]);
-				print_uint(PRINT_ANY, "id", "id: %u\n", id);
-			}
-			break;
-		default:
-			break;
+			else
+				print_uint(PRINT_ANY, "scope", "scope %u ", scope);
+		}
+		if (handle_tb[NET_SHAPER_A_HANDLE_ID]) {
+			id = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_ID]);
+			print_uint(PRINT_ANY, "id", "id %u ", id);
 		}
 	}
+
+	if (tb[NET_SHAPER_A_PARENT]) {
+		parse_rtattr_nested(parent_tb, NET_SHAPER_A_HANDLE_MAX,
+				    tb[NET_SHAPER_A_PARENT]);
+		if (parent_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
+			scope = rta_getattr_u32(parent_tb[NET_SHAPER_A_HANDLE_SCOPE]);
+			if (scope <= NET_SHAPER_SCOPE_MAX)
+				print_string(PRINT_ANY, "parent-scope",
+					     "parent scope %s ",
+					     net_shaper_scope_names[scope]);
+			else
+				print_uint(PRINT_ANY, "parent-scope",
+					   "parent scope %u ", scope);
+		}
+		if (parent_tb[NET_SHAPER_A_HANDLE_ID]) {
+			id = rta_getattr_u32(parent_tb[NET_SHAPER_A_HANDLE_ID]);
+			print_uint(PRINT_ANY, "parent-id", "id %u ", id);
+		}
+	}
+
+	if (tb[NET_SHAPER_A_BW_MAX]) {
+		__u64 bw = rta_getattr_uint(tb[NET_SHAPER_A_BW_MAX]);
+
+		print_string(PRINT_FP, NULL, "bw-max ", NULL);
+		print_rate(false, PRINT_ANY, "bw-max", "%s ",
+			   bw / BITS_PER_BYTE);
+	}
+
+	if (tb[NET_SHAPER_A_BW_MIN]) {
+		__u64 bw = rta_getattr_uint(tb[NET_SHAPER_A_BW_MIN]);
+
+		print_string(PRINT_FP, NULL, "bw-min ", NULL);
+		print_rate(false, PRINT_ANY, "bw-min", "%s ",
+			   bw / BITS_PER_BYTE);
+	}
+
+	if (tb[NET_SHAPER_A_WEIGHT]) {
+		__u32 weight = rta_getattr_u32(tb[NET_SHAPER_A_WEIGHT]);
+
+		print_uint(PRINT_ANY, "weight", "weight %u ", weight);
+	}
+
+	print_nl();
 }
 
 static int do_cmd(int argc, char **argv, int cmd)
-- 
2.53.0-Meta


