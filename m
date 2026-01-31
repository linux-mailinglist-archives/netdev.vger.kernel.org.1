Return-Path: <netdev+bounces-255320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGFXFaBmfWknSAIAu9opvQ
	(envelope-from <netdev+bounces-255320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:19:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D70C03FC
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11BE2300D331
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30592BEC52;
	Sat, 31 Jan 2026 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJTiOwe4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5B6A33B
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825946; cv=none; b=EbVDIQoDPDvf45F7hOxKfIzDbYOtISwlOWxW3NP6WxNUsxSNH2hiEylZhv1YxTzdNNl/4RYr3sswxgeLBOzQsCYLc+07pXiOLYMYguh4cv4wX+uXwx5GKa4QQfkpPCWGoPRdcC2kOqBT/a32SuPLdWxSbM3gq0znBpask7Tq1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825946; c=relaxed/simple;
	bh=aAdnMvR2ckA+MK4a7O2S7GrscaBMh639AZEAZBIzNag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDj4+uwwrCzvaVdokyShwXxebkorMhIwOgpWIRGGtPrmuRtIqbCg0WTKiPn5lUxADpHysEC1JU5wN0guXFL27b+7jIrcXYMwEq7Fc7WuHXer/bKSlcY0pYAJWtTq3MG+u7wPqfhpCdH5rFKb0U3OK2dQsXchSkNvXdZzNqYaaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJTiOwe4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d67f1877so17684795ad.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769825945; x=1770430745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xu3nAMKMno7i+bpi3HHulZypUbwiOV1otmmd5ESVeE=;
        b=nJTiOwe4flah3xvJvyCHYdslAnm2HfepgR+R2DMYj8c15fWX/gh0OsoUdowkxgkGQa
         qjURlEOPrzNqM3fMRPSOXbRjn3L925XrIMhP9rMWp+7TFmu0/iVSCu6xQnv3NVva9MLg
         hG2JHhBXEUIrTBXW2WcgtGHLwdRxdjRZpRaOGTjSuGK3x7ySA0nGuUmUjmNKfTxKePwk
         3KcxSsbzC56QaLg6ZPX/sWLH65ElB8/zv8hgPhMtwFhFqpKrejo0TDrR3ALS+HESJDUv
         zVDs7wAyBVMX5a8NLALO6MykvvSfzxYz9SjA0G7Nl6N16v7BODoKJzsfhX2/ehlwms18
         uOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825945; x=1770430745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xu3nAMKMno7i+bpi3HHulZypUbwiOV1otmmd5ESVeE=;
        b=vtSJeAvoyu3k/sgzEeHitvmq6DF990Sf9xoWr31c6qpruDEkhhaaKYOr0Xa0L22xIi
         zWa9V7MAb8mbTf6ykB+L91/H3ySn4jMz01YHcEXI7jbn+gbHk1LTvxGPqBbjWOLM2YhD
         G3xsoVcyfM0hkB19PQQ3Y+/24D/4eUPNeQlY7ecCUcdRtZZ1QB+kGEFkDMAcLnK1iFfu
         Yq+VnpRki/N7TL/UTZGI6Dj5slD2osknXJDRWdFOabHT6zVQg2AVbp7IV1OgLFl9AfoM
         R25DMfBlxsjY4aos+GuFlkkoSRz6DjWeL0qyq+4eqhDmx8MzuPHNdspBU+I58ONSilxC
         o2xA==
X-Gm-Message-State: AOJu0Yyda3CQNeMd2N34ESJituThxNly7qkUlFPXrTM6np4mfhhkf7lt
	pRJ58KoecBAlAlVvhXKA3Vh3ii5Yd16cAi3C/0C8gGdaWJ5wzT5H92gv9W0+jA==
X-Gm-Gg: AZuq6aJRQUtaeXlz0g4mmACGdcm3T7L5Rhv1v/xPcHrlrfiRvDVToVXhEKPvVvrkXiB
	Tg0wBFgh3YLk6dAwQdl1nHccJdcMYmcdeTY7xb5HNHRhq5CYuWJImDBwZYu2KKx+CaKMG9D2MZF
	xZskWEPloeMhuAUa+/IqnJRHP/seAWH7AweEaU9I0LVLYZxVrw/nNIn/YucK3RkDbWLlAY2YWaO
	AZ3jCnHFNV+s1LQbbbUyq9OwWvxx+a48lwG+XMwgduimXtm33gGxs/BOuBn8OgaRkaoC06O+HsR
	waJiGmbleR906SuSTXNCRNtwiQuAKukJAgOKyJPmHFFa4+g7vtgCzUJ8LDo7n/nO9PSQK4L65XG
	Thb00fumX57jj5EdVsB7B/U44UBd1ij6U44ThAPfzdMp6Z5GS6uykI97u6htZwbd5T8kTftotZL
	o1ZFnKL4IKLPswQ/thncaqwQd7XgS6IPbzDIQ=
X-Received: by 2002:a17:902:ce06:b0:2a0:f0db:690e with SMTP id d9443c01a7336-2a8d819ace3mr53803275ad.52.1769825944793;
        Fri, 30 Jan 2026 18:19:04 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eeebcsm83427365ad.10.2026.01.30.18.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:19:04 -0800 (PST)
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
Subject: [PATCH net-next v6 0/5] net: dsa: yt921x: Add DCB/QoS support
Date: Sat, 31 Jan 2026 10:18:46 +0800
Message-ID: <20260131021854.3405036-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255320-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0D70C03FC
X-Rspamd-Action: no action

This series add DCB/QoS support to the driver.

v5: https://lore.kernel.org/r/20260128215202.2244266-1-mmyangfl@gmail.com
  - fix xmit priority for tag driver
v4: https://lore.kernel.org/r/20260127020847.1482724-1-mmyangfl@gmail.com
  - change the color for DEI bit and add a comment for it
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

David Yang (5):
  net: dsa: tag_yt921x: clarify priority and code fields
  net: dsa: tag_yt921x: add priority support
  net: dsa: yt921x: Refactor VLAN awareness setting
  net: dsa: yt921x: Refactor yt921x_chip_setup()
  net: dsa: yt921x: Add DCB/QoS support

 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/yt921x.c | 310 ++++++++++++++++++++++++++++++++++++---
 drivers/net/dsa/yt921x.h |  55 +++++--
 net/dsa/tag_yt921x.c     |  89 +++++++----
 4 files changed, 393 insertions(+), 62 deletions(-)

-- 
2.51.0


