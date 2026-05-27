Return-Path: <netdev+bounces-292169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EiEMfqoFmrEoAcAu9opvQ
	(envelope-from <netdev+bounces-292169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1415E0F9D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C375301D5AD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360083CF66B;
	Wed, 27 May 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="QEL+pgSx"
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E603BB10A;
	Wed, 27 May 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869929; cv=none; b=LJcBstPyRqu3Ih0rs0pC7K9RF41Gg1A/61bLyGo8DQkNK9bOroqzS/TNTtjHWU5i7RhFpcGp+td6Nx5ZYzIZRxceVr0Df934rgP7pCGG/58Iqje6jxDS6nqmJempENllrPiGeV/fLYK2Ex61yyPvPdn7LzbTLNIzWcl7sgSAMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869929; c=relaxed/simple;
	bh=syfk5959tJHAPWULL5+nOqHgS2Vt+pN5sQcrmx2+q1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHKIT5QSQ2c08rz9FPxOZdEVZkOnSnB4ScZFDswvWX7XaXpiV767hXZTkYkEOhFYPoI718TjP49OJfSGcvwNgLTxD6/xnr5SLT7U91OZ36Ywb4XE42aDZArq4/+D908oJaYY5EvwIHt5GVdGD7qkM75kKeqCrUT9cpXi7vFJC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=QEL+pgSx; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=2rub8
	xVFH79HgKRt47yMxbSOY6mYiviajCZO6Mf7T5k=; b=QEL+pgSxblLp9DWSugux8
	gguAPIWCC+lsykNdN3bz1BL63x+vsVOwTjA62HksH9jrMuYD54Yj7Mtut3mH1Pqd
	wxyrG3bG67SiNfygShp1SRDqdUk7cRJgGmjOCwCwszoDMS0jF+AO5IGOXgRhOHay
	HQeun4ksVS8WI1vq+BcCjI=
Received: from localhost.localdomain (unknown [211.102.241.99])
	by web3 (Coremail) with SMTP id ygQGZQA3go_ZqBZqOrztAQ--.39780S2;
	Wed, 27 May 2026 16:18:33 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Alexander Aring <alex.aring@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH net] 6lowpan: fix off-by-one in multicast context address compression
Date: Wed, 27 May 2026 16:18:01 +0800
Message-ID: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQA3go_ZqBZqOrztAQ--.39780S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1rtw18tw45WF4UJr4rAFb_yoW8Zry3pa
	s7A3s0yF97JrW3u392yw1jvw17uF4kJrWay340ya4YvFn0gF10yr18KFWkJas0yrWYk34j
	qFWUCrWYyan8GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjXTm3UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEAAWoWnq0YHQAAsL
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292169-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C1415E0F9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The second memcpy in lowpan_iphc_mcast_ctx_addr_compress() uses
&data[1] as destination and &ipaddr->s6_addr[11] as source, but
both should be offset by one: &data[2] and &ipaddr->s6_addr[12]
respectively.

This off-by-one has two consequences:
1. data[1] is overwritten with s6_addr[11], corrupting the RIID
   field in the compressed multicast address
2. data[5] is never written, so uninitialized kernel stack memory
   is transmitted over the network via lowpan_push_hc_data(),
   leaking kernel stack contents

The correct inline data layout must match what the decompression
function lowpan_uncompress_multicast_ctx_daddr() expects:
  data[0..1] = s6_addr[1..2]  (flags/scope + RIID)
  data[2..5] = s6_addr[12..15] (group ID)

Also zero-initialize the data array as a defensive measure against
similar bugs in the future.

Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index e116d30..37eaff3 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1086,12 +1086,12 @@ static u8 lowpan_iphc_mcast_ctx_addr_compress(u8 **hc_ptr,
 					      const struct lowpan_iphc_ctx *ctx,
 					      const struct in6_addr *ipaddr)
 {
-	u8 data[6];
+	u8 data[6] = {};
 
 	/* flags/scope, reserved (RIID) */
 	memcpy(data, &ipaddr->s6_addr[1], 2);
 	/* group ID */
-	memcpy(&data[1], &ipaddr->s6_addr[11], 4);
+	memcpy(&data[2], &ipaddr->s6_addr[12], 4);
 	lowpan_push_hc_data(hc_ptr, data, 6);
 
 	return LOWPAN_IPHC_DAM_00;


--
2.43.0


