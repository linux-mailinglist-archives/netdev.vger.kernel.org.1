Return-Path: <netdev+bounces-305304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cU6+LTOiTGp8nQEAu9opvQ
	(envelope-from <netdev+bounces-305304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:52:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7CF718265
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:52:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MMNKEoDr;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305304-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305304-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 543E0302BB85
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3E9376A09;
	Tue,  7 Jul 2026 06:50:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774473AE707
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:50:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407035; cv=none; b=OslLoItYodqY0CQVQ8UwjhP55DT1HhUaAyfutkEkJsZuh1O6Q00Wy+cx9Uph63aTjQ5hPvFhZ8VPPEjjT1PhqGFiTmR0AyJ3uBjPJEQltd4hDl3GTwum0skfOkT9hIRHcDj1ubYCJ/vsNtXDQlnrLO7TqIPRfBJl1hRxlNePgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407035; c=relaxed/simple;
	bh=u7/R5ZF6iojuieduxQ1kZKAMdMfapJLTuakkH9KTNNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWRTdYang8mvUYSq1JiBDspoHMTQunMHFqsBLaXHP5a8B7xxvVsemOlLrPSXsvnc9jLNUR44VlCKNzC0QhM7jFpezLEBYIjWmx62XzNJIWcKnNipkKqNplByO66eYUuoqt/g3KgDEe/8g3zPR3PK5Jp8JGvVaisVqBP2iL7Uf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMNKEoDr; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384c94c9414so2046744a91.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783407031; x=1784011831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WZp1okN1FSLI5ciZ2eCbXzK8E3+Ga26+HWqnOPaOQVs=;
        b=MMNKEoDrB2b6WekE/wZBySP/v+2jHdxWegfZPVjEy0pszeZXlJWJ6Si8nhsqUzQ1KH
         A/a3sSKIOWaODV6RiYlwX1bw2jOFzGx6k0qSAad1g0EPFPX5KY0Zxx9ZhTKpfII9rTtS
         7wGtzxJIGtcSlR/ln8KBxTj02oIOt4JZwQWAg26HZGTfuobAOvsDiY43AIUgFV8QCJcA
         cG8zQGFy+iB1g6KngNn6tEi+eVvb91/BCrP53epLAfDhdWY9un15d3mC99Gcnlcugthe
         RE943F6R7kiZodjkqpi1RYJ4v4+5RRzDwM3Xw8QRI7Gdi54Hm+eVphLiJGlfTN84iXbn
         StCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783407031; x=1784011831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZp1okN1FSLI5ciZ2eCbXzK8E3+Ga26+HWqnOPaOQVs=;
        b=MJtEcq1WSUzjWttAwN0xTXXJEWjGA9sZ7LxoHxdpkjMuAsx1A0xKdFQSq6KfDfh1tF
         gdxpWNoZ6AEnGcxT/drqNP7y+YD6EInxXpYYf4ps+0bboa4gO6B/aAv2SklkkXmJScpQ
         V8b0GwuY4Gq9St+biKkKzJey71VUe/MtimBOZ6IXfS3jxTT9q7kkO4a2WTwvxHGJK0fq
         depjpT+7Z5kRmv8gPVqO5ELodObI5xHhcPmU5HVsXUuWZJ8pvmw7W945tyUBWXfbV24p
         tp1W/ZHvNawPHfjyTxcixYITDov00qVRDlLXj2QaAzvYx0T8dd4ZarAF2OOTUBjcWIMU
         7qhA==
X-Gm-Message-State: AOJu0YwNB7YytmzO8GXWfKpgQ1kbqe57ecnzTnuNDX1Xkt80szaU6Nn/
	Ay+tuTiLQxNvSszTPBR4OxxT91oP9U7Mbcd98wD172y1omswVK7cgW8/9f53rlsd
X-Gm-Gg: AfdE7cnDn1ILcKQo5IMmdt3h1kM6zuv7CAJ61geb+Fb76bjfGBElonk/HaBr7Q9nqIS
	oSvjKHuRLln14b1yXTvvXXy9MaXr6ir+HGsA8Z8aTHPVTNAo5VwRNfhJZlVm0u8AUL7ctEGHC2K
	vlEwSAAKC0/3dGxaIrZDyh04sFOZT1gg1V4awQ46RKeY9wuk95ccqg+ONE6j60gKq/+Wha2N91Y
	ESwYaSLyEai8Y37Runo5BYmOqwqRME9r1EkgMZwFl7aAXw7JNDWMvIICgAnJT9JXPedwQSSNenf
	AUDhu8jDETTqw9X3jYiR+UeTiikDO/NdqRh8GjKTZLsY4GMs6HAnE54kpEQXIYGsGYfW9ygYF6p
	iy9ONHC9mCX2U/lnlJ8ocxEzOtnxCFXdADJZr8sY1YlwdK/O0ngQ+/5LfwLHxrM9XLv6FKSFnEV
	BuFNw+CNiEB+kbpeR8XIryWjo5jpp0DXclt9v7rECyKDEx2+1Ls37LX3/5eSA4cA==
X-Received: by 2002:a17:90b:52c5:b0:381:dd0:94e6 with SMTP id 98e67ed59e1d1-38756fc9234mr4464471a91.22.1783407030818;
        Mon, 06 Jul 2026 23:50:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d17e9ff3sm540698a91.7.2026.07.06.23.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:50:30 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/3] net: dsa: motorcomm: Add LED support
Date: Tue,  7 Jul 2026 14:47:47 +0800
Message-ID: <20260707064752.1030345-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305304-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E7CF718265

v4: https://lore.kernel.org/r/20260703165241.542195-1-mmyangfl@gmail.com
  - fix some reg op typos
v3: https://lore.kernel.org/r/20260701155519.273212-1-mmyangfl@gmail.com
  - fix null pointer dereference
  - support polarity auto-configuration
v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
  - allocate LED structures only
  - eliminate double locking
v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
  - set up polarity correctly
  - do not set up .brightness_get() to prevent dead lock

David Yang (3):
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Add LED support

 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 222 +------
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  14 +-
 drivers/net/dsa/motorcomm/leds.c              | 615 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 121 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 +++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 1033 insertions(+), 220 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (96%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (99%)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

-- 
2.53.0


