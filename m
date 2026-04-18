Return-Path: <netdev+bounces-279490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kR6cAbhw42m7GwEAu9opvQ
	(envelope-from <netdev+bounces-279490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:53:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4AB421054
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D193029AF3
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31CE351C10;
	Sat, 18 Apr 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Sibr8p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487F3446CC
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776512518; cv=none; b=pN7pX2luommwuDcX1PEdLdLDX4xBLIExdDCC7YEI8rojyN0EhhI4oBomuMd1/JII4JjLQWSUnTssLTBrmNkL9zbQHAL2m/lXzZxipqOyyIEq9F/xdItdbKR87w57m230OYOYzdaeEEGofoCUlbERdOr8G8iTYbSbks4E6xjQbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776512518; c=relaxed/simple;
	bh=azYuKobJHMocnVLpYPQCzIrwBdMbdZ3xLCQTUG7+zdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGkhu8cvwHEvkEQVFOw8ospMKJRI1WzzK8s9lCuK4Ldb0K8InqVjOMCQoKImBixSkpuD50BUr+WeiCVRh/ToiBmer39EGKo/YaloYRttdPlCwFYI4WmtuZ4uJVp/L1zQDWGRsX62COsnj1nx7KQXuTXqepBYUdFeRxKLlqqLwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Sibr8p; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2e622a9da9cso1935205eec.0
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776512516; x=1777117316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FBwq4gD1bEo3EkFOewwDd2AazgW/xP0JZQJa4s0yC7k=;
        b=i0Sibr8peUSaAOSEdfBAHCCClyrG124hmRiNeIxu8niqhLazgQyL6vY+/BTxCZHWt1
         GSVmBHgFoqxATbaVu6Y0K9hxhZFMMFAgD7aqTe/KQWCETwiPioMY7u46yzDCN9i+4y7Q
         pV500NhEfLReec/uJulBT9l54JqQihIN57dkvNhUZyYlrBQfrLfCAZGHfOIjc2AmNOLt
         P1zEbkbW4sPox1Njjsi5J9VaOUPxEQ7m/PNcHtk+R7WJlGDq5o7WQVdemOVQ41BO0CGe
         JuPlIqQGpAmmFIUJJmcHq7fhWu1cnFRYeWHDgzYIac1sRMmr/bs5CXoAC3QZTyf1nrYT
         XfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776512516; x=1777117316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBwq4gD1bEo3EkFOewwDd2AazgW/xP0JZQJa4s0yC7k=;
        b=o8P8AeBA6YAhRo+rplsEOjYKJAVBY2or0riO7OJGHC7oAfPwhXK0bwJuXQWWH/ctMQ
         mg0pzEcyp7uSpADpkLB8Iqr0TREaUZMFj19xKe44o9ZK8Q2dxdg+2B9BNr8jR1vG8lIf
         ICsr7q4Jhy7gEUkuWkb9XtZGX9Z9AiM8dSGlAOBQK3I44usJElugkq6v73HaMfvXWs0R
         ukFoYyVdeBAffdFRVaBonJYxQsw+nndoJouQ0kPQp0DUfxo1ZFzvt1jTpeJ6rc8796Hc
         j2IyizJ/PyByR46uh33ufsjodjZEKc702NNPuY5Zsf2PWV7pMuzdSQC3wdpDEQRZU1tJ
         IAcw==
X-Forwarded-Encrypted: i=1; AFNElJ+wMJD9lGSXcw0EG7MgW0qfkGo5W7XuGC7viGbBr7eSyMP6+lBZ9pzUfIpjpoo3Omo0lLACsjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznkD9jxZeNaXsBmO/iBANsxNrXteLB7egc+ADSxfoQvoN9ibZP
	6A41HS2gAgMr/pYBXBXMnYnCFOIbqTXwomw7hVMyKotVNKczYBjdQ10H
X-Gm-Gg: AeBDietxw6X3uBsUiXHjLA/kbDCQLr6KzkHyZmYKRcT8Qb2AC3tJ001Qktdnxi9Dhyu
	KTAC7RIZTQljHAi7HYtLxmpl6GGYO1yKKQzsBR+UQ+Keaf/QBggCJCJLjtwdJN/9WFOD1uRa0IO
	g7bDjpndnXmFq81jR5xnpehkfcPV+kPe3KkyH+PdRRenXeIJdvx8h5qDyszRaEJpymxiWh6Q6Mb
	uiyLIQlml/UDYsR/GHF5CxhSn1zNFYLuopMNZqO5jI1SYMzE45bF5KpZ+i5G2ertIJlWunGUyyi
	4gzD6hEoEuRR7tjL58kzbF+BRe46n2ZszPRKhKpLljlXMX50VYoOk4gqn6xIBtEZTm27Xhzmpfb
	zAm0QOlfgyO+cPiXKkmFU8b9DrGvvahglT+J9Yp9Y97pIl+lmwnrje2IYxUwbsWFJgg25ZlmScX
	kQEiYoUyqNTDH+dp8SR443YzljrmiJKd9937Qd8siFEhOvv6BpW7aOpEZJw0Y7jcm0pf149LjBz
	cFZUOFgJYew+QIn7qf5joVy/6Hu73U=
X-Received: by 2002:a05:7301:6085:b0:2e2:4979:eba with SMTP id 5a478bee46e88-2e465770d9fmr3277839eec.7.1776512516474;
        Sat, 18 Apr 2026 04:41:56 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm8162284eec.29.2026.04.18.04.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 04:41:55 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] vxlan: fix NULL vn6_sock dereference in vxlan_igmp_join() and vxlan_igmp_leave()
Date: Sat, 18 Apr 2026 04:41:12 -0700
Message-ID: <20260418114110.2602784-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279490-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.963];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E4AB421054
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

vxlan_sock_add() tolerates IPv6 socket creation failure with
-EAFNOSUPPORT (e.g. ipv6.disable=1), leaving vn6_sock as NULL while
successfully creating vn4_sock. vxlan_igmp_join() and
vxlan_igmp_leave() then crash when they dereference the NULL vn6_sock
for VNI filter entries with IPv6 multicast groups:

 Oops: general protection fault, probably for non-canonical address
      0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 RIP: 0010:vxlan_igmp_join (drivers/net/vxlan/vxlan_multicast.c:40)
 Call Trace:
  vxlan_multicast_join (drivers/net/vxlan/vxlan_multicast.c:195)
  vxlan_open (drivers/net/vxlan/vxlan_core.c:2965)
  __dev_open (net/core/dev.c:1704)
  __dev_change_flags (net/core/dev.c:9781)
  do_setlink.isra.0 (net/core/rtnetlink.c:3180)
  rtnl_newlink (net/core/rtnetlink.c:4238)
  rtnetlink_rcv_msg (net/core/rtnetlink.c:6921)

Skip the IPv6 multicast join/leave when vn6_sock is NULL, consistent
with how vxlan_sock_add() tolerates missing IPv6 support.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
  - drop sock4 NULL checks 

 drivers/net/vxlan/vxlan_multicast.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index a7f2d67dc61b..e6aa5ab1c939 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -37,6 +37,9 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 	} else {
 		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
 
+		if (!sock6)
+			return 0;
+
 		sk = sock6->sock->sk;
 		lock_sock(sk);
 		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
@@ -71,6 +74,9 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 	} else {
 		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
 
+		if (!sock6)
+			return 0;
+
 		sk = sock6->sock->sk;
 		lock_sock(sk);
 		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
-- 
2.43.0


