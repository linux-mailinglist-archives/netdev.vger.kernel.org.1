Return-Path: <netdev+bounces-242506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8BC91171
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71BB04E050D
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B362D5C8E;
	Fri, 28 Nov 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcknPLZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FEF1CEAA3
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317200; cv=none; b=SlLMGB7lq1UEsB3L2elZmfbWmuoF639vIkSGcW1QNYiCPImbnQWHxSS15Tb9M1jG3qkNuuB8kB8MkQDPXMoE5JhF7O3UnQgJrieXjVHzGbNeN76ob0RFSdJjWOOAtZW5C636dwRjhtU0iUxpjtqdKFuIPbu2LXqV8BrPhcVhWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317200; c=relaxed/simple;
	bh=RuaSVob/OFTn3DUtIstH7NKQe0aOf/L3fs8hCElKy+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cTUNgSdWZkqWQILKt64PPaoMPDYz785fXc/2C7ZRZp7fpbhnrtqJJbPyDJm0Izf+Pt3kS2z402kqAJJIqP5zzxb+GwVbwe6SEGwDK4/jBZ/gdPBoun6R93n0DOaXDfnoj/rwpMsWmsmmwLXQTVg5XYtRWteODDI/SzqBuDydS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcknPLZo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b73161849e1so348770466b.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317197; x=1764921997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GF8qzZ5aC4QFBtOdX1V/ZnNJfJs6kDMMgn4xG0xdpzc=;
        b=FcknPLZoxpeHF6ymDH+7XUxTj79MeMl9Xe7+Pk6C9xfaywAeugPvcxG15stmoLPUHF
         vuGgXxbZkXpuB8ADtcGxqae7SlpjHlPrv3qs1Q7TIpf66YNxyOBOBlHr3qpStwX0M4Xn
         etqmsJEgwIfIzt91PtAHeI+pOc7Xl+m+U2v6MjvxqFsVP7pkebqYWwOt64annvaaq7M6
         7DxH0gP4BoFK9h/Kr4Az3A+X5+bru8+Nsg2sSQYrqte49XYwXwOsnEf+/KaGGe7BeZ+r
         Ut5ESVSFUNGgdwyN4WEEPeIeeR4mfPXoGLPHZ1z7fG0aWPlQUuA6Qc13eoDh1AKgg4ZO
         eEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317197; x=1764921997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF8qzZ5aC4QFBtOdX1V/ZnNJfJs6kDMMgn4xG0xdpzc=;
        b=m8t9UbzrXMY4EpPZlasgUnE8NAZU0aljyDCgV0PnAcCf5cEGqlUkn7zuJdsEF4d1Mg
         cjzZ//G9Jj9kogp/Nkw11/A/2ZdHeyIfYd2XEV1aE+VLliHkZvwMnPBwwKJ0cowGl5Cw
         KdjNk3hCbnSPLvOIuw/2WXQot1rRT/RkyVAlHNQDH0vEFDIe1t2VOQZvtcC9C4wokK5k
         z/45hPaBS7egXSCXgu4++q8fEZtY/kqQJzOD+PDZ/dULyz9IGOlKqxD8RjmYEGf3+PDF
         8QSiIw0v/AolH8jl4+CJUBY14vqCJdDYsEaWVfbJaGz3O3Q2ukS/rgr+OP7BRLPMbe0c
         RPNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe1S9NoYV36B4xPNEuFE3rHiqNWxc9fChKIHgeFNGB3R5QCs4yzwwrX4dpN3tP0bQ3hmXo1X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjc1OVFXX68pHzNiqVRqdo3qGYrQ42xro5Ebg0mUzN/iFXdqNx
	c2+zGpAk9owtk+Fy/ruoIZ7xSitSdre9cViu7gaWfKgt0C2ia7IrJS/U
X-Gm-Gg: ASbGncs3OqQ4uT/B1zmJMb5oE/+J1zs+X+isu//GaHO1TRgPMagYLfmjiHmk+8e/wVA
	tKr27IOvKKtSxdkL5/wJ2R8o3VT+TOauxSSbvKdMhWx7SCDLVjWtTr1VaATZVFnQSjZq6DFXY6+
	2vjRPmeoix2qQKC+wM/M2u9KsJ2+y4NmvHaB+6hoPXPYaJc4VKEbm/Wq0SHWJUN62rx9GKqVDE5
	7k1Z4s9Spe0pzOIYqJe5AxWzyLsbhYQvp9NBLXsFTYYcUMbUPf3x8wMaAAtftpE4Pz5wGFiPncs
	Ll6UneT7Swp8oSXqDs/f6PKvWmuDK0y8OU0COfOA2A0M+1W9hFM3xIdh6v9D711MVR9rfbexqwU
	dH1ICR7Zu13sVaNRRE3KAmYsOhtbFFL4RMfsAdGg4LFwdtm8ZyEdagFI/Hc8/60r2YPNkeDoocB
	TAn7P3hIBQegoWjsHVWlMbMbCGx9llHxO0zibNTDj0xV4cqLTEckKppPd0ZhQes6SMdu4=
X-Google-Smtp-Source: AGHT+IG8lMhmASq0Dqj7DDlPWZpnN/HYg/KOE/R9C95kx5h7OgFdH+Cpax+cHXAeZlu2/w6JZnbdgg==
X-Received: by 2002:a17:907:97d0:b0:b73:6b85:1a8f with SMTP id a640c23a62f3a-b767170ae15mr2977239666b.49.1764317196535;
        Fri, 28 Nov 2025 00:06:36 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c6c12sm377322766b.29.2025.11.28.00.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:06:35 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/7] net: dsa: b53: fix ARL accesses for BCM5325/65 and allow VID 0
Date: Fri, 28 Nov 2025 09:06:18 +0100
Message-ID: <20251128080625.27181-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ARL entries on BCM5325 and BCM5365 were broken significantly in two
ways:

- Entries for the CPU port were using the wrong port id, pointing to a
  non existing port.
- Setting the VLAN ID for entries was not done, adding them all to VLAN
  0 instead.

While the former technically broke any communication to the CPU port,
with the latter they were added to the currently unused VID 0, so they
never became effective. Presumably the default PVID was set to 1 because
of these issues 0 was broken (and the root cause not found).

So fix writing and reading entries on BCM5325/65 by first fixing the CPU
port entries, then fixing setting the VLAN ID for entries.

Finally, re-allow VID 0 for BCM5325/65 to allow the whole 1-15 VLAN ID
range to be available to users, and align VLAN handling with all other
switch chips.

Sent to net-next as it would cause an ugly, non trivial merge conflict
with net-next when added to net, and I don't want to subject the
maintainers to that. I will take care of sending adapted versions to
stable once it hit linus' tree.

Changelog

v1 -> v2:
 * added Review tags from Florian
 * added Tested tags from Álvaro as far as the patches went unmodified
 * !is_multicast => is_unicast
 * only change b53_default_pvid() to always return 0
 * stop rejecting vlan 0 for bcm5325()

Jonas Gorski (7):
  net: dsa: b53: fix VLAN_ID_IDX write size for BCM5325/65
  net: dsa: b53: fix extracting VID from entry for BCM5325/65
  net: dsa: b53: use same ARL search result offset for BCM5325/65
  net: dsa: b53: fix CPU port unicast ARL entries for BCM5325/65
  net: dsa: b53: fix BCM5325/65 ARL entry multicast port masks
  net: dsa: b53: fix BCM5325/65 ARL entry VIDs
  net: dsa: b53: allow VID 0 for BCM5325/65

 drivers/net/dsa/b53/b53_common.c | 47 ++++++++++++--------------------
 drivers/net/dsa/b53/b53_priv.h   | 40 +++++++++++++++++++++------
 drivers/net/dsa/b53/b53_regs.h   | 19 +++++++++----
 3 files changed, 62 insertions(+), 44 deletions(-)


base-commit: ed01d2069e8b40eb283050b7119c25a67542a585
-- 
2.43.0


