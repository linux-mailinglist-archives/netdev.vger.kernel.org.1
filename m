Return-Path: <netdev+bounces-253129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zt6aCgGmdWlkHAEAu9opvQ
	(envelope-from <netdev+bounces-253129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 06:11:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A648E7FC86
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 06:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB063009506
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 05:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616CE1DE4F1;
	Sun, 25 Jan 2026 05:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87753EBF03
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769317883; cv=none; b=KLiRftItrJ7WWdcZe6wTzgNQX3pdvP9CfWWROdTeQ8Spxj29WLQaxfMMxs9ena0mGphnwrqBLDVzWTUs3FdCtxqYChIM3al9m/N2khf4hpH1JRVbl8h7G7a/bQ8Jbqc0edm3D4p0snnzWfou0iUwpd+BBRkpFbfY/8YWztbeh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769317883; c=relaxed/simple;
	bh=PeIGU62kqxXXjk3ZXB8Bhxe/3Ckmh48FAKPrLERcZ0U=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=r9zcgZIxXYwFZiQP/hVZQhzrrkTl8hTa6/F/xicJZPpI+7vO4Nu2wc4vslAHmBVE0/YvdD5mCHxH0xUBI+4uGXE0EUE8k39ycjbt/1kXmfA/q2wgXzD3kuwQ0rIzoZhJFyjGe3xYyXJWH05diPXiElS7J8IB77dtd9etiRMl62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60P5BI49017274;
	Sun, 25 Jan 2026 14:11:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60P5BIkV017271
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 25 Jan 2026 14:11:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7fe2645c-680d-4fbe-981b-67a041f0d9c9@I-love.SAKURA.ne.jp>
Date: Sun, 25 Jan 2026 14:11:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] ipv4: don't call inetdev_init() if device is no longer
 registered
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-253129-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,ffff88807dcf8618:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: A648E7FC86
X-Rspamd-Action: no action

syzbot is reporting

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 3
  ref_tracker: netdev@ffff88807dcf8618 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_hold include/linux/netdevice.h:4429 [inline]
       inetdev_init+0x201/0x4e0 net/ipv4/devinet.c:286
       inetdev_event+0x251/0x1610 net/ipv4/devinet.c:1600
       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
       call_netdevice_notifiers_mtu net/core/dev.c:2318 [inline]
       netif_set_mtu_ext+0x5aa/0x800 net/core/dev.c:9886
       netif_set_mtu+0xd7/0x1b0 net/core/dev.c:9907
       dev_set_mtu+0x126/0x260 net/core/dev_api.c:248
       team_port_del+0xb07/0xcb0 drivers/net/team/team_core.c:1333
       team_del_slave drivers/net/team/team_core.c:1936 [inline]
       team_device_event+0x207/0x5b0 drivers/net/team/team_core.c:2929
       notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2281 [inline]
       call_netdevice_notifiers net/core/dev.c:2295 [inline]
       __dev_change_net_namespace+0xcb7/0x2050 net/core/dev.c:12592
       do_setlink+0x2ce/0x4590 net/core/rtnetlink.c:3060
       rtnl_changelink net/core/rtnetlink.c:3776 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3935 [inline]
       rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4072
       rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6958
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894

problem, for commit 06770843c2f0 ("ipv: Re-enable IP when MTU > 68")
did not expect that NETDEV_CHANGEMTU event is fired as a part of
NETDEV_UNREGISTER event.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: 06770843c2f0 ("ipv: Re-enable IP when MTU > 68")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Since there is no reproducer for this problem, I can't test this change.
But I think that ref_tracker indicates that NETDEV_CHANGEMTU event from
NETDEV_UNREGISTER event is causing netdev_hold() on NETREG_UNREGISTERING
device.

 net/ipv4/devinet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 942a887bf089..dc4359bfa103 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1594,7 +1594,7 @@ static int inetdev_event(struct notifier_block *this, unsigned long event,
 				IN_DEV_CONF_SET(in_dev, NOXFRM, 1);
 				IN_DEV_CONF_SET(in_dev, NOPOLICY, 1);
 			}
-		} else if (event == NETDEV_CHANGEMTU) {
+		} else if (event == NETDEV_CHANGEMTU && dev->reg_state != NETREG_UNREGISTERING) {
 			/* Re-enabling IP */
 			if (inetdev_valid_mtu(dev->mtu))
 				in_dev = inetdev_init(dev);
-- 
2.47.3


