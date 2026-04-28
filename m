Return-Path: <netdev+bounces-281809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL98B3ie8GkRWQEAu9opvQ
	(envelope-from <netdev+bounces-281809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB44842D2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E04031584BD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D53F20E3;
	Tue, 28 Apr 2026 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj5zXB8+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C83EF0A6
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375596; cv=none; b=JkHala1ih5LRYq0yT/6+c8Jh7RLdugurKJfWRWJwqePfR7lZkgdIA4fWugvaT2ux1hq/cOWlDuIxAz/bJRgk39zpMAACr1v4Wxvgf51cOEmw80w3Y3Klf9zin31ApuKf3CzGOESi+aAWWrhMXDFpm1E2uoEXbh0q3lJtBRZoWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375596; c=relaxed/simple;
	bh=9x/xPm6sfqi4fADWMtba7HyZly1IbVvGlQOEFbze3TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNMbIsmBTfsWikxdgQbLQfbA8mtCvr/sAP+s/DFOjeY5d+waUDW8sZBRXp5Gx2YaTvnyouWMyvhUO7NiUqEYnep0zve/GSaPIf2bn0YC5oRaiJMXcZmx30utk3UAgoUvi8PzAOWrDyBMD7KdvY0pRScBAPaV84upEGFSlEe4tcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj5zXB8+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f8cebc935so4883094b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777375594; x=1777980394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/x4zmdzI0JftaychPcefl7/Psy7YcbwkOR8YyysWDE=;
        b=Cj5zXB8+Xzd0mKiADY6DY7wY8iLymopyLZW1m77FBsi1r9x1XVecH374yQ4/9kbImm
         U7Kp7iDLMIT8wTZebVnyAX3xiwIMJtNS9OHekFF9fVGPIOWvO/Xv9/kwh7itaXtmhLtS
         D7JyyNKadtOxtqaqT/gA52oHlAaDdIayqN+eOiGU8Xz5PQFeMAP2lakduKBOsnhOY5fj
         VsLzXB6Texv7aMCb45Lz5Svb0sHUYI5LMvdcDlJGUV4k0qnJPkUBmrXut2hHFyYZ6sYh
         uZeBWDB+NAsGafUP7/7PcV+HbucRhN5+FmYoD0u4hIrHB5AVY5jCJyJ1UqhTKiajRjgk
         MrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375594; x=1777980394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/x4zmdzI0JftaychPcefl7/Psy7YcbwkOR8YyysWDE=;
        b=LTX3YB/jV2oE6CbqAMxiY82U5QZusmpmDryfL9XKA+vRlRuszMLECZBiPk5iGO3bUF
         oa3NMGUdrnI+RHuJW0RGo+fw4tkDlLWcIrqt5na+R01/kWp3qHSabFd0vQCuQuaOL9Yl
         ttWHLB1OuiLzD2h2dN9c1D2oOI8i6TWgW8m9Z9UYa7J0VnzCLWDrxi4t7Uey7HD4v9Hp
         l1oybg85eUNFlmea23YBws4wlrcz2QCdFqwDFcZbYkTDubcrhd249vo/pKDswSDtrhhC
         VPrtOKQKTqkbuvK+rfr+0rTB3sIT/U4S4zId+zARfRkCFe7m/j1ZD1rwjOuAujXPp+7s
         j/Ng==
X-Gm-Message-State: AOJu0YyswjEwHSbh1VdECCuM7oELIjHGfR5eYq7un4qmvn3LqCiHwKOZ
	prp8ruB1ZP7j4c9598rxvxbcMS3kgtC1zNrA4EfkBcIDJBtIvCBgxdghEolHGhqT
X-Gm-Gg: AeBDieu62JscyBBpH5oEqXzhPYs/jrHYN/r1Rjpfq2TYg2DIygHbpifIQVTf41uLL5m
	5/DqwfsAngoaFCBAZLb/3FPURzmA51ZUD/Ra/nWz83OkbG5ij04Yf0uX5H7FGzt9zQQwB/XfTTV
	BDpFL1rcBhGYI2gpYViZuTkmQrx6TVI/SpK4wNrQqTImq5ZWgkJO1nWbm5u/dzw09sMHr7JUC7o
	QNrOxpwLphVh7iDz7qaidI0tjwcLlwrMY6nrrPoeLdvWeHrQZ3VzIQXv9ptefp2hnfB5jHheiQR
	Aj5XZ0rgQAaFcuYo1h0YToK7s7FlKCIyByhnGmGWdoC66Kl51o1L1ba8pmRyeh0NYKmfn3tgks/
	GsYWtW9w1Hbef5aAn3+tSiVF6eks8BGXCyaKf9Tmf/SCVVYjYBJuSr0u190oBzlHtc0fhxOXwmi
	VNaUtkAjosIQhdGE+V/9+OIN3+qpYHY7IBjFgWPlXQUwXIe3NamcNQMD+U1zND
X-Received: by 2002:a05:6a00:94d3:b0:82d:5da9:adbf with SMTP id d2e1a72fcca58-834ddc4c171mr2905170b3a.41.1777375594326;
        Tue, 28 Apr 2026 04:26:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae36b4bsm2284327b3a.27.2026.04.28.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:26:33 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v5 0/3] net: dsa: yt921x: Add port police support
Date: Tue, 28 Apr 2026 19:26:00 +0800
Message-ID: <20260428112606.1917230-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5ABB44842D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281809-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

v4: https://lore.kernel.org/r/20260409171209.2575583-1-mmyangfl@gmail.com
  - split series and drop patch for qdisc tbf
v3: https://lore.kernel.org/r/20260407160559.1747616-1-mmyangfl@gmail.com
  - explain long registers more accurately
  - fix missing packet mode flag
  - rearrange function layout, in preparation for further patches
v2: https://lore.kernel.org/r/20260402223437.109097-1-mmyangfl@gmail.com
  - refine commit messages and code styles, no functional changes
v1: https://lore.kernel.org/r/20260225090853.2021140-1-mmyangfl@gmail.com
  - pass extack to user tc policers
  - keep reg64 helpers along with reg96
  - avoid macros in favor of functions
  - adjust log messages

David Yang (3):
  net: dsa: pass extack to dsa_switch_ops :: port_policer_add()
  net: dsa: yt921x: Refactor long register helpers
  net: dsa: yt921x: Add port police support

 drivers/net/dsa/ocelot/felix.c         |   3 +-
 drivers/net/dsa/sja1105/sja1105_main.c |   3 +-
 drivers/net/dsa/yt921x.c               | 485 ++++++++++++++++++++++---
 drivers/net/dsa/yt921x.h               |  87 ++++-
 include/net/dsa.h                      |   3 +-
 net/dsa/user.c                         |   2 +-
 6 files changed, 509 insertions(+), 74 deletions(-)

-- 
2.53.0


