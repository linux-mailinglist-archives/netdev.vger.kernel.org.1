Return-Path: <netdev+bounces-126378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CB3970F7F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C39B20D09
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F901AED5C;
	Mon,  9 Sep 2024 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naqR62h3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59501AED55;
	Mon,  9 Sep 2024 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866586; cv=none; b=sQKPaoViwLfIYH+3nv1TTRgv/UPAXfBMDWQppSrJvIyMMsVBDc8YDPfkP0brkYauos7uLeg5xFwvASYeGDqP7sDjxcMXfCWEoafGvhEoYL6JkJi4qfpFs9QzAJ9ww7EhYVFWGkvtNLptQ+e+5Qp28ZSelql8gzOcYQstgDJxLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866586; c=relaxed/simple;
	bh=Iw00dCIosptPue61ucrUgNPeEO95wQZSZBJoQTKTOG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wn7Ju4waMNcdAxE49CJjaX1KLHLgjIcCVocUUNkjVCaetQycRY+rp6XaPl1B31aEWFMTvbHwQC6u3KtZELKZAmJS7kjopwEQI4D9JQJNcM7R8rtqJkH++aRz+aemTQfDMOoefCg7znajrzvUMi4UHnQIo1AsSODr+QUbdkdGCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naqR62h3; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-3e03e9d1f8dso631730b6e.2;
        Mon, 09 Sep 2024 00:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866584; x=1726471384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0v7ViIgmPVp2A4QfqOy1Yh+f9LsV+Zd4QgrjtNP7Ze4=;
        b=naqR62h3+HIlPbISKnfjuHPFh4x4B/jZxEN8iiAU3oHCNPMErViXqmdLQa7FzR9lk1
         yfWHAyrfIQhlO4MQug5gG9hp4bQhnO1oi2gAxb2/ZbyTi/MjmPppN71yXbMWRGD+ZW2Q
         Dte4RpTlnmAmvXWm1Pyu6mLPkrPJqybqjhrg4R+Sy2h0i2ebr9F4sE3sHaWlt0YbOYxs
         U/JSkXranfJivPAE0FDt0CT14hMPOn5VdCUslsrB4Bhv4E88QcSpr+kmOHWBpwjYowj7
         lPcwKxrsq2NDglgsELKPMhqw34pmV0lNWgQApmQH/mdp1IDUup6Lh4YLSpWZplS5fTkq
         m3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866584; x=1726471384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0v7ViIgmPVp2A4QfqOy1Yh+f9LsV+Zd4QgrjtNP7Ze4=;
        b=DwL8DR0WURQxC/h0hnuzDKt8HlhvsCf2B2P9cTBBcVN2L+Zgx6Q3vYLa8VShoUMRhJ
         v67CQgddl/7399i0zN5MxJV9DsWjmDlv3JT2zq1giLwwKEoXEBPwEAHwMxl3tXVELn5i
         gCZrutNKYAhywqejfZUq1Szue7fq3gVaERjGfl4C9RdfnOtT4RWX65ASoZ56v6zKpJZV
         +dIvUB/DMfaAPstyPrPmBNo7kKGWpNtDoBznLWVJVL9EsdIZG5qoaQuyVDKzHj/95YTr
         jKJfZcwaBrif0u5DzfHPgJ2sP+5Z8EJlWID1POQDskRbtmJJz9QcE1i1TEasCJ0y8Q4R
         oqQw==
X-Forwarded-Encrypted: i=1; AJvYcCX7lJkFZKUWWHYod0Ym46PDCTj8G2jIWh2p1CrZhDkPi1vTyuYOm5lNGysW7jIwgW7z3RnDV5I9@vger.kernel.org, AJvYcCXx9dHqcgODSfcyr02pEw8Q9qOYBhVnUz4AmoIGHbjF9iFTimbrvIZAfCu10hXkMWFUb1EX1IT33/05O/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuzkDuLNJEhFCXNmS1MvqwgcPqidqUjzVLpFjA21XbvXv7zEv
	HdJsYQ5QcTWDiYWuvpcXTUm9yGmmiFHTyHG1IvWC9zWiTE7mrW2s
X-Google-Smtp-Source: AGHT+IEGVCcArknxw6s5Mso314Z0OqD1T0xycKR7OadYggEpu31/Opg+U42gv0osPO8M5L2SaS6shQ==
X-Received: by 2002:a05:6808:1a2a:b0:3e0:c13:9837 with SMTP id 5614622812f47-3e037ae4bddmr3341401b6e.37.1725866583606;
        Mon, 09 Sep 2024 00:23:03 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:03 -0700 (PDT)
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
Subject: [PATCH net-next v3 00/12] net: vxlan: add skb drop reasons support
Date: Mon,  9 Sep 2024 15:16:40 +0800
Message-Id: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
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
  SKB_DROP_REASON_VXLAN_INVALID_SMAC
  SKB_DROP_REASON_VXLAN_ENTRY_EXISTS
  SKB_DROP_REASON_VXLAN_NO_REMOTE
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
2.39.2


