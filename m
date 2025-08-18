Return-Path: <netdev+bounces-214630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C2B2AB5E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAB8721E87
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2B3090C5;
	Mon, 18 Aug 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sg4CjauS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98D2E2287
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526839; cv=none; b=jvJpRAsPyDogqGu8X+OQPp40ovLNJocA57FeUDvJVCFx9PjgIOpi/RdsYbqERaEnPTLKw8y5zp7zxEhhRS+CecHmmysviGLERt/W2/7AiYPZpO2Rfxxx8iQlFfgaEHNFVkrar4TCdDWc9DQ52r4xCK3ldH9lOPNh/YcTrG39ypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526839; c=relaxed/simple;
	bh=tXuh9+Tako/6SI5hu4a6KGj/DLclcRO/0P7UWGFsjfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVvDdcFXdWUPkpsXXDD+cb4KOkBm+j7upsstJ4AnNMZoNNl9CdT5B8JgongnXehE64p5WK8QAJAxmyeEaifKwUL3r4xcRZgUbdeGWMkMPTaoxW/RPcHhAoFPNB+8aGRkWdNaMeXSzMotxFtwTXYb95z0k73AkSJkxvfpMLJJSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sg4CjauS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47156b3b79so3117429a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755526836; x=1756131636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iJWKv+XzfYj67rIu5+Mh6p8y3dF6jMz2KOqOjeZdAE=;
        b=Sg4CjauSV0YZONpSA5QsfBUK18L9iOSB6sI2dCVUHKCEGiEtge52spsYru9YpBwkiy
         JjzlcVhXBwuJbjLreWKjwmpGAVikIZMC76vkTixugiSC8KhpPOL1FGrmX9NEqMkGnG7t
         0reHZ4qXPGBte9PfTD+PffhMSHzPZVd6NWc88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526836; x=1756131636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iJWKv+XzfYj67rIu5+Mh6p8y3dF6jMz2KOqOjeZdAE=;
        b=lrqUz+eYOGvdSkz+36Up+UPzHMlc7cl64nT7ek0KkYo73sf2G7EMlNcZPTiK4Adcqi
         n4iWf9I7f56kR7WwQgcjSdb2ru1oHL+vJevsncDjKutYEu5hQtXTNUPk34aYz2Tfz2W6
         2uJqoNle96t/Q4/8ZyU4xIUbly+ZAK3F2P+R/nOn2RyMoP0AyDE2a/+fjNhw28T9V+QJ
         40Ktr0Hias9lC9qZDwssjBzh4xb2TbcYpxNLkOL5UL0B6Fo0MCXkgqpJ8OV5a85DPwn6
         yaWS9nZzcZNDUAWUt1/EGErUOcqwnk4uIntfZl0Xqmcyi1A9VoUn/+cFqXWI7VWFGHCn
         OrnA==
X-Gm-Message-State: AOJu0YyWydtM3IkV9vwnAbfzlXYCxKJApLwosq+Y9TVZA40sFXvH+gIO
	pTPQlT8HZ64c8MDnQWHmRXk2oxJMQbEUNdfFVt3wSwV5jk/Wfdk4nz2g4+RT4vL2Ig==
X-Gm-Gg: ASbGnctsI+anfH5MGYk6K62bC2v69iInftdxVjCH2JjCMU9A89ul19tJQEXY2F1RvB/
	LofTCy6Jrfsgz2gF5xJvOkLB1qnxxdmfYP8ntdZEABEc1toC8e4JsLNf6QrbeFO/F6xqp6U4KeJ
	mvm/Rbg+cwURH9SJH4bfyq5SiJ5X9mGFLThxNWjVHb7NKca4V89ykRn1n1LThGPVxpXhTqOwh0j
	CGeXRF5toyeTWnccVsXLX2H30uHpn0r6bzy4Se27Gs2TdE3vDtbKUQQMNC3oTQEpRFzG1LrkSFx
	bkjKoTKz6RPo8Ogyu7TShDXug95qhGpPYYRUPa38zR8cYvL+TtGCLVKIRclI6aCHTEBbhLzOQEm
	9+nWiqe1v5xy+t87eihjtb5OQyaksK2g2PdeHeCcv++MHADyF9idRG6zAr8vLt4sKFleMjUruPC
	nMPhkS+Yq67v0flCqJKY6nJnZZlg==
X-Google-Smtp-Source: AGHT+IEpUxRJiaC/FhAJavL79hu2dwlz/YlZYy2RZksVYR9pcUjk7MzeE8l724xUwIdMDrwU7KEYeQ==
X-Received: by 2002:a17:902:cf11:b0:240:86fa:a058 with SMTP id d9443c01a7336-244594c7a56mr221256215ad.7.1755526836327;
        Mon, 18 Aug 2025 07:20:36 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d578aa4sm81947835ad.153.2025.08.18.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:20:35 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [v2, net-next 0/9] Add more functionality to BNGE 
Date: Mon, 18 Aug 2025 19:47:07 +0000
Message-ID: <20250818194716.15229-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series adds the infrastructure to make the netdevice
functional. It allocates data structures for core resources,
followed by their initialisation and registration with the firmware.
The core resources include the RX, TX, AGG, CMPL, and NQ rings,
as well as the VNIC. RX/TX functionality will be introduced in the
next patch series to keep this one at a reviewable size.

Changes from:
v1->v2

Addressed warnings and errors in the patch series.

Thanks,

Bhargava Marreddy (9):
  bng_en: Add initial support for RX and TX rings
  bng_en: Add initial support for CP and NQ rings
  bng_en: Introduce VNIC
  bng_en: Initialise core resources
  bng_en: Allocate packet buffers
  bng_en: Allocate stat contexts
  bng_en: Register rings with the firmware
  bng_en: Register default VNIC
  bng_en: Configure default VNIC

 drivers/net/ethernet/broadcom/Kconfig         |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   27 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   16 +
 drivers/net/ethernet/broadcom/bnge/bnge_db.h  |   34 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  485 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   31 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2186 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  252 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3105 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


