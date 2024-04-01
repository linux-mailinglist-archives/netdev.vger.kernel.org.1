Return-Path: <netdev+bounces-83824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A18947E3
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 01:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1EB3B226AB
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 23:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE72E57301;
	Mon,  1 Apr 2024 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A78cqvpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1D5D468
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015136; cv=none; b=FZ7P9mcfnatFEnGTq6OChZn4ZzbUQqWZLiq+PGb0RqcajxHJ//49gFiW3yfDx60sw0C2ijovV1gltna/xblMHsvviX/Li2FhZZIDp76frE7uhkfDhfkxS/vG4GB+4iAmQAObgQQgPGoOqa73MLAqcj4+DDgU9kyNhleGVgA/tyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015136; c=relaxed/simple;
	bh=q5uE5iIpFjbvKfuGGktEA4wK8XXiUacQzrox64rZSzo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HqKAIhvHjdTtCqoFHDNEeRCSqRWWoZmoYuqlt3cwSUBBDLNd1sNBAD1Brzc+U9aFpx8xEGYqVls/meQFU/nqeRbuyconW7CUfOVy5/5+2DGuaT/hIQzqWd2IhzSPOJFHxWV+O55XWtz1bRkaBDx2dhoqhJx68cJRTUeeQG8kYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A78cqvpR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e0b5e79a57so35418575ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 16:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015135; x=1712619935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lch/oP7Pyow2mOgtViPyCMQBf/BJiF1sWKaTfWLjhE=;
        b=A78cqvpR7R+B92Mp9TTjkt2YZJC6XDosu/Evmsf83AuI6Irf7YYi5K/Qguddp407Jl
         7P41IMfcPuFNHbHxeGYB6JWcbxsC6hlYpDmEKYUCEsAVX66qIenLdOXs4Mxenv1EaGiP
         TOY81ias6PiemT9G0jQa0O7Ew5qHb9EoTgIzMeWcylUZPYiZZT44Hb+2T8pauwWLg/Yn
         yJ7ISJtn1J7zhz/LbXMuxWKSycR4KcrEQPVSayKMSjdg8VgNn0ZcePzYgPmpumbhBzMG
         VhAZFzsAYJrH8kicMsDpknspXij+thoRxpkkWJkAb+e/oBXIp/viJZTW4ThGxh+xg0Cp
         k0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015135; x=1712619935;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lch/oP7Pyow2mOgtViPyCMQBf/BJiF1sWKaTfWLjhE=;
        b=Of86Xr3EovYu9upjRZnmmQPYkeamofv0+M1mgSQgR2crZyQTJEFSpdZeewrENCGMv/
         bHODSB2tSstmAq6PZc+rSKHyTpegwudk3F5sS7XjWx6MRXJi9tW589JbXJJtjBXUgBXN
         CQb7L8eymqIHuGzrcg2JoV6GUxSVm4Z9KNw3Y2GP8662KhmDE/FDIlCI+5gSzpublhyJ
         sfgciXNW6OoC1ve5JEX9z8ZdIl8gSiKMdyk8UV4WnuXRi4dr1wcTh9jXFKXIN2Xw7EMq
         0sMROMktD8CC9PKBbUa/5RwWGjac55rUCOiPUywD2zcJr8ZFucu3AORSVch+HAE5UPBE
         OsYQ==
X-Gm-Message-State: AOJu0YyJ9OCtqP2sieNAEfYwQwbF9hJc4wp1Q4rr7CZOMfzlfK5fgeWD
	RwYjeTcSvy/hdQTwxCoQ1uu4bZkU19KaIbyIWgXiJYmq/ISAN/lXSuV6axhfcps2wlqC5ff1O9j
	qrUhGUjTuV5RPMhhbMxVQHjBPZ2sbyoEREb3rIU9eZfePVdRsx5VCiq7891mr4JoNOWmRrqF/RF
	FL8c4edjv1mSJspTROQD6tb9+LK2ffsWEgT/bJ9t59is7B8QBqoqVYCwwgH2c=
X-Google-Smtp-Source: AGHT+IGKCrhOkLN2VTUrJY6La4PQSYEAiXiUKfPlWl7BZjDzITPI7XOz0p+SS0KSUbrF9v0Y8Bb6t1E0+u9AuN7qDA==
X-Received: from hramamurthy-gve.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:141e])
 (user=hramamurthy job=sendgmr) by 2002:a17:903:2288:b0:1e2:45bf:abae with
 SMTP id b8-20020a170903228800b001e245bfabaemr111761plh.6.1712015134632; Mon,
 01 Apr 2024 16:45:34 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:45:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234530.3101900-1-hramamurthy@google.com>
Subject: [PATCH net-next 0/5] gve: enable ring size changes
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

This series enables support to change ring size via ethtool
in gve.

The first three patches deal with some clean up, setting
default values for the ring sizes and related fields. The
last two patches enable ring size changes.

Harshitha Ramamurthy (5):
  gve: simplify setting decriptor count defaults
  gve: make the completion and buffer ring size equal for DQO
  gve: set page count for RX QPL for GQI and DQO queue formats
  gve: add support to read ring size ranges from the device
  gve: add support to change ring size via ethtool

 drivers/net/ethernet/google/gve/gve.h         |  35 +++--
 drivers/net/ethernet/google/gve/gve_adminq.c  | 146 ++++++++++--------
 drivers/net/ethernet/google/gve/gve_adminq.h  |  48 +++---
 drivers/net/ethernet/google/gve/gve_ethtool.c |  85 +++++++++-
 drivers/net/ethernet/google/gve/gve_main.c    |  30 ++--
 drivers/net/ethernet/google/gve/gve_rx.c      |   2 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |   7 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |   4 +-
 8 files changed, 235 insertions(+), 122 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


