Return-Path: <netdev+bounces-273516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDW6EdOCy2l4IgYAu9opvQ
	(envelope-from <netdev+bounces-273516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:16:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF7365F3B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30BA53056104
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF13D6688;
	Tue, 31 Mar 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haDzv/d4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C423D6CDD
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944182; cv=none; b=rXSImKaVt2Gt3BQxKz5W9KvWeqq4GrNoaV5bO3wKPSk8TE/AOTsdkj25PcLflVzGD2L79WfNfIgyHK3BjKluOtrcbvldzwY3gkJ3/GPFcM9+VbBnNFRCtLWzgvO6D8w72jPrNwEl1zhK35Mk3xBt+Q4i3yFcwznablnXvZZsRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944182; c=relaxed/simple;
	bh=xEMxy10j/in+Jc82Ss01pEcL/fnHoS9Jm23s9tilhsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSQctSXVUpfh9f7knZT7rOrOzuqMe10J/vu3smBLjJDdtw/AeWuYEJad23LGjjRFsR+adEWOU7qRgPWi0yuECWocgQY8sjWZPcTXy5ZkwnHtduzH/YqAdleIhFRB9ULmcqYzEMZVOAAGXzd/cjuccvjYcP/KmZgWfzfys5Jm+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haDzv/d4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a893d289bso2329335b3a.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774944180; x=1775548980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj9hbu3Ee7OLEVq2o+ptn8L5WwFlALaVQohCAXxnCuk=;
        b=haDzv/d4Vss6oz+eKuafDdUK/1jz4dHCDXwBnZ3QxwX/F+oz54r95aGhEWQPXVW7py
         zGvut8OqErPGKtCusTVpS4+0FsqUsnx7tGd6sP2+AWkuPDvh0dxv/RSo02y1GqxhydpN
         gws7yRK8zGt5QVG8xYcU6ykmvUPgJtBH4ClUT/TIF/oDK7stO4+nK0Yxa8Oq2MK3JFDv
         O/j5rjkLYeVLC3sxKEIsCe8eCExhhKOjQtJ7vBN7QWNtvJo7lw27b0dM52rC0j3KOYZH
         aW30rUdf1ei73+MeFqonFcDlgOVHoVYpEdAQLYMLu0UQNnlbwKF/pqdvE9Q/JIfydEHA
         2jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774944180; x=1775548980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uj9hbu3Ee7OLEVq2o+ptn8L5WwFlALaVQohCAXxnCuk=;
        b=YfsGNEttAbP+NQp5OovWjnHHFGoS+Hyt/M2UW75otQGz4XrHKDbXfki9s679QWBfZf
         VKhqC4pk//NM1rCrAX9s5yZ3c5WYwXde4fmkxMirvwXBGGiyG7x3OnhRP69/DtqPBFKJ
         ofmHNxfLwattKi0otIYxwdpTLnrGFtHgpn4iz6HcgAWtYzR1EpoE5HkaAQAksJA43Q4A
         pQIlk4zhL1vqeEdUciFD8TcPkFX+fcTQ8wwGg0gPRLLK74sIrvS8u31LDZ2y5At4nywE
         B8BHgY2G4Fs/mq8/qYFm27TwjEFDxS+FUho1GIhOucD53Gow4BjOXzB210DKNizh6KJF
         PKww==
X-Forwarded-Encrypted: i=1; AJvYcCU0oPDY/mGTM+IpS99WqfwxpWwXqJILuUzFqen48tacKJrVhf0N5u3qpAHeNLpAl3vCtFltdWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkKu5O9OkwHMldJBPNwM51HIA8Khv1TXlobl1sJ1kb3Af6Ffz
	uL32l14UFR6mskoHzA8KkEGiWPJM1Fu1KN+N8z2yDd6EOwmQfYniJZUt
X-Gm-Gg: ATEYQzxDiV5UF3EspeeUCDaGxvP79fNBbixcLVQVrc+/oJt8svt4oSb2Z2uWHNMx5P+
	ZzKjG1Z90V6sQl1RxdYFKLBEqIWqx3Mt+Mj57QMhUmj/XF1mjgFPvAKYaIqUxRF+srcWfapV5jw
	KOEk7mWW6Lcj/WUtoxJcLdQsRUpuReqqi+ADu3/Cfz/nUFq7KhngRCVuU1i5DQl/NVBwSUK9Fr+
	ENCo+s2u9jWWHbQ3AmP290CH5VyOofEgypjb9dSEurEwTCz/uLcHMhhdJVPCLycRfaShyGxgbdJ
	5rkR8qVHdQTLi5OQZA7kyqg4gPO/WS6GkLAW5NTkh69sN0SovVvbc+9+23YE0Hi7ktbgMLpBbMt
	U22l7LPS6w/FQKfraB8ceDDPqSmCUiCwVExvNLkVBg57zGXcTbI60dSH5WuW/papUU/HWZ/I9HQ
	QAgy3ci8/omIHK
X-Received: by 2002:a05:6a00:1398:b0:82a:780f:a187 with SMTP id d2e1a72fcca58-82c9600194cmr14690149b3a.36.1774944180126;
        Tue, 31 Mar 2026 01:03:00 -0700 (PDT)
Received: from kano.localdomain ([2001:da8:c000:3011::3:e1b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc735sm9349254b3a.40.2026.03.31.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 01:02:59 -0700 (PDT)
From: Yucheng Lu <kanolyc@gmail.com>
To: security@kernel.org,
	stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	Jason@zx2c4.com,
	kees@kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	tanyuan98@outlook.com,
	bird@lzu.edu.cn,
	z1652074432@gmail.com,
	Yucheng Lu <kanolyc@gmail.com>
Subject: [PATCH RESEND net v2 1/1] net/sched: sch_netem: fix out-of-bounds access in packet corruption
Date: Tue, 31 Mar 2026 16:00:21 +0800
Message-ID: <45435c0935df877853a81e6d06205ac738ec65fa.1774941614.git.kanolyc@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773323637.git.kanolyc@gmail.com>
References: <cover.1773323637.git.kanolyc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,zx2c4.com,kernel.org,gmail.com,outlook.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-273516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kanolyc@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 4DAF7365F3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In netem_enqueue(), the packet corruption logic uses
get_random_u32_below(skb_headlen(skb)) to select an index for
modifying skb->data. When an AF_PACKET TX_RING sends fully non-linear
packets over an IPIP tunnel, skb_headlen(skb) evaluates to 0.

Passing 0 to get_random_u32_below() takes the variable-ceil slow path
which returns an unconstrained 32-bit random integer. Using this
unconstrained value as an offset into skb->data results in an
out-of-bounds memory access.

Fix this by verifying skb_headlen(skb) is non-zero before attempting
to corrupt the linear data area. Fully non-linear packets will silently
bypass the corruption logic.

Fixes: c865e5d99e25 ("[PKT_SCHED] netem: packet corruption option")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yucheng Lu <kanolyc@gmail.com>
---

This email was not CCed to the public mailing list previously, so I am
resending it with the mailing list included. Sorry for the inconvenience.

 net/sched/sch_netem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 5de1c932944a..da9e2f60160c 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -519,8 +519,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			goto finish_segs;
 		}
 
-		skb->data[get_random_u32_below(skb_headlen(skb))] ^=
-			1<<get_random_u32_below(8);
+		if (skb_headlen(skb))
+			skb->data[get_random_u32_below(skb_headlen(skb))] ^=
+				1 << get_random_u32_below(8);
 	}
 
 	if (unlikely(q->t_len >= sch->limit)) {
-- 
2.47.3


