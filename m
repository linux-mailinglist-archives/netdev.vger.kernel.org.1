Return-Path: <netdev+bounces-154961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D950A00805
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3286416380D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE9F1CEE82;
	Fri,  3 Jan 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvEMQD6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26541F9A91
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735901150; cv=none; b=a0G14xjdVMyvmDpg7RKkMukagfjVNb7YEphBjWXvXTqPIydl6GHFrv2BDIoT1/57QH3VBs+L2pb+Cbb/7txxycgKJwqs6hUgdIMv6PDJR4vi8klWsbltQZdG5hwCBNzofxrv54kKJA5WnsenDodZrgcgw0ZEhiPkag46a7pYYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735901150; c=relaxed/simple;
	bh=j8vOKcBecWWFxiCV8eCzd7F8CWx9eTV85qSOBIjdPrc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ebICAMf6Bj2aV2TfBkfjUgEeKCo2/82yBEyCDR9age7vCWVT1eHYnLZ2bHTjEdltXItAkWSRhPqtDRO6n66ocHjvZxbG8/1XEtZx53Xmc3ueAsaKi4IfBeM7HBK0tw+d0CUYAsAQGPIMnPZSl+gcHXkcaDW4LYkFU/Z+iWYnTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvEMQD6l; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b9f0bc7123so1190692485a.1
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 02:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735901148; x=1736505948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uVKmH1UrFQLoeO4s5/1bgEeCaRFjYDvmIRx8LNEk/YM=;
        b=rvEMQD6l97/ffrh7fcXDIlUQmXNT5KDTGKWaT7KDMOnRCQ2ej3WARVON16RJAyIbC7
         cxnxZ71oGL66dAJjYrQLQo6UMZJs0smhD0ciRAXPiOyPczT1UVqbRpb6KSdwoTjG7smO
         VUjFogZfe5f3GvBWcINmlXrgasZOeb/0V7B9s1JUaQgopMzVoybVshCai66sEFfUOSeO
         HDJQxmjNhNcV8YbQa1Bvoys6nEr/6jWSzKq98PXafZ0qetsVx4ONpFkmV80M0UJrCX+D
         0W94Jx/B5kX9pFhhtYxQ/Pdge0FIyYEFo9gvKjxpjf3RvfhOaSLXjAyck2JFiptFk6nk
         jhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735901148; x=1736505948;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVKmH1UrFQLoeO4s5/1bgEeCaRFjYDvmIRx8LNEk/YM=;
        b=xE38rAGETLdvMtoOWE2fTgQoRLXD0/gd7ezWMW8PfiCT4fMsjKDMYqaHpn86KC5M8O
         gSuO7fgM6vYc4XCtTjChRzjLzTixFFICQo9T8fxdcZ+NLv6t2nfXSM3AD8Mekqck58lW
         3jkemrshGN9BOpKcnvruhPQpWusYinHtVe9X58gYTrM5z1sDwODXKMiHXWKwYt8ELLlK
         x4AR8gu1A0tZtb4yR9pl+InKCJX1/kZhwOG71wlemdYKtoyKO6Hz60gnpfkoySmqHrat
         boglTGqdsbUrJEHn+1lsneL++7MRtBYJLm2aVuw7JqmL6T8Y7LMnUjg6SBvEoOGfpw2Z
         Zd1A==
X-Forwarded-Encrypted: i=1; AJvYcCXk3Cy7L3xWp9/MCtDWHy+ybDv1rTb1Q1J/AYhja/xxpl3RJkuEQjvJMWiKZ4rCdIRFzxAlrT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy462dq6RkkCXqvKi+fzRA/5e3isbAcHCva/nNs7PLkQCCaExDx
	HYFXBFdjEjZwG1UjvWOZBgP5BrfkTsFIhIgm1vT0N6KYcoy6ver0Tc7TD8z+/vaSi/yYOYeVgDO
	Znwpuh9Rk9A==
X-Google-Smtp-Source: AGHT+IGAI231LYSh7ibu905DB/ANilLdPHmiKNGVHTN3b3yVly09KM3QmrgNPbEb6mKz39qBIsj3njHq98psWA==
X-Received: from qknqt5.prod.google.com ([2002:a05:620a:8a05:b0:7b6:d4b7:ec60])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4551:b0:7b6:eb2b:b49e with SMTP id af79cd13be357-7b9ba6fd8c9mr8091584785a.6.1735901147790;
 Fri, 03 Jan 2025 02:45:47 -0800 (PST)
Date: Fri,  3 Jan 2025 10:45:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250103104546.3714168-1-edumazet@google.com>
Subject: [PATCH net] net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+1dbb57d994e54aaa04d2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot found that TCA_FLOW_RSHIFT attribute was not validated.
Right shitfing a 32bit integer is undefined for large shift values.

UBSAN: shift-out-of-bounds in net/sched/cls_flow.c:329:23
shift exponent 9445 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 1 UID: 0 PID: 54 Comm: kworker/u8:3 Not tainted 6.13.0-rc3-syzkaller-00180-g4f619d518db9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  ubsan_epilogue lib/ubsan.c:231 [inline]
  __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
  flow_classify+0x24d5/0x25b0 net/sched/cls_flow.c:329
  tc_classify include/net/tc_wrapper.h:197 [inline]
  __tcf_classify net/sched/cls_api.c:1771 [inline]
  tcf_classify+0x420/0x1160 net/sched/cls_api.c:1867
  sfb_classify net/sched/sch_sfb.c:260 [inline]
  sfb_enqueue+0x3ad/0x18b0 net/sched/sch_sfb.c:318
  dev_qdisc_enqueue+0x4b/0x290 net/core/dev.c:3793
  __dev_xmit_skb net/core/dev.c:3889 [inline]
  __dev_queue_xmit+0xf0e/0x3f50 net/core/dev.c:4400
  dev_queue_xmit include/linux/netdevice.h:3168 [inline]
  neigh_hh_output include/net/neighbour.h:523 [inline]
  neigh_output include/net/neighbour.h:537 [inline]
  ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:236
  iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
  udp_tunnel_xmit_skb+0x262/0x3b0 net/ipv4/udp_tunnel_core.c:173
  geneve_xmit_skb drivers/net/geneve.c:916 [inline]
  geneve_xmit+0x21dc/0x2d00 drivers/net/geneve.c:1039
  __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
  netdev_start_xmit include/linux/netdevice.h:5011 [inline]
  xmit_one net/core/dev.c:3590 [inline]
  dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3606
  __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4434

Fixes: e5dfb815181f ("[NET_SCHED]: Add flow classifier")
Reported-by: syzbot+1dbb57d994e54aaa04d2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6777bf49.050a0220.178762.0040.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/cls_flow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 5502998aace74157320efed71faf40afd196fac4..5c2580a07530e4e0615a7df7ff9d0a35ae9e94b4 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -356,7 +356,8 @@ static const struct nla_policy flow_policy[TCA_FLOW_MAX + 1] = {
 	[TCA_FLOW_KEYS]		= { .type = NLA_U32 },
 	[TCA_FLOW_MODE]		= { .type = NLA_U32 },
 	[TCA_FLOW_BASECLASS]	= { .type = NLA_U32 },
-	[TCA_FLOW_RSHIFT]	= { .type = NLA_U32 },
+	[TCA_FLOW_RSHIFT]	= NLA_POLICY_MAX(NLA_U32,
+						 31 /* BITS_PER_U32 - 1 */),
 	[TCA_FLOW_ADDEND]	= { .type = NLA_U32 },
 	[TCA_FLOW_MASK]		= { .type = NLA_U32 },
 	[TCA_FLOW_XOR]		= { .type = NLA_U32 },
-- 
2.47.1.613.gc27f4b7a9f-goog


