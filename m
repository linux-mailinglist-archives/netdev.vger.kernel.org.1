Return-Path: <netdev+bounces-264192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDCLHE0lqWkL2gAAu9opvQ
	(envelope-from <netdev+bounces-264192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 07:40:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E820BBF2
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 07:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 147EA3023D47
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A414309DDB;
	Thu,  5 Mar 2026 06:40:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DA307AF0;
	Thu,  5 Mar 2026 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692808; cv=none; b=GpwXmioTcEIxwAQsQJ6rM0qwa5PqHtBnkoxMN0oj7oCeImNC/VV6SeYYXPDfFSqggk3qEALQcUE/DJIhB0IJVu0iy3/J3q80Tk2nTYhpiPNe6QYuPJmhcmlrs45EViQqFiIRpDCP+xWjipWeJ79h0+jbAwHBikydkZuLqDHbWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692808; c=relaxed/simple;
	bh=eRkgq81AfKRtjUmavBd6D8tUyzTRKSWohAx2GHV3bzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CC+U6GvHvQoTZnAY03STFVN0nKbGya4cki/qUUPxJkIqcExMEJmPBWeReKH6PhTu/rV0Xl9pXjFQmK16gf0P7YCUpqDAd0JBGZX8eqb46O7Zc7RamJ9HQCaRBmVy020nm4OcYZ1aS1iwoTthzndQxQJwbbtQgINLD22ztt6pgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAAXqg01JalpW7+uCQ--.48975S2;
	Thu, 05 Mar 2026 14:39:49 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH net v2 0/2] net: spacemit: A few error handling fixes
Date: Thu, 05 Mar 2026 14:39:37 +0800
Message-Id: <20260305-k1-ethernet-more-fixes-v2-0-e4e434d65055@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACklqWkC/4WOwQrCMBBEf6Xs2S1JKlY9+R9SIU23dpE2msSgl
 Py7IXr3ODNvmFnBk2PycKxWcBTZs12yUJsKzKSXKyEPWYMSaica0eBNIoWJ3EIBZ+sIR36RR7l
 XB9O0sjUjQS7fHZUgd8+QWei+pqPHM4+EX9JrT2jsPHM4VrGtBTojL2sq+MQ+WPcu36Is/L8bU
 aJAoXshlRqHQW5P7I32tTa1WaBLKX0AwhpSDvIAAAA=
X-Change-ID: 20260303-k1-ethernet-more-fixes-1829c3717cfe
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowAAXqg01JalpW7+uCQ--.48975S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy3ur13WFyDXw45tr4fKrg_yoWkuFb_uF
	W8uas3GF4kWFnrCa4akFsI9rWvyrs5Jrs3tFyYqayYkry7Jrn3XrWktFWrZr1fXa1kJFnx
	J3y7ZrWrZr17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUU_WrtUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Queue-Id: BF1E820BBF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264192-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.974];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:mid]
X-Rspamd-Action: no action

Recently a user reported a supposed UAF/double-free in this driver. It
turned out to be a false positive (ugh) from a bug with riscv's
kfence_protect_page() [1], but it did also prompt me to review the
driver code yet again. These are some fixes for error handling problems
that I've found.

[1]: https://lore.kernel.org/r/20260303-handle-kfence-protect-spurious-fault-v2-0-f80d8354d79d@iscas.ac.cn/

---
Changes in v2:
- Retarget to net (Andrew, Jakub)
- Drop what was patch 1 and patch 4 for now, since they are code cleanup
  only and can't affect users (Andrew, Jakub)
- Reworded cover letter
- Link to v1: https://lore.kernel.org/r/20260303-k1-ethernet-more-fixes-v1-0-0ab0122fdd14@iscas.ac.cn

---
Vivian Wang (2):
      net: spacemit: Fix error handling in emac_alloc_rx_desc_buffers()
      net: spacemit: Fix error handling in emac_tx_mem_map()

 drivers/net/ethernet/spacemit/k1_emac.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260303-k1-ethernet-more-fixes-1829c3717cfe

Best regards,
-- 
Vivian "dramforever" Wang


