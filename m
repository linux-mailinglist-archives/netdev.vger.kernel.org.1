Return-Path: <netdev+bounces-253926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOY1EYjbeGmwtgEAu9opvQ
	(envelope-from <netdev+bounces-253926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:36:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CF96D5F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050C83005D06
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE422264A9;
	Tue, 27 Jan 2026 15:32:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13614A62B
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527936; cv=none; b=o6Vu43AGapcTEtlESdwzXmk3BCHRlhUFwEuDvqG7u7uVJv9hF8wyo1ADXWglcxaZajI0KkuemrDDxSxUpufuzgGuyeGg37I9NqDyV0XOgmiKnl88in+u42FUrEOcdrrY0tF7nWIO9k4ATyKjAESSQh/m+aPJVTR29H2noS8HzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527936; c=relaxed/simple;
	bh=kQ6WBdNxjV8DwnHaqql83yoWC4IAhD827rNzztzAHH8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=B5Gp+TEZ6B7Iud+NdLIXGPv0osWV9q4psCeYrEEWyvPRev31LC3+gzx92b74Yqx5xrBokGmhIx4rqfW4eoGy9IZ3PIH9kOvyelIMxu8v4YqMjjwp4HPRKQOB7n7XCUJVKh/SMfTCS/5c3BW1MqWV4BFSG/wbLIrgBAsiVPJ4ISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60RFWCXL099761;
	Wed, 28 Jan 2026 00:32:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60RFWBiP099756
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 28 Jan 2026 00:32:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
Date: Wed, 28 Jan 2026 00:32:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ilan Tayari <ilant@mellanox.com>, Guy Shapiro <guysh@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Leon Romanovsky <leon@kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253926-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 1B7CF96D5F
X-Rspamd-Action: no action

syzbot is reporting that "struct xfrm_state" refcount is leaking.

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
  ref_tracker: netdev@ffff888052f24618 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
       xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
       xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
       xfrm_add_sa+0x34ff/0x5fa0 net/xfrm/xfrm_user.c:1022
       xfrm_user_rcv_msg+0x58e/0xc00 net/xfrm/xfrm_user.c:3507
       netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
       xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3529
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
       __sys_sendmsg+0x16d/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

This is because currently xfrm_dev_down() (which is called upon NETDEV_DOWN
event and NETDEV_UNREGISTER event) can release the reference to
"struct net_device" taken by xfrm_dev_state_add() only if
the NETIF_F_HW_ESP bit is set, but the NETIF_F_HW_ESP bit can be cleared
by "ethtool -K $dev esp-hw-offload off" command.
In other words, we cannot guess whether xfrm_dev_state_add() has taken a
reference to "struct net_device" based on whether the NETIF_F_HW_ESP bit
is currently set.

For recording why this patch does not re-introduce xfrm_dev_unregister(),
my guessed history about this module's NETDEV_UNREGISTER handler is shown
below.

Commit d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
introduced xfrm_dev_state_add(). That commit called xfrm_dev_state_add()
 from xfrm_state_construct(), and introduced the NETDEV_UNREGISTER case
to xfrm_dev_event(). But that commit implemented xfrm_dev_unregister() as
a no-op, and implemented xfrm_dev_down() to call xfrm_dev_state_flush()
only if (dev->features & NETIF_F_HW_ESP) != 0. I guess that that commit
expected that NETDEV_DOWN event is fired before NETDEV_UNREGISTER event
fires, and also assumed that xfrm_dev_state_add() is called only if
(dev->features & NETIF_F_HW_ESP) != 0.

Commit ec30d78c14a8 ("xfrm: add xdst pcpu cache") added
xfrm_policy_cache_flush() call to xfrm_dev_unregister(), but
commit e4db5b61c572 ("xfrm: policy: remove pcpu policy cache") removed
xfrm_policy_cache_flush() call from xfrm_dev_unregister() and also
removed the NETDEV_UNREGISTER case from xfrm_dev_event() because
xfrm_dev_unregister() again became no-op.

Commit 03891f820c21 ("xfrm: handle NETDEV_UNREGISTER for xfrm device")
re-introduced the NETDEV_UNREGISTER case to xfrm_dev_event(), but that
commit for unknown reason chose to share xfrm_dev_down() between the
NETDEV_DOWN case and the NETDEV_UNREGISTER case. Therefore, I assumed
that doing the same behavior for both cases is desirable. If something
is wrong with this choice, please re-introduce xfrm_dev_unregister().

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Previous discussion is https://lkml.kernel.org/r/924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp

 net/xfrm/xfrm_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29..26e62b6a9db5 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -536,10 +536,8 @@ static int xfrm_api_check(struct net_device *dev)
 
 static int xfrm_dev_down(struct net_device *dev)
 {
-	if (dev->features & NETIF_F_HW_ESP) {
-		xfrm_dev_state_flush(dev_net(dev), dev, true);
-		xfrm_dev_policy_flush(dev_net(dev), dev, true);
-	}
+	xfrm_dev_state_flush(dev_net(dev), dev, true);
+	xfrm_dev_policy_flush(dev_net(dev), dev, true);
 
 	return NOTIFY_DONE;
 }
-- 
2.47.3

