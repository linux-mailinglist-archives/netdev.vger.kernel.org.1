Return-Path: <netdev+bounces-93708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1F78BCDFB
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D6AB266A1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37A748F;
	Mon,  6 May 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8nD0Ge1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CDB672
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998636; cv=none; b=ZFe3MTvp3PqngNbhtGkF8cVUgmoCKIj2k/DgLj3FpjDU5dpq/nBuVnOWRuisGAAJHDRlE+oCYZGYKf+nADPAytHTWe1viFcgLQX8mHNdY/m/LcQq/J7QpPB3zn5rBDSlbmJjXc4w8UW3VjNs0zaNsZOvEmRLwkg7bj9NmQ5jlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998636; c=relaxed/simple;
	bh=dHkAFoPK9igsh3hBPxZ0BoPVhsZFVy+Byd3Z8YXctN0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G+m/S1UQF5odos3jo9ZKP/svvJ0DONLNv8vxAHWhR+N3aUpqIu5i0EmlF6CPPwSb7MlPd92SEEtpiUAm6b/wKOXAMkKrYgApNQOsE2VPNEKcQ/gGwwTehQU/0U5JDPAZbV38VnaH0Rr4tKBCxGCasmv7/hS+AjwZqE5K6XqEirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8nD0Ge1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b1200cc92so35686547b3.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714998634; x=1715603434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JLW66EGcoAduSwef0VL9DG+1mWQHwTuV/UM4MbZqh1o=;
        b=i8nD0Ge1Jy/OEjkL6YFtWJv7ZWvEKZYOfJqI/Wrewq13sO2fZaYrgk4jhvPVUsmb3j
         8nOhiKvJZhIm4JwLfKrSxxUd+3MVL/0NtjBzybiTkH/1cbHL9LmOLDV2O1/uP4FKrw+C
         AzNxoalsO0RzEilPRCm5ygleO14/WV+89Z6w37TdhafC70/7uRa5lcXhj8mWz77eZdcI
         SFJBThpKC8trZdu+sEygIXxz2o9/xSpQGk4/VluUFScJGmIdCFmuOQiOdb9urjH4FLtl
         GiIFEM4aAJ4pFcTMYHkxmBgJUnwEB+KTe28FXTpD24941qDeMdZ5vtloHBofrAt9baHX
         svZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714998634; x=1715603434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLW66EGcoAduSwef0VL9DG+1mWQHwTuV/UM4MbZqh1o=;
        b=ccS3B24Q9J+hExHBKuiQbvZO3k+eRkwiwVNHzbaH0B0+n4k5L3vFVyqzyxWuolrdFL
         GzTPdriqjjwbSl2bLvY0cHOkiuAP9hHhbSmfFNbJ8Qyilk0ULgftXyfVBiOihilKIgJ0
         kPF0dfFEIPlCWXFS5X6fNfRaj6jRLAGEVuVLfpjGYWG3ehNjso5Yd3QOBYfd4rZsQOMj
         7aTDfb1ey8fWegg9L9TBfOCCrdP/dnwRVE+38x9wt/prxUCy60IIv4pSjMqZOdXbg2Li
         hgwBMSeSm6SuRq0ztkhO4+ZiOPeRwASdTHDM4qFldCd70qj5PYZaMsqraBapH2nXoVIe
         pYxA==
X-Gm-Message-State: AOJu0YxqCbSI9F/8AD2aFqye5Lo1tCH7gv7TjgRfRimo/NnJcsM9hbjq
	pLiw0GCFvnK6zP61/XGms3MJ0D/D9unld/vEKeR8OfyhDjzilsyozIrwcCa/rv8wzG3iVCPsbgX
	6FDa0r4BOlg==
X-Google-Smtp-Source: AGHT+IFMPTsoGxUsumAtN3chcaukZ3C6wjkHWoIAeMwy/+KcTA62jn8U8xL2b6hSdyb9NeENKxSUsnW0kDQcVw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:d74c:0:b0:618:8e4b:f49d with SMTP id
 z73-20020a0dd74c000000b006188e4bf49dmr2701634ywd.4.1714998634160; Mon, 06 May
 2024 05:30:34 -0700 (PDT)
Date: Mon,  6 May 2024 12:30:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506123032.3351895-1-edumazet@google.com>
Subject: [PATCH net-next] mptcp: fix possible NULL dereferences
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Jason Xing <kernelxing@tencent.com>, Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"

subflow_add_reset_reason(skb, ...) can fail.

We can not assume mptcp_get_ext(skb) always return a non NULL pointer.

syzbot reported:

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 5098 Comm: syz-executor132 Not tainted 6.9.0-rc6-syzkaller-01478-gcdc74c9d06e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:subflow_v6_route_req+0x2c7/0x490 net/mptcp/subflow.c:388
Code: 8d 7b 07 48 89 f8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 c0 01 00 00 0f b6 43 07 48 8d 1c c3 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 84 01 00 00 0f b6 5b 01 83 e3 0f 48 89
RSP: 0018:ffffc9000362eb68 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff888022039e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807d961140 R08: ffffffff8b6cb76b R09: 1ffff1100fb2c230
R10: dffffc0000000000 R11: ffffed100fb2c231 R12: dffffc0000000000
R13: ffff888022bfe273 R14: ffff88802cf9cc80 R15: ffff88802ad5a700
FS:  0000555587ad2380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f420c3f9720 CR3: 0000000022bfc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  tcp_conn_request+0xf07/0x32c0 net/ipv4/tcp_input.c:7180
  tcp_rcv_state_process+0x183c/0x4500 net/ipv4/tcp_input.c:6663
  tcp_v6_do_rcv+0x8b2/0x1310 net/ipv6/tcp_ipv6.c:1673
  tcp_v6_rcv+0x22b4/0x30b0 net/ipv6/tcp_ipv6.c:1910
  ip6_protocol_deliver_rcu+0xc76/0x1570 net/ipv6/ip6_input.c:438
  ip6_input_finish+0x186/0x2d0 net/ipv6/ip6_input.c:483
  NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
  NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
  __netif_receive_skb_one_core net/core/dev.c:5625 [inline]
  __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5739
  netif_receive_skb_internal net/core/dev.c:5825 [inline]
  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5885
  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1549
  tun_get_user+0x2f35/0x4560 drivers/net/tun.c:2002
  tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2110 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xa84/0xcb0 fs/read_write.c:590
  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 3e140491dd80 ("mptcp: support rstreason for passive reset")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kernelxing@tencent.com>
Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 97ec44d1df308f53e8ebabe6f77c8c86859b5a36..7208d824be353476496271e971ccafde1a47b959 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -287,6 +287,16 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 }
 EXPORT_SYMBOL_GPL(mptcp_subflow_init_cookie_req);
 
+static enum sk_rst_reason mptcp_get_rst_reason(const struct sk_buff *skb)
+{
+	const struct mptcp_ext *mpext = mptcp_get_ext(skb);
+
+	if (!mpext)
+		return SK_RST_REASON_NOT_SPECIFIED;
+
+	return sk_rst_convert_mptcp_reason(mpext->reset_reason);
+}
+
 static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 					      struct sk_buff *skb,
 					      struct flowi *fl,
@@ -308,13 +318,9 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie) {
-		struct mptcp_ext *mpext = mptcp_get_ext(skb);
-		enum sk_rst_reason reason;
-
-		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
-		tcp_request_sock_ops.send_reset(sk, skb, reason);
-	}
+	if (!req->syncookie)
+		tcp_request_sock_ops.send_reset(sk, skb,
+						mptcp_get_rst_reason(skb));
 	return NULL;
 }
 
@@ -381,13 +387,9 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie) {
-		struct mptcp_ext *mpext = mptcp_get_ext(skb);
-		enum sk_rst_reason reason;
-
-		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
-		tcp6_request_sock_ops.send_reset(sk, skb, reason);
-	}
+	if (!req->syncookie)
+		tcp6_request_sock_ops.send_reset(sk, skb,
+						 mptcp_get_rst_reason(skb));
 	return NULL;
 }
 #endif
@@ -923,7 +925,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	reason = sk_rst_convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason);
+	reason = mptcp_get_rst_reason(skb);
 	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


