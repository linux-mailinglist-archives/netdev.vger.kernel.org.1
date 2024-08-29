Return-Path: <netdev+bounces-123426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFCB964D3D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0071F22ADC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87C1B583F;
	Thu, 29 Aug 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i8+bLNh4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i8+bLNh4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB28192B85;
	Thu, 29 Aug 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953927; cv=none; b=IO1ADIGak4foMPhQdqEq42OdoSn4mirxY9GfRjXWSwRUf6z7BBxQbvg1xhEETi8Euaabg2bofvD4yYZK06chbDgUDd+1jjOEFiMQw1J0sWu4axYFgLGJQ1McZMk9WEU77DkIGets6rAOH2xPeYRCL/SmNf+wCZrjFtWatImzydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953927; c=relaxed/simple;
	bh=yXNatUfBjc4wB02MKsfPhU9639KrQX5xGYPz47w5l40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jmph5MX+2az4ZyFWQP0HcCDl4PixmOY7v4QkLkxT1wsJLgbEtd89+HnrFlYrIkfVOc+D0jUrlNCIxg3ogtaHhKsjQuPvun9K0E1Rs7X4eY/8+3OUlETnKq0OTkRhSjEh2iYTidbHsh8gMgLPjeJRUc7cL2eVeoq/BitWiSUDmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i8+bLNh4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i8+bLNh4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47C401F455;
	Thu, 29 Aug 2024 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724953924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6SvYEfpScUFeQtPKK/sEjRJJLkXkYqMv9tPfmouJHac=;
	b=i8+bLNh4uI0CIf4U3AAkjJEvUIXCx69MWWmpSlgILZ6JNxyzAm71zk7CIsjs8K+gWdAi0T
	vf4W5KRJYxSeKp5z6U+XMTh6WLgwEU1lSxJd2B8DI2wAmfSO7U/sfcSZ8CMjEJ5CiQjYCA
	vcbMFfv/1xoqf/I9Mfph6uzk/AFjzB4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724953924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6SvYEfpScUFeQtPKK/sEjRJJLkXkYqMv9tPfmouJHac=;
	b=i8+bLNh4uI0CIf4U3AAkjJEvUIXCx69MWWmpSlgILZ6JNxyzAm71zk7CIsjs8K+gWdAi0T
	vf4W5KRJYxSeKp5z6U+XMTh6WLgwEU1lSxJd2B8DI2wAmfSO7U/sfcSZ8CMjEJ5CiQjYCA
	vcbMFfv/1xoqf/I9Mfph6uzk/AFjzB4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0238913408;
	Thu, 29 Aug 2024 17:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ldryOkO10GaEEgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 29 Aug 2024 17:52:03 +0000
From: Oliver Neukum <oneukum@suse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCHv2 net] usbnet: modern method to get random MAC
Date: Thu, 29 Aug 2024 19:50:55 +0200
Message-ID: <20240829175201.670718-1-oneukum@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The driver generates a random MAC once on load
and uses it over and over, including on two devices
needing a random MAC at the same time.

Jakub suggested revamping the driver to the modern
API for setting a random MAC rather than fixing
the old stuff.

The bug is as old as the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>

---

v2: Correct commentary style

 drivers/net/usb/usbnet.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index dfc37016690b..40536e1cb4df 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -61,9 +61,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-// randomly generated ethernet address
-static u8	node_id [ETH_ALEN];
-
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
 module_param (msg_level, int, 0);
@@ -1743,7 +1740,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 
 	dev->net = net;
 	strscpy(net->name, "usb%d", sizeof(net->name));
-	eth_hw_addr_set(net, node_id);
 
 	/* rx and tx sides can use different message sizes;
 	 * bind() should set rx_urb_size in that case.
@@ -1819,9 +1815,9 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		goto out4;
 	}
 
-	/* let userspace know we have a random address */
-	if (ether_addr_equal(net->dev_addr, node_id))
-		net->addr_assign_type = NET_ADDR_RANDOM;
+	/* this flags the device for user space */
+	if (!is_valid_ether_addr(net->dev_addr))
+		eth_hw_addr_random(net);
 
 	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
 		SET_NETDEV_DEVTYPE(net, &wlan_type);
@@ -2229,7 +2225,6 @@ static int __init usbnet_init(void)
 	BUILD_BUG_ON(
 		sizeof_field(struct sk_buff, cb) < sizeof(struct skb_data));
 
-	eth_random_addr(node_id);
 	return 0;
 }
 module_init(usbnet_init);
-- 
2.45.2


