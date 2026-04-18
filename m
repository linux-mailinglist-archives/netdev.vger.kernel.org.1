Return-Path: <netdev+bounces-279494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMI3Mkx442lHHQEAu9opvQ
	(envelope-from <netdev+bounces-279494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:25:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5D421138
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0AF730242AF
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580435DA63;
	Sat, 18 Apr 2026 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="0IUMzExT"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FBF34DCCD;
	Sat, 18 Apr 2026 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776514715; cv=none; b=fBHjZuD+x2tRHP4AQAhWcEINBTluWVuEb3K1olSLfRAKGDLN1hO8Cgst1uRnB73eNqCjZr/0jfpOCbn8FRXXIgTObFlTce7IGkSWDwZGEBwsREPElTwxuS94JuHgTWifDcsX0A2m9ZroJLqd5BeX/5RACLPsbX4O3j+khW0YYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776514715; c=relaxed/simple;
	bh=wDzbXZhLh94RRVK+pCs9UkrM63fbj82TLjhru0A71Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k7EYvA0rCtAljALkAcZJKgav9OsChSfoIjUtgPPNkvoEK7wikPtyQ1rAWUtiyphMmYLPO7GfD6XsJ185Y+DnD9Ykvh7kSKgXuNe41wQJ+IUiH2CvGWEabinREEh35VrLktO2v/VGcOB4Jkq8auf9xc8eps7N2s7Vc2XWQjzndGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=0IUMzExT reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=TEpmaqV2cr
	73O2zRkCteMaRgSagJzIImAOJtTOjMaGE=; b=0IUMzExT3uKWkafGlqieWb7HZX
	F/32E08vJ2joEIijYZcasmfiaIrKfFOjIqZ3WdsZRVMq69WcSNMtaVTlaL334Iua
	lKPETqP9wBGcVMPZq/ESXL9Aqr/5EEfP2OXgpjaSvKChfnKyEbt2xb7iC1DLjhlh
	az+ecsgyLhNZm71is=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkBW_rl+duNpzfihAQ--.24054S2;
	Sat, 18 Apr 2026 20:18:16 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tglx@kernel.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] net: hamachi: fix divide by zero in hamachi_init_one
Date: Sat, 18 Apr 2026 20:18:04 +0800
Message-Id: <20260418121804.149171-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkBW_rl+duNpzfihAQ--.24054S2
X-Coremail-Antispam: 1UD129KBjvJXoW7try8uFW5tF1xuF1kCrWfXwb_yoW8uFy8pF
	WYk34vyw4DKwn0q3Z7trWxAFn8uay3t3y5uF95Jw1a93s8CFyrtr15KFWj9a43CFWrCw40
	yrWvyFy7uFn8tw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr
	0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0yCJ
	DUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUHEWniTmNg3AAEsP
X-Spamd-Result: default: False [7.84 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279494-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	NEURAL_SPAM(0.00)[0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stu.xidian.edu.cn:mid,xidian.edu.cn:email]
X-Rspamd-Queue-Id: 45A5D421138
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

During the hardware initialization phase in hamachi_init_one(), the driver
reads the PCIClkMeas register to calculate the PCI bus frequency.

The current code attempts to prevent a divide-by-zero error using a ternary
operator: `i ? 2000/(i&0x7f) : 0`. However, this check is flawed. The highest
bit of `i` (0x80) acts as a ready flag. If unreliable hardware or a malicious
virtual device returns a value where the ready bit is set but the lower 7 bits
are zero (e.g., 0x80), the condition `i` evaluates to true, but `(i & 0x7f)`
evaluates to 0. This results in a fatal divide-by-zero exception.

This bug was discovered during an automated virtual device fuzzing campaign
testing the hardware-software trust boundary. When the hardware returns 0x80,
it bypassed the readiness while-loop but triggered the divide error. In our
tests, this panic interrupted the module loading process, further triggering
a KASAN slab-out-of-bounds in the module error path, and ultimately leading
to a multi-core soft lockup and RCU stall.

This patch fixes the issue by explicitly checking the divisor `(i & 0x7f)`
instead of the entire register value `i` before performing the division.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/net/ethernet/packetengines/hamachi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/packetengines/hamachi.c b/drivers/net/ethernet/packetengines/hamachi.c
index b0de7e9f12a5..1d7206dd18fd 100644
--- a/drivers/net/ethernet/packetengines/hamachi.c
+++ b/drivers/net/ethernet/packetengines/hamachi.c
@@ -748,7 +748,7 @@ static int hamachi_init_one(struct pci_dev *pdev,
 	printk(KERN_INFO "%s:  %d-bit %d Mhz PCI bus (%d), Virtual Jumpers "
 		   "%2.2x, LPA %4.4x.\n",
 		   dev->name, readw(ioaddr + MiscStatus) & 1 ? 64 : 32,
-		   i ? 2000/(i&0x7f) : 0, i&0x7f, (int)readb(ioaddr + VirtualJumpers),
+		   (i & 0x7f) ? 2000 / (i & 0x7f) : 0, i & 0x7f, (int)readb(ioaddr + VirtualJumpers),
 		   readw(ioaddr + ANLinkPartnerAbility));
 
 	if (chip_tbl[hmp->chip_id].flags & CanHaveMII) {
-- 
2.34.1


