Return-Path: <netdev+bounces-118827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AEB952E71
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5387A2859E4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AEB7DA62;
	Thu, 15 Aug 2024 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOecwiQ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265B1AC88C;
	Thu, 15 Aug 2024 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725944; cv=none; b=rhcUxb21VdJIvk2PWSqPowDIsJQSb6E+owiL5SAsJ34tzzB06hkaVQUTLGAnwNZAG1w2qzo0R/MsSEQgwpWlHsOX0+cu1nOQ4vpoOLS5W/DXGAKwp7Van0WLY8ZGdgW8bfTbJI7Kf0OboIf176TG8w7dvOBEUfZY7ESQHFnSWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725944; c=relaxed/simple;
	bh=gSkvPCZ5F2KLNjbUA9QQF59rFMN29CicQcVimMZA7Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=br4OymBL5/JDyvKdB24BPsGOId0BYFVIcHYVg6pleagmQSUDHEM1JmA3sCJJjK97LIwzrU778Z4otKLvZ08Hxu4NHDkKYu9LZGYdTKbho55WaBHEq33Zx5bVWUe3wPC535jMi9DRxlN1OxX+kYQFeartUZNQ9gs9vTMIrvNkae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOecwiQ0; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso676819b3a.0;
        Thu, 15 Aug 2024 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725942; x=1724330742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNzBxnmVRpnlx1Ed/XHkpcoP45ab/H3XRfB6s4a8DXQ=;
        b=GOecwiQ0OSKMJNW/RcTSMeza5iWqkpY562qiB0GmZB1dnbn9/Bms4zXiIaeXY/xTME
         h+EtQ1+O7k4bcGwbd+sErUI93v3tuOI2svbvbEZTEdj9YbuRu903M8zAY2SGqom9NRZi
         0FBzud/3kA+xZlRGktVq+mKXD1wjd4uMwwDhR7a+AzEKdzN1eoUmhs7wP46VQuRqgess
         w85TAWl0nRzP4gXqYG6uI8OjPovSwBVWiyh5/6aWodvy/GhQcUQsrWWmC00WqCoBHns/
         fpIO+C4Sea6LhpCjP574XiTh7C3QP6bz0NJ2A/sl2DQXtt1cO/Lao9PxViKgwGvFfb3O
         lKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725942; x=1724330742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNzBxnmVRpnlx1Ed/XHkpcoP45ab/H3XRfB6s4a8DXQ=;
        b=eDLPaFWnHTTgy21I8b03j13mZsSjsmLLX63BwDkkmGjTzHw/Wg/qztNlIBur9HObLt
         7/JAaadQCIyy7hu1PXsRZpPEn05CGUzhPLzH/QgVyLh0EaUnzkQc56oDcy/2dImZNKxw
         /madQvTzouJBbfh2mZvmLTHU0g9KfGyUM0NXfCyFJNzp5rGt7MW5ojqlygcvhJp9tvft
         SkhhSKlZXNi3CE4GdYrjB/kuK1xFsWEnKYcN6EBAsDHhJ+YgESVKP1SMqDBCNsr17Afr
         a/pBIBnUvBUIn2pDTabJWF2ZFRbwLW6yPW90m58VNlvouymvz5Yhcrm/XxeP6o4COjGA
         nXrg==
X-Forwarded-Encrypted: i=1; AJvYcCVXFqTWgIID3jrjC7QB/4PxaiY8E9acT2WCbmpQKAexsmBit2UNKCOwHAsV617U/hMOHM4yu57gXg2TmxY20F+UlyHaW58Kx10/keMO0k7D5zVhrOZm7++mu0a8qJwh2h/5H3VG
X-Gm-Message-State: AOJu0YyJAo3fbbJpsaxtaAh6Gfw/zD87/G6CRhUhQ9Op0VKk0LXm9c6E
	QrTTeI3Y7CboEjZPSdNV2TDNXac8JDPDOjYcgWuBRjU+s8H99dfG
X-Google-Smtp-Source: AGHT+IH8vXh5XNtlrYF0WHkQ6rw2dEXfq12CBNFZ81eLTYiYWiRfHWd31IeL39BUnDZIyZJuzFVqUw==
X-Received: by 2002:a05:6a00:21d6:b0:70d:278e:4e94 with SMTP id d2e1a72fcca58-71267420cf8mr5780950b3a.30.1723725941686;
        Thu, 15 Aug 2024 05:45:41 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:45:41 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 00/10] net: vxlan: add skb drop reasons support
Date: Thu, 15 Aug 2024 20:42:52 +0800
Message-Id: <20240815124302.982711-1-dongml2@chinatelecom.cn>
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

So, we now add a new skb drop reason subsystem for vxlan. I'm not sure
if it is better to add them directly to enum skb_drop_reason, as there
are only 6 new drop reasons that we introduce for vxlan:

  VXLAN_DROP_FLAGS
  VXLAN_DROP_VNI
  VXLAN_DROP_MAC
  VXLAN_DROP_TXINFO
  VXLAN_DROP_REMOTE
  VXLAN_DROP_REMOTE_IP

And we add the "SKB_DROP_REASON_IP_TUNNEL_ECN" to enum skb_drop_reason,
as it not only belongs to vxlan subsystem.

In order to reset the reason to NOT_SPECIFIED if it is
SKB_NOT_DROPPED_YET, we introduce the SKB_DR_RESET() in the 2nd patch.
This is to make sure that the skb is indeed dropped.

Menglong Dong (10):
  net: vxlan: add vxlan to the drop reason subsystem
  net: skb: add SKB_DR_RESET
  net: skb: introduce pskb_network_may_pull_reason()
  net: ip: introduce pskb_inet_may_pull_reason()
  net: vxlan: make vxlan_remcsum() return skb drop reasons
  net: vxlan: add skb drop reasons to vxlan_rcv()
  net: vxlan: use vxlan_kfree_skb() in vxlan_xmit()
  net: vxlan: add drop reasons support to vxlan_xmit_one()
  net: vxlan: use kfree_skb_reason in vxlan_encap_bypass
  net: vxlan: use vxlan_kfree_skb in encap_bypass_if_local

 drivers/net/vxlan/drop.h          | 36 ++++++++++++
 drivers/net/vxlan/vxlan_core.c    | 91 +++++++++++++++++++++++--------
 drivers/net/vxlan/vxlan_private.h |  1 +
 include/linux/skbuff.h            |  8 ++-
 include/net/dropreason-core.h     |  7 +++
 include/net/dropreason.h          |  6 ++
 include/net/ip_tunnels.h          | 10 +++-
 7 files changed, 133 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/vxlan/drop.h

-- 
2.39.2


