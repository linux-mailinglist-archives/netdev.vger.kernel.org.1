Return-Path: <netdev+bounces-272767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMTwHEC9x2k9bgUAu9opvQ
	(envelope-from <netdev+bounces-272767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 12:36:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B234E300
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 12:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C3713013276
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BC837F731;
	Sat, 28 Mar 2026 11:36:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAE40DFBC;
	Sat, 28 Mar 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774697789; cv=none; b=Z4oI8Sm8QDTVhmNduXOAAzQqMhvsSPp6MY341TDv/bNpTTiWI6Luu3wzF49zJlW8BGodC1o0kk/YrFtGcGJhrUMx+Yw0KmegQBw/P4xAL/J/L0/b/UNKWIK+uzezKtoPYJdP0rNd/6On4lhbAgj11OtSq8Rd16/aZNjdyMJo6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774697789; c=relaxed/simple;
	bh=rhlDXRXJHepqcIKaaqSr0WQGym7zs9V2OcYTND/ciH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3T4jT4oy6YVXNE8+q+/n4yPdjYrpn5q0MLnxiYyS0lv2tER7ekDmejZ/y3u742n3iwOPoWNaqADiHHRJfS9hLfH95T+sLnBRvHDhKN5+ayC9YvqmpnjQ+Nf6CmJsm7OQtk+Om901PCdDqTt3WBqIxmrWbJhEZMxor7Pb0MC8ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAD3iAwvvcdplh_ACw--.26170S2;
	Sat, 28 Mar 2026 19:36:15 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: netdev@vger.kernel.org,
	krzk@kernel.org
Cc: bongsu.jeon@samsung.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] NFC: s3fwrn5: bound the UART receive buffer
Date: Sat, 28 Mar 2026 19:36:15 +0800
Message-ID: <20260328113615.37260-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3iAwvvcdplh_ACw--.26170S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr48Aw4DGF4xJFyrXw4rAFb_yoW8Xw4kpF
	45Ka4jqr18tr43Jr9rJ3yFgFW3J34SgFW5Cry3K3yrZFWrArZ8GaySkFW2gr45Cr4kJFWf
	Aa48AF48C3WUKrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 798B234E300
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

s3fwrn82_uart_read() appends bytes to phy->recv_skb with skb_put_u8().
It only resets the skb after a complete NCI frame is assembled.

The receive skb is allocated with NCI_SKB_BUFF_LEN bytes, but
malformed UART traffic can keep the frame incomplete and continue
growing recv_skb until skb_put_u8() overruns the tailroom.

Drop the accumulated partial frame once the fixed receive buffer is full
and no complete frame has been seen yet so malformed UART traffic cannot
grow the skb past NCI_SKB_BUFF_LEN.

Fixes: 3f52c2cb7e3a ("nfc: s3fwrn5: Support a UART interface")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/nfc/s3fwrn5/uart.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index 9c09c10c2a46..c664fed78c1f 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -64,8 +64,17 @@ static size_t s3fwrn82_uart_read(struct serdev_device *serdev,
 			continue;
 
 		if ((phy->recv_skb->len - S3FWRN82_NCI_HEADER)
-				< phy->recv_skb->data[S3FWRN82_NCI_IDX])
+				< phy->recv_skb->data[S3FWRN82_NCI_IDX]) {
+			if (phy->recv_skb->len < NCI_SKB_BUFF_LEN)
+				continue;
+
+			dev_dbg(&serdev->dev, "dropping oversized UART frame\n");
+			kfree_skb(phy->recv_skb);
+			phy->recv_skb = alloc_skb(NCI_SKB_BUFF_LEN, GFP_KERNEL);
+			if (!phy->recv_skb)
+				return 0;
 			continue;
+		}
 
 		s3fwrn5_recv_frame(phy->common.ndev, phy->recv_skb,
 				   phy->common.mode);
-- 
2.50.1 (Apple Git-155)


