Return-Path: <netdev+bounces-174438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958CA5E9FB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 03:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF42179160
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462032EB10;
	Thu, 13 Mar 2025 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lbqsf1+E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D32E3395
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741833463; cv=none; b=HT9NsMYneQwXupasSmOlFGcHk2KmxcmvPw2EFxobLKrsce1x4NG5e6hpKpHBhUMh2DkgGOVmtCHaHj5yLg/oJqNf21IufIamm3Lp3yWYa7CRFBsiPAUEvfLTaJhgve6kXrivHCArr28/TbWAQtPlcuW6yrq6979oBdqHbsnvEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741833463; c=relaxed/simple;
	bh=3DqA+rfRERrfGMSoFsNo3CtH1vhqsbC3qeGM5TZLRmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ffd3ExDulwLGO3Rzzn6hWHfTHaP7Zm5yzpQTgo80lpPxWpzd5MKbLyjL1nz7d82ENpagE8PONo1xxeRimokV+MfeRdj7OcRMQefXHbvYaFkHIewPtJ6lPd58QbGBZ4m6aQOLLnE1gWj4Mn/fa/PJ75A2iU9xp3uzGoEwZHYriQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lbqsf1+E; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso904713a91.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741833461; x=1742438261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQXrajeeHkqtCHLrJxECf+gUcFfYhAaWos50VhqDTvk=;
        b=Lbqsf1+EiHUQbvpj/e3JAXiKM7EbywXWFrJi7+yYVBOkSs9gbKtKkbstIiCK/btICA
         Mh6Lx2S+xCZQt4kimhf+I0QKdgd/mui6Rl1uU9mqLW91m06V46t7eyV8OhORh7ECFDzL
         nq5ev7lHMx9h6AzGV8jnb/J4wqsOU+n+kXQ1+h2vEm9xDG6lZTlfFwIYsQHlazjZuhUH
         wQ73RePJOe9SrC+lNgrhQaoy7J7Z53QOa/NJ1Vdkx8cPs4lSJ2wqKAFe1nJdKkICG1v3
         DKQFyUMLtE2sAEI4Lk91A2CvQMiHd2Gi0tUe3SkA7bvGZqQIp0rdJy1y5UDxkWsBW6uQ
         YTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741833461; x=1742438261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQXrajeeHkqtCHLrJxECf+gUcFfYhAaWos50VhqDTvk=;
        b=RjFno5CoxLd+Ra2K0S3rP7zSBvAaag7OKVq1ITPddSm4oMNfvuSuORtWubTO46CAXJ
         QcN9x79CfDaR+K0hwx/bha93LtUGxh+RYTvkH0FfC09C83TKQCepXsE8HaC+Y7LdYUB+
         VEcepcDXqg9g/J9Cw0qEB5+LYjdtXmV2et548ErCVEmUOtGsaY9Y1iJ9nbUan+vUguPA
         iZeeucsmWqXfSZI7K7QJ9lW7c9qY2h3bQI1LiuBlyeH3Dgi1b7UvJ3c5Pp7TyyQ6I05o
         7cmybRuMJpC08ZmfB1a+M1FZ+KW34xDk6KKRvCq3T5wWQ6HYAsnpjW0Q3PeQWKdww9HQ
         Cqsw==
X-Gm-Message-State: AOJu0Ywvs3uPidKkhMAGXpNROI917xLAPyrflvInjH0+sqpXMvrDXZFA
	ZbyLVv2Eshw48I7WEdQdDrAYPvtDFlHRHQ36ikZWYhJJigGnbgOVn+dAad5JaD8n+gAgmXbY9pi
	/yi8whgtR7YXj70iX71ig87wkmE33+kIrZzZj00QiicTIi+A8NtsTOhsrQZGtw1KV3LsdAa7Iiz
	jB9JY8nDNlIjXoq2y9tYZHNinWX6KNyU8tAQzgEcJUX+9+laIqFWn/URg20Dq2QHtR99L38w==
X-Google-Smtp-Source: AGHT+IF2Gsn4pOBYrr9NSIhJdeCuZCn+SoRCKws6BvPPZmAYFJF/YPpZdTP3mBxPaZodR+9xBKCeUa1XtbwX9bF+KQS5
X-Received: from pfbhc23.prod.google.com ([2002:a05:6a00:6517:b0:736:3cd5:ba36])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6b0f:b0:1f5:719e:115c with SMTP id adf61e73a8af0-1f5719e1397mr23324602637.26.1741833460725;
 Wed, 12 Mar 2025 19:37:40 -0700 (PDT)
Date: Thu, 13 Mar 2025 02:36:41 +0000
In-Reply-To: <20250313023641.1007052-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313023641.1007052-1-chiachangwang@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313023641.1007052-3-chiachangwang@google.com>
Subject: [PATCH ipsec-next v5 2/2] xfrm: Refactor migration setup during the
 cloning process
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: chiachangwang@google.com, stanleyjhu@google.com, yumike@google.com
Content-Type: text/plain; charset="UTF-8"

Previously, migration related setup, such as updating family,
destination address, and source address, was performed after
the clone was created in `xfrm_state_migrate`. This change
moves this setup into the cloning function itself, improving
code locality and reducing redundancy.

The `xfrm_state_clone_and_setup` function now conditionally
applies the migration parameters from struct xfrm_migrate
if it is provided. This allows the function to be used both
for simple cloning and for cloning with migration setup.

Test: Tested with kernel test in the Android tree located
      in https://android.googlesource.com/kernel/tests/
      The xfrm_tunnel_test.py under the tests folder in
      particular.
Signed-off-by: Chiachang Wang <chiachangwang@google.com>
---
v4 -> v5:
 - Remove redundant xfrm_migrate pointer validation in the
   xfrm_state_clone_and_setup() method
---
 net/xfrm/xfrm_state.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9cd707362767..88d4b08f52a4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1958,8 +1958,9 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 	return 0;
 }

-static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
-					   struct xfrm_encap_tmpl *encap)
+static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
+					   struct xfrm_encap_tmpl *encap,
+					   struct xfrm_migrate *m)
 {
 	struct net *net = xs_net(orig);
 	struct xfrm_state *x = xfrm_state_alloc(net);
@@ -2058,6 +2059,11 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 			goto error;
 	}

+
+	x->props.family = m->new_family;
+	memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
+	memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
+
 	return x;

  error:
@@ -2127,18 +2133,13 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 {
 	struct xfrm_state *xc;

-	xc = xfrm_state_clone(x, encap);
+	xc = xfrm_state_clone_and_setup(x, encap, m);
 	if (!xc)
 		return NULL;

-	xc->props.family = m->new_family;
-
 	if (xfrm_init_state(xc) < 0)
 		goto error;

-	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
-	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
-
 	/* configure the hardware if offload is requested */
 	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
 		goto error;
--
2.49.0.rc1.451.g8f38331e32-goog


