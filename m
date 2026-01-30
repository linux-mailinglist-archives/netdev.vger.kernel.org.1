Return-Path: <netdev+bounces-255098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMf0LzWLfGnSNgIAu9opvQ
	(envelope-from <netdev+bounces-255098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:43:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86DB9722
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4573C300D176
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5BC36997F;
	Fri, 30 Jan 2026 10:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD533EAED
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769778; cv=none; b=L/t/pLk8YQ6MoR6J3PFpZmzDsBSiZ4QEGnJCT2oNOY8YooBIxMevRzoFxiidDLptq9nDqtPKv2u+ZyzOC4irPRrVfO/+/RqkUPLmW3cg3dLWf5zMvu2Y5h5hWjZrv+GsZwuUY4Yieqs2/6VFV38Qqpy9cqF9JM+05n789ZVemFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769778; c=relaxed/simple;
	bh=LHGFYVdFs7XVfQiGqqpy9wFdvOghvKWLadMefjklVKQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jshX5qEkrNQhHIZjVeCZn5iEQMurvuOAOjis3CH38q2DzO8z+YKjBVo5iwxW3mU3evc9bE0TaiQzdgRd8O1nFBUOoIwNbmwP9ZmRa7l9DNqNIEWYpy9t+5SmlZ6oqEey+KP/UcF2CR6Pp/kAdteAYT+gjkB11hd+V7X34kjktcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60UAgnuB028767;
	Fri, 30 Jan 2026 19:42:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60UAgmef028764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 30 Jan 2026 19:42:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp>
Date: Fri, 30 Jan 2026 19:42:47 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>, Leon Romanovsky <leon@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Ilan Tayari <ilant@mellanox.com>, Guy Shapiro <guysh@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH net v2] xfrm: always flush state and policy upon
 NETDEV_UNREGISTER event
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255098-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,I-love.SAKURA.ne.jp:mid,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 9D86DB9722
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

This is because commit d77e38e612a0 ("xfrm: Add an IPsec hardware
offloading API") implemented xfrm_dev_unregister() as no-op despite
xfrm_dev_state_add() from xfrm_state_construct() acquires a reference
to "struct net_device".
I guess that that commit expected that NETDEV_DOWN event is fired before
NETDEV_UNREGISTER event fires, and also assumed that xfrm_dev_state_add()
is called only if (dev->features & NETIF_F_HW_ESP) != 0.

Sabrina Dubroca identified steps to reproduce the same symptoms as below.

  echo 0 > /sys/bus/netdevsim/new_device
  dev=$(ls -1 /sys/bus/netdevsim/devices/netdevsim0/net/)
  ip xfrm state add src 192.168.13.1 dst 192.168.13.2 proto esp \
     spi 0x1000 mode tunnel aead 'rfc4106(gcm(aes))' $key 128   \
     offload crypto dev $dev dir out
  ethtool -K $dev esp-hw-offload off
  echo 0 > /sys/bus/netdevsim/del_device

Like these steps indicate, the NETIF_F_HW_ESP bit can be cleared after
xfrm_dev_state_add() acquired a reference to "struct net_device".
Also, xfrm_dev_state_add() does not check for the NETIF_F_HW_ESP bit
when acquiring a reference to "struct net_device".

Commit 03891f820c21 ("xfrm: handle NETDEV_UNREGISTER for xfrm device")
re-introduced the NETDEV_UNREGISTER event to xfrm_dev_event(), but that
commit for unknown reason chose to share xfrm_dev_down() between the
NETDEV_DOWN event and the NETDEV_UNREGISTER event.
I guess that that commit missed the behavior in the previous paragraph.

Therefore, we need to re-introduce xfrm_dev_unregister() in order to
release the reference to "struct net_device" by unconditionally flushing
state and policy.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
v2:
  - Don't change xfrm_dev_down(), re-introduce xfrm_dev_unregister() instead.

v1:
  - https://lkml.kernel.org/r/1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp

 net/xfrm/xfrm_device.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29..550457e4c4f0 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -544,6 +544,14 @@ static int xfrm_dev_down(struct net_device *dev)
 	return NOTIFY_DONE;
 }
 
+static int xfrm_dev_unregister(struct net_device *dev)
+{
+	xfrm_dev_state_flush(dev_net(dev), dev, true);
+	xfrm_dev_policy_flush(dev_net(dev), dev, true);
+
+	return NOTIFY_DONE;
+}
+
 static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
@@ -556,8 +564,10 @@ static int xfrm_dev_event(struct notifier_block *this, unsigned long event, void
 		return xfrm_api_check(dev);
 
 	case NETDEV_DOWN:
-	case NETDEV_UNREGISTER:
 		return xfrm_dev_down(dev);
+
+	case NETDEV_UNREGISTER:
+		return xfrm_dev_unregister(dev);
 	}
 	return NOTIFY_DONE;
 }
-- 
2.47.3


