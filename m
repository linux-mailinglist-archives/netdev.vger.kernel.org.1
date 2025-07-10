Return-Path: <netdev+bounces-205919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB1B00D4C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBA1189F68F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8D28A73C;
	Thu, 10 Jul 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeG17Lzk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277028B7EE
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180035; cv=none; b=BsGog7Qf3nzyuDdHmGM3zlA3nDmyKHZ98Jr1eNC0Os5lUtfC8DC2X3OZY9OF4mKoIH+AFRSZe7jlMoh8IWeEUSiMPLqVkU/YNMPnm5jF1vebVwpBH7MUhb+e8py1IoShfLB+RFM/BLkBOy0lByQXEO3KkCj90Ldg+5ss3Jh8+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180035; c=relaxed/simple;
	bh=d81PsHObznTW2i1CFHThGJsef9zGYZLRC/H4omKW8To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J0F33yWQL63cx6u9hGcRPBNt6ne0vZypCthxoHHCYbj5nB53IO0Kkux6MgG/OiaXosHHgzB6X3ESMaCbtDbNsE6uIhzKj+sc4Ts4nF5Jmm/E2cPDpXgpP30JIvI7+fYpV78KmHSoYkJDwLobI1Jl38cfvxOxFklYs6DqndeB9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeG17Lzk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3122a63201bso1267416a91.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180033; x=1752784833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ7masZSk8xK0Ara9W55Uu3AeF93cuRqZLT8uKTRlas=;
        b=VeG17LzkqCmHe5JKas3qGol2M1ajQD925Wqh92CtHoqdl7eGR73S4n76vdUI/xIgGC
         I1iGQL6YDeOh0ge5bmb3jZ+EY8788N7Vuxh339dKaXoaah5pb8fucF5qzOEjxUSPy2Ih
         6O7bYLPy6kd6PE6vbpfoOMXAJrX+qEf3OjEf3T0t4MO0mFOJhSpd3/9dDgCcrBCMnGeM
         b8nXP2HUPNiXSJHuGW0eHMfKdcJx9BSJeC3nKXZaOF6lTUaKiRnFW11iE6u/St9xEmVL
         AfiKmP1JRhNE3UJSmLcY1WhB7BrS5XojT2Xu3nYVA3uUjbBNtwuwF7oEJ7pQx2OF2zpa
         6zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180033; x=1752784833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ7masZSk8xK0Ara9W55Uu3AeF93cuRqZLT8uKTRlas=;
        b=DMdXIpUFowdJ5Ci5z+2YLji2dN4jIenZoxwRZ+FScq+JsqKIAwHTBTshvYAkXj92FC
         rdHkQUcl1LgOYdbOL5HxRjVVUxOjsBTvU4jrFXjEFBgKNk3TqohpIaE81679PkvNU/+U
         vog1eCX8DXK8FrWVnv+DWNfRIL+U0K74TDEG6sVEVZbSiq6Hh1IegO8/71IAQcUgMpNp
         enKHCpWqFVpWbYmOe0WpU6YKHcR/KfjgdkMzwdstQfzXfjYGbVyqrcVQYzpjIyj8JRxc
         HqfICxgYgwRb6JczUN6HsZs9RGJJgt675RDCm6sx2hR9RJsP5LAH1ddZxfui6Gc7U5gT
         VyzA==
X-Gm-Message-State: AOJu0YwBpqLUS4BPMyZGhz+IgUVBF2nNPNoSoahin/mH7LPETT0XmzA3
	XKtIoKOYGZ+4oWudvwYo1bsjD+zXrWgu/ALhwN12PfvDhKKi5Pjg3ZJN8zq4WpQ1
X-Gm-Gg: ASbGncthsQNKBf8rBOMKLfcBxSHt0yuQgRT83871ISI3OZ6X3HvB1nQg+b/+LAYwAYP
	P1/a5SyWg0z6g8ezceac3TAT4oBihIcomyjLY+oFaLoLBFW3iWo4X8Kel2YHq+y6++prqrOATs7
	e1aHFzOb/quay+ycwrN7YtRRCQjRaIhtOnCeO/L2MfmESw9TioHoy1eaHEpRDbNV2KtU/Q9n3jc
	SoW1500w5EO9RCJWvvzYoO/S/Zo6rmu8WbeHExpDWxchDYgGoXeICAZvbbeUxjTWvJmmymGaxrj
	8YlIojjgIH4tXvexqGH8PRWgLiMUSd/oR252k9chnwM=
X-Google-Smtp-Source: AGHT+IEv6o0aggropWfdmsOErbnG17MeZJJizrGQyIh9qNYLetsek799+6SN3QsLO5UbfSfvnrpHLQ==
X-Received: by 2002:a17:90b:28cf:b0:311:f05b:869b with SMTP id 98e67ed59e1d1-31c4f584837mr71336a91.30.1752180033486;
        Thu, 10 Jul 2025 13:40:33 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.32
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 00/11] gianfar and mdio: modernize
Date: Thu, 10 Jul 2025 13:40:21 -0700
Message-ID: <20250710204032.650152-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe cleanups for gianfar and fsl_pq_mdio drivers

All were tested on a WatchGuard T10 device.

Rosen Penev (11):
  net: fsl_pq_mdio: use dev variable in _probe
  net: fsl_pq_mdio: use devm for mdiobus_alloc_size
  net: fsl_pq_mdio: use platform_get_resource
  net: fsl_pq_mdio: use devm for of_iomap
  net: fsl_pq_mdio: return directly in probe
  net: gianfar: use devm_alloc_etherdev_mqs
  net: gianfar: use devm for register_netdev
  net: gianfar: assign ofdev to priv struct
  net: gianfar: remove free_gfar_dev
  net: gianfar: alloc queues with devm
  net: gianfar: iomap with devm

 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 92 +++++++------------
 drivers/net/ethernet/freescale/gianfar.c     | 93 ++++----------------
 2 files changed, 50 insertions(+), 135 deletions(-)

-- 
2.50.0


