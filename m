Return-Path: <netdev+bounces-252570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE0NJuDLcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:16:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 007EA6EF47
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67BA4301016E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFEE31B81C;
	Fri, 23 Jan 2026 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeRryTVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C4337111
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130931; cv=none; b=X0tC2YhFbd3PryMaAaeroWiVScdWNBMh72cUyhEx2O1tHsEHy2ccCc/1gk+golKMPtfw42+T3uT7vpp6UGc4HS0/PH4J0LhLEGjLvHMBwlbiSPCBnnSWCf5Qy/JvZp+XKtMLUuvuBCccRN4Drkc+M0zSBQvdpdhfFRBEIFgJRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130931; c=relaxed/simple;
	bh=gIH5qfA5AoXyWmtDMjbV69xS6bzI8RoKE7RZKzgs4nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVMMJOsSouTpjSQRGaZPSo1U5QKa78FhWn/P8HFSQuOIuQO79giALI6ejos86B73M7h+f6rPMnC/rKcIiUgY6PTEmt+K4IlCz70Xx8inJnyWAm1LiruUlt/y788hccLaF1GyK2oSx8h+FpstjKZ0QpOqWlbyDjSJuu8F6U3pP3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeRryTVV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a76f90872cso8914975ad.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769130924; x=1769735724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PExmS+XqEykLWLrYOMzWy5MTaT6ZAIKFuYbZQQhQkzQ=;
        b=TeRryTVV1QyVICeCtzPaXc7lUdyEo4pWRGCJX1SRCrXl6eId5yuxqqQbnkYJbvXoMI
         I0+gGmaHF9BHw5yXvrNnsxgyio6MrjWIPc0WmRM3emAUSfpRj8hWk5jdwpNDXYcqMNYr
         pd49Ga295QZ3RzGLv/2/cyydXPOAQFz0Ruuygl9wLUeivnLFPQ19bLBrfZMDqtdXWAgQ
         zUY/p/azgYuqtR6VywgwWtTYOLbsDhty5ebTyH1K6XW2eVPKwoRt4LpuEC5FMzBHcHah
         FBAGLDejbLoZCXhPjXzPnZ3k3HVK6al1h1Y2ivAcpn9v84g1Q9KmfqgpyGm07yNYJmPj
         0mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769130924; x=1769735724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PExmS+XqEykLWLrYOMzWy5MTaT6ZAIKFuYbZQQhQkzQ=;
        b=sDoWHx0MIOq1c8QqF3+r87Ii4/St0z9snBCbveqTGa2ppfVbyWsTf+phbHDL/+8RsK
         4NnkqylZgNAT4w/XBzewh7S0L8+QPT01g0jiYfLe4FVEsepI0RObeC1BPCuJh2Syghge
         d47Zqww2X3y4m5A2/PQGm624dldrIt/sZhKHpQUVwrIUNnzMzvYOu0bThy17kIRaPNdR
         Ye9VLbS2+8VJo1Yto1Xr5kwZQ1BQsPB0HzrPr0auBYQ6LzufJGfFMGlibF0aeQH7NC9J
         vnWViVfLITRWYXYLYWJ7h/nOys9YoGTrudNiTUOTAmV5A8yxs1x/06ZnmSQuFeQ6Wuzv
         yS+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIYyJdMgyN0hkXqa8/RrjRlUZS/c5pc4gOTEp7xTYe4vycLqEH2QGg2BLHx3hYlosJs8ZOYh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gEJO/CCd5TF0USoAp54B5fI0Ahgc1CFbfaKvgPWck5FUiAY/
	WrjlrhHIdhRMQA/TAcS6TeMxvWWzTA69uret5prOn5r983lnpQE9Ljc=
X-Gm-Gg: AZuq6aJ/a7c1mtB3Fbn3xoM2I8SDjQlqxPTrW45fJxxnikFE++B/zaZIIJ7MHF9oyXd
	mJIkxsBpYA8DNt7SwHXJxJgWeJJIBtZEFsRglNU245RHU61rR1h4btUqzWMCuAdyfObg8f8M9W0
	y10W5GHPBYMb9vz2J3srsbrXrJt6HdACd5S4zlPj1F5cxVnJkq1DklW4Sxia+jgS/nZeSxslktT
	jhELgfC/Ku/zzowIVNdg8oi60trvRwIZBAlEI30AgXaxUfyucvsW0v4RDoEaTyiGHW51PqMKXFJ
	hF5LG93PKJzIptxk4RCSYTuqQ4Y87lfte5W1z1ybOJL9xNSyAAbccSXWlow0AMEpv2vc16g+YPY
	eh1s9IHPF4IByxL5mdnBw2VC+463QEQBl0Ot3ee0GejrxPA4NkOjPMtQYEC2qYt+wn8XJzCN3DS
	2SN0Qv2ipmY+PMuvE=
X-Received: by 2002:a17:903:3583:b0:29f:1738:348e with SMTP id d9443c01a7336-2a7fe571d3dmr11807365ad.15.1769130923801;
        Thu, 22 Jan 2026 17:15:23 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f97a81sm3989745ad.47.2026.01.22.17.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 17:15:23 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	kaber@trash.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] ipv6: ip6mr: check socket type and protocol in ip6mr_ioctl and ip6mr_compat_ioctl
Date: Fri, 23 Jan 2026 09:14:45 +0800
Message-ID: <20260123011444.2044-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,trash.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252570-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qikeyu2017@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 007EA6EF47
X-Rspamd-Action: no action

commit 99253eb750fd ("ipv6: check sk sk_type and protocol early in
ip_mroute_set/getsockopt") fixed the issue for ip6_mroute_setsockopt()
and ip6_mroute_getsockopt() by checking socket type and protocol
before accessing raw6_sk(sk)->ip6mr_table.

However, ip6mr_ioctl() and ip6mr_compat_ioctl() were missed in that fix
and have the same problem: they access raw6_sk(sk)->ip6mr_table without
first verifying that the socket is a raw socket with IPPROTO_ICMPV6
protocol.

This allows a permission bypass where a user with CAP_NET_RAW can create
a non-ICMPv6 raw socket (e.g., IPPROTO_UDP, IPPROTO_TCP, or any other
protocol) and use SIOCGETMIFCNT_IN6 or SIOCGETSGCNT_IN6 ioctls to query
IPv6 multicast routing statistics. This bypasses the access control that
restricts mroute operations to ICMPv6 sockets only.

For example, the following would succeed on a vulnerable kernel:

    int fd = socket(AF_INET6, SOCK_RAW, IPPROTO_UDP);
    struct sioc_mif_req6 req = { .mifi = 0 };
    ioctl(fd, SIOCGETMIFCNT_IN6, &req);  // should fail with EOPNOTSUPP

While the direct security impact is limited to information disclosure of
multicast routing statistics, this violates the intended access control
model where only ICMPv6 raw sockets should be able to access mroute
functionalities.

Add the same socket type and protocol check at the beginning of both
ip6mr_ioctl() and ip6mr_compat_ioctl() to ensure only ICMPv6 raw sockets
can access multicast routing ioctls.

Fixes: e2d57766e674 ("net: Provide compat support for SIOCGETMIFCNT_IN6 and SIOCGETSGCNT_IN6.")
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 net/ipv6/ip6mr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e047a4680ab0..35f941861008 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1906,6 +1906,10 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
+	if (sk->sk_type != SOCK_RAW ||
+	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
+		return -EOPNOTSUPP;
+
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
 	if (!mrt)
 		return -ENOENT;
@@ -1974,6 +1978,10 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
+	if (sk->sk_type != SOCK_RAW ||
+	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
+		return -EOPNOTSUPP;
+
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
 	if (!mrt)
 		return -ENOENT;
-- 
2.34.1


