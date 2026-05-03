Return-Path: <netdev+bounces-283547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA+aJ8bo9mnhZgIAu9opvQ
	(envelope-from <netdev+bounces-283547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:18:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F03404B4937
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 735923003339
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 06:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4463A7F7C;
	Sun,  3 May 2026 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R52BVGiu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB593A7587
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777789118; cv=none; b=n1fdZaN8Xn3mCvNIA7z1mjS0GhozL2d4rujcN/PTS3i1r84iAHeWeC8OLvpZpu/mvCtGMfJtwWYC2BrINvgZvW1wBzuq9/VYm5hscbTtghIXcpFzBYbCflZOE3abgmQfNoD9lx4VboUWJLBYri2dkgN1/n4/quctd/pHiWpX4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777789118; c=relaxed/simple;
	bh=AoMCpmibT7NFEdoLQ6HUrzTF02gvG3Z1FvFHarB7KrQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f/G9RJngpaGYPZ6TnWEfNR917kq7bHNwyd3NIAZfNt19BZ7mhL9lCTZqzxyaaEU+wM6DKy1QwSDIuOrSmJh7NJfUb8PmAWPWPhJOLDkyTfrgstW7Z7oJt/YbKlfMecAS+kZlSRbxHc+MUVIvbtcC+pn6jgS8zcQXJxv+Szeo8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R52BVGiu; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c156c4a9efso5432313eec.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777789117; x=1778393917; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LK22UkgyGq4ftOBwOhi3oEEHG2s5hAbxu0mEOdazjB0=;
        b=R52BVGiuJAKjWo1IGBys9Gx/ICwhpvAS4adLW/VEuLtfapEdK75SYq6FKWCtE9dkxi
         oda4DRtN3LaRV35vP22kSycWpTBcSzFpm9T++r2zou53Lp3LxBrVxxaGNJrxexHs5jWr
         kDBgK3Tmrw718irk3azXFp319YnO5APX+dzARGYd1yWp6w+Qugs1lcEdZhUG1jolYkaH
         mBFKnvwQ01sytZ10ZNzZ8gnZdr4DWy8T+sRiD/fqFbuhiYJ9mIkmvBVmr3/SoFBOsVLF
         Aw0PE/gIifNknfEv23jNnWFOobnI/KWtQXPx080BeXRekEpvkjVlowdPDk+DJAKBsDzH
         Fgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777789117; x=1778393917;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK22UkgyGq4ftOBwOhi3oEEHG2s5hAbxu0mEOdazjB0=;
        b=e/yMV6bdDV9tAZKfgbW4kjD/20r/9t+nAp3ediluFdhRSBYk2t5mnlE+uWQOLiW+KY
         WsJ0+8QTHwenUupLFwDaejkpc57J0mx9owCMrmt4dr5u/2Pk+y+DpMKuZhs0oOJiRD5f
         +kNtK8HDaqDsAJOdGOihDb66SKQ2awvvm0RoO1wr16L1jekWKE4kk50mPW2E0ix/lpZk
         blJOMHoo5ezUddDHM7DGBT9y0Vso0pPLLcMvLMdyrijI62lXQx65MydZi97wtIzMUdRM
         900JGg4Fv7W5wk43L4TjoE8Uf+d6BqSvp1e2Q3dTftmsXGCNXy1cmNfwF1nxiOYjQ5jD
         flTw==
X-Gm-Message-State: AOJu0YwME9WgF1218WSjW8Mic7IAZWvW7QoFgxo7WilBXTfGFmWjm1P1
	haneBLniCNYijkgdZCI8BmJu86Janic/gb/zSqV+mcDQtZpv9p0v2IU/
X-Gm-Gg: AeBDietdl78i31skhQVX3TBx5n6/7hFCxjG+qJiXLSEZxah8nmR8+Xt2uv0HOe5xugB
	vw/Jk6dQ4w/1g3Ao+OCNYoZsdnzs2uMoiIrkwnYmLSxauHAO9HAb77/imF0PaewHsazNIbJXsL+
	+ERSG1jru9vO53M+F+1Ys2ZXZatKHInbOdAHgdk9gLt2KdsLYzzmSSv6GzCzRO7s1+kn9fmTTMu
	mUqwslzp1CLlncME2idHhDjBJF5fqBQPxqtxQYzKyKXwBbh26oNOi6iwthTCeNiHScpuZpjW9c2
	MkpNRxSp9dEHOXV3ETwRCLe8fZCifH2VtoYMS13+LG1gVY9l+aNNyXXBorRxsWZWJwF2ogJU9Qn
	z3cEi2bwsZlvqU0GPq3l2cXk4QtW1CgcEHv4VXjjT5qY08yVsMO5eVh4uDxJJO13RzXkRYcIjLB
	NMfG4hsdOKiTptJ0OzucTBieRqbJITTGu2GcgGi368z9I5uCUZog==
X-Received: by 2002:a05:693c:3005:b0:2d9:77e1:57d4 with SMTP id 5a478bee46e88-2efba7a7e94mr2378020eec.29.1777789116579;
        Sat, 02 May 2026 23:18:36 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6811fsm11100344eec.29.2026.05.02.23.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 23:18:35 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v2 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Sun, 03 May 2026 03:18:20 -0300
Message-Id: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKzo9mkC/2WNQQqDMBBFryKzbopJJEJXvUeREuOoQzWRSbAW8
 e4Ndtnl4/Hf3yEiE0a4FTswrhQp+AzqUoAbrR9QUJcZVKlMqZUWjHZK+Hr2gd+WOyFb67Sta2d
 MBXm1MPa0ncUHeEzC45agyWakmAJ/zqtVnv5X1fKvukpRiqrqW6Ozb2u8D7Ol6erCDM1xHF/KK
 2auuAAAAA==
X-Change-ID: 20260323-realtek_forward-1bac3a77c664
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
 Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: F03404B4937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283547-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email]

This series introduces bridge offloading, FDB management, and VLAN support
for the Realtek rtl8365mb DSA switch driver. The primary goal is to
enable hardware frame forwarding between bridge ports, reducing CPU
overhead and providing advanced features like VLAN and FDB isolation.

Some of these patches are based on original work by Alvin Šipraga,
subsequently adapted and updated for the current net-next state.

---
I attempted to reach Alvin for review of the final version but was
unable to establish contact. Any regressions in this version are my
responsibility.

Changes in v2:
- added patch to use ERR_PTR()
- dropped bitfield patch. Use FIELD_PREP instead. Suggested by Yury
  Norov
- tag_rtl8_4 patches were submitted on its own series (already accepted)
- dropped rtl8365mb_vlan_mc_port_{add,del}(). rtl8365mb_vlan_mc_port_set
  is now called directly from PVID methods.
- reordered methods in rtl8365mb_vlan.c
- use dsa_switch_for_each_user_port() instead of simple for in bridge
  port join/leave
- PVID check now uses dsa_switch_for_each_available_port instead of
  dsa_switch_for_each_port
- set EFID of user ports to 0 at setup(), although it is the expected
  state after reset
- STP patch was dropped and replaced by a more extensive one that
  disables all ports (including unused ones) before setting CPU and user
  ports. It also extended the CPU port isolation to include all user
  ports.
- refactored bridge, FDB, and MDB port operations into the common
  rtl83xx module, introducing new realtek_ops callbacks to abstract the
  hardware access
- Collected Reviewed-by and Suggested-by tags
- Link to v1:
  https://patch.msgid.link/20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com

To: Linus Walleij <linusw@kernel.org>
To: Alvin Šipraga <alsi@bang-olufsen.dk>
To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Alvin Šipraga (6):
      net: dsa: realtek: rtl8365mb: prepare for multiple source files
      net: dsa: realtek: rtl8365mb: add table lookup interface
      net: dsa: realtek: rtl8365mb: add VLAN support
      net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
      net: dsa: realtek: rtl8365mb: add FDB support
      net: dsa: realtek: rtl8365mb: add bridge port flags

Luiz Angelo Daros de Luca (2):
      net: dsa: realtek: rtl8365mb: use ERR_PTR
      net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration

 drivers/net/dsa/realtek/Makefile                   |   4 +
 drivers/net/dsa/realtek/realtek.h                  |  42 ++
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 494 ++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 548 ++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 255 +++++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 133 ++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 824 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  25 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 482 ++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 2798 insertions(+), 68 deletions(-)
---
base-commit: edf4bee4215a173c0534d1851d7523d827149f9e
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


