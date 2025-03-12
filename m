Return-Path: <netdev+bounces-174326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863BA5E4C2
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324E8189F801
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6B120C47F;
	Wed, 12 Mar 2025 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XKBh4GFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220E1E8346
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809120; cv=none; b=FZpiiPQsMme9+RocqN0/6tFfIINp0PwisHEJJW4gHO5zALYFqC3x8CGUOnso2SLupv4In78U7+nBZN/11XVd2mD7Gbh+YWagRBPWjJjOXQb4g99E4TMEOw1f/l88pj0VyNepBmVWBXSZc2whw/rX74BvYwn7n5B6d7b7EqeCmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809120; c=relaxed/simple;
	bh=Q2k9GPayWeUHQsXcs/86RclA5d1uasfKBhsFAaw3N6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L8PSV2dDzArl1226gs4E0anFNyDosEJ3z7B28dPe5MS2GL+j7q2su0wOvsXWDXznfnhe4W4flLZyUSc/Jgz9WB3xbmGYuJSwOfLoILi88lHXlPtgw4MrGWjOFMtaLmG0os6m0j+snPoMesrHlbfSlbnTTTE/3D2NHit6Zkh9LyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XKBh4GFt; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2232aead377so4969135ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741809118; x=1742413918; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUXQmTabTFlJQTznKZdaGRe9l01Y+yauh4zh2Ba8guo=;
        b=XKBh4GFtQCYph1TcPaoHMx/aS0kPOPGy2bz3gEQfe7/Am5jsZSqu2HIx3lm3sN8Qbt
         BYRTRqeMBEPJhg7bbdHL2mmOfojYsV05s56KcpqY3N/MvjMKvVs4DxzALnDYb3wPOZiF
         /hO3Bpn0YmPt0Svnob5N9iwjmB23DFfA8Sqf0AkOhvS6weuCK8DyRDm4PG/5cPs0loMu
         CExrPDjVbwwbtJ+jAF1FDm5aMzQQRpGvIKNv1jMji6zdVC7eqXQbDdCjBlKT9fgVWrng
         tIiNshqy5NTKtRLmcb9WpqyryGmzqhFBMmu1CYgdyUkiZmSP6K6YaPVUSPy49ewEfoln
         NYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809118; x=1742413918;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUXQmTabTFlJQTznKZdaGRe9l01Y+yauh4zh2Ba8guo=;
        b=jlrgQMlXa0Z0m5AgOO8s12R5onXDgNyhO1VqrNBRmhSu3tFmdU2BP+2nk8UdkhfNCD
         g4cxJxuFHyijFYqJmIXeZjpMgJM+kxHKyRCKOyWKK2S6S3Ln5SrXQMyTJtYHNSmuKqjf
         rkVx+7KLD2Cy0kzOQROGZqSA1RRbdI0MuBjBb6s26k0Awcck/sVW1oIVF+tV8jBch4gK
         L1J/eD8ny+FVqhkEhyNxxuUuFAb0WZeOHJTwWwvPLRufSbNaSM4Excaji2bVZc+fhBr9
         ixThjwRzP5COVStM55zoY6zK1zjPz4Og0OO3AmWcK+oRkrmCuB1aDvmIXnS+JKr1dOEa
         5P9w==
X-Gm-Message-State: AOJu0YwZUKz+Io2J9RgAaEhtMwWGZoFMYkEfRz7nzALe3B+urit8GF8R
	vU8JXmf216gwUcD1+XDrG1kN6tqWp+Fw0lftTH9FYYjclXkc9ovsKD+bdnxCwMqMQIJE0RlT4gw
	rnN47ZMZ7EkjRmiTWWbAWORqiQAXKbateToakXl8uvdd7gNHw
X-Gm-Gg: ASbGnct8TGliX5ZpvMbHzTtzXkWzrmknH4TT/E4743ud2H90R49bYx/z7OZ0crL01MT
	2x/pRmopUkQggwXK9xMrWqfSHPfzQewm+0/wICcs0WKEa2G/62Up781jcR2uOd+7cMvbC6OsmYH
	yZ7z2Kuq0Cp7lu1sHeXb6gk0UBp4H4pR9/zBKL9iHZvF16wPF923YsOKABAERMVtwNQQSc00kfl
	VL1G6IowLQlW2ruudOIt4FHt3n5J9bI2idnqu48nFAV1eV5JBaWdCkln7185MysuairnxB65zQj
	h/7FnlZUW2UQOq/Vv/AB53hfLz4bufRW+Nk=
X-Google-Smtp-Source: AGHT+IFzTFpDmJydmC2PtlCdpNTNUDU0mgSO+UfsIg00y4eEivOM8oFExNu431q+A3hE23lAesqPTs6l6uBP
X-Received: by 2002:a17:903:283:b0:224:194c:6942 with SMTP id d9443c01a7336-22428bded4amr373642295ad.34.1741809118152;
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-736c8d701absm632789b3a.12.2025.03.12.12.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:51:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3CF97340328;
	Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2C718E4044C; Wed, 12 Mar 2025 13:51:57 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH net-next v6 0/2] netconsole: allow selection of egress
 interface via MAC address
Date: Wed, 12 Mar 2025 13:51:45 -0600
Message-Id: <20250312-netconsole-v6-0-3437933e79b8@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHl0WcC/23NTQ6CMBAF4KuYrq3plP6oK+9hXJQy1SZKSYtEY
 7i7IyuILF/evG8+rGCOWNhx82EZh1hiaimY7Yb5m2uvyGNDmUkhtZBC8RZ7n9qS7siVNyBQhr0
 Fz2jQZQzxNWFnRnd0++rZhZpbLH3K7+nLIKd+DRwkF1xj0FjrYIQ2p+6Z8Td1V9z59JiwoZoDe
 gFUBEAlXQUBLBwO64CaAWAXgCJAeLMHj8ESsg7oGSDFAtAEKIcuOAsN1uEfGMfxCzHJLj93AQA
 A
X-Change-ID: 20250204-netconsole-4c610e2f871c
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Simon Horman <horms@verge.net.au>
X-Mailer: b4 0.14.2

This series adds support for selecting a netconsole egress interface by
specifying the MAC address (in place of the interface name) in the
boot/module parameter.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v6:
- No changes, just rebase on net-next/main and repost for patchwork
  automation
- Link to v5: https://lore.kernel.org/r/20250220-netconsole-v5-0-4aeafa71debf@purestorage.com

Changes in v5:
- Drop Breno Leitao's patch to add (non-RCU) dev_getbyhwaddr from this
  set since it has landed on net-next (Jakub Kicinski)
- Link to v4: https://lore.kernel.org/r/20250217-netconsole-v4-0-0c681cef71f1@purestorage.com

Changes in v4:
- Incorporate Breno Leitao's patch to add (non-RCU) dev_getbyhwaddr and
  use it (Jakub Kicinski)
- Use MAC_ADDR_STR_LEN in ieee80211_sta_debugfs_add as well (Michal
  Swiatkowski)
- Link to v3: https://lore.kernel.org/r/20250205-netconsole-v3-0-132a31f17199@purestorage.com

Changes in v3:
- Rename MAC_ADDR_LEN to MAC_ADDR_STR_LEN (Johannes Berg)
- Link to v2: https://lore.kernel.org/r/20250204-netconsole-v2-0-5ef5eb5f6056@purestorage.com

---
Uday Shankar (2):
      net, treewide: define and use MAC_ADDR_STR_LEN
      netconsole: allow selection of egress interface via MAC address

 Documentation/networking/netconsole.rst |  6 +++-
 drivers/net/netconsole.c                |  2 +-
 drivers/nvmem/brcm_nvram.c              |  2 +-
 drivers/nvmem/layouts/u-boot-env.c      |  2 +-
 include/linux/if_ether.h                |  3 ++
 include/linux/netpoll.h                 |  6 ++++
 lib/net_utils.c                         |  4 +--
 net/core/netpoll.c                      | 51 +++++++++++++++++++++++++--------
 net/mac80211/debugfs_sta.c              |  7 +++--
 9 files changed, 61 insertions(+), 22 deletions(-)
---
base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034
change-id: 20250204-netconsole-4c610e2f871c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


