Return-Path: <netdev+bounces-148797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47129E3292
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DDC166F2C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3514A15B97D;
	Wed,  4 Dec 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="UxD1TCpQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDF10F9
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285457; cv=none; b=VpLW782hy5Ki2cAqS1W+m3yDpwrhygHAVTFQKZt7aPmDO5dcdjjifnSP2K8kzDabtc1issBNHo0jiXObl0hsp4seSUL/xkRld+DL27MFVex4cbvOH/DMinohZsbuH1OdPN4lTGmuAH/LG9HuON1wQ3C+j5oiQVUWDl8BzWbuSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285457; c=relaxed/simple;
	bh=zeBJQ0naVj9Ez+GxSthS8PZwM+9pU0PkJgPdrKMP7dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gml5s8jKIIh8b13l7a0oPxrvQBJNmsYWNerOwF0Q/NSzuNPEeNtndc/xvVcF47R/psAQo9wEs/Ut83D8mgxYh8cXjAa4SyQ2uXIuN1b9mA79Hh/jKIjLreaHFMuGYxSSJFkcuh4SP0GUjFucy6I3t8Z0tlqx+wR7512tgLbG1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=UxD1TCpQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215b0582aaeso18028525ad.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 20:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733285455; x=1733890255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vB6O+xkBF4HsZUS3R+/oayuNouNHFnuKKjLdZozdxdA=;
        b=UxD1TCpQNh87OMS9GMrIAOMc4NDtiIPTroDmiD3w20u1ABogObj2JjFqUL+s3kyYkE
         WiBJVYJl1itOjzygRqguNL9OeVGI9LzMr0P+gtsMNW7+m+thQpyzeTAif/L+cXbH79M9
         BULQgCX1Pv0DvbERNoM3lrkkliJRMjIspHS9HS5ZB8oik3bbyN/PnK/+8FrX/52MXkWj
         RcGQKQ0bQWcWlKvunuWH5m0PM2a1g6RJrccsWk1Fti3fZ66TonAHfEmBdSw9ppzxfuJd
         ChrwMZwzzGE9f9SgSG7Jxw1cjfwkn765Q3/STe8HItVR/XKKJlMxPqzMZ7+9SV4lJ75S
         syWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733285455; x=1733890255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vB6O+xkBF4HsZUS3R+/oayuNouNHFnuKKjLdZozdxdA=;
        b=So1NR+A+4AXqugywNiFkqIPqunw01r9+JXD99pCxt7OYUPQkTU2ZSSmXxz2dg56RMV
         4OGirZcQVbbzIEGr1gKfpNnw5j8Z1ocHWyCye7QdLf9A4wKDtZRy6Mx0Bfv16Ysq/TP0
         5n1Uzri7ojHrvvsN3amFOUBcBqKPQJfGkiwtkaoJrq8+xjbSX7a+vz+DBMXxGIwVWx5Y
         YV00IfTcChvvPMeQYpDIYaHZ775zAwStM0xOcbQGFtpKbGSjyzaUmRMkmE6p+OwTP2mI
         SbPxw/zxRV4yDNgEvupfdIIuQjoh0uMjYHrASvH7FqF1L8qZnj+KNKs9MFBKKclcHyy/
         hcmA==
X-Gm-Message-State: AOJu0Yyv5KTp0jGS/K2eiqtuViy++TfDKp0EQsesePzV44uK3G/FeEIt
	cGgpLfP3yPkWJq1Dr/1oKXzaz5IlKV5Lp4xSuPXFzERPeQaXrQjKWp4ylrZZq1Q2jS5QSXXsK20
	j
X-Gm-Gg: ASbGncuMvwXwEje5xQKiaeBAU91b0LJAh2+MS3AWUVF0uHi4D/QcmFRtqKEAFl9p+MQ
	r2gAlCTtpCOx5mMTOkElLpxZL4q0JAy0dxeSpVRzTeuXhaONstFHAPR7mEBaFUaVdHT9A7QBmd8
	Os+DjwGhiZfSV5mUKGYMmrazIsQYrkdfbbjGV7DyOp2MY8a+3jfs0580cdxiaLtWgt4xNELuqAY
	3xLMoYv/I+mHq+85yMU7kDJOPsUN7etFG0=
X-Google-Smtp-Source: AGHT+IEP1/+1333fh1rqir55EGEhT7ENJYGcLcg8LBxyxAhY0AUZjVWszAv0j1qvWYeXJjv/zfCGuw==
X-Received: by 2002:a17:903:41ce:b0:215:7ce4:57bc with SMTP id d9443c01a7336-215bd0c4d19mr62722205ad.16.1733285454774;
        Tue, 03 Dec 2024 20:10:54 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159ebee334sm39341835ad.67.2024.12.03.20.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:10:54 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v3 0/3] bnxt_en: support header page pool in queue API
Date: Tue,  3 Dec 2024 20:10:19 -0800
Message-ID: <20241204041022.56512-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
separate page pool for header frags. Now, frags are allocated from this
header page pool e.g. rxr->tpa_info.data.

The queue API did not properly handle rxr->tpa_info and so using the
queue API to i.e. reset any queues will result in pages being returned
to the incorrect page pool, causing inflight != 0 warnings.

Fix this bug by properly allocating/freeing tpa_info and copying/freeing
head_pool in the queue API implementation.

The 1st patch is a prep patch that refactors helpers out to be used by
the implementation patch later.

The 2nd patch is a drive-by refactor. Happy to take it out and re-send
to net-next if there are any objections.

The 3rd patch is the implementation patch that will properly alloc/free
rxr->tpa_info.

---
v3:
 - use common helper bnxt_separate_head_pool() instead of comparing
   head_pool and page_pool
 - better document why TPA changes were needed in patch 3
v2:
 - remove unneeded struct bnxt_rx_ring_info *rxr declaration
 - restore unintended removal of page_pool_disable_direct_recycling()

David Wei (3):
  bnxt_en: refactor tpa_info alloc/free into helpers
  bnxt_en: refactor bnxt_alloc_rx_rings() to call
    bnxt_alloc_rx_agg_bmap()
  bnxt_en: handle tpa_info in queue API implementation

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 205 ++++++++++++++--------
 1 file changed, 129 insertions(+), 76 deletions(-)

-- 
2.43.5


