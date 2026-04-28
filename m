Return-Path: <netdev+bounces-281798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLG8BESX8GmrVQEAu9opvQ
	(envelope-from <netdev+bounces-281798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:17:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56441483806
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A5B431588BB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1E3EF0D6;
	Tue, 28 Apr 2026 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5n5Pa6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7E3EBF23
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374444; cv=none; b=BFY7jl7R+KV//NmnGItj0nl1VyU6hrr3iRfBxdaqKXsAR0jI6j9wZftpG//mK2mZsOuZ0+e4PK1dge7C1rrXSBDnowbdbjY6vyZCJofYdIL7hFZXOhVKXb3NSie2wAPHjBju10ohhwF20r0RVEJUM4fkYpc0AGPJxq6G9pV48JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374444; c=relaxed/simple;
	bh=NjtDbOnnEO86ejPTIN4uLHWLgBUoL1OSud1GczR0dAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mfQvPk0T73AL6D8rtRugF2J5mV1//Ji3fq4GCcNh9Ka0TBwLu/KMBwElGmhudgoMcYlKKIFmrZC5gfFxzRAmG5F6rXV46TGSYEDsnqT6r0OFoccCy1Uaj3adLVpS8D1xJrM2R7VT7d9VN+/F/3Ta+cxiuGXLuZg13gPqWx7kTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5n5Pa6l; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c796163fac5so6954347a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777374439; x=1777979239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5gnbIk61J7ja47fuHsFudG56ejf8vLTSwMTzZTnrdk=;
        b=P5n5Pa6lAKroFCMbDkm33qbTSyeMJRlas8iPNwU2wK9sKNFbBbJAfzragLyGOMedOs
         h0pp9wPnYK7/vG8NNTHA6xMopP9aFsD4RRf4sHdjSWUQWBl3ArsL2ePRio69f1/5tRkS
         8zrGHr3IMr3CAqtElvwOUOztxV4lAElnX2iyUVFt+V1OBSL27pSn4o3scnL8SM96nfEV
         oj3OLbid7kjCSJzW4pNTqSTA6n/7Z2d1GqPwnw4OCX9r9NZtwQYAgEmKUFrdDJdeUV9A
         3vqREdr3ghvf1dV6//Sdph1iv5gsQ5vdFgI/hF5cSexm0k5/eNT09AxXYdC+diQq8JOC
         2GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374439; x=1777979239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5gnbIk61J7ja47fuHsFudG56ejf8vLTSwMTzZTnrdk=;
        b=ZYz6XBvWPYQfkBm02jDU4+PGJxc0NoTkECOFwvp0eGxpd+8CzpMwmQ6/AvcSF9rHkc
         E3biXz+LqQdhSCuQChcNkO/lo3vfJweAH8+ekGK3lhGKfUXzfbGY9A2LWT2yJjzsgU4s
         q2OeZhjBTxoidB5rwiqsxT8Jd26yb/yWf/CHi7i0mieShdXNM9lP+KLikna0W6PPhU9c
         /UsA1raAHM6tjE2UQVayp2k18mkg6CehHMbarxiN7SQVv8PexZCdMXDqglIWjhSrRDCb
         7fC3Rh9Kz3hGADmUm1QQXr7k7jgdkclrV6JmZL4jjrbOWeKEysqce5gr+WrmlIdsTXTr
         cfNg==
X-Gm-Message-State: AOJu0Yy0kaj9Z1MfNTGSPrNeNCtsMJOMI2xZNUnmxhTWvqGaZbAEb1S0
	gGgUE2c0WSVjGUFWmYUHy/ry5LRGdvqkCVCm4JDWWfa+wMK1NZIHqR27pSkz+RE4
X-Gm-Gg: AeBDieuFiPxBDDZcUTSt4Z2RRfcG4q5dLG/GzhWJ4RU0Qk4tBwgcQ27Xhtx33d6b1fs
	rHhp3PPrX4bqo0FFii5O5rwbHSHHSukte/pXEmRmQ8EMg3p3P92uP3ARjJPYJMHJjy1zsgH8VPD
	4XyiVl9eoRmN7IR/9TEzCESNWjItUzrxuvEWFf+cVxAOs9ux7U3+2kLuX1G5KQRpXzE+68fspOo
	dJQsduyURgJYxgRZE4XxpiTsRS+zEmWMcJSXhiDxtUg9uao1wdn0hF+RuAc3P7COYT8TmsX9tul
	KLpjQWTQMFyLLStu47F9It2llQOLw+WSylmaqy/zku5jaIy7xXa5Min1+hFGv6W9a8zgWiO1ir7
	HxtHVKV4BVwZBJ1+7UKlhD6Ca+zbq3r+d8HJQSrzY3xsL3175G6wn927RG7iNd5/X5qxDcSRXCi
	leyp1h8t7EITHJBHvVrVmqEW2bUxZzUfqcTFGqxI1lgLGZBEvJ52SGic4ndnE=
X-Received: by 2002:a05:6a21:3086:b0:39b:e321:784f with SMTP id adf61e73a8af0-3a39c34ad7emr3383963637.40.1777374439315;
        Tue, 28 Apr 2026 04:07:19 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d4e11sm2023328a12.24.2026.04.28.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:07:18 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	shaw.leon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: [PATCH net 0/2] ipv6: tunnel changelink: use cached netns pointer
Date: Tue, 28 Apr 2026 19:07:11 +0800
Message-Id: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 56441483806
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281798-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

This series addresses two slab-use-after-free reports against the IPv6
tunnel changelink callbacks vti6_changelink() and ip6erspan_changelink(),
both reachable from an unprivileged user namespace and verified on
Linux v7.0 with KASAN.

Both bugs are sibling misses of commit 5e72ce3e3980 ("net: ipv6: Use
link netns in newlink() of rtnl_link_ops"), which migrated the
*_newlink callbacks for vti6, ip6_gre, ip6_tunnel, sit and ip_tunnel
from dev_net() to link_net but did not convert the corresponding
*_changelink callbacks. As a result, after a device is migrated via
IFLA_NET_NS_FD, the changelink path looks up the per-netns hash in the
wrong namespace, leaving a stale hash entry in the original creation
netns. The next cleanup_net() of that netns walks freed memory.

Patch 1/2 was authored by Kuniyuki Iwashima during the security
disclosure thread; it converts vti6_changelink() and vti6_update() to
use the cached t->net.

Patch 2/2 applies the equivalent conversion to ip6erspan_changelink().
The non-erspan sibling ip6gre_changelink() in the same file already
uses the cached t->net correctly.

Both bugs were originally reported on security@kernel.org on
2026-04-26 and triaged with Kuniyuki Iwashima and Xiao Liang. Posting
publicly per standard practice once the technical fix shape is
settled.

The bugs are present on all maintained LTS branches (v5.15, v6.1, v6.6,
v6.12, v6.18) with byte-identical source, hence Cc: stable@.

Tested with KASAN reproducers (unshare --user --map-root-user --net,
RTM_NEWLINK + IFLA_NET_NS_FD migration, RTM_NEWLINK changelink in
the migrated netns, then teardown of the original netns); without the
patches both reports trip within ~2 seconds, with the patches the
reproducers complete cleanly.

Kuniyuki Iwashima (1):
  ip6: vti: Use ip6_tnl.net in vti6_changelink().

Maoyi Xie (1):
  ip6_gre: Use cached t->net in ip6erspan_changelink().

 net/ipv6/ip6_gre.c |  3 ++-
 net/ipv6/ip6_vti.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

--
2.34.1


