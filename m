Return-Path: <netdev+bounces-281025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKX8A9um62mrPwAAu9opvQ
	(envelope-from <netdev+bounces-281025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:22:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D3F461E1B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB01303E2CA
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D93E1CFC;
	Fri, 24 Apr 2026 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJXfrJ4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f202.google.com (mail-vk1-f202.google.com [209.85.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852B33F5B4
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050715; cv=none; b=HgcuhqOXxA54bz9sN/0ofG+MvEbbsZCwl/idA/O04WlBWhJx9WZb2AUtNVIi5J97FrNHW6yxUrzyBuNdtLSBhDbvzRNslgsas6n95xI63fnBfiGvvBSGDLf3NnO2+PVBbXEPhDlqLQJXnSgd0U7T13qmTArbvlId3X+kgxx5MIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050715; c=relaxed/simple;
	bh=elQA6kRFOKbGu7xOg9UXrVrdKp5uBfSiC+BcGbjl/gI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jeVO4R0EDpDeR0NuCaMzrOW2r1xCc8l2VcC/bGeES7dFgwoxynEnVRM5daQ3E8Mp6uT/brwkRm4Q1fKbUzYw6Jl6oOuEF1io6L3/zX4aPCEgD/022NGeJ5adc+hhv0YE5Q+VurO6r1YzgqL1jshYBRm5RjXAZlzNcmr82GKi9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJXfrJ4X; arc=none smtp.client-ip=209.85.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vk1-f202.google.com with SMTP id 71dfb90a1353d-56f6ef62af1so11913720e0c.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777050712; x=1777655512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BO2e9ngnshBPgV593HwtW/OHEvo1XShHa8R218xO+tU=;
        b=IJXfrJ4XpIG0yVN7ens/dQnrdEqBHJ8PMHKZTpQ5Pw6SK1tR5gkNbIGgWBVaBPJkeA
         BMlyiJafNECINmqHmONncA7gNTQiwYzgC/BOmvQXiLGFBsFLkjtd7JOd2dggqsiv5UHR
         JVay562GrgXryPJEGOatKOMr8LveqnX4qhDgk/9ch8mqXusuD3RzuI0uYCrmAnM6yvfp
         H0TBM4rLLILqowjkq+GzDOgZpGDhLxuX24K2NXcP7wWi1iSzB7T2GpnNcQS7QzkXH85T
         faBdFTjldFYq6HIfD8ARZR1R5Myf0cX6ViQ+muEw9wbYLP6WJT7HF1VgUO6Tsq4jB1fJ
         AUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050712; x=1777655512;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BO2e9ngnshBPgV593HwtW/OHEvo1XShHa8R218xO+tU=;
        b=Y0IsYhHWcu+XBL0gILadhSjhJG3fttgLGOfuiGaK6G6a0arK9h2Rs5d6wNp0db3d55
         EW0n3EmwaUVOVbY1zihhc4hjZqJV2rwV18t9cIOo3T9bzKrulv8FPxvdQdCKiz76U9G7
         hhqVMY4VposmHtu9x0w1srCEYe4cdx0xvK78H7pj+m24D0o14a2kTINnbv9cClZPjguy
         14XWbdCIW+ufKc9/OehjRQWlvsZTlY62SDdhJOvraVoGOHVO5Z5KA31nw/fTOpOQX7TN
         SFyxuxD3EyT58Qaf/A91e00mWUhEBH7Ucnr+PkimnTC5rSTp4qtCh4PX0YJXG9xFtPnW
         6NgA==
X-Forwarded-Encrypted: i=1; AFNElJ8+tKGFF/+X6x+tBCx8X1Xgaggm9/FmEnFiQjFdhNKWEcvCthSyBeD80SBfS7Scq2sjJ07Mp60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnnipN0ZQlMqlgkpRbI0l4twILLcHU8ISYnAWWyhnVPH7Qa1NK
	s1LXP25cqLbxb4J1MKQvHdtMrxZXNh7+aho9ahg7aV+KS18DP+mCjELrHnbPk3OB7mpyyOZisVM
	JNNynlKXRkMn6oQ==
X-Received: from uabep9.prod.google.com ([2002:a05:6130:2d89:b0:94d:4d9e:686f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6123:2e3:b0:56b:579c:82e with SMTP id 71dfb90a1353d-56fa58c0c9fmr17704826e0c.5.1777050712330;
 Fri, 24 Apr 2026 10:11:52 -0700 (PDT)
Date: Fri, 24 Apr 2026 17:11:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424171151.1190882-1-edumazet@google.com>
Subject: [PATCH iproute2-next] utils: add fflush_monitor() helper
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 85D3F461E1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281025-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

Some fflush() calls only make sense for monitor programs.

For other cases, forcing a flush is expensive.

After this patch, ip, tc and ss are correctly buffering their
output when redirected to a file.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/utils.h |  7 +++++++
 ip/ipaddress.c  | 12 +++++++-----
 ip/iplink.c     |  4 ++--
 ip/ipmonitor.c  |  1 +
 ip/iproute.c    |  4 ++--
 lib/utils.c     |  1 +
 misc/ss.c       |  3 ++-
 tc/tc_class.c   |  2 +-
 tc/tc_filter.c  |  2 +-
 tc/tc_monitor.c |  1 +
 tc/tc_qdisc.c   |  2 +-
 11 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index b68d6bc4edcf9ca335148f731cd240871b6c809b..9099a78b1593738c5ba181274d784d0a1913407a 100644
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
+		fflush_monitor(fp);
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


