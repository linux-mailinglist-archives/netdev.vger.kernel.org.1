Return-Path: <netdev+bounces-290750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNRCHQ4lEGoYUQYAu9opvQ
	(envelope-from <netdev+bounces-290750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:42:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA35B162F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07919304B89A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3E3A7F78;
	Fri, 22 May 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXiy0TE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6373BED7D
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442754; cv=none; b=ia5SuIbZCNdl5/Dnx7hKdr07CrSduNWtkKusF3lTzYjDqzWil+/h8HynGZSC9bFd1jkCClPkhgbE1tJCOPbx5mRzXdyiIWsDkP2504c2I/0rxMtteZvsbHACpBCY8Hp6+0cbpUlD/MuA+mCtiYklHCZeMTok2ZGZbDhQuhNY2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442754; c=relaxed/simple;
	bh=5QGYs42lyFwntdmixcH6+eNnje4QIYhJJDtxvLMqdSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIjFJWHuJXp2v+5JR5uS7z8qfnXKGZr3Vwd8CFEaoq2Ow08+1tZMJVgb6eCRwnNB0FHV2J2j95ualSScUM0GwaHhv2d6D5mpSp1jxcISGTd3ayuJY/rdbSKn6o/yYbCH7S1T3Z6h658IUm/6uhDleP19s6IiqmrPt9oL9Y1nH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXiy0TE6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-367c26471f5so4522030a91.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779442752; x=1780047552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGjuCeQt6QetUshdYR+q3g5AvWut7tP0yHLeANA3bjE=;
        b=QXiy0TE67UlIjrhao50ZCpavmQg8gGr2y7XcZq53YHdixWhw9hbgv/Jp2kZxmQpgYV
         lH/TNEIw9vkie+W3rSFhQs4b9iQMopa5Kg9P7K8l9b3TG8MGzTg75i2P3SkCXxB+Wzv/
         vN8dfgXygaZ34adpnlm4KA05m/yTnUkts12ymNWgUYgsxFNMTHnkFLjQLDPT42lyMdSs
         sAQILWkOxE2iSEFh7p5Csy9+2GaGSMVnz22Y6I/ylj+n2LQyrHou705IKjVPmCJ2mTM1
         qXEa2xx2MquTtEzpfURpfBLYQWKyuyd6MkiJZooMyEKTxMwxKaxV63+dWHiusWwSfdyV
         /Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779442752; x=1780047552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGjuCeQt6QetUshdYR+q3g5AvWut7tP0yHLeANA3bjE=;
        b=IG5iKNTd+RlL5dwkCtX+QJadIsFU5i+zNRR3Tm3zWVx48eOCKHVJYvjsLcCWaP9Hix
         zYy9LOfY6vlz91ipVMS8wuLLjAY9OqDhYq2L3QM7d+SFFQATXnZYc8u/cYKzpP9Gn1pB
         M86oIjik5S80cmMnjTdOq6/7WgZu0QA4kCY3bwpINrefgdA8tpu7JCTtDMotCuvvGsgt
         RxFNumMKq02oS3brfYbVBN322DGxwLH/MGXO5Vc3ogC61LsI5WZqnL33txreEhVzgF1V
         gWLI4sg8dxM7M4dPU8K5+iDFP5eJDPhsvAUE0LvzXcUDElp9ePzPqpcLYjcMbVzEO8KN
         AUFw==
X-Forwarded-Encrypted: i=1; AFNElJ993FRptLkw/wQois6tdTR9i+JeVqGjicGb7oMgRLz4x7Fq0BM26SYqJNDlfFKbD1iug0zRBtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywne08r1oCwjR+mSZ0igoDu/EX0l2NjpAs8ytHda1LcXwnIAa9V
	/AxctXj0TF5lc2HMDnrV9A19w6YFpB37hJZchP4Ble1SwMhoSZ8bIEK5
X-Gm-Gg: Acq92OFPeKpchzDqc4911TiFnxl3tx5pB9wIqCx4PUInL40QjuigZE3ZrkrgLTUeHe2
	THwTeXDiQY+c454OAhq+DLCK9Fus5ZS5EKZHNcLYNK0GgPBDdb9aS2uRV2bM14xBkpQ/OUamw65
	qvdGdUwSCqQDHftMueAn0ykI0FJFqJTHAofC1JvVaEI8Yolk94GXBciWoKzKusEzAmy4Hm45EV+
	Y8oNi0+tqyklaqJfAxHPQQNYHdiVxASP6YxGIQYRM9qJvnoAmCrUQtYKl/3KeOy9Q5/a/9zB1Id
	8toNenxVM8k436xKu86yFSPr8NkuR/9Obg5vkZZbVmRtCV5Lgew9qXE5j3PSCbEXSFd9v7kzPVj
	KFnwIKmrckKb7yVotWTKWTakhK678BswLYJoeZavxoYhTaCVWdqLp9s9b+BGhLPvXHgTU9MUVLb
	8zyjBgH3d9hn+rsdLujdhiP4lzLYYGWZRWxjYkeNoufN9X81o6Vfay
X-Received: by 2002:a17:90b:4e84:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36a676f0614mr3005668a91.3.1779442751819;
        Fri, 22 May 2026 02:39:11 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:24b2:bbd8:eef:e038])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6ec5a287sm871668a91.0.2026.05.22.02.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:39:11 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] ipv4: igmp: annotate data-races around im->users
Date: Fri, 22 May 2026 18:39:06 +0900
Message-ID: <20260522093906.39764-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-290750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E8DA35B162F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

/proc/net/igmp walks IPv4 multicast memberships under RCU and
prints im->users without holding RTNL, while multicast join and leave
paths update the field while holding RTNL. Annotate this intentional
lockless snapshot with READ_ONCE() and the matching writers with
WRITE_ONCE().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
Changes in v2:
  - Added Fixes: tag

 net/ipv4/igmp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 27d120183779..f2aca659b29c 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1541,7 +1541,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
 	}
 
 	if  (im) {
-		im->users++;
+		WRITE_ONCE(im->users, im->users + 1);
 		ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
 		goto out;
 	}
@@ -1550,7 +1550,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
 	if (!im)
 		goto out;
 
-	im->users = 1;
+	WRITE_ONCE(im->users, 1);
 	im->interface = in_dev;
 	in_dev_hold(in_dev);
 	im->multiaddr = addr;
@@ -1784,7 +1784,10 @@ void __ip_mc_dec_group(struct in_device *in_dev, __be32 addr, gfp_t gfp)
 	     (i = rtnl_dereference(*ip)) != NULL;
 	     ip = &i->next_rcu) {
 		if (i->multiaddr == addr) {
-			if (--i->users == 0) {
+			int new_users = i->users - 1;
+
+			WRITE_ONCE(i->users, new_users);
+			if (new_users == 0) {
 				ip_mc_hash_remove(in_dev, i);
 				*ip = i->next_rcu;
 				in_dev->mc_count--;
@@ -2977,7 +2980,7 @@ static int igmp_mc_seq_show(struct seq_file *seq, void *v)
 		delta = im->timer.expires - jiffies;
 		seq_printf(seq,
 			   "\t\t\t\t%08X %5d %d:%08lX\t\t%d\n",
-			   im->multiaddr, im->users,
+			   im->multiaddr, READ_ONCE(im->users),
 			   im->tm_running,
 			   im->tm_running ? jiffies_delta_to_clock_t(delta) : 0,
 			   im->reporter);
-- 
2.43.0


