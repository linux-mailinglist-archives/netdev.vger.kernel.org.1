Return-Path: <netdev+bounces-240797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E069FC7A9AE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 110824E69C2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE72ED85F;
	Fri, 21 Nov 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZd/AEpp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994AB2C2ABF
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739668; cv=none; b=jmbH3UyDnG5DQGsziUTTSqaggpsFPgCCEC5C2yQDH8wKB4uRcJxpDlNug6ndaJIILIgwMqeAroZlNVHCKwT4t4i60U5WfrZWnfJV8Uiw+kmBmi8bkTSqernXwj/lItSfQzlm/1cNSk6XbxiaUNH1YBBl6a5OcZOlcqhdxjpzm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739668; c=relaxed/simple;
	bh=IynZqOMMfpBgJAuRKWjrDqsopaMw/H61+216u2SLX7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mX/DWpyd+fQ2Bzsu+7Topdixe4Bg7leD0J4Mnlva0FyrT/nCHeKdG8cR6TrFksjbJqXBkaxh7jpL98ecpCBXCh39+coIshQMQ3HTMtEKZH2udGaYEL0iAgYPY6YF6qfylwZwi0PeLQigWeDjGLHKe8YPmVg3NG3Hmq6OgnC0STw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZd/AEpp; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b259f0da04so592134385a.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763739662; x=1764344462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lG4EVSHa2p5X+4tm1xXh9hVt+9c2StBfQCA4bKx0F8g=;
        b=vZd/AEppef94uPGGfWQ6WtgZ6Q4e1aTx7wIA1wMevOjJGR0Bd5BNydzNi7GyLkkxnc
         evxitKyMPx3tq0n9Ss2Nnyizb6aQ9ODPpWEj9BI6CQdTCWQjXilDQWRe1Lto4IAGaxkx
         wzUYPwAV3wHKmVttwyNWHmE3lHQ1Da6K7tB1a0cOVZ/5c6bDX3E2KV6c+wXEQ5h1cTo6
         DZV7v5aT1XyF2BjovNPZNiYTriA7aenq0R7badGImwnFtHUTDAfqE5EOWZILyhLd9nvd
         bVPKqsEMn87WPxLaJu9ImzjINI1k/wvhtRuuBQe5yB0MDVqS1EYsFmr9pK7KAv0j4kMT
         6wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763739662; x=1764344462;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lG4EVSHa2p5X+4tm1xXh9hVt+9c2StBfQCA4bKx0F8g=;
        b=j7Dh8xsBNaW4YS+F+Qxr4dHn7TYxu8FkiTXdX3iIZgDxroTJGNinNFv5z7GSiiTTTv
         GDDykPqye13ldIO39MNwL7YCm5KU6lXSW0kJyDwD5O5UMYob+XbJuH283GymKe3D1s8F
         QtKTDCfySTd/Nn74tx8k6K+i0GF61G3/uC5nqwUwyUieIduB+iwrjXhLBtesz3uWP1x8
         xKoF5FcVfR5tXFRqJgE6QMuMLBZTthFvv1clmurZkLJn2rJx3d+fBng9jY7wxt30nULY
         xMiEkfxz2/JHCXtxozkAlrBmxwf2oJp6mI9ukN58nooM6R7wvtSZpxnyz4nUIn/ZGNCj
         u5dg==
X-Forwarded-Encrypted: i=1; AJvYcCXXoJc2YDlYnKjMLAUcJW134goM76c7HWrHvUD9QMqGfn3ItD1oxYXRPooaIj0vhd8n5V+eJEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDg99qJzsKztQL2QAOXLBsisW7KKp/I20NHgAuNU70+WqgC0h
	auRKhRFCjRdypbNJY3tv8cUZs8bxLaKQcrWohjQKql3ITEjDJQuLxikmDPMuOoMisL9d+Rhaj6Y
	O5wHi/zPRhO85qw==
X-Google-Smtp-Source: AGHT+IEvPI09mUn9Fupj1hX3tbEozFSlJc265lvngmSrDLIl2X8p/jX1evbyCp9g0O97Glbgm/0i0iEMCgi6sw==
X-Received: from qkpc28.prod.google.com ([2002:a05:620a:269c:b0:8b2:eb77:a152])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4492:b0:8b2:735b:973b with SMTP id af79cd13be357-8b33d1d0e9emr276795485a.23.1763739662292;
 Fri, 21 Nov 2025 07:41:02 -0800 (PST)
Date: Fri, 21 Nov 2025 15:41:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121154100.1616228-1-edumazet@google.com>
Subject: [PATCH net-next] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported that tcf_get_base_ptr() can be called while transport
header is not set [1].

Instead of returning a dangling pointer, return NULL.

Fix tcf_get_base_ptr() callers to handle this NULL value.

[1]
 WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 skb_transport_header include/linux/skbuff.h:3071 [inline]
 WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 tcf_get_base_ptr include/net/pkt_cls.h:539 [inline]
 WARNING: CPU: 1 PID: 6019 at ./include/linux/skbuff.h:3071 em_nbyte_match+0x2d8/0x3f0 net/sched/em_nbyte.c:43
Modules linked in:
CPU: 1 UID: 0 PID: 6019 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Call Trace:
 <TASK>
  tcf_em_match net/sched/ematch.c:494 [inline]
  __tcf_em_tree_match+0x1ac/0x770 net/sched/ematch.c:520
  tcf_em_tree_match include/net/pkt_cls.h:512 [inline]
  basic_classify+0x115/0x2d0 net/sched/cls_basic.c:50
  tc_classify include/net/tc_wrapper.h:197 [inline]
  __tcf_classify net/sched/cls_api.c:1764 [inline]
  tcf_classify+0x4cf/0x1140 net/sched/cls_api.c:1860
  multiq_classify net/sched/sch_multiq.c:39 [inline]
  multiq_enqueue+0xfd/0x4c0 net/sched/sch_multiq.c:66
  dev_qdisc_enqueue+0x4e/0x260 net/core/dev.c:4118
  __dev_xmit_skb net/core/dev.c:4214 [inline]
  __dev_queue_xmit+0xe83/0x3b50 net/core/dev.c:4729
  packet_snd net/packet/af_packet.c:3076 [inline]
  packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
  sock_sendmsg_nosec net/socket.c:727 [inline]
  __sock_sendmsg+0x21c/0x270 net/socket.c:742
  ____sys_sendmsg+0x505/0x830 net/socket.c:2630

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+f3a497f02c389d86ef16@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6920855a.a70a0220.2ea503.0058.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/pkt_cls.h |  2 ++
 net/sched/em_cmp.c    |  5 ++++-
 net/sched/em_nbyte.c  |  2 ++
 net/sched/em_text.c   | 11 +++++++++--
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index c64fd896b1f985c5f6a5b50cbb42ded640d0c9fe..99ac747b7906074c43b3eb8e34cf6c07235cc81d 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -536,6 +536,8 @@ static inline unsigned char * tcf_get_base_ptr(struct sk_buff *skb, int layer)
 		case TCF_LAYER_NETWORK:
 			return skb_network_header(skb);
 		case TCF_LAYER_TRANSPORT:
+			if (!skb_transport_header_was_set(skb))
+				break;
 			return skb_transport_header(skb);
 	}
 
diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
index 64b637f18bc7d40509bf5c9f7679cfbc2922af1c..48c1bce74f498d0b4ee3d1efde96459b0dac5896 100644
--- a/net/sched/em_cmp.c
+++ b/net/sched/em_cmp.c
@@ -22,9 +22,12 @@ static int em_cmp_match(struct sk_buff *skb, struct tcf_ematch *em,
 			struct tcf_pkt_info *info)
 {
 	struct tcf_em_cmp *cmp = (struct tcf_em_cmp *) em->data;
-	unsigned char *ptr = tcf_get_base_ptr(skb, cmp->layer) + cmp->off;
+	unsigned char *ptr = tcf_get_base_ptr(skb, cmp->layer);
 	u32 val = 0;
 
+	if (!ptr)
+		return 0;
+	ptr += cmp->off;
 	if (!tcf_valid_offset(skb, ptr, cmp->align))
 		return 0;
 
diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
index 4f9f21a05d5e40aadfdc4c339b8178ad43dc2c8b..c65ffa5fff946edbc30a65ad99087bf664665e32 100644
--- a/net/sched/em_nbyte.c
+++ b/net/sched/em_nbyte.c
@@ -42,6 +42,8 @@ static int em_nbyte_match(struct sk_buff *skb, struct tcf_ematch *em,
 	struct nbyte_data *nbyte = (struct nbyte_data *) em->data;
 	unsigned char *ptr = tcf_get_base_ptr(skb, nbyte->hdr.layer);
 
+	if (!ptr)
+		return 0;
 	ptr += nbyte->hdr.off;
 
 	if (!tcf_valid_offset(skb, ptr, nbyte->hdr.len))
diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 6b3d0af72c39c7fb1e3290e24bf94f5bf9e0b358..692e2be1793e9961bcd4516baf54a05341f6ac5d 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -29,12 +29,19 @@ static int em_text_match(struct sk_buff *skb, struct tcf_ematch *m,
 			 struct tcf_pkt_info *info)
 {
 	struct text_match *tm = EM_TEXT_PRIV(m);
+	unsigned char *ptr;
 	int from, to;
 
-	from = tcf_get_base_ptr(skb, tm->from_layer) - skb->data;
+	ptr = tcf_get_base_ptr(skb, tm->from_layer);
+	if (!ptr)
+		return 0;
+	from = ptr - skb->data;
 	from += tm->from_offset;
 
-	to = tcf_get_base_ptr(skb, tm->to_layer) - skb->data;
+	ptr = tcf_get_base_ptr(skb, tm->to_layer);
+	if (!ptr)
+		return 0;
+	to = ptr - skb->data;
 	to += tm->to_offset;
 
 	return skb_find_text(skb, from, to, tm->config) != UINT_MAX;
-- 
2.52.0.460.gd25c4c69ec-goog


