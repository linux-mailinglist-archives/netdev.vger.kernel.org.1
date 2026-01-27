Return-Path: <netdev+bounces-253656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMjCFlIeeGkKoQEAu9opvQ
	(envelope-from <netdev+bounces-253656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:09:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D421B8EE3B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D502F302B51D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89572BEC43;
	Tue, 27 Jan 2026 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUHuuODN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B643284890
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479745; cv=none; b=H1n38sRSic8C4gOsq29qURPnRVX0a3ozmCOoFe60S564mqNF++JiUKp9UBLSdf+bKWuU2z4jbjlOK08K2+NrGObfcgIdFjAk/COzONMNNd9ngCHGlOsu5szOsjmJtL0K0ld63ZhGbufBcYFxa+YwDv2VxL6X2wZjTcNbynvr9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479745; c=relaxed/simple;
	bh=hlr/u6OSB1ld/maQM78jagON3c9o+2MplWv+F++9Bjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4V5torFHYLJH1s0egVXTujSqbg9Oo/xRy5nZnPePnUMWj090Vx+0JyvfxTjvW4o8ByQy8i0JBSslNeaaTk1zABXBUraHDE33Ob4hCZLld0ARvk4rAoAueJV05OqBmDrEcQ2DjLvmlUCj9LYfVqnd5/CFZWvlaWz6tSAYfBLk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUHuuODN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso2769401b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769479743; x=1770084543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRqI3EYnGEVaei8c3HWyub0Uf95BjfkFkPwdlg2GbA0=;
        b=cUHuuODNyBGQCF/+T5xP6PZ3HxlSBvxxRP9tbJ4jh0ki6nTl0RvBzAMjorVwwZSDMR
         gUnJ05CqKszJh8W9baUe664cfhc2LNIjkE/yHjSRwhV1LXv/7x3sEdYAlN3yWpGghO7q
         Kq9ZTc6gc8Z9ZIM6yz26P/BmgniH4vM4C6sSvXHZPEN5tq2LNHFTy6p/vMC9VZiH+7Ew
         cBIjpmB9CcM3TlWPftUacZbU5i9kYkpZ8ADxhW4LBHLqWdr2Dd3OFPWWYOUQ4aKyI/yP
         qR7KpLkrhWFUQ1W3KCtgtxsR+HQ6/j+pLmE/RPzTMuaq3Hdiv3aQ4WZlXOXDMTduCmsO
         2kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479743; x=1770084543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRqI3EYnGEVaei8c3HWyub0Uf95BjfkFkPwdlg2GbA0=;
        b=dkPBP+DiXvXcWaV7iF3ZHC8K324qVebn2OD4lMnPhUgm9EBbtmga/kXi6Pz+mTMkjr
         DimzQI2SObL2xhMiZr8SrNIQdbolztA+ZAXlnQco5ArV485Oxi6wmDwCz7ymZH2KRC14
         HqbiIx1fdRFpdZz0qTCcF+DduXvBTvVuTPM0V/B2GKkabOtZIRNxFKXWhhYqlzYz0q2N
         Db4/RYqsERj1Z3aDTKvFfjFZUnol4VjnRb0JAkWj2CRxkGVNDnRB08/Cd6gdeR23FsTF
         Q/Lhylud0pE6F+0Sh2bc+Z6uwAfAKLLGORlwlp2fC0tgRMzfKvzcThsFWDqfddFZ7HLV
         sbOQ==
X-Gm-Message-State: AOJu0Yxcx78QXCYPOgIoPNVG6SXf5STyhUfzxW8ESLGbsgfF9gyMLNNQ
	IYsXAo6mmSJ+banPsqqNeOy5uaLOyWqQ7KFWK26xMtz7RNniax9CMl4S4FAvKg==
X-Gm-Gg: AZuq6aK0gjK+6zEsTwb3xUnSL+MRmJDXf8i+4uQ7fdLtcRYjtU0gQtk1Hkem0gBi8mU
	pN+9tya3P4D51scdY06vWOJJItxGOIQ9667iPcZT+ZleApVnJU6tiMnHkAtILuldWr9MTnp1MGv
	LztDQlMrA2gACkLSv4RlUrCUgmIMk3G2Hqf+5eORay7K14NRz1Kx3BFMz+1jCI5s21zTYfDs3an
	XCzPmoJwAK1hRlIPHtv6OApDYPI2irw3ygBVEnVvpgRUwka9I1b6RQn4qX2iFR2kD/vVKJIwtrs
	qsumyCrSFafDr9u7B+Sly7v6tmVKJ3bIFveTqCYDc1D1s9MhMyUAjrwTLqid5mhRUHaOeCvbVYp
	s84BgOryfI10x6d62wAfWxiGQUjMDjbzwZ5rr972hPCv5LoRyLFR/Rd24UngxvciEAQrS9c+SCB
	tANRryCB0pq/SVhJeaNmyer7E2LJ2oNWZHj24pfm+VRnS+UwurPwwcGw==
X-Received: by 2002:a05:6a21:328c:b0:38e:9405:beff with SMTP id adf61e73a8af0-38e9f1f2a9emr6674893637.65.1769479743515;
        Mon, 26 Jan 2026 18:09:03 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f613fc36sm693540a91.10.2026.01.26.18.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:09:03 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/4] net: dsa: yt921x: Add DCB/QoS support
Date: Tue, 27 Jan 2026 10:07:57 +0800
Message-ID: <20260127020847.1482724-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253656-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D421B8EE3B
X-Rspamd-Action: no action

This series add DCB/QoS support to the driver.

v3: https://lore.kernel.org/r/20260125001328.3784006-1-mmyangfl@gmail.com
  - fix port_del_dscp_prio()
  - split yt921x_chip_setup()
v2: https://lore.kernel.org/r/20260122194233.2777550-1-mmyangfl@gmail.com
  - make DCB support optional
  - refine with enum yt921x_app_selector
  - add missing dscp_prio_mapping_is_global
  - fix pcp support
v1: https://lore.kernel.org/r/20260119185935.2072685-1-mmyangfl@gmail.com
  - rebase

David Yang (4):
  net: dsa: tag_yt921x: fix priority support
  net: dsa: yt921x: Refactor VLAN awareness setting
  net: dsa: yt921x: Refactor yt921x_chip_setup()
  net: dsa: yt921x: Add DCB/QoS support

 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/yt921x.c | 305 ++++++++++++++++++++++++++++++++++++---
 drivers/net/dsa/yt921x.h |  55 +++++--
 net/dsa/tag_yt921x.c     |   8 +-
 4 files changed, 337 insertions(+), 32 deletions(-)

-- 
2.51.0


