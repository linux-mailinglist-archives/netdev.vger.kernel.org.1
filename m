Return-Path: <netdev+bounces-238950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390EEC6191A
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3EF3B7E5A
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2030E85B;
	Sun, 16 Nov 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU52QHdf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637B30F80B
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313258; cv=none; b=BBodIYixuSR27DkWJMlZYOPINB7cEjF6lq698U0/YT4S+zWjfS77c1gkM+kBOi0P9+2Xw90UwT4SOysygL4h7qT3Mvg9LR/19gXVB1sJC25cxPdDHULrN8ia0ck8U+XEgKe3iMX8CvMl3p2ENHArqXrwCl2u3aD7MVvwc/S/nF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313258; c=relaxed/simple;
	bh=Sl57n5h3qnQFQNcmwKkS4S8dI3DCYu3TXVSej6Ds+H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0yGTPixnmmMOBSVYRA69yBkeqraLp+XLHqBqYHUCkiMlxavW3hIveVa1F7SgJdBCncUeLo3uJwVJsyJ6ogQNziIaOW2SI7NvXj/OHOf8B1vIDxXkhQEwzhxwpHiSSdfpzVvDLgR3PW5eE/Ze7oe0QQQEBM/ntCbdyipN2ndOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU52QHdf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632d45c9so26238745e9.2
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763313255; x=1763918055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85FBK1N7968Zf3zmy7BJUL2wfVMtCnOsN9wdrJDgfgc=;
        b=DU52QHdfZ3c9LoJ/OpeuWPZNyiXGETJ2vqM0Fw3xUS3H6cp12wIKIXM8Jvn7L+kRbd
         yrhBz6fCyn9jwyIDzWBBFOtQzWkzfkiD6ovw5n9QjelYHpxI49udNO7YM2uUg+SIhaJI
         VcK4kbPvnMalPJkRTcizVfNVGydAiinxNeBUO/4tNtOwf7UaJavWo+wEsw2CHgdESYec
         mnPAJvD0en/1WvL+ranPVoP8BoDKIS1ayVeYQ/hGSuvXMG6QdJ8gSnuVw1+BXi5EYJPH
         6r8IKMYzk97oP/g88v3XNQ4m4PLE8n1TXabxYf1kUg5TEebRBSmnrBh6xxhYru4VJH9E
         l02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763313255; x=1763918055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=85FBK1N7968Zf3zmy7BJUL2wfVMtCnOsN9wdrJDgfgc=;
        b=k8kicIy9dSs7o9FJ9kVmtEm+tY+Ztvu5h7U7hWJ/xOEvN6pr8dFUG8t4yZQm3Nkb3L
         IkDllxQ87pl8xIdEsYJKNRDK0kWBhZlfQAxxIsBuSJkBAxXNyPZGUQzIzH6JhJB1nhIh
         5g0f3L9ZAfLpDm1th7t6EQ6KLLZG0ZSTGpRCoz0f+WAOfRn0pQRwzkO1cBJqA/KZA948
         EGzum5kncdI7CdWz71iQDiIcLzxswjwPWt4LGpY0wjaRdGNU62agHV7Ft+IFJAijopA9
         GlXsi4qjicDrdKsuuwchbtFaEUIz0/glTuyBu7iOhDNCQkEALCRJMgypxQo80GuSpygW
         Z6+A==
X-Gm-Message-State: AOJu0Yx//q66LJU4vaEQ/+m8TvG2dfDGFusiTE4iI5oS4sGN+ZEesh5+
	Y97taKrF15sdfJsUJnxwATtA1iTa/TWv6Pu5Xv+sIkRvK4bi/UCcScig
X-Gm-Gg: ASbGncvGFgl951sM3jIx0z+/Ruz1Io876cEhq05+kwzoZ4Pt2N47WvT8CezwFTPlSVG
	OoJCnLCoziIrvZcaA/IhB3W5sibb2XTWDrGB46t3X1a99s4Bn1LzxCwMtEB+FeDgJeb6L/Dd7dJ
	FeEeKSiCHs8AnZUQWnLd/wO0Q1IhOQ09zirSeNLY79+F0AgTloeYEemdJaMXUUpcHopRX8sDZ5K
	ShUqU35bc3zmW/8r4/tbqzEaeDma8IgYPVEyhmf5ZBGjW8dHJQ02gY2ptUraJdJWw/uG+crrPje
	Lmx9XwSa3ZCMh1fhE5M5kDQkwjD+RNtUR2XXAwZ9GpJUW3yi0rcKMwWt93iD5whpHw9wk3HXhBP
	gNXZilgiugqr0vpyYmUUjtAsMYAbbkFMZWc1Y33gL0lrQggh9UrD0TWJraeni5dt+iFl11e8mjt
	C/sHFH2VcN3lc8AbWsoLEh6pMqFg==
X-Google-Smtp-Source: AGHT+IHNZQXmYL/sgtAzAPtdMkKKiWh8eiU8KGkxT2ZXpK/uFgFhXC8dYE5EiHJesoW2Umma6C8TLQ==
X-Received: by 2002:a05:600c:3593:b0:477:557b:6917 with SMTP id 5b1f17b1804b1-4778fe4fdecmr98962925e9.18.1763313255263;
        Sun, 16 Nov 2025 09:14:15 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779d722bc5sm70874245e9.2.2025.11.16.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:14:14 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 16 Nov 2025 17:14:03 +0000
Subject: [PATCH net-next v4 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-netcons-retrigger-v4-3-5290b5f140c2@gmail.com>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
In-Reply-To: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763313249; l=2028;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=C8sdELlfliWx0wFIHhmVjWXm2jGpSIoVSQHcSClL97Y=;
 b=bABY7arpLv8yYqtvmlKZTWMAJKTRxUUlExT7Ut5NXwA7l6L9/NebZ+VsPtz1yWJMHcaHwUv+9
 okBlPQZOD/wByUwI7CzxN5iwFeFjLLq2oH693R/I6r35NTIA4MkKadv
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.
Mark the device that is down due to  NETDEV_UNREGISTER as
STATE_DEACTIVATED, this, should be the same as STATE_DISABLED from
a code perspective.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2d15f7ab7235..5a374e6d178d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -120,6 +120,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -575,6 +576,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1461,7 +1470,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->state = STATE_DISABLED;
+				nt->state = STATE_DEACTIVATED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}

-- 
2.51.2


