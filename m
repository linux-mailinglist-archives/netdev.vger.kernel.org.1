Return-Path: <netdev+bounces-246019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDDCDCC26
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 16:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A6E30262A0
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC41326D5E;
	Wed, 24 Dec 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="chrN+xOW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A432695B
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766591418; cv=none; b=WglavhhK/tJNkSWTnR5wlvYJQGJ+ncd2zy1KoMA5WTTXM+OBt8ox+lSYwNyO7wBkz8PQWe+gTMjKbpvnMc+OjME+1fC2UKB8P/iFBZFWBWwqOyyWDohJ9VeA/jo4LcQWfW9lPVD8BEQPEov2zLsSfwY9lbJmCSf8Ub2ABD6m2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766591418; c=relaxed/simple;
	bh=CHA2bdiWGcTGdK8utlDflD9qu5D+MxouWcSB3dyY1nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVlGdjcxjxRkQevv8zG2FA0N0smN3VsRvk63hUzp6YBxxoqf4a6+38yWZpu+kA4BZiDeQKtxSMQH3OH+JYqge6U4Pa9wBExfC5HJ5DB3jZqdVf30QlyxAHF0f7tQw6yWDajuBeNDUdrSPBOhIQ9QBJ9A/w3S7V+NDotp4qEmZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=chrN+xOW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so35207275e9.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 07:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766591414; x=1767196214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VkucTD2zc8M3bXnpPs7hKWyql8PHRKkVkimfGpQxM2A=;
        b=chrN+xOWrU7in4Gjfl0rdE9vzc4KnaiV8j/u8ajMez4FF1GSyum7S9n1NZlw8vwoPA
         2AQPSs36wgvR+JKsBjXGAphVGgUPAOGjMfWpyPQE7igyuA/zc+ul+gIHVwwre00C2Bg2
         HMCKagzcINzv8HK4anPXcMJL/LoUnKKwC90DobEhpB06RNkp8q3cXRG9C/S20RGZdy1m
         7IBGJq5HMoLd5c9vUgKVDz9nJcZxrSi8BT7uFiUZS645PyQF9Yhh2ViyG/poGbAjUiK9
         089km4VtAJACM6gQ3GPk8AONefOdsHa3+x6YergU30Pz1e1QhyHi4ZQEwoO/llMOIySO
         4nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766591414; x=1767196214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkucTD2zc8M3bXnpPs7hKWyql8PHRKkVkimfGpQxM2A=;
        b=jvq6KkijisRRrwk1cgMQqryTVIS6Yx7wH31Y6s+k/lFQj1uODX6Q5nv7is+vjRjA7S
         bHRjszqDeLJAx7l31Q3YFPDmp/TM6mw/g82Pxhml4rdUGIuazcaWC3TA3PR9M2XdiHIu
         MKhObtdRZvvD3eAnY3aDvxp2gDsaUVc3IH1lYQuSGi5b7gblFBRSslVXiiwi5luegGoJ
         btVE1EhIY8QygITNLAh6s9CW9PWp/fw3k8cDPifbWUitOBwXdjlBiM7w+VDe32q+DwM0
         JWwDoHmssQp/Y/I339K+eIMyHqoMmhZXaxnInvMmwuQJhrVbcwJ1VUA3rr2PzWglYxTJ
         fX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb5ecI42eK+ShzAJKtdblqne9Zi8E4DHz2AgDwXErGc3pHVNKzI93jmDJtJlVQPiDRQYbJtas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcwbeel/eOtcUs+44HbTyyZyFpTqoyw5oRioErNCoPKrYh1Kkq
	9Eg5IYpW1lm1zhm0RfVqDSFmx7Gikf/5955uNyne7SegEz9SO6x9MUGPEAXui2/NBSM=
X-Gm-Gg: AY/fxX4DS3V4zf7pzCFWezQyeoIy+F1EJ/y1vrC8Izr/hQJ+HOhJZvo88LBa1O6zZvv
	PoEaeslB5QfV4rn3zDQZIzgdt0vyyWiTkMd/v1qpPyTgbYtY/ac3dM7RxKz8Zdkp4CwpV8ouj4F
	bybFWwDqNQdIM5Qk6O+6shInGWGsYxBVinXiVvK+3S8WPASrS06fwr5sS+gP9vy4fQOLxbuTwja
	dTK7GZQHM7OKbBiZPZ/ZgKh56TJIGBjHU2OCX+4WHHEmpBcbNlrl2nWHhwLP/rzI3/9n1Cj0na7
	9q38T0LG9HlyGui7uhCJmcQ1EDyNpWKcu4Opq1YSmYp0fmNMJGekamEASjpHVhzge0n2Y0sN7nu
	TnV0CnR7eW1rrHpRJzE6a4nX0nm0gs1bddODVwK1cRBmkGfVh3rilwDuJrTM738z3alAVyuloFI
	Gs7v2vx5Q9mWnNTkWtUFJ9lsKig5ve2iOied4=
X-Google-Smtp-Source: AGHT+IHjjaGeAzuQmEmxFLtylaNCbK04Sz2O3YUYj0rVWixCl2e4DJNIsfnp7V4ZL7ifv316KTUlFQ==
X-Received: by 2002:a05:600c:8b06:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-47d34de6358mr78512955e9.31.1766591414323;
        Wed, 24 Dec 2025 07:50:14 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a20af0sm135768785e9.4.2025.12.24.07.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 07:50:14 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] ovpn: Replace use of system_wq with system_percpu_wq
Date: Wed, 24 Dec 2025 16:50:06 +0100
Message-ID: <20251224155006.114824-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen after a careful review and conversion of each individual
case, workqueue users must be converted to the better named new workqueues with
no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ovpn/peer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 4bfcab0c8652..0463b5b0542f 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -61,7 +61,7 @@ void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
 	/* now that interval and timeout have been changed, kick
 	 * off the worker so that the next delay can be recomputed
 	 */
-	mod_delayed_work(system_wq, &peer->ovpn->keepalive_work, 0);
+	mod_delayed_work(system_percpu_wq, &peer->ovpn->keepalive_work, 0);
 }
 
 /**
-- 
2.52.0


