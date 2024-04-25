Return-Path: <netdev+bounces-91475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1878B2CE2
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 00:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4571C2182F
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134D9156647;
	Thu, 25 Apr 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN7UFxu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8524156250
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083019; cv=none; b=lAa9iPzQJ8TI9kcckp+u+kFnxSmEw7tKz03pjLeKFZr199o7wMq9GT7mgVHa+Um/a7wbkQXpsFpWUUwJF7PrOQXTYVXv8cuuNqpJhcIXPOIsAFg6LQOnmsyuhwFHaOEVvZaXPvT1C5lk3ZCgrPnUx692++BoWeFQJq04nGEjAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083019; c=relaxed/simple;
	bh=u5YCPBbfU1mP1ZcMWk36sIHt5zaVaIMvB2Iu7ja/E7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDDR1YwQ7Hr9eF38+a58TvZqAYhLQDYXG0VK9lGRDpHRWYyj1j8YwDvb8CiExYzUHvYRP2sKWtWXe7oNFD2druui3dZdP/xNo7c4RJF8WjD96B6hLCuDiYFtqiz/b+53TjVBGGaPfqijOw324oI5+sL5QUqob9cP83sPj8OyFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN7UFxu8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-60585faa69fso1078976a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714083017; x=1714687817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4ObHrHeCFN64wSM7NzDkDxv31XoYnyH95XTbkMwAw0=;
        b=XN7UFxu89UjnOolvYxtuV8vaSw38GV3K/lYqkmjEi+NREcXCenMyP/8S/54VqrJsz6
         w1rVRBWJoISRLg3LaC+DlTySRXu2zgWcagD/BZ+0I/gBU22q5Ub+HJyORfZw2rElvkv5
         V73XOOjteFkb3JOgHRo24tbBbEJFnpShmwyrBm4q8DTFzwYCwmnOUqQXaXed1dufgcGs
         dn6pzKNsWZGnNYNWGB+/yGs09KD/2T83Yx9d2Aw4hz0NwlarYQMre5D690ZI6YLcFBlx
         fqluNaMRWQZs7hJy0iyLxQlK/dZXTDuaFu6TpsjnBi2yn+CvCTKj8+CDWGKyELqjr9U4
         ZZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714083017; x=1714687817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4ObHrHeCFN64wSM7NzDkDxv31XoYnyH95XTbkMwAw0=;
        b=HzXa9OUBg9tiqNlXeKmYG76aaS2shCUZ0YwbHudTi9m6EFQia9v+D+cmTNgp7db539
         4rJE1Utgj0kAwImyPXCyQn2RAuHYSLKtbjf1RiOXA1olXppWb/OX6wPwGBAdi9qW12fp
         8I18tWgZFIZylBMoBte1LvEiZOCS9HfRIGtG9J+IGEVKOBNE60DjefDFFk1jJjGgnLBz
         0XhSTv/7JNaB5b3JZxyaeuZ5feb1avsBXAUoolXdZFXRHE0uRNZqEfRlC266+/7xaXDi
         nWIXjJK6hBMLL39qLzdkKpn3JFq1oIIEKDi1lfdDTxyPg9RG4KU8OooP/c3ylMhzQ2VG
         ThzQ==
X-Gm-Message-State: AOJu0Yy3FIL9Rld8XlYqb8PXidWWb1USIJhQ5A3GasdE4fiChXHZFZJw
	oGAqFwYr7AgGDHUg0zPfPxGCzOiIwYZDZ12qeZXcZ+YkfyOaRk+jB3Zbig==
X-Google-Smtp-Source: AGHT+IGd+/ZlsSmsAskam+Ti+AZUk16zxsI/1v9saOmqyoUfaIyU3KDBhU2rBkcTYxKAen4oSOwDPw==
X-Received: by 2002:a17:90a:d397:b0:2ac:7bd6:cc6a with SMTP id q23-20020a17090ad39700b002ac7bd6cc6amr1500980pju.0.1714083016613;
        Thu, 25 Apr 2024 15:10:16 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b002a269828bb8sm13394766pjh.40.2024.04.25.15.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:10:16 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>
Subject: [PATCH 0/3] net: bcmgenet: protect contended accesses
Date: Thu, 25 Apr 2024 15:10:04 -0700
Message-Id: <20240425221007.2140041-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some registers may be modified by parallel execution contexts and
require protections to prevent corruption.

A review of the driver revealed the need for these additional
protections.

Doug Berger (3):
  net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
  net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
  net: bcmgenet: synchronize UMAC_CMD access

 drivers/net/ethernet/broadcom/genet/bcmgenet.c   | 16 ++++++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h   |  4 +++-
 .../net/ethernet/broadcom/genet/bcmgenet_wol.c   |  8 +++++++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c     |  6 +++++-
 4 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.34.1


