Return-Path: <netdev+bounces-133420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D42995DBD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3FD286BE5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0455A126BFF;
	Wed,  9 Oct 2024 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiLKt53g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014956742;
	Wed,  9 Oct 2024 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440951; cv=none; b=OxQ/Yr3iNLpOwbrevJHJYZdlI4ORZ9lnknlCX+j4FSKPM9bDBiTTmb9xrxSCgAr0brUKtiuZ8wRBMKMMHaAaQNMde9uS0diRzJO4KAhD91M1DZjaL/2IykLQLIK5HCmvW6JPyXYFrF0jz4Ni0zQ5wMIxtuPt9YQSoUScZ5bNyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440951; c=relaxed/simple;
	bh=hDbZC121f3FkIjlBATEPoPKG6lNkdxhvFLMm7QmPhXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LasW2f0F8SugGWlv+Ehp2tejfw4XhZmQBanF0qjEvy8AeFxHoYGbeD4VKby/rLa9uNnB5NOzS2ot/yCsg3UetjQH+gnCgnadsbCw786ltRYlaiCGyO2xQrIcU/+2snyWM9u4TISKUalwjwCnpInW3JlMgJKch0qjCseOpy4gEqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiLKt53g; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-207115e3056so58012425ad.2;
        Tue, 08 Oct 2024 19:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440950; x=1729045750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLMJgLLSK/EMHE38gaMZeHpLBg8ZTOiT27udtwNf4+c=;
        b=OiLKt53gxbpF4/Whx7pWbFZr0xiAd8M6l4Godcj+sSI7PIod/CiGhStdH7475wn7vM
         fcDHOPgbU/4rbXj1KpM8Wlab1mOCYEzKUVPPd757v2PMV+eRY+2iVmuttaxYad8cXPR0
         50NGlxbTyaT6YVCVbAl2bwpVUZAGrdsdtnJZlnwVOqz26E4IwwVneLRaCGHED+LmQ/E7
         9f7j3jtAM3hW0Ftj7lAWiGd0mAaJsf8+HNQ1BdijgTYE1kwSQONQMBl+HV4vt3pJG09Y
         QDNGk017G3HAjxvLjnjA4USDjYxE3oT7i6KWdypBPqyNS5PMecVYIzNuPpF6anZEJ8iC
         tVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440950; x=1729045750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLMJgLLSK/EMHE38gaMZeHpLBg8ZTOiT27udtwNf4+c=;
        b=TjBm3F758zdjxqLieVxPM4mOZ9YZkGKQf9xdkR09IkfzBikVu0904c6LqGa3DeXAFp
         P3I7AdtKVIo8E36+7eZjZR50nqf6xcT4n+fttefC1zOKlbqAqqQTk6zIAzXZUaYAWgyD
         1Zy7MlAgjTrsLv4k8mrkTJB4gLTMNYfOtOBCPUNcsfGafE+iCWAhZTs8peyTfvx2FNnr
         6nVrb062vHY7BAKQgxFtXv8PiO/oGKEj40UtcMUAhVaZkpE9NYFl15uXAmaAqOtiTbGu
         1JkJDMrnC2xTxBcLovgWYyc/QdLuiDsjAO0cawzccABCRgmzXAgnon2BqYE6KAfagRL0
         l6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCU39uAMWGl1RhFHSepRmbYNqalKC2pjkD9OZ9i0Q1tlTfFm7brILE7kvwuw/FlQhEtSsVae40u2LsEmFBU=@vger.kernel.org, AJvYcCWi+MkYptuXTbK0pvfYQzXlR6P1kAwsVomIKbD0XslMKyyH3rJ7kmr5tgnStblsOqcngd0IHwMN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4vdOQJ2hqsVwxbVe8HGf6LtbqfeQRHa1nUxQnR7mkKpIJzLH
	OhcEHCTv794OLLbAL0xelbmk1HwhFkNMcpsnELC5ipv6mENZLdE0
X-Google-Smtp-Source: AGHT+IEDU2NZEtPHzu2aH0Nyp6MV6rk6i8ehIKOFfX5VH15aaaNCwq6h5meLNEgBJOHeX/KI5hB/og==
X-Received: by 2002:a17:902:d2d1:b0:20b:61c0:43ed with SMTP id d9443c01a7336-20c637511e2mr14170445ad.30.1728440949648;
        Tue, 08 Oct 2024 19:29:09 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:09 -0700 (PDT)
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
Subject: [PATCH net-next v7 00/12] net: vxlan: add skb drop reasons support
Date: Wed,  9 Oct 2024 10:28:18 +0800
Message-Id: <20241009022830.83949-1-dongml2@chinatelecom.cn>
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

Changes since v6:
- fix some typos in the document for SKB_DROP_REASON_TUNNEL_TXINFO

Changes since v5:
- fix some typos in the document for SKB_DROP_REASON_TUNNEL_TXINFO

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
 include/net/dropreason-core.h  |  40 ++++++++++++
 include/net/ip_tunnels.h       |  23 ++++---
 7 files changed, 139 insertions(+), 53 deletions(-)

-- 
2.39.5


