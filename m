Return-Path: <netdev+bounces-301633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XafPHX7LO2r4dAgAu9opvQ
	(envelope-from <netdev+bounces-301633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:20:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD12B6BE0C1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:20:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V2raHcm4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301633-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301633-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A42302DF55
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E61389E1A;
	Wed, 24 Jun 2026 12:16:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8A1925BC
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:16:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303387; cv=none; b=ZvXM+oZPQYTkeAYttUijOfh5XrFZz64TIRA05fCA4HlFQgH1WOaXfyHcvnFS2pZeWWat9Kx5dkIo5LvsrVKadtBpfJXCJk+JbHjAyqtbnt1z2kXIyM3aGDNp6x+oDNJ7eym2TqZ+P0GRhCBt5hKuJf2XMM03Nlg5JSwPvoyWc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303387; c=relaxed/simple;
	bh=8mTZuUoiyhNRN3gTKiUmzENom/VFrrl5XjY2DI/t9pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4hYh4oMaGHfbt55B5scGcPeIg9vJbkL9Eu+AOeah45qiuIUjijXrRmwu0i1Q4I+9DVxadQBg82lVU4I57KP2Z3nSqeAbS/C5oR0NLJXQrLfatpRgzNcoQ6N2eJSMnLm5UXLcv1wCvIHiBIAYhpuP5LIgwZF5KAPlw86D4eHIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2raHcm4; arc=none smtp.client-ip=209.85.208.179
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-396669329fbso16809321fa.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303383; x=1782908183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWN+ktVTYkpSQqdNFGaR2EYDD+puHcc21cFbcKJgBfs=;
        b=V2raHcm4aq59i6qi0YfjMaqw8TXp1JbHv1JaNVBJ1C0bXP7+3dHBVRQqMBY0KHnvMm
         AkG+HFYcLqUUWHwx6Ch0UQEWHrMch9cq/7r1ANOBfHHgpPQPLZSa7kQgD+XCS8rW2QFZ
         jO1H2gIPQwJmogZ1qKqrSIX9k/VrTj8zNA5ll/vaw8fEoYF1VoG129P0Ayq1mYKXdk3+
         pXm948Uir2MbhKX1PCUySlzsLAQBHYuytszwn91cmxfRX0tKzwy3Irt0hHiPmyjbwVaT
         XI9Jt/Rm1oyumHGhgOCN8c1FBXaOvtm4XIWMGeJPw9TJUD5Nmrn0d5jO6QJQi/50LnSD
         8ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303383; x=1782908183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWN+ktVTYkpSQqdNFGaR2EYDD+puHcc21cFbcKJgBfs=;
        b=aHSd2JqTp6biVZ8e6zpBvowg7693GEoxaZmf0JS9rXI7kShK/FOjUv5IBuqckGTKXt
         HMCS3FUVpSlK8soSIYk5md1rtcEAlLcC4O1ZzFr0xEkZzB+hkApZXWYEzMSHjBBD5Jjm
         VuKudc8pO50yOKU0hO3tflKM4dmLrzbBYO4HiuFYQygzWE5+nIMPJTwsT3WLQkyfi+I+
         Z2EsVRIIluDEaKZQ3MEHyyNztwPsRJBKl31GQTjbsK0zePOUjBIMlQNz0qW1LiHbReKS
         /E8C/1D4sKXKq2sD5i89GjHPhbCYSDYH8PFkmZeAzutz0ZrOcbDFpGTgEfvbFWkpNOOz
         sMcg==
X-Forwarded-Encrypted: i=1; AHgh+RpEe8X6HRnDvbkmfy5BMpTuhfBSNeGhMMZDyiZMaiproVI0sf1+esdTvocnrvBNacrUhlO1zhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+roiSkHtE/RJc8MlUl87vLmVywULmTRbruHYqm9m9gP9Dsb7
	hg+p8Ya4rYDlxdn3xBe6+knOHtj9U3pz1G8YXUCzhKAf9AbpwDrHzjZY
X-Gm-Gg: AfdE7cmb9crLOinO8XMKgxL9S+UyocJou1w2Ks3jvQnhLThqVo8QJ2BLzmRsohco39p
	/YtlEyrTSJ1t0vBSjH0rbISufQdq2AmDddGF4oJIYfV5hPphzTLL1L5Ah3k1o5ECnVhEmAdPlFN
	xvnpydCylAYawGvYRYxvp+mI834wxYXkB6AI4Rb4CNk6HgIlH3YO4SyaCfPxLDN3Dse0e/3c9s/
	0vkm3blyyAtWROdOyTelH6N4mQqCAMx/XoHZMW/hTTvOslg9wonGzdDDPdQ2pJfbZqLhBeufdz/
	xy1E26vW7mpno4kQRgu23QeVwQOWRPOrHZyAO+aaw7GkAuYJ9jz8WJAcF5Lrt+X89yqIZoobcC3
	TQSZxfBl0yL52a7TIeTMuQtmvJ1IOK9Cn7yxZVUh9/7JJkl7eeYQk9QN7emZAqOMH73GrYpyh12
	ZO+HZ0t8fYOl7stXIEx3Py8pDv9l+j
X-Received: by 2002:a2e:a913:0:b0:38e:8357:c5ae with SMTP id 38308e7fff4ca-39ac25ddbedmr400571fa.9.1782303382591;
        Wed, 24 Jun 2026 05:16:22 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999b156f23sm33089191fa.27.2026.06.24.05.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:16:22 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jann Horn <jannh@google.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: [PATCH 5.15/6.1/6.6] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Wed, 24 Jun 2026 15:16:48 +0000
Message-ID: <20260624151651.38894-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	DATE_IN_FUTURE(4.00)[2];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301633-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,google.com,oracle.com,vger.kernel.org,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:jannh@google.com,m:lee@kernel.org,m:sashal@kernel.org,m:rao.shoaib@oracle.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:wangjiexun2025@gmail.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD12B6BE0C1

From: Jiexun Wang <wangjiexun2025@gmail.com>

commit d119775f2bad827edc28071c061fdd4a91f889a5 upstream.

SIOCATMARK reports whether the receive queue is at the urgent mark for
MSG_OOB.

In AF_UNIX, MSG_OOB is supported only for SOCK_STREAM sockets.
SOCK_DGRAM and SOCK_SEQPACKET reject MSG_OOB in sendmsg() and recvmsg(),
so they should not support SIOCATMARK either.

Return -EOPNOTSUPP for non-stream sockets before checking the receive
queue.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260506140825.2987635-1-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-52928
 net/unix/af_unix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 32892a40d139..8bd78cad69e7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3139,6 +3139,9 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			struct sk_buff *skb;
 			int answ = 0;
 
+			if (sk->sk_type != SOCK_STREAM)
+				return -EOPNOTSUPP;
+
 			skb = skb_peek(&sk->sk_receive_queue);
 			if (skb && skb == READ_ONCE(unix_sk(sk)->oob_skb))
 				answ = 1;
-- 
2.43.0


