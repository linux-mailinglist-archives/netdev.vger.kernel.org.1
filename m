Return-Path: <netdev+bounces-257705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nkOmFBGqhmkrPwQAu9opvQ
	(envelope-from <netdev+bounces-257705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:57:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3474104B7D
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41773301D6A6
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B9632ED43;
	Sat,  7 Feb 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIt6/8SU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AA22A1E1
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433037; cv=none; b=UY2RItyUxJonnrKingI8PNahB30osrwci49iOVCl+6fuCnaVEcuelWkE34GUJ/QEZWiLwQTAz4vjkwjnuRNfA8R82dBH2U1uBEyWKVJE5xlo0LOEep04fNqZ/FuMJj/FtQGgh7+VfgdGGDz/kUKGpX6bwIJSv//Z3C2pKJifh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433037; c=relaxed/simple;
	bh=F75+iwxlRTLyIzKuJzJ+ID7DQ02GZVbuxnZkr4FlfjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGDZfwGDz/F8UhUSFAqN3bESZptUeyA0UDIN0TtK6X9ea8yDP9OScQp4cXTBVGHP9A6nKsEWmCWJZtwJfOf4dmrJP2eFWFUTDPCiOaceV1Wxh8gt4T7aFfU3ZJYHCTaZKcnZzNJkGI1E/6nvmDhB/bdc2OaLV56nRhHIpmjo98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIt6/8SU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43626796202so1858120f8f.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 18:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770433035; x=1771037835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nV2/pR09fRCKiwS6HhA3KDDNoxylvhh0vYo9VwjMiO8=;
        b=OIt6/8SUyXuH58tiM/6XHW8F27w+nWmLv1HVm7n73tqWuT47/1gj+0gufTEVVOSC3q
         IZubAqZC2e2REphLGPmirJCGfNCg3CTam5T4d4Q5iCMiEnwjpycnu04nFrpSrfB4SEiU
         nyE7IG377A9P/KdR24Ovb7lps342l6M7MC/FMG/5XW/Xoh4BPgs4wzscuhPxt/7b0D3g
         AiJzxuthST9NRmZRg5TYxMqjnf22aS0E/lzhgPR2nd4aKmR1jdqCfEW1RLbDbhWohENV
         yna8EUsF0g72iUpIowAUsxLqEGkOdzxKe+vXwyXq+xr9SihVpwBLzNH14jWMTxVkLQLh
         ffDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770433035; x=1771037835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV2/pR09fRCKiwS6HhA3KDDNoxylvhh0vYo9VwjMiO8=;
        b=lfakk+5NL/w0f/Jo89gOkNijTl1PudZfcHrkyogPtxhBBr/UoWz2Jjs0tArTVhqOA2
         UyBYl4C5ay6R/AH7RDabpY4aarcF99Q9aLQUwfEajqFQcoFAgLNUSGctrw+oZMqvWUrY
         HCigFMiyjHHLApLDHwQs6jt0y8WsdReIdZbllNZ6KdTvDN6t1DJppmyrs/dtO/fuP9KO
         tVW8rvWsz5oXGC+7bMG6Qt9cBYecjTNbmSfkv+ZO097dF4V0zdZC+3jvQAPrRMIoht82
         drOt/2SZkYTRNbFKxU0KfkVRN34ZIYTHgIgKuqxZz8qoq26Obzt/VrhIDJgyb1DUavsD
         Ox8w==
X-Gm-Message-State: AOJu0YzaU2ccmRvI0tZ2p4x6jMMbwoTVeIFo0kj81lguXUx6JWgB8U9s
	Pd37xtT6HLDA5Ij2B+jqQwXxLDKASB49xsJRvZ9UAoLBrLFi9JKR8GUnwZ9JoUfm
X-Gm-Gg: AZuq6aKr0Z/5+gdt7xk3cPdG7mNdrKTUp9X5EdHfComsCDMgCuz9zWcFdN+wqGueFdv
	jn3YsAyIzcT3rkNmUCKVSVbkd86xkClRpWuqAdzYlhJwVGpRDYSmJeuSTntvvmdu6fd2MZIezKK
	xCe059KS8elYw3rfntJxW5YZnFYfjdpMVWltX8JO3oe2LQg20D5t9MwTLAf7AWGiU6HLTFiVWS9
	FS/1Vpe4hJUkBA1K5wBNUGzzsVBgsPbzWPKoL63BYCE7vRn1qSDhrssblaJpLgEiFPDFltxNddy
	NnaESeNovvY/sEmE2WC1dhGKvhU7bhF3YTd9/6OsEo2VI+6pCkn5Q0wfM82Z8rWvmfA92mWa3Ks
	qMqvBiMf2NhWVqRSWzjTdg2grW5/PU6/nuqP/iClF2+DJwAVrN10xRQtqzV3ataCCsSFXItmr30
	Bz2a6kM3d/
X-Received: by 2002:a5d:5247:0:b0:436:34e8:e665 with SMTP id ffacd0b85a97d-43634e8ef4amr189103f8f.54.1770426329243;
        Fri, 06 Feb 2026 17:05:29 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd4a1sm9576013f8f.17.2026.02.06.17.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:05:28 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V2 0/5] net: ethtool: Track TX pause storm
Date: Fri,  6 Feb 2026 17:05:20 -0800
Message-ID: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257705-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3474104B7D
X-Rspamd-Action: no action

With TX pause enabled, if a device cannot deliver received frames to
the stack (e.g., during a system hang), it may generate excessive pause
frames causing a pause storm. This series updates the uAPI to track TX
pause storm events as part of the pause stats (p1), propose to use the
existing knob (pfc-prevention-tout) to configure storm watchdog (p2),
adds pause storm protection support for fbnic (p3), and leverages p1
to provide observability into these events for fbnic (p4) and mlnx5 (p5)
drivers.

---
Changelog:
V2:
 - Clarify pfc-prevention-tout applies to general pause, not just PFC
   (P2)
 - Add pause storm watchdog timeout configuration via pfc-prevention-tout
   (P3)
 - mlx5: Report device stall prevention events (errors) in pause stats
   (P5)

V1: https://lore.kernel.org/20260122192158.428882-1-mohsin.bashr@gmail.com/

Mohsin Bashir (5):
  net: ethtool: Track pause storm events
  net: ethtool: Update doc for tunable
  eth: fbnic: Add protection against pause storm
  eth: fbnic: Fetch TX pause storm stats
  eth: mlx5: Move pause storm errors to pause stats

 Documentation/netlink/specs/ethtool.yaml      |  13 +++
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  25 ++++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  11 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  46 ++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 110 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  27 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   5 +
 include/linux/ethtool.h                       |   2 +
 include/uapi/linux/ethtool.h                  |   2 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/ethtool/pause.c                           |   4 +-
 14 files changed, 250 insertions(+), 2 deletions(-)

-- 
2.47.3


