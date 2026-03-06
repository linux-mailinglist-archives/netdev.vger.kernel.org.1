Return-Path: <netdev+bounces-264663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLM/AaxMqmmIOwEAu9opvQ
	(envelope-from <netdev+bounces-264663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:40:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 735DD21B373
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C20AC301B14A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA2A36BCE6;
	Fri,  6 Mar 2026 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHxeyGom"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB20248873
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768423; cv=none; b=cmvEIzJUaeETUrviTAXk1IPzmsXj3JEnm0xcJrW6hI19TWgUYljORfs7kkEdz2/pTRn4S8hiu5ZI6hNBAUgkUTOZMGJd2kKlvhP2LRJKHxD+Sho0g/cHPqnX9QiMDYDUQGA/LubN3/32wWkVIg7T1+e7uWRz5U48Vx01VZJiyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768423; c=relaxed/simple;
	bh=ZKGQMmynGH72RNGVGSJeWjju/XTm1pbnlX08xLpX844=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a01MrSele6s2HWz6bKth/F5qea13gZnZ22nTw429qrYkUFNTLv77JerUQ7JJf9WylTY0MSbdfGC7UfSOrvyJzBfOVvDGuKjjTzW60Ei7HggqRLCPeglJptCUCfyZNYHB8WU1q5cSEbtKECxeju0CFSvL6Oqw/SvSu47FLH23SX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHxeyGom; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899e87b04d8so97094336d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 19:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772768420; x=1773373220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=myrPwAZMujLUe8MJ6Ba22b/AUfkQBCrFe4aRwPYkeIA=;
        b=bHxeyGomsLiPvjHUQ6QJ5EM1oIHaa6BIC4AJtQoQaXaBZ9IPHK0ZHoK2sYyxqv/Mpq
         iMeSf1gUN0TQQ6cbqwPb1qX2V3W74vuBDfXuy6i8RBEIR1SwYhU3I1RZREIW/8lraMzO
         pYwNfNPzvwFZSj/pOQG13U7lsmxYy/zeTsLBnPM9RQd3cWqDKe5YsNYkVubFqZ8Z/a6c
         kuLUYQyqVi/UgDhjHtqdJ/4CvPdiCaUr/aECTz4WrbKFHFAXA71ihqmxEPHPGoHCp/6/
         X+sO0VQFVsl2j7j9p/BeRVja2KourQVop7op3Vm9rzFa30CSaZjbU3UititmedSpcvjf
         mGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772768420; x=1773373220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myrPwAZMujLUe8MJ6Ba22b/AUfkQBCrFe4aRwPYkeIA=;
        b=pNNHCCxlqA+nKPM5HY12QL7h20aXvsBOPl6DOgTXQHw3altYmyaQA0Axur+QN3U8fF
         Gp33tk08RqeIT6isOZPvptRp9dQHKyCdyZP0BMYodRYWYAR0irr+yn7CM8rl+dFi5x57
         TgRqXeJ/ADu29yjC6Rr0/dlywd0ChfHn9JkQCIRj+aJuN1jub5ewFtq4dbhPVlv1SjE2
         6ChoM3TSDvjKygTRvt7V4Cgz1Q1Oi6QNzx5gf/ZVJ3fqvZVNmvNuBpBWtTz2+JtDbBHe
         b/ofCAXwJf7NXJ0YYdSO634jX+BpEJV3tO24X1x22V/e86sPCKnUb8z1gFweRG88fjLT
         b3zQ==
X-Gm-Message-State: AOJu0YzzLAdNBTE6k7fFiQ5rwh6ZEITnT9QQa+tzm591ModsKBtEk3kh
	oF7IAL7bKcsCTc563KGF7B+hu+W3AelDINsVKoDK7xMSJXIAiV73m846F89isaSp
X-Gm-Gg: ATEYQzz0owNzTl3PxvDO4SefS33ugDjCJYkpJW/z/xUNYHVmYqLsUW+BKpR6Ug91R/a
	pcbQruPFLEyYi/zNEZzMcT0ndJjGbmIvEHmNwDYGVxEGFHXawFE8BEGysMq7qrR00lBMEkZgcfv
	u9Om6kuk/AYILrSXfTPBkpaCUPH+QEFSk4evKP1f/vp56aShP4KjDFsryc/VlKhCbSPo4HCEA+A
	coscpeZuQPuZ4EDQQVIIBwF3rUGfLl7GJDmJ7WTbeg9O4sbPuPmMmjoxcao0qa6SFYR2jI+cMDi
	noLxIeUlNpIDHuFNHD+U9bBoiO2FMMoGKfYCF9I7k3OYveQP6SY92wMzwNR1sJAMEwAynbgcXpL
	+EYn7LyS0G7PZ7QsdHHNM8wBGDYtM1jubtH2QUvLOVipHOQq2f7vzB6IAC8AncwKh8+ixj4ANBS
	hTAcGLniYkQtCN8P5W6ANb2zDcLtTs1jK88AI3Osgcf8ERQqFsYVXSJQ==
X-Received: by 2002:ad4:5769:0:b0:895:c06:8cbf with SMTP id 6a1803df08f44-89a30c2b8b3mr7786186d6.62.1772768420459;
        Thu, 05 Mar 2026 19:40:20 -0800 (PST)
Received: from I4-L-HQH5357-01.ad.psu.edu ([130.203.159.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316f8228sm2158306d6.38.2026.03.05.19.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 19:40:20 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	gregkh@linuxfoundation.org,
	horms@kernel.org,
	jirislaby@kernel.org,
	shaojijie@huawei.com,
	jiayuan.chen@shopee.com,
	alan@linux.intel.com,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net v5] serial: caif: hold tty->link reference in ldisc_open and ser_release
Date: Thu,  5 Mar 2026 22:40:06 -0500
Message-Id: <20260306034006.3395740-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 735DD21B373
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-264663-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lunn.ch,linuxfoundation.org,huawei.com,shopee.com,linux.intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Action: no action

A reproducer triggers a KASAN slab-use-after-free in pty_write_room()
when caif_serial's TX path calls tty_write_room(). The faulting access
is on tty->link->port.

Hold an extra kref on tty->link for the lifetime of the caif_serial line
discipline: get it in ldisc_open() and drop it in ser_release(), and
also drop it on the ldisc_open() error path.

With this change applied, the reproducer no longer triggers the UAF in
my testing.

Link: https://gist.github.com/shuangpengbai/c898debad6bdf170a84be7e6b3d8707f
Link: https://lore.kernel.org/netdev/20260301220525.1546355-1-shuangpeng.kernel@gmail.com
Fixes: e31d5a05948e ("caif: tty's are kref objects so take a reference")
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Changes since v4:
  - Fixes: reference e31d5a05948e ("caif: tty's are kref objects so take a reference")

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


