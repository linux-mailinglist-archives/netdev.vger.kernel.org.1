Return-Path: <netdev+bounces-299391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aaJdErzVL2rdHgUAu9opvQ
	(envelope-from <netdev+bounces-299391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:36:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4168561A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:36:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299391-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299391-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EC4730066B5
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C7732ED27;
	Mon, 15 Jun 2026 10:36:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99640D586
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:36:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519801; cv=none; b=rtDLFwBIJjzBcA9Xx+J5L8m4OONXlfCa5agu4LvRcMDVNrHG76gzlzg5UnS2uo/JMpJrYA6KeoUHgs9SVHLEtmw46sBnpSY2s1EzhQMrimL13grmIKZlmMxVdQMZej7hntjG4aNq9/84iKoFb6RwQzQkTIudE2eoJ0jZ55xEd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519801; c=relaxed/simple;
	bh=cilkiXJoTKf/1DnW4ZFRYfjLP3Ydn6ylgzjtwVSOv2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=si1Bx3f3J4gRrCxticQz9z/juJYhB6SCcyiNgf0iZAgv2KFr8J5NvjxS+UeMXaCuAmmluKnd33keCF8BpjKZ22yrxKPVSROiI85jDQhjulHdNPDsrFhOPo9rhVD3dq+kq2LQNwfjrwW//BOohlCnaumvnao4vF0xxo4ZIQnhOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.175.55.52
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAB3f7OY1S9q7pUnAA--.2386S2;
	Mon, 15 Jun 2026 18:36:08 +0800 (CST)
Received: from uu22.. (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wCnngmX1S9qcBFTAA--.12278S2;
	Mon, 15 Jun 2026 18:36:07 +0800 (CST)
From: Yinhao Hu <dddddd@hust.edu.cn>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david+nfc@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com,
	Yinhao Hu <dddddd@hust.edu.cn>
Subject: [PATCH net] nfc: pn533: prevent division by zero in the listen mode timer
Date: Mon, 15 Jun 2026 03:35:47 -0700
Message-ID: <20260615103547.1599528-1-dddddd@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAB3f7OY1S9q7pUnAA--.2386S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxtFW5Gry8Zr43Jw4fXwb_yoW8Cr4kpr
	Z8XFyayr4DXr4UKF4UGFWDWa4rZ3Z7JrW8tFWUKwsrCF90q3WFyFW5ta1agFs7trWrAr42
	vFZ5Wr1Dua90kFUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8ErcxFaV
	Av8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04
	k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07bcuciUUUUU=
X-CM-SenderInfo: bgsqjkiyqyjko6kx23oohg3hdfq/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ixit.cz,kernel.org,gmail.com,hust.edu.cn,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-299391-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[hust.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:david+nfc@ixit.cz,m:krzk@kernel.org,m:kuba@kernel.org,m:error27@gmail.com,m:dzm91@hust.edu.cn,m:hust-os-kernel-patches@googlegroups.com,m:dddddd@hust.edu.cn,m:david@ixit.cz,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dddddd@hust.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dddddd@hust.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFE4168561A

The listen-mode timer handler advances the polling state machine through
pn533_poll_next_mod(), which computes:

dev->poll_mod_curr = (dev->poll_mod_curr + 1) % dev->poll_mod_count;

pn533_poll_reset_mod_list() clears dev->poll_mod_count without first
stopping that timer: pn533_dep_link_down() deletes no timer at all, and
pn533_stop_poll() uses timer_delete(), which does not wait for a handler
already running on another CPU. When the handler runs after the count
has been zeroed, it divides by zero:

Oops: divide error: 0000 [#1] SMP
RIP: 0010:pn533_listen_mode_timer+0x9b/0x110

Delete the timer synchronously in pn533_poll_reset_mod_list(), the single
place that clears the list, so the handler can no longer run past a reset.
Also return early when poll_mod_count is already zero, covering the window
where pn533_wq_poll() re-arms the timer just before a reset.

Fixes: 6fbbdc16be38 ("NFC: Implement pn533 polling loop")
Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
---
 drivers/nfc/pn533/pn533.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index d7bdbc82e2ba..88df99001b4a 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -951,6 +951,7 @@ static inline void pn533_poll_next_mod(struct pn533 *dev)
 
 static void pn533_poll_reset_mod_list(struct pn533 *dev)
 {
+	timer_delete_sync(&dev->listen_timer);
 	dev->poll_mod_count = 0;
 }
 
@@ -1235,6 +1236,10 @@ static void pn533_listen_mode_timer(struct timer_list *t)
 {
 	struct pn533 *dev = timer_container_of(dev, t, listen_timer);
 
+	/* Polling may have been stopped while the timer was pending. */
+	if (!dev->poll_mod_count)
+		return;
+
 	dev->cancel_listen = 1;
 
 	pn533_poll_next_mod(dev);
-- 
2.43.0


