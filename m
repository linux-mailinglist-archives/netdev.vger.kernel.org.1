Return-Path: <netdev+bounces-112928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083D93BF18
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F138128131E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994016D4C1;
	Thu, 25 Jul 2024 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orex+vl2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030813A414
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899670; cv=none; b=XuxuPMFun6sEW9kg99krPt1wYxoxpli00ZnSZ/d1bU0slmML0ICmS39vb08p4hrJ2CPvXzjC8f50fuR/VwgOYAYXNaMdQqek2kLJxTcpjEhrBjDuhOjm7DQoCvlBqoROHjqnNpvRx1/jb2mAVKVfzRQu/mC0F35M8dx+Srzas7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899670; c=relaxed/simple;
	bh=Oz/eqxHFLc0T0d0Pi+Dn0ipwFbLMKxdnjOLY2TPKyH4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XJpylIYWi18VO3cX8ecQiypixv5gfrmR+nnvrQomy871ahk9zs23WM6Fw25cwj6I+WI9rOz+oNRMTAytPOL+BUULlUU+iXq9ApJKlsZQL9/Uk5cgAr5990RqC3cCBGgQ4GFnFXcGHC4jLAhIvKzB/5xVRbMChef1TvIhHoQff6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orex+vl2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b35859345so226214276.2
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721899667; x=1722504467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AdgVU6zHgCJKa50Exg/98idCG0v/D0DVaIgQrxwNmTE=;
        b=orex+vl2M6eVq5rWabbjIrzRcymespzaNKzOJR2tPgUERUSIBcP7WvciNINaGP/EAE
         CERmKPZiXytmo5GCK5+V4SeoBMBffvIgb2alKF+eh84XIFhXjNtYoGwKNFrH5Y+FhwaD
         Dtxot/ll9nacD3rbQu4zd39Wl8q4r4tLTDA8Ntl7ayt736D+oV/unTG2XBK7pewTEN2G
         F2ppTXNCrgnvb7ys2s7S/g4HDh3ilc3FRfnqKjQFuG7Ema2gnVbeOb/xVZOwBIORFEnV
         RMAQ9eLuC6LIz7InDeCqkKVGYGLzu/HvB3WZmxtMSMmlP67pGjE2I3h4MynQxzeFf7ad
         pEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721899667; x=1722504467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdgVU6zHgCJKa50Exg/98idCG0v/D0DVaIgQrxwNmTE=;
        b=uP/kuhQCL27kGi6xPimDPCspnT3RkL7hrkc8ybPc6+gHVlF6m+90R2qVYchOMm9t6b
         13F0o6MEtWz3vpAZisVis6CIR0g2DnxElFDTmAV8nUEvRToq4dVRHSQFHaVUBnmoUQMR
         zOCLzXqKdbgDajBZNrYCNkC5tUXpiM2jhMprRhWEMIxDqGpql1h7xsWoA+pIfw/RcvVS
         d1v9kLUtAl4t1TqtPIsPv6GEvIIYjjiTDJo+C3miMkAId3McQEDSggJhHBfzkavIcYZ3
         tpJDE/4wFMSFjtA6i3p13kLL7iKWZX+ZIQFZBbyl1OpEAwb42uiZI+ElqAxwfqj4Lmrr
         htjA==
X-Forwarded-Encrypted: i=1; AJvYcCUQBYzRz9A/TqGpnUPS5QVOmvDOdQyUSw/2oWjDc2EdthnEDRBfAg2sqnE64ERK+jZgUmXM2L7j1MbS22kB8N63i5Evi1Ku
X-Gm-Message-State: AOJu0Ywt/GXY15D2rzj6pl8oizuDcmHllcLLXxhuYtaQTXudpgmLqarK
	ofXpl14b8U7giHlGsDXHv4RW4xYytwOLCW89pfiCX93po9Z5MhxXx9SzTz2UuFE5ffOB1SQbUkV
	q34pbzkti6g==
X-Google-Smtp-Source: AGHT+IHCbxyYDk+AK6iaYCTBE6tayRlPXmz9fLX5PNxG2/t2cSMnoyLnaZbbR+Lfzhv+CF9TTKRKJ8wI7h0pCw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154e:b0:e03:2f8e:9d81 with SMTP
 id 3f1490d57ef6-e0b22e3c000mr4260276.0.1721899667249; Thu, 25 Jul 2024
 02:27:47 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:27:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240725092745.1760161-1-edumazet@google.com>
Subject: [PATCH net] sched: act_ct: take care of padding in struct zones_ht_key
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com, 
	Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Blamed commit increased lookup key size from 2 bytes to 16 bytes,
because zones_ht_key got a struct net pointer.

Make sure rhashtable_lookup() is not using the padding bytes
which are not initialized.

 BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 BUG: KMSAN: uninit-value in tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
  rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
  __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
  rhashtable_lookup include/linux/rhashtable.h:646 [inline]
  rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
  tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
  tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408
  tcf_action_init_1+0x6cc/0xb30 net/sched/act_api.c:1425
  tcf_action_init+0x458/0xf00 net/sched/act_api.c:1488
  tcf_action_add net/sched/act_api.c:2061 [inline]
  tc_ctl_action+0x4be/0x19d0 net/sched/act_api.c:2118
  rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6647
  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2550
  rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6665
  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
  netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
  netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:745
  ____sys_sendmsg+0x877/0xb60 net/socket.c:2597
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2651
  __sys_sendmsg net/socket.c:2680 [inline]
  __do_sys_sendmsg net/socket.c:2689 [inline]
  __se_sys_sendmsg net/socket.c:2687 [inline]
  __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2687
  x64_sys_call+0x2dd6/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:47
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable key created at:
  tcf_ct_flow_table_get+0x4a/0x2260 net/sched/act_ct.c:324
  tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408

Fixes: 88c67aeb1407 ("sched: act_ct: add netns into the key of tcf_ct_flow_table")
Reported-by: syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/sched/act_ct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 113b907da0f757af7be920cc9b3a1b1c769f5804..3ba8e7e739b58a96e66ca64d38bff758500df3e1 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -44,6 +44,8 @@ static DEFINE_MUTEX(zones_mutex);
 struct zones_ht_key {
 	struct net *net;
 	u16 zone;
+	/* Note : pad[] must be the last field. */
+	u8  pad[];
 };
 
 struct tcf_ct_flow_table {
@@ -60,7 +62,7 @@ struct tcf_ct_flow_table {
 static const struct rhashtable_params zones_params = {
 	.head_offset = offsetof(struct tcf_ct_flow_table, node),
 	.key_offset = offsetof(struct tcf_ct_flow_table, key),
-	.key_len = sizeof_field(struct tcf_ct_flow_table, key),
+	.key_len = offsetof(struct zones_ht_key, pad),
 	.automatic_shrinking = true,
 };
 
-- 
2.45.2.1089.g2a221341d9-goog


