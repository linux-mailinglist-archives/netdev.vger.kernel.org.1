Return-Path: <netdev+bounces-124595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146D96A1BA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647361C23F2E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EAE183CB7;
	Tue,  3 Sep 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="V+p/s+9U"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57849184554;
	Tue,  3 Sep 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376217; cv=none; b=WeHicb8n5LtTNfVcUha8VWimwH0X5MBT+mGkVmjVZ3bRz2/6Lx7q6t6amnA02MZFCiX/BuN2VpVQ+RCBFIVgaQGBWHRXpIV90fYRUyj43e3wxL5Q2gpeR1zVnZRe2fBQ6yChwnZ6LM59EBw26TUF1WYEv3j/AeXH8r/wNUBKBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376217; c=relaxed/simple;
	bh=+z7G3IX+1bW2pDxcYm41syOZar68AflCSZdjfRRjnRQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=REY57xE9ugUYjAOGYjyp7LH1aTAljw6ggM6ge9gkEj1iKDtrMw+4zG9NBaF5WlAP87xZ0mMQFALv5vjzVj+Ft/05PbnjCxJ8OPrPOBCXFb/xIX/7nCdEI6RCnfKBuwBiX0JRVElSX4S8aMON+qEoutvadEabCKjfs06OwBr+BH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=V+p/s+9U; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725376198; bh=MQ6bT5FJLUg3J089OEWCktQlKv2hXeklSpcdpqzongM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+p/s+9UiF9EiyPS254dFEry1w+QjPWqtIPHmHdxn1BwESPIycYAns+wkpdLLteSO
	 0Rn1isYgjympltaYdJj05HVdKT1qZxuvvEMEBO9xjCAze3jBfWCQivoVM8dvmlntfV
	 sdyJEAlD4VmMHHzAJlxUzo8wgwKHDR0aVR0hAVnU=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 277260F5; Tue, 03 Sep 2024 23:09:55 +0800
X-QQ-mid: xmsmtpt1725376195t0lnj7bhm
Message-ID: <tencent_274B82754376EF66A23C0D37029644374609@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXy6B4ZPvpifI2vGuaOv61uhym1HEu23+Gf+oRWFKLypO0suJilkx
	 t/ZoF7VrTBv7RkbI4Bj9wBpeqSgD4oTR5GpFWUGhHDIoMTZn8biK3pqSqEEV3/uJfAXqIyP+VN1K
	 T3ja2x1IIiV9zRcdPFdNHz2UrMBQqV4Dez6IMBn1zppmHZDrNgmeI5/zBPmHkXQQ+OKYldHWhGrD
	 ngcHL/ExTTrAAhakVtANM0gd14VJBILglCvk7IlB/+qM14m+KBTi7zIgk/NFFgfD5TCYHkiOqW1H
	 Xi8xfYKR7Hl1NlkiVp5B1DX1L9Orf/z7Hpz22y+E1VnGYm0Pqql1m6KC1WlqK/pMd5g1JTLR3OYJ
	 tr04yPeZzJ1oZhko1SL0YnD3hfgnRadcn6xkln5Zt/bo54q/Gezzw207o0JAqCBLwiY57Toy8smo
	 So6/avOPuRFWJtB2BDYY6kuEryKJWxfO9K1Ysm3cuufd/rME6v6P2mtbaaRcQcYWO+zp/7ySGXYa
	 2DqYe1vllw2zD0Yl78u0YrCiI83yi3fyW/uEdtU86cY18lk7XzliCEaBcW6pP2zkN572Q43wFgcF
	 lGa72kegs7MN6S0blVp6M2+1xf58F/s7FYBJZTbUMPvvbt0jkhyoicMy56vg4v8C/Lz/u2VBSKbd
	 Kkq6Ed3a/umSnysO8Y6qscpqFp183qTC6xzzzf38sPTqLVATxVBwWQQE8DjLXsqK0pYU9Ih1zcef
	 PBcAemZx91hm7i+g6+B4kZPKX+9FtDBcrRULmzNDonmJIH2iOkilv2FCHssfpoUOrknB6eNo89gs
	 +chiIb5VBlSJRaMP5uF37ZzPB9zj+geE3FNZ6o9ElNH3GHuoMjeGz/JNAkWYbka33HJMM9rviXu1
	 6Fkpc3qTeZskf/GpDqheChLNvQFgDtHaXlG8pkRhgrX2N1DNGTdqwQTiCPJH0A13+e6w+GFzIWvw
	 7fE7prS/M=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Tue,  3 Sep 2024 23:09:55 +0800
X-OQ-MSGID: <20240903150954.3338781-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000b341bb062136d2d9@google.com>
References: <000000000000b341bb062136d2d9@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two paths to access mptcp_pm_del_add_timer, result in a race
condition:

     CPU1				CPU2
     ====                               ====
     net_rx_action
     napi_poll                          netlink_sendmsg
     __napi_poll                        netlink_unicast
     process_backlog                    netlink_unicast_kernel
     __netif_receive_skb                genl_rcv
     __netif_receive_skb_one_core       netlink_rcv_skb
     NF_HOOK                            genl_rcv_msg
     ip_local_deliver_finish            genl_family_rcv_msg
     ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
     tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
     tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
     tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
     tcp_data_queue                     remove_anno_list_by_saddr
     mptcp_incoming_options             mptcp_pm_del_add_timer
     mptcp_pm_del_add_timer             kfree(entry)

In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
zone protected by "pm.lock", the entry will be released, which leads to the
occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).

Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..d28bf0c9ad66 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -336,11 +336,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id))
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-	spin_unlock_bh(&msk->pm.lock);
 
 	if (entry && (!check_id || entry->addr.id == addr->id))
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
+	spin_unlock_bh(&msk->pm.lock);
+
 	return entry;
 }
 
-- 
2.43.0


