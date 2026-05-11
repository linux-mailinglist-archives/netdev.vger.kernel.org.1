Return-Path: <netdev+bounces-286796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DBqA7kiAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5317C5148D5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748893037410
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB74ADDBF;
	Mon, 11 May 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzUTniRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF654A2E12
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524778; cv=none; b=EOwuiwuZ46mYQIcZyoTgurBhrd/gJqGXQZPnYFk8etk4P/jn+Ik2xbAW/6hSAsUXJOEuqmFgPyrP4E5SAAU/K211c4vE1w4x802S5RRoFJflk+UE8y2ZhjKUngLpwe2I7YfgH+e57s0Jv5nYUd/UCbVHYXWHnYQ7INWPdHSYBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524778; c=relaxed/simple;
	bh=cYeQmbwFK4J93CdNJKWco6cFxmrnTq8ZsQbspG94E8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJVKeLMnfBBeeTOrXf1GU01cte4h2+YP04WWzE+5p1Iwp/j4Z3UF/DN7Ii7zWSkl71UoqCXT5w9s5WdezAMVRyHt46R9B5xPbrJmSnrnoQO5seAM4Pi6Q3SPMuDlcF7nUtAOrAwUxHmpOhtxOZeaVedprA9bSegJEzTpA3o1VtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzUTniRv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4585a116a4aso1150883f8f.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778524770; x=1779129570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDBb0iALNggsgmnxOsSS2A4Zn4r0O31/8CA2j0XGK+8=;
        b=ZzUTniRvumKcr7Y/A+iOAEd/EAOphib9DZbdO5+WQ8eY1EcB+BINGVWo3Ju2Fh05hd
         4SoqCDS4Lk2gTek1GawBEM6+K9zejvVZ31GrgG7SsotQ7HYPMmf2VU4J6cDUOVZVK8/V
         yyuEdG8VAU/hQkr98yTIh5YaSOl4rtNLpw87CxXmhPNGWfG9xyqoR2K4EVrDvZo78Kjv
         chgB+xePLe9LhvsirK+3IH0khpdTClRX0wKnqYkNo1quJwurbKd2OTZPZAz35/Xu6N/a
         7HA+YxQVdwKMI052adhtW9lpxdWgqwO6huGxJwzM/V/n73XEZ39Ia9qVS/HPk/Iw83tJ
         egUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524770; x=1779129570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDBb0iALNggsgmnxOsSS2A4Zn4r0O31/8CA2j0XGK+8=;
        b=C2vXvWAGMJI90nU/xS+IMMo10DGrk/Gy5lEdck2fbZlrr0jn5f+cU+dmqllr99kYw4
         Te9iRMyTCm3mPOwGgxXRxqX1nCy0IkpbePisFICAbx8mQE0xaVWHYGZfOdD2RiEok2mB
         jzoTZs5nfNFZDHBWwQRY+gLsRxYZF3flMtpcoUyijaq11ij/XK+eMjX5D1hDlKipI7fG
         XNdXnpaS4mMjqs+fGrOU2HrWxreSgOmadWS2dQV0ks9ULG3Xl0KZFOaoxAjb6rra4wjE
         62kUGlji/rX+ksrhD3gANB9kUp6AJ7HWhVjiseSVWnfWw+JaYypZuP8TPAdnQTHKIfOU
         ni9g==
X-Gm-Message-State: AOJu0YzR8WxnUB+lFmvp/gxmknHx0Sp8VXBtnuXHt7IX+pN4xZgwyusA
	R4imzMBiZcf2deoJ5F8j1iMtAIOI6hS8bqdcwIPFiu5ZKvGOdvbnjJyiLkhjJXeH
X-Gm-Gg: Acq92OGHrlsjsIdbcyEYUcBtn8S0gQgBZb2dW38R8DowAsJ1MuXaJy1K7grASKtVn9f
	QqZsfAygu66z7b9HlpReDRG4FHe7dCR3nOcEHa13yJjCA3/M3rZhDCHVDAuqix4qJfa+I9xYKxX
	UCv7Jor171gAb/eWZdenegEhIBW7Vb1amKXD/oFujv2vm8aboJtymVroVb+1SSyPJ0RtLrjbKzS
	o0JFWWPIT/hELU5zOlKk4Q/1Ok/4IFWya0ncJzk1beFUQNwxvUKONY6K1PUeRYOfX0oL0BJgIp7
	0M8FWKrvWSjzL0FeKsGf8LqL1X8jmuer5PdSODl+AlFjeRSru1/z5DFkSS+d5PzoDr5RRSAgpzf
	KSAdrM8unpJ2WZ5/4xto6TxCq7KnRl44rS+nTI6ageasqFkx2YONNmN3cJi7QU9zagWN5oAezLq
	+m4gP8vGYJBfktcWxlWyLaD/XAcVOd0BI=
X-Received: by 2002:a05:6000:400e:b0:452:d03a:7aad with SMTP id ffacd0b85a97d-452d03a7b29mr33872476f8f.36.1778524770072;
        Mon, 11 May 2026 11:39:30 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:42::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm26746959f8f.34.2026.05.11.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:39:29 -0700 (PDT)
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
Subject: [PATCH iproute2-next v3 5/6] netshaper: Add group command for creating scheduling hierarchies
Date: Mon, 11 May 2026 11:39:14 -0700
Message-ID: <20260511183915.797792-6-mohsin.bashr@gmail.com>
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
X-Rspamd-Queue-Id: 5317C5148D5
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286796-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Add the group command to create and update scheduling groups via the
NET_SHAPER_CMD_GROUP netlink operation. This enables building shaper
hierarchies by specifying a node handle, parent scope, rate parameters,
and a set of queue leaf shapers to attach.

The group command allows the node handle id to be omitted, letting
the kernel auto-assign one for new nodes. Only queue scope is
accepted for leaf shapers. Group handle and parent scopes are
validated to accept only node or netdev. Parent node scope
requires an explicit id since it must reference an existing node.

Common argument parsing (dev, bw-min, bw-max, weight) reuses the
parse_shaper_arg() helper introduced in the previous patch.

Example usage:
  netshaper group dev foo handle scope node parent scope netdev \
      bw-max 1gbit leaves scope queue id 0 scope queue id 1

Reviewed-by: Claude Assistant <noreply@anthropic.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 220 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 1 deletion(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 9ccd09f4..4519eb5d 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -31,10 +31,15 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: netshaper [ OPTIONS ] { COMMAND | help }\n"
 		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
-		"COMMAND := { set | get | delete } dev DEVNAME\n"
+		"COMMAND := { set | get | delete | group } dev DEVNAME\n"
 		"	    handle scope HANDLE_SCOPE [id HANDLE_ID]\n"
 		"	    [bw-min BW_MIN] [bw-max BW_MAX] [weight WEIGHT]\n"
 		"\n"
+		"netshaper group dev DEVNAME handle scope SCOPE [ id ID ]\n"
+		"          parent scope SCOPE [ id ID ]\n"
+		"          [ bw-min BW ] [ bw-max BW ] [ weight WEIGHT ]\n"
+		"          leaves { scope SCOPE id ID } [ ... ]\n"
+		"\n"
 		"Where: DEVNAME         := STRING\n"
 		"       HANDLE_SCOPE    := { netdev | queue | node }\n"
 		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
@@ -319,6 +324,217 @@ static int do_cmd(int argc, char **argv, int cmd)
 	return err;
 }
 
+#define NET_SHAPER_MAX_LEAVES	256
+
+static int do_group(int argc, char **argv)
+{
+	GENL_REQUEST(req, 4096, genl_family, 0, NET_SHAPER_FAMILY_VERSION,
+		     NET_SHAPER_CMD_GROUP, NLM_F_REQUEST | NLM_F_ACK);
+
+	struct shaper_args args = SHAPER_ARGS_INIT;
+	bool parsing_leaves = false, has_handle_id = false, has_parent_id = false;
+	int parent_scope = -1, num_leaves = 0;
+	int err, ret, handle_scope = NET_SHAPER_SCOPE_UNSPEC;
+	__u32 handle_id = 0, parent_id = 0;
+	struct nlmsghdr *answer;
+
+	struct {
+		int scope;
+		__u32 id;
+	} leaves[NET_SHAPER_MAX_LEAVES];
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
+				NEXT_ARG();
+				if (strcmp(*argv, "id") != 0) {
+					fprintf(stderr, "Expected \"id\" after leaf scope\n");
+					return -1;
+				}
+
+				NEXT_ARG();
+				if (num_leaves >= ARRAY_SIZE(leaves)) {
+					fprintf(stderr, "Too many leaves\n");
+					return -1;
+				}
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
+			if (handle_scope != NET_SHAPER_SCOPE_NODE &&
+			    handle_scope != NET_SHAPER_SCOPE_NETDEV) {
+				fprintf(stderr, "Group handle scope must be \"node\" or \"netdev\"\n");
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
+				has_handle_id = true;
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
+			if (parent_scope != NET_SHAPER_SCOPE_NODE &&
+			    parent_scope != NET_SHAPER_SCOPE_NETDEV) {
+				fprintf(stderr, "Parent scope must be \"node\" or \"netdev\"\n");
+				return -1;
+			}
+
+			if (parent_scope == NET_SHAPER_SCOPE_NODE) {
+				NEXT_ARG();
+				if (strcmp(*argv, "id") != 0) {
+					fprintf(stderr, "What is \"%s\"\n", *argv);
+					usage();
+					return -1;
+				}
+				NEXT_ARG();
+				if (get_unsigned(&parent_id, *argv, 10)) {
+					fprintf(stderr, "Invalid parent id\n");
+					return -1;
+				}
+				has_parent_id = true;
+			} else if (argc > 1 && strcmp(argv[1], "id") == 0) {
+				NEXT_ARG();
+				NEXT_ARG();
+				if (get_unsigned(&parent_id, *argv, 10)) {
+					fprintf(stderr, "Invalid parent id\n");
+					return -1;
+				}
+				has_parent_id = true;
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
+	if (args.ifindex == -1)
+		missarg("dev");
+	if (handle_scope == NET_SHAPER_SCOPE_UNSPEC)
+		missarg("handle");
+	if (parent_scope < 0)
+		missarg("parent");
+	if (num_leaves == 0)
+		missarg("leaves");
+
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, args.ifindex);
+
+	struct rtattr *parent = addattr_nest(&req.n, sizeof(req),
+					     NET_SHAPER_A_PARENT | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, parent_scope);
+	if (has_parent_id)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, parent_id);
+	addattr_nest_end(&req.n, parent);
+
+	struct rtattr *handle = addattr_nest(&req.n, sizeof(req),
+					     NET_SHAPER_A_HANDLE | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, handle_scope);
+	if (has_handle_id)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
+	addattr_nest_end(&req.n, handle);
+
+	if (args.has_bw_min)
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MIN,
+			  args.bw_min_bps);
+	if (args.has_bw_max)
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX,
+			  args.bw_max_bps);
+	if (args.has_weight)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_WEIGHT, args.weight);
+
+	if (args.has_bw_min || args.has_bw_max)
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
+	free(answer);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int color = default_color_opt();
@@ -363,6 +579,8 @@ int main(int argc, char **argv)
 			return do_cmd(argc - 1, argv + 1, NET_SHAPER_CMD_DELETE);
 		if (strcmp(*argv, "show") == 0)
 			return do_cmd(argc - 1, argv + 1, NET_SHAPER_CMD_GET);
+		if (strcmp(*argv, "group") == 0)
+			return do_group(argc - 1, argv + 1);
 		if (strcmp(*argv, "help") == 0) {
 			usage();
 			return 0;
-- 
2.53.0-Meta


