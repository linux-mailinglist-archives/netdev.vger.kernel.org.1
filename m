Return-Path: <netdev+bounces-272391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNXcC/4sxmmNHQUAu9opvQ
	(envelope-from <netdev+bounces-272391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:08:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73761340329
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4709A30AE519
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1400B3BE173;
	Fri, 27 Mar 2026 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="TygdmLD1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0D3C141A
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594562; cv=none; b=ogy36h69jHalu+3M3UdwqZADab453yMy2BaSbZ8tqLG10nEFEPgaj4BDfMRXJfcGFZY7Ve/CeNPnv0nk6FUQAuCEuBWcMeN75PeDAqnqxmNaIRmjLAIBvTmgN1rH8uNks2rEBqBF/Ut3wbzlcs6vQ0UTQq6p5rltHQ+eI6ENDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594562; c=relaxed/simple;
	bh=uqBkmivwq+/owl7EevXGZfiPmXbB+lwInab5MgQrSvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQn8SyZkuXQx3cFoS7HF0r5vrTIrUWlvTxcuyxFaoXSBBeYr2m8akIaTY2yDm41MNeym0kxPb6m96pOZlFuZr6wgP00IP8iYJsY0FWd+hkc3kpH3ZadhQ95oWe0gekBs8am3ZoQc63fzFlXO4khrf3wofSQime8uHTRdiR2MeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=TygdmLD1; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c1092cc08cso4752754eec.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774594553; x=1775199353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d//Qz/QP/J6KYWYRR+MqZvKgbvpCoVXsYCB383fXLuE=;
        b=TygdmLD1+YA2OOuoxFIyU2AqliocRr8sSqF7GQGq0+3oHV8gL6MqYFyrLGcC/8zyyb
         x5z41GLk/GXqvn+wzbGBcnYt1Xo/Y6aUN9Td4fy4N6PyOMaDZja2ToX0Yvew91N3LcgS
         5f76y/LkuFGIT42Hoa+r+VgYjpokNArAY/jqFtuAANxzkihxh0I19SR8381ooznMR0Bl
         ociAkd/3WWLYmkYYWnOgZ5rbMITw8Fx6WYoMaBxje4LP/Ftjrsltv7MW+i18+NoEeR+J
         +3aLGxdSFSCEbGGZCZwHoz71T0DqdFUqmJ34SjZvJpeCTwO0hvds5AS72rw5a5Z6ZJly
         uKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774594553; x=1775199353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d//Qz/QP/J6KYWYRR+MqZvKgbvpCoVXsYCB383fXLuE=;
        b=jm22CRSGg/nDSew3pGmefMRXB8KRxJmNf/P1oyP+SpjCzShfoZNoyuW9kpxZvntJRh
         Fu1wD9y+K5OYgwxLWIsbuwRXfuTn4xTsAXOn27Wm9gnGlgUMd+IXXfwxg2OXwBdeEzsT
         b5REevn+zWKtP7ieLlCsv+Ra75G4ak1/z33/mr0lPkGDb/WQLb0yzrAapOO+94iZnRbt
         nmmUincBtDe5QMR2apIjzJCvZbkbyrsIJu4wueUX6GtN3/V8zop/HdVViEUOCmGFJISK
         mMVKnIMhPmFsh/5JtZ94TtFhd0gRTi68boePBb2Ut8U6RkHcKp9ciWJ92iD/WhIlYTBz
         45Nw==
X-Gm-Message-State: AOJu0Yxnthkm6Pv/ajj2Bi1z8l/fFxrq1m+ax1dkltKMQ/jnupMq/qiJ
	p7Gabhoq7PApX1uufq5tfUzMdGczOVXoiUFi/hkE02bJJqyh+IXvyeRfBtoqN3vU8l46yzmJuLw
	CDBMlSg==
X-Gm-Gg: ATEYQzyr2s+QO7FDIDOewPMRz0g/hqmgx0rBoZ7YOLxYGMu1bOwwa8A/ftszXqTlMDo
	INwAF5lIDGK7uAf7E3/DJ98pGdGnha3VXD0FBmDpshbXsfAJjhSN2JhxDfc76+YOv7/IPZnKJW+
	T0RmXGHxnLUGJsk8A0o6+GUNz3A0EfX8up5yhyL/jJZdpdPBToFGCvyBc4IVCBrQtE9REPEHnyQ
	oHs+yLJnWLycIJI1ydP9XygbYy1+u7zQPQU/uM8nndJJ0FNY9xioAqKcz7oVMR4h33/zJr4UqvU
	iAvSg0XkoveRpgmuG5UY/bAayiLhpKkKSMyO8Ujq4nJ6l8vaT4c/DYLFQmpTpkSQACa52R2ij7m
	dVlBpr23bf+Tbqw1VcYEDk8qUGpqfGmbSEQouy2eY4S3CRZOIzEi60AsFnT6NftK/dGk7FHEJbn
	yk4gt9QtnjpoLXqjK2SvL95ENIjohvaqYhyXXxjJvUpyMispV5xVrDOg==
X-Received: by 2002:a05:7301:d0b:b0:2b8:64ad:ad4d with SMTP id 5a478bee46e88-2c185e2fa35mr667104eec.26.1774594553409;
        Thu, 26 Mar 2026 23:55:53 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ee3c3ecsm4503957eec.31.2026.03.26.23.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:55:53 -0700 (PDT)
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
Subject: [PATCH net v2 2/3] net/sched: cls_flow: fix NULL pointer dereference on shared blocks
Date: Thu, 26 Mar 2026 23:55:46 -0700
Message-ID: <20260327065548.3191115-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327065548.3191115-1-xmei5@asu.edu>
References: <20260327065548.3191115-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272391-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73761340329
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
v2: Correct 3/3 selftest case

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


