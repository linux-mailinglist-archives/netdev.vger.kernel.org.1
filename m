Return-Path: <netdev+bounces-260174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB8kNg6rnGklJwQAu9opvQ
	(envelope-from <netdev+bounces-260174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:31:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432017C667
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E833130065D6
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790121E097;
	Mon, 23 Feb 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8xvZJG4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD8A2853F8
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875084; cv=none; b=Zzz4xbvcQhHlhwF0OFtdU0phqozg1w58E4SzethyTkfLF97TqbIDeaoBrIdJzDukV2sAWmh7/9KwY59kTwFvvkrSEDLOgqqWknLa3irdqQ/ALulojd5FqlENUaOMWt/xeh+3QwJGdGbxB0s2DvxkWrHOwrelkxTnYjO/+K5QWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875084; c=relaxed/simple;
	bh=aBVe1v2zocRrMHCYVLiLkykG1Xp5AP9GVnTPhpkM3uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwDYuz6jnZEFKCqxBmohR0VeY8HfiV0VvzWh4PaIxQTRtjGzqIRrgcJqtAYaReas1WXETxXZSB/13W+M6Y7Qlr2BBbxs6hmGKUP7qHMl67//Mg71qVJyviLdDstZHj6PaZ5X/+s8dinhjIbZUUNkefk0Fxv6DY/ntvZA/aIW/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8xvZJG4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso6186206e87.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875081; x=1772479881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pPKKuwWl8LDWT5PkX05EPu4mdiDlnGWXA550J/Mnwo=;
        b=d8xvZJG4gqG56Z++dQ5/MJnpUHxk2rYCKrTiKq4oLKHMkke5siQz4sxVxcAhGKeYUD
         gRbQglOH7wkOuSqlN9m4aDaOnScwE1FNj/YrvBF2IR4R+BUliZLGUOaypZo/x/vOEAyU
         Xeh4i4f6dIMC576RkFQ8JZhrmZkxrtt7ijMy9Ia+Vtn7qJAKMRBOXBpnPVpQXNfG+qnd
         aX/hNN5FZ753Wa/efqZ4lHhL+gyx+A7z/52BebAXWFd0Y/tYcwL1kMpthBxCZW4Cbhfn
         kbMTTG7th6eu/V34zcCsJ89irdTy4/NKerJjUwqRFrObOgLQgdIEv0J0dpI+I2z4ndhK
         aSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875081; x=1772479881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pPKKuwWl8LDWT5PkX05EPu4mdiDlnGWXA550J/Mnwo=;
        b=kWb2rvTXYZSm9bg7lqCWQXzN3evrHI4kQpaClrZFILzCwiEx8FbV6T3YsdUQTKaz+t
         Ru9tnJg8rBrGhAiYOuq/njss44YXUnVEeQC6IFp03MHrhUFrN0Q8uQpc3qKFdN+Jd1cg
         xEt8Fo1/NlR8RoTQQbUV8l28vk6gJ8XorTaTZyDg+PjioQaSK9O6qWwh0U9gJw/lOAtA
         TJl+8rT5LuilHb5LLFvTgapDwQNxRejmK+RUhMXQVsXicT0oMoZ9lceb3jUdilqdWxSI
         NlZ282LhiAU0BfmnIZOYCsbvcfcWvYsP4NAx4rp+QJTFneDavThno53djLze5Fkf6Lmd
         Gh/g==
X-Gm-Message-State: AOJu0YzPsBAMCyd78ltInZH8L5yyRC1UEDnAcqyBl6j2ZlcJ3BMZ63Fg
	kkiloiciUR++w28Vcmi7N1g0DGZ4kFuIZRJe7TH10qZznUtYeaiR747RKSSHB1Su
X-Gm-Gg: ATEYQzxXUiKkromIkg6LJBNtzZ2QSdKrP1JsLcrAl9cFg2cP5vQGFlFA3igKx5ixqxP
	k4PQl6gpV/hh7SRCyULPRNyq5XmXDjcxI+FZsm3QqouPAf0qOl/CNWIIAP70mVYG1WLiQ0LS6d6
	ibnVDcNXGusJxpIwFBUEUnzt8pKJgm8XJMj+rQcdM5cTAdrACf1hjelZA0v9UR5UvnobmwQe6QM
	Mr7mTlFIblLEubl2DegqvVJhCBrqQwg4ahBs/OgcTIen1+A3PHjFPTLqVpdDSqLZS9f/+K52/pg
	jLuOvFX/WkB0HNy2h90mHBxc0bkGxgZjbkeWf2J5BR4NRCMMFccq1pIvpd8NEUADTRTwl03EEHw
	57UC352FT0bspyqhMesTnt04gc591yzLXC53QMINZzi+Ek+KsizT75wmiMH1DSxf/QQeILVcS9R
	pIzlaXE4WX4peU0L89e1ry
X-Received: by 2002:a05:6000:4013:b0:436:15c3:9163 with SMTP id ffacd0b85a97d-4396f18abbcmr14931725f8f.57.1771868956773;
        Mon, 23 Feb 2026 09:49:16 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:52::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c96csm22685347f8f.30.2026.02.23.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:49:16 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
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
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [RFC net-next V3 0/5] net: ethtool: Track TX pause storm
Date: Mon, 23 Feb 2026 09:49:09 -0800
Message-ID: <20260223174914.74461-1-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260174-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[26];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8432017C667
X-Rspamd-Action: no action

With TX pause enabled, if a device cannot deliver received frames to
the stack (e.g., during a system hang), it may generate excessive pause
frames causing a pause storm. This series updates the uAPI to track TX
pause storm events as part of the pause stats (p1), proposes using the
existing pfc-prevention-tout knob to configure the storm watchdog (p2),
adds pause storm protection support for fbnic (p3), and leverages p1
to provide observability into these events for the fbnic (p4) and mlx5
(p5) drivers.

Patches 1-4 are ready for review. The series is marked RFC due to
patch 5, which has a few open design questions:

The mlx5 tracks device_stall_critical_watermark_cnt per priority class
(8 priorities) in the PPCNT register's per-priority counter group. The
ethtool_pause_stats struct exposes tx_pause_storm_events as a single
value. Patch 5 currently aggregates across all 8 priorities. This raises
the following questions:

  1) Should the driver report the aggregate across all priorities, or
     only report prio 0? Looks like the current reporting via ethtool -S
     (tx_pause_storm_warning_events / tx_pause_storm_error_events)
     read from per_prio_counters[0] only, if my reading is correct,
     reporting the aggregate in the new pause stats path would create an
     inconsistency between the two interfaces for the same underlying
     counter.

  2) If aggregating is the preferred approach, there should be a fix for
     existing ethtool -S reporting to aggregate across all priorities,
     so both interfaces stay in sync?

  3) The per-priority data is already cached in per_prio_counters[]
     by the periodic stats update (DECLARE_STATS_GRP_OP_UPDATE_STATS).
     Should the pause stats path read from this cache (zero additional
     firmware trips at the cost of slightly stale data), or issue fresh
     reads via mlx5_core_access_reg() as done in p5?

Feedback on the above would be appreciated.

Changelog:
V3:
 - (P3): Fix checkpatch complaint about line length in
   fbnic_mac_ps_protect_handler()
 - (P5):
    * Aggregate pause stall stats across all priority classes
    * Update commit message
V2:
https://lore.kernel.org/20260207010525.3808842-1-mohsin.bashr@gmail.com/

V1: https://lore.kernel.org/20260122192158.428882-1-mohsin.bashr@gmail.com/

Mohsin Bashir (5):
  net: ethtool: Track pause storm events
  net: ethtool: Update doc for tunable
  eth: fbnic: Add protection against pause storm
  eth: fbnic: Fetch TX pause storm stats
  eth: mlx5: Move pause storm errors to pause stats

 Documentation/netlink/specs/ethtool.yaml      |  13 ++
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  30 +++++
 drivers/net/ethernet/meta/fbnic/fbnic.h       |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  11 ++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  46 ++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 111 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  27 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   5 +
 include/linux/ethtool.h                       |   2 +
 include/uapi/linux/ethtool.h                  |   2 +-
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 net/ethtool/pause.c                           |   4 +-
 14 files changed, 256 insertions(+), 2 deletions(-)

-- 
2.47.3


