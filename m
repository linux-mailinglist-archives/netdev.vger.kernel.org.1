Return-Path: <netdev+bounces-300519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SVI1Ib03NGpiRwYAu9opvQ
	(envelope-from <netdev+bounces-300519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:23:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3286A220B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:23:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jrife-io.20251104.gappssmtp.com header.s=20251104 header.b=YRid3r6h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300519-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300519-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E4F030E78CE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86627389DE0;
	Thu, 18 Jun 2026 18:20:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AF37DEA4
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 18:20:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806846; cv=none; b=HshCcsyUH8uxb+EfalX1qaMBZBxjolISfh78BeTZa1jTCU4TQhrFljQu0Xum+Rmsic6QeEtZlO5LvqtFys0+jvapgupxs2+oEKw4NxhSgZS89dWRlup4hhRHAQEPlr4E7y4hyq6ZENdLoVSxFV5ogANLuRQUT0+VnQ2W8RI8MFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806846; c=relaxed/simple;
	bh=8TW8CEh4uQDl1LPXXMpeWiZOcVMOrk56iUojbRyb1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3hMLrNbbjlLvLKV/BHsTfarRDnrCqDzm5BNib1LKzjBxGUjHvY3Y/fpFVA5tPsJjpHDxaeU0JOuQtnksyy7oIRIjkwmJbnQFOv8SiILCjn8/P+J2oKvtG5i2udthEpzIWgQwJiAHx8n03GtSVh/ZFG6NLIkpvTwtApy8w+bfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=YRid3r6h; arc=none smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bda2cb796so73730eec.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781806841; x=1782411641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT2oq9gTrDaMMkE1yXo+V+1LVar+mTuItHPxWSCdycE=;
        b=YRid3r6haC34T3h3ix0fuq0b6t1xGEIu+O+SAUeJOhLE3u4HEr3NSCgNzXtmh0Jcqu
         xjQtKgdAWmAH6D1Hp2aRR8PT+8V7EjGFuheBP78oAP9yYBlKNc3OcyAxADdIxpuymG1B
         cO1DQ9aC/43Tx9KTP/sIwIUxM3GfGSZYfYwLChjwgegscNq6AZQLwOQ7xOw5AWeVVSIW
         VPoYYbEtJoeA1eZPyM9tFf2SFzyRbIe/zH+Yw8DSfuTWhYWuJR7iPj3XzUCOg82GjQ6M
         F9ANsXkAOYjD62f27YZ8EXYrDiDogiEfUXM8KHm6e6cQcRwzHtI5Fd/3JcMrWhj8qSlr
         eKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806841; x=1782411641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BT2oq9gTrDaMMkE1yXo+V+1LVar+mTuItHPxWSCdycE=;
        b=k9jDAYgHkeFIBjIwwqEpmoBabk0pVL9IGiBfKGb4HkWtzReyWTaC14zqEUPAu5gOE7
         hlXRoE6HrYo4vpILbEcW/r8DUBByHLB+vpWFZJwblyEm4Gv4v6Y5lzDtNGvJmzkOjzrq
         LsGgKKZdYYl0aFvNliTjqSZi/yar3KvylDyfa1JCUoXAbJrsceB6PzGGpx7aGsGW/+e5
         ig6W+ezRWzLUqvH9yG3VB1ado02Ghx+SJd7mXBUgQBkmNk8eX4UzQ87mHRBvBA5zvvLU
         pGlSLO1fSG5qpQ3UcLmBfofdCepVcBGosW46zf9qW+Tl0vSZDfI/3ruF+iOA+njjiXYi
         nYPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Dhm5tqnynxLCwyYYeXuHgiUgp1D+o6Sh4g0EVjnwZ/gu/MxhKhrC6sXykmGH+LkYeRWNFg1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchyQK0exDTffrY9KfA9p3jlUumEPTUYRzaFkuw73we4n+LIp8
	346fuKMx8cp07BDokL2z2RbkG8os+x39dqBsgZ6nLAtuR4BGX2mLc8+0oqLN5b1NfP8=
X-Gm-Gg: AfdE7cnV1Vyrw2oudpacHC0uFWS0j1JFKsJQFcnsK7J/FhH1tVJcOPnx0lb5mcLW3sr
	8oCl25RfLNP2i9hy237rokdSH9IiPyy9ZtrOV70kZOFNf9/LQidouJhmgAqAVs1aq1QjWHQwVnn
	ymFWI+/C18RTpxTH+ZkJIB83K3vVg+iSFpWooEhUdIdvKGA74n9COnAv3jrTorTik+lyULrJwJW
	deS/psUDKZeIhtQG4YjYK7amVEgZSg1Qg69iLCHIQVqOu2BSyDrbyyPt9ggR/Il7M7dEaX/JBUd
	2RM0QwIMKqyFSojfbLJPeXFnuLNr1P8ecYk0gzmFUfcpDrkP2P+pLD1b5OnIhxk/koJMxam559z
	WJ+Iu/Xyxa9Rcn/BwsthLYEnGvOXmovnwm5mwRmj8iTPADL6ikzLqI9B/qY7+o1YUs4k/PN61Io
	Vb
X-Received: by 2002:a05:7301:4b16:b0:304:3c33:7afd with SMTP id 5a478bee46e88-30c06fea693mr160987eec.1.1781806841105;
        Thu, 18 Jun 2026 11:20:41 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:1b1d:38b6:64b7:ee72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06c33c88sm205950eec.19.2026.06.18.11.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:20:40 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_EGRESS
Date: Thu, 18 Jun 2026 11:20:33 -0700
Message-ID: <20260618182035.43811-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618182035.43811-1-jordan@jrife.io>
References: <20260618182035.43811-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jrife.io,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300519-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:jordan@jrife.io,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:paul.chaignon@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[jrife.io];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,jrife-io.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,jrife.io:email,jrife.io:mid,jrife.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D3286A220B

Extend redirect tests to cover bpf_redirect_peer(BPF_F_EGRESS). SRC
redirects to DST using bpf_redirect_peer(BPF_F_EGRESS) then traffic is
hairpinned into DST using bpf_redirect.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/tc_redirect.c    | 68 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_peer.c        | 22 ++++++
 2 files changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 64fbda082309..af8968b89ad7 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -192,6 +192,8 @@ static int create_netkit(int mode, char *prim, char *peer)
 	req.n.nlmsg_len += sizeof(struct ifinfomsg);
 	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, peer, strlen(peer));
 	addattr_nest_end(&req.n, peer_info);
+	addattr32(&req.n, sizeof(req), IFLA_NETKIT_SCRUB,
+		  NETKIT_SCRUB_NONE);
 	addattr_nest_end(&req.n, data);
 	addattr_nest_end(&req.n, linkinfo);
 
@@ -405,6 +407,24 @@ static int netns_load_bpf(const struct bpf_program *src_prog,
 	return -1;
 }
 
+static struct bpf_link *netns_attach_nk(const char *ns, int ifindex,
+					struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_netkit_opts, optl);
+	struct nstoken *nstoken = NULL;
+	struct bpf_link *link = NULL;
+
+	nstoken = open_netns(ns);
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		goto cleanup;
+
+	link = bpf_program__attach_netkit(prog, ifindex, &optl);
+cleanup:
+	if (nstoken)
+		close_netns(nstoken);
+	return link;
+}
+
 static void test_tcp(int family, const char *addr, __u16 port)
 {
 	int listen_fd = -1, accept_fd = -1, client_fd = -1;
@@ -1082,6 +1102,53 @@ static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
 	close_netns(nstoken);
 }
 
+static void test_tc_redirect_peer_ing(struct netns_setup_result *setup_result)
+{
+	struct test_tc_peer *skel;
+	struct nstoken *nstoken;
+	int err;
+
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns fwd"))
+		return;
+
+	skel = test_tc_peer__open();
+	if (!ASSERT_OK_PTR(skel, "test_tc_peer__open"))
+		goto done;
+
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src_fwd;
+	skel->rodata->IFINDEX_DST = setup_result->ifindex_dst_fwd;
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc_src_ing,
+		  BPF_NETKIT_PRIMARY), 0, "src_prog_attach_type");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(skel->progs.tc_dst_ing,
+		  BPF_NETKIT_PRIMARY), 0, "dst_prog_attach_type");
+
+	err = test_tc_peer__load(skel);
+	if (!ASSERT_OK(err, "test_tc_peer__load"))
+		goto done;
+
+	skel->links.tc_src_ing = netns_attach_nk(NS_SRC,
+						 setup_result->ifindex_src,
+						 skel->progs.tc_src_ing);
+	if (!ASSERT_OK_PTR(skel->links.tc_src_ing, "attach_src"))
+		goto done;
+	skel->links.tc_dst_ing = netns_attach_nk(NS_DST,
+						 setup_result->ifindex_dst,
+						 skel->progs.tc_dst_ing);
+	if (!ASSERT_OK_PTR(skel->links.tc_dst_ing, "attach_dst"))
+		goto done;
+
+	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
+		goto done;
+
+	test_connectivity();
+
+done:
+	if (skel)
+		test_tc_peer__destroy(skel);
+	close_netns(nstoken);
+}
+
 static int tun_open(char *name)
 {
 	struct ifreq ifr;
@@ -1280,6 +1347,7 @@ static void *test_tc_redirect_run_tests(void *arg)
 
 	RUN_TEST(tc_redirect_peer, MODE_VETH);
 	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
+	RUN_TEST(tc_redirect_peer_ing, MODE_NETKIT);
 	RUN_TEST(tc_redirect_peer_l3, MODE_VETH);
 	RUN_TEST(tc_redirect_peer_l3, MODE_NETKIT);
 	RUN_TEST(tc_redirect_neigh, MODE_VETH);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index 365eacb5dc34..cfb9ef7f467c 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -34,6 +34,28 @@ int tc_src(struct __sk_buff *skb)
 	return bpf_redirect_peer(IFINDEX_DST, 0);
 }
 
+SEC("tc")
+int tc_dst_ing(struct __sk_buff *skb)
+{
+	if (!skb->mark) {
+		skb->mark = 0x1;
+		return bpf_redirect_peer(IFINDEX_SRC, BPF_F_EGRESS);
+	}
+
+	return bpf_redirect(IFINDEX_DST, 0);
+}
+
+SEC("tc")
+int tc_src_ing(struct __sk_buff *skb)
+{
+	if (!skb->mark) {
+		skb->mark = 0x1;
+		return bpf_redirect_peer(IFINDEX_DST, BPF_F_EGRESS);
+	}
+
+	return bpf_redirect(IFINDEX_SRC, 0);
+}
+
 SEC("tc")
 int tc_dst_l3(struct __sk_buff *skb)
 {
-- 
2.43.0


