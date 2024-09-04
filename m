Return-Path: <netdev+bounces-124771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B513E96ADA9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BA0283D06
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0B263C;
	Wed,  4 Sep 2024 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f3VcjyXX"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF220ED;
	Wed,  4 Sep 2024 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412521; cv=none; b=E5n/MWc5OV0zvi/sGThBTv07zbrmSUEWR5NwklFl+fVeRm7afue8BhR+5lAb11tOET8qDqIWVJkXxSDZQz1p/p3A9iIJ+PnLWzCp5zUlGSpfbFJgkk0v8iOqZrWFRylrHPKXlrROYfbjxFssm9InPY4Mr+z+owaLOb5hTDCL0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412521; c=relaxed/simple;
	bh=EXMzDbmcyT8Qbv/FeHGnz5g0knYbqB/ouB2ky8UwEgs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=G0JgaY0x6oPU2x1ycdEktb06PtMLCfk+iEqDYo6jNidexxR+2hZ6iwt2b8IYWo6yW4H+buMuMohvCVjLJWH0jc/lILxQNIL3TS/OZy4WaWdDRMJFCFgPHvorm4ZehzT+QzrJDvk74wqKUqmNz7zjmDPIWBgJIRzLIKklca73X60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f3VcjyXX; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725412515; bh=QJXZJ0i4PPyQs9pLBVhM6Cvr7GCkh2tTTsXYVcn50/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f3VcjyXXBodAtU2L2N2FF1YiEjEjss8zKD2YqfQPXAwGAqMw5vSnyxB8UxkYEIQCg
	 7hCZ/rHfqGz174AXlxmbmdgOSPrbz/AtqEvnhrjf4qsfSih/PZZKkt5K7/c83+7PTH
	 UDvHWIs4EioFA60BjYgxT7KN/6wEEi8RwaBZtCm0=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 64972BC; Wed, 04 Sep 2024 09:01:36 +0800
X-QQ-mid: xmsmtpt1725411696tbd4s16ca
Message-ID: <tencent_472581BA11BB2533E79EA21B964B2A1BC408@qq.com>
X-QQ-XMAILINFO: NiAdzfE16ND4G/kmn26CnIlyhaFL7BFoNKCJQqM4wJSMCMBfLvHOBYUa0FF4OB
	 gEiIsHUffKRlg4jM1p6hUdRnlt+46h6w0PnLmdcIFMTvDZUFCXrxUwFYNpAtt7k1DghYYFh9tju2
	 zjvBrBGL27gyvyV/LDaOe9dgzgVgvnC2DzV5EMmJSd5kIcm3qEc1u/F5qYxOq6yFIR4VoqPbhHDD
	 KEqAzH7NCNlYdYKmZG1UlR+KzpLJHswLW1ssym0KETcqSc7zxa7cb5nq8hNu+aFeQ1JAROj1kLHa
	 Slyl7KKWYuXtstFAkjoBY6DStCx0g1IiTz5tHodZBmJ8EthtTwussUghGhvBlkvr5Up11JG3z94Q
	 dpsSUOyLi58kguToezbaLgk4nkCFMNdh7xHK2UtG4P8cJDAEMcpLV4rhbYRQFGoqYS8PsHzEy3H8
	 0VbzIc8XIDsbrIi7dgUQ3Noe/P7x/XoTUhh9Fr2zi3GefOvMZuLdcQKh2HFOQqvmpn1yY0FplDvZ
	 7gXtVDVIgC14VU7jLiP0AfHQ16qTX8sg0eCzU4Z8MUq+1ypeUCSNUBxiKFGv9fKVHc/jxVrxgI/B
	 VNSyJjShrSY/LI1ENS7nbuPsAzl0Sz23dCZ9XvtFMblEVZjHyjkxjSgm/Ptb0q7ZV0JIoIizIaWk
	 BnsHykcbLoolQGhnysmFgh/WvnWdS5ERJcfuuHWlj5UeVL4OsRjtRD6g2z4YxQJBdKy1Laomqk96
	 spm9AMDzlEHiW+h8V/PFInyr9OWKjVwg0bZVRjkVMMTKCDywXIbH5ZxWJ15fXthMhm6ElF0GDena
	 vTNQgbhsuK9e98X0Eheu/5nLXfQJ7YxL7mGnaLE10unU/qK0PBjtGNGSrPhfxWAKgPIFddA16Gl0
	 MQVV4tGJzvehtkJswLcUZ8e3h3jqlXVdJD8jQsEUnDq702yPnQET2UXvJ5bmtYhNTjKAtnZJSyhO
	 IIkoOvDH4J8qgl68T7Jmx31hLCa66G
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Subject: [PATCH V2] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Wed,  4 Sep 2024 09:01:37 +0800
X-OQ-MSGID: <20240904010136.3443727-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <tencent_EECBD37DC379497A63A1C455B773377AC605@qq.com>
References: <tencent_EECBD37DC379497A63A1C455B773377AC605@qq.com>
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
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..d4cbf7dcf983 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1430,8 +1430,10 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
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


