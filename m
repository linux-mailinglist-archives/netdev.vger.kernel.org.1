Return-Path: <netdev+bounces-272380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LtDF/sfxmlbGwUAu9opvQ
	(envelope-from <netdev+bounces-272380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:13:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C888E33F68E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 834C6306B38E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F755344D91;
	Fri, 27 Mar 2026 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="jqpMUgA8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBE26056D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774591993; cv=none; b=dHnsqnIoqxnN5AH2B9F+gbWWkIqYOvvbx4FubTMQPig3xrYvDEmm7OM7U66OGh9z6N2yySHgbTLiDXgJ0DrwOb7RV4d4qpssQaL+3CuM/WTYSzr7ZZW/pZdejmoyjkkhnjLaqRHyCZYmBww78cyc9tNSsbuhJbJlAIrUZiHMgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774591993; c=relaxed/simple;
	bh=EzcmwyeAJd7ac/N4xer2c8VkAfWnF6UxJZei2LznsDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKiyOS5ZzfddReyxiZ5Y9ktEPMjbOUDt/NzTEYk2lCUHEWvFNia9S3NgiPDtmmpEMLa8Mw31GRdmguevGyELEtaJd6alwu5TmoO+wPT7WpXACRsf0kpdjyzEelsW9cbu+qDTF27gpSiqNbtUoufc6ZYsgCyzEhJXsRBhtZWXJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=jqpMUgA8; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c17446ba8dso976024eec.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774591991; x=1775196791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgfMJxv4Ps7f5TI6ljVDp50RvmNcIVtt55VtHtlzQpU=;
        b=jqpMUgA842XgknARW0/jVk0k9/r3Pna4jPxfcGbZvHMD3kU/vZ3CAcz1SPspGdPlbU
         65Lq750qphOZNhjN69A6EkJxxIh8ioFSheaO5vLfI4HrYw6LjoUsv5O1JB65HdHntQE9
         nPzWeQj2bu1Xl4N39tYMlRHa/xfhSvJHhw+RcS7XnrsSQzPGRJtdmYoqjGYRppHrid3H
         PTZEJz3u74wULSpL98eVEEY9RuShSdTm18e77WpGA2r8E4SqqIvn550zMVYvq+WV+FcK
         +3bY6NoD0FpJT5Nhz+QTakES1ZJye2J36kRVHCWjDcHc+EfuheYR3SxHhClLVDRGGQBj
         Ve0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774591991; x=1775196791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LgfMJxv4Ps7f5TI6ljVDp50RvmNcIVtt55VtHtlzQpU=;
        b=nEK/kBWOTSyQCBCMdTSCIyk4UdkDvPceNXG8oJ7STk3E0whBk1QptNSik/V+29ydMj
         595XSzxe2wz5r+9z2iMZ14+9V4xlwI0XLZ0NNahVK+cH6RyTT4BbBdfjlF9JHLA6qLnh
         HFrrvDGa+7Si0cEyNrsVMQ2gzUuyzAd29B+1h57x3Rs/+UiJUssyJtUaeLJ0vu1r7TVx
         XJvGkqihk3H8tUxSJKfJnDQC3fKOp+X5bRlc1aEbtNWiC35th8T16ljFJ2T7pqiaOVGu
         X8ezFBpmf+tOYeDASUkAIVTCb34+v29AdiTyDy9vOR2LDQxRyp+NmhBNjrikoOGDlcmp
         OGGw==
X-Gm-Message-State: AOJu0YwKxnUL4vPVsDtp0DPIMIBDJx2pj0cOco6Od4z4CelRmtVsK3il
	Kuut2phYjmkb09/ivEvExRlnMDB9dqGpfatK3Wjba9fCDtMNUvhhExwawq2jKKApdj/5HGYwQRZ
	bAYSGLA==
X-Gm-Gg: ATEYQzweGuumSFjZzH7ZVin1LTlYvGaOhfi33ScMpitXNHu+HQrswpK8CQBfDlql3BW
	wlCLeqm+eFFlwzL3Kxj+ljPHuJK055UBe61po1P5E6ant5OxyK7FbX6t37l78LG7NJoAP04vk9K
	JCa2oV5Pl1pD9iohxBqfEiuqw2MY5EC/gcRSr9bun46Y4b4zkRQmY7ojXokoi5Yprc2sU6zXuFU
	fBcM6f4EVnc5dWJIwGLXU4tiAB4MJyLdY4EetgGiT2LW3IX26GEkT8+IzeOjFU5Ju1Phyb208MW
	FWVx+mhH8ljAIT2HYjkqtDT4canRJu5q97j9Y/9jMWn890wswKcoAbMRhLVpYpwY9UWvK3mZkM/
	U/L9y04rQv7Rw2TZ4P96MWDPjW31Zu+pGfQ3GLmg6L1tn2VAVivcRUi0+XRrfzRflHKw1lezGPA
	M2OObRAR1niAdwPL6u9C+tikhT/8gW1n24FXYzXLDXxqfBQ153dwRC2A==
X-Received: by 2002:a05:7301:6091:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-2c17727c7a9mr1985431eec.18.1774591990825;
        Thu, 26 Mar 2026 23:13:10 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec26651sm4629441eec.2.2026.03.26.23.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:13:10 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net 2/3] net/sched: cls_flow: fix NULL pointer dereference on shared blocks
Date: Thu, 26 Mar 2026 23:12:59 -0700
Message-ID: <20260327061300.3066844-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327061300.3066844-1-xmei5@asu.edu>
References: <20260327061300.3066844-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272380-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C888E33F68E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

flow_change() calls tcf_block_q() and dereferences q->handle to derive
a default baseclass. Shared blocks leave block->q NULL, causing a NULL
deref when a flow filter without a fully qualified baseclass is created
on a shared block.

Check tcf_block_shared() before accessing block->q and return -EINVAL
for shared blocks. This avoids the null-deref shown below:

=======================================================================
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
RIP: 0010:flow_change (net/sched/cls_flow.c:508)
Call Trace:
 tc_new_tfilter (net/sched/cls_api.c:2432)
 rtnetlink_rcv_msg (net/core/rtnetlink.c:6980)
 [...]
=======================================================================

Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q helper to get struct Qdisc")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/sched/cls_flow.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 339c664beff6..26077681c9b6 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -503,8 +503,13 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		}
 
 		if (TC_H_MAJ(baseclass) == 0) {
-			struct Qdisc *q = tcf_block_q(tp->chain->block);
+			struct tcf_block *block = tp->chain->block;
+			struct Qdisc *q;
 
+			if (tcf_block_shared(block))
+				goto err2;
+
+			q = tcf_block_q(block);
 			baseclass = TC_H_MAKE(q->handle, baseclass);
 		}
 		if (TC_H_MIN(baseclass) == 0)
-- 
2.43.0


