Return-Path: <netdev+bounces-93341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D74E8BB3D2
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA5D1C23749
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1E713B593;
	Fri,  3 May 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIiaSYH5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C0158869
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764063; cv=none; b=g7zt3jjVmy/+1lW/Kl2y7CBFXbNgp+vDdEMiTZtokzDz2DrOg0UA7KVMJ5ha+2CuUeYe47ZvB/MtA2ika+JjMCKM2f7hocLnrHiAlO9zau+ia858xoqokXOjS8UJ8NpyOLgdcwnOV27x9tVv6/jMho/YO5sMkRO/TG9XBhQNZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764063; c=relaxed/simple;
	bh=08QSpIQGWlXwXEj8sMt2oa0+Bq6ox+P7MmCeaSF9vVU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SnTkn00VZNhR1hoSldIwPzVg9QNIIBjxy7RkS+9yYFv7CPuCF0QjUihUCZ+z/syezWzYi0gEyKAjfYm2ANSVk3VCPEiq1A4b2QPUGyNXS4Pz4ThHMKCcWUCdp7W1mNRdtIjUbFs1i8M9LuK38t7+wPiLCRUNEG9l6VIH/uTbKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIiaSYH5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so63196276.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764061; x=1715368861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vL7nhaiIYQuczdw6GlYf6veqmTY5SNAmlevhZLtLprU=;
        b=BIiaSYH5qfK61v1772hq0wn/Ss15qQ9AxjJc10VNVKtHalUgEMzaIugDE8JR45WoVQ
         ZFyoCjz47gaeLlwVHa9vfuxLEnlbK4115iXut8/MHUxk+uZu7FvwmPE4ZRNF+wE8prXx
         Kv6SMCKncKpNGeCpoRpdPZ5h/8ngV8ghzVzSzCiAbmk4EPoks/Q7/5CULWeVkk3TcJyN
         ta93IFfro2KhdHzfA2fYvqjNz9R+jOkRnrzkpFhSA6epBmzgy7fCrX7dk+zwaACO4kjv
         5AzThDgJI1g0tajl1GBH6JjgL8WlnrN0MPyAZc5swvsQS5D2GS8xDxhwRgBG1AXE/HH6
         8b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764061; x=1715368861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vL7nhaiIYQuczdw6GlYf6veqmTY5SNAmlevhZLtLprU=;
        b=FnKEI9G2dpATrFfISVz8XAgw18YAUI9fsJuRlYnQpKRl4STcLRzJiDMEPEGRDQPfJK
         5TaI4VOFqQTtiY0sQZffCjMWRNoST04qhjOIiJ/tpviGi1xfjs9qsQ7o19jK3DLUoJHu
         b6sltD27pc/OW+ralNPt2tKxlCQ3zdO4AV7f4qtisQSx3Wrvn5yMOPpehyrdWq9cGYL6
         qmnZIwXF1eP1b/Le2fBsqEDJqA4elPA1cDr/2X663sNlRug5GdBl2YSiGB3KyL+gbPv9
         MxZzXcF0vF5RPqtj4ncOA0cyT2X2pt+apcQTOhNgwNXO+rtD+eUJifGJzqypM3+N2Ej2
         OmIg==
X-Gm-Message-State: AOJu0YyjKgpt5jpvj+op8OL7W/sP5FtQ9o9BiTV2YfiAr8EUez0KF+Tk
	LlHrtr5UYClJjMyjkx8cjAjOyY6T2j6uFVceKAsde5FpPq+RwA6D9j5sDuJcvCeyXRm84dktfJd
	Xlp0bpcDysw==
X-Google-Smtp-Source: AGHT+IG5EO1Vh9MUWFZloqdPuG+aiW82WrmmqZirqD53DCyniMqRzvI54mI62Wb58V8Z13wAqPXNkVeiy9rxkg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b07:b0:de4:64c4:d90c with SMTP
 id fi7-20020a0569022b0700b00de464c4d90cmr503825ybb.12.1714764061229; Fri, 03
 May 2024 12:21:01 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] rtnetlink: more rcu conversions for rtnl_fill_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to no longer rely on RTNL for "ip link show" command.

This is a long road, this series takes care of some parts.

Eric Dumazet (8):
  rtnetlink: do not depend on RTNL for IFLA_QDISC output
  rtnetlink: do not depend on RTNL for IFLA_IFNAME output
  rtnetlink: do not depend on RTNL for IFLA_TXQLEN output
  net: write once on dev->allmulti and dev->promiscuity
  rtnetlink: do not depend on RTNL for many attributes
  rtnetlink: do not depend on RTNL in rtnl_fill_proto_down()
  rtnetlink: do not depend on RTNL in rtnl_xdp_prog_skb()
  rtnetlink: allow rtnl_fill_link_netnsid() to run under RCU protection

 drivers/net/ppp/ppp_generic.c  |  2 +-
 drivers/net/vxlan/vxlan_core.c |  2 +-
 net/core/dev.c                 | 51 ++++++++++---------
 net/core/rtnetlink.c           | 90 ++++++++++++++++++++--------------
 net/ipv4/ip_tunnel.c           |  2 +-
 net/ipv6/ip6_tunnel.c          |  2 +-
 net/sched/sch_api.c            |  2 +-
 net/sched/sch_teql.c           |  2 +-
 net/xfrm/xfrm_interface_core.c |  2 +-
 9 files changed, 89 insertions(+), 66 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


