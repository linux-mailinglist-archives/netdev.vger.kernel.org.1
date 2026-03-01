Return-Path: <netdev+bounces-262456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI+ZHXC4pGlJpwUAu9opvQ
	(envelope-from <netdev+bounces-262456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 23:06:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E21D1CD1
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 23:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FB9630098A6
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 22:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836427472;
	Sun,  1 Mar 2026 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9DCLEBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0243317151
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772402797; cv=none; b=hib6NLoVttAX9ZlFl0O7WtASna4ToKuPXmjTdmO2YPivYpl5QTBJE8enUHbzrbKo9m34kDJ2yD2Io/jK93yFuhu0VZtnSMX3SJU4iyX3s17Em4wjqDl7kiD9cCEzamgLomW/3NZ7wySQntGPM5dD57+j0cEWv6xrFSgZLWm6CmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772402797; c=relaxed/simple;
	bh=4aDbahTsAxWptkKELlnXx/m2/Evtrb9Jr7QiEDNJg2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p0A3igkcqonWOMgUhIV/VAMrlMQ15JS1DnhCdiat4ND7qn5IjgKIjmeYbBgBUNMzvTzqnKOZqkD8e3ZXW8UeMWu6elrZZc7aW17sCuu1ca8qAH/6RuDsC7sX7VlgtwSxw5hgSHYOfrOvVDSAtP2lJbnj7+q5udaYPTyGK+zl/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9DCLEBC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb7edbcde6so500299685a.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 14:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772402795; x=1773007595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6RompYSWO41huen7yAapfSM0kh71UiS0m1JToPd3m8=;
        b=F9DCLEBCClpKoSLJWg3ssZoWfrXzMAM7v89waXQfjKueZxsl1oLquO1tiXTSdCFpht
         aIVlOyOnK1rAwOcLb9oscpNDMmxqttmc7O60aCZFAcv/RjbWd1zNKCJpHuoinIcI4hs0
         TzlAQB23X4mEKBoQtEKThJ3HT5H9ZsUd+bPooRMdjCHGn637KfGUC4sFK+Fg4slqgDYl
         MKeQk9q98ovYD8eRMM3Sk1ki9R+6KQnQJKvZHxmDSUJEAMsT6xeZmdB9LAcbLWSQErTZ
         uQQckE9hjrnWHTAcnC33KFXuP9ykcDdzZzrRdfPFJHd8vZIUALodDgnXEn4WYVeUYLIF
         G/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772402795; x=1773007595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6RompYSWO41huen7yAapfSM0kh71UiS0m1JToPd3m8=;
        b=NYrPuPhAh6v2bkjANVa3wBd9qvAb+CPAbkezBBb5mjmo6MCcKxGc5YNFpki12GCCry
         4H7t/vV2o63xevtGL0iSPJuQ/5KAGV96IOlfTT1nYQV9nIJy9tziUUPrIo3y4CpGgHPE
         gXkwENiRckJClpubXRvhi26Gd9g10f6kQuEGgg+aQSsXIRueKYG/BLKoVtwQCBnX1FYO
         mpul6Y6QnY7f4eQUtY/koHsus+LmifqbFoOxraS2sTZWMYZkEEkZfVA3UiibUYGu/o4y
         HxLeRH65NAV64HnT+OKhp2VRhKxddGWRUe/tLhgPkR5IsQQtWfI9TCH+uUrK0MTO+SY1
         QzZw==
X-Gm-Message-State: AOJu0YySWOAeH2kOHKGoNVdqD55VIsLmyWs8Te2g3nZumA7UhB959X7w
	cZxfCoIuzg0TE7EH3Qr0yYlKjAAJm979i5Fk9GWJ3FifjQszVQU2ZmFabUYdgGpm
X-Gm-Gg: ATEYQzy6s0j6AXqWLSaUJUWaCfznShvu5I4uRpLarSwKGPVhYh5Uotq/FKmhrQIcvXG
	OL5qs4mdpJt2xr+acSu3hNslFtlrxN4KXCjYq9YhEgDfUbjJ/jIrny0hElkL32ASiDX2pxygXcE
	MkYS+oIwfZGN/qlnol3r00yQlXZY67rpai9lVQLN4pKsEkijZ7t+3LFnvN7J8pPbsRFFzKNd56j
	zFaBREXpL4hcAHwZisQGtQxg/iwuPsNzjRr8QbwPyv2SSKSw7ioVB8a/dhm90PKekRIJ3iPFxjy
	z/vIVg6F9PgVeR7c7xDS24DoNRP9YszDVyX8z8c9sivL1X7EwcTCZdesDTphwTe8u3bfxp3OWpt
	CmNEJlpPsBbxJnKxMJchThff1mHBSTghzz90GJeWMNjUpojgTCTOeevfSVS6nsJ/Gq/C+CxLBs0
	8HVHxtjt96QzlpQMQPnoJiXOzYMxFz7ahEOeibjY3ZPH/FM4HHnJn0DQ==
X-Received: by 2002:a05:620a:f14:b0:8c7:140a:7dbf with SMTP id af79cd13be357-8cbc8f65113mr1287009585a.77.1772402794849;
        Sun, 01 Mar 2026 14:06:34 -0800 (PST)
Received: from I4-L-HQH5357-01.ad.psu.edu ([130.203.159.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf65921bsm999703785a.1.2026.03.01.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 14:06:34 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	gregkh@linuxfoundation.org,
	horms@kernel.org,
	jirislaby@kernel.org,
	shaojijie@huawei.com,
	jiayuan.chen@shopee.com,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net v4] serial: caif: hold tty->link reference in ldisc_open and ser_release
Date: Sun,  1 Mar 2026 17:05:25 -0500
Message-Id: <20260301220525.1546355-1-shuangpeng.kernel@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-262456-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lunn.ch,linuxfoundation.org,huawei.com,shopee.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 161E21D1CD1
X-Rspamd-Action: no action

A reproducer triggers a KASAN slab-use-after-free in pty_write_room()
when caif_serial's TX path calls tty_write_room(). The faulting access
is on tty->link->port.

Hold an extra kref on tty->link for the lifetime of the caif_serial line
discipline: get it in ldisc_open() and drop it in ser_release(), and
also drop it on the ldisc_open() error path.

With this change applied, the reproducer no longer triggers the UAF in
my testing.

This issue becomes reproducible on top of 308e7e4d0a84. Before that, the
reproducer typically hits another bug first, so this UAF is not
observable there.

Link: https://lore.kernel.org/all/20260228094741.1e248271@kernel.org/
Link: https://gist.github.com/shuangpengbai/c898debad6bdf170a84be7e6b3d8707f
Fixes: 308e7e4d0a84 ("serial: caif: fix use-after-free in caif_serial ldisc_close()")
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Changes since v3:
  - No code changes; repost without cover letter and with updated Cc list.

 drivers/net/caif/caif_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index b90890030751..1873d8287bb9 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -297,6 +297,7 @@ static void ser_release(struct work_struct *work)
 			dev_close(ser->dev);
 			unregister_netdevice(ser->dev);
 			debugfs_deinit(ser);
+			tty_kref_put(tty->link);
 			tty_kref_put(tty);
 		}
 		rtnl_unlock();
@@ -331,6 +332,7 @@ static int ldisc_open(struct tty_struct *tty)
 
 	ser = netdev_priv(dev);
 	ser->tty = tty_kref_get(tty);
+	tty_kref_get(tty->link);
 	ser->dev = dev;
 	debugfs_init(ser, tty);
 	tty->receive_room = 4096;
@@ -339,6 +341,7 @@ static int ldisc_open(struct tty_struct *tty)
 	rtnl_lock();
 	result = register_netdevice(dev);
 	if (result) {
+		tty_kref_put(tty->link);
 		tty_kref_put(tty);
 		rtnl_unlock();
 		free_netdev(dev);
-- 
2.34.1


