Return-Path: <netdev+bounces-306736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +bo0C4WzUWo1HgMAu9opvQ
	(envelope-from <netdev+bounces-306736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 05:07:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C17F740217
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 05:07:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ILleHQjw;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306736-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306736-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CC71300251A
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 03:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BBC2561A2;
	Sat, 11 Jul 2026 03:07:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA62AD35
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:07:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783739262; cv=none; b=Q8Ujzq/uSnvOVkDBm5rLgVb+N4nzPwxWiloaQ4j0ZpOQslIYkMWcHSaqhoGzkGePpfEQ280delMnlsg3d2YmSxsBiK3xKiymdZgtr2YaomViRFpyKuCE9eQoOjBI+crXbw5ov1ObEuOpKiT9pW5CbBLFgAEs0+/VMru1kwZ1Rk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783739262; c=relaxed/simple;
	bh=ZVD3P6sXGC2uVQuJmmD+ItOQ7wpPxLN9flmiautJbsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1Pwv28LLO/Qqtc4k95vp5jsNlHyfTNtKak/LPd6u4L6vbBVV1N5c3u7t3bH8dkc0U7EFmwPz1g6UBz1H+sDbwXQoeZ0CgPG7AgprTsS1nUCKX3eSDg67UfnPFo8TtSPV/Q2jHOjmp+VASqCdZkH8gjO5dMVKzDgixSRmuNpRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILleHQjw; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so9287365ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783739260; x=1784344060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i2/HQvcLsmdxnX4aZux9zwoA3/CVBJIg6oqLYUlcCp0=;
        b=ILleHQjw3x3Lwl/HhDTBbFE66TLilkvan0fL5T2URcZOllMjhM9vzuBMK0RnclR1mW
         +Co2T3yz6mmdDpn6TMCrds4ohBenWun2F+hg+jxbVifQsoSvxnm0oUYYpAij9N/K8G19
         zYkd6XcofZ4WPMl6sCHgpeTxEoOcKntyyPEAgEPi3wl29EnMuATO5kX6838OLytT4ng9
         PdDwbuIbgta7VxqmiTxqtin1yZX/rSG22VC0DFWI0zblDs3bw8SrA5n6QLuFCWt5wwBw
         zeKD5SVktdUGF9p1fhjhYQnzsIIgJqioWMO3KrwvcKJto9kfGYsDFn9HIEJU5ZJJTLMy
         IWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783739260; x=1784344060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i2/HQvcLsmdxnX4aZux9zwoA3/CVBJIg6oqLYUlcCp0=;
        b=kgvNN0OBpokm5kyNJ++81aMpOeKlSnqJEzs1AT80XZEwnjp7tZNTeXu9T8jGKfiNu8
         nz7pRoz2b4AIuvk+mTmM7g0BRMUgU9I1ahODn75xmvNh1hixvjbJm3yGMk2Ovq961o7x
         afyLQq6LeZStegSHIGq2RMppJCByOF1eD495I4eD4UfvmhsG2VP8CnTGeSJgMAGHs7Lz
         OBvfxbFENsY0rkl76av1BUAKZczrnMrVz1pjjiyTXFSaDjUN8HuMKGX6ONv2yLyyZZSU
         EpzqjzUXno93n8AUJ3dkh7edZuE1Q6DeBtmMXVpPBUVDnSd6bxAs1En6NtylRyKSmhU0
         8lzQ==
X-Forwarded-Encrypted: i=1; AHgh+RoboWyitN6/1qBkhRw5RDZnWhxs8xS88UQxqwlmm0Dyc1iDOlkIb2TtN3bMPu67rGxpkUsYAVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFVwIP2GC2+NhtVJOg/Rf5ZmZWQrTu830VTzu8lUViyOLWcB86
	aoiA7PsNcn+cwhy5t/SRFZFyjHY2XgjEjFmdzQG7aaU5C8bz+maVcJXd
X-Gm-Gg: AfdE7cmW+DA3vsmmv7CyqirFdRXUfiTZraL46qQXgXGhXTbwOu4vkmrHu/det/sT/cf
	3vODhMgiD3/ZtsLFpODhtvxwnQGlxA60oZJy2/CkpxnunR2TC8nT3Vso0rlYIDG/DZkem8GAFET
	kHCbQkDXuXwhf+LE2wAyl4eL3phYY8EheSRpCB+P2rgcEIgi3LM299LosHcngai0JJK9iaQttP1
	diPkl54av5FEoIkWdJnOhbRIHyeAOMofz7gxlLJznLMbDP1jIdFK1PVgMbMoE0Bdw+fZuYHmKZs
	F6jfaEmZbrTnQl3co0tUuigWvjbaNSxQh7klZYDFPE0+TOal2BvidcybmhYuJYOW3dcq0I+vb2k
	Yn7a2mWUhW4bU37dShnBdQROcz2BdSgIxSky59wXu+gkeFQVcuDhwLu5QWnXPaFG1XKHl6CRNyr
	an78SBlqAwLNcs0WUX1Hfbio8NbglPiQ9o2v7T4+kL
X-Received: by 2002:a17:902:e850:b0:2ca:ddbd:a19b with SMTP id d9443c01a7336-2ce9ee12956mr14923525ad.28.1783739260405;
        Fri, 10 Jul 2026 20:07:40 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:1e11:fd6e:f22e:97a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c25fccsm67365265ad.35.2026.07.10.20.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 20:07:39 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2-next] ipmaddr: use RTM_GETMULTICAST to list multicast addresses
Date: Sat, 11 Jul 2026 12:07:33 +0900
Message-ID: <20260711030733.48567-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306736-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,filter.dev:url,filter.family:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C17F740217

Replace /proc/net/igmp and /proc/net/igmp6 parsing in "ip maddr show"
with RTM_GETMULTICAST dumps. The kernel dumps IPv6 multicast addresses
via netlink since the beginning, IPv4 since v6.15 (eb4e17a1d915), and
reports the group users count via IFA_MC_USERS since kernel commits
7cb8198761e6 and e1d0f3f08391.

The netlink result is only used when it carries the same information
as procfs: if the dump fails (e.g. no IPv4 dump support) or any entry
lacks IFA_MC_USERS, the result is discarded and the procfs parsers
run as before, so output is unchanged on older kernels.

Link-layer multicast addresses are still read from
/proc/net/dev_mcast as there is no netlink API for them.

When a device is given, its ifindex is passed in the dump request so
strict-check kernels filter the dump server side; received entries
are checked against the ifindex again for kernels that ignore the
request field. An unknown device keeps printing an empty list.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 include/libnetlink.h |   3 ++
 ip/ipmaddr.c         | 110 +++++++++++++++++++++++++++++++++++++++++--
 lib/libnetlink.c     |  26 ++++++++++
 3 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index e91505d9..518b8714 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -62,6 +62,9 @@ typedef int (*req_filter_fn_t)(struct nlmsghdr *nlh, int reqlen);
 int rtnl_addrdump_req(struct rtnl_handle *rth, int family,
 		      req_filter_fn_t filter_fn)
 	__attribute__((warn_unused_result));
+int rtnl_mcaddrdump_req(struct rtnl_handle *rth, int family,
+			req_filter_fn_t filter_fn)
+	__attribute__((warn_unused_result));
 int rtnl_addrlbldump_req(struct rtnl_handle *rth, int family)
 	__attribute__((warn_unused_result));
 int rtnl_routedump_req(struct rtnl_handle *rth, int family,
diff --git a/ip/ipmaddr.c b/ip/ipmaddr.c
index 462b409e..7d8a3a09 100644
--- a/ip/ipmaddr.c
+++ b/ip/ipmaddr.c
@@ -27,6 +27,7 @@
 
 static struct {
 	char *dev;
+	int  index;
 	int  family;
 } filter;
 
@@ -207,6 +208,94 @@ static void read_igmp6(struct ma_info **result_p)
 	fclose(fp);
 }
 
+struct maddr_dump_ctx {
+	struct ma_info *list;
+	bool mc_users_missing;
+};
+
+static int maddr_dump_filter(struct nlmsghdr *nlh, int reqlen)
+{
+	struct ifaddrmsg *ifm = NLMSG_DATA(nlh);
+
+	ifm->ifa_index = filter.index;
+
+	return 0;
+}
+
+static int accept_maddr(struct nlmsghdr *n, void *arg)
+{
+	struct maddr_dump_ctx *ctx = arg;
+	struct ifaddrmsg *ifm = NLMSG_DATA(n);
+	int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*ifm));
+	struct rtattr *tb[IFA_MAX + 1];
+	struct ma_info *ma;
+
+	if (n->nlmsg_type != RTM_GETMULTICAST &&
+	    n->nlmsg_type != RTM_NEWMULTICAST)
+		return 0;
+
+	if (len < 0)
+		return -1;
+
+	if (filter.index && filter.index != ifm->ifa_index)
+		return 0;
+
+	parse_rtattr(tb, IFA_MAX, IFA_RTA(ifm), len);
+
+	if (!tb[IFA_MULTICAST] ||
+	    RTA_PAYLOAD(tb[IFA_MULTICAST]) > sizeof(ma->addr.data))
+		return 0;
+
+	if (!tb[IFA_MC_USERS]) {
+		ctx->mc_users_missing = true;
+		return 0;
+	}
+
+	ma = calloc(1, sizeof(*ma));
+	if (ma == NULL)
+		return -1;
+
+	ma->index = ifm->ifa_index;
+	strlcpy(ma->name, ll_index_to_name(ifm->ifa_index), sizeof(ma->name));
+	ma->addr.family = ifm->ifa_family;
+	ma->addr.bytelen = RTA_PAYLOAD(tb[IFA_MULTICAST]);
+	ma->addr.bitlen = ma->addr.bytelen << 3;
+	memcpy(ma->addr.data, RTA_DATA(tb[IFA_MULTICAST]), ma->addr.bytelen);
+	ma->users = rta_getattr_u32(tb[IFA_MC_USERS]);
+	maddr_ins(&ctx->list, ma);
+
+	return 0;
+}
+
+static int read_maddr_netlink(int family, struct ma_info **result_p)
+{
+	struct maddr_dump_ctx ctx = {};
+	struct ma_info *ma;
+	int err;
+
+	rth.flags |= RTNL_HANDLE_F_SUPPRESS_NLERR;
+	err = rtnl_mcaddrdump_req(&rth, family,
+				  filter.index ? maddr_dump_filter : NULL);
+	if (err >= 0)
+		err = rtnl_dump_filter(&rth, accept_maddr, &ctx);
+	rth.flags &= ~RTNL_HANDLE_F_SUPPRESS_NLERR;
+
+	/* Kernels that dump multicast addresses but do not report the
+	 * users count via IFA_MC_USERS cannot replace procfs.
+	 */
+	if (err < 0 || ctx.mc_users_missing) {
+		maddr_clear(ctx.list);
+		return -1;
+	}
+
+	while ((ma = ctx.list) != NULL) {
+		ctx.list = ma->next;
+		maddr_ins(result_p, ma);
+	}
+
+	return 0;
+}
+
 static void print_maddr(FILE *fp, struct ma_info *list)
 {
 	print_string(PRINT_FP, NULL, "\t", NULL);
@@ -291,12 +380,25 @@ static int multiaddr_list(int argc, char **argv)
 		argv++; argc--;
 	}
 
+	if (filter.dev) {
+		filter.index = ll_name_to_index(filter.dev);
+		/* an unknown device has no multicast addresses */
+		if (!filter.index) {
+			print_mlist(stdout, NULL);
+			return 0;
+		}
+	}
+
 	if (!filter.family || filter.family == AF_PACKET)
 		read_dev_mcast(&list);
-	if (!filter.family || filter.family == AF_INET)
-		read_igmp(&list);
-	if (!filter.family || filter.family == AF_INET6)
-		read_igmp6(&list);
+	if (!filter.family || filter.family == AF_INET) {
+		if (read_maddr_netlink(AF_INET, &list) < 0)
+			read_igmp(&list);
+	}
+	if (!filter.family || filter.family == AF_INET6) {
+		if (read_maddr_netlink(AF_INET6, &list) < 0)
+			read_igmp6(&list);
+	}
 	print_mlist(stdout, list);
 	maddr_clear(list);
 	return 0;
diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 8905e297..edf3a8ba 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -336,6 +336,32 @@ int rtnl_addrdump_req(struct rtnl_handle *rth, int family,
 	return send(rth->fd, &req, sizeof(req), 0);
 }
 
+int rtnl_mcaddrdump_req(struct rtnl_handle *rth, int family,
+			req_filter_fn_t filter_fn)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifaddrmsg ifm;
+		char buf[128];
+	} req = {
+		.nlh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg)),
+		.nlh.nlmsg_type = RTM_GETMULTICAST,
+		.nlh.nlmsg_flags = NLM_F_DUMP | NLM_F_REQUEST,
+		.nlh.nlmsg_seq = rth->dump = ++rth->seq,
+		.ifm.ifa_family = family,
+	};
+
+	if (filter_fn) {
+		int err;
+
+		err = filter_fn(&req.nlh, sizeof(req));
+		if (err)
+			return err;
+	}
+
+	return send(rth->fd, &req, sizeof(req), 0);
+}
+
 int rtnl_addrlbldump_req(struct rtnl_handle *rth, int family)
 {
 	struct {
-- 
2.43.0


