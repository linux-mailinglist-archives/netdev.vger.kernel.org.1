Return-Path: <netdev+bounces-272090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIfjA7lCxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222BC336C5A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77ADD3009CCF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAAF3F9F48;
	Thu, 26 Mar 2026 14:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949B3F7A8C;
	Thu, 26 Mar 2026 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534851; cv=none; b=UETOdnYxu4Id8rLxbQT3XcQ8EWPQQCs3IxdOuNnRv0vYFZme5/EFzGloh/u+6KZfMIoM6bi6jTwfvQDWP9A1gOCUn9Y5VwbDbTmX/BYxjkdTSapoZeEwIWrqr64QFJkrpShsv2dotF+GpQ6+jI2XJuL7cnmi3RFEGtXm2nuxPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534851; c=relaxed/simple;
	bh=OtEKHWEsO466BSlul1sIOJ0gYgidTZ8F1CdQgHAhA3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StOzVIxYC3DiQHUeA+wPsbm7IIzAyzYTB/dUfe3ZVbjRoFsrMY+Bg849XBdzqTLjrQadimj0R9DAOHmE+0Ys1Nz1s7Lcv3ghs8RRvOJtkCfGPzY11goj/X42URcbtIAF1sqQOxpAwT1dYUW250/WTZFqUzR5ROp1xSlKmbZ5wCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAC3m+KxQMVpAK_qCw--.63990S2;
	Thu, 26 Mar 2026 22:20:33 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	mingo@kernel.org,
	kees@kernel.org,
	pabeni@redhat.com,
	pengpeng@iscas.ac.cn
Subject: [PATCH net v2] NFC: pn533: bound the UART receive buffer
Date: Thu, 26 Mar 2026 22:20:33 +0800
Message-ID: <20260326142033.82297-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323072409.60086-1-pengpeng@iscas.ac.cn>
References: <20260323072409.60086-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3m+KxQMVpAK_qCw--.63990S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKr17JryDtrWxWF1DJFyUGFg_yoW8JrWfpa
	9xKFn8tr18Jr4UJwsrCw1rXFy5J3Z3JrWaqFW7G3y3ZFnxJa9xWF4fKFyavFZxXrWkJFy2
	vFWDJr4UCa98WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeBTYUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272090-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 222BC336C5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pn532_receive_buf() appends every incoming byte to dev->recv_skb and
only resets the buffer after pn532_uart_rx_is_frame() recognizes a
complete frame. A continuous stream of bytes without a valid PN532 frame
header therefore keeps growing the skb until skb_put_u8() hits the tail
limit.

Drop the accumulated partial frame once the fixed receive buffer is full
so malformed UART traffic cannot grow the skb past
PN532_UART_SKB_BUFF_LEN.

Fixes: c656aa4c27b1 ("nfc: pn533: add UART phy driver")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
v2:
- add the requested Fixes tag for the UART receive path

 drivers/nfc/pn533/uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index 6d2f520a5bc8..1b82b7b2a5fa 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -211,6 +211,9 @@ static size_t pn532_receive_buf(struct serdev_device *serdev,
 
 	timer_delete(&dev->cmd_timeout);
 	for (i = 0; i < count; i++) {
+		if (unlikely(!skb_tailroom(dev->recv_skb)))
+			skb_trim(dev->recv_skb, 0);
+
 		skb_put_u8(dev->recv_skb, *data++);
 		if (!pn532_uart_rx_is_frame(dev->recv_skb))
 			continue;
-- 
2.50.1 (Apple Git-155)


