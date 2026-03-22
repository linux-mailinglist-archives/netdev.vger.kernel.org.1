Return-Path: <netdev+bounces-270289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PwCGD1gv2ma3wMAu9opvQ
	(envelope-from <netdev+bounces-270289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 04:21:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5222E81C5
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 04:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC2253031ACD
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 03:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C1737F001;
	Sun, 22 Mar 2026 03:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77437E2E5;
	Sun, 22 Mar 2026 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774149580; cv=none; b=S7UAON1pB+sqMRuyDyqUgF1YQmirsvXfJFWLmnmTyeB5p3NJhd+2VgWglSwYs2JVr1SVkFjyD2oq+ELm7ZCw8kAQ1DpLz7+uFJieNrF5+d7FokoQdmtM2LHe0MFVa0JSG18KFRFx4CVqunPacBJL5jbSZyeJGQwO5uZl545KgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774149580; c=relaxed/simple;
	bh=CENEbpOf8TbsjkLHwHcCJ8NDO/CCWKi2C26VgiXqKUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2Z4a7mpLUyQjqaqqWw4DnWoIcajAh/7txwHE2Skr/xYCI5cfdQ0kinNGFP7CdAq8omLfW7qXszp295Y/3ZjPHXmP9Dltyi+/kHybHB5rv/vkayJujVWT0ABHxGt0DHBXmiJklqAhqCltzP/HlPgCGvozLAollDPASorBFEHjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAAXqg26X79pvk8eCw--.20503S2;
	Sun, 22 Mar 2026 11:19:22 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: netdev@vger.kernel.org
Cc: pengpeng@iscas.ac.cn,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/nfc: bound SENSF response copy length
Date: Sun, 22 Mar 2026 11:19:22 +0800
Message-ID: <20260322031922.57949-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXqg26X79pvk8eCw--.20503S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW7uF47ZFy8XryxCFykXwb_yoWkXFc_Za
	srAF9rK3Z8WFn7C3yxGrs3G3srX3yxu3WfZ3yagF9xCa45ZF18Ar48trZ8ArnruF40yFWr
	Cr17Xr1Ikw4UujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE5222E81C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`digital_in_recv_sensf_res()` only checks `resp->len` against the
minimum frame size before copying the response into
`target.sensf_res`. The destination is `NFC_SENSF_RES_MAXSIZE` bytes
long, so an oversized SENSF response can overwrite adjacent fields in
the stack-local `struct nfc_target` before the result is handed to
`digital_target_found()`.

Reject frames larger than the destination buffer before copying.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/nfc/digital_technology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index 63f1b721c71d..8147e61c224a 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -768,6 +768,11 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	skb_pull(resp, 1);
 
+	if (resp->len > NFC_SENSF_RES_MAXSIZE) {
+		rc = -EIO;
+		goto exit;
+	}
+
 	memset(&target, 0, sizeof(struct nfc_target));
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
-- 
2.50.1 (Apple Git-155)


