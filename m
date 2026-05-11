Return-Path: <netdev+bounces-286797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOx/Hr4iAmonoQEAu9opvQ
	(envelope-from <netdev+bounces-286797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:41:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A271E5148E7
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89DEB30091D4
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1349691A;
	Mon, 11 May 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3MAV15D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36A4ADD9F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524780; cv=none; b=jBrTn3GfPVmDTHqivLbOzLGowzqwcGYcWEbGUaToExWiCcM5kFRTRLyreo58cStLy24SRSCwhbPF6uPhVXHFvyjwNsShyVX2tZtmwOHtwv5Vxma3xuFHDVvnsfGuQa2EsgpLi0Wls4jyzCjUmjngzTR5te7VqYU6lM5DeKe6Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524780; c=relaxed/simple;
	bh=QOsEH2Mk03xrE0Y2qeaw1WUb3sTQHejstAgVAdwqytE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIYeZhj7Cw7hSOCmZkCeEi//6h7K+b6KEcHu2l4uBzy6BEmcqOHI10ohfqvF0/MYVHZdf2/r+aB19M146eiXjN0FMX9PmLUtgXS+TGpm6LfnwmtgH3+D1e3p3V0W08EGiTSf98BRrDSP8bhsNwdo4P6hB6jUNVbIsbNc7ksBcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3MAV15D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so42557955e9.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778524768; x=1779129568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqYBJkFBn+dzBmQcLNGlSE6PnVzTozScXnJuF8YniTs=;
        b=B3MAV15Dd0kIkufmcYtTaKIeZLJcxsHGOg4v/ECnRAzVwkDA7MXWkq0k6+4YUxzYBt
         sERloZkivQlvVtWR4EaSZzFmAiiCY/I7ejF0IMT09dWhi+Xjt1fAGN75BnE0/tGOaNEj
         gFIkOLzqQ0PKKCPR7d37OTYc42gCzVYHpezAu1zWMwjBYRnIBi8G758il0MKoTL7o7JH
         RZjkmkMUOqCdD5znljaOSn/CkScvaaR/OPLiMBQqB+BrQr4O36aSbFMXXHc/aq6K6Ujk
         eHgLtqxvssIY1tjd6TTbXdCmSc5Tu5AVa0NGzyFS039i8SdZ9IcM6JvkLpBVIkSxGN5K
         f7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524768; x=1779129568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqYBJkFBn+dzBmQcLNGlSE6PnVzTozScXnJuF8YniTs=;
        b=WSJ5ZUNVQJ0QrotV4q5HRLxkHc3Q45gRveb6wCEcrSCPDyIOWmF/EMBdnuYpPXQkI/
         nOc4YJuPzg3u0ehG8wuy1h+p+AVUJ6eGpQh3a0XOA/YXHFQfgwCycDgw0fU9MBy0M6nP
         xl3SaqoiCSaY6K59alXwUIc9MgzvBlU9DDDvmmP6mW2hgaXV77BnhB6RXiiNQLEERALz
         Qe75iPtaRXMwnRzJ59QxfQ9aBfOU0VKDfOEKnWeGabl1lpLOhWf66zHvqZq4GzYDzEyN
         Ylrxc8zxdlfGFsLqwuZimVOm3y2Ds9uC8VkTZbobA31zzcT0ZhG3jOaiLstKTBRYghzu
         136w==
X-Gm-Message-State: AOJu0YzgmSfl7SGodtToansJQoSfci1uPYXcG/rmV05OaSKF6W+DD/R7
	nPLET3Ms7Yd3xEWOT31ccBAke4/4qKwvxAgnv2NXUEj6lds/IICSaNhwxazM1yFS
X-Gm-Gg: Acq92OGtBVVt3+6ocvvXGwUzS43PsHvkR9LnfEb0SJXtezzFV7jxMyHg+fPQjK6wIrl
	3u4k4WnzPTZY7B9K7v0YgsQmhKP7UPDnWsaGapGCjxztv5EC9z9PjscHQapbNgr5tvlzJagmbP4
	M0jr3kQVYxHKrfHO6vSgAtxN9n8c4h4hUoOP4saajtAxk5eYd3RHJFDIfpwpGWMrJAJIW7fZxCB
	OnPZQmFKS/hgAd7QsYXsb1YUml3DkcorRLR31fnmTv3va84LRAUYlN2kcSxuMHpcCP0+xwX89S7
	yiZg5R2RtL/Q0zjqms8Vq9BkMqcA2nJSgqfi/9sCDiPS7OvkdLUun0eg0RZ0oTaQaFK6s79YuAN
	3wVE/n2/2BcT1oa2rk/VMTf7zX1WgQFI9ll/cnBqtr8vU2IByhXRr2rbwA1/NV1tH7crrdBWfHQ
	4u3MahAMCIvjjf9ZMwsVs=
X-Received: by 2002:a05:600c:3b17:b0:488:ffb1:494c with SMTP id 5b1f17b1804b1-48e51e1f0b2mr382504595e9.12.1778524768017;
        Mon, 11 May 2026 11:39:28 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f410558sm467565e9.5.2026.05.11.11.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:39:27 -0700 (PDT)
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
Subject: [PATCH iproute2-next v3 4/6] netshaper: Extract struct shaper_args and parse_shaper_arg() helper
Date: Mon, 11 May 2026 11:39:13 -0700
Message-ID: <20260511183915.797792-5-mohsin.bashr@gmail.com>
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
X-Rspamd-Queue-Id: A271E5148E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286797-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Extract common shaper parameters (dev, bw-min, bw-max, weight) into
struct shaper_args and add parse_shaper_arg() to parse them. This
avoids duplicating argument parsing when the group command is added
in the next patch.

Reviewed-by: Claude Assistant <noreply@anthropic.com>
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


