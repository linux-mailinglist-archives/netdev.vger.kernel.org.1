Return-Path: <netdev+bounces-132469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F470991CC9
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3FC1C213C9
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0369166F0C;
	Sun,  6 Oct 2024 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFin6XYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60F249F9;
	Sun,  6 Oct 2024 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197808; cv=none; b=OAlCHeHk1EJxcz19lVupP8JNQ1LWmCNYzWV7sHYMjVSX2R9HDKi5wbc/cB0Qb6NhVh3+LRPHE1031Tz6cfFOBQhrZZmNsjaQtio0lteYqKA47mqgtrOtWjF31PKfCrrJ340nHGMiq4rxeqlX0tTvw+BcqUEfQIOLF2Ft10i6JXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197808; c=relaxed/simple;
	bh=9xmSt//ckqUc9GEsM7EVOlOajr53kyWz802i/xD4PHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nzndu/AZCWqHnlq1Wai5vLXxNb19f4N9AG3yECjEHlPmCZN0QD6EOedOzNrGgKOn6d+rIZTY1LU9+HmF12jD45Hl9+hDNpNnurRIu3M3EGbNE6473d/CTIymBWn52y9/Q4MQx1BsIs/vtOnzN//bSCTao07kXVFLG7eQEHWWO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFin6XYc; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-208cf673b8dso36763925ad.3;
        Sat, 05 Oct 2024 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197806; x=1728802606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVlvbtJ0HauPUdOyVZHG6EW5XbBgja5OxFe9LJEXSIw=;
        b=LFin6XYccT1gLaPmoi20d9xv8s1vNB2vNraFWinlTOloLI4c542DrUP0UJGegYfMwS
         EmPNAeC5W+GpuNDJQ96fchBOMGCjwgqyJFLjf9+2cvcuqqMgjcZnXgPnLH80mElcEMq/
         BVSQA2jPFj7bQoNKpsNJziSEAcATcvlfu6tx8SxgZgVmn4gikOxBNFejZ9YrtIczf+tG
         hbo8D8L5I6cmsr+AD3KhyLgZK9HBrbxTny065pCOhYCbGHnETKd3t4JR514BhtbLTJB3
         Z27VsjStalNwppyPKgLTX7kjytL9WByc8enLdlo44+mw8N2GfPiORL9+Rk5eWLwB9YFX
         cgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197806; x=1728802606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVlvbtJ0HauPUdOyVZHG6EW5XbBgja5OxFe9LJEXSIw=;
        b=Zzwn0K7ZbwZVCEUK4uyzupCuo3ZoWrWeRQA9fQRLiXPB6rJAm+UJRbJjdHgkKomEol
         f6DNdwE+ABu1LAvwEaGmJzGApAAZmU9/j7LFvYVgmHzKtK2HGjX0YpriaLwhczwuKl/5
         X/TCsLdZofXgqKh19xOb3zLuChgEruJRu2Aezq2VIQjumT0WnoD0nnYPbykxVSVoBbm7
         JMgRW6nmWX8pjApqFaa/u6VvRZj1rtT8x4vTtO1SbOVwD74H6Cp+MouXwlJzJtKiyVsv
         5Ix+v/5e1JX1J/wOcbH+Uw8cRfNOsHaoNqsYCbw6y/UBQtt8iIIxNZn38yBHqpl+Ko8L
         twXA==
X-Forwarded-Encrypted: i=1; AJvYcCVKGUtPa+ezoKg/syf+ZeF2OLtkn21wdPqoZkV/4gfsHwJ0wX7HSgWAvn09BV8kEqg/32+xIRc7QES1q64=@vger.kernel.org, AJvYcCWgnRYj15a60DaERjOqziGCKMNWgQNe4SKEMAa0eRssMTRveHbkVr2iotvVy14LKXlQHGedLQFx@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJbwJSJr1XnIS0pS+yRsQdrkzSjGUi59RsTvq5/m7/7n8g5Zd
	jkVhhXdVLzzx4lzI4xrgDWUVaAyevlDcruY7bLKY09kkhlF+deiZ
X-Google-Smtp-Source: AGHT+IEDzWwIdJCb/fzy5ZaO9rMBbEN7d+bsMKvBKcStuvOMuftMzbHUx2AFtEX4U0mXqs1Ce4I5Fg==
X-Received: by 2002:a17:902:d48f:b0:20b:937e:ca1e with SMTP id d9443c01a7336-20bfdfd29a3mr104299925ad.18.1728197806425;
        Sat, 05 Oct 2024 23:56:46 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:56:46 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 00/12] net: vxlan: add skb drop reasons support
Date: Sun,  6 Oct 2024 14:56:04 +0800
Message-Id: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, we add skb drop reasons support to VXLAN, and following
new skb drop reasons are introduced:

  SKB_DROP_REASON_VXLAN_INVALID_HDR
  SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND
  SKB_DROP_REASON_VXLAN_ENTRY_EXISTS
  SKB_DROP_REASON_VXLAN_NO_REMOTE
  SKB_DROP_REASON_MAC_INVALID_SOURCE
  SKB_DROP_REASON_IP_TUNNEL_ECN
  SKB_DROP_REASON_TUNNEL_TXINFO
  SKB_DROP_REASON_LOCAL_MAC

We add some helper functions in this series, who will capture the drop
reasons from pskb_may_pull_reason and return them:

  pskb_network_may_pull_reason()
  pskb_inet_may_pull_reason()

And we also make the following functions return skb drop reasons:

  skb_vlan_inet_prepare()
  vxlan_remcsum()
  vxlan_snoop()
  vxlan_set_mac()

Changes since v4:
- make skb_vlan_inet_prepare() return drop reasons, instead of introduce
  a wrapper for it in the 3rd patch.
- modify the document for SKB_DROP_REASON_LOCAL_MAC and
  SKB_DROP_REASON_TUNNEL_TXINFO.

Changes since v3:
- rename SKB_DROP_REASON_VXLAN_INVALID_SMAC to
  SKB_DROP_REASON_MAC_INVALID_SOURCE in the 6th patch

Changes since v2:
- move all the drop reasons of VXLAN to the "core", instead of introducing
  the VXLAN drop reason subsystem
- add the 6th patch, which capture the drop reasons from vxlan_snoop()
- move the commits for vxlan_remcsum() and vxlan_set_mac() after
  vxlan_rcv() to update the call of them accordingly
- fix some format problems

Changes since v1:
- document all the drop reasons that we introduce
- rename the drop reasons to make them more descriptive, as Ido advised
- remove the 2nd patch, which introduce the SKB_DR_RESET
- add the 4th patch, which adds skb_vlan_inet_prepare_reason() helper
- introduce the 6th patch, which make vxlan_set_mac return drop reasons
- introduce the 10th patch, which uses VXLAN_DROP_NO_REMOTE as the drop
  reasons, as Ido advised

Menglong Dong (12):
  net: skb: add pskb_network_may_pull_reason() helper
  net: tunnel: add pskb_inet_may_pull_reason() helper
  net: tunnel: make skb_vlan_inet_prepare() return drop reasons
  net: vxlan: add skb drop reasons to vxlan_rcv()
  net: vxlan: make vxlan_remcsum() return drop reasons
  net: vxlan: make vxlan_snoop() return drop reasons
  net: vxlan: make vxlan_set_mac() return drop reasons
  net: vxlan: use kfree_skb_reason() in vxlan_xmit()
  net: vxlan: add drop reasons support to vxlan_xmit_one()
  net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
  net: vxlan: use kfree_skb_reason() in vxlan_encap_bypass()
  net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()

 drivers/net/bareudp.c          |   4 +-
 drivers/net/geneve.c           |   4 +-
 drivers/net/vxlan/vxlan_core.c | 111 +++++++++++++++++++++------------
 drivers/net/vxlan/vxlan_mdb.c  |   2 +-
 include/linux/skbuff.h         |   8 ++-
 include/net/dropreason-core.h  |  39 ++++++++++++
 include/net/ip_tunnels.h       |  23 ++++---
 7 files changed, 138 insertions(+), 53 deletions(-)

-- 
2.39.5


