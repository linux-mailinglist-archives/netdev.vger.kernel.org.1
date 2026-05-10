Return-Path: <netdev+bounces-286248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLAGFb0sAGoGEAEAu9opvQ
	(envelope-from <netdev+bounces-286248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 08:59:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF4502DDE
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 08:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA4C130028EB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 06:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CA355F49;
	Sun, 10 May 2026 06:59:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AC32571C7
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778396341; cv=none; b=NywtZFkDatQYcVvwRNH5scMIT6Q35m5LRS46GKRSglwK9w634cb+R0SmFCOzKy3Rb5ZthAedXsA65L/j+hOF73v+WeFjImVh/W9VtDKwgiV5HdW8xCysSSa0WxDghYYJ5bbjhRqO6fCfhhVZx8TNUD8hKaI6dgswp0HRT9GZbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778396341; c=relaxed/simple;
	bh=RQoM/yJ6Y/rIDXG84i5cf415zSG0rmtHGdDo6SBz+UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bwr9xK8zjhYZwC2U6SrVM9Ub7Wvk9hJJv+5eA81VaQq1N7OiSuFrnaQ0pr4Vn1loMHn2vsKeoLBnosemWID/LrnNNws1lScryhrmrVrUYuIXWV0wowQoozZ1hQ6Yt2jiKol3ineUIC3xstKtT78NNgC8aH5ju106zWp1eI/svoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnFfafLABq_ToBAQ--.3380S2;
	Sun, 10 May 2026 14:58:40 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	matttbe@kernel.org
Cc: jbenc@redhat.com,
	davem@davemloft.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	lkp@intel.com,
	lx24@stu.ynu.edu.cn,
	caoruide123@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/1] net: nsh: limit recursive GSO redispatch
Date: Sun, 10 May 2026 14:58:39 +0800
Message-ID: <67e8340baa2c2772def267a801c8d5b201444d49.1778382236.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnFfafLABq_ToBAQ--.3380S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFykZr4fWr45tF1rXr15CFg_yoW5AF4rpF
	ZIgFn8KrZ3JryIyaykKF1UZF1rK3yUGFsrKFs8Ww4kXasYqr4IyFW0qFWjvF48J3yrKa4S
	vFnI9rWq9F4UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQwDCWn+9OUOaQACsk
X-Rspamd-Queue-Id: 47FF4502DDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[ynu.edu.cn:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,gmail.com,lzu.edu.cn,intel.com,stu.ynu.edu.cn];
	TAGGED_FROM(0.00)[bounces-286248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.704];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

From: Ruide Cao <caoruide123@gmail.com>

nsh_gso_segment() currently redispatches the inner payload through
skb_mac_gso_segment() after stripping one NSH header. For nested NSH
payloads, this can recurse back into nsh_gso_segment() through repeated
GSO redispatch.

The existing validation added by commit af50e4ba34f4 ("nsh: fix infinite
loop") only covers invalid header lengths and does not prevent recursive
redispatch across nested NSH payload chains.

Use the existing dev_xmit_recursion mechanism to bound recursive
redispatch, as with other nested tunnel-like paths in the networking
stack. If the recursion limit is exceeded, abort segmentation and unwind
the skb state through the existing error path.

This keeps the existing protocol behavior for normal packets while
preventing pathological recursion without adding NSH-specific protocol
unrolling.

Fixes: c411ed854584 ("nsh: add GSO support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604302359.kU59LnTI-lkp@intel.com/
Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v2:
- Rework the fix to use dev_xmit_recursion() instead of iteratively
    unwrapping nested NSH payloads.
- Abort segmentation when the recursion limit is exceeded and unwind
    skb state through skb_gso_error_unwind().
- Rewrite the commit message to reflect the recursion-limit approach.
- v1 link: https://lore.kernel.org/all/6112cce99b4e3571444a616d0fb19e91e2fcca72.1776597598.git.caoruide123@gmail.com/

 net/nsh/nsh.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index bfb7758063f3..d83e4e2da41e 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -107,12 +107,14 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 	skb->protocol = proto;
 
 	features &= NETIF_F_SG;
+	if (dev_xmit_recursion())
+		goto err;
+
+	dev_xmit_recursion_inc();
 	segs = skb_mac_gso_segment(skb, features);
-	if (IS_ERR_OR_NULL(segs)) {
-		skb_gso_error_unwind(skb, htons(ETH_P_NSH), nsh_len,
-				     mac_offset, mac_len);
-		goto out;
-	}
+	dev_xmit_recursion_dec();
+	if (IS_ERR_OR_NULL(segs))
+		goto err;
 
 	for (skb = segs; skb; skb = skb->next) {
 		skb->protocol = outer_proto;
@@ -122,6 +124,11 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 		skb->mac_len = mac_len;
 	}
 
+	goto out;
+
+err:
+	skb_gso_error_unwind(skb, outer_proto, nsh_len, mac_offset, mac_len);
+
 out:
 	return segs;
 }
-- 
2.34.1


