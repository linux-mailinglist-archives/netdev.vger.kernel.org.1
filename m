Return-Path: <netdev+bounces-130727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E81498B5A5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA12F1F21A9F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C9A1BCA04;
	Tue,  1 Oct 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX2V4zUN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D759B21373;
	Tue,  1 Oct 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768082; cv=none; b=Sw4F8DFOGYK2sHKRMJ5ckjcnmkAahTpB61ppguU2ZXaeq1y4W2SmoaIUErkAgg3sQHbJiXoTgvykVgHHZ6erakdRF8i18+V3mccXddoIg7L9Z4amwXfEwdpP5ndwgF0pnxw0sRj3ywCmFeTRQ0nzW+Z7Q4KZ2Sk7/xgDk0ivM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768082; c=relaxed/simple;
	bh=Jne4CedonI6JCdV8qzvNtmC/3gFT98u4Ma//EEck4uM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pU3i7rs3iJ2Agz6Y2a+17s+lalYIqAdyDBhhKLi+p+7/qjzcBv3v0E9hg78b01THEfZ0bmc0vRKPCwHrqWdCiMeECMpH4iwQvtjORL5fQ3Uusp6xzC1xCZPBvofnzhdTX3YSWThFkXtpi8Oe5Y9ZpyfKMr8EJbn8iZZl6qwnHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX2V4zUN; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e082bf1c7fso3813092a91.3;
        Tue, 01 Oct 2024 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768080; x=1728372880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1h3lC0J/+FcpCGs1ftXHaWu9Hry4ssCsXkL+Z/MMUw=;
        b=YX2V4zUNnOYhinUA7TmfDEEVCSjCfhssFwafx9vxFBeSGElQ2yMoe3en3sHWl6j7ne
         LKjBGDfTg1ACBgHTkBrdfW516od7xZJkydprxlfw6dI/XQK0yjeg07RYYkbtVuBsmDGe
         6wHT9yiFHXY59AsoeHEzNU6RniQfUex89Je4yBvAcS/3V9zw62EVFr141De8HobamE/O
         B6J1a1+TCKhK2grtwupOOE2ceGdmZV83kuVSmemBbzjvmsIRuN2I8Ne86t0mkipiB07G
         /tNAp2dFjBPc4m1Ta2qNcUGEfNEvM9P8UhK5VFUeXbzXUYyxSB8NcdzEfcgzKGZrYdiR
         MhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768080; x=1728372880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1h3lC0J/+FcpCGs1ftXHaWu9Hry4ssCsXkL+Z/MMUw=;
        b=g6boGq4/9RRfcltj3CBcDhOeVhMs3mXG5wmvupg/geGUjZl7dDi8MDpVWjxDpcXxQz
         /zZkiEQHaYVblUa9hjvtM9+Y/TXlz9YrsoGqzhIPPuwqnRaAMrRF3zDDqW7KudTrVLzn
         QDcIM0qtnKQDNsnGC5Zoh4MIcA3Y96WVDPbwT849QmOColMxiijXUip0TmGo+OadeGAK
         lkasinS71BTTNBUIJ17kX0SQ2WPBVesvlQ5kjsnntz7/iNrxdqV3yeZGbIpOCT2foTFK
         ehfvy0NiN9+7NTwy71But9L1VnpfBp8umn1J2NOjiqMCS7PCIBBlGMGhMsRNpUBR2joA
         BH/g==
X-Forwarded-Encrypted: i=1; AJvYcCVJz8+5u1Z2zUZIEW9ubYWhXM2el45MbqkEtchJIOAT6bYIemHhZLwKnkaZ9rMSmyoFN8m8YrbtoOq8TIA=@vger.kernel.org, AJvYcCVvXsYsPRFVjRas/EDbf2GPe/cmuWYhYcwG08McBdx+ueVYol/NV/BjF0kM35DsAnOnvlmpydez@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3lNFArI+K+d8v6GoFYdv1vqwFXlGMc2zbOfEiZV7Uo61QPm5
	Bo0LwFe7XXj+1c0vZ4dtebRnxAsqoYoYFhejfRtEk5RCrV9e4bCj
X-Google-Smtp-Source: AGHT+IG2JlHiXI2Db3c+hb3rnYObiFrW39KiuMF9yPL+VgF1bt/xWrpHNAOjQXWiXKdx3l6emwDnzg==
X-Received: by 2002:a17:90a:c291:b0:2cf:c972:7c22 with SMTP id 98e67ed59e1d1-2e0b89cf943mr17187357a91.10.1727768080053;
        Tue, 01 Oct 2024 00:34:40 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:34:39 -0700 (PDT)
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
Subject: [PATCH net-next v4 00/12] net: vxlan: add skb drop reasons support
Date: Tue,  1 Oct 2024 15:32:13 +0800
Message-Id: <20241001073225.807419-1-dongml2@chinatelecom.cn>
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
  skb_vlan_inet_prepare_reason()

And we also make the following functions return skb drop reasons:

  vxlan_remcsum()
  vxlan_snoop()
  vxlan_set_mac()

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
  net: tunnel: add skb_vlan_inet_prepare_reason() helper
  net: vxlan: add skb drop reasons to vxlan_rcv()
  net: vxlan: make vxlan_remcsum() return drop reasons
  net: vxlan: make vxlan_snoop() return drop reasons
  net: vxlan: make vxlan_set_mac() return drop reasons
  net: vxlan: use kfree_skb_reason() in vxlan_xmit()
  net: vxlan: add drop reasons support to vxlan_xmit_one()
  net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
  net: vxlan: use kfree_skb_reason() in vxlan_encap_bypass()
  net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()

 drivers/net/vxlan/vxlan_core.c | 111 +++++++++++++++++++++------------
 drivers/net/vxlan/vxlan_mdb.c  |   2 +-
 include/linux/skbuff.h         |   8 ++-
 include/net/dropreason-core.h  |  37 +++++++++++
 include/net/ip_tunnels.h       |  32 +++++++---
 5 files changed, 140 insertions(+), 50 deletions(-)

-- 
2.39.5


