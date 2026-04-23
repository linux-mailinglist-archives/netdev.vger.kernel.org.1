Return-Path: <netdev+bounces-280663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CBfA3PX6WmglQIAu9opvQ
	(envelope-from <netdev+bounces-280663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:25:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE2944E82C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22317308A97E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D7390C8D;
	Thu, 23 Apr 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="swoHN/Y+"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37E394792;
	Thu, 23 Apr 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932596; cv=none; b=at80BNGZ9P02A7OEHPAr3Q06PAhOJUVR0kwoTYc5IYexEBJJdcolm6OGBdC6WrRsyPLzScOqo2h1JwFgtEkIipuGyjF+Hq00+JRkVWg0qwigCwmJhAmcgThIBu6uOJU29YLGf3VGqEwszoF3lXjptCnstgnb44GtukGFE/etk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932596; c=relaxed/simple;
	bh=grRHwSovjjUaMfFtGyplOIjIM9NIwuYyYjouDR1IH10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cL7dkyW4dPgDJ+tvq7Nd5YNBIDLBCsdne8vWUAgOOYOAo2ilwrRouLxmF8g9EPf6VtvdmN6JxyzvkRFhEjnzWE6pmRi1PH686R/Yrd49adWcctx5JTNa56Qtmkvyd5fNpQD/eienK/Qi0GozRtlwYttQ0SVUFDauVAzk4DlWROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=swoHN/Y+ reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Pf0fcGHrTb
	CZrN/UcCtPUNLr7w60fkHRwpxp5WWVHWk=; b=swoHN/Y+OO06+onqjSwQv72i7d
	dQAN22ZY3HFrKL/b+jYmrKLLoUFKq8m8q8dD0eOgdPDWt2OrDBPhexYM+tjXalIW
	53NtrFYHe0SgCecPGAwHRfZsB9jc4ViIixd1BC06tpWXXDDEYoybZ4/mRtK0H9j6
	IUcLDjdVBUOCHzeXQ=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkD227vK1ulp7TG3AQ--.36099S2;
	Thu, 23 Apr 2026 16:22:46 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: sd@queasysnail.net,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
Subject: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when queue is empty
Date: Thu, 23 Apr 2026 16:22:33 +0800
Message-Id: <20260423082233.514056-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkD227vK1ulp7TG3AQ--.36099S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWUZw1rtF48XFWDWrWUtwb_yoW8Cr4xpF
	ZrK3y5Jw1kJrs8t3ZFya1xXr4S93WjyF1agrW2kasI9wnxJr48JF18KFyYqF4rAFZ5KF45
	Xr4jvrWYkF4UuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUMEWno5lmIbgAAsB
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
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-280663-lists,netdev=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	NEURAL_SPAM(0.00)[1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	TAGGED_RCPT(0.00)[netdev,e5d6936b9f4545fd88ab];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xidian.edu.cn:email]
X-Rspamd-Queue-Id: CEE2944E82C
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

During fuzzing with failslab enabled, a memory leak was observed in the
IPv6 UDP send path.

The root cause resides in __ip6_make_skb(). In extremely rare cases
(such as fault injection or specific empty payload conditions),
__ip6_append_data() may succeed but leave the socket's write queue
empty.

When __ip6_make_skb() is subsequently called, __skb_dequeue(queue)
returns NULL. The previous logic handled this by executing a 'goto out;',
which completely bypassed the call to ip6_cork_release(cork).

Since the 'cork' structure actively holds a reference to the routing
entry (dst_entry) and potentially other allocated options, skipping
the release cleanly leaks these resources.

Fix this by introducing an 'out_cork_release' label and jumping to it
when skb is NULL, ensuring the cork state is always properly cleaned up.
The now-unused 'out' label is also removed to prevent compiler warnings.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 net/ipv6/ip6_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e92909ab5be..82210dd5eb96 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1934,7 +1934,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	skb = __skb_dequeue(queue);
 	if (!skb)
-		goto out;
+		goto out_cork_release;
 	tail_skb = &(skb_shinfo(skb)->frag_list);
 
 	/* move skb->data to ip header from ext header */
@@ -1998,8 +1998,8 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 		ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTMSGS);
 	}
 
+out_cork_release:
 	ip6_cork_release(cork);
-out:
 	return skb;
 }
 
-- 
2.34.1


