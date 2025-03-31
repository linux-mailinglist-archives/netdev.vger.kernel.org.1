Return-Path: <netdev+bounces-178252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415D0A75F0E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 08:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167C47A3050
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 06:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A118B48B;
	Mon, 31 Mar 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAuq3V7b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07F38F80
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403990; cv=none; b=iLMyTE/5sMLryo68FjATJfMumysxnJKEnpPNuXifule5hQqrnhDD4wys9jq22U8t6n7+WU4C+dVOpEGvAvXg5+c7ryUIr4SceDQLPyB0NHA15btlcoebks0eCUMZ3TInBKnMrh8skVG/98CPbQfPj3DSn0ja4XIaHBuGYDMb+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403990; c=relaxed/simple;
	bh=FAP1uFngi3txu2jcmcowfO+bhV84fsioCaY71nIE/+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WPNPf47dy+9fiyBIkF2u4xwGwTMl5TbN+824ArQG8Nncmi2bS2WEGjwGbntZxwbd2EGYefmR4pJ9zt2JeRXJJFAW6fIL+eg+tkK8dkhF9sCvse9laRtxwMnlKh8qk7HNjXmEBX9t1KtTl4mfYM08QyGJ5zAt7uJDeBvPjrAZicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAuq3V7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2D5C4CEE3;
	Mon, 31 Mar 2025 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743403989;
	bh=FAP1uFngi3txu2jcmcowfO+bhV84fsioCaY71nIE/+o=;
	h=From:Date:Subject:To:Cc:From;
	b=BAuq3V7b0YUom6d2OXCQJUo4Hh6iKc8hOW2pdnRqaqZCj1x8efk9SWjEIUZXOxlgY
	 x+m3n2OwYUHyjHbarz9ATAdvW4LDPu24EWfUS5XVF88nVEL0tccc7YDyl/xE093UeR
	 7dPjfOyH/yf6GsuW1vG1NF5g4fEBJGiNgrOnQj47bQtxtWdT4zPFsFwX4Kh/p780wV
	 5nz50asv6x3TunjTeq4ndb+9JtFPh0pU9Jyat0TybkCgjM6wImUDBGfJ0v1K6XDrlD
	 9SzzpaTJx9gTHmQ8MyiCnaGSi23l1q1hh8us9S0IVHPnvwon1xYVCIQsu2gB6sdm0J
	 6HVH5xLbzCjuw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 31 Mar 2025 08:52:53 +0200
Subject: [PATCH net] net: airoha: Fix qid report in
 airoha_tc_get_htb_get_leaf_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-airoha-htb-qdisc-offload-del-fix-v1-1-4ea429c2c968@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMQ76mcC/x2NQQqAIBAAvxJ7bqG0sPpKdNBccyGyNCKI/p50n
 DnMPJAoMiUYigciXZw4bBnqsoDZ620hZJsZRCXaSsoaNcfgNfrT4GE5zRicW4O2aGlFxzcqRU0
 nVG+kVJAze6Ss/8U4ve8HaxOvvnIAAAA=
X-Change-ID: 20250331-airoha-htb-qdisc-offload-del-fix-77e48279b337
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix the following kernel warning deleting HTB offloaded leafs and/or root
HTB qdisc in airoha_eth driver properly reporting qid in
airoha_tc_get_htb_get_leaf_queue routine.

$tc qdisc replace dev eth1 root handle 10: htb offload
$tc class add dev eth1 arent 10: classid 10:4 htb rate 100mbit ceil 100mbit
$tc qdisc replace dev eth1 parent 10:4 handle 4: ets bands 8 \
 quanta 1514 3028 4542 6056 7570 9084 10598 12112
$tc qdisc del dev eth1 root

[   55.827864] ------------[ cut here ]------------
[   55.832493] WARNING: CPU: 3 PID: 2678 at 0xffffffc0798695a4
[   55.956510] CPU: 3 PID: 2678 Comm: tc Tainted: G           O 6.6.71 #0
[   55.963557] Hardware name: Airoha AN7581 Evaluation Board (DT)
[   55.969383] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   55.976344] pc : 0xffffffc0798695a4
[   55.979851] lr : 0xffffffc079869a20
[   55.983358] sp : ffffffc0850536a0
[   55.986665] x29: ffffffc0850536a0 x28: 0000000000000024 x27: 0000000000000001
[   55.993800] x26: 0000000000000000 x25: ffffff8008b19000 x24: ffffff800222e800
[   56.000935] x23: 0000000000000001 x22: 0000000000000000 x21: ffffff8008b19000
[   56.008071] x20: ffffff8002225800 x19: ffffff800379d000 x18: 0000000000000000
[   56.015206] x17: ffffffbf9ea59000 x16: ffffffc080018000 x15: 0000000000000000
[   56.022342] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
[   56.029478] x11: ffffffc081471008 x10: ffffffc081575a98 x9 : 0000000000000000
[   56.036614] x8 : ffffffc08167fd40 x7 : ffffffc08069e104 x6 : ffffff8007f86000
[   56.043748] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000001
[   56.050884] x2 : 0000000000000000 x1 : 0000000000000250 x0 : ffffff800222c000
[   56.058020] Call trace:
[   56.060459]  0xffffffc0798695a4
[   56.063618]  0xffffffc079869a20
[   56.066777]  __qdisc_destroy+0x40/0xa0
[   56.070528]  qdisc_put+0x54/0x6c
[   56.073748]  qdisc_graft+0x41c/0x648
[   56.077324]  tc_get_qdisc+0x168/0x2f8
[   56.080978]  rtnetlink_rcv_msg+0x230/0x330
[   56.085076]  netlink_rcv_skb+0x5c/0x128
[   56.088913]  rtnetlink_rcv+0x14/0x1c
[   56.092490]  netlink_unicast+0x1e0/0x2c8
[   56.096413]  netlink_sendmsg+0x198/0x3c8
[   56.100337]  ____sys_sendmsg+0x1c4/0x274
[   56.104261]  ___sys_sendmsg+0x7c/0xc0
[   56.107924]  __sys_sendmsg+0x44/0x98
[   56.111492]  __arm64_sys_sendmsg+0x20/0x28
[   56.115580]  invoke_syscall.constprop.0+0x58/0xfc
[   56.120285]  do_el0_svc+0x3c/0xbc
[   56.123592]  el0_svc+0x18/0x4c
[   56.126647]  el0t_64_sync_handler+0x118/0x124
[   56.131005]  el0t_64_sync+0x150/0x154
[   56.134660] ---[ end trace 0000000000000000 ]---

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c0a642568ac115ea9df6fbaf7133627a4405a36c..20a96cafc748e97a8ff9ab33a5be71ab62e8c9c5 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2358,7 +2358,7 @@ static int airoha_tc_get_htb_get_leaf_queue(struct airoha_gdm_port *port,
 		return -EINVAL;
 	}
 
-	opt->qid = channel;
+	opt->qid = AIROHA_NUM_TX_RING + channel;
 
 	return 0;
 }

---
base-commit: 2ea396448f26d0d7d66224cb56500a6789c7ed07
change-id: 20250331-airoha-htb-qdisc-offload-del-fix-77e48279b337

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


