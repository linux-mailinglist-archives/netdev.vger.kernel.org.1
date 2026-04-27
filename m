Return-Path: <netdev+bounces-281258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID+YMEMc72lk6wAAu9opvQ
	(envelope-from <netdev+bounces-281258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:20:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145246EF42
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DEC63006115
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671F39B489;
	Mon, 27 Apr 2026 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvf6G7WG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D239B482
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277997; cv=none; b=gYubwCm+2UU1gEkLXxx+eZuMrrnDQlmJLh70eBFUE1jgSms9AR4d4wLAHwEs8zH7E+mYSfY1ElbyaLpALDEg/HBN68A8TqUsJMikWrbG2Yaok7t54I5YPqJ0W+IuhQn6gq4styYLaWoZx0dAy16r0qFOm+e2R8bzw/qQC7nUL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277997; c=relaxed/simple;
	bh=U/Da4CG9zyFVhJWXw1IkB5xC0v+HckHQFadw3JJt55Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KdNhmfpqEO5d5omr+dKlFtvn2my2vYFQQhefnzJYhiebsomoC3AqkgafegFBy3eafTo54tcO4AxE0TjAI5N3sw2BeMDuofL4+2ZU3O04TgBthjSDNTMtWEuFqWqEv9/3bjppR4K2bU+uUiuRsVsx3at6TiV5uGVQKbqZtVexpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvf6G7WG; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8eaee67d1bcso1355629285a.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777277995; x=1777882795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z+EVm9PgXe4DnSmhH1iRHlGINhe2M5ARvnyMqCcu7Qs=;
        b=uvf6G7WGn5RerYBlu0Xn6jnBI/mFPGSq5l6uNTmb6aawGz56/ZOpWF3IqJYDU3Qsik
         yBGJy2I5NWXHQ5oO1I28UvZ5KsKDyHgFM7c74+Z+LA33BhA7sJqeWOBgjrRtNY2cX3le
         sSP340Odey0JGOmSZ0NMcnPG8HCj1AlyhrWg/nkia9WGiYWdtWeE9cjJMmKyeWuFZwp2
         6tya/gGim92HEZq0iDC6lQX5O188PPe2Alz3SWFQBTD9UcEGkzCumbegj46T4FEsttm3
         g26JUchWZWDfbeX9ZN9iyb525BOOL6H3bQFg28rsF2lHyXyTwXumchuuphDobf+Yvwk3
         vlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277995; x=1777882795;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+EVm9PgXe4DnSmhH1iRHlGINhe2M5ARvnyMqCcu7Qs=;
        b=ibLjc3uJGOIe3DwW72nVVYC1E2QKV5HWSuQhuB+cl4DjhiD3ipO6Iz/dLDBp0ZGf/B
         d6SVksJQInV4sZXzlqE/Nn+ioPBPNGvGlThvnGhZOSDL7qkw7t3yN3Q+Ob1XGvs5aSh6
         VPF+6rtaTjUCGMTTgIyBfM8ip5uhBrnNdJKIW8GAKPtRQE8sU9x2wNPThhwyJ8BDLXcX
         ohjw13XFp7Tqwwx3rLDbxjD0xhJHA7Pmsx6y+jvq1XDMYbA5ALRaFQHH01zI7iUaQOQK
         r+b5dkK1JHuuGEp3dpo7FN5rIy9DC5aXmfeqMl4P+E+4Zo1UFbvvx3B379YntdUweaUB
         lt5g==
X-Forwarded-Encrypted: i=1; AFNElJ+twGCyhBlRRJfXH935OVSaynpNzXaGHdywTukQ3TQAVNteeEHiRh/8Ul714aXyxOonLjDWVgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFQCbM0hsWZ1OAWj3k/tiAiI5kOHj9A4UPSdxsA+yQD+ld+0T
	c250tTKhSFOEKkC05jOf1ye3koDGWuPM1yX+ShbqdmCZtnz56xU+en94rl5a7QgaUBaDgUwWI8x
	MaYtUCTYnJDa4+w==
X-Received: from qvbkk25.prod.google.com ([2002:a05:6214:5099:b0:8a3:6752:348e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5746:0:b0:89c:4fab:3783 with SMTP id 6a1803df08f44-8b027e76f94mr665037356d6.0.1777277994462;
 Mon, 27 Apr 2026 01:19:54 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:19:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427081953.364819-1-edumazet@google.com>
Subject: [PATCH v2 iproute2-next] utils: add fflush_monitor() helper
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9145246EF42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281258-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Some fflush() calls only make sense for monitor programs.

For other cases, forcing a flush is expensive.

After this patch, ip, tc and ss are correctly buffering most of their
output when redirected to a file.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/utils.h  |  7 +++++++
 ip/ipaddress.c   | 12 +++++++-----
 ip/iplink.c      |  4 ++--
 ip/ipmonitor.c   |  1 +
 ip/ipmptcp.c     | 10 +++++-----
 ip/ipneigh.c     |  4 ++--
 ip/ipnetconf.c   |  2 +-
 ip/ipnetns.c     |  2 +-
 ip/ipnexthop.c   | 12 ++++++------
 ip/iproute.c     |  4 ++--
 ip/iprule.c      |  2 +-
 ip/iptoken.c     |  2 +-
 ip/tcp_metrics.c |  2 +-
 lib/utils.c      |  1 +
 misc/ss.c        |  3 ++-
 tc/tc_class.c    |  2 +-
 tc/tc_filter.c   |  2 +-
 tc/tc_monitor.c  |  1 +
 tc/tc_qdisc.c    |  2 +-
 19 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index b68d6bc4edcf9ca335148f731cd240871b6c809b..2ed3b75ebb45e0f0e4aedd9bdf21375f74c2bbef 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -38,6 +38,7 @@ extern int numeric;
 extern bool do_all;
 extern int echo_request;
 extern int use_iec;
+extern int monitor_mode;
 
 #define SPRINT_BSIZE 64
 #define SPRINT_BUF(x)	char x[SPRINT_BSIZE]
@@ -399,4 +400,10 @@ FILE *generic_proc_open(const char *env, const char *name);
 int open_fds_add(int fd);
 void open_fds_close(void);
 
+static inline void fflush_monitor(FILE *fp)
+{
+	if (monitor_mode)
+		fflush(fp);
+}
+
 #endif /* __UTILS_H__ */
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 4d93a04a8555e141ae30a4aaeb42ac607a181c9b..14aa98e77452c9681c9d3660f6a882df56b44f1c 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -894,7 +894,7 @@ static int print_linkinfo_brief(FILE *fp, const char *name,
 		print_string(PRINT_FP, NULL, "%s", "\n");
 	}
 
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
@@ -1346,10 +1346,12 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 	}
 
 	print_string(PRINT_FP, NULL, "%s", "\n");
-	fflush(fp);
+	fflush_monitor(fp);
 	/* prettier here if stderr and stdout go to the same place */
-	if (truncated_vfs)
+	if (truncated_vfs) {
+		fflush(fp);
 		fprintf(stderr, "Truncated VF list: %s\n", name);
+	}
 	return 1;
 }
 
@@ -1732,7 +1734,7 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
 	}
 	print_string(PRINT_FP, NULL, "%s", "\n");
 brief_exit:
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
@@ -1768,7 +1770,7 @@ static int print_selected_addrinfo(struct ifinfomsg *ifi,
 
 	if (brief) {
 		print_string(PRINT_FP, NULL, "%s", "\n");
-		fflush(fp);
+		fflush_monitor(fp);
 	}
 	return 0;
 }
diff --git a/ip/iplink.c b/ip/iplink.c
index fce6631d2d821a8739d28805e13d98f6804bda30..806f86987ed7c8af5ddd40f04a44fb8ce8debfaf 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -1296,7 +1296,7 @@ static void print_mpls_stats(FILE *fp, struct rtattr *attr)
 	print_nl();
 	print_mpls_link_stats(fp, stats, "        ");
 	print_string(PRINT_FP, NULL, "%s", "\n");
-	fflush(fp);
+	fflush_monitor(fp);
 }
 
 static void print_af_stats_attr(FILE *fp, int ifindex, struct rtattr *attr)
@@ -1359,7 +1359,7 @@ static int print_af_stats(struct nlmsghdr *n, void *arg)
 	if (tb[IFLA_STATS_AF_SPEC])
 		print_af_stats_attr(fp, ifsm->ifindex, tb[IFLA_STATS_AF_SPEC]);
 
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
diff --git a/ip/ipmonitor.c b/ip/ipmonitor.c
index 1f4e860f8d6726edffcf9bf81636c6555757dd09..23bd667a2f7a27e620d0f6dd13a16476c1ac0d08 100644
--- a/ip/ipmonitor.c
+++ b/ip/ipmonitor.c
@@ -324,6 +324,7 @@ int do_ipmonitor(int argc, char **argv)
 		return err;
 	}
 
+	monitor_mode = 1;
 	if (rtnl_open(&rth, groups) < 0)
 		exit(1);
 
diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 3df89db54b4e00f8fe2d18828621999512622d59..37df15ba9b5f2d6974f5fdd2360025ce9a017316 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -276,7 +276,7 @@ static int print_mptcp_addrinfo(struct rtattr *addrinfo)
 
 	print_nl();
 	close_json_object();
-	fflush(stdout);
+	fflush_monitor(stdout);
 
 	return 0;
 }
@@ -325,7 +325,7 @@ static int mptcp_addr_dump(void)
 	}
 
 	delete_json_obj();
-	fflush(stdout);
+	fflush_monitor(stdout);
 	return 0;
 }
 
@@ -349,7 +349,7 @@ static int mptcp_addr_show(int argc, char **argv)
 	ret = print_mptcp_addr(answer, stdout);
 	delete_json_obj();
 	free(answer);
-	fflush(stdout);
+	fflush_monitor(stdout);
 	return ret;
 }
 
@@ -430,7 +430,7 @@ static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
 
 	print_nl();
 	close_json_object();
-	fflush(stdout);
+	fflush_monitor(stdout);
 
 	return 0;
 }
@@ -592,7 +592,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 out:
 	print_nl();
 	close_json_object();
-	fflush(stdout);
+	fflush_monitor(stdout);
 
 	return 0;
 }
diff --git a/ip/ipneigh.c b/ip/ipneigh.c
index e678545ad535ad83722d1daef51f08c569df8236..2b74fccdfd9c5e39d675b8d1419e23bf9f6b6e3d 100644
--- a/ip/ipneigh.c
+++ b/ip/ipneigh.c
@@ -298,7 +298,7 @@ static int print_neigh_brief(FILE *fp, struct ndmsg *r, struct rtattr *tb[])
 
 	print_string(PRINT_FP, NULL, "%s", "\n");
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 
 	return 0;
 }
@@ -472,7 +472,7 @@ int print_neigh(struct nlmsghdr *n, void *arg)
 
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 
 	return 0;
 }
diff --git a/ip/ipnetconf.c b/ip/ipnetconf.c
index 020eff786d0b82f3033a71c2f4fc3d5b1af5f099..efb4da963d463481fa27f41fcb8e65db844381cf 100644
--- a/ip/ipnetconf.c
+++ b/ip/ipnetconf.c
@@ -140,7 +140,7 @@ int print_netconf(struct rtnl_ctrl_data *ctrl, struct nlmsghdr *n, void *arg)
 
 	close_json_object();
 	print_string(PRINT_FP, NULL, "\n", NULL);
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
diff --git a/ip/ipnetns.c b/ip/ipnetns.c
index 3a33a3adacee31080c3ea9d0a52e455243423a75..abe5746415176c137c9755a6211cc4b7cbabe4e2 100644
--- a/ip/ipnetns.c
+++ b/ip/ipnetns.c
@@ -327,7 +327,7 @@ int print_nsid(struct nlmsghdr *n, void *arg)
 
 	print_string(PRINT_FP, NULL, "\n", NULL);
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index d5c429369d10f629823639fa7e6bfb70be5226d6..a9ebffc8e50101c5c4b2480fd4d8e1bb1a3c7588 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -826,7 +826,7 @@ int print_cache_nexthop(struct nlmsghdr *n, void *arg, bool process_cache)
 
 	__print_nexthop_entry(fp, NULL, &nhe, n->nlmsg_type == RTM_DELNEXTHOP);
 	print_string(PRINT_FP, NULL, "%s", "\n");
-	fflush(fp);
+	fflush_monitor(fp);
 
 	if (process_cache)
 		ipnh_cache_process_nlmsg(n, &nhe);
@@ -882,7 +882,7 @@ int print_nexthop_bucket(struct nlmsghdr *n, void *arg)
 
 	print_string(PRINT_FP, NULL, "%s", "\n");
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 
 	return 0;
 }
@@ -1178,7 +1178,7 @@ static int ipnh_get_id(__u32 id)
 	}
 
 	delete_json_obj();
-	fflush(stdout);
+	fflush_monitor(stdout);
 
 	free(answer);
 
@@ -1266,7 +1266,7 @@ static int ipnh_list_flush(int argc, char **argv, int action)
 	}
 
 	delete_json_obj();
-	fflush(stdout);
+	fflush_monitor(stdout);
 
 	return 0;
 }
@@ -1342,7 +1342,7 @@ static int ipnh_bucket_list(int argc, char **argv)
 	}
 
 	delete_json_obj();
-	fflush(stdout);
+	fflush_monitor(stdout);
 
 	return 0;
 }
@@ -1383,7 +1383,7 @@ static int ipnh_bucket_get_id(__u32 id, __u16 bucket_index)
 	}
 
 	delete_json_obj();
-	fflush(stdout);
+	fflush_monitor(stdout);
 
 	free(answer);
 
diff --git a/ip/iproute.c b/ip/iproute.c
index c2538894da633b56f5b926ecafda4960a48e9fbd..c6a6ba9dd37076acfceb9b259874a50e7cd3c3d0 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -1012,7 +1012,7 @@ int print_route(struct nlmsghdr *n, void *arg)
 
 	print_string(PRINT_FP, NULL, "\n", NULL);
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
@@ -2035,7 +2035,7 @@ static int iproute_list_flush_or_save(int argc, char **argv, int action)
 	}
 
 	delete_json_obj();
-	fflush(stdout);
+	fflush_monitor(stdout);
 	return 0;
 }
 
diff --git a/ip/iprule.c b/ip/iprule.c
index 3af02da24950ae224614e8e45e3de400675eee57..5bcafe11986f84f4b1946d758647d909456aeb61 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -599,7 +599,7 @@ int print_rule(struct nlmsghdr *n, void *arg)
 
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
diff --git a/ip/iptoken.c b/ip/iptoken.c
index f25a7c8b21f57c941d975a0255b0613f8a38f999..c19f9e0b4fdb282d1835959b025adf5bdf5a14e8 100644
--- a/ip/iptoken.c
+++ b/ip/iptoken.c
@@ -85,7 +85,7 @@ static int print_token(struct nlmsghdr *n, void *arg)
 			   "ifname", "%s\n",
 			   ll_index_to_name(ifi->ifi_index));
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 
 	return 0;
 }
diff --git a/ip/tcp_metrics.c b/ip/tcp_metrics.c
index 9c8fb07240bf01511aa2fc8cc2e80603db3252c9..b69bb282e1f30f53843e2cd9e51bfc3debf4310b 100644
--- a/ip/tcp_metrics.c
+++ b/ip/tcp_metrics.c
@@ -334,7 +334,7 @@ static int process_msg(struct nlmsghdr *n, void *arg)
 
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
diff --git a/lib/utils.c b/lib/utils.c
index 1215fe31cb3f63c0fa768fef60da77a641c51581..7017b0e6afacd8e770fb9f8b26aa5a319c1279e7 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -41,6 +41,7 @@ int timestamp_short;
 int pretty;
 int use_iec;
 int human_readable;
+int monitor_mode;
 const char *_SL_ = "\n";
 
 static int open_fds[5];
diff --git a/misc/ss.c b/misc/ss.c
index 14e9f27a75321556240a5f290b8bcf51c605a4c2..0f9b37177d375ddf70cb34674992723b5c4883be 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -5544,7 +5544,7 @@ static int generic_show_sock(struct nlmsghdr *nlh, void *arg)
 
 	render();
 
-	fflush(stdout);
+	fflush_monitor(stdout);
 	return ret;
 }
 
@@ -5580,6 +5580,7 @@ static int handle_follow_request(struct filter *f)
 		f->rth_for_killing = &rth2;
 	}
 
+	monitor_mode = 1;
 	if (rtnl_dump_filter(&rth, generic_show_sock, f))
 		ret = -1;
 
diff --git a/tc/tc_class.c b/tc/tc_class.c
index 6d707d8c924f4b5e90201d4de8e9779f82ce17f3..8197566281fad47d4efcf4768ed406ab809dd08a 100644
--- a/tc/tc_class.c
+++ b/tc/tc_class.c
@@ -380,7 +380,7 @@ int print_class(struct nlmsghdr *n, void *arg)
 		close_json_object();
 	}
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
diff --git a/tc/tc_filter.c b/tc/tc_filter.c
index 7db850bda11a3408ec66b457c9fc590f3a734f65..633f027d79865d98ba1ccba48af71d247dfc7a48 100644
--- a/tc/tc_filter.c
+++ b/tc/tc_filter.c
@@ -374,7 +374,7 @@ int print_filter(struct nlmsghdr *n, void *arg)
 
 	print_ext_msg(tb);
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
diff --git a/tc/tc_monitor.c b/tc/tc_monitor.c
index 5b9bccbed4140241a4d7a5cffc50865106224867..49bd4b6a460fbfe41a35e06f92f07dbe56a6be2d 100644
--- a/tc/tc_monitor.c
+++ b/tc/tc_monitor.c
@@ -100,6 +100,7 @@ int do_tcmonitor(int argc, char **argv)
 		return ret;
 	}
 
+	monitor_mode = 1;
 	if (rtnl_open(&rth, groups) < 0)
 		exit(1);
 
diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
index 7eb9a31baa31fb91a8141c9eca1135e76a52fa8b..a8ef8fc9f70d91609d6ed61c2a46b29120512fd2 100644
--- a/tc/tc_qdisc.c
+++ b/tc/tc_qdisc.c
@@ -344,7 +344,7 @@ int print_qdisc(struct nlmsghdr *n, void *arg)
 
 	print_ext_msg(tb);
 	close_json_object();
-	fflush(fp);
+	fflush_monitor(fp);
 	return 0;
 }
 
-- 
2.54.0.545.g6539524ca2-goog


