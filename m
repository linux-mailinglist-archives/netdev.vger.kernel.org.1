Return-Path: <netdev+bounces-242556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8626C92151
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93EF3A523A
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267632C923;
	Fri, 28 Nov 2025 13:11:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088B32D0F3
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335515; cv=none; b=juqliJDm0I5caLUCczidHAdqVslp9q9ir9BjCyUtJeIDFUyr3bHpdlI5rKkwIlAXM9eUIEBH6Tu+zohnIrjMv3TEbJdo7hlbZ/jI4097Iii8KFIMHGjBLeDkF/fY3j/yg3/MjENkvPGzKSJwkHEsA6RTXDbfCmtgZJlgIcO1g+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335515; c=relaxed/simple;
	bh=wPfBuuRbOQzpvr+HQJeCzp5MBHbQLw3bJS89RfFBpEY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IT+sKQPKxi64KCfWRXUOZEi2DHWFfcF9Hvzh8WJuScsXPjzxpEA36mO83Go0CEyinMCe2gkFMGwM97r15CqbzrehwFRgyOw7fbnZmcmBBJAreqVQXUwZ67vE8GK1by/RH13aL5qVHD8pChpOtvDELwi9Jd/tDAwunuuQUVyGD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e89d226c3aso1081176fac.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335513; x=1764940313;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo9vcRLG0sffdJ2tNernWLmxwmEkT/AvLbfE2YPHtNo=;
        b=bkcEYWeoX26s8i7tBdnG7RkOFaqySIdGTcwssrpJFNg1rI++EjX1PK4yQSHmlMray6
         RsFZkFmJkQqoIYLlMKQkkEEV63hUNFVOdA7IJP2BAPAAOiwRTHP7O1sUhsnTPQtz2H+u
         RqYIXA+T7nGCKknKWzNrNOd8k4fejzmthpY3b+9xZTASnG9JFKgRPE0ehx18YafAAfmt
         KNYJgUhePoOdgLcQWLnlkzPq7dVCtCmnZYuzt4gSQ7OyRyWyMM3Ljex7/jxmG+190YIc
         XWf0O91ClPbjulp465gop5Jt4/K5LRZ8zBOk4PWJ8YO1PIJFEBk29JCB+USTU8rNW28y
         Xwyg==
X-Gm-Message-State: AOJu0Yzp9aQlG40CTj6FfgW4FJdVNB5/mxjSr6oXjUrLOY4HhdRAgO5f
	HNVYAesPeXgBZXSXF3XvaotDb+lxNKKsFXG46PXCLQGs/7NVjG/5ik4E
X-Gm-Gg: ASbGncvPS0ZyHeQlRUte4QfP24Wo89EqOBnhDAB5BjXcsaJS2ea7O4rzty13dr7WoSf
	B+jZNwadIF9lY1RlA2KyBuXlylPamQB2ScDDGmf7iTfGpTstFbRQ939orwpGb6/dHPAxoat1eQs
	1dAGL51BngpNkapUKU4DAS7EFcnH4AgB7o5x5Q6mQs1Jl+wZTh5Ar0TQbhhwYE1NVTrursV2Bnf
	ovOh9VPseSKT8dWfpTPZQTFZ73N7WE4Tn4RcGbv5RdWze7oj2wr511BwgAYCohyeNGJ/mhFEjiK
	9XKANZ1PXf4tRQ44/ZrvlBNO6/EBIXhiCOqzfv4jAaPgRrZcKqXv6C6zkUamrGh2zTY3L085VWX
	nntzJDmRoVQpCyLGhAYk40FdCzRXt5pzARyIHUXyEc8m/5Ags5dLvI3gd7NmxEJxDSOc0+iC9rv
	aA6oMnijGz5G1S5A==
X-Google-Smtp-Source: AGHT+IHMtWs+H6VoFeAZ4KF7o8BPplF77Zskrbnrap/+zhewizkk9Ay0s01zNG3UCeFYf843DlHFeA==
X-Received: by 2002:a05:6808:398d:b0:43f:b94a:14f2 with SMTP id 5614622812f47-4514e635561mr6797100b6e.16.1764335512874;
        Fri, 28 Nov 2025 05:11:52 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45317113578sm1207649b6e.22.2025.11.28.05.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:11:52 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/3] net: freescale: migrate to
 .get_rx_ring_count() ethtool callback
Date: Fri, 28 Nov 2025 05:11:44 -0800
Message-Id: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCfKWkC/x3MUQqDMBAFwKss79uACSiaq5RSgj7TBdmWREpAv
 LvQOcCcqCzKiignCn9a9WOI4jvB8k6W6XRFFIQ+DN6HyeVW1PJrK2Rd0k43zkNKM6cwrgGd4Fu
 4afuXDxgPZ2wHntd1Azx/DWJsAAAA
X-Change-ID: 20251128-gxring_freescale-695aa9e826d2
To: Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=leitao@debian.org;
 h=from:subject:message-id; bh=wPfBuuRbOQzpvr+HQJeCzp5MBHbQLw3bJS89RfFBpEY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKZ+X39YtaH8lgeg4bEAgtcx04w9xGnjGKvxUh
 l/za36DZqeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmflwAKCRA1o5Of/Hh3
 babRD/9fycIXztKGa0k9ztryGFwc1vsXl3dSU+02G0tUOaMMbW1mke+MOc4/vmxiT/UqdWJ7JxG
 diXh4y8s3JT7C9F2TMRlYYZp7wNr8mhXoOdOcNCt2fc/Hk6wXySiuPx+tbuCDCq6Q5qZi9EHJoi
 cMfW2ustDCQVVC5eOva1waqqBT34UoxmFI/oYtGiDHGCw0ZreWknfZbSHSdBNxQU0OvfWxIS19E
 CVF/AarITWCLgEaEE/j/ppVqu1n6wxGojoh1C86wcbSbfyau6t4oSG5CpQGUTqKpho64uDxZIJd
 MrGCepCpMbgbGRwTdQBzl/W7Y6MChPB/T7dUMzFC6cj26YS/0o20FApIt8UDURzJ6aoZTMyirPC
 0nr+5krzvk6G02L2nwHB2Gp7tktbdNGD9ZxTicxAdfv8OvRWvg7v0SzCQyzjnaK8e5LV3IfiDLW
 E/Xy2mSKiihTu3RjlGBvHRekMrFqtE5BInUjDYNp22Y2KMN8h6kJxGWO8EvGwPCxF5dq6RGye4Y
 xPIVnb0xmSjC6oO14o7XMgVGhPxaR737aAqBdEJZEReNxFj6rMktLGa1+dErtZjkqNbzvQrFSJ2
 ce9/9lqDSkPDY01KDZf5/oYwO8Opu2DcgwlXrBJBtwIRZAMeo05pQA8guWg1LV0o76Urynixr0l
 0VX3ZhiB3jEweSw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series migrates Freescale network drivers to use the new .get_rx_ring_count()
ethtool callback introduced in commit 84eaf4359c36 ("net: ethtool: add
get_rx_ring_count callback to optimize RX ring queries").

The new callback simplifies the .get_rxnfc() implementation by removing
ETHTOOL_GRXRINGS handling and moving it to a dedicated callback. This provides
a cleaner separation of concerns and aligns these drivers with the modern
ethtool API.

The series updates the following Freescale drivers:
  - enetc
  - dppa2
  - gianfar

PS: These were compile-tested only.
---
Breno Leitao (3):
      net: gianfar: convert to use .get_rx_ring_count
      net: dpaa2: convert to use .get_rx_ring_count
      net: enetc: convert to use .get_rx_ring_count

 .../net/ethernet/freescale/dpaa2/dpaa2-ethtool.c   | 11 +++++--
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   | 37 +++++++---------------
 drivers/net/ethernet/freescale/gianfar_ethtool.c   | 11 +++++--
 3 files changed, 27 insertions(+), 32 deletions(-)
---
base-commit: ed01d2069e8b40eb283050b7119c25a67542a585
change-id: 20251128-gxring_freescale-695aa9e826d2

Best regards,
--  
Breno Leitao <leitao@debian.org>


