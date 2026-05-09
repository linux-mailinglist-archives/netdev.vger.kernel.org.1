Return-Path: <netdev+bounces-286089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCjmGUqb/mkMtwAAu9opvQ
	(envelope-from <netdev+bounces-286089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:26:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D484FD9FE
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68600303CA73
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB12C11DE;
	Sat,  9 May 2026 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU+9ZdfC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD042C08CF
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293454; cv=none; b=RVlluskKON8MshuVtIROZ7QcNTRNI4OGd8xUUS7VFwtx8WxdIAPtoaD4f83i4OkOifP0JJGJtkMRX+rGa35O+jGA2nJ6UiyGpJbXkMhmfkC13P9h3WeYLuamn6hacufe0wLupjiG4lKpq0OUHKwTbtPQFsa5448q4WDxozy5QTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293454; c=relaxed/simple;
	bh=safKsecjXibYbiYmynEbCX7dyi43jejtX3R+IhJ6eSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6ARJhhA4lnpU0wUI2pdywtMp5/9cgNJwdFW9lbj3nVR7sru53ujiwr8MumA3KQ8yKF0sq30PFXwWj7hPTUnWsbvWzodk0jc6w9LJ2SqaLEgoeiYF0T/iQpgL/F0Db2Yzo2X0OkJ5Vl7RAI34o8+wTK0d6t7bxeC3o+NR85x5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU+9ZdfC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0046078so20829545e9.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293450; x=1778898250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDV88yauO4u8TgmWa0MN3NF8sVmma225KYeS7BDXi9I=;
        b=CU+9ZdfC0468NscONZmL+RQisJEoGSoSFrS5soL/rh7vNa4MsosLRmfJVfJm954E8f
         yXl/Yi4AGTcKZBIWYaKRJdLNDgQfIViXlHEgn8BiJL/5+VlDvqLBiJJ2m6R4fH/nMFdd
         cfv7xB5bEvLbN4u6Bvdpt9z6PPCjujKDBxAhY+M2RZfwfltUW8k/t2dotGzxdD2A7pUn
         vIOvIxdfPjFpC8IUQTkRnXK68GIUgZB/Vzz4PCtxTCnEZm06BKug0cVUjeR95C7JyzZ4
         8XQ4qtFfgRwHYl+f0FH9ArNVipMpIQSKR2x22s3DpL4VDQY3w3alfU4fDICh83NXE5/J
         OEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293450; x=1778898250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDV88yauO4u8TgmWa0MN3NF8sVmma225KYeS7BDXi9I=;
        b=tPxu8zLap/4aqm6437YC9i5BsdXVhS6APBjlhFZMbgl8qBiY+I8GBg7Z5KHVe0UEUI
         EQ/NEB8PD6WjmA9W6H4bBsYr9lTmdtOS202hYSnO0uJCBj3ES4dboG4Li9QjqjwG6EnV
         lPwRb9Xo3/bQb3/iSQ7w4vqo2y7HHNZow0khqcKUR3ZyouHfI89sSXDtEfePivl3geMj
         Npdbtd8dxGeWsNHCmxT1nwBJAc4Xc6/GVbQdmNMB+Jw8K1zOqDH7yGOxJUAGsW0ISU2i
         KECYTptAsG1BaYXaCHNvX/CKgkbN45S9mRbdme3gaKEoQxUpIuWWFdsZ/VWS/rujLsNT
         Xlmg==
X-Gm-Message-State: AOJu0Yyyz0280w55KZfLQY8nKFPQtyo1cFrstllnldujNLQi7mhHbXmZ
	IGn9OTvAaiDGhsONLH15y0UbXQELy5IkDaLpzqTmUwFBvOfzKpVsDzf8aHx2enRT
X-Gm-Gg: AeBDies8H96t/z5+gl9sQfIuIPwWrsRJvKL9U5qSGQAtTBYzFLsQ0A68xueRPFDv4CN
	yQfAOUTm9z59Zc2J4OdjRqVUh41KJcRayZMO3kNLOH/HArkb4FHp6Guan1TogV//Gsc/95JYp5c
	9OXVMhFTi4yRarnc/1tU8WBNtokNBh7M9qWz2Rr+Kb0GLM1SCM3g3A21pL9Vqcdwd48LF01bXww
	MyCPiYv/0npqQDWoUiN7Ne84agQedFWiAWZUUxO8adgJa/UhM9pcpaSefRpSMQo4vPXiCJFunzw
	jS6Sfovd9F1mhchHEfe5Oqmy4RbWPFQ+ZRgi7nHKP1eY3y2QV8/PCx32mQn8hJR30NNNrDnHha/
	C+hs3NaDvQL0+8OGEXflf6/sGoY9hzr7fMHvDzkTl7AUBiovnGaJ3KQWA5GAUh39L2K7k+4/2pM
	oBkMgFMHk+PNPslrz/whccCiQloWoosHY=
X-Received: by 2002:a05:600c:19c8:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48e70687ed2mr9116335e9.5.1778293450244;
        Fri, 08 May 2026 19:24:10 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:47::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db189d3sm11885745e9.32.2026.05.08.19.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:24:09 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next v2 4/6] netshaper: Extract struct shaper_args and parse_shaper_arg() helper
Date: Fri,  8 May 2026 19:23:51 -0700
Message-ID: <20260509022353.3470738-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
References: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C0D484FD9FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286089-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Extract common shaper parameters (dev, bw-min, bw-max, weight) into
struct shaper_args and add parse_shaper_arg() to parse them. This
avoids duplicating argument parsing when the group command is added
in the next patch.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 111 +++++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 39 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 83bfd2f6..9ccd09f4 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -69,6 +69,54 @@ static int parse_rate(const char *str, __u64 *rate_bps)
 	return 0;
 }
 
+struct shaper_args {
+	__u64 bw_min_bps, bw_max_bps;
+	__u32 weight;
+	bool has_bw_min, has_bw_max, has_weight;
+	int ifindex;
+};
+
+#define SHAPER_ARGS_INIT { .ifindex = -1 }
+
+static int parse_shaper_arg(const char *key, int *argcp, char ***argvp,
+			    struct shaper_args *args)
+{
+	int argc = *argcp;
+	char **argv = *argvp;
+
+	if (strcmp(key, "dev") == 0) {
+		NEXT_ARG();
+		args->ifindex = ll_name_to_index(*argv);
+		if (args->ifindex == 0) {
+			fprintf(stderr, "Device \"%s\" not found\n", *argv);
+			return -1;
+		}
+	} else if (strcmp(key, "bw-min") == 0) {
+		NEXT_ARG();
+		if (parse_rate(*argv, &args->bw_min_bps))
+			return -1;
+		args->has_bw_min = true;
+	} else if (strcmp(key, "bw-max") == 0) {
+		NEXT_ARG();
+		if (parse_rate(*argv, &args->bw_max_bps))
+			return -1;
+		args->has_bw_max = true;
+	} else if (strcmp(key, "weight") == 0) {
+		NEXT_ARG();
+		if (get_unsigned(&args->weight, *argv, 10)) {
+			fprintf(stderr, "Invalid weight value\n");
+			return -1;
+		}
+		args->has_weight = true;
+	} else {
+		return 0;
+	}
+
+	*argcp = argc;
+	*argvp = argv;
+	return 1;
+}
+
 static void print_netshaper_attrs(struct nlmsghdr *answer)
 {
 	struct rtattr *handle_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
@@ -155,41 +203,25 @@ static int do_cmd(int argc, char **argv, int cmd)
 	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
 		     NLM_F_REQUEST | NLM_F_ACK);
 
-	bool has_bw_min = false, has_bw_max = false, has_weight = false;
+	struct shaper_args args = SHAPER_ARGS_INIT;
 	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
-	__u64 bw_min_bps = 0, bw_max_bps = 0;
-	__u32 handle_id = 0, weight = 0;
 	bool handle_present = false;
 	bool has_handle_id = false;
 	struct nlmsghdr *answer;
-	int err, ifindex = -1;
+	__u32 handle_id = 0;
+	int err, ret;
 
 	while (argc > 0) {
-		if (strcmp(*argv, "dev") == 0) {
-			NEXT_ARG();
-			ifindex = ll_name_to_index(*argv);
-			if (ifindex == 0) {
-				fprintf(stderr, "Device \"%s\" not found\n", *argv);
-				return -1;
-			}
-		} else if (strcmp(*argv, "bw-min") == 0) {
-			NEXT_ARG();
-			if (parse_rate(*argv, &bw_min_bps))
-				return -1;
-			has_bw_min = true;
-		} else if (strcmp(*argv, "bw-max") == 0) {
-			NEXT_ARG();
-			if (parse_rate(*argv, &bw_max_bps))
-				return -1;
-			has_bw_max = true;
-		} else if (strcmp(*argv, "weight") == 0) {
-			NEXT_ARG();
-			if (get_unsigned(&weight, *argv, 10)) {
-				fprintf(stderr, "Invalid weight value\n");
-				return -1;
-			}
-			has_weight = true;
-		} else if (strcmp(*argv, "handle") == 0) {
+		ret = parse_shaper_arg(*argv, &argc, &argv, &args);
+		if (ret < 0)
+			return -1;
+		if (ret > 0) {
+			argc--;
+			argv++;
+			continue;
+		}
+
+		if (strcmp(*argv, "handle") == 0) {
 			handle_present = true;
 			NEXT_ARG();
 
@@ -241,16 +273,17 @@ static int do_cmd(int argc, char **argv, int cmd)
 		argv++;
 	}
 
-	if (ifindex == -1)
+	if (args.ifindex == -1)
 		missarg("dev");
 
 	if (!handle_present)
 		missarg("handle");
 
-	if (cmd == NET_SHAPER_CMD_SET && !has_bw_min && !has_bw_max && !has_weight)
+	if (cmd == NET_SHAPER_CMD_SET &&
+	    !args.has_bw_min && !args.has_bw_max && !args.has_weight)
 		missarg("bw-min, bw-max, or weight");
 
-	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, ifindex);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, args.ifindex);
 
 	struct rtattr *handle = addattr_nest(&req.n, sizeof(req),
 					     NET_SHAPER_A_HANDLE | NLA_F_NESTED);
@@ -260,16 +293,16 @@ static int do_cmd(int argc, char **argv, int cmd)
 	addattr_nest_end(&req.n, handle);
 
 	if (cmd == NET_SHAPER_CMD_SET) {
-		if (has_bw_min)
+		if (args.has_bw_min)
 			addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MIN,
-				  bw_min_bps);
-		if (has_bw_max)
+				  args.bw_min_bps);
+		if (args.has_bw_max)
 			addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX,
-				  bw_max_bps);
-		if (has_weight)
+				  args.bw_max_bps);
+		if (args.has_weight)
 			addattr32(&req.n, sizeof(req), NET_SHAPER_A_WEIGHT,
-				  weight);
-		if (has_bw_min || has_bw_max)
+				  args.weight);
+		if (args.has_bw_min || args.has_bw_max)
 			addattr32(&req.n, sizeof(req), NET_SHAPER_A_METRIC,
 				  NET_SHAPER_METRIC_BPS);
 	}
-- 
2.53.0-Meta


