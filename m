Return-Path: <netdev+bounces-303291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H1nnC7DoQ2qwlQoAu9opvQ
	(envelope-from <netdev+bounces-303291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:02:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC0F6E6393
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mdDp5xzd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303291-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303291-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9A6F30FF1E7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AA4657CF;
	Tue, 30 Jun 2026 15:55:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE845BD60
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834912; cv=none; b=skLQzKXweUddZMyL+1eQMh49CBed6akKjnqVCYe/mkhmywYHpjZFXw59yXNqDwKC3e23tFa6ZW7dr4wiSIkD7Ug2sKuoIx3bs+P2EKt+Oj0usQXLeDzv9NTM+v7/a3hLrRsq4QoWMrKF+rFnIegJUIKydBXVbANckg5hNHAxpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834912; c=relaxed/simple;
	bh=Yw8oCznc2OJZsMWD8OS/+WNJjaNMiuOlVPoeyrSnd5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJKsOUcYBACLNBidmHijn07fW+/5pYMDrJYH6cB6Edt92UsDRjgtCZYK+7BiPqzzX2OSawG38k4gJyK5hkwS1S36Vl++fviwuRw/bgDSdbf74a3mqr1xE7T/rKc1f1BUFGW8aY4eAnoOY1KG0fJMNDfJXCUgPoBPyE32DKJs9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdDp5xzd; arc=none smtp.client-ip=209.85.167.51
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aebf120839so859774e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782834909; x=1783439709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpeuDr4E5yKEgMHqJGuQTCwVMvwRIRIBCO7YWOuYUzo=;
        b=mdDp5xzdWzoN8DZICRJYL/PeLGM7+thRjhEDFlqm7HeJsBdO+haOQ/Up1Gog+L/krF
         2fy6s9CN8S9LQDPaNDwHxiJB1TCqT24z5lZgWtBmcWw+ZXkpIA+Pjh9FMdZRYujtXv3T
         ezf6tI+zo5LVhLIxZ3WAT0YhjpsiNIhS2wAJmnXznyXZb7zjtHshGZ7BOL+P7KYU2LtM
         b7Q+x2z30xPIe6B5XuKlLxzDTrA0M+kdxSW6pabIDSteTEzZI2ByziBI5OBGI2A2R+4j
         43oRbTnKOHsuLh5dAThL+el7gvOxpkiL7tyxUujIVF1DHpWZPW50oU0ixOYLQrkVMZpf
         i6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834909; x=1783439709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpeuDr4E5yKEgMHqJGuQTCwVMvwRIRIBCO7YWOuYUzo=;
        b=Bxb9NmGjRtPS7kCTaSMLcdsXHHzINisSmiig2ezI7IzEgaI0JMxNuWbej91seedyq1
         NPTcS/uRrg01cqsv5rYtbfkPZoAqVfMMVGTKWhXGXZ+tBhDm17xMy0BgRRaLUy8xeJ6x
         fzDkh0UgZiEPE65YgSjKGYQQFySWde8ytnjSj/HxUbYhmKyG1JnxV5wNfMPfCUvPAwjk
         ToZpyinTroU6qYedQaYRJpizlQXEHVn2uO0nduTAlk47QAQyHRFmDAOBeEgY+8h7CZnv
         fcnBdBBgIc7ZbZlfRhTyAlQOw/vhRysxloUCAW/jc5lJ8TfWaY12/0cJqQf3TdX/W2HF
         cMOw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7wpfeFj5gLYRa4jGX0CYA6p5U7/SAJ8lYl6DznZNY69Kq4rW6LnXQMi5AVlRjeQO9yPLystU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXcRNbacGQKcURKJLTP1fF60TbCBph71Z6U3Egk9q3MD0mYHK
	LTjUhNLV8yPE1aIfEq9OTZY0pq0ZHewyiBSv8BLCzhVgC/lFHnN7KeMrEahBDnuh
X-Gm-Gg: AfdE7ckR4otQ6F82+2agx/Nla5NG9ms/aPK/pdOCpZm4pvWoLk0u+m3q7Gwyn/YFEDU
	ftLmQc3dVfrSmBY37bOgfGy+lVMCaeYY4GA7C2fxg4/Q78HLDepWpfOfz7V/NFH6kOyWqN6Qbf9
	L9yOhXWahhsida33yNnetag3C85Gk80U5cXc1Aje9PsjYZ+x2ulQ478RMDNatPieEHcTiMlTPpX
	Id41C3fjpv7G5ZPeb2HTw4vH5vEaB1nEgmTFIXzkc5JXr+DmilhVRjzsiUkkQCDXcnFGH1qg2VH
	hP1tp7tCJFp/aWUuqXwO/taPVJxiG6RCBa4+jjC8ARtgrfhQBgzxd4tJhV1WOdFwCY+jUvcSKO8
	bPXMB42BK9xm+6kUMvHS7gAOWRotbn/bIEIXnWXsfkFQs/RLpP10pczBn8TsA1k9YKZ/SploFRp
	2qsn6My03GAPu6EfGMZJvnn9lIkpARMTc=
X-Received: by 2002:a05:6512:405b:b0:5ae:b6cf:c745 with SMTP id 2adb3069b0e04-5aebf977c96mr795622e87.17.1782834908933;
        Tue, 30 Jun 2026 08:55:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec21794casm46702e87.10.2026.06.30.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:55:08 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: pablo@netfilter.org
Cc: fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH nf] netfilter: nft_set_rbtree: reject interval-end get for open intervals
Date: Tue, 30 Jun 2026 17:55:07 +0200
Message-Id: <20260630155507.92815-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[strlen.de,vger.kernel.org,netfilter.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303291-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mlbnkm1@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mlbnkm1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlbnkm1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DC0F6E6393

nft_rbtree_get() uses the interval endpoint selected by
nft_array_get_cmp(). For NFT_SET_ELEM_INTERVAL_END requests, the function
uses interval->to to recover struct nft_rbtree_elem.

Open-ended intervals can have a NULL end endpoint. In that case,
nft_array_get_cmp() treats the missing endpoint as b = -1, which can
still match an interval-end query. Avoid deriving an element pointer
from a NULL endpoint and report the element as not found instead.

Return -ENOENT for interval-end requests against open-ended intervals.

Fixes: 2aa34191f06f ("netfilter: nft_set_rbtree: use binary search array in get command")
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
Notes:
  A reduced userspace model confirms the comparator returns match for a
  NULL-ended interval when NFT_SET_ELEM_INTERVAL_END is set, and that
  container_of(NULL, ext) produces a garbage pointer (UBSAN fires).

  I have not reproduced an end-to-end crash through normal nft CLI usage.
  An instrumented WARN in this branch did not fire during interval-set
  tests with nft add/get/list. The patch is a defensive fix for the NULL
  endpoint case.

  Tested on 7.2-rc1 with KASAN and UBSAN enabled. Function tracing
  confirms nft_rbtree_get() is reached via nft get element. The added
  guard returns -ENOENT for a NULL interval endpoint in the instrumented
  test case.
---
 net/netfilter/nft_set_rbtree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 018bbb6df4..024a2cd3a6 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -184,10 +184,13 @@ nft_rbtree_get(const struct net *net, const struct nft_set *set,
 	if (!interval || nft_set_elem_expired(interval->from))
 		return ERR_PTR(-ENOENT);
 
-	if (flags & NFT_SET_ELEM_INTERVAL_END)
+	if (flags & NFT_SET_ELEM_INTERVAL_END) {
+		if (!interval->to)
+			return ERR_PTR(-ENOENT);
 		rbe = container_of(interval->to, struct nft_rbtree_elem, ext);
-	else
+	} else {
 		rbe = container_of(interval->from, struct nft_rbtree_elem, ext);
+	}
 
 	return &rbe->priv;
 }
-- 
2.39.5


