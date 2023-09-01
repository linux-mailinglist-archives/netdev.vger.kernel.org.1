Return-Path: <netdev+bounces-31667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F178F786
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 05:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675F028163F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591AF187C;
	Fri,  1 Sep 2023 03:49:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF41C3E
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 03:49:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AD18C;
	Thu, 31 Aug 2023 20:49:26 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcP9C49CYzTjf6;
	Fri,  1 Sep 2023 11:46:55 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 11:49:24 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net,v2] wifi: mac80211: fix WARNING in ieee80211_link_info_change_notify()
Date: Fri, 1 Sep 2023 11:53:01 +0800
Message-ID: <20230901035301.3473463-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Syz reports the following WARNING:
wlan0: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 3 PID: 5384 at net/mac80211/main.c:287
ieee80211_link_info_change_notify+0x1c2/0x230
Modules linked in:
RIP: 0010:ieee80211_link_info_change_notify+0x1c2/0x230
Call Trace:
<TASK>
ieee80211_set_mcast_rate+0x3e/0x50
nl80211_set_mcast_rate+0x316/0x650
genl_family_rcv_msg_doit+0x20b/0x300
genl_rcv_msg+0x39f/0x6a0
netlink_rcv_skb+0x13b/0x3b0
genl_rcv+0x24/0x40
netlink_unicast+0x4a2/0x740
netlink_sendmsg+0x83e/0xce0
sock_sendmsg+0xc5/0x100
____sys_sendmsg+0x583/0x690
___sys_sendmsg+0xe8/0x160
__sys_sendmsg+0xbf/0x160
do_syscall_64+0x35/0x80
entry_SYSCALL_64_after_hwframe+0x46/0xb0
</TASK>

The execution process is as follows:
Thread A:
ieee80211_open()
    ieee80211_do_open()
        drv_add_interface()     //set IEEE80211_SDATA_IN_DRIVER flag
...
rtnl_newlink
    do_setlink
	dev_change_flags
            ...
            __dev_close_many
                ieee80211_stop()
                    ieee80211_do_stop()
                        drv_remove_interface() //clear flag
...
nl80211_set_mcast_rate()
    ieee80211_set_mcast_rate()
        ieee80211_link_info_change_notify()
            check_sdata_in_driver() //WARNING because flag is cleared

When the wlan device stops, the IEEE80211_SDATA_IN_ DRIVER flag is cleared.
And then after the set mcast rate command is executed, WARNING is generated
because the flag bit has been already cleared.

Fixes: 591e73ee3f73 ("wifi: mac80211: properly skip link info driver update")
Reported-by: syzbot+bce2ca140cc00578ed07@syzkaller.appspotmail.com
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v2: modify commit info
---
 net/mac80211/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 24315d7b3126..f79e2343dddd 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -285,6 +285,9 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		return;
 
+	if (!ieee80211_sdata_running(sdata))
+		return;
+
 	if (!check_sdata_in_driver(sdata))
 		return;
 
-- 
2.34.1


