Return-Path: <netdev+bounces-283062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO8CLar/82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:19:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 390624A98E5
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB57130538C8
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F364E2D77E9;
	Fri,  1 May 2026 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIBbIBo3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D9225A38
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598192; cv=none; b=V3qf1xmnwdSJZLzcrxtzYM237t3fvKoljTmoCvVeQL3inMbSO3iJ4Zat52gVhJb5TDYqhBgjJhNSCTlc8rS6ND60oA2XNUR+1KdLNJbWQWNqG8RWwYxWuljZr1STr2/S0lUtTw0pVh1wozQj8NMcwZHkYAN3kFW3sC8Wfb/m8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598192; c=relaxed/simple;
	bh=YO606FGCvTmL8As/8r2us37/1EmLMwGYIVE5kokr4ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csCQFR6QJyzqiXlp5NTkYEYsLqcmA9tAR6yIn2hYXOxrHvqK8worKON8+auzRhW5aQ8J86G+CqJe9j7iGAUD50SfwGcGdMa0rWKWzojZqijjxq6vsaNRUrJQIZNE5PC7kVfeQ3nQ00ygGTvQmrYIJh8AgVUsk2oE9HnV4/jrRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIBbIBo3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d77f6092eso946016f8f.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777598189; x=1778202989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c8Wu+9VhDvSXUBcr83Y/i5yPiGwRnxgWsCNpKzYXf8=;
        b=dIBbIBo3gTS0CJOIs9leecVBpdYImZS8eyp3V30GcrB8XLJNXEXUYMLF+R5JMQRmwu
         Z0efvbXUXZdmiwY8+ekMZgYWQdR2lX2PSt8IV0NcNUGJlXH4THHbVw0Y+KMRlSM+U9R6
         FELPJfrKgHbGFQNanHaCFEW0Qc+sLvKIJrhYb5Ma/Hadse/2s5AweJ0XE3id6dOsaa4t
         WQRph9uogBqSWvL3j8gLx+kRV1TQgzji/VSZlr3ii8kM38xQI08WVpl2Ycllkmzy6ViF
         CwupuovZeXMZXICDy7yzq4SdgohtTvOaZf5z8ZlAFlqmcJy34QRn12jx5vyIlzNmYLfn
         bZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598189; x=1778202989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/c8Wu+9VhDvSXUBcr83Y/i5yPiGwRnxgWsCNpKzYXf8=;
        b=JGQhGCq+3GKcVjKvRmrYBxyJmgKAq1/Dhc9GynjG4OPvHGfR5BqhxHzMmOwdn5feXc
         eamVr+RF90Wn9wHdF7Fr8uC5l+RZk5Y5Lmmxle2QFPn5NZ5RwZLUlCpO+xDYvb5aHFFe
         zBlJUieqAcRTJYwlcdDR96MWn9r7/+klMyRSX2tTt9gIFgNL3ZiAbU2/Z89k7GPTrFK3
         fM7pmCiAjTzJPs0YXhdYqnhcxEitQPKXwPcDPxJ1CmtQ4qxXAvj+MW4ZDN9ZvFVKYPoP
         GvtHHTXXcYip0E1YYBdggK2Bs8yHMvAGijv7E2RKaqTv7PUwx7YZoLwELkvgw52BK/St
         IETg==
X-Gm-Message-State: AOJu0YxPmWvpy4RtnIhl1bUvcmPWpec+qitSNNvgam5h5ZQndoSzfA1h
	r5QpXWD084gOx5nYhMfQI2ywANYz/nrbdWMh6m5C3YlJDIu8fBCBwyW6bfPlw1La
X-Gm-Gg: AeBDiev2YcuFCXpc9RRKxr22bb7s+9R3BPbpKPwakH0Q/Y+pUP0Xmt0WLFmJfUYaxtp
	yCoUD/6rjuQbqfPu2Qx3TNhFF+HstWduCO6iKud0n0mcJQIDEY8ZLM4DeN29Pp2JbMc5x6l1qq0
	2FpmzfaCY3OZbYcUU6bjALRRc1sKnjtLgW+uWue6hiMw028lVUw/3W1R61wTmvT9FZelOWo529d
	VeNwGGexoXW+ZagX1zj/DJdxzqGVrpnhQBobRkHVhM/DujinZ0Yv5+4y+vZQedc6PQa39SVcQCF
	QiveBxNSd2uoARErmIzf++NprG5D3bPx/88GTfU9utOlEwuHNji53mu+ZTRyKI/9nJtaVk0mW/W
	3+4BEmncqzmdKhIAB5WE8hbsEJvxhgo8FaOtHmD2/zc7oDdy5OUanpP5zpJsal9+J7fVljSe0k6
	01MjpB0zs0DZAsIhcNnliKu1Vy9HEiWw==
X-Received: by 2002:a05:6000:1ac8:b0:43d:75ec:26f7 with SMTP id ffacd0b85a97d-4493fa01814mr8600782f8f.29.1777598189199;
        Thu, 30 Apr 2026 18:16:29 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ef52854sm1571036f8f.12.2026.04.30.18.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:16:28 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next 5/5] netshaper: Add group command for creating scheduling hierarchies
Date: Thu, 30 Apr 2026 18:16:11 -0700
Message-ID: <20260501011611.3533573-6-mohsin.bashr@gmail.com>
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
X-Rspamd-Queue-Id: 390624A98E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-283062-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add the group command to create and update scheduling groups via the
NET_SHAPER_CMD_GROUP netlink operation. This enables building shaper
hierarchies by specifying a node handle, parent scope, rate parameters,
and a set of leaf shapers (queues or nodes) to attach.

Example usage:
  netshaper group dev eth0 handle scope node parent scope netdev \
      bw-max 1gbit leaves scope queue id 0 scope queue id 1

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 netshaper/netshaper.c | 206 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 205 insertions(+), 1 deletion(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index fc68e735..7ec8220c 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -31,9 +31,15 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: netshaper [ OPTIONS ] { COMMAND | help }\n"
 		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
-		"COMMAND := { set | get | delete } dev DEVNAME\n"
+		"COMMAND := { set | get | delete | group } dev DEVNAME\n"
 		"	    handle scope HANDLE_SCOPE [id HANDLE_ID]\n"
 		"	    [bw-max BW_MAX] [bw-min BW_MIN] [weight WEIGHT]\n"
+		"\n"
+		"netshaper group dev DEVNAME handle scope SCOPE [ id ID ]\n"
+		"          parent scope SCOPE [ id ID ]\n"
+		"          [ bw-max BW ] [ bw-min BW ] [ weight WEIGHT ]\n"
+		"          leaves { scope SCOPE id ID } [ ... ]\n"
+		"\n"
 		"Where: DEVNAME         := STRING\n"
 		"       HANDLE_SCOPE    := { netdev | queue | node }\n"
 		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
@@ -264,6 +270,202 @@ static int do_cmd(int argc, char **argv, int cmd)
 	return err;
 }
 
+static int do_group(int argc, char **argv)
+{
+	GENL_REQUEST(req, 4096, genl_family, 0, NET_SHAPER_FAMILY_VERSION,
+		     NET_SHAPER_CMD_GROUP, NLM_F_REQUEST | NLM_F_ACK);
+
+	bool has_bw_max = false, has_bw_min = false, has_weight = false;
+	bool parsing_leaves = false, has_hid = false, has_pid = false;
+	int parent_scope = -1, ifindex = -1, num_leaves = 0;
+	int err, handle_scope = NET_SHAPER_SCOPE_UNSPEC;
+	__u32 handle_id = 0, parent_id = 0, weight = 0;
+	__u64 bw_max_bps = 0, bw_min_bps = 0;
+	struct nlmsghdr *answer;
+
+	struct {
+		int scope;
+		__u32 id;
+	} leaves[128];
+
+	while (argc > 0) {
+		if (parsing_leaves) {
+			if (strcmp(*argv, "scope") == 0) {
+				int lscope;
+
+				NEXT_ARG();
+				lscope = parse_scope(*argv);
+				if (lscope < 0) {
+					fprintf(stderr, "Invalid leaf scope \"%s\"\n",
+						*argv);
+					return -1;
+				}
+
+				NEXT_ARG();
+				if (strcmp(*argv, "id") != 0) {
+					fprintf(stderr, "Expected \"id\" after leaf scope\n");
+					return -1;
+				}
+
+				NEXT_ARG();
+				leaves[num_leaves].scope = lscope;
+				if (get_unsigned(&leaves[num_leaves].id, *argv, 10)) {
+					fprintf(stderr, "Invalid leaf id\n");
+					return -1;
+				}
+				num_leaves++;
+				argc--;
+				argv++;
+				continue;
+			}
+			parsing_leaves = false;
+		}
+
+		if (strcmp(*argv, "dev") == 0) {
+			NEXT_ARG();
+			ifindex = ll_name_to_index(*argv);
+			if (ifindex == 0) {
+				fprintf(stderr, "Device \"%s\" not found\n", *argv);
+				return -1;
+			}
+		} else if (strcmp(*argv, "bw-max") == 0) {
+			NEXT_ARG();
+			if (parse_rate(*argv, &bw_max_bps))
+				return -1;
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
+		} else if (strcmp(*argv, "handle") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "scope") != 0) {
+				fprintf(stderr, "Expected \"scope\" after \"handle\"\n");
+				return -1;
+			}
+			NEXT_ARG();
+			handle_scope = parse_scope(*argv);
+			if (handle_scope < 0) {
+				fprintf(stderr, "Invalid handle scope \"%s\"\n",
+					*argv);
+				return -1;
+			}
+
+			if (argc > 1 && strcmp(argv[1], "id") == 0) {
+				NEXT_ARG();
+				NEXT_ARG();
+				if (get_unsigned(&handle_id, *argv, 10)) {
+					fprintf(stderr, "Invalid handle id\n");
+					return -1;
+				}
+				has_hid = true;
+			}
+		} else if (strcmp(*argv, "parent") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "scope") != 0) {
+				fprintf(stderr, "Expected \"scope\" after \"parent\"\n");
+				return -1;
+			}
+			NEXT_ARG();
+			parent_scope = parse_scope(*argv);
+			if (parent_scope < 0) {
+				fprintf(stderr, "Invalid parent scope \"%s\"\n",
+					*argv);
+				return -1;
+			}
+
+			if (argc > 1 && strcmp(argv[1], "id") == 0) {
+				NEXT_ARG();
+				NEXT_ARG();
+				if (get_unsigned(&parent_id, *argv, 10)) {
+					fprintf(stderr, "Invalid parent id\n");
+					return -1;
+				}
+				has_pid = true;
+			}
+		} else if (strcmp(*argv, "leaves") == 0) {
+			parsing_leaves = true;
+			argc--;
+			argv++;
+			continue;
+		} else {
+			fprintf(stderr, "What is \"%s\"\n", *argv);
+			usage();
+			return -1;
+		}
+		argc--;
+		argv++;
+	}
+
+	if (ifindex == -1)
+		missarg("dev");
+	if (handle_scope == NET_SHAPER_SCOPE_UNSPEC)
+		missarg("handle");
+	if (parent_scope < 0)
+		missarg("parent");
+	if (num_leaves == 0)
+		missarg("leaves");
+
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, ifindex);
+
+	struct rtattr *parent = addattr_nest(&req.n, sizeof(req),
+					     NET_SHAPER_A_PARENT | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, parent_scope);
+	if (has_pid)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, parent_id);
+	addattr_nest_end(&req.n, parent);
+
+	struct rtattr *handle = addattr_nest(&req.n, sizeof(req),
+					     NET_SHAPER_A_HANDLE | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, handle_scope);
+	if (has_hid)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
+	addattr_nest_end(&req.n, handle);
+
+	if (has_bw_max)
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX, bw_max_bps);
+	if (has_bw_min)
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MIN, bw_min_bps);
+	if (has_weight)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_WEIGHT, weight);
+
+	if (has_bw_max || has_bw_min)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_METRIC,
+			  NET_SHAPER_METRIC_BPS);
+
+	for (int i = 0; i < num_leaves; i++) {
+		struct rtattr *leaf, *leaf_handle;
+
+		leaf = addattr_nest(&req.n, sizeof(req),
+				    NET_SHAPER_A_LEAVES | NLA_F_NESTED);
+		leaf_handle = addattr_nest(&req.n, sizeof(req),
+					   NET_SHAPER_A_HANDLE | NLA_F_NESTED);
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE,
+			  leaves[i].scope);
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID,
+			  leaves[i].id);
+		addattr_nest_end(&req.n, leaf_handle);
+		addattr_nest_end(&req.n, leaf);
+	}
+
+	err = rtnl_talk(&gen_rth, &req.n, &answer);
+	if (err < 0) {
+		fprintf(stderr, "Kernel command failed: %d\n", err);
+		return err;
+	}
+
+	print_netshaper_attrs(answer);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int color = default_color_opt();
@@ -308,6 +510,8 @@ int main(int argc, char **argv)
 			return do_cmd(argc - 1, argv + 1, NET_SHAPER_CMD_DELETE);
 		if (strcmp(*argv, "show") == 0)
 			return do_cmd(argc - 1, argv + 1, NET_SHAPER_CMD_GET);
+		if (strcmp(*argv, "group") == 0)
+			return do_group(argc - 1, argv + 1);
 		if (strcmp(*argv, "help") == 0) {
 			usage();
 			return 0;
-- 
2.52.0


