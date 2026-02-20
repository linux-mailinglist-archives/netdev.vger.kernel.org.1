Return-Path: <netdev+bounces-259695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMLOJJQsmGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:42:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5071665C3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06CB30515E6
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2E324719;
	Fri, 20 Feb 2026 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qEkTPPsO"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DA32142E
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580508; cv=none; b=JMH9u8KSxhh0Cj4HUE5WM/o8Ktufu7MaW9MmJ+ZHGb47Fj913/3BK/bn3xO3I32SK1idEK6dPqZVMAeTucuhQDUNPe12yPnv/qhgZtLANa42ipl2OGqJ5Fgw0IyY3LQK5YYtkRKiYhLeM3a+cNMuho/KP2uhVVkPsaHJi1A1WRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580508; c=relaxed/simple;
	bh=HFzWxmlbNhIBhVI1cnJoHUIR+dDeir+GWvHzK4QG8b8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No3gcHhcIpeGfGpVLnG3s6b8rbBJkZtioLp76KwLxi3zHFsWyJUYn9mm6LfRaf3jFsB/hKljUgHTpozu6GLTRsyQyiK8nlFRWag9DjgYBaeFSAa3l5ljK6cgswY2Nd0uldEJ4w1JmwZAvea3iAO5ZwOf2z+/19m906ZxCzUU9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qEkTPPsO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EDA192083B;
	Fri, 20 Feb 2026 10:41:44 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ftHsRzEGqFr5; Fri, 20 Feb 2026 10:41:43 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 40B53207BE;
	Fri, 20 Feb 2026 10:41:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 40B53207BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1771580503;
	bh=VPMsX6F5NJ655qnrq6CDtiXbKVq1dxmrpuOrXRjS3Ds=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=qEkTPPsOc5E2qM4MSIvcYCXVCjb+cDt4qPLfYfbiniqR9RsUvzoA2pMY/c+2RF8Y2
	 bU7eRqccowTPREU5EnA7slq4A9PKMSIfT8WcASukTcmgdF7bGoJG5d6cam1wPRIRAg
	 p4Oc3YndUYHzsDxFy74kX7+lb7NuOtFamVzVdyJPFtFVig5ZWvgR6h1f0Uq5huCdrp
	 /0+LI8WN7YgiDvIzHl1iIElUALAaA77Qe9suXVRHl/hFl2ps4CB0mK/nBHDZ/F4Rqb
	 HUTGuue/1XfBVBqy7ZaICXtWd4nG+Oo6j8ujX6zvEJxmZ16MEnZjSbrvKx+Ag7WmEm
	 S6XpZU8lSVtZw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 10:41:42 +0100
Received: (nullmailer pid 16451 invoked by uid 1000);
	Fri, 20 Feb 2026 09:41:41 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/3] xfrm: always flush state and policy upon NETDEV_UNREGISTER event
Date: Fri, 20 Feb 2026 10:41:17 +0100
Message-ID: <20260220094133.14219-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220094133.14219-1-steffen.klassert@secunet.com>
References: <20260220094133.14219-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,secunet.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB5071665C3
X-Rspamd-Action: no action

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
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
2.43.0


