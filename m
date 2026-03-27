Return-Path: <netdev+bounces-272390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJfyEAcqxmnQGwUAu9opvQ
	(envelope-from <netdev+bounces-272390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:56:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CAE34019E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AF11300F28E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B127A39A04C;
	Fri, 27 Mar 2026 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="dcJKzizf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318B379EE5
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594561; cv=none; b=JQX5QnUThoc5tl4117gLKrWzyEl0+RrlZm/RcE9Vjn0MDlL1Ryc7Yr2xwug5+R0wUhzVfMTI6JI518Of719QPKZN5StJgTr5Vdnoh7jrcExjJSvJ5TAp3H8Cl3okFARvYgRiwNVV7JIEq2Neh9qcUncLlURwEjBvmDe3acqsNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594561; c=relaxed/simple;
	bh=GeU/u7xHeMZyM2vyFpy08CcXYUVTEEGoIykdwFWbWg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c29cSBulQbNt+9MUBwngj8R3C00IVH3D2WK2LcnmKFOWxXyRyBmA1zmlOZOgDndi6t/wB9WS0/dt6gPyCYCMzz1cnKZKv9UrnLQpMHiJ3I7XLm4MLM/JZk0S+s7Bk0Ph2W3SMaZBavA7Z0OlGRtPn7wW+87bsioMwhwf3W4IPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dcJKzizf; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c160308a54so648377eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774594552; x=1775199352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqw7WmN0LbKjxUaysnPN18wnaJzJzJ+G1EopNMP2/bc=;
        b=dcJKzizfOBkRGzqmUm27iz6cuzNIErvbvUKpedbCKpYQDYTjv6zS9+C5rnWReiu04i
         Xw3Sxd6y+5jzkwfjYdusuc4EWTswtSEPW8sFRen+ijfmekVJ9qrA9XkTxhdn7xTYkYqn
         L+TeNambYRzyLMt+0523fjUufOEz6ln0rcG6qfowOBLOANXmqlfoPZ5p3v2Ch2n7Y2yI
         HhgM3rfs5x4R0cvMTc3y8ER+WlvXsY7fRvZc1+zyZEwvSmNNAm17IGNH4jqbbV22BTHn
         wfQzBJGRaGXa5OW8LM5UEXG7BYyCrrSITO/sf9ADQFr0WyU6xsm/iEtnp7bEJWnyTXmg
         Me7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774594552; x=1775199352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kqw7WmN0LbKjxUaysnPN18wnaJzJzJ+G1EopNMP2/bc=;
        b=N9SQYOMd7vEcKVs/7g0UJj3XWjBC+/XeA9BWNU91vC1iYcljBHqOvHJEWpuIrLrWHp
         OwpBfQlsbnxJv5RvDPBBR+EkaIWjQFcesP0REU39xjIa2Fwn9Q4WB8UpoF4F0Muy5GDz
         O1eyqGnomL/Pvl4CxXUYSmvxO5+8Ly269njIIM8FVROXLpbohvNys0CCKHZ8aZN7/VVQ
         rgzZHv2Vzn8EBLx9JjSAbzXsg76LX+Ot6bHebehaCX5h6pPGyZyUE+gdjis7E/VfWyRd
         pcdfGCN5Cybm7l2rSW0G191QSjeESRqn3VhKBbfZ4MVtD5TkMGjH72LG1JcETfnoV5Y1
         Wqqg==
X-Gm-Message-State: AOJu0YxXYd70e5YPS9mU/lgB/iGZm8SQadi91O7MhPNhXU2S+AFNUYJU
	xeF09Xd5NGy/MHG1EC0y0z4exIO2SZVRVpw/Up/UPo6Hefc92SB2tPjSpmM57HDdZHgKb1srCMK
	xN1ue/g==
X-Gm-Gg: ATEYQzwz78Q/fdURASYk5IWAoeHbxKH7vM7UwovOmQBowuEqqUgn7JQgN5AUmaGRlLh
	6uOJJ8LCO0FzFK3gtF6p0RHqCFEiZpMEcBW57zRbxY4YUKH+mMZoGqOo+k4oYjZOhvtbt0XstOI
	2uzZZufLUiFij0oHmaueJTRIdrKfE0SQmQc7XmAlAqAdI3yJYD/gzQTcHu3GnnQYHZ/sSaF/U/J
	aGNkxdlGyJ2meyXZB1mRQi8IanamK+p3yo8gE3HIcrHHOTdbPRQVlYdoeulO4BgdXVn2xznuAV2
	pTYFLOlq4A4WU6KO4bZt9WZo20VpSSDm2Mw7gemm+LH/k363ct9Wrm2WFO+bl/7vIIWeVF7VmSe
	ZMiJ3wrALhDXs0ywom0TcY/OCNYP4Fwbc9l3oZwtDR9CUhQp+pcv47vjx5xzRFMAqZHk542jOZ3
	noLr5LozD63ovAJBqbh0kkF+7o2lzqlbm2v1iuhzE4IEoR88OZmS/Nqw==
X-Received: by 2002:a05:693c:3008:b0:2c1:6cfd:73df with SMTP id 5a478bee46e88-2c185e90d4bmr870057eec.30.1774594551497;
        Thu, 26 Mar 2026 23:55:51 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ee3c3ecsm4503957eec.31.2026.03.26.23.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:55:51 -0700 (PDT)
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
Subject: [PATCH net v2 1/3] net/sched: cls_fw: fix NULL pointer dereference on shared blocks
Date: Thu, 26 Mar 2026 23:55:45 -0700
Message-ID: <20260327065548.3191115-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272390-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41CAE34019E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The old-method path in fw_classify() calls tcf_block_q() and
dereferences q->handle. Shared blocks leave block->q NULL, causing a
NULL deref when an empty cls_fw filter is attached to a shared block
and a packet with a nonzero major skb mark is classified.

Check tcf_block_shared() before accessing block->q and return -1 (no
match) for shared blocks, consistent with cls_u32's tc_u_common_ptr().

The fixed null-ptr-deref calling stack:
 KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
 RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
 Call Trace:
  tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:1764 net/sched/cls_api.c:1860)
  tc_run (net/core/dev.c:4401)
  __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)

Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q helper to get struct Qdisc")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Correct 3/3 selftest case

 net/sched/cls_fw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index be81c108179d..caf17ab3be87 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -74,9 +74,14 @@ TC_INDIRECT_SCOPE int fw_classify(struct sk_buff *skb,
 			}
 		}
 	} else {
-		struct Qdisc *q = tcf_block_q(tp->chain->block);
+		struct tcf_block *block = tp->chain->block;
+		struct Qdisc *q;
+
+		if (tcf_block_shared(block))
+			return -1;
 
 		/* Old method: classify the packet using its skb mark. */
+		q = tcf_block_q(block);
 		if (id && (TC_H_MAJ(id) == 0 ||
 			   !(TC_H_MAJ(id ^ q->handle)))) {
 			res->classid = id;
-- 
2.43.0


