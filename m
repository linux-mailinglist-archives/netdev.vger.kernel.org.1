Return-Path: <netdev+bounces-240757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE1C7912B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48DDD4E7C98
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99BE330B19;
	Fri, 21 Nov 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/FulqFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072230C61B
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729381; cv=none; b=OyccVzijkC2Swn4ViDO1vHsqVfMZQOjUBq3ucZpvGBjpSNIloGW2QmJ5++Ha6068MPIa3lypnUDIkFWMRPhS8Tb29HRhmO9koPKXheUqx0nNMyTCbBe95AgtUCUpt2XNf6n3nmlr/71yeNytxOsmaUnrvSClL5y9MIrioYmxszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729381; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZ9CAIA+A1NE4awjz+bmuBxhBJmVTX4bs/S0kAcCoLdjmcH/cTGIAOPtSEgbk+5S1uEYSr2szdXiVNi5J0i1slIAmB/Ix+A7Jf5CP9tSxwA8G3fQD9g3l4GTFQok5A8SvNgDnaMRfN/vWvBJROA3KeCOKotIxUhlVXU7+FGfju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/FulqFM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29812589890so23746765ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763729373; x=1764334173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=T/FulqFMD4RkJ8LEIhvIFbMjsEgbbCMtjeAWXHQTg2boHHy2v7YXbJBXQ+DQiAE/Fy
         efV2gv/VF2t9407tqcGVphyYQgt/GTxXP/9Rk71WCBaCXLl3+c2Xnw4p6ufwXYhcSuh0
         Xm8PMcmjzxsmoRTlLVAnt2/VMjriXa2Kx87nOwa8dGPPnmECp91B1PmX5Oh9XyUjLAJr
         ue13kdTPi6NUN2kYPEfU5/ZWrZv29J7sxQIdzUmk7vZmlitHWr63TIYxFYVw7fF6QwBc
         myF51NMyKQJkA+XiP1QE3xiIN104iGeN5HbqeUva5+49chY6z7skduj6LHRky0ED+5hJ
         FiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729373; x=1764334173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=l68TCoeQphRrOk7oCkXwHVL+4oicGZLw0xWYtDvFkpwOC895QSXARsEVxf3DmmuJbi
         AB1dEO13kcJ5ut8cr4NvqSQkEa/XEasdSTl7cPieSE1xuGQkGPTSrEG0Wi4D3Q45px3v
         6KZ9xDHexOEqZfEJ+GJ1cws/fedNDz5OQqI2EBkBCGvTrsrlYoj8zCa13WotB1d7O4hd
         2MDSfRjG+Ry6gJ1DXqjAg0kjhzfwb6ES+un8Tu4EImal0NiUBsaVAcbkLniwVbQU/tw/
         /ecSDQuLClltuJq7VDOET6nTExKqgOXg6iZ8ABHTia0yYeFK1X1HZlsashflrHRYKbD8
         d1rw==
X-Gm-Message-State: AOJu0YzOYv6Mn/ZVstPRHxF9DKQyQ3evojEhECF0rGTYVwe3HASFJCJc
	AyBqc7ip2mkU6R9FLZJBKsyMFHUREUUfR8SkRGtAjkvlxXKKr0DmPIOl1CzELkTvPY2IltKC
X-Gm-Gg: ASbGncs3WG/Edjj6dFxZ3o6c6jYDwBDG+jHlTAkg+MlfNVDLSmcLxxMK8ILfD4TFape
	alLHYtxEdA3XMuHjvrunBBwL8Bf4VobYPUFolWhw2Z9mgoj5gZ87bzYt7aVMB0nAiNydvOEqkHG
	0de5kF3Yee4tIVElVJp9xR7WjZkZg+JSj4lhpH4dU26zUydW58wUmScT5yjEDdjY5YvLYw4of2O
	pA88XS2W0ApytPnDgs8XW7lq+4qsA+jwoNJbsTyCz7dhQ47HD3QQH9Y3FIy+a/8Vh2tmZRqOyU8
	7ulj3HYy3mPK9CpsYbn2EeBeRtU8KetzsPY9U3WUxu3d9AUgiMA2o8ki/MdbhkecbS0aRPqQuN3
	dyMzt0QLELiQ3Ri3FIqLrGTG2+uggim+AtCYoo+nHfNVpeQ6Q03QsiwAz9p4eZoSum/Fr9IjHV6
	A2wPCX1rVw2iP3cajn
X-Google-Smtp-Source: AGHT+IGjQY393wbPoRfTrgThZUbRXZ8/OuQlRpf2ILVHZvNAbrSjcZJduZN+Y2ALKisyM9NoH+L+Vg==
X-Received: by 2002:a17:902:ccce:b0:297:dd30:8f07 with SMTP id d9443c01a7336-29b6bf806bcmr29078625ad.50.1763729372688;
        Fri, 21 Nov 2025 04:49:32 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm56644045ad.75.2025.11.21.04.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:49:32 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 12:49:02 +0000
Subject: [PATCH net-next v6 3/5] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-retrigger-v6-3-9c03f5a2bd6f@gmail.com>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
In-Reply-To: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763729347; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=mUF4xs6Q425NCVpPCEL2wiPv3fqPZv2HRqxhVxxflU19F4YinKcf+E/B/ctw676dwZSgMMBni
 b80Fvf7Oud1BObj0an3VZA1S+MxE8rbrVuQ8R3OelHwa1uezyuAywYT
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


