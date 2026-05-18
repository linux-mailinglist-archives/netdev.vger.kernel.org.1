Return-Path: <netdev+bounces-289169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJHFIW51C2oZIAUAu9opvQ
	(envelope-from <netdev+bounces-289169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:24:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A5573563
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EB0F30215B1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913FA392803;
	Mon, 18 May 2026 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aySX8VUa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E3405C33
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135850; cv=none; b=S5IS9/jJcOLb3cXQsjVLKPvInMqHGJ8b5WSnFmtYW/UHpq4yM9awbdPUyauaQdi0AJ72lxuWNALvbQzjmOkqQEesGP56VL0aOn807vPcARf3/MIUCpG7k0cZ0LYCjB7X8a72j4oXSadU6BotxDyPzG2pWoe1Cm0RhWWiM20mIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135850; c=relaxed/simple;
	bh=NL+gcLtDDH6hwXd9uzV0ueZXc+qecwqwv8G1pP4E74g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pg5WoIZhT68damP+YUJ1p9WnagbTIgkCQHHeA+PxqG/eVDqkZy8TMN+QfiRjT8ifwRO+4LHAcok0y3aW+bBUKlbB5hgafhX+y8T7P5i9rpp4K0nbezhbSLot6WTdS7mBFth3zpjNWyvfhzaFhIS5+C6GaQbSyEoIXOuLFDryZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aySX8VUa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd21ffaca79so558679166b.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135847; x=1779740647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd3DFU7FKnKTIzqNFC8UO25pVxxF4C812ZdwvpwpdO8=;
        b=aySX8VUayNy+BEDvl6iEPhR98oKZZ8DvcxRmAH5DsbTfHJmBL6+ftg+OggBa11DXUv
         ye8+E9w6QR7bDzEKr2J/iCeVIgeJaEqcy+g2zqrgtVeIOBSkG8M5KXIwg7wZYarpq7I6
         Hp73YVe/TuVrrLyoB/O0c1g8InfdEbsPNDGF6pnu5ZtoE1U16vJEvJfDw5hhkc2jwV2r
         gNCQGD6wwKT4XhgYeDCx990s7YCApdhL06T3jXk8Tq04msPvM1iaOTxFJP3Xbcmqw/sV
         ilcFiAuhF4spjh7jInKjiYvphni8T6pj+RTmE1vLO7F5yBNK2Mm6oLpYLgbDvabIEF+b
         TR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135847; x=1779740647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kd3DFU7FKnKTIzqNFC8UO25pVxxF4C812ZdwvpwpdO8=;
        b=RavSBDWhGjBxN/+i3MRcSRnPXvgXJyZPZ+SdwKDQoNiMdgPe5ffjhv4mAnwmBckf2o
         PUnLGH7CIBfeUMti+1Bpn6ar3n+xuMJ5iMk1uW/kr6joWJr4u3elofc2QqfpfK9FB4/g
         WVZ73GZazLE466A64UL6vh7/FBXrXneUY6vfQ995DgXZKo7TKWqL3qkQQU2vmiK15cow
         cpEec2MnGPGGBtQ5uXvVlH7peylH2Ki1U7Pe5JQxUEhRi5kxE6BDI+2kXcUe/5UekDh8
         uPNaCP3x5qbep75wWm0fj5ZmR9GdBwXvZv+urcdRWVL9+UZAw3qldyWtu7PJEBo4bYoC
         2NrA==
X-Gm-Message-State: AOJu0YyTeTdxfSZWlFi8e34u4KO9nP20tGetBaq/EV7dYK4404dczVmR
	+dptFyiGL1ZkYHIL99JejI49x8aT7MksxVkx4ezB5rUF7bU2GnDhnm7HhfAloAoMPcY=
X-Gm-Gg: Acq92OG6wLfcsIyC6FO0QiDMJX6OKFRFNCUKAJsjRGZoPm1WaWGrCyQ0+hV9lsEN2Qz
	06TO5Pc8BPRATTXN+ue+CUr8BkAiDTT3gtqygn8DUevxQw/TAJoH1sWE7ffadj4GKToGO6WQcL4
	xP5V53mwh6lCosL6B5Uy4zNtrnvr9dZMBd9noXk4gY4U7ZKIpFJloxF3xjJpDcq1PO5s4VluUj0
	Hr2CPzATGvzFqNlhCTxrtvU9rrhGOKKRYc0FLoUoLHQ1VPjZYm6K3pvAWj/jbQAoL6HZkxse695
	LjkBZd/T9FMi79jiC+dAeAXUzNuQD6jX38i0lTKa6xRIHIkdF6xHTxwHZoNLfjookVnZFoJtdss
	uEH9fbPSeBmpUZmjojnyo5qY7Q3Wss3V42nqPDXaEVVFGIIQ96MApNEjgS05E20VKdi3haYwlKZ
	lbanirTtM62XQJ8p7xMnRpCkJa5afEBRo=
X-Received: by 2002:a17:907:988:b0:bc1:8598:f329 with SMTP id a640c23a62f3a-bd4f3460160mr930328866b.21.1779135846640;
        Mon, 18 May 2026 13:24:06 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:47::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c3150dsm609636066b.24.2026.05.18.13.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:24:06 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [iproute2-next V4 3/6] netshaper: Extend show output with parent, bw-min and weight
Date: Mon, 18 May 2026 13:23:50 -0700
Message-ID: <20260518202353.390827-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518202353.390827-1-mohsin.bashr@gmail.com>
References: <20260518202353.390827-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289169-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,networkplumber.org,redhat.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B8A5573563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

Extend print_netshaper_attrs() to display parent scope/id, bw-min,
and weight fields in the show output. Replace the switch-based
iteration with direct attribute checks for cleaner output formatting.
Use print_rate() for bandwidth display so that sub-Mbps rates
like 100kbit render correctly instead of truncating to 0 mbps.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 100 +++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 74175b39..20f4ed71 100644
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


