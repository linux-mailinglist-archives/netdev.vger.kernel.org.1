Return-Path: <netdev+bounces-27467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186577C19E
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E76281288
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320FBCA5C;
	Mon, 14 Aug 2023 20:38:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129C2CA6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE607C433C7;
	Mon, 14 Aug 2023 20:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692045524;
	bh=EvWgzTAcPqIqOv65wLPvZqXPF9W9Zs4Occdmjk66shw=;
	h=From:To:Cc:Subject:Date:From;
	b=UUUnFaNzb29JxxgyIsggGMQzplEd4KLie+yz6/WlCFwIroLQucTqGF4GeEpQLPbNC
	 Kbhjz0sfG2s2w71B5mTrq6AbR+uTrYCz5VE440mYmX4Sqah5nTaSuKpvSWmR1pSvur
	 1hr8gMjhNUsjpYBLk0ATpTdn81Ge29WwANHmUBTpE9FZaIzwh3FcjG2UNkme589mvR
	 Un2bzvS5/qHLrNpjoO7FD+NttmHHMLOIzgroFs0EUVxmfm/pz45swXBlG+53NxPlCp
	 1u4JhR18ysAqlLyeaJEhqGw2HDfaZ+ScUsW26Or/wOoHlamvSFwNNpjJCyVU3vSbSy
	 GTz3Me6T2/JsQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com,
	pshelar@ovn.org,
	andrey.zhadchenko@virtuozzo.com,
	brauner@kernel.org,
	dev@openvswitch.org
Subject: [PATCH net] net: openvswitch: reject negative ifindex
Date: Mon, 14 Aug 2023 13:38:40 -0700
Message-ID: <20230814203840.2908710-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes in net-next (commit 759ab1edb56c ("net: store netdevs
in an xarray")) refactored the handling of pre-assigned ifindexes
and let syzbot surface a latent problem in ovs. ovs does not validate
ifindex, making it possible to create netdev ports with negative
ifindex values. It's easy to repro with YNL:

$ ./cli.py --spec netlink/specs/ovs_datapath.yaml \
         --do new \
	 --json '{"upcall-pid": 1, "name":"my-dp"}'
$ ./cli.py --spec netlink/specs/ovs_vport.yaml \
	 --do new \
	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'

$ ip link show
-65536: some-port0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 7a:48:21:ad:0b:fb brd ff:ff:ff:ff:ff:ff
...

Validate the inputes. Now the second command correctly returns:

$ ./cli.py --spec netlink/specs/ovs_vport.yaml \
	 --do new \
	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'

lib.ynl.NlError: Netlink error: Numerical result out of range
nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
	error: -34	extack: {'msg': 'integer out of range', 'unknown': [[type:4 len:36] b'\x0c\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x03\x00\xff\xff\xff\x7f\x00\x00\x00\x00\x08\x00\x01\x00\x08\x00\x00\x00'], 'bad-attr': '.ifindex'}

Accept 0 since it used to be silently ignored.

Fixes: 54c4ef34c4b6 ("openvswitch: allow specifying ifindex of new interfaces")
Reported-by: syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: pshelar@ovn.org
CC: andrey.zhadchenko@virtuozzo.com
CC: brauner@kernel.org
CC: dev@openvswitch.org
---
 net/openvswitch/datapath.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index a6d2a0b1aa21..3d7a91e64c88 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1829,7 +1829,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	parms.port_no = OVSP_LOCAL;
 	parms.upcall_portids = a[OVS_DP_ATTR_UPCALL_PID];
 	parms.desired_ifindex = a[OVS_DP_ATTR_IFINDEX]
-		? nla_get_u32(a[OVS_DP_ATTR_IFINDEX]) : 0;
+		? nla_get_s32(a[OVS_DP_ATTR_IFINDEX]) : 0;
 
 	/* So far only local changes have been made, now need the lock. */
 	ovs_lock();
@@ -2049,7 +2049,7 @@ static const struct nla_policy datapath_policy[OVS_DP_ATTR_MAX + 1] = {
 	[OVS_DP_ATTR_USER_FEATURES] = { .type = NLA_U32 },
 	[OVS_DP_ATTR_MASKS_CACHE_SIZE] =  NLA_POLICY_RANGE(NLA_U32, 0,
 		PCPU_MIN_UNIT_SIZE / sizeof(struct mask_cache_entry)),
-	[OVS_DP_ATTR_IFINDEX] = {.type = NLA_U32 },
+	[OVS_DP_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
 };
 
 static const struct genl_small_ops dp_datapath_genl_ops[] = {
@@ -2302,7 +2302,7 @@ static int ovs_vport_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	parms.port_no = port_no;
 	parms.upcall_portids = a[OVS_VPORT_ATTR_UPCALL_PID];
 	parms.desired_ifindex = a[OVS_VPORT_ATTR_IFINDEX]
-		? nla_get_u32(a[OVS_VPORT_ATTR_IFINDEX]) : 0;
+		? nla_get_s32(a[OVS_VPORT_ATTR_IFINDEX]) : 0;
 
 	vport = new_vport(&parms);
 	err = PTR_ERR(vport);
@@ -2539,7 +2539,7 @@ static const struct nla_policy vport_policy[OVS_VPORT_ATTR_MAX + 1] = {
 	[OVS_VPORT_ATTR_TYPE] = { .type = NLA_U32 },
 	[OVS_VPORT_ATTR_UPCALL_PID] = { .type = NLA_UNSPEC },
 	[OVS_VPORT_ATTR_OPTIONS] = { .type = NLA_NESTED },
-	[OVS_VPORT_ATTR_IFINDEX] = { .type = NLA_U32 },
+	[OVS_VPORT_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
 	[OVS_VPORT_ATTR_NETNSID] = { .type = NLA_S32 },
 	[OVS_VPORT_ATTR_UPCALL_STATS] = { .type = NLA_NESTED },
 };
-- 
2.41.0


