Return-Path: <netdev+bounces-306516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /CEUFvzQUGoH5gIAu9opvQ
	(envelope-from <netdev+bounces-306516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:01:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6462739F0F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:01:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ohSWk+9m;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306516-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306516-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A42B13042580
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFF640E8FC;
	Fri, 10 Jul 2026 10:54:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9223FADF2
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:54:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680882; cv=none; b=fVLVl3sbrz3nGsvo1CXPADR5qjYSr0d/GTL1KsLSngTH3jaDetoicI2sevcaYRhBvGJUrCsfwA27T89yXFrnkGBUoFEgg5zozAaiBopAaFEduT8UO90gYle/RaWm9MU3K8MXIkDmHwJMP+B7cd13FLWgF7W5RJ/MrGTGkpXlC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680882; c=relaxed/simple;
	bh=vN8Gplg3HKboYHhrh53h0TgVjNq08Q48tb7ZFBm/Nag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzIgDZpz1HsDVS42gyG3GQVHcwXRHLSYiyYHOn42f6JPsySuColRbLBeHY1raRKOi+Fj7WkoBiilhuoweZvrDFNgjJZFkK9lSXeKNocqA2qrKah00W9tVaSz6T2ZXmfx6mtz+ewPLm9/ZcWYEhHbCVNuh/ib6/hHlma+FD8hi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohSWk+9m; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c999f162c9aso436593a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783680880; x=1784285680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j4ZVGeRqKMU3nyf6nzNvRFsoeF/EGxON3z9J6rKtVAk=;
        b=ohSWk+9moSZZ5EDWEhLYvlLf358g21eZnPOK3Q0HD0zKwl3ESSU0ue7XwFVJzAG2Gr
         w6sMaEzKUvtdcUy/+3LU3lzS02uwQyA7oHvqHfmbM74Er5ODrM67qV55s9tGVpxWl+6L
         8AQ6Q8o+vDJ3YP88wuUdCNs/QBBkCms7sZDk9ybAYoqXgVed/F5L84NJYYLHdLu1mL3F
         fwN5pOEWAm1NBoNHtvVyQeQZjppg3siATA12ejYeDlnzkhBGjKGjnh1aCV26QLYi3pUa
         uFSmbgBkpKxXhFVHPslVrLseeIu/IfGRRbe+758FnGwJnjuOnOUOUtvTxk86dgWOY0Fo
         yRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680880; x=1784285680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4ZVGeRqKMU3nyf6nzNvRFsoeF/EGxON3z9J6rKtVAk=;
        b=c8V/amZGAq51aLUQ4WD96ukOFwKhCymRUasgi6sTZLMh4/NDSBDcTEtwJxuKQgnyF5
         eTotZbTXmWuYfZgUwaOM2NgjBr0WeXFWg4oMmZusfWGSGxe/e/lR66xW0Ves6pPdV7wO
         b3zqrf0tLVEJ3p3dJ2WvPblcpupIm+L+zVjdGupVNGLyouDZy50dV1tPvF0iCw70KDNT
         zyqHFc+bnbVdN2t8KiowO0JaglQg/Cl9S2lprnwAx83DcvJCdd9UVNAKrkvYMtQSPsBP
         392A1vO4LzxpvxV/CicSayuBrE9E71TmBGb93UFzLjIqU8zGFPFH9dkHQbJdmSzSbAib
         xeZQ==
X-Gm-Message-State: AOJu0YxSg7wgj7+NDRFuPWsDOoodGKPXUJyv2AkJmkTRPz1C88KEcZLa
	LorGNbvlaUiOOY50RqlgsSdb7SX9PeKAICdGUj1rBUUx4lxCVLXn0NsAdTtFTSlL
X-Gm-Gg: AfdE7cnay4v0izsDLOGlYpT/j21+xnVnZI4rhgJWU009pMSmlKZMwStaxyGJjRaVSjT
	YkzR83fEC0Y+UjUgnBu2lWQO+RuglerNWuIzyxOK4zGi9CTj9MjM3vPrNx0t0QeyxTWMg9ZLZRC
	2ACJkRSVmt53e5om5Bqcz1T+3gcmcNGHlsCevO3D0aN6XcDLh00tTi1XFpGX0faUgkcvIYqQYYY
	wTNEfyoYHcNhog5/8wSzR5w6DLZEqXdAM5GhX9gqT9xy1sqflAfe1J9LIIiT8Z+ppOzn8ZOB7T6
	WvNsw1nyjE3izdN4lWBfEJFZUMBS7kCMNE+uZQYpAjka8TDG1nmnaimtzFmIOv5xUtAeKvIH/pI
	AoD+1a8cfWZVFcwhYnksmRVOp2Iyp3/RVV9eG4W/wy0RuTNdvqE7OC5wuXX+2cnNkuQdKeOnk8U
	UrKgmDxOjeN94HEunaQofF
X-Received: by 2002:a05:6a20:3d0c:b0:3c0:9c1a:8936 with SMTP id adf61e73a8af0-3c0bcc4068emr13266820637.62.1783680880360;
        Fri, 10 Jul 2026 03:54:40 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8572sm40752937c88.9.2026.07.10.03.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:54:40 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH net-next 0/2] net: dsa: mt7530: add EcoNet EN7528 built-in switch support
Date: Fri, 10 Jul 2026 14:54:22 +0400
Message-Id: <cover.1783680864.git.naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306516-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[naseefkm@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[arinc9.com,davemloft.net,lunn.ch,collabora.com,kernel.org,gmail.com,makrotopia.org,google.com,mediatek.com,redhat.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:arinc.unal@arinc9.com,m:chester.a.unal@arinc9.com,m:davem@davemloft.net,m:andrew@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:conor+dt@kernel.org,m:dqfext@gmail.com,m:daniel@makrotopia.org,m:edumazet@google.com,m:kuba@kernel.org,m:krzk+dt@kernel.org,m:Landen.Chao@mediatek.com,m:matthias.bgg@gmail.com,m:pabeni@redhat.com,m:robh@kernel.org,m:linux@armlinux.org.uk,m:sean.wang@mediatek.com,m:olteanv@gmail.com,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:naseefkm@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naseefkm@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6462739F0F

The EcoNet EN7528 is a MIPS SoC whose platform support is already
upstream. It integrates an MT7530 switch, memory-mapped like the built-in
switches of the MediaTek MT7988 and Airoha EN7581/AN7583 SoCs, but with a
true MT7530 core, four Gigabit PHYs on ports 1-4 and a CPU port at a fixed
1000 Mbps full duplex link.

Patch 1 documents the compatible, patch 2 adds the driver support.

Ahmed Naseef (2):
  dt-bindings: net: dsa: mediatek,mt7530: add econet,en7528-switch
  net: dsa: mt7530: add EN7528 support

 .../bindings/net/dsa/mediatek,mt7530.yaml     |  5 ++
 drivers/net/dsa/mt7530-mmio.c                 |  1 +
 drivers/net/dsa/mt7530.c                      | 56 ++++++++++++++++++-
 drivers/net/dsa/mt7530.h                      |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)


base-commit: fe3e786ef4eb6e47d2901f568a27bd920477bbe9
-- 
2.34.1


