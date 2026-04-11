Return-Path: <netdev+bounces-277715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLDoHsWZ2mkC4QgAu9opvQ
	(envelope-from <netdev+bounces-277715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 20:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB83E1603
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 20:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 560D3305A41B
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3C3148A3;
	Sat, 11 Apr 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYeH1gIm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C03B9608
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775933847; cv=none; b=ZoUuhlnW2Mp1V9nQyYNrEHUKSYGbsu6iyVNJcVHtOAaik5DE5oRcmmtQHft6G7HsyizHyIktcXGgM9z8KbJ1Y9cC2NsWGboE1iRYF+Kt+xoTu0USXF0VO7IsEkBa7vu/9szmB8TF6dAf9SEbcVEOC+hwNnwZtMTAQX6O+puEIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775933847; c=relaxed/simple;
	bh=s8DvPKpa7mA+qHyXVl0NHzUIBYxwCvFo6gHuWEJk5ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thcH6ocWccFzakWTmoFz4OiQDNKAp6JuFALBEsVBDlF9MNMClQhXrbZYTyhYtOV9JLR/DJNT94k21L2yotkhMdmT5iNOZHIpf2YxTjjuBW7Dyvm5VxvYrnAK7tDZ3Iah4ihNG3vsZjhtYJBDlzQcLZ1f+1ZupsvE/ACJu5izc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYeH1gIm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so29582455e9.1
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775933845; x=1776538645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=asmRMjtAdynfNNM/fvaGPOkC+0FMwoOWdK0OJmKnM5g=;
        b=hYeH1gImvN7NJBo9KDzRBfBCU34VMqRUt3zcgO3EWYAsUqIY5OTjRLykxui8j5YE+L
         XOfSgf5Ktids1LRZsNLletkNN9fgWzWM/0YSYo/l5NiRTt6XKsttoOnDhLty1t4+Bw7z
         /pSrJZ1CAMvWigIzzRCz6oBAPrxKYkN/4Ml7zKuVJGLsl3kmUWJy9lX/xJWy28H5irfm
         IQUUXCSxLLeWFulg0mLsBmgj5JwH1PxeAAObMroxcbsQHLFDn5/cf3wUC5PlZEVxXo6w
         SCffgYGNqdPVFQGYyn4nd9Woq3OiPmOxpFv/4EL5o6aVzXJZosgZ/1KY1CCl8L3XLk21
         py9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775933845; x=1776538645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asmRMjtAdynfNNM/fvaGPOkC+0FMwoOWdK0OJmKnM5g=;
        b=sG9fWo60oCpEHogewGHYP537/yW19V+uNqFZwdCRpeMeMJO6zgbwnJrRGZ8XaxJjwL
         WCYH6h0rQ5n3Jfggl/op+qWBixBYbwp5a5mzd6vlWgUGFN17ywCdVPhzZCCiDJTveKby
         6WGs47rSKSeOKP6458BBcwkmImGq7VvjrIOn6T3V//f/hHMT9GYFhBz8aHfllse1mx+m
         VYeyQOlLYCsYTeapTqfUISrz1TBcccumU4m7tNrpghwUYjB7n0anzE4EyTv19IUltDTm
         obgP5PiYl5qLdCbSaMziulKnDp5qVH9d7T8xDlbkURn9ngdxcV71efqJingsnabYHdag
         C7EA==
X-Forwarded-Encrypted: i=1; AJvYcCWKVjAGK9x87U7UHteq2YSXgjBDVmU6rowsFtCb/HaIoNMNOutevBxBg8p1p5L4rhTuL3Ff+1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97OUcMsBlk0Vt6kR1Btuy26Ztj1i50iZ46VyW0lII0A+8Qici
	v7VE4Galm/qpnFtDj7V3Jm5saHI4vZT03gB/zZrDCE5mfkwX8ICIbnFo
X-Gm-Gg: AeBDieuOWA8xCS1wvWFBvxF6J6GYjL93HcUgHxn1jYhq6+/eiGkYEXMBqzi4rpMNQ7U
	b5SrZw/9vycTp7as1qFE3iGLRyn4P4qIQjJ/egy1PU0C0FmXVWtZVMDKTcLF0g9/Hah1v9enlmV
	IbVrNZsclzxTJA9vHKJ3VCdOrRtcLi/UoUa/5QBPLw6lCzgI1oP8bbarcKX8Zyu1gYh/DYCxJut
	TLg/710BRg4pRqdzFqVr+mgIsDOxVoMw2jvl+1fN/2BR79mWRg3lsNN+Z0fA3bJ5JkA6jin3UDx
	bOPVY5imBuCDbtEntElB1ZeWGiUx6WC6mLsCsP2MXE2NZuymuiDJIxZLocgtLXRECjYk5TYphFQ
	QRyh9fj+a+Dzg86HFvL5gUcvCcjRZtWh/HQ9g097a9dyffvPtSGKetihkcb7Xt5Pk9c5zw/NhNN
	K95Zj0cMk+DwCeBe4pZCnZk5i1MousIXreTwHzEIYlo/B5IytlyFa6TnqXmwCqWJODSGHBCyFsU
	mbWhlBFC9sN
X-Received: by 2002:a05:600c:350c:b0:488:9661:2570 with SMTP id 5b1f17b1804b1-488d67ce8c2mr100910025e9.8.1775933844696;
        Sat, 11 Apr 2026 11:57:24 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d703c1sm52012375e9.3.2026.04.11.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 11:57:24 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: nfnl_cthelper: apply per-class values when updating policies
Date: Sat, 11 Apr 2026 19:57:21 +0100
Message-ID: <20260411185721.234936-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[strlen.de,nwl.cc,netfilter.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-277715-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8CB83E1603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a userspace conntrack helper with multiple expectation classes is
updated via nfnetlink, every class ends up with the first class's
max_expected and timeout values.

nfnl_cthelper_update_policy_all() validates each new policy into the
corresponding slot of the temporary new_policy array, but the second
loop that commits the values into the live helper dereferences
new_policy as a pointer instead of indexing it, so every iteration
reads new_policy[0] regardless of i.  An update that changes per-class
values is silently collapsed onto class 0's values with no error
returned to userspace.

Index the temporary array by i in the commit loop so each class gets
its own validated values.

Fixes: 2c422257550f ("netfilter: nfnl_cthelper: fix runtime expectation policy updates")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/netfilter/nfnetlink_cthelper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index 0d16ad82d70c..34af6840803e 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -346,8 +346,8 @@ static int nfnl_cthelper_update_policy_all(struct nlattr *tb[],
 	for (i = 0; i < helper->expect_class_max + 1; i++) {
 		policy = (struct nf_conntrack_expect_policy *)
 				&helper->expect_policy[i];
-		policy->max_expected = new_policy->max_expected;
-		policy->timeout	= new_policy->timeout;
+		policy->max_expected = new_policy[i].max_expected;
+		policy->timeout	= new_policy[i].timeout;
 	}
 
 err:
-- 
2.53.0


