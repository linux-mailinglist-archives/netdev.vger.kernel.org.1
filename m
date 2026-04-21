Return-Path: <netdev+bounces-280004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL8+MqL75mlu2QEAu9opvQ
	(envelope-from <netdev+bounces-280004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:22:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE170436428
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3791A300B9DD
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D60248F6F;
	Tue, 21 Apr 2026 04:22:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24B35979
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776745375; cv=none; b=UXEfYhusJtCfLN9oY9/9z/LhQCnuUfM/r1rE/sarx3nWRV3mxRoN1E5KPNXkOIEk7BNUDRjRflZ1lZ+LVnBkOHZoiR0heSOPceKf5eAwFUlSzoQWw795H6rq5kaGREDM41lpHrkAcVJD8VrbQXLrONzSSiSZxpqPlkzhcNERTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776745375; c=relaxed/simple;
	bh=apP1c0s1Co56WKUOfNjtoDP7I9y+pvzRapW9qJun9L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/jWhAyQ8P130YTnfNo73XevnBwoYfjjjFhOye94WAGotajB1F9J46GZUY6zaR0gJsjHtflmTnH5qR+WzJ2e1iiCthbpacNZ5NtNFOdhyeJsdW33XdqSyT6/HKSGdvei4n4r/tbnEJvfflX+wlYmDQfY8LJzwG3GYZlydHiyeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowABXz_+N++ZpWAbYAA--.51842S2;
	Tue, 21 Apr 2026 12:22:37 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andreas.a.roeseler@gmail.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	caoruide123@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2] ipv4: icmp: validate reply type before using icmp_pointers
Date: Tue, 21 Apr 2026 12:16:31 +0800
Message-ID: <0dace90c01a5978e829ca741ef684dbd7304ce62.1776628519.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowABXz_+N++ZpWAbYAA--.51842S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkJF4kGF17ZFy7ZF1UJrb_yoW8Cw17pF
	ZIkFs5JrZ8Jr9xJF1qyFy0kr4UWrWDWFWDG39Fg3WDuas3trs7AF4FgwnxWr1qka1IkFWY
	yFn0vr4qy398ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEDCWnl6GEKsAABs0
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-280004-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.819];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: AE170436428
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ruide Cao <caoruide123@gmail.com>

Extended echo replies use ICMP_EXT_ECHOREPLY as the outbound reply type.
That value is outside the range covered by icmp_pointers[], which only
describes the traditional ICMP types up to NR_ICMP_TYPES.

Avoid consulting icmp_pointers[] for reply types outside that range, and
use array_index_nospec() for the remaining in-range lookup. Normal ICMP
replies keep their existing behavior unchanged.

Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v2:
use array_index_nospec()
v1 link: https://lore.kernel.org/all/efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com/

 net/ipv4/icmp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 4e2a6c70dcd8..ba4b1eec9ea2 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -64,6 +64,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/fcntl.h>
+#include <linux/nospec.h>
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/inet.h>
@@ -373,7 +374,9 @@ static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
 				      to, len);
 
 	skb->csum = csum_block_add(skb->csum, csum, odd);
-	if (icmp_pointers[icmp_param->data.icmph.type].error)
+	if (icmp_param->data.icmph.type <= NR_ICMP_TYPES &&
+	    icmp_pointers[array_index_nospec(icmp_param->data.icmph.type,
+					     NR_ICMP_TYPES + 1)].error)
 		nf_ct_attach(skb, icmp_param->skb);
 	return 0;
 }
-- 
2.34.1


