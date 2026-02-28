Return-Path: <netdev+bounces-262189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OE2NGNIo2mm/AQAu9opvQ
	(envelope-from <netdev+bounces-262189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:56:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7469A1C7927
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC19337C023
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAFA36DA03;
	Sat, 28 Feb 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3WBCQRE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424C536D9E9
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301439; cv=none; b=bVgWHui5pk5GRxzqSMJbOGAyXzVelU3OlOkyYB+dZfER50f/KgTte5wwWwF53ivEbKMkJU1Nz0r3RogaDtxcCShf71kYYbBRbLxqyTA5byKwtc3Zi5kfBM20Yn3piyd2bhWM+G2jEuMk4Cmo5ooNkLpEaKHbIcauppzYsPyPu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301439; c=relaxed/simple;
	bh=MK2PaSh7VH6bc4A7RvBEhSnqKfdSlGiin4gy9olAdHM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u1uyd8FP7cyKtmgbrYcZmrRKzJEP9WBEcQeWPnkvPiZT+ap9+I0IZpi38YeNbb5vcbJwDO7s2Tceh/NZI3WzqXgyhr4xnbRa08Ab0RLtiYtHV3QAt3GhEBLZEmTH64XrobuHIFrkdb+f+8MeH3OKKKkJbbUtHr+shqRMabKWpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3WBCQRE; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506b3fb32a1so540972471cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772301437; x=1772906237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hhhdMsPx+s4xGeYLLnUQAiuVE3AWdCSg2gooxlvr+cg=;
        b=v3WBCQREuBLUXCOcZylFTfDr2gZR1SZL9+FewOATFwsUBsPUZ/zT8Eh1l6uzrwkZPX
         SFo2ordzThMn3zfGWr9Xc2xGKeGJUk6MYrgWbTatQGMoj0UeNIicKPAl7Qh7fycLTbol
         nCZk1Fc/Qh0LrIYiqhKZ95RXW/Mzk75HKayjJleOG5XvpGlY0p9VuXz81mDNpMirzzzM
         uTwSROIUgRoxOFRURQVlrxgzwW2cTE/PuV6oM7V0UOoE9VyGO2wGlICJdw866LGmbMyo
         wl4o+eQqNFzdGD5K6HGdg83AgERqq466h45foap1H1gkCjNWoYLYZuw6kaS6FsUQm1YQ
         ACXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772301437; x=1772906237;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhhdMsPx+s4xGeYLLnUQAiuVE3AWdCSg2gooxlvr+cg=;
        b=VS9o9Bw2gVLGoUN9a7MR7NNhfllaYtnqzZC0VzmltKlvFNUwIxY1ymFx8MO5Kkc0y/
         PnnHl2YDlJJ+w83J6u/SrWQjUTUEDpwD4i/FchKwj9tSacR1bBAVA8604/o2USnFnZ5z
         ACT/QZmJrv/AyEbD4idv69mD+o+hUiGoiOWiF8bk66fn77bEm003JwzXgsa0kzo7cFwu
         QnjoS5NfPpjgeJdgk4mtBZU5SbCPbwjtmVPD3Hg/lRndjMwpo5htl2EmNMdpRxc9NW+U
         9joFYGHib+Yo9qyjm2kFMKUtjd5UXoSIoJrc0yMs+HFeHOHAAmLxAmdzkr4tUqdSC2JA
         0alA==
X-Forwarded-Encrypted: i=1; AJvYcCWu77iuAFgFOrnMI1gwGd/1w41NM+8pFKAOOcxnQsK3xHY/HkJEPO64/zOmx0PeE7tSS2EfJVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3YJta/TqVDSM33eZkRzeNTMepYnUe+0YovPtNPsT8tce0xHF
	f8Qwk4oFTWPimkuQiQySwHa+zwAQtNNx+v5ANZqLgl5QO6vcnmagwbjt/izqtEJgGSU8NzZJqS0
	M4bvs3wB/CJYvdw==
X-Received: from qtkn21.prod.google.com ([2002:a05:622a:11d5:b0:502:f1b1:5a64])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:313:b0:501:4cd0:a486 with SMTP id d75a77b69052e-507528a59b2mr94017661cf.54.1772301436971;
 Sat, 28 Feb 2026 09:57:16 -0800 (PST)
Date: Sat, 28 Feb 2026 17:57:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228175715.1195536-1-edumazet@google.com>
Subject: [PATCH net-next] mpls: remove test against ipv6_stub
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262189-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7469A1C7927
X-Rspamd-Action: no action

ipv6_stub is never NULL, let's remove this test.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/mpls/af_mpls.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ef9e749d5e08f4c04e97b2b2182a67329c04d343..ae85a7654b1f6d2871c29e936f582a6faa5d0656 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -640,9 +640,6 @@ static struct net_device *inet6_fib_lookup_dev(struct net *net,
 	struct dst_entry *dst;
 	struct flowi6 fl6;
 
-	if (!ipv6_stub)
-		return ERR_PTR(-EAFNOSUPPORT);
-
 	memset(&fl6, 0, sizeof(fl6));
 	memcpy(&fl6.daddr, addr, sizeof(struct in6_addr));
 	dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
-- 
2.53.0.473.g4a7958ca14-goog


