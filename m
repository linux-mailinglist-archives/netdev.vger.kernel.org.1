Return-Path: <netdev+bounces-258755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJGBKIA1kWkXggEAu9opvQ
	(envelope-from <netdev+bounces-258755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 03:54:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E763D13DEEE
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 03:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C53303298E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 02:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E513C23815D;
	Sun, 15 Feb 2026 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEUv0teC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FC23EA8D
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771124058; cv=none; b=CB5Vqw7Iu/PdteU5jb5x5XwLJgh6ncOAfgltpxiUY2WV0e0he9311LFSl0nWQ+rCd6IWEU5lCVrXZ5L3+qbgXA7sclLAGIRfbYIcO3C/q2Lal4fO9/k2QFBk7FMVsPBK0/v355j+dznz+u4WaZBBIVbbdg8adS/TouHT+29sDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771124058; c=relaxed/simple;
	bh=yBGdYJxbGQO+UVkCKsfo5rmzOTIEwEE+eVWb4f9pZHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUhbTcmiw9e3mAVYjbgU2oQkcCSGRjdEPXLMe3fyzzMuH8WhuI1V9ZrVBcGf1T2gZTre9ShiybuJjO5hXx4UhX1Jc6qY40xAL4bOv4vKaJVdaxPvSbphgwdSHc5KY/DbAjnkz9ZWx1I3JmoFg1rPt1ldgWzvyt/jI11QcIAY+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEUv0teC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896fa834290so26167966d6.1
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 18:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771124056; x=1771728856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDMwIoF3IMhdmhhSXK52Nmob0Yt03qXT88kkZlSh0ds=;
        b=WEUv0teCS/lImJIyU73Jv1NIPep7GVLZEdWGhRABHD6Ea4YOILbq1l3Clgpa79Kr4d
         7EUXc3jGCU0co8el6+cABJ/2UMKY2cdDnUNPJdXVZnEKO1uzN3+kFCsy2ZxUzDCckE7K
         2Uj/HOvRhm05IaiFJdeHDwptY1SJWTYq6mKjeu1+wj8sRAtq4OTuX+w1TcIjbCBsEFTT
         5qyTaDmXWQlC5p5C/Rt/CMuGUzyHN0iolwjdNsBmeouO4LCUjwUUiro4/WvT1fm2PUZC
         yWo8J9zng7CcZFUElbFf0m2wj8SR9Q76ZtM54wBnsrkjaLaKAb3eNgSfDAf/7REYBOaT
         G4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771124056; x=1771728856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDMwIoF3IMhdmhhSXK52Nmob0Yt03qXT88kkZlSh0ds=;
        b=nda9maVZOfjMRxUhEDxbsNWI1zk25ZjL2HW+VpRF1kiyo9VDQL41K88Gf/2RaCXhn/
         pHBic54qt5bCeVHsTmAiG1BQizVlBkAu384DS+Uhtvvy69uPISDzNhefwYbPSvnzy52s
         6wRMQ+IHH0EiyfSabddy9ijzFEaoHJy6mhclU5lpGV/3XDP4Cea55C9IxOi+RsK3eii6
         k/lP4qlcWlV7l2uJlMzkxyZ/TnDDHrTb2uYPeSS4MR0+0djH2pxSxBf2oEIEGcujH+q3
         1OaKALCSLyGAN5KOHY1XJR/g9MvsXJ5w54A3n938s/DKl+sdvtgj6Nz/GDYiWEJkaGGe
         kWkQ==
X-Gm-Message-State: AOJu0YydhMS/iN99iGFDTJTfh53gGqdfwT4z9hdoP7XTXpEdfTnd/CdQ
	xHtzbfaonB5oWRtburoSusLeTUnkhlCZICKcPcc6VkNM1F7X5jqOox+eZMjMLw==
X-Gm-Gg: AZuq6aIsEW4H60bDpbll6b7kn+Ou3lf+kQvrZRem1JsqjbyWxKFIo69d3Sssu2gpyLP
	kgE3NDiAuauBl0QkbZNaIbwHTZmmqPfXxXYSkNSzw9VrKJ0GaAMTBFEppVJQ3+YqT/9c/+bgTC/
	RVd+7840V/6vZgZdYzuiWOc4N/jP0CwY+cmpJhjW04e/9HWfrhm+eF9XUMw2hj/ur8d/TC8BISc
	MpRWL7PEOVFInBiW4zkyigMqbXH5M6TjCIeMkwgo2ScKVak0FlUXUTJZ11Y0g+/+ifXaiDzRGhx
	K7nhqlLxnYIpJgP54nshdR5NbpbZneekrtFZVDaxaNMLJtEZ1jJxGaBDMIMYQo45oGcuco834GN
	6tTsczPSnzju8pY585klrx5GGdE1CZsEBgxc5YdpFFMWd/7DTw0gTUTvxNhwmR8JMymfXdCF/Ig
	z54sfgqVbKEt0moEg1LhlAtzvcbcdu9NC2wUFu4VApAap+7OOCzgWD1w==
X-Received: by 2002:a05:6214:62c:b0:896:fc1e:235f with SMTP id 6a1803df08f44-8973f344d6emr79654206d6.32.1771124056404;
        Sat, 14 Feb 2026 18:54:16 -0800 (PST)
Received: from I4-L-HQH5357-01.ad.psu.edu ([130.203.159.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cddc120sm119517306d6.52.2026.02.14.18.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 18:54:16 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net v2 1/1] serial: caif: fix remaining ser->tty UAF in TX path
Date: Sat, 14 Feb 2026 21:51:41 -0500
Message-Id: <20260215025141.1106576-2-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260215025141.1106576-1-shuangpeng.kernel@gmail.com>
References: <20260215025141.1106576-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258755-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E763D13DEEE
X-Rspamd-Action: no action

A reproducer exposes a KASAN use-after-free in caif_serial's TX path
(e.g., via tty_write_room() / tty->ops->write()) on top of commit
<308e7e4d0a84> ("serial: caif: fix use-after-free in caif_serial
ldisc_close()").

That commit moved tty_kref_put() to ser_release(). There is still a race
because the TX path may fetch ser->tty and use it while ser_release()
drops the last tty reference:

    CPU 0 (ser_release worker)         CPU 1 (xmit)
    -------------------------        ------------
                                      caif_xmit()
                                      handle_tx()
                                        tty = ser->tty

    ser_release()
      tty = ser->tty
      dev_close(ser->dev)
      unregister_netdevice(ser->dev)
      debugfs_deinit(ser)
      tty_kref_put(tty)        // may drop the last ref
                     <-- race window -->
                                        tty->ops->write(tty, ...)  // UAF

Fix it by serializing accesses to ser->tty with a dedicated lock. The TX
path grabs a tty kref under the lock and drops it after the TX attempt,
while ser_release() clears ser->tty under the same lock before putting the
old tty reference. This prevents the TX path from observing a freed tty
object via ser->tty.

With this change applied, the reproducer no longer triggers the UAF in my
test.

One concern is that handle_tx() can be a hot path. This fix adds a short
lock-held section plus an extra tty kref get/put per TX run. Feedback on
the performance impact, or suggestions for a lower-overhead approach, are
welcome.

Link: https://groups.google.com/g/syzkaller/c/usNe0oKtoXw/m/x8qUc3yUAQAJ
Fixes: 308e7e4d0a84 ("serial: caif: fix use-after-free in caif_serial ldisc_close()")
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/net/caif/caif_serial.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index b90890030751..ddd90d01cd40 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -68,6 +68,7 @@ struct ser_device {
 	struct net_device *dev;
 	struct sk_buff_head head;
 	struct tty_struct *tty;
+	spinlock_t tty_lock; /* protects ser->tty */
 	bool tx_started;
 	unsigned long state;
 #ifdef CONFIG_DEBUG_FS
@@ -197,12 +198,21 @@ static int handle_tx(struct ser_device *ser)
 	struct sk_buff *skb;
 	int tty_wr, len, room;
 
+	spin_lock(&ser->tty_lock);
 	tty = ser->tty;
+	tty_kref_get(tty);
+	spin_unlock(&ser->tty_lock);
+
+	if (!tty)
+		return 0;
+
 	ser->tx_started = true;
 
 	/* Enter critical section */
-	if (test_and_set_bit(CAIF_SENDING, &ser->state))
+	if (test_and_set_bit(CAIF_SENDING, &ser->state)) {
+		tty_kref_put(tty);
 		return 0;
+	}
 
 	/* skb_peek is safe because handle_tx is called after skb_queue_tail */
 	while ((skb = skb_peek(&ser->head)) != NULL) {
@@ -245,9 +255,11 @@ static int handle_tx(struct ser_device *ser)
 		ser->common.flowctrl != NULL)
 				ser->common.flowctrl(ser->dev, ON);
 	clear_bit(CAIF_SENDING, &ser->state);
+	tty_kref_put(tty);
 	return 0;
 error:
 	clear_bit(CAIF_SENDING, &ser->state);
+	tty_kref_put(tty);
 	return tty_wr;
 }
 
@@ -293,7 +305,10 @@ static void ser_release(struct work_struct *work)
 	if (!list_empty(&list)) {
 		rtnl_lock();
 		list_for_each_entry_safe(ser, tmp, &list, node) {
+			spin_lock(&ser->tty_lock);
 			tty = ser->tty;
+			ser->tty = NULL;
+			spin_unlock(&ser->tty_lock);
 			dev_close(ser->dev);
 			unregister_netdevice(ser->dev);
 			debugfs_deinit(ser);
@@ -330,6 +345,7 @@ static int ldisc_open(struct tty_struct *tty)
 		return -ENOMEM;
 
 	ser = netdev_priv(dev);
+	spin_lock_init(&ser->tty_lock);
 	ser->tty = tty_kref_get(tty);
 	ser->dev = dev;
 	debugfs_init(ser, tty);
-- 
2.34.1


