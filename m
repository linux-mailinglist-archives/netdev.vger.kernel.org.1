Return-Path: <netdev+bounces-286090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBJ3LF2b/mkMtwAAu9opvQ
	(envelope-from <netdev+bounces-286090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:26:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 432DE4FDA06
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72FEC3014676
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22672C11F9;
	Sat,  9 May 2026 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjMeL1A3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB772BFC85
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293458; cv=none; b=biqTFTQ5ACW3YEYy640I5FkeCvrHBT4mOlUvEbKcg8BrImGY4B3d7WGc05PYBXf0aRuSaf5FCt5AB6oxiksG8IJ5zV3pPpmzv838+3LuftzbrmVlugzUX8+BtqgtFCjTBlHd2savZf9F2wRAItgE3yPm86oGY1sfVs1D7YjV3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293458; c=relaxed/simple;
	bh=7dVSa7ksFpXgMr/jLnckfWMDCSg7BbD178PtVaianoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNULaeFITDnHGVsNzqghhiMgGR+Fg5n0lvDhcoqbay7v7xGjH15eqaKWBKfze7yYyms60uqH+JvNeOoo6NF6ax0X02DFt1+ypNTCbPo04IuaskEko41eOErVkevN0K1LuRwTKhBW41c/3jRaK9jQzHM5arvl66bPnb8r6k3MU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjMeL1A3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso1966106f8f.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293455; x=1778898255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWO+R3wnt/yGbI4trvo9eBfuBhXyNneDRc2cIMmMhqE=;
        b=OjMeL1A3EARwqOztym7w384/mU5U8u5K+OleJfexUR5mB9gj3B5v/m/Ebh93etNrwE
         8us0kWNJEByRRW4hs4YSRwt3YRtmzKu64tLkIbi/XzFCvfLRiizzFyVtsMSj0O4KbG0a
         xTDwaHQp1CXcHNRck7RLrMzVEoKOLBZupQw51BdQ6u5rHReLl+ZHAHpzoWT7zCbigKpI
         skHcML3bQX8z32Gt+ypZ5ZSD3CvNrLdkE6NzuRU3MoseWrB0hnWl6UCR/3h2GrKsaMFE
         LiyRFErIwc3K7cQEt8AQwLGJnSWNT6omXRM3X3tstB+XuzFV5peWO16rmNmHxh75sLvp
         5YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293455; x=1778898255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWO+R3wnt/yGbI4trvo9eBfuBhXyNneDRc2cIMmMhqE=;
        b=h0YLWtQunjmMp7H5vWmt4vDiua78/6JRCU5jjSPEDDAH3xm+FLinhtRcEqib2EStoz
         SwDNs1jgXSKARqmG/5J5WOfTksyEiJJYzkZ6JnABPJz7qbEzzMgPhCVsoUwjJRZMTQui
         7CyTqu9kO7dXx1heP88Twv7XYoVcS+Z+NxeQkGXZynTM42CKn1EnRDqqo4zrAJ0eZGBj
         CHsTRe6t+i/90HhE49kEaC+8Xkmg0Z14a53XSmuiHDGHojqalwNxE6S3SeXH7822Q5bs
         IkOfW1TkJ5q0AmnWoAiojfVlSrdvqHvTzKLgQxd2GW3kD50TFXw9h+sqDeII3x4OBue2
         SlPQ==
X-Gm-Message-State: AOJu0YxAoDFXRw+aIkSv9tFhDqmZea97G6AY6AuQOKbBjiR1Srae5ApF
	KRHYz4zS8zJLAsJgXSaCLS5mEtBIU4MLwJNvSVQQiJ0pH77G0wXyhhzxFSNHWucB
X-Gm-Gg: Acq92OGuifr2lC6092A9d7esI0xZzsXJVXQnxPpKqBKAtPfA3QuIGpPxzSASJB779F/
	e2ypyhzUqKJmzHoH+5qv7ck04ACnQeBZZwhpKTBMdKOn23Ccrn3YM2CIJkO5ElNPBbcWvV413l+
	fUGuiJPEz4uuDvAVaYV7B80m118YJMBv5QFAUkQ/ZY59fVBk8byeGfp6IZJ7HOpjDoiwNT+2AY1
	ql/4zgIY2kIpSZaa4i7wA/SjJtgqvChhOmTyOZXK+L7UnPuA5DGLUPpjlBmbKZEd1nLkqDRzjbt
	JC8DkK4EUC0ojUr/v7ar6+97k+55TOa3vHnum9gtTRaKDibYYSG1MjdYVxH3bf2mdkE+7/icrvi
	428tC3Zvg239L7tRkKVy3YCBavOLJARjFFvZmEd+WgO3Tx7CeY7yXHW0e+Eyo+Fnbn7x31adrag
	kGzJU8E+pp8QKDS52vgs3bevrAonYnqA==
X-Received: by 2002:a05:6000:2902:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-4515cf11c1bmr23813662f8f.26.1778293455236;
        Fri, 08 May 2026 19:24:15 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm8843835f8f.26.2026.05.08.19.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:24:13 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next v2 5/6] netshaper: Add group command for creating scheduling hierarchies
Date: Fri,  8 May 2026 19:23:52 -0700
Message-ID: <20260509022353.3470738-6-mohsin.bashr@gmail.com>
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
X-Rspamd-Queue-Id: 432DE4FDA06
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
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286090-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 220 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 1 deletion(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 9ccd09f4..5b1726d3 100644
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
+		printf("Kernel command failed: %d\n", err);
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


