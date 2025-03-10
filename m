Return-Path: <netdev+bounces-173453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D0A58F42
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A93B7A23B5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D48221F13;
	Mon, 10 Mar 2025 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjvqmBpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EA22371B
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598207; cv=none; b=RgzvjiXeZGVQDnU67ZWwgg0bO+wddE3/CF+/dK1rG0o+sfQ1k59HlDlKbpVJ5dBw35or/27/iJEMRRk6qzHsUhgfK1MTSq4T42dZlnp0t8i9NTr+J3IK1v85irTvKOTcZ0BvQTU3aPkrtNKEmTW/TiYK9Z5D/DdGHNuhXHIklZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598207; c=relaxed/simple;
	bh=/CoDczrC/PnmqGe073cRpY/sT71Q/uwFa7MgT+GIBno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RprEjJHWHBk1ZmSf9Ma1J2BUbHlB4JAFyxzk8jkNBv7WQ/Mguq+1JWdQOP1T5flbDdg1WsoX8a2dfKYfNfFdeUrD/PFdAYwYgHzbHZkr6GhrHdsC1FTyx1WM2hPKKGKHilN6iD9Y6t2IxR531GSyOOdUTCX9rjQhvEUTWzN3HPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjvqmBpy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff5f3be6e6so6897861a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741598206; x=1742203006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxFKpSUTYqg1Rc0MBNSslC0niEyRIRznyg/YVs/pgOQ=;
        b=JjvqmBpyGyEsk4Pyyd3mevY1a+VyHrJ3+Z6mX06eVCiXcU+QuRGEROcIUpiiA1eavU
         d6AblO8AFTJG4QbdUH6Uq2ZFA5kY/Do1Eah0SXBn0zo/JD/wUNdkG4Z7MzuYbmXT85PX
         uIHxADfctlq+c6+YwZdBQmNEyxwmGtTI5rVCgLy4tzViM+grt3zmqblYiJp8Fk+SMjoo
         6b19uVT0mzYtPhg/fHD5OUJYKHEM9j6VNpVbkhvxU++Osy7xbK64Axr4eJU4WlAeAjya
         nrA5aR5OPf0eRGgIc56AEUMGA9h2nkB9X2S9PimqKr9U/iwY5s51pzHNasYP5XGCPeND
         gbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598206; x=1742203006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxFKpSUTYqg1Rc0MBNSslC0niEyRIRznyg/YVs/pgOQ=;
        b=PFTMQ0SQTNc8ZL7tixfSXnwDRLjxx/yxb8bNyGWzNSutbp21dPLCzg1WQ5GH2NUujq
         T5zd2eMnUYDSMZ2bMJ6F8BKizAalj6oKu/QMF8t35e5H4ZEFUlsWK80lqia9K3r5z12b
         0nJ9PWNpsYwVqyUsuHZERNcE3rVSzlkrfF6AYBfZAWZUDI6tklACaC2VObctQGluYy3B
         PbCjwtw9ImsRZrhZiCWSS0eo7hWf6/b19jS29+jybqY9jOem6UfTTbzG7ec8JfxMpmMj
         S6MDn9DFRdeRAEStZ9cwq7QIPWkeiJE9SFvD3cGdOmlTitG7jQdra4Mry+jz3CX/zYz0
         zk3g==
X-Gm-Message-State: AOJu0YzkQl32BhB4RwkDGokeyct5VlZXlM1P05GpY7G2mBLovYwM7TNe
	eWWNOVk/Y35ciTaj3KoU25p9psesSOcTESPBRbeE7v+OiIeNe3QTJYFbMHRBkzcV1zqfdx5ik3Z
	sYnhSU2rWnjWKJKy2ZCr736+MFdxMwMlF4/C1HrwdcXEHp0wwiyUZtL0Q9tzekz9UmB5kH0dU+m
	P6j6JoE0KRrJ5vJnKh/Sw1LTvtQGO1gYgH6SSprdDEYwfVnhaXxjER7vN79Z15q4Rbbc/ihQ==
X-Google-Smtp-Source: AGHT+IFY/g8nxsG5hvg+E43eCTd5iqNagsd6D8DhlLjOjXOWcI+MuPu6ii8JyrQ97rZX2/ghjOPeY7hmRbZu1QEhc6+P
X-Received: from pjj12.prod.google.com ([2002:a17:90b:554c:b0:2ea:5be5:da6])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dce:b0:2ff:62f3:5b19 with SMTP id 98e67ed59e1d1-2ff7ce6f0bcmr20385113a91.13.1741598205676;
 Mon, 10 Mar 2025 02:16:45 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:16:20 +0000
In-Reply-To: <20250310091620.2706700-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310091620.2706700-1-chiachangwang@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310091620.2706700-3-chiachangwang@google.com>
Subject: [PATCH ipsec-next v4 2/2] xfrm: Refactor migration setup during the
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
 net/xfrm/xfrm_state.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9cd707362767..0365daedea32 100644
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
@@ -2058,6 +2059,12 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 			goto error;
 	}

+	if (m) {
+		x->props.family = m->new_family;
+		memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
+		memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
+	}
+
 	return x;

  error:
@@ -2127,18 +2134,13 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
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
2.49.0.rc0.332.g42c0ae87b1-goog


