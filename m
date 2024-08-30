Return-Path: <netdev+bounces-123548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4D39654EF
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A85B217A5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813129CF7;
	Fri, 30 Aug 2024 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWDPkyLq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116B28EC;
	Fri, 30 Aug 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983339; cv=none; b=ZHC35oxrcOjJMFdWXb3zRSphBMxjxwAVhj+DTr2mbETMpE7QjNOtV0ttVJGMciAsmkbf0vTzELyPaV01zJnVPSjRkuECFB2S6J6SX0BxP2v6PvA7go8xONzYdxlG8qu01MoXvxMcy8j/utUw8a0cbt3P3jiiIyveasJKGjWFX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983339; c=relaxed/simple;
	bh=5PrHpNpgJU67VNvFnqaW4tUwVaL9MzZCeCIUK3AzLKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKmZ2Iv1PaksQDNfb54ua9vJASnx6syUGDODaeA5hvFj22Pc2+UqthQ6Jbg3juBcqX1TRlj0ha/P/hJFa7La4YhDmYic+K1iq+UCV00f0UercbJfeXHORl33oRcktTaR+RnPpyw+/jiziyX1eAgLvUJl+9Okl+gP6XBZxQYDMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWDPkyLq; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71433cba1b7so999172b3a.0;
        Thu, 29 Aug 2024 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983337; x=1725588137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+B9S+Ad8UV8cDt2I1V6UnXqNCMZVVO/jyvRv7UGi9k=;
        b=VWDPkyLqNj5BhXeVhDxmKL4G2OXFdKIPf8dHxwbsKCdnKo+7c3jPrvT7e2Dk+7SpcZ
         Ei2ZUgsMrZ6dhrW2zglpEBdMBQ9o1TCLtN3pF5JwRoj3kTQxqV0Z0sxpkje/auEe4pMC
         dpYGp2EQupD7RV1aRl8jcWiuU6C0bAmTJ+KCXXL/+KEaKUnjaDGVNEfOL90bT9rhOiqs
         XYYbd5prBLz7EQdQzE75+wBu0yfLGwR4TB9tPkmvakJbEJSKnHRNPjaGgmmWZ+iwZ+82
         2pu4xWhc09n/gmRo91icqQeyjKoscL1cixQm65oV0Wy7yi6GqHzy6uxO/y7iCPv7Svvy
         b38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983337; x=1725588137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+B9S+Ad8UV8cDt2I1V6UnXqNCMZVVO/jyvRv7UGi9k=;
        b=ZNJsrS/t5TNOkP7ZteqNmpBfRuTGVxk8967B5FAVNYqcVW01Xyhf1q3p6wA2RyM4LK
         Rck+IAtPz+Ls4Ct8NqE1autfaipdXZHWTUhgOtK6UJT+LmH1zv3I7hHX9sYV2iJihGJE
         GAs5tp0H7pQTuiqu/O80hVSGCsje1fR31Afq2SY3IEfM44m/zqAa9tATrh4AI8mpB4t9
         AL9xNjY37f1dmRlVpFk2d01ohWIhMJdRw1zF9evDwBtn+PTJV39tpc+WX3Pqopqb/nwy
         fGWThwA5Mmr9/QMRD+yR2VGwwJX8vkQMSC3veNQDUXyIkSsIuotGdLg2nxbFhWdZnWnY
         I+qw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9NPk5+uPiCuzABIrKPa0a6ZDlhb7uPNVMwPfruHPCnCRZ7P2AzbrrcW/Yac70TRNggllNO+Z@vger.kernel.org, AJvYcCVsWcq6C+cGkyf7Gjxxyk12w8M5gWGF7VWw44+Kv1WDhmz+OuNg8ygNLH0RIEywW+387KAQz7Y8dKtffxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhuysf450p71YyrWf1EB50kzKXtfNzF1ElgZ0ufGuiMosEdtMG
	vYAblMkYhmgAMY2dHDZIPQrk5AiSZUU59IMibvT69MlqZzL/FWv1
X-Google-Smtp-Source: AGHT+IH3wPwRugjpMGZbwUfWQfkn412nPNmsqeW2dldsRluJFJd1N9kMOkHRerHDipDZ93Z0YuValA==
X-Received: by 2002:a05:6a00:a01:b0:70e:a42e:3417 with SMTP id d2e1a72fcca58-715dfb124e2mr6113482b3a.10.1724983336565;
        Thu, 29 Aug 2024 19:02:16 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
Subject: [PATCH net-next v2 00/12] net: vxlan: add skb drop reasons support
Date: Fri, 30 Aug 2024 09:59:49 +0800
Message-Id: <20240830020001.79377-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, we add skb drop reasons to the vxlan module. After the
commit 071c0fc6fb91 ("net: extend drop reasons for multiple subsystems"),
we can add the skb drop reasons as a subsystem.

So, we now add a new skb drop reason subsystem for vxlan, and following
new skb drop reasons are introduced to vxlan:

  VXLAN_DROP_INVALID_SMAC
  VXLAN_DROP_ENTRY_EXISTS
  VXLAN_DROP_INVALID_HDR
  VXLAN_DROP_VNI_NOT_FOUND
  VXLAN_DROP_NO_REMOTE

And we add the following drop reasons to enum skb_drop_reason:

  IP_TUNNEL_ECN
  TUNNEL_TXINFO

Changes since v1:
- document all the drop reaons that we introduce
- rename the drop reasons to make them more descriptive, as Ido advised
- remove the 2nd patch, which introduce the SKB_DR_RESET
- add the 4th patch, which adds skb_vlan_inet_prepare_reason() helper
- introduce the 6th patch, which make vxlan_set_mac return drop reasons
- introduce the 10th patch, which uses VXLAN_DROP_NO_REMOTE as the drop
  reasons, as Ido advised

Menglong Dong (12):
  net: vxlan: add vxlan to the drop reason subsystem
  net: skb: add pskb_network_may_pull_reason() helper
  net: tunnel: add pskb_inet_may_pull_reason() helper
  net: tunnel: add skb_vlan_inet_prepare_reason() helper
  net: vxlan: make vxlan_remcsum() return drop reasons
  net: vxlan: make vxlan_set_mac() return drop reasons
  net: vxlan: add skb drop reasons to vxlan_rcv()
  net: vxlan: use vxlan_kfree_skb() in vxlan_xmit()
  net: vxlan: add drop reasons support to vxlan_xmit_one()
  net: vxlan: use kfree_skb_reason in vxlan_mdb_xmit
  net: vxlan: use kfree_skb_reason in vxlan_encap_bypass
  net: vxlan: use vxlan_kfree_skb in encap_bypass_if_local

 drivers/net/vxlan/drop.h          |  47 ++++++++++++++
 drivers/net/vxlan/vxlan_core.c    | 104 +++++++++++++++++++++---------
 drivers/net/vxlan/vxlan_mdb.c     |   2 +-
 drivers/net/vxlan/vxlan_private.h |   1 +
 include/linux/skbuff.h            |   8 ++-
 include/net/dropreason-core.h     |   9 +++
 include/net/dropreason.h          |   6 ++
 include/net/ip_tunnels.h          |  31 ++++++---
 8 files changed, 168 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/vxlan/drop.h

-- 
2.39.2


