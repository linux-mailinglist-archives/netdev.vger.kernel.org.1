Return-Path: <netdev+bounces-184157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A7A93834
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BBE7B29CB
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E72940F;
	Fri, 18 Apr 2025 14:01:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED358F49
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984914; cv=none; b=QkmziYWgyuQ1AoipefpAO1RHP/TJUUff3pLCGczIBOZrPRqI9R6IDnlupt+ltELG2TLKFPRz4FR/OcQJC7cpL1PhbgOW0QjmsLOtICPJx78bAmB5Y/Aj/bVplgg0szTGrVjnqhpuWqdqm8y2+jGGPu3duVQckFVTslaIkyNv1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984914; c=relaxed/simple;
	bh=+8OdUJwIXjHlLO7MXpVULRrF4daUsJ1JeCYf/lo/0ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+T7FN+W/e2H8rTef/IcHk0a6z9WfYZXR3UYfp9v/kqvSzy6t1/9c7mI8Me1duJdZXuk27l3dDX488GObVF3baTGjaLhnYJy5gzeffXwBE0hLpK34Gov3cx27b57JaXjhUojTo9jy3Nt9tXUDqrKEhRsNVVsfOPFtUiDJW3zcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-03 (Coremail) with SMTP id rQCowACHNUJGWwJoeHTeCQ--.23559S2;
	Fri, 18 Apr 2025 22:01:44 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: isdn@linux-pingi.de
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	chenyufeng@iie.ac.cn,
	netdev@vger.kernel.org
Subject: [PATCH] cmtp: enforce CAP_NET_RAW for raw sockets in cmtp_sock_create()
Date: Fri, 18 Apr 2025 22:01:18 +0800
Message-ID: <20250418140118.1775-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHNUJGWwJoeHTeCQ--.23559S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4ktw17Wrykur48CF13twb_yoW3Crc_Cw
	48A3sxWryUta15Zayjk3WUur1kJ34fG3WxCwn5XFZ8Was7Cr4qvr1xGr1fCF1xuayjvFZ7
	Aw1rGFZ3Ja1xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjmii3UUUUU==
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiBg0QEmgCIt2dTQAAsM

A patch similar to commit b91ee4aa2a21 ("mISDN: enforce CAP_NET_RAW for 
 raw sockets").

When creating a raw BLUETOOTH socket, CAP_NET_RAW needs to be checked
first.

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 net/bluetooth/cmtp/sock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index 96d49d9fae96..00f944f2863f 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -206,6 +206,8 @@ static int cmtp_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
+	if (!capable(CAP_NET_RAW))
+		return -EPERM;
 
 	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &cmtp_proto, kern);
 	if (!sk)
-- 
2.34.1


