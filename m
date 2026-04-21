Return-Path: <netdev+bounces-280079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHjrIYhb52l87AEAu9opvQ
	(envelope-from <netdev+bounces-280079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:12:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 070CE439F2D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B42F4301ECDC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED13BE148;
	Tue, 21 Apr 2026 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NtjxE7I2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD83BD62A;
	Tue, 21 Apr 2026 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769925; cv=none; b=CeONc+vb1lcHk8ro2rdFfQvakoQ+fUTWX3NWUrRlbnazXbDUdfS5fMQ/frwO2h1JIX+PxGIiSlUacFAjwIzyhrGmSO1APXOseDp3mNQ4EJd1AsPg5b/Tu3BKcOBWFtNCtt1UAKHxcpMzKJWqkb7FFVlfNiRXvgB+059y7qI7+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769925; c=relaxed/simple;
	bh=P9Z2jLmgHDW55aDtEIgqTFaGBkg8kduWeGu9dllPAqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGVyT0GXkpl512YSLXNQQdnatSvBR5G/S7VCpDPJX9JO33o+Ig/MyKp7rYj678TQhjW+/IxMKKd0/smsi01Nj4XcsWZxu7SA04wJe+DMtkoY7VycAMRPPiHwdlCMYZEj+vDgvbyyTSs4LCW93zdhK0PJYcFVpcCSloM0LVPwUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NtjxE7I2; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776769847;
	bh=uhoRCrafoHUgV/zs6w9jHE8hikS9jDA0oyFpem7tNus=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NtjxE7I2lP9BkpLje/VfjVpCe0steuF1Ctbd9lBMdC45LXAWQQWhol+gJ4xUCIUi+
	 tR0dngAuPYiKvqBaOLHtDIxVMTK+yreQ6Y1PMOMyXk2pzGawrEw/FTiIYOgCS1jTPO
	 quxWNah9QwysNklK6lkUU2ZS+HHZKTcjqegrVIUY=
X-QQ-mid: esmtpgz10t1776769829tfb877a3e
X-QQ-Originating-IP: yud7h116OuWe9hhcZGb4gX28nGnD1E94DzSXnIsExQA=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Apr 2026 19:10:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14433049193172832886
EX-QQ-RecipientCnt: 10
From: Morduan Zang <zhangdandan@uniontech.com>
To: Petko Manolov <petkan@nucleusys.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Morduan Zang <zhangdandan@uniontech.com>
Subject: [PATCH] net: usb: rtl8150: free skb on usb_submit_urb() failure in xmit
Date: Tue, 21 Apr 2026 19:10:25 +0800
Message-ID: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M7dxyDFn9MPmMuc87DbMRmMKmDCoCphE5PU5RbUCdA6TUoSVZ0kW4YqH
	UeakIZ1ZrfYJ1y0fik/Jv6I4q/9ZOsSiBovE5GKGad/fxCI4+totaca0tpMmJegEKHzcq0I
	tZWg+Nl2ntXTLq6EVH6wMyQQfGrz8XPlgeptMq0vMX3VSOQHTuhV/D4tsuppgDN/Iq+hRZ6
	y7Sv7ARzAZ6mKU4GN+rLSDqQ/AFipd7SAyD0wseGnFhl4o5RuwfryTRPggwWA0/+hSsGmOc
	7cVIIBB0r1KpC1pU52FKWtVe8NS8XXjY6cJyEwqqYMrfUv6skGgWTNj4Hvw7EF6D6Xv0IUZ
	n5AUHphiRKf2SKuzw6SGXK2tzYAPtKiiZERHm6QvXJnuC29Q1pHJzF9m5R+jaEM09n/neFA
	ZQSi8TlOMW495orrqFa6QAx7djyxU9KiV87fhQDNoui+qbXSqaGAt96JE0k/uzIOWtqEvf/
	kmLP94tJaBy6GqryNSYnM0n5XoTizsOcSlQZtLIVwdU1zfAPBETXJChwZFyzhWkl5TPZQY1
	NZ7T3rBonT6kTnjnwkkDtWHtRqthUPmc3s++qxlzqzHVxi1ZaXpXIgVYNe6FRw4Cqp5aqwg
	ltqfAXz/xUjU8z0xJ97sv0n//hwoeHO6k7OWRt0YmiBVsAW+cjukfThA2NKHUUhIW8LSYdO
	GVzA6osi93r62Qs6p9IYbsV9mm/8BRy8ykKt/JlWWrfGZgqdVE6tysBvBnWBnjOeftOx9lv
	Ia8aB1NFempvNBUyA2IY3ODfXWYTn3LRZLJ5uTVJEJbda0jeshrEpDeWYj4oYGNosaGBBGK
	xXhhXlyYJ++dGq+ybGQ49ZcNexNCDEynHit65AuyjRoI046C3ML+l3Jqr++SBeZQW3zbkez
	hZddD/kJ5VMkZS74E1So7BSOEMqacQ+o7NAZJJsb6MyiaWqRW2PZr4jJzeXy/cksxwAABAa
	jJVcGRqcu33FL1aUMHBx/vxz+B23xwp4B/CCYhTA1oHc5JWkqQpeNJ6gi+xIQA7BNnkllW4
	KjRN7qVD6ibM6XWI16nmIHrtlBtYrqMhU1M9XRg7bQHva2oigrC7gk9PaXJmE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-280079-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email,uniontech.com:dkim,uniontech.com:mid]
X-Rspamd-Queue-Id: 070CE439F2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When rtl8150_start_xmit() fails to submit the tx URB, the URB is never
handed to the USB core and write_bulk_callback() will not run.  The
driver returns NETDEV_TX_OK, which tells the networking stack that the
skb has been consumed, but nothing actually frees the skb on this
error path:

  dev->tx_skb = skb;
  ...
  if ((res = usb_submit_urb(dev->tx_urb, GFP_ATOMIC))) {
          ...
          /* no kfree_skb here */
  }
  return NETDEV_TX_OK;

This leaks the skb on every submit failure and also leaves dev->tx_skb
pointing at memory that the driver itself may later free, which is
fragile.

Free the skb with dev_kfree_skb_any() in the error path and clear
dev->tx_skb so no stale pointer is left behind.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
---
 drivers/net/usb/rtl8150.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index a0f790a368ba..d358b6d41a53 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -716,6 +716,13 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 			netdev->stats.tx_errors++;
 			netif_start_queue(netdev);
 		}
+		/*
+		 * The URB was not submitted, so write_bulk_callback() will
+		 * never run to free dev->tx_skb.  Drop the skb here and
+		 * clear tx_skb to avoid leaving a stale pointer.
+		 */
+		dev->tx_skb = NULL;
+		dev_kfree_skb_any(skb);
 	} else {
 		netdev->stats.tx_packets++;
 		netdev->stats.tx_bytes += skb_len;
-- 
2.50.1


