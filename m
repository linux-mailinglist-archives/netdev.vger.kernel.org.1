Return-Path: <netdev+bounces-258403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e35pAbRVjWnK1AAAu9opvQ
	(envelope-from <netdev+bounces-258403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 05:23:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF612A4B9
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 05:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFC5730A455E
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 04:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5AD1B983F;
	Thu, 12 Feb 2026 04:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRbZiFRJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B87770FE
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 04:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770870190; cv=none; b=Gs9Zv2qEoLYi/g/+Z8+lZjrparqB7AN0E5Q/l0FITy1XvijsLoNJDyUmo+WklMcE5Zg/WRJxT1yWizXk0S+tlyArMcuIl78rZ9qNgrgDKzcxPidr5IQbJ0uh3JUeEU61N2yg4X6Fx4TwCn20Fl0HgLVkSCXc2m+XJq+MYui6d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770870190; c=relaxed/simple;
	bh=vVzPLok3+u8PoRchq7QGvG8X2iXyTnBTrdE1g5c0v0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EXP7unO/knffXLTkd0sq8wI8wIeCm1hw1sOg+d2PklgHP+KsFoZG9PqGlta0eIICqGLlp5V58sJwdNf5ZkhDZJ1/Fv1goFloy7CX7MpkYg5/tI5IAnYodoHO0iHPuWCuuQxPw0toPJHBpFXQx5zuNnj7BRMWHddqReuw52RpBbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRbZiFRJ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c70ce93afaso289284585a.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 20:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770870188; x=1771474988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNMvr4QOgmqieZYLEhyQ6uHpbDNLKTTtTYDiugqax8c=;
        b=DRbZiFRJUA8EFqOuA9Wg5BPb2ajneAvWWlO6qyu3aLMhmhLB/ArxML4mtakWIz7Io3
         eFeu51cNbdmnoEqB7hTa7Sh6eQgqvaj5O5ef7kpwiG2xYG98NYQaOuFfLr1+JzrmLo3o
         2OslUFITsu6sSDxxyjcGdAWyseXo006YY8ZBjPfMLqdhIWhCXd+e2b4HQj9Gh1R4Xue+
         RUGt6u8ZWeOmM+MlEY0yGalVaSN2EvB7yOVLLz6NFwU0y/nP18E/qc8/xC5BjYRw+FuU
         eklCz1Ery0xE/o94SZsRMJjtGdlWPzVFSL1s1dVG/nCIfuPcSiXeZKQWpjlWAwLq9s8g
         +h1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770870188; x=1771474988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNMvr4QOgmqieZYLEhyQ6uHpbDNLKTTtTYDiugqax8c=;
        b=euskSyGTGj5SAby3qaDCT1vNSf8pn2e/cvCts42tON/m6fpq6CFH2W44k93+9CbNNx
         DBxLMtEIcSKJnkhdf0sqNZW2TDsFKOPSfmFcONxlJ2mhp02LibfP4Y5ByedyuHEodomi
         OJCUbT5Eaz95ROSantX/ddwG1mTO9Stk3eNk4+X/Pcrr6M/7F18HTyMPEbVIEnqS16TX
         FyHnDmXsiOAexLwE7oQKoR4kpblJUHJs4aOEHvebkvgeg+vewSt4k9FaNIryeHr7N0Js
         EAzKUg1PbFXIkJHCVbIPj1TwbHB5TS2PKqTPp8xN/Vn6Ca8n+I+R5ZiHVlEfJkciDpvA
         eYmA==
X-Gm-Message-State: AOJu0Yz7S/jYR/O7jXSrPXwA5fD5ZXitjhdR3QHyQ8YyPaXJ+cxUkosm
	eRydYzpp/fm/cuC4uvfGpfaoVa8pqeltV1QwzMmSOgscN/t5kdgVCYTu08/w9Wxf
X-Gm-Gg: AZuq6aInD9Rrz7WRmWz/yTolUPWF/wsp6EGXXo6saXrrV6NXBaqacrikwqjYQyrZRv+
	6rV2WY7Ibn8TXH+tKxi9yFYPiwL3nD30NfmPI9qZRsjlWA9Aua7+j7E2DklZD9e7W76mJjE7Cyj
	TGzJTdULNwmtBEl71yfOoryQkqa/l3KQvDNo4+jjNPJ3vnshB36H+kV/kWdBDM6UuCtX/8SMGqH
	943ROjQdlCSxod832DyTI8H2B8wzLAsmHOmfNODM+vIXkMX8byMTUWJWU+151aR8xUOXYlVvyup
	WQG5Ld9sDu7hYiXNGSbXix85LGWf2WP8zss78qPjTzpLdp3TZqbKm9qZYlbWf67clZqBV/zQZp5
	xOLlzY/9kHCMUYWpxXfySiwqgKMtyR+3I0+uua2rPNHV6yq+RmZEsjIqj0eyINOBgQYvupdR7ZB
	kx9CJGP8Er/YjdV16K9nhJ/AgFZMm09DvK9ZfN1q0=
X-Received: by 2002:a05:620a:46ab:b0:8c6:b258:dff7 with SMTP id af79cd13be357-8cb3512e9bfmr95921985a.72.1770870188331;
        Wed, 11 Feb 2026 20:23:08 -0800 (PST)
Received: from I4-L-HQH5357-01.ad.psu.edu ([130.203.159.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c7ef7sm281601085a.28.2026.02.11.20.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 20:23:07 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Shuangpeng Bai <baisp@psu.edu>
Subject: [PATCH] net: caif: serial: fix TX UAF on ser->tty
Date: Wed, 11 Feb 2026 23:22:36 -0500
Message-Id: <20260212042236.639174-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258403-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,psu.edu];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,psu.edu:email]
X-Rspamd-Queue-Id: 5DAF612A4B9
X-Rspamd-Action: no action

KASAN reported a slab-use-after-free in tty_write_room() reachable from
caif_serial's TX path. The TX handler dereferences ser->tty while
ldisc_close() can drop the driver's tty reference. Since ser->tty was
not cleared and accesses were not synchronized, the TX path could race
with tty teardown and dereference a stale ser->tty pointer.

Fix it by serializing accesses to ser->tty with a dedicated lock. The TX
path grabs a tty kref under the lock and drops it after the TX attempt,
while ldisc_close() clears ser->tty under the same lock before putting
the old tty reference. This prevents the TX path from observing a freed
tty object via ser->tty.

Reported-by: Shuangpeng Bai <baisp@psu.edu>
Closes: https://groups.google.com/g/syzkaller/c/usNe0oKtoXw/m/x8qUc3yUAQAJ

Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/net/caif/caif_serial.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index c398ac42eae9..fd1213685a89 100644
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
 
@@ -327,6 +339,7 @@ static int ldisc_open(struct tty_struct *tty)
 		return -ENOMEM;
 
 	ser = netdev_priv(dev);
+	spin_lock_init(&ser->tty_lock);
 	ser->tty = tty_kref_get(tty);
 	ser->dev = dev;
 	debugfs_init(ser, tty);
@@ -354,8 +367,13 @@ static int ldisc_open(struct tty_struct *tty)
 static void ldisc_close(struct tty_struct *tty)
 {
 	struct ser_device *ser = tty->disc_data;
+	struct tty_struct *old;
 
-	tty_kref_put(ser->tty);
+	spin_lock(&ser->tty_lock);
+	old = ser->tty;
+	ser->tty = NULL;
+	spin_unlock(&ser->tty_lock);
+	tty_kref_put(old);
 
 	spin_lock(&ser_lock);
 	list_move(&ser->node, &ser_release_list);
-- 
2.34.1


