Return-Path: <netdev+bounces-283058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKHJBDz/82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:17:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBC24A987F
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E166301E1B3
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688F225A38;
	Fri,  1 May 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8MjCi1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8762D7DD7
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598183; cv=none; b=E+Y0uqbx8ltyaxRSPt6rBQ27AxsA66gu5nrUfrg/4b9UGz9VwtmI/zp3iw8itTcFxpLLXcd0n4rkRCLY7tyUV5zAKKfCpZBlL0Oo7ChnWTeTyH32n2Wfusf5L4SB/WWSGS8EIaPSI+BMkcj2yRxvBBcGg6mnWfSc7KzIhMkFPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598183; c=relaxed/simple;
	bh=73v4s1/fiDJLhCi7oJ1WYBmNjZrgZMBWTV4WRVcn2KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvEU9nq3qjk2KAhiLfrhJsrGG0+6l96M/NeTb+9HsMUYi/GbJ9/K7LonpMIj8RY2Lq46tn6IA1mJdLpw4HYIT69M4wLK0lA6lyL76/FxyDJk3jEHSOh8Vnx/Yi2WxKDHdvKP26P7C6XVcDfxSS176kj90YclJFgNEp6SmnEdSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8MjCi1o; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso15034445e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777598180; x=1778202980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/2eZVovPifiLRcNFdyOuqA74Vdtp0ttIJXyCOLMM/w=;
        b=S8MjCi1oo5jyfmil0/qlmQQL4oweEp8opAeTOtfMod2x9D/imEp9148+OGOIWMJrou
         6xLLjV4EH2YDPGFpj7aAIjifKAIdtaUziuS0lJiONWHzy3bWtCrP7JGFreeuOnZJgJyl
         isjbSYPDf5i+W6tnBMIH2GbS9c7PJuyoXTZcG+wvxi/Z2srukaohI8BwoPKNnNRm1ZD+
         MET2IoRDewGdM09EZXchQQ9ZUxNps9WAOk9e5t5Y2UnL+tBDv6Hj1FKT5B8XYIrQzayK
         Psg6EmJ9Ue1Pka/2WhfJtiAjd03tiVD0fRrGd6TQ/UPM7GNFQigVHX5B9mLF1nNWAfdX
         05dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598180; x=1778202980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/2eZVovPifiLRcNFdyOuqA74Vdtp0ttIJXyCOLMM/w=;
        b=AM6YqwZEwoZhrdpPF+CheNGldeL1rBIozrPmODgN3CoJvU9SxxYAUkt/nNBZloaLUn
         aGsHfwx8mP18aFjtrXpwJCWU7TqVwu3DIzNOZrEcPL/2zYZ1ktaB3BfPscUOM0dJ2ny5
         aHM4h+q6XqETJEt5hgiHqljsC+8zh/gP8DWbUW2rdOukSXxXr2pwgaJ6ie4OloGM5IPL
         KXsxXcYm+bVejUU3+/PPLS5jr2il+azsin1OYi6CKzUhon/8B1v/eLnYytPpPDAl9OA2
         CQxLCjnXE0s9kXmOFPI1a60cN11E8Cb9O5jyIF+aizKqwNpGyPD7srNgYiHTRgINrnVu
         kSBA==
X-Gm-Message-State: AOJu0Yw8Yywnli+kdyNlXavobe3myL2YJum1WbyB6xcyEmqnMnZ/VQLV
	z3Ez0sd0wI1UdmONqBmURcY7dKtTmxAXJlcCoe+M9+QOzFxKyvaSpqYjYZcc7r0+
X-Gm-Gg: AeBDiesFX4If3l6WTS+XTyJ8yJDaITtfNtY4XSxoRh9JhxEaqJKKxj3YKUZcDy8YPK2
	cjotsGP5mRmSB8zGsYHxbGZ6o7ZYGjDJhpZ9613VTv0LJ/DVDz7V8QE0DyB9edimEPak73gp2Yr
	HrNHDLV7xmRUYep5OBZMJcTb/eJc7CPF/2l7vmPNfawKNLSxsyuX83iV9cG4rS2x/3xJjTj8EDN
	YyQFYA6s/6inoVU2dZmIjjhUN9AJcaaPVWXlB+fFvftNMn1QtY099e3C5ovXn3TCDcMD8WhCjj4
	0YLzbgXM8lmppLlS0iktM3ufOssM9P20acprq5VedL1/F4Lys1U1kuSXwT3twM9dmIXvMaFrgCj
	Sq4dJfwc9omlCisxg+gnxrs4ypO7SW5Ys5T3zuy5ztXJH5ik2RFtQko8S6F0IaCG5yMfvWnNRrx
	ItTWjHPxMTtD+XLWkLGKBewEl9yvkav9U=
X-Received: by 2002:a05:600c:8b82:b0:48a:80cb:1bb4 with SMTP id 5b1f17b1804b1-48a84451237mr81945585e9.22.1777598180189;
        Thu, 30 Apr 2026 18:16:20 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe3cd18sm2384215e9.0.2026.04.30.18.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:16:19 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next 2/5] netshaper: Add bw-min and weight parameter support
Date: Thu, 30 Apr 2026 18:16:08 -0700
Message-ID: <20260501011611.3533573-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0FBC24A987F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-283058-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add bw-min and weight parameters to the set command. Previously
only bw-max was supported. Update the set validation to accept
any of bw-max, bw-min, or weight. Update usage text to reflect
the new parameters.

Before:
 ./netshaper set dev eth2 handle scope queue id 0 bw-min 100kbit
What is "bw-min"
Usage: netshaper [ OPTIONS ] { COMMAND | help }
OPTIONS := { -V[ersion] | -c[olor] | -help }
COMMAND := { set | get | delete } dev DEVNAME
	    handle scope HANDLE_SCOPE [id HANDLE_ID]
	    [bw-max BW_MAX]
Where: DEVNAME         := STRING
       HANDLE_SCOPE    := { netdev | queue | node }
       HANDLE_ID       := UINT (required for queue/node, optional for netdev)
       BW_MAX          := UINT{ kbit | mbit | gbit }

After:
 ./netshaper set dev eth2 handle scope queue id 0 bw-min 100kbit

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 netshaper/netshaper.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 1603e6e5..4ee30525 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -33,11 +33,12 @@ static void usage(void)
 		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
 		"COMMAND := { set | get | delete } dev DEVNAME\n"
 		"	    handle scope HANDLE_SCOPE [id HANDLE_ID]\n"
-		"	    [bw-max BW_MAX]\n"
+		"	    [bw-max BW_MAX] [bw-min BW_MIN] [weight WEIGHT]\n"
 		"Where: DEVNAME         := STRING\n"
 		"       HANDLE_SCOPE    := { netdev | queue | node }\n"
 		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
-		"       BW_MAX          := UINT{ kbit | mbit | gbit }\n");
+		"       BW_MAX/BW_MIN   := UINT{ kbit | mbit | gbit }\n"
+		"       WEIGHT          := UINT\n");
 }
 
 static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
@@ -125,13 +126,13 @@ static int do_cmd(int argc, char **argv, int cmd)
 	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
 		     NLM_F_REQUEST | NLM_F_ACK);
 
-	struct nlmsghdr *answer;
-	__u64 bw_max_bps = 0;
-	int ifindex = -1;
+	bool has_bw_max = false, has_bw_min = false, has_weight = false;
 	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
-	__u32 handle_id = 0;
+	__u64 bw_max_bps = 0, bw_min_bps = 0;
+	__u32 handle_id = 0, weight = 0;
 	bool handle_present = false;
-	int err;
+	struct nlmsghdr *answer;
+	int err, ifindex = -1;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -141,6 +142,19 @@ static int do_cmd(int argc, char **argv, int cmd)
 			NEXT_ARG();
 			if (parse_rate(*argv, &bw_max_bps))
 				return -1;
+			has_bw_max = true;
+		} else if (strcmp(*argv, "bw-min") == 0) {
+			NEXT_ARG();
+			if (parse_rate(*argv, &bw_min_bps))
+				return -1;
+			has_bw_min = true;
+		} else if (strcmp(*argv, "weight") == 0) {
+			NEXT_ARG();
+			if (get_unsigned(&weight, *argv, 10)) {
+				fprintf(stderr, "Invalid weight value\n");
+				return -1;
+			}
+			has_weight = true;
 		} else if (strcmp(*argv, "handle") == 0) {
 			handle_present = true;
 			NEXT_ARG();
@@ -197,8 +211,8 @@ static int do_cmd(int argc, char **argv, int cmd)
 	if (!handle_present)
 		missarg("handle");
 
-	if (cmd == NET_SHAPER_CMD_SET && bw_max_bps == 0)
-		missarg("bw-max");
+	if (cmd == NET_SHAPER_CMD_SET && !has_bw_max && !has_bw_min && !has_weight)
+		missarg("bw-max, bw-min, or weight");
 
 	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, ifindex);
 
@@ -208,8 +222,12 @@ static int do_cmd(int argc, char **argv, int cmd)
 	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
 	addattr_nest_end(&req.n, handle);
 
-	if (cmd == NET_SHAPER_CMD_SET)
+	if (has_bw_max)
 		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX, bw_max_bps);
+	if (has_bw_min)
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MIN, bw_min_bps);
+	if (has_weight)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_WEIGHT, weight);
 
 	err = rtnl_talk(&gen_rth, &req.n, &answer);
 	if (err < 0) {
-- 
2.52.0


