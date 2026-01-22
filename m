Return-Path: <netdev+bounces-252506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA0lMuV4cmlSlQAAu9opvQ
	(envelope-from <netdev+bounces-252506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 268BC6CF6D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9283011C73
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C03876DD;
	Thu, 22 Jan 2026 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmHDkoAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AC38B7D6
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109730; cv=none; b=H8/DTekS7g65264i7FbWwYR0xIOnbt/1EAr8AslsgUTOsoL+XtsMt1rVrvvnM917U17I/wUXSoPe8xFKp5vbnYqA/72h2uGZMYTsexUChHC1uYbu2FwipHO4q3TqxSLRIi4t4LzyaL9z9hUFE5kj2O0yqvD0z1qQOVpkCp7xvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109730; c=relaxed/simple;
	bh=JHZZBjfd0k4akGwR9QjDZL7FcaSaoCNeekSw6jdT6fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDMouzUhdQIsGKW03DrvENHdlopPVuFFSopLRNKKVlwnsnUXkk7/PSvJb+Uota95h4fr5CYttXaCpbQiPX3TqrYcP29ZvscBFan2IDiz5vBGs3dSwZc5euEWHQICQ4BBp1WVHmc8jjzNbLOXoCm3ZXJALfljM+yfXR972pWz7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmHDkoAp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so15469345e9.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769109721; x=1769714521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ch/3j+Fdie5zbCWlDCqsejfooDG5YNJvTZmyQkky8BM=;
        b=HmHDkoApmKHhMBG11CfvpUepaOcUsHIPYC4RNxGS3rE4Pw6p9voyrX0Cln6a8u1Pjb
         TGMLzoyLOZhCXJW9Qzr6rG2vK3pdi4kXCH1xcA04k52JS3ocF0hwVTptmEKQRD27DuBr
         xcoaux8Wm76eDl6f9w1WT2NPvCOdGlXoX0KNrzUt0iA9AQyDaJCCPKd/5jO8qfWXN6Cz
         avjUL1obVoty7IYE1wv83PYQm9dRJLKhHA9mmDO8mt/HFHVyNSBdAW9vc83r99H6IG/G
         xmHdA/BfkR9SFxtaXw2uZuRr7Bxk6wXBBATRjZOnmks8eFMUjUsrt5nYw+RIkTz0qNEI
         1UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109721; x=1769714521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch/3j+Fdie5zbCWlDCqsejfooDG5YNJvTZmyQkky8BM=;
        b=TTVMxIyAZORkuYLhXssCRE/wf8juQlbx5DV0sBfGwHB9RwFPZGuoDH0FXM68zsmBhj
         gRrBs6p2xffaex4f47B8vF33MSfW5AfZs+5amsZkQqE2ICZ5wHLzsWejDAvKoiPTWc2p
         cJZZ7mrMOEbmSnfrNzu+zOvZ5U2dDQJJJorsvTEMQPtabNhYqFC5aSGfCdy/1Vt7Zrvf
         rfDSh4hORx/QZROrS88a1zgwmrLCFpSRoCpNymAMSrLbXdB4KE1ulYbyKfEy3mhxZF0q
         agPplcW8ryLbun89WbDq9SQWGGUdlth/p2FL7W7+cZ9q5vJyYNgK5F9JHjTwQwgJLZbi
         sZOg==
X-Gm-Message-State: AOJu0YzppuE7gG9q4AeKkElJyaytmiuuum/Nm0tMVSL2+ovQBEfDWc8A
	un3vm7kxoLWNuN4kpUMZcr5rqS2XnroJX4S4KO4kr+Dx/zPqoI9ey51me2K1FXDO
X-Gm-Gg: AZuq6aKbfU4qqv2bskU2QeGZCFBULrdcUOtvYOLMSl6HAYjLzD1BB3SQNQbYBZL4IWu
	Q5SX4Zz6BJDmkfDP2mjVUY6hr71zqrJs4iEEuOuSWoxZMxS8ZTq9LB8sPPojdz/6W+4weGZE4Tc
	aN9VHFymWofN7+xJ/EQ1BaD2bhiBDkhXVSWqJolthqjEKnG2ZQui9H5wliPkHi+0cSUAni9gQUI
	1e1QiLqePrhwsbeIHGQvvbBaqmOCbCg5lVme6F4emEPqtE/4Jpv3okbB/kKv2SlTUkDrJypgByx
	dW+z192XgaTKWjqLAgvFc0tWu70KhL/u0XI3VNvfpaSyZXGexvKaJ0x2u17+cDFhn1wf+KheB3l
	K6SUwGSOdOg3JpDZgp3D0Drok5rA+dszOCDjgOumOS3VKytFvs/ggYIv5NzzWnQ5F1F/hbCZvZ/
	mYr98POBw=
X-Received: by 2002:a05:600c:468e:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-4804c9dbb88mr12518085e9.35.1769109720874;
        Thu, 22 Jan 2026 11:22:00 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e716b6sm768091f8f.27.2026.01.22.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:22:00 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	chuck.lever@oracle.com,
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
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
Date: Thu, 22 Jan 2026 11:21:55 -0800
Message-ID: <20260122192158.428882-1-mohsin.bashr@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-252506-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
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
X-Rspamd-Queue-Id: 268BC6CF6D
X-Rspamd-Action: no action

With TX pause enabled, if a device cannot deliver received frames to
the stack (e.g., during a system hang), it may generate excessive pause
frames causing a pause storm. This series updates the uAPI to track TX
pause storm events as part of the pause stats (p1), adds pause storm
protection support for fbnic (p2), and leverages p1 to provide
observability into these events for fbnic (p3).

Mohsin Bashir (3):
  net: ethtool: Track pause storm events
  eth: fbnic: Add protection against pause storm
  eth: fbnic: Fetch TX pause storm stats

 Documentation/netlink/specs/ethtool.yaml      | 13 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 11 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  3 +
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 77 ++++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   | 15 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  4 +
 include/linux/ethtool.h                       |  2 +
 .../uapi/linux/ethtool_netlink_generated.h    |  1 +
 net/ethtool/pause.c                           |  4 +-
 11 files changed, 128 insertions(+), 5 deletions(-)

-- 
2.47.3


