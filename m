Return-Path: <netdev+bounces-214784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A38B2B341
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 23:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CCD4E3C9E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0577B21FF3F;
	Mon, 18 Aug 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROMvMPeP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22B146585
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551583; cv=none; b=rv/ERD7fEDNQp4LDkn5j6aUv5mGmubOQFb4U0xXYXiInpFaTnyyVEOBU1PqZ6beD9OJhpQA346vN8mysnJaD4oJvKpYZwP4IZExqyhvoDSIV7t/lEhWJ2rRKplNmOnkfpxuSiTICSXY7OxFlaWT88jQOv3acKes43EAvXDIYOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551583; c=relaxed/simple;
	bh=/nLLEfT3tyChrFQRlc03qPTRviAr/bcwwzJUDrBrorw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QyDsyY/c63LlOmx++rmvR6E++xFkFPvnUXxh0bauwT9jpksbmCXlPGrLGMBypVdpEM/AR2XY0JKYpQ/lB4ngQ8XcKKhlw9FFCmgFVwaEv87Xfx3awSyT24dwL18tbQQwZsm2t3vL5wzFfTYSoLBIFrjAsNbSMf0+8JKzm60THM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ROMvMPeP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323267c0292so4210910a91.1
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755551582; x=1756156382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pe3bb3+hhZ0qSMkMqidp1VPBqJ/V/v1tvwOji8BfcIo=;
        b=ROMvMPePSv9d0FKCqkU8vheMZITLBjP2ZDjgfCE8wN6P7+dzXowLJDB8zhpZvZGIdj
         veB8eSGLdzPpinWzVigxvdo2q2HWmaxDLeI5F3OzC4agITAYMVnfEwYAKHC66qJUepyz
         pXiZPu5p7r6xhflxgcC+1z2xnHfrqFRDIIjKi4dGqvmFE0cURqYNrpEG/IbYfIqXXKcQ
         QN0ToJt19fBXyxX8+irPARMWwCG7X6B2ZDBIWk+jgj6EeEv7zS0ErLjoeL+mUoTAKZzC
         FiLPX44+rHFLe0ov8rXXIJWLm4LXnOpcpog4ycP1TEiAARzzfwzaI+cDGaQdJcONxOIL
         ttOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755551582; x=1756156382;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pe3bb3+hhZ0qSMkMqidp1VPBqJ/V/v1tvwOji8BfcIo=;
        b=j9LXV4HNj1zi9Zy01MWjU5jwFcu5WTibiYR7y3HN6walmAKme+5IsWKWzpBUW4xsaz
         AZq8ol6cD2KdzV53AZ3I19XyhpRC/5tNxzlj8vMJbsXTimkJAAdkGazTYzMgDveolmx0
         hBC3twCPF1/srZ0dnF1spfBEs1d3eudhviqVE1sk2UcnUUeHxFz0adBPebroHPKysxk+
         TSbyol3upC5RHBaiRsSj2/7p3hZAEreI1+DRW7MVdouY8ziz3zYpLq0uMYR8OtBVDIp0
         Kq9gImUMWxZuEHhaAfXDXCprN9/zUzCa6ibCzz0seEg1lmkQzEZLU/0Z0HTXBLkCrF09
         VQwg==
X-Gm-Message-State: AOJu0YzW+Er650zbBmR61FF8ASzYsC6RFD1asus2fEG+coPH9sDKdDq7
	2JcEUZIwKmnrBR/eM/5qb9Mzh0vqV2vGOBBNxLJ8wFn+6I56Jxe/tpvCX8i+twgikvxIey3Swi4
	qOZEem6ebSIM+bHu3UUv5DsXahtJx79OrAO8Nc4ixCBYB3QnU13TnZgSeNSEQdnG9Zs//FNMOQY
	GyoHVZzHA88cm+9DHUJy2YAAGXcrBzC0j2EyPsRofVSj7wwkQ=
X-Google-Smtp-Source: AGHT+IHkbraGzSqtrSSFL6J4QJNzq23hLmxsFJDCgRsrsaB7kHdW24jWyILQimhKFM/L4GVl9zPiWLvioSVGaQ==
X-Received: from pjf14.prod.google.com ([2002:a17:90b:3f0e:b0:31c:38fb:2958])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17cc:b0:31f:253e:d34f with SMTP id 98e67ed59e1d1-32476b02016mr419311a91.19.1755551581701;
 Mon, 18 Aug 2025 14:13:01 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:12:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818211245.1156919-1-jeroendb@google.com>
Subject: [PATCH net] gve: prevent ethtool ops after shutdown
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Jordan Rhee <jordanrhee@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jordan Rhee <jordanrhee@google.com>

A crash can occur if an ethtool operation is invoked
after shutdown() is called.

shutdown() is invoked during system shutdown to stop DMA operations
without performing expensive deallocations. It is discouraged to
unregister the netdev in this path, so the device may still be visible
to userspace and kernel helpers.

In gve, shutdown() tears down most internal data structures. If an
ethtool operation is dispatched after shutdown(), it will dereference
freed or NULL pointers, leading to a kernel panic. While graceful
shutdown normally quiesces userspace before invoking the reboot
syscall, forced shutdowns (as observed on GCP VMs) can still trigger
this path.

Fix by calling netif_device_detach() in shutdown().
This marks the device as detached so the ethtool ioctl handler
will skip dispatching operations to the driver.

Fixes: 974365e51861 ("gve: Implement suspend/resume/shutdown")
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 1f411d7..1be1b1e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2870,6 +2870,8 @@ static void gve_shutdown(struct pci_dev *pdev)
 	struct gve_priv *priv = netdev_priv(netdev);
 	bool was_up = netif_running(priv->dev);
 
+	netif_device_detach(netdev);
+
 	rtnl_lock();
 	netdev_lock(netdev);
 	if (was_up && gve_close(priv->dev)) {
-- 
2.51.0.rc1.167.g924127e9c0-goog


