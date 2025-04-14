Return-Path: <netdev+bounces-182464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFAFA88CA2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8366189B74E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12B1EDA04;
	Mon, 14 Apr 2025 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSHdQwi6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A51E9917;
	Mon, 14 Apr 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660832; cv=none; b=ac5pF4zj3pt+ZztQWcNBbchojh+qN7TYmJ8cG/hIxfjz5iibprgyA85EYwR1mCbitdQzQqDiHT+xiejFt3OEg1Z5gqo8fVJxTnXEL3Q4jjG791GQ5kSccw49Pqf5A0f2BMQnL2ltfbSfozDsX3npcX8nMX2yBrQk0fdrzOCydUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660832; c=relaxed/simple;
	bh=wN66fbhXuks93JafYdJZ3w2vTDMMVeP/MTvUpMP+HNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGdbkc6yeTYPPK4Zyly6BBtA02STcEt/yQp6aT8t3zsY0zunRntiARFFSbfLoK6PlZUaImH3C+MrGLuBGQ1U4edJNh5rFK7XHSo42SMRAnzUc9lkkmrv1iNW94c7ziYvDRj/uDyQdQAiCXnE+z2q1u3hO+mYcoV0SwF6FGdZfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSHdQwi6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso10470571a12.0;
        Mon, 14 Apr 2025 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744660829; x=1745265629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YA62eK01MS4YMpjP4qPRP/SWRiVysC+pcVZ2AAuJuw=;
        b=gSHdQwi68Z+VMLFRaJM1wWgXsW8n6iSAznp/BrvawX+mvLwVwUqsjpZY//OVLyQc2a
         LW0E5+RTW2fJQ8tIL3LejYvsWey4HPrMP9cpHBLk9iAnt2Ci9Wlj1t01SX5Svgoe9t/1
         Yo0KbnemG7WuH7yGbV2iWZZPe1vjTKcoXRSEGnSytEJZNt+7jOdDmD+JW40O7QvZgmSE
         TTYAOT5E2Cd4Ug/C1Bn7U8Ofg347RsAuJp2a6gueEG+QXZ7BU0A2MYkwkLCswoWLHAK6
         r+dN1tC4/f4v8ZLTGMP4bYJm5KDdwiG69C8vU1S7lonWUwc3JSuc23ADBXFogmUm5uMj
         VL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744660829; x=1745265629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YA62eK01MS4YMpjP4qPRP/SWRiVysC+pcVZ2AAuJuw=;
        b=xRVHQNL50ZtriQvqLGO/cAFzU63DXqBowy5Py0vbBhiOgR2qoJpmAHZTP5Sc7KpnE8
         /k+YT7iBJVKnLnoUdEuF+5pOaBbNapUpkrll93ebMXZ9MVpLk3RHA2jW+cgBVzQQ+LHJ
         3snKS9jHnM8JhCa6C4RYztvL+3MooJudnGcgX2RuPKpgpe3xeHRC8H4Ai8QzAvaE4Kxf
         /azdHmZsFlUgukM3okZm83GfMm9mZmCPo4+TsEa/ObBTxqxF6jO/HgedDjKYkHaHzTeF
         QRnWOvfssHQ22KgvCMtzJzjKYKt0RZJjpmwNgzEYCnrTvG54qUSumQmv/qWgI+S2GS1f
         VXUg==
X-Forwarded-Encrypted: i=1; AJvYcCVPny1ukjiDvrMFDijLMbhZtJCPWIA3m7r3D2zgYGV0osuvf1jv++XPxGanoNLW71KEHm5hK5uuqR7qddE=@vger.kernel.org, AJvYcCVQoJSC/CBOoc0xD3FsemKNp1FSNNPKAYxpc3u2O33rjc8Ng0QnVDJ97ellafJqZ8a7anvHdjcF@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHZSHHL2PwrUbn2iCPbbrDTqxuZotvWYsq6zWmO3T5BowATU9
	l78wR3XWOZkl19u0Kj8Q2dbNNquXB8SV2wZYi7OB7/E5LEXG2KhIKrCMx8K3
X-Gm-Gg: ASbGncsnQ7kKtPRXptiS3KnFLbz1yBwmBgoReGixFRJ6jvivAiamOQTA+vGr1u9Iy0k
	NBCzmYL0bBjuSbHpfyO3Fnvu4/rJPvwwRkXLKxWEOxuTb5P9lqzhc9pBi03fGSQm7wxt3njVxTT
	b2NnYLkMd0gb6ZeS8KRM8ZamPx4TCshbOtPYsMy8dcqnIozV//Eej97BctAiJZmFRD9N3VbzWaH
	HgL+r1yZLvjxeMXqUdYAG3PIO4P625KucOXjPsHxz8v+mXVQtjIiEAvAaCVedZOPxzYQsQ76V5e
	Zjnow0SKN/eIscm8ZJeK7RkCCZsJJoy25Izylr4x8ZREtj0YXSyVwxw3H3yhWVMASPLaWw19Fzn
	ZLuCs7fcd3H7uCc2949Gw
X-Google-Smtp-Source: AGHT+IEGlZbkJjexJwqszfNiPam4av9rMkvTxh9IM6rb8tuetGKBs60SC5tLj13pfhDdo50QNYJQrA==
X-Received: by 2002:a17:907:3d0a:b0:ac1:dde7:b57f with SMTP id a640c23a62f3a-acb1688aaf6mr60931866b.23.1744660828916;
        Mon, 14 Apr 2025 13:00:28 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd1cfsm965494566b.138.2025.04.14.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:00:28 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: bridge: switchdev: do not notify new brentries as changed
Date: Mon, 14 Apr 2025 22:00:20 +0200
Message-ID: <20250414200020.192715-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding a bridge vlan that is pvid or untagged after the vlan has
already been added to any other switchdev backed port, the vlan change
will be propagated as changed, since the flags change.

This causes the vlan to not be added to the hardware for DSA switches,
since the DSA handler ignores any vlans for the CPU or DSA ports that
are changed.

E.g. the following order of operations would work:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
$ ip link set lan1 master swbridge
$ bridge vlan add dev swbridge vid 1 pvid untagged self
$ bridge vlan add dev lan1 vid 1 pvid untagged

but this order would break:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
$ ip link set lan1 master swbridge
$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 pvid untagged self

Additionally, the vlan on the bridge itself would become undeletable:

$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 PVID Egress Untagged
$ bridge vlan del dev swbridge vid 1 self
$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 Egress Untagged

since the vlan was never added to DSA's vlan list, so deleting it will
cause an error, causing the bridge code to not remove it.

Fix this by checking if flags changed only for vlans that are already
brentry and pass changed as false for those that become brentries, as
these are a new vlan (member) from the switchdev point of view.

Since *changed is set to true for becomes_brentry = true regardless of
would_change's value, this will not change any rtnetlink notification
delivery, just the value passed on to switchdev in vlan->changed.

Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs from changed ones")
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Changelog v1 -> v2:
- dropped the second patch always notifying dsa drivers on brentry changes
- dropped the cover letter, as its overkill for one patch and it mostly
  reiterated what is already written in here
- fixed the example in the commit message to use vlan_default_pvid 0
- fix thinko brake -> break
- extended the changelog to include the assurance that rtnetlink
  notifications should not be affected

 net/bridge/br_vlan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index d9a69ec9affe..939a3aa78d5c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -715,8 +715,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 				u16 flags, bool *changed,
 				struct netlink_ext_ack *extack)
 {
-	bool would_change = __vlan_flags_would_change(vlan, flags);
 	bool becomes_brentry = false;
+	bool would_change = false;
 	int err;
 
 	if (!br_vlan_is_brentry(vlan)) {
@@ -725,6 +725,8 @@ static int br_vlan_add_existing(struct net_bridge *br,
 			return -EINVAL;
 
 		becomes_brentry = true;
+	} else {
+		would_change = __vlan_flags_would_change(vlan, flags);
 	}
 
 	/* Master VLANs that aren't brentries weren't notified before,
-- 
2.43.0


