Return-Path: <netdev+bounces-76105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E1486C58F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83CD292BE2
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A360B9A;
	Thu, 29 Feb 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35mpVu5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ECB60BBE
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199554; cv=none; b=uwe4Ld3vtUVZV8hSIRx2z/WWhfit3J7L4K3dMhJe1zHN7I11n7Y77r0Or/n8QvnMkrrxLJw1O5EaWaZ0ny3CfaCmY8nDFf5oPtX2DmHmP8S+emFsHf3ondFbaFDW2SrF27muVpddPKc23BC+fZ5Z2YDOX3gkTly/MWprOsrCXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199554; c=relaxed/simple;
	bh=hZ1mBpv/f5sQroBrC681aGrso1a12KgrnTpf/Vp5R2Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lYV0xqIfsLZ2pMl3DTxdfRlvrSs4WP1m2MJPD6XAyNB+SH7hBLn10te0jII+vgKX8Jxb06X4Hk8b2aBGmJzt8+knCcTiBGIAr4z6fejlniQVAd6FY3Wlob+n7PdRonZbhxM6NASaJZrD3O+FcL/Y1G1S8qIPpiTIiAJOt1i9K1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35mpVu5F; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1126450276.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 01:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709199552; x=1709804352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GOHpqdA+QRalZl8W1KSWWcIlPsHInhoHPbfW13Qd5Xg=;
        b=35mpVu5FU7vXh8a7knX2YqhSsYVPvzzJVavlQSC9Py4GopNntKsGfF4fkGPQdpKFoF
         5tF3FlEefa/ATARWgzKvGgXHUt86MXs+jUMhxj/8MonRrnDXpdWSU9uJgIz0a2M45dWG
         G7EsJavaVURkSHB9zEooezb7xedtrQTSf67+boOLSXIW88vW8W1TOythAKsSrL9xhQxC
         PRvWXGNXWWQpeOnKyFr/71eYLud96hKZKwoD/ytVfa3WHRoB0FqkP460KG5zxw9NC8tp
         afHUC4Im0jE31wJtQZMn4Df0vxDYPzyVXmrmPKB5PGWn6TgjGKQGpgX0gfpAfai6KWrR
         xI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199552; x=1709804352;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOHpqdA+QRalZl8W1KSWWcIlPsHInhoHPbfW13Qd5Xg=;
        b=v5XInWz5n0E6l3ozICV7CkEUxiT/BMSuZleA8JrPFKFx5Ca5hkcT1JqWTaRsNHtQ+T
         PQJoYktFCwN0wRGwyl9iw+u2j7j+ihUZKyqP9AAyRMGnPasIn4/NQRbRaRT/f+J6uBBH
         Hd+8N690IvUwGux7W7Ve3FGDfrUXToWCHdlUZmtEOWnF6bDF3WaNV/x5jLPBmDIDSBhB
         wufxW8pFlV7LlJZotthZADxroLMbBSPyFwE6ftORc9e8tPWLtydVacL/K7+GPsAAQSSl
         PnXztU7KzGHhfd+rnhrXGKyByl8Tg6PHIw2+N36LJV5+dU1JesCvy1Vu2Nl78cPJrQbQ
         D+ng==
X-Gm-Message-State: AOJu0YzjGk3zaxAU2rWZwZ43+0azAKh0eKuPufYU/enjQbkVdhMFFJVN
	PvhJIrVayR6SU+m0gqB0e69lad4OIt87tvMShaYGATpohdIPPQwwu/swIsDHV7VPcH2PRZAeOyR
	NH56DwTTiIg==
X-Google-Smtp-Source: AGHT+IEISdUsad7TwP5QZqBrwrDIHdB3P28cGXRXWZ5eOpXjNfgIB3Plce09B1KEzpYNT6zdNIR3bY8ISPtYAw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:e90:b0:dcb:c2c0:b319 with SMTP
 id dg16-20020a0569020e9000b00dcbc2c0b319mr61321ybb.9.1709199552396; Thu, 29
 Feb 2024 01:39:12 -0800 (PST)
Date: Thu, 29 Feb 2024 09:39:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229093908.2534595-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: better use of skb helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch is a pure cleanup.

Second patch adds a DEBUG_NET_WARN_ON_ONCE() in skb_network_header_len(),
this could help to discover old bugs.

Eric Dumazet (2):
  net: adopt skb_network_offset() and similar helpers
  net: adopt skb_network_header_len() more broadly

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 14 ++++++--------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c       |  4 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c       |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c         |  2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c         |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c         |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c        |  2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c    |  3 +--
 drivers/net/ethernet/sfc/siena/tx_common.c        |  5 ++---
 drivers/net/ethernet/sfc/tx_common.c              |  5 ++---
 drivers/net/ethernet/sfc/tx_tso.c                 |  4 ++--
 drivers/net/ethernet/sun/sunvnet_common.c         |  4 ++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.c       |  2 +-
 drivers/net/wireguard/receive.c                   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c       |  3 +--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c     |  2 +-
 include/linux/skbuff.h                            |  1 +
 kernel/bpf/cgroup.c                               |  2 +-
 net/ipv4/raw.c                                    |  2 +-
 net/ipv4/xfrm4_input.c                            |  2 +-
 net/ipv6/exthdrs.c                                |  4 ++--
 net/ipv6/netfilter/nf_conntrack_reasm.c           |  4 ++--
 net/ipv6/reassembly.c                             |  4 ++--
 net/ipv6/xfrm6_input.c                            |  2 +-
 28 files changed, 43 insertions(+), 48 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


