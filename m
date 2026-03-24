Return-Path: <netdev+bounces-271091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOKHCAabwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:09:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C12309EF7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03F15301E994
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66493FCB1E;
	Tue, 24 Mar 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naulIDr7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2023FBEA2
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361346; cv=none; b=K8DyCTeohKIXCW2d0+N1Z+uR0cA41HrC9qfO1IF53J23RRiu6PFo/tGGSkykiCoCxxD2iLJAhdroz8kl161lDzCleSbhBzoMxQqH7hPO/yrYtISSQodCqtkuuEISE6rP8mQyPT67OdwrN6Az89AY/OD3ZlEnVA8bSg1e5XbnJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361346; c=relaxed/simple;
	bh=A5o6uolbHucdEYLXcYJ2A6R7zGGJ4jAlILqRIk16Ens=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LgiwMBfSgEge31ROCc3PV+HpsUClAmA3lYdSpngco88ea+gepmjpxAev1motQGdrUzAHJyXfiBaVI1F7lK3KJFK8NJhAJfF0y71c6EpzNlzwfEbk1xGu204/hg0Fp5eyAdoWbQvVA8iOTLIbmUwMa8zhgCmFG4dcPn9AmfbC01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naulIDr7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6611f41eebcso2067082a12.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774361344; x=1774966144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILCdDQNcTpH0TrgHQQt3mEXSmWmZQmeBlevvIb8uECI=;
        b=naulIDr7nB5o/a/TpDJE85vs43PFkOM0FACw2+BUjxSO8J4bTUNllymP9jwFxnG6Ec
         NMQAufEuj2KsEJfHAvP5KdkVlFQ6Yh0O8fMaEQOup1j/bIaeM1vwvVjeJa0SstOtAZLE
         PXZXo9pSQObT4vuM6cex38SyY8kp3amcsyxCzv57rzvtBySfsFaPwbhTbM+Y5LFpf7Kx
         7DuwM98hl1Hggi4XX205BxQ2KQy6F2gbqH695yZzXG2n6FUwtXd24yKZwLF2B5ivq8FC
         0ChBxmy2Ialt+XEdGq5ABIrgFuMoLD0rXrt1MDTrbaGBn21uLK/VsP+sGWsQ8WlGSZN+
         KiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774361344; x=1774966144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILCdDQNcTpH0TrgHQQt3mEXSmWmZQmeBlevvIb8uECI=;
        b=YLV8KsJNcNIxPeKs/XsEbjYTAcdNYNXpfwZDAjw3ZuoGzhHRdfm2JPtey6htnenjGO
         jPTQU9Mi8NIpZCnwN0s3qmOmXY3gKia4hPVfzmIpRKNygIi5FfeTjDWLnCMOFkoxK5j6
         1rZZD75YX+StIN2KK8obT5KtInNzSyrBuXXlso+94Jx6d/hH4np/jXaYDssoL0G7RxJr
         3xUB628asfjBDoUyAMMRCJSmQ3NxCsVSYqqwJoap+kwmtKbU5OFRnAPKIPF/JNWr1qui
         3wHxNtsmdEbySPF4x3NxajNPkEe94heukRGIoBuy5lopKrjT7wV7KoCCWZlqQUjnO0FG
         JBow==
X-Forwarded-Encrypted: i=1; AJvYcCXgWeLKLIfYM2iy6dj2brZINjeCl0p95U0eK33vv6gX61udCfs8wRfkMraKY+Zgg4YhgYEXaJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvc9z4rxPmsga2SIlvzMLiFV6AfW6wDYY2BsJO6vg0pPEnwPuY
	Nv8mK3388Io2y8ZIG51s/HiQQGbZ9SoYyS1AFC4zS94AItYxCaAWr6JR
X-Gm-Gg: ATEYQzy1rDcfTF+Pg1DRlQPaC3jDphxgcONRos6op1Z9U2+JOwSWZmM6oWJGLw9U5kF
	OVW5Fg9efsr/s876ILbbHFQz+VH5lS+OEE5AotWu3/bc8FehH3gpAQkmj9FnXeENbK3BCaV/PgS
	GV/QEnnUgS85RX9dVQKRQGWG0OUvwVGEq7SF02VAtLXw9w5mdy9GzHkoKb8FQ5iDgIRN6N0JL6d
	WDyxEJroCJREBDRZRZzeqKvCTOWhCmpJ8t40JKq5nTiRkHfAgjfIV+MR4kjKDZwVqd2L5nUqMEi
	HpcENDULpIVYsGQM2E5FP8oi8GER4ix2jXnL1df0qmIdaOpkGOgNKHhMuA7F+oLXxlxWFd46oNi
	Ua0POwA2xRjWChAUjfsFYahLiNNl90GJibVdn92uBxdNogsmXDLOeTGFWoeXg/AHuAt/G5u6nQu
	3hyA==
X-Received: by 2002:a05:6402:2110:b0:666:d675:e2d9 with SMTP id 4fb4d7f45d1cf-668c9c449b0mr11573060a12.23.1774361343522;
        Tue, 24 Mar 2026 07:09:03 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e22:270f::3e4:5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668cd050c4esm4731544a12.0.2026.03.24.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:09:02 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Wesley Atwell <atwellwea@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] netdevsim: fix build if SKB_EXTENSIONS=n
Date: Tue, 24 Mar 2026 22:08:56 +0800
Message-ID: <20260324140857.783-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271091-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5C12309EF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__skb_ext_put() is not declared if SKB_EXTENSIONS is not enabled, which
causes a build error:

drivers/net/netdevsim/netdev.c: In function 'nsim_forward_skb':
drivers/net/netdevsim/netdev.c:114:25: error: implicit declaration of function '__skb_ext_put'; did you mean 'skb_ext_put'? [-Werror=implicit-function-declaration]
  114 |                         __skb_ext_put(psp_ext);
      |                         ^~~~~~~~~~~~~
      |                         skb_ext_put
cc1: some warnings being treated as errors

Add a stub to fix the build.

Fixes: 7d9351435ebb ("netdevsim: drop PSP ext ref on forward failure")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 include/linux/skbuff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9cc98f850f1d..fbfa9852e82a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5106,6 +5106,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
 	return unlikely(skb->active_extensions);
 }
 #else
+static inline void __skb_ext_put(struct skb_ext *ext) {}
 static inline void skb_ext_put(struct sk_buff *skb) {}
 static inline void skb_ext_reset(struct sk_buff *skb) {}
 static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
-- 
2.43.0


