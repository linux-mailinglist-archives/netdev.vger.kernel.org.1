Return-Path: <netdev+bounces-289171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AELuFdF2C2o+IAUAu9opvQ
	(envelope-from <netdev+bounces-289171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:30:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD690573676
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE3B302AD0A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E14392837;
	Mon, 18 May 2026 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5o5mvAZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A386392C4A
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135857; cv=none; b=VyE9DRxpc7EBuuCSJIehmedlUkvnaxJxb6m0bbXXnOCdAkdP3uIHWcWaNqbGOh501KZZYmsovmWaWJ4HgheAkIxmzK7NseWKm9qkkcb9UDNHZ8+c9OJaCMD6cwBd/bgVLYGK46uALDiIj8fVENepQ+HxCI8JUzAYl0HGsv1KBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135857; c=relaxed/simple;
	bh=pAuhrJe+UBdx2woUSslHLeOSkEiAZBJvKr+37I8a7Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdFODlokWLvrYf9gbkdHmbd2SSdJdy2LfqFj8TBQ+GiU7lmXajBZpO63smcT1O6+bpYjqYORpCpSk1y0vaoLQNtEtSVGhXW5tj2dZMNGFk1SJEsItmXFpIfMKMuKQSgRUohGCG5HSGdn8XciBhb33ZuqsyD/6heGz9N1RWm1jQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5o5mvAZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd3eb594960so349564466b.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135853; x=1779740653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXQCHJrbKAzj/zINkQIkbfOU8OQrxAI8C4D6OhIlhsY=;
        b=r5o5mvAZaHhRST25UkFsztUmT2jVmIVwxE9JAnJ1cHS7NIKGSNel1kraDp2KaaaLoP
         b8nc03iNIRMEHC93VOV9gAfEQJPnzz3jXkxMwUKHPFBUiGC5kP+YptXVbmiQinna1j/h
         n1AL2WN9be1Zb5NMSOdtTChmXASkOysDxQbXt2NgTUewwuxramVSb5+sr87WMBBgJx/e
         Gn36NpAe48SWCGE4BLQ//0Vv6bVTNge86dbAd5xOdGhtOFJVY49iiJcVCkAJrwCC8hBb
         F6HcSRiH4nhgOUPbxdF2KzX7zJqKnLKQddF2qABlInwhNmgcygzxY3xpWdM1iOOPRCXI
         n9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135853; x=1779740653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXQCHJrbKAzj/zINkQIkbfOU8OQrxAI8C4D6OhIlhsY=;
        b=oyGNqGPkTXA7Jh9EHxuaISGhP/4upxkcpL6G98xZnanKVQgLky1m4tLRv2cAaLBi/Z
         lG5g3BzXChS9JW5wy59R7EByX+aiAaELIrHAONHFC1ZIV+VhkgKeMJ0yJ3pNyfv4NIX9
         G2JpXtZEK7OMwlONQ/ybYAHtOACQipZ+DVWfQ8QotboUVk4x9FFToFXE1AlNgn1fUYej
         0neXRRScFziOUQyCkkj5wu+u3Byd2SyXaprBFAr+eXza69V62LC9d0F3KwC25f3sZCJU
         CYaHhMPsa48LdyoHfd35CvT0d3Nf/a0YucAWqnJ+gH4Pson8pKpW97DgTzMZ/lyKdKW6
         pgjA==
X-Gm-Message-State: AOJu0Yw2d7EOYxoq09AbXNWvIebpojJGamOm/mfOCF74gtLeDn+6jPHW
	BCbMWl0cjtjoujg5AUmOwy1M5k1ACutoboW1wynMDkzk1hARsZueG1xi8dDOALuPo1g=
X-Gm-Gg: Acq92OE3ej8TI71Oib8mNQ76dXJmxz5d9KNGoz1LcJ/ABOtPQCWDwceUay6ZuKcNwEd
	MxCOvAjJ29MXGbcVCQuxBkoLpncGiJ3yKHjX3PaIOQ4g2H+fJ+DYKAneKv3RfHI+c1GgwYh6x+w
	KeJauzFxAZOsV5l6npXRiynXQ0APnxRPdvVIpFx6z4na0vV3joX7j7k+eiyuH4T0Zi+02oTgFYD
	uk6aGv5JR90FSd8KyxhT7flywGJDlWUjzlsgjgFSEKo5ZlTdrab1WcHkMdNPnDLZH8zGE0Qf5vr
	BHtCmCk1V9gQN3aOfhvbsxtopF+77oQufcw37T2b1SqDGoVoYKukhoGZ7LEODXBnN3e9EVo1f8c
	gCbtQ9LtYZd51RhLmUqyl/5mYQyjQKXMSXTmk26xlIpz9b2+ihVSUhIB9jOaWu7u17iUQYFc9FU
	IBc/IhRWQiHpaIu0QwBbgL
X-Received: by 2002:a17:907:724a:b0:bd5:3ccd:557c with SMTP id a640c23a62f3a-bd53ccd5753mr643104166b.42.1779135853327;
        Mon, 18 May 2026 13:24:13 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ebfd40sm606338466b.61.2026.05.18.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:24:12 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [iproute2-next V4 5/6] netshaper: Add group command for creating scheduling hierarchies
Date: Mon, 18 May 2026 13:23:52 -0700
Message-ID: <20260518202353.390827-6-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289171-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DD690573676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

Add the group command to create and update scheduling groups via the
NET_SHAPER_CMD_GROUP netlink operation. This enables building shaper
hierarchies by specifying a node handle, parent scope, rate parameters,
and a set of leaf shapers to attach.

The group command allows the node handle id to be omitted, letting
the kernel auto-assign one for new nodes. Group handle and parent
scopes are validated to accept only node or netdev. Parent node scope
requires an explicit id since it must reference an existing node.

Leaf parsing is extracted into parse_leaves() which dynamically
allocates the leaves array via realloc, avoiding arbitrary limits.
Each leaf accepts optional weight and priority parameters for
per-queue scheduling control within the group. Handle and parent
parsing share parse_scope_id() to avoid code duplication. Common
argument parsing (dev, bw-min, bw-max, weight) reuses the
parse_shaper_arg() helper introduced in the previous patch.

Example usage:
  netshaper group dev foo handle scope node parent scope netdev \
      bw-max 1gbit leaves scope queue id 0 weight 3 \
      scope queue id 1 weight 2

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 281 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 280 insertions(+), 1 deletion(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 93f50b9c..3b47d43d 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -31,10 +31,16 @@ static void usage(void)
 	fprintf(stderr,
 		"Usage: netshaper [ OPTIONS ] { COMMAND | help }\n"
 		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
-		"COMMAND := { set | get | delete } dev DEVNAME\n"
+		"COMMAND := { set | get | delete | group } dev DEVNAME\n"
 		"	    handle scope HANDLE_SCOPE [id HANDLE_ID]\n"
 		"	    [bw-min BW_MIN] [bw-max BW_MAX] [weight WEIGHT]\n"
 		"\n"
+		"netshaper group dev DEVNAME handle scope SCOPE [ id ID ]\n"
+		"          [ parent scope SCOPE [ id ID ] ]\n"
+		"          [ bw-min BW ] [ bw-max BW ] [ weight WEIGHT ]\n"
+		"          leaves { scope queue id ID\n"
+		"          [ weight WEIGHT ] [ priority PRIO ] } [ ... ]\n"
+		"\n"
 		"Where: DEVNAME         := STRING\n"
 		"       HANDLE_SCOPE    := { netdev | queue | node }\n"
 		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
@@ -69,6 +75,15 @@ static int parse_rate(const char *str, __u64 *rate_bps)
 	return 0;
 }
 
+struct shaper_leaf {
+	__u32 id;
+	__u32 weight;
+	__u32 priority;
+	int scope;
+	bool has_weight;
+	bool has_priority;
+};
+
 struct shaper_args {
 	__u64 bw_min_bps, bw_max_bps;
 	__u32 weight;
@@ -78,6 +93,7 @@ struct shaper_args {
 
 #define SHAPER_ARGS_INIT { .ifindex = -1 }
 
+
 static int parse_shaper_arg(const char *key, int *argcp, char ***argvp,
 			    struct shaper_args *args)
 {
@@ -319,6 +335,267 @@ static int do_cmd(int argc, char **argv, int cmd)
 	return err;
 }
 
+static int parse_scope_id(const char *what, int *argcp, char ***argvp, int *scopep,
+			  __u32 *idp, bool *has_idp, bool require_node_id)
+{
+	char **argv = *argvp;
+	int argc = *argcp;
+	int scope;
+
+	NEXT_ARG();
+	if (strcmp(*argv, "scope") != 0) {
+		fprintf(stderr, "Expected \"scope\" after \"%s\"\n", what);
+		return -1;
+	}
+
+	NEXT_ARG();
+	scope = parse_scope(*argv);
+	if (scope < 0) {
+		fprintf(stderr, "Invalid %s scope \"%s\"\n", what, *argv);
+		return -1;
+	}
+	if (scope != NET_SHAPER_SCOPE_NODE && scope != NET_SHAPER_SCOPE_NETDEV) {
+		fprintf(stderr, "%s scope must be \"node\" or \"netdev\"\n", what);
+		return -1;
+	}
+
+	if (require_node_id && scope == NET_SHAPER_SCOPE_NODE) {
+		NEXT_ARG();
+		if (strcmp(*argv, "id") != 0) {
+			fprintf(stderr, "What is \"%s\"\n", *argv);
+			usage();
+			return -1;
+		}
+		NEXT_ARG();
+		if (get_unsigned(idp, *argv, 10)) {
+			fprintf(stderr, "Invalid %s id\n", what);
+			return -1;
+		}
+		*has_idp = true;
+	} else if (argc > 1 && strcmp(argv[1], "id") == 0) {
+		NEXT_ARG();
+		NEXT_ARG();
+		if (get_unsigned(idp, *argv, 10)) {
+			fprintf(stderr, "Invalid %s id\n", what);
+			return -1;
+		}
+		*has_idp = true;
+	}
+
+	*scopep = scope;
+	*argcp = argc;
+	*argvp = argv;
+	return 0;
+}
+
+static int parse_leaves(int *argcp, char ***argvp,
+			struct shaper_leaf **leavesp)
+{
+	struct shaper_leaf *leaves = NULL;
+	int count = 0, cap = 0;
+	char **argv = *argvp;
+	int argc = *argcp;
+
+	while (argc > 0 && strcmp(*argv, "scope") == 0) {
+		int lscope;
+
+		if (count >= cap) {
+			cap = cap ? cap * 2 : 8;
+			leaves = realloc(leaves, cap * sizeof(*leaves));
+			if (!leaves)
+				return -1;
+		}
+
+		NEXT_ARG();
+		lscope = parse_scope(*argv);
+		if (lscope < 0) {
+			fprintf(stderr, "Invalid leaf scope \"%s\"\n", *argv);
+			free(leaves);
+			return -1;
+		}
+		if (lscope != NET_SHAPER_SCOPE_QUEUE) {
+			fprintf(stderr, "Leaf scope must be \"queue\"\n");
+			free(leaves);
+			return -1;
+		}
+
+		NEXT_ARG();
+		if (strcmp(*argv, "id") != 0) {
+			fprintf(stderr, "Expected \"id\" after leaf scope\n");
+			free(leaves);
+			return -1;
+		}
+
+		NEXT_ARG();
+		leaves[count].scope = lscope;
+		leaves[count].has_weight = false;
+		leaves[count].has_priority = false;
+		if (get_unsigned(&leaves[count].id, *argv, 10)) {
+			fprintf(stderr, "Invalid leaf id\n");
+			free(leaves);
+			return -1;
+		}
+		argc--;
+		argv++;
+
+		while (argc > 0 && strcmp(*argv, "scope") != 0) {
+			if (strcmp(*argv, "weight") == 0) {
+				NEXT_ARG();
+				if (get_unsigned(&leaves[count].weight,
+						 *argv, 10)) {
+					fprintf(stderr,
+						"Invalid leaf weight\n");
+					free(leaves);
+					return -1;
+				}
+				leaves[count].has_weight = true;
+			} else if (strcmp(*argv, "priority") == 0) {
+				NEXT_ARG();
+				if (get_unsigned(&leaves[count].priority,
+						 *argv, 10)) {
+					fprintf(stderr,
+						"Invalid leaf priority\n");
+					free(leaves);
+					return -1;
+				}
+				leaves[count].has_priority = true;
+			} else {
+				break;
+			}
+			argc--;
+			argv++;
+		}
+		count++;
+	}
+
+	*argcp = argc;
+	*argvp = argv;
+	*leavesp = leaves;
+	return count;
+}
+
+static int do_group(int argc, char **argv)
+{
+	GENL_REQUEST(req, 4096, genl_family, 0, NET_SHAPER_FAMILY_VERSION,
+		     NET_SHAPER_CMD_GROUP, NLM_F_REQUEST | NLM_F_ACK);
+
+	bool has_handle_id = false, has_parent_id = false;
+	struct shaper_args args = SHAPER_ARGS_INIT;
+	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
+	int parent_scope = -1, num_leaves = 0;
+	__u32 handle_id = 0, parent_id = 0;
+	struct shaper_leaf *leaves = NULL;
+	struct nlmsghdr *answer;
+	struct rtattr *nest;
+	int err, ret;
+
+	while (argc > 0) {
+		ret = parse_shaper_arg(*argv, &argc, &argv, &args);
+		if (ret < 0)
+			goto free_leaves;
+		if (ret > 0) {
+			argc--;
+			argv++;
+			continue;
+		}
+
+		if (strcmp(*argv, "handle") == 0) {
+			if (parse_scope_id("handle", &argc, &argv,
+					   &handle_scope, &handle_id,
+					   &has_handle_id, false))
+				goto free_leaves;
+		} else if (strcmp(*argv, "parent") == 0) {
+			if (parse_scope_id("parent", &argc, &argv,
+					   &parent_scope, &parent_id,
+					   &has_parent_id, true))
+				goto free_leaves;
+		} else if (strcmp(*argv, "leaves") == 0) {
+			NEXT_ARG();
+			num_leaves = parse_leaves(&argc, &argv, &leaves);
+			if (num_leaves < 0)
+				return -1;
+			continue;
+		} else {
+			fprintf(stderr, "What is \"%s\"\n", *argv);
+			usage();
+			goto free_leaves;
+		}
+		argc--;
+		argv++;
+	}
+
+	if (args.ifindex == -1)
+		missarg("dev");
+	if (handle_scope == NET_SHAPER_SCOPE_UNSPEC)
+		missarg("handle");
+	if (num_leaves == 0)
+		missarg("leaves");
+
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, args.ifindex);
+
+	if (parent_scope >= 0) {
+		nest = addattr_nest(&req.n, sizeof(req), NET_SHAPER_A_PARENT | NLA_F_NESTED);
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, parent_scope);
+		if (has_parent_id)
+			addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, parent_id);
+		addattr_nest_end(&req.n, nest);
+	}
+
+	nest = addattr_nest(&req.n, sizeof(req), NET_SHAPER_A_HANDLE | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, handle_scope);
+	if (has_handle_id)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
+	addattr_nest_end(&req.n, nest);
+
+	if (args.has_bw_min)
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MIN, args.bw_min_bps);
+	if (args.has_bw_max)
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX, args.bw_max_bps);
+	if (args.has_weight)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_WEIGHT, args.weight);
+
+	if (args.has_bw_min || args.has_bw_max)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_METRIC, NET_SHAPER_METRIC_BPS);
+
+	for (int i = 0; i < num_leaves; i++) {
+		struct rtattr *leaf, *handle;
+
+		leaf = addattr_nest(&req.n, sizeof(req),
+				    NET_SHAPER_A_LEAVES | NLA_F_NESTED);
+		handle = addattr_nest(&req.n, sizeof(req),
+				      NET_SHAPER_A_HANDLE | NLA_F_NESTED);
+		addattr32(&req.n, sizeof(req),
+			  NET_SHAPER_A_HANDLE_SCOPE, leaves[i].scope);
+		addattr32(&req.n, sizeof(req),
+			  NET_SHAPER_A_HANDLE_ID, leaves[i].id);
+		addattr_nest_end(&req.n, handle);
+		if (leaves[i].has_priority)
+			addattr32(&req.n, sizeof(req),
+				  NET_SHAPER_A_PRIORITY,
+				  leaves[i].priority);
+		if (leaves[i].has_weight)
+			addattr32(&req.n, sizeof(req),
+				  NET_SHAPER_A_WEIGHT,
+				  leaves[i].weight);
+		addattr_nest_end(&req.n, leaf);
+	}
+
+	err = rtnl_talk(&gen_rth, &req.n, &answer);
+	if (err < 0) {
+		fprintf(stderr, "Kernel command failed: %d\n", err);
+		goto free_leaves;
+	}
+
+	print_netshaper_attrs(answer);
+	free(answer);
+	free(leaves);
+	return 0;
+
+free_leaves:
+	free(leaves);
+	return -1;
+}
+
 int main(int argc, char **argv)
 {
 	int color = default_color_opt();
@@ -363,6 +640,8 @@ int main(int argc, char **argv)
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


