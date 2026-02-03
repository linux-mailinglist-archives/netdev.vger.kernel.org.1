Return-Path: <netdev+bounces-256484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEgiFCl/gmnAVQMAu9opvQ
	(envelope-from <netdev+bounces-256484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 00:05:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB6BDF888
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 00:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB3E63002921
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1D2BD5A7;
	Tue,  3 Feb 2026 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGCdj6tL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F714256C8B;
	Tue,  3 Feb 2026 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159908; cv=none; b=f3Lhkm3p8zIAfu7XLHRf/FPG8fHVwJFpywtXqG6Fnl24PfRjY4rtgIVDT6ALCX4ZA2ploxukMir4s7ump9RlLOB4ZTraLtczj9OIA4Yo+oftftq3UTJeMK7uXmnRKv5ehraWabng+oGqzPThRgRLzb52fKON/LtQ0boG1d06/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159908; c=relaxed/simple;
	bh=lN5NzvZ82FzppvYfl5Zxnhq1rcu3CVXlKFcuFq5Szzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDLHaFE21/PCbCqMZq3e2JQlHAp4ZMmhN0WZHG6+aOyTPLiRizAoR7K4ig4pSyEXOhgN4TeW/gkSCNq4W25pW/QbQ7l7WLDFwcAu6I1uyAdq+HG1upO+6c+Jq2bkyJf5tR3Enetr56DJBlRFYx7uEIQ3F03cyhwb5I7NO9byUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGCdj6tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AE2C116D0;
	Tue,  3 Feb 2026 23:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770159908;
	bh=lN5NzvZ82FzppvYfl5Zxnhq1rcu3CVXlKFcuFq5Szzk=;
	h=From:To:Cc:Subject:Date:From;
	b=lGCdj6tLVoca6tFwoCt+cfnQxh7lz9kjlAXcBtEgDTC+Rc2BmHprV6nnwO1+XGFfa
	 dJT2JbBgS5zfAfEqnFVSS0Tv0pjVO1RXQUmY6cY1DnxmLTVVkFBnk/UE6Q99lb4rjd
	 rc+d6EG72HJw/W12RQ8lcabHNDyYuBnhgjYNMKvQErc0bGJqCOU9s3F+DfUcswdjcL
	 uG5hYBBbs6h5WiqgGQb8rptfL3YoBrlJkA1CKLMjPi9sQKNruIJqVJ1iYy9TR1ZU+L
	 pUXDI9uDh9fZpi7Kd3hQLnClxJb0RPAIwuBboyO2JaXGvIuZmJCjyPnlydP2OF2qYl
	 NtxIhq/l5Jx0g==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Andrew J. Gallatin" <gallatin@myri.com>,
	Brice Goglin <brice@myri.com>,
	Jeff Garzik <jeff@garzik.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] myri10ge: avoid passing uninitialized data to inline asm
Date: Wed,  4 Feb 2026 00:04:51 +0100
Message-Id: <20260203230501.832872-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-256484-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AB6BDF888
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

Building with gcc-16.0.1 find a bug with the inline asm:

In file included from include/linux/io.h:12,
                 from drivers/net/ethernet/myricom/myri10ge/myri10ge.c:43:
In function '__const_memcpy_toio_aligned64',
    inlined from '__iowrite64_copy' at arch/arm64/include/asm/io.h:249:3,
    inlined from 'myri10ge_dummy_rdma' at drivers/net/ethernet/myricom/myri10ge/myri10ge.c:535:2:
arch/arm64/include/asm/io.h:206:17: error: '*(const u64 *)(&buf[6])' is used uninitialized [-Werror=uninitialized]
  206 |                 asm volatile("str %x0, [%8, #8 * 0]\n"
      |                 ^~~

Set the extra fields to zero before writing them to hardware.

Fixes: 0da34b6dfe55 ("[PATCH] Add Myri-10G Ethernet driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 7be30a8df268..cea28aa971cc 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -508,7 +508,7 @@ static int myri10ge_read_mac_addr(struct myri10ge_priv *mgp)
 static void myri10ge_dummy_rdma(struct myri10ge_priv *mgp, int enable)
 {
 	char __iomem *submit;
-	__be32 buf[16] __attribute__ ((__aligned__(8)));
+	__be32 buf[16] __attribute__ ((__aligned__(8))) = {};
 	u32 dma_low, dma_high;
 	int i;
 
-- 
2.39.5


