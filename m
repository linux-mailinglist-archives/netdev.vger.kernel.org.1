Return-Path: <netdev+bounces-261135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEIGMp6yn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:40:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4582F1A02A7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25C9830DFEDE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1637998A;
	Thu, 26 Feb 2026 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mkqms7+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764237AA8E
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073419; cv=none; b=ElumBaSKRuP+cWq5h7tyOAhm40023qKgAUWWsQCNOQ3TgMIcLsok0j6IwtkJhRfrqtGuUbHlLz3iudOVuKsovaN4iC7ULz3ctBaGo/2P2yjdUXe+PlXtfv9t0C+Ok8vp1oIRo/N82PV5J/Fve1l7AoaHPvIR+svgurDY0W0JXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073419; c=relaxed/simple;
	bh=0PdYj2QjbzgEChqwpO7lZ5YuHU9i/QHLpnlxc0Sdjwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eyeAsIEmbZHvyDLpL1FSTCF+BiOyOhIGOKYcvRayJ5wPF/07zGN6yUpD0b5gVnlUNRda7AYZ/GPeUglWHKC3UBmadJgobXPPPqFUsOImbLm7aYYraLZ8nOxbJEsSvsg3bfMGLtMmLwwOWJeYA+HBBaa8ZlASFPhFOiO4/AwJ8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mkqms7+7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso278576a91.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073418; x=1772678218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey75qwJrTuuFgs9YE+SFX6mmLeaf++1LiFklPUiYyTs=;
        b=Mkqms7+7DFTJJaO9IMllDaPDq6nVm04zrheOfMY/VHfo3MO97aYeNLNys/MpzvSTi8
         vorZdAc/mraf6x/i8iGz+2atcai7r2CofPtfLBwZdXFL7+edKaeaOF22jhmBZZ/8LdqN
         YIWLza7nb2j4C4Q//0mJyLBs0+YmnLpw9VweonpXYxxOci0VcUnggJ+ofWlDa0CxlCOW
         x+R0wNeoZHMr3v/0CYT/zx2OAQNjsM776X+z1CTlnfejWueZ1cMw6iiYYIoO3Idr/cqR
         PNOXpIUMQ95R1grfjFXwU0RfdgG+ZQ+y4JtDtJs33EfzSe1hL/AUjCaPD4Sa7bQfD9aD
         /X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073418; x=1772678218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey75qwJrTuuFgs9YE+SFX6mmLeaf++1LiFklPUiYyTs=;
        b=jwXDGQhojAMbzLuIp3zTN0F6nAdBGTF8c4bTXj9cVmtblfbdAyY3YqBMpfGStrHWCP
         9ZOTIHUIpsetFErVFLgz1gBv592oXZAqj3l2I2xCoIjBb8KaUN3XGglYdqJPBJTKjQcm
         cxeibJCHW8BjrhAGM87BS8BGAzaZOydcD/hwE2DfGMFW6VC045Rculv4QZLvSoQGcC9F
         DC861zs1tHXnZq/JthBHC9YRg0pQhWPTzK13yI+LTO0XOesQbMWzzH0JchcPMvbmEtJk
         epupxxo5y0//KWUyx7+9zHSd2Y/VfQzOSj2iBz01l56x+vI4N/+cbgVVMYWvgPAYOnVj
         VN+w==
X-Forwarded-Encrypted: i=1; AJvYcCVt0R8EVcBLDnSekhA48YcAEsvNG+oy8GHxEycZZM1d9v1FjEeQbSnEsZu5mm2f5+2Xkyvv8Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmfCkyK1u8krHgJ9NHSvZf2oU1GIxPdg3PvPrci9D2SaXhzWKu
	cbnLwe/zD692C25OLuBMdoHlMc/n0sYHS89kghTPGVrcd5zzs0T+uLy1A+Ws973QAEMLyZ91A6A
	lcTJqDA==
X-Received: from pjzp17.prod.google.com ([2002:a17:90b:111:b0:352:c761:3cf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3949:b0:359:1821:b4d5
 with SMTP id 98e67ed59e1d1-3593dab8402mr576793a91.5.1772073417946; Wed, 25
 Feb 2026 18:36:57 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:23 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-12-kuniyu@google.com>
Subject: [PATCH v1 net-next 11/15] ipmr: Call fib_rules_unregister() without RTNL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261135-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4582F1A02A7
X-Rspamd-Action: no action

fib_rules_unregister() removes ops from net->rules_ops under
spinlock, calls ops->delete() for each rule, and frees the ops.

ipmr_rules_ops_template does not have ->delete(), and any
operation does not require RTNL there.

Let's move fib_rules_unregister() from ipmr_rules_exit_rtnl()
to ipmr_net_exit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 537be40af9e0..0dd683932d2b 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -282,6 +282,11 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return err;
 }
 
+static void __net_exit ipmr_rules_exit(struct net *net)
+{
+	fib_rules_unregister(net->ipv4.mr_rules_ops);
+}
+
 static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 					    struct list_head *dev_kill_list)
 {
@@ -291,8 +296,6 @@ static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 		list_del(&mrt->list);
 		ipmr_free_table(mrt, dev_kill_list);
 	}
-
-	fib_rules_unregister(net->ipv4.mr_rules_ops);
 }
 
 static int ipmr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -348,6 +351,10 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return 0;
 }
 
+static void __net_exit ipmr_rules_exit(struct net *net)
+{
+}
+
 static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
 					    struct list_head *dev_kill_list)
 {
@@ -3284,6 +3291,7 @@ static int __net_init ipmr_net_init(struct net *net)
 	remove_proc_entry("ip_mr_vif", net->proc_net);
 proc_vif_fail:
 	ipmr_rules_exit_rtnl(net, &dev_kill_list);
+	ipmr_rules_exit(net);
 #endif
 ipmr_rules_fail:
 	ipmr_notifier_exit(net);
@@ -3297,6 +3305,7 @@ static void __net_exit ipmr_net_exit(struct net *net)
 	remove_proc_entry("ip_mr_cache", net->proc_net);
 	remove_proc_entry("ip_mr_vif", net->proc_net);
 #endif
+	ipmr_rules_exit(net);
 	ipmr_notifier_exit(net);
 }
 
-- 
2.53.0.414.gf7e9f6c205-goog


