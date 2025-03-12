Return-Path: <netdev+bounces-174112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DBBA5D85F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA49417509D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06567235360;
	Wed, 12 Mar 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="nKAI4Wwo"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60321E260C;
	Wed, 12 Mar 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768779; cv=none; b=qNonJhx+y0dHWFEGAPGjFhELu7GKv9MOyhEt8fLuSEr/rnEaFO2msydubSN4NEH1VFNDiQlw31QdKjbhQN6B8SbZ65H8Q31kx9/h8eZq85oHRHnsMwnrQUAAmdnAHgbuwTML/rktjw6BP3P0anlefyPG13DZnkp9hc/J+ROkSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768779; c=relaxed/simple;
	bh=yNgoPSJjsf++4XSyvU8tPaX2ml30wu9PFCyRHSCM0U4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVo/6tp9oy5GV4csKVu+i5tU8vU6sXmro2P5PYqp+7u2HHya30FvpF1rfrqeEigp+TXjByt1OPrSyRKwQVdEwKZhpOWAFuZoEjUt8cgApxH/I2GHdmwwKNFbt3tQXE1HMnalB2Z2wIBUdiJYxPjXPmthFMg8W13p9RbM+4lLYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=nKAI4Wwo reason="key not found in DNS"; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=5oUDC6wsjZ
	WnHqf8K3FBO9GrUnuvrcLdJ7o5wYqKLR8=; b=nKAI4WwoRHKZacWc5f2elxeBrL
	PDPej3tHtOJL+dJnEapzHlHd4WCRk8RGA0vGYxc9eGVIl99l7un3aR8rPCVNTX0D
	FU4CzOMjp87COAe5i5EEzknFiVehn0Mkk5UVCgsApchTPoNrlxnGZmsPBnYNnK0n
	n5stb56fPGQKaX2HI=
Received: from localhost.localdomain (unknown [10.193.111.103])
	by coremail-app1 (Coremail) with SMTP id OCz+CgA3_lMaSNFnwCS_AA--.24657S2;
	Wed, 12 Mar 2025 16:38:50 +0800 (CST)
From: Si-Jie Bai <sy2239101@buaa.edu.cn>
To: luiz.dentz@gmail.com
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cuijianw@buaa.edu.cn,
	sunyv@buaa.edu.cn,
	baijiaju@buaa.edu.cn,
	Si-Jie Bai <sy2239101@buaa.edu.cn>
Subject: [PATCH] Bluetooth: HCI: Fix value of HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE
Date: Wed, 12 Mar 2025 16:38:47 +0800
Message-Id: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgA3_lMaSNFnwCS_AA--.24657S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr18uw15Gr4DXw15KF18AFb_yoWfurb_Aw
	13ZF4kuryUAa4Sqr4qkan8Jw48ur1rZFykWFnxW347Jry29rs5J3sxWF4jq3W3Way7urWS
	yF4IyFyfW343JjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK
	67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I
	0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r126r1DMxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	0JUDhLnUUUUU=
X-CM-SenderInfo: tv1sjjizrqiqpexdthxhgxhubq/

HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE is actually 0x1a not 0x1e:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 1, Part F
page 371:

  0x1A  Unsupported Remote Feature

Signed-off-by: Si-Jie Bai <sy2239101@buaa.edu.cn>
---
 include/net/bluetooth/hci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0d51970d8..3ec915738 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -683,7 +683,7 @@ enum {
 #define HCI_ERROR_REMOTE_POWER_OFF	0x15
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
-#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1e
+#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1a
 #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
 #define HCI_ERROR_UNSPECIFIED		0x1f
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
-- 
2.25.1


