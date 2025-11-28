Return-Path: <netdev+bounces-242633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269DBC933AA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81F33AE31E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 22:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACBB2EA16C;
	Fri, 28 Nov 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGXJVnti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FE2DC776
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367709; cv=none; b=XS3TFE4nzgGbI9mgEPulWKt9Z76IlDv45reGqOTvmmZmOsLYUgSR74mfe1CExAuzj7jcRVYts9Yr2G3rls7FXZYWXMUMQWVxlz8nQhzrOGugVEzUHhL1L2teAipZuoWius2EeGxpgpq8L6ywMal+ieTqmxSjj4nlfhCZNojUB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367709; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DaH4h2R1C1y7ccCrhRN/aSKqt3Hy/dt4Imt3OZnojRzK6LdEPAE68wCuJI04HFJTredZOtapY8NAguNlIu3Ez+RKiLhMJ3R0N61aMXRab1s/+UG6ncd7nuE+84Z6hNi8Z572Vzp3QVp+tlG7EswE0m7f0/vx0FEBCfBU8AxPsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGXJVnti; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1930348b3a.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764367708; x=1764972508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=dGXJVntiSZZidJaEYQWYuCXXdwg4QByX3kDzwShDuhfPI6XVLwcgUtmaN9qZbF5+wT
         Lw+x8n5rBVq91z55Q5bpvj2VClxgbo5oVz1HqtWViBrbRuZe8QppnsOmCLfBVuabEcsr
         BS1ByUHd+mc2eNZyUyi+OEgejnsULwit/q7wtX0O7l47kPKc6kaMRv99qVRh0Kn6kxAv
         6HkAKiaGByk1Dwd6jTrE+Br2V3eh0xA8h/GLSEJ9+cdFoo7rJfqX6Vv5NdHdJLw0Q1HU
         3nzQw4dZQgJNu7ISRaXqELscEzdNrTcgdhTbFAEjkkFe0MpPiS2yPurG8/dk3S/GHI54
         OEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764367708; x=1764972508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=laSsZMEXhugbhyFItdppX1Vrl7X580Hif4Fr5qOjJlFJXXZDUbp/miBKAsKb06LKI3
         lkVFvLZTW8TCXslpA3p/qOFl3hawaXr6EJHsXJ6nYy0CewLyBSNdwkuWbfQ60VssnN4O
         7B1UUNpzma+O0jiLDhY52PyKFkwZ13tR75JtWu1Y48DBe1ES3n66/7dDO5Jyc3Uypt1q
         wJZM9GvHPkM3YuQY0LzN8ZnC8Ukb0gWvy20fL3eriG4pL2zvA17m3UMEWLsEOv5ZPRDv
         uCgUIan+dvPwyqwKtLBvpjLud1PmlkHA4dxbgdAVv5fcL1GHyLNyWtY8EbMvsMveDW26
         s8Zw==
X-Gm-Message-State: AOJu0YyccQh8onUCGoAPZftJfEU0yF3DxwLbOsl3Diee/NzCBg8su+eB
	+KQdJIUw49p42FnYoukvBvSGl+gJZ6NmM+ykFVF9HtfRrZOGmO9SznqD
X-Gm-Gg: ASbGncsb7sJMu8cle9y5Qd2CBqGYLmAJaFrTtTOOQLZrPZP5AQo9ZYcI4B9Kz5FT9n1
	4j4JOn029+qMkd+JIHosH6tP2I51pH5XZTFp3+C6g023dkSuYYPBuN+TAjEPbg363qhqPguT8Jd
	33XOJ/YBo4Ce9HkLWxFLO85VFINS7q97fFx8fH8vZ5yCFWqXAxuA9deWZuAOd5SgSkHuAZo94xa
	NzvOc1XbWsakMoOMJs0K5zKcaRJ+Qq8zfdrQwRBHlLDq/qQ3pFPON6CAD05EvwGlw3EfFDCAQeE
	ITPsxNVFWoK70UveYBwKHQ5kLNSA2VNy6oPUzDA1pnvmkqbVH5AqICIe5Di9vVxDMUbpO198+M+
	nnC8swhwrvvFXjTa0X/pQk/Sw+V4sDMCqk8O7nGIcN+6DJqodyW5b+7TNvtSa68vgnx2QKaAO5V
	U3ZZzg+lnVUeEqXKwWOA==
X-Google-Smtp-Source: AGHT+IHP9cacM3sLthbsJDzciAEys52jMWZBJESkwrB9/1Buq/1iB5QinbxCfCe5nE75YPOMpByUNQ==
X-Received: by 2002:a05:7022:1506:b0:119:e55a:9c06 with SMTP id a92af1059eb24-11cbba6f374mr13160663c88.34.1764367707518;
        Fri, 28 Nov 2025 14:08:27 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm26824205c88.3.2025.11.28.14.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 14:08:26 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 28 Nov 2025 22:08:02 +0000
Subject: [PATCH net-next v8 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netcons-retrigger-v8-3-0bccbf4c6385@gmail.com>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
In-Reply-To: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764367687; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=OKYBLhWd1IZ93XaJ9r5FNHNxrv9gpqahkExk6+Sfgd6RO3fy3SSFjwyesY0i0145zbiJbCC8N
 kESIR+0Us6cCG4UmGvJUiw55zckCUS23UxCkJ2i8G9SSdcO+03E87C7
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

Devices (de)enslaving are marked STATE_DISABLED to prevent automatically
resuming as enslaved interfaces cannot have netconsole enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b21ecea60d52..7a1e5559fc0d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -122,6 +122,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -580,6 +581,14 @@ static ssize_t enabled_store(struct config_item *item,
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
@@ -1445,10 +1454,19 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
-			case NETDEV_UNREGISTER:
+				/* transition target to DISABLED instead of
+				 * DEACTIVATED when (de)enslaving devices as
+				 * their targets should not be automatically
+				 * resumed when the interface is brought up.
+				 */
 				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
+				break;
+			case NETDEV_UNREGISTER:
+				nt->state = STATE_DEACTIVATED;
+				list_move(&nt->list, &target_cleanup_list);
+				stopped = true;
 			}
 		}
 		netconsole_target_put(nt);

-- 
2.52.0


