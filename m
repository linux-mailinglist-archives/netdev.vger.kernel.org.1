Return-Path: <netdev+bounces-160264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0987A1912A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B5E3A00CE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F22116E6;
	Wed, 22 Jan 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZK9UoVp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BD212B02
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547803; cv=none; b=DulE3uzTdV74VAXcrhHDNl356gg0GWWeoF8bQqYo6/xlShBTdFD3LAPHuXEBvrgSRDQ3mIBpCCLDoxuC3fYhDSLy99H/CVWn7e9I03oNln//yFE/7viAhB/DgkCcfiY1Vm+oyCcOHZWrvbyzXFXinoTRBM8JYmrlWtOfMG9HBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547803; c=relaxed/simple;
	bh=af+kttG6++jnXIgU0u6od/TPSeNYDwF7HPbdBSxFJJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fIKgaAj9fb7t9q76FwP5q1TMBppBXW6Nwrwsovgbpi0h9vdZa8WP0bVqn3jIN6L6HmrpHPLbb5e243ooQL3earOpL27KZ882yLrstII5ebneX7I4vasbieopTC93Fnv0VCAGJgggTj0B8xwBG+UkNeD4m2WekdHuYcLkHTg1KB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZK9UoVp+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216717543b7so64558595ad.0
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 04:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737547801; x=1738152601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=00Q4sj2EncvDueDdhm02SyfQwd+04qaoe7JUbyCCFg4=;
        b=ZK9UoVp+wBRUOSjVnkWK3a1qJ39d3u6HBXLdy3Vbpe+2UJl4/h3e0RgpfSLifGvByT
         ntEPiPVI8YkbmzAiQtzhvYABGXEXDKvSjBs1Gd+C73N7iJFbUZIFc2jCvuLazb7SP0D8
         6MA2XUQ7QFyyYwpPSAGoSK4kOME7SIn0LYdpH40RQcqrZoi3v0uFpo0eGG0IjcAdsuGs
         bzGzhVDHtPRfjywzjalZn+yWl+gpi9PpddF1eMfzLoHfOwRmFlLZJpVRA2jpSMiwlCVG
         YwzlAj1w5Zmy7jEynm5JBMGIiHsYvqVRwolL9EKyRsuVQXjHaOc4YHM0wxGa+7T82kI/
         JaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547801; x=1738152601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00Q4sj2EncvDueDdhm02SyfQwd+04qaoe7JUbyCCFg4=;
        b=g9BDL2O80S9FgLbn4z2lzRjWGRgMuPduU/WPu4ppDRsjfQgn2avlO1bUFYDFEfiz4l
         BDMoUJMHBuEzRQdnKguuEC1W+XmMEfyzhRlzfJ7KdpaNfLtGcevbXVn9lhTcbW2O1JGS
         CoDaNQKdPnoMO6cgGaTDF7ZL1PvAbCxQcjCqjExlb2yAE7/6PxxEMqx5d6R0q0uQT9ss
         qOqSzbfsu0TMEy19VnaxNPRhymeXqX7hM5aDjolFXGpww30QAUPEwBLjfUZAFsUEFLxS
         IR8lgUChcc5H7kMOeXRg/JfDfd+AEScb3ARotx3HFI1yDvOWeI8Oe5mfSTGG07E4RXYJ
         pTlQ==
X-Gm-Message-State: AOJu0YzpHSQqPr0Ra8qMDdJmphGdoxYQbBscawJCxwatlgkROfePuOIr
	oiJe5O5HkPlsNY7kKPI1SObOxhSxIHa5J1SgqABWrr3ZXWj76bydpF72SGpiKyV1bDPd7li8mlZ
	wTCsQgtLopVksF74vv9GC3jW5UF+0YFaKPZ5La0zRQzwAWkc5m7RGgC5QT7CBPE2JLK0PYRxYXI
	aMW6xgo3qf0QKzFx9Q6fyKe8PkYqlpsqgHP8dbA8qInO2zCbXTU/3u8+YL8Oxa18xoUo4VqQ==
X-Google-Smtp-Source: AGHT+IHA+bbcqeOXwARX8ykyjCjUEfkXYRI2mAN7mrQBd6QTCx6Ks7eRThGBXJYN9SzBQhMUoCgib+HvH74mEQH5ju1/
X-Received: from plgp10.prod.google.com ([2002:a17:902:ebca:b0:21a:82c7:f2b7])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e802:b0:212:615f:c1 with SMTP id d9443c01a7336-21c3540a0admr349298275ad.14.1737547801232;
 Wed, 22 Jan 2025 04:10:01 -0800 (PST)
Date: Wed, 22 Jan 2025 12:09:40 +0000
In-Reply-To: <20250122120941.2634198-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122120941.2634198-1-chiachangwang@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250122120941.2634198-2-chiachangwang@google.com>
Subject: [PATCH ipsec v1 1/2] xfrm: Update offload configuration during SA updates
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: yumike@google.com, stanleyjhu@google.com, chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"

The offload setting is set to HW when the ipsec session is
initialized but cannot be changed until the session is torn
down. The session administrator should be able to update
the SA via netlink message.

This patch ensures that when a SA is updated, the associated
offload configuration is also updated. This is necessary to
maintain consistency between the SA and the offload device,
especially when the device is configured for IPSec offload.

Any offload changes to the SA are reflected in the kernel
and offload device.

Test: Enable both in/out crypto offload, and verify with
      Android device on WiFi/cellular network, including
      1. WiFi + crypto offload -> WiFi + no offload
      2. WiFi + no offload -> WiFi + crypto offload
      3. Cellular + crypto offload -> Cellular + no offload
      4. Cellular + no offload -> Cellular + crypto offload
Signed-off-by: Chiachang Wang <chiachangwang@google.com>
---
 net/xfrm/xfrm_state.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 67ca7ac955a3..46d75980eb2e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2047,7 +2047,8 @@ int xfrm_state_update(struct xfrm_state *x)
 	int err;
 	int use_spi = xfrm_id_proto_match(x->id.proto, IPSEC_PROTO_ANY);
 	struct net *net = xs_net(x);
-
+	struct xfrm_dev_offload *xso;
+	struct net_device *old_dev;
 	to_put = NULL;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -2124,7 +2125,28 @@ int xfrm_state_update(struct xfrm_state *x)
 			__xfrm_state_bump_genids(x1);
 			spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 		}
+#ifdef CONFIG_XFRM_OFFLOAD
+	x1->type_offload = x->type_offload;
+
+	if (memcmp(&x1->xso, &x->xso, sizeof(x1->xso))) {
+		old_dev = x1->xso.dev;
+		memcpy(&x1->xso, &x->xso, sizeof(x1->xso));
+
+		if (old_dev)
+			old_dev->xfrmdev_ops->xdo_dev_state_delete(x1);
+
+		if (x1->xso.dev) {
+			xso = &x1->xso;
+			netdev_hold(xso->dev, &xso->dev_tracker, GFP_ATOMIC);
+			err = xso->dev->xfrmdev_ops->xdo_dev_state_add(x1, NULL);
 
+			if (err) {
+				netdev_put(xso->dev, &xso->dev_tracker);
+				goto fail;
+			}
+		}
+	}
+#endif
 		err = 0;
 		x->km.state = XFRM_STATE_DEAD;
 		__xfrm_state_put(x);
-- 
2.48.1.262.g85cc9f2d1e-goog


