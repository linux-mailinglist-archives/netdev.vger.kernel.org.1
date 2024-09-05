Return-Path: <netdev+bounces-125529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B196D899
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EB51F27614
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC8B19885F;
	Thu,  5 Sep 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WxoLhdEv"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6483CC1;
	Thu,  5 Sep 2024 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539561; cv=none; b=ArFd1EcI0Lak6RblzNWInpNkh/cH1ywqUjEKIAkjyS/zSQglHes+lthfvkGa9EFvQ8TBCOPVM8Z3kElVDFpupupwFDqlyWKbiQl2mRPfw8i/o+dqql05uBKLncJHKkYjBLJIaO4y0YLJCKx4Fl0Clp/IIxnozwUOQKiT7srZT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539561; c=relaxed/simple;
	bh=HVh93pepYoAKfpPEaWrHxeaPoymB5ommkntQdUOkBjU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RYLmtqGLPAdm+QG1Tirl3ppJfgVurGCMuqhbuo7nt8BhbePHkRqH4DGhxgCqFNJtJsbBOH/xhx8jOOMZ7MJPoy5u/2iRdMQc2o+8gg+VGVm9R/MiABapZKay8U0BT4nlmcc75+psnwYJ0joUBF6eqyfardxry77ZEFEmFX0eRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WxoLhdEv; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725539247; bh=qodMNKlPXyc76Cao7+xhzyFv6t1EQEjqqQcbA2Td10U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WxoLhdEvCUPogxOGrapY6FhY61qtFUV0Y58STaSZCZM0+qWAs7IEQk8Wkb/cyuA3s
	 6xGdL744mz4FVAShEvlrzHHvLeSzAU8b20vb8X+dAa4cl5OjyT8hmJ+KOhOoxpjmvf
	 M9oXZ8XDzsFD+MWoW2uDe9bSjt5OKa+jaF5n4Dn8=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 6D6A0665; Thu, 05 Sep 2024 20:27:22 +0800
X-QQ-mid: xmsmtpt1725539242t5go7kv95
Message-ID: <tencent_F85DEC5DED99554FB28DEF258F8DB8120D07@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnHqK/65UZE20SWfbTYSAz5PhmdlyMBE9kProXUj5Wsi8IeF41NV
	 IXBR7BQaFlDZEHX+/MEOqeVAcnN6QbSg+QeX+euQsaTaAxenwcNVIMAPem0+MARsed/wHB3FEY8J
	 3skTo5vNGS5ZyzHbJ6Gx2YfAndwBEGH/aMT47AsSD2ObR2vFcw51zpX7IaWyu9imqObHWKp8VNrb
	 Js4pjbgyIPf5/GhCgg9rRkclTo7z9uEheGppYyU9TVycR9h5R7YQEW+ekBil6nyqcywaEoWS+dT2
	 OQKqSvS+kgIHJ7mSEHsVOIv0I6W4sWpsgYHR2jfjOI2/Nla+R7FxwRMplcH81dAKHPhW+NUdCsro
	 35Nb6ShYVB2dgBh0MO57n4zRhlxb4BxnxglZ0DNcZzlZy/dUF2/I1YYwiqmzTPsZCNfhZn25r7lT
	 i4/fCdT/BKyxUd+G2gZyI4gsWJR3tfwp7EkVqz9op2RmaO9HKp2wSW0Sn7GiT+cLRxnsdr76hT6g
	 OxanBUyAwT9chPMeT03HnDWYTN1zfPo6XXJhZcUXqk4Gc8OaCCfh3WlxeVHCHe2WUiX12qA11/rh
	 WShjZ4m13b8qhJmgVrg5grTeo0aGUugqaLM4yswgrr2I9IyRBI/8CWiVojxTtMRRP4OxXAP4cpfO
	 /7iOlG49XiZeBnFsOGivpfoUcbZorK7sI0zJh2LwcoIw+0DfIjQUbuBOX0YO/oXimAJUAAt40f+6
	 PiRd2Ix3UgfUGKqhGUYFnq1J4LAfIu7sFXXoQd4/0j/TQMdEtnhz4yEFVjqdA0PrUAtrqL7XW0PM
	 1uE0tNxjJzIWaZDkp/gv8ZS9ohWWY+d96HrDz/D//dsUVFXZqJaOVRY/xAIiT258zFRs8JRYHdsa
	 O6BdJIe6OVSBmURo4XVKVsQiB+WspKZfH+3biNsWCo+iUShH0fqY4nAtndac9iNxbd/+44Euiwii
	 Uw6X7S1lrhobO4saw+pyV9U8dEE88YkrPx8qhfKIY=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: matttbe@kernel.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	geliang@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net v3] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Thu,  5 Sep 2024 20:27:23 +0800
X-OQ-MSGID: <20240905122722.93763-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <e4a13002-f471-4951-9180-14f0f8b30bd2@kernel.org>
References: <e4a13002-f471-4951-9180-14f0f8b30bd2@kernel.org>
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

Keeping a reference to add_timer inside the lock, and calling
sk_stop_timer_sync() with this reference, instead of "entry->add_timer".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/mptcp/pm_netlink.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..7ddb373cc6ad 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -329,17 +329,21 @@ struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
+	struct mptcp_pm_add_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
@@ -1430,8 +1434,10 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
+		spin_lock_bh(&msk->pm.lock);
 		list_del(&entry->list);
 		kfree(entry);
+		spin_unlock_bh(&msk->pm.lock);
 		return true;
 	}
 
-- 
2.43.0


