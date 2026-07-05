Return-Path: <netdev+bounces-304762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OigENpoZSmpX+QAAu9opvQ
	(envelope-from <netdev+bounces-304762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 10:45:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AEE709846
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 10:45:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304762-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304762-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22DA8300A387
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B536EA98;
	Sun,  5 Jul 2026 08:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63DC2820A9;
	Sun,  5 Jul 2026 08:45:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783241111; cv=none; b=uL+vhOPsbUW94L1Bn8LXN2CTghb4IZBn8fpdDGFF3JYN1fTOzzFS+PDj8RJAVIGzz2Qa7uyP9hNQ3BVt2lVX2VoD7+Z4HJg7uOYOLJ3p8gAm0z4kUAkKUehjvSk2McMyV7KO9PVUGqYttSRpv5K1Y2Z/3HD+fwTojMYo85icpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783241111; c=relaxed/simple;
	bh=wUD75mZGOgJZAPh8PCUn7G/0cQOVKtz16FivmgjPo9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioWgqBX6rp8C7GHKy88lS8U11R1phYgHY4ZI8/xErkshCy8+9XuwwiVEbPoErdeL1OuKZQPq9+DW4ZpJveZtNhPiGM/PZVI/DT9jPVqfTLfow6EZJ8SmAeLTWbSFYf2btvEcaPBeurxHNrwft31dyEs/iWX2XR8oYP0Ur5Yfk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABHkcSSGUpqS6_8Fg--.7044S2;
	Sun, 05 Jul 2026 16:45:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] atm: solos-pci: validate DMA receive size
Date: Sun,  5 Jul 2026 16:45:04 +0800
Message-ID: <20260705084504.54281-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHkcSSGUpqS6_8Fg--.7044S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtF13KF4kJw1UCw4ruFyDKFg_yoW8JryUpa
	15KF1Utr95Ar15Ar95Aw4UXa15Gan8Aa4agFWkGa4a9rn5Ww15uFZ5KFWSgrWkArs3GrW2
	qr1ktr40ka4DZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjIJmU
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:3chas3@gmail.com,m:linux-atm-general@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,lists.sourceforge.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304762-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30AEE709846

The DMA receive path reads header->size from the RX buffer and uses it
to extend the skb with skb_put(skb, size + sizeof(*header)). RX DMA skbs
are allocated with RX_DMA_SIZE bytes, but the DMA path did not check
that the device-provided size fits in that buffer. The MMIO path already
has a similar size check against card->buffer_size.

Reject an oversized DMA receive item before skb_put() and drop the
invalid skb, then continue through the normal DMA RX refill path so the
port is not left without a replacement receive buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -784,6 +784,12 @@
 
 				header = (void *)skb->data;
 				size = le16_to_cpu(header->size);
+				if (size > RX_DMA_SIZE - sizeof(*header)) {
+					dev_warn(&card->dev->dev, "Invalid DMA buffer size\n");
+					dev_kfree_skb_any(skb);
+					goto refill_rx;
+				}
+
 				skb_put(skb, size + sizeof(*header));
 				skb_pull(skb, sizeof(*header));
 			} else {
@@ -865,6 +871,7 @@
 				break;
 			}
 		}
+refill_rx:
 		/* Allocate RX skbs for any ports which need them */
 		if (card->using_dma && card->atmdev[port] &&
 		    !card->rx_skb[port]) {


