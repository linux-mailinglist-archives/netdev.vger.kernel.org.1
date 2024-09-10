Return-Path: <netdev+bounces-126935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A959731A7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F2B28B26F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF118199926;
	Tue, 10 Sep 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O2wLDqSn"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018E19066D;
	Tue, 10 Sep 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962974; cv=none; b=LHQzofi5gH9pqfTknevWHw4TDLwRFxMBcUiEzTfjEbmMevry5jbvnN+pzwN7T0u+pHzNOBPczfu0DlL1sNX4uETacSrSvus6l5znDQ51a3li1fiN33sua6VuOaMOK3GCua2XEMSWAXfNf5oXhs9c3durURmarrt7PrInTdTUwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962974; c=relaxed/simple;
	bh=9+c9pvgoddnrMvDhdI6Wh8Iz8hbCY/65n/sGOMz/UlA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rIVJO0wkiTuyhfRcqB//zNrRRa5QC3n50caR+GRmGEN3OYZpFf5k/k+wliAi7uLUeXaOk/rbsLQIlxLcfhbQdq2CJAxRnfzptkhjr/xUnrugNiuJJ7EPsNIt182PFnrSZ1BYFbmcvZR0gnoz/lRdAAt/zt0my94ETIVbS+cDCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O2wLDqSn; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725962663; bh=SH5quYrxe+ydY/dZue9zWjjQGockMw3uC6pR6yuHmC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2wLDqSndvF9b4Iom3FWaux73FcJKYZ93KvGTQa5QGsNV4i8gPZyNtd0g4nGi4Z4z
	 9GJqSgkdF+uLrz3xkBr9IRKv6qddAcEI8AUmWSdidMA2Ca0L1h1yaMszQBS7t3aiXh
	 KsLoJn6TeHhVAh1RHFTcRE+hn6QSAelar+7UKGUU=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id E833DCB8; Tue, 10 Sep 2024 17:58:03 +0800
X-QQ-mid: xmsmtpt1725962283tgqrw2ryz
Message-ID: <tencent_24C00657C9AC2EC62EF90C8E27F446C69206@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ577KvoMsX0d77snMbzbB4GODF52AgBgMFxqcydEMtiYN0TYI+rYw
	 zJHNWXUrzCPcW6iHu6uFLFK8RDd8KR3UwCvlMHkwuzJQ15I5QhS34lUFStd6yq6gLuE1CDZL1eWX
	 lSNB8CgZz8g4mX3TDu9YmCnLsOcF72PPSGZSZENiW9LvfUauIIGUM0/nHhGdYOvm9QcANyrJqsNl
	 j5o5ca4hvpxr8wl/nu/QjcL5VHWqMQQG51R7LZdPDDnxvhP+efBI4b229Q/gx6+ifAkTS3v3rTB1
	 8eim5AAjoAMu8MGdOwrnAtd3BfHFLYs5a2vnZ0OJpJ/uk2P0LqguLPmJuPxYQ0XPnupYc5itVICt
	 RGR5xPCG8z37WQp7xr29Pf6Rgrv5v4d39QeBgVPFrws0/yvMcmiCNMA8oK9q3zLkeH1DVfJqstZ8
	 YSKVWpuDcArYYFX7Xq8GrvkvyLGW37fcH7LcIY66lH4PT76sJnQU/g2MrP7CnzJ2eMR/8RxTjhvC
	 5z3YHc1NdUFVsPlyHg+1bXhELPlS4dqKcFb5HKpAIKRB17k81+yzphilE0Mw/3+5X6ltOifGZ4Az
	 xWjN3+PW4JP+lSGcoOGZzTRaNascdtsmrR7BQUIUnwtZUjC0XETzTfX+hOyB1h5or6moNcGpkytT
	 9wwEMWbQ0ztBC6wHEDkEloGpstU8BkQvSSYpwXEqEt7FTemZI+RrA0CXpdsotP8JdPQ7tYcJpZMs
	 NcrnAsGQLlZ7MqEQDDgHBkEielb5WfqL5tHvWxBR5nWjCcx5zSgdFiRDhogSzmu6d0zyB+Pr6PIo
	 cD5/i9r18BOF3r+LtGUeckE4eHYh08QTF2xbMvMnGHY3c3qmpz3OMYRm35/mabChRITtQQn4Umcd
	 C3dN/FIll2C2Z02TrmL1AH7cyoWG9rzWnP6Uh3/kWG+nG8QJLuywooBiIzF5NzWL3t173OI9ae1y
	 Fz1vSf00JYdixD/o4qy0A9BSWr8+1nTdiPVfSkQvhloJRRqtFdujCn8YS1SbdmxqSHzN6iGPc=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
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
	syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V4] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Tue, 10 Sep 2024 17:58:03 +0800
X-OQ-MSGID: <20240910095803.2617505-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <tencent_272542BA3FBB37337F9EE91B384BB21BF008@qq.com>
References: <tencent_272542BA3FBB37337F9EE91B384BB21BF008@qq.com>
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

Move list_del(&entry->list) to mptcp_pm_del_add_timer and inside the pm lock,
do not directly access any members of the entry outside the pm lock, which
can avoid similar "entry->x" uaf.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/mptcp/pm_netlink.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..f195b577c367 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -331,15 +331,21 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
@@ -1430,7 +1436,6 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		list_del(&entry->list);
 		kfree(entry);
 		return true;
 	}
-- 
2.43.0



