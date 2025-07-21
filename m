Return-Path: <netdev+bounces-208715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D411B0CE47
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B2541974
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CE2243953;
	Mon, 21 Jul 2025 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNNqC9XP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986524678E
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140972; cv=none; b=sjv+WNuC4vqpiyPK2w52Prj9gAmaILtB0LTY3QWygEirBekyRHYW15yJzSsEW8sBPy2yY0L4QBWXPju/WmgkcoxmrUTBTFT/tmEs+NGmnK0ucs8yY+xbu+q/7m5FkfthlU5kh5gxtqI5tqkpOifXOV1aEiEBJkofLGRUTFhsvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140972; c=relaxed/simple;
	bh=LcChigbcQC5gepm/gBPHHGFklcCaTEDuEPb3nBjL5Xo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jsNy20I8G7VcYb9l5tS8vp7vyIYEZy7aKBSFWzulP85LMvK7glX/9J9egEzO9WYvnVGscY4UxA78O0jB5WjCHNoBN0cVhaKi7J696D/X2CQlPuKZ/KxkYUyGTuXUMuDmP/eHmjLgWwjbWM0xDAgkDCDpnjXonPA5JXFsbVSPiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNNqC9XP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-756bb07b029so4352196b3a.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753140970; x=1753745770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tFJj1nHrc7+rZGLc+wiiJXp3IGxvx4S2SIF823quDhU=;
        b=KNNqC9XPv7efm89Y2SXLuBBye8oJy+qd0f2SRvr2XO06vNj4EDfnRPaVT6ypfXtar2
         zrLipp/xOaQ+xRtbA2C8RxWouviZ0FK8Mh3X1Z6Iv7gmZ5nqUza2zwD3alGPX6hyWtUo
         V+ROuAXwknNnnkmdkLMs9l7m/mxmBqZrMnt+XIgpqUSSovjtLmutJHhyqTLOrNOEKybj
         CmEmNeKueXP+QoyRoLBjNSefm5d9ri2gdfzGoQquj4Q3ku5dNUwvc8x3Dqf+XHRQGhSx
         kn16Qtrc6vrjcHNALkVSi4nJgZ3J4sn5LNeIkeSk8LKTetovwj+zZ7bHqGnINll8UMrY
         EtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140970; x=1753745770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFJj1nHrc7+rZGLc+wiiJXp3IGxvx4S2SIF823quDhU=;
        b=sUaL9hrv0cKOjhhOa9GFtr8jfcYvnWg5wqF79WR1E2vVF5uAxE7wYpVKjcubnUxmsn
         AlhyHyrl3aq0XS7NOFT29DlXsklIw4SwJvecxbkcA31LtQFLRoo/rXo5ScSHZYCyy6bO
         v44HOBli45KVIOsTcfelGUUsV1QrBC086QFLilavde61WHMdmvCA3tJmxuhV+XwHjBHy
         BV3hVBR4jgCUS9gdj1xaZlsmhtT5gGLJ9VQiph/UA3LX9bYiSgmwnwlnJPFfHrD0xz9q
         nmYc/Nx4JN/yR1ZZYpDGeGLeQkPsFeC/TatypFVcdFPZtPYHuLWA3FK0Hd/MGQq7MNt4
         Tx5Q==
X-Gm-Message-State: AOJu0YzLJJaXiMnb4e/Nv5Isz+f9En2T6M3ROyH6Pl1TohzbHr6jq0T6
	CHTUujYzSg3Nqf97VUTGpp1oRvLbxAKz9j0FOQ3WpV4e1ds01ZGUwkLagVm1OOGlh0xCeQoYTey
	CHovF6xgGjSKaGw==
X-Google-Smtp-Source: AGHT+IFz4JGf9GVP5eQoniQxzG0romEA/jL1ms9yqmqYnQ4G3WrWTVv3tXfIsIXAQTrw8y9e6P1XMxSWj0sNKQ==
X-Received: from pfblu3.prod.google.com ([2002:a05:6a00:7483:b0:748:4f7c:c605])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e1a:b0:73f:f623:55f8 with SMTP id d2e1a72fcca58-7572267ae68mr23284461b3a.5.1753140969869;
 Mon, 21 Jul 2025 16:36:09 -0700 (PDT)
Date: Mon, 21 Jul 2025 23:36:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721233608.111860-1-skhawaja@google.com>
Subject: [PATCH net-next] net: Restore napi threaded state only when it is enabled
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Commit 2677010e7793 ("Add support to set NAPI threaded for individual
NAPI") added support to enable/disable threaded napi using netlink. This
also extended the napi config save/restore functionality to set the napi
threaded state. This breaks the netdev reset when threaded napi is
enabled at device level as the napi_restore_config tries to stop the
kthreads as napi->config->thread is false when threaded is enabled at
device level.

The napi_restore_config should only restore the napi threaded state when
threaded is enabled at NAPI level.

The issue can be reproduced on virtio-net device using qemu. To
reproduce the issue run following,

  echo 1 > /sys/class/net/threaded
  ethtool -L eth0 combined 1

Fixes: 2677010e7793 ("Add support to set NAPI threaded for individual NAPI")
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 621a639aeba1..1cab04b8f60a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7244,7 +7244,8 @@ static void napi_restore_config(struct napi_struct *n)
 		n->config->napi_id = n->napi_id;
 	}
 
-	WARN_ON_ONCE(napi_set_threaded(n, n->config->threaded));
+	if (n->config->threaded)
+		WARN_ON_ONCE(napi_set_threaded(n, n->config->threaded));
 }
 
 static void napi_save_config(struct napi_struct *n)

base-commit: c3886ccaadf8fdc2c91bfbdcdca36ccdc6ef8f70
-- 
2.50.0.727.gbf7dc18ff4-goog


