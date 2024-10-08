Return-Path: <netdev+bounces-133135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC899517E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3041628559C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA991DFD84;
	Tue,  8 Oct 2024 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBF0+brz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA171DEFEC;
	Tue,  8 Oct 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397442; cv=none; b=h8kI5ofGlIkPADLfLEjJmYMvfhzLomeF6y0jQFtRm5KKaSAuDbkzzj5EzSThLFhdLL8OaKowY68iwQzPu0JwYm9V02wGgB0Iq9kTIiV6lILKp854KycVLWaCT/moZJjuYWgtKwdtgxGp7egYJJwSd2rx9yzXzZL4GWAgIzF86Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397442; c=relaxed/simple;
	bh=fT0wjpS/WVAIMnRtxxAI+82CGCdRqJUec/b/shzvnSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NpAQQQyLnVqp99A5FR6Eqpx4j2Xw2ej94bStVbGsYg7RMIc2ocyZGWH+UosiK4jFD4grQQYmNLt3pXRYivRMX/Nx4+Gll2esh8U685vVmmtfxPSF8iDjpY1V6urm4VjO/d9iMjSKFMExcuZJofNCfvfYds43pLouRhE8wsxI+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBF0+brz; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so4507760a12.0;
        Tue, 08 Oct 2024 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397440; x=1729002240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQK6lizztsX6ecGaKnNc6Bn34G/An8sSTspPNUomXw4=;
        b=OBF0+brz549Md/8q8tfY/Dj3QwoeONTAD/WTdMfjWtxihinz5KSdyAUwJSFJh0rMeP
         kbc5JbmEzyqqyuTCxLVWtFU+fIY3NcUa9LVCFhnUuLgDwYn3DLkJL6P4dUcsyTmqQpRa
         HoaE97lVjQVKaZXI96go2oUqbyxfvQy7DfsIo+X54FYXDbRaz0IS6dqEo9xr0P4E5T58
         tHhCslKzDoUOcz5lLKhSBHV8XPz3Yoz91P/45F7W7+BrqDuVx3yT2xRccB1A4JUNXEOO
         tW0UoE1+5Sk/YA2xG5snN5tvRPL7ogWxXv+h6wZ4So+UTA4GpX1FMCbhPaQfqdRnurZA
         QdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397440; x=1729002240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQK6lizztsX6ecGaKnNc6Bn34G/An8sSTspPNUomXw4=;
        b=ri1baRa1PGd065H+fOhKnoWL5Qx8mv1odIL77IikREDTj3VcHY8o5KJw81a3fmU78E
         uyEti2jxcX/qSe5ie7U0OvMAYYbjpogTz33DWFwRvbSUmSRFri8ianoe/SjYpLy5gLC6
         b6LNFQ+GN3hHNMe6uQzSpQrTb7nMgcpBff8YOlg3dA5d4u9BvfvrZUqZWimIQXZShX0k
         Y/vF/7yFDZjW+V9T6ka+lLhn2euaoiEdTvlQansd2tF7l7vDbvidfrZzowC/5EZ1e4w7
         bLRzfEwzVR5IJaDsaCesKI0+XJFc9AqinLpBQKxWN1M4laon1wBLSj9zs7fMMAU9IKUf
         H7mw==
X-Forwarded-Encrypted: i=1; AJvYcCVO5zq2HTZOFuqjeozskJ8RvSWyb8lPcon7IaBWkA4+yZbXDb1hOOTPR347AmvlN33swN6TvnWIZIWPiqQ=@vger.kernel.org, AJvYcCX7Khfit1fd9ADQr/gkHOeYuxnaGVom3BymNj3ii7gOUKGCFY9ubx9kprVyXqLUG6ZIu6Luvj68@vger.kernel.org
X-Gm-Message-State: AOJu0YyshCkx1nCvd1Q0aQWiQl0XDEySuhV6OFgiaYn0tfY1PCLql+MV
	tfnjlH4IpBr83OaqHLA1wbPj6PGTzU3mRZ0mmErZwZnh5fb0qCNR
X-Google-Smtp-Source: AGHT+IGCGZhpkQu2/JoxpzNw/1/Lqe8hjbzqi36pcvY0amNm1isynmUKh9ZK5VOPUbhwl2iMyRrzHA==
X-Received: by 2002:a17:90b:1253:b0:2d8:7445:7ab2 with SMTP id 98e67ed59e1d1-2e298eb19d4mr367482a91.20.1728397440096;
        Tue, 08 Oct 2024 07:24:00 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:23:59 -0700 (PDT)
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
Subject: [PATCH net-next v6 00/12] net: vxlan: add skb drop reasons support
Date: Tue,  8 Oct 2024 22:22:48 +0800
Message-Id: <20241008142300.236781-1-dongml2@chinatelecom.cn>
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


