Return-Path: <netdev+bounces-280385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OYwL+mp6GnEOQIAu9opvQ
	(envelope-from <netdev+bounces-280385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:58:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA04450A2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9ED91300EB52
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8653C13FD;
	Wed, 22 Apr 2026 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="3LEM8CEX"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9017A1E5724;
	Wed, 22 Apr 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855521; cv=none; b=GeVBsXolvHPUtDh2nYhsW53kQMNSOCP3LMjCyEYF6pb4MK4F+rjJBMcPhsNZXz7evcAXgXPkOTELzVN6SRWvnJvDGM3DzK12kPuxaIriHXaF+EaQ/rQqAY6UxkTdCB/AA+0qOQNRUhvsyOEnTMefzZ9SbjbZVlYSBI/SzYBOtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855521; c=relaxed/simple;
	bh=TTcsVqyO+cRvqywCmON3S9sMBf2mjoLY9CJLaCXlzM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E0br4zTHTBt4ID2BB5ppPHioo+moVFXZaOJ6T6FYUhtQ98Y2fegjEuY0FuUIVhkVeBI0RbFYb2hC3h+osoDETokPTn7fFTdrP9m1Hqlrba/r6StpySawrMYj02JGrS+78/q224KEHGeSZ6J70lnBy6GI49BnuBPIFcAoTKeMlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=3LEM8CEX reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=AAAU2GMGPr
	G1zZgq/1GH5AH+uMaADrCdJyeoKBuVvpc=; b=3LEM8CEX7eLAr6z97RMBLHwYm0
	ib+ZC7IDSXJKR60LlXKVusSu1YQWlkafM75br5ylG7sUVguXsQiD2fthunltI2K5
	JIVsN07kao1siFB8G06UWNQBbLRZfOQpAIbGIZtpTHifv/SxM4Y90czCNqwK8r9J
	aDUxnfooA6pj5+0F4=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkCmxjC8qehpyyKzAQ--.8112S2;
	Wed, 22 Apr 2026 18:58:16 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] ipv6: udp: fix memory leak in udpv6_sendmsg error path
Date: Wed, 22 Apr 2026 18:58:02 +0800
Message-Id: <20260422105802.486216-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkCmxjC8qehpyyKzAQ--.8112S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWUKFW7Jr15Jw18CFykXwb_yoW8Gr1kpw
	4xKw4Yyr4DJrnxKFyxJ3WxZr15uayFqFyY9F13uas2krnxGF1xJr40vF4jqa1rAFs5uw45
	ZayvqFW5uFyDCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgULEWnnlGSYMwAAsI
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
	TO_DN_SOME(0.00)[];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	TAGGED_FROM(0.00)[bounces-280385-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	NEURAL_SPAM(0.00)[0.929];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xidian.edu.cn:email,stu.xidian.edu.cn:mid]
X-Rspamd-Queue-Id: 97FA04450A2
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

During fuzzing with failslab enabled, a memory leak was observed in the
IPv6 UDP send path.

When sending via the lockless fast path (!corkreq), udpv6_sendmsg()
calls ip6_make_skb() and assumes that the routing entry (dst_entry)
reference has been stolen by the callee. However, if ip6_make_skb()
fails early (e.g., due to an ENOMEM from memory allocation failure),
it returns an error pointer without consuming the dst reference.

Since udpv6_sendmsg() unconditionally jumps to the 'out_no_dst' label,
the unconsumed dst_entry is never released, resulting in a memory leak.

Fix this by explicitly calling dst_release(dst) when ip6_make_skb()
returns an error.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 net/ipv6/udp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194ecc..b83ecfd729af 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1706,8 +1706,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 				   dst_rt6_info(dst),
 				   msg->msg_flags, &cork);
 		err = PTR_ERR(skb);
-		if (!IS_ERR_OR_NULL(skb))
+		if (!IS_ERR_OR_NULL(skb)) {
 			err = udp_v6_send_skb(skb, fl6, &cork.base);
+		} else {
+			dst_release(dst);
+		}
 		/* ip6_make_skb steals dst reference */
 		goto out_no_dst;
 	}
-- 
2.34.1


