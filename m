Return-Path: <netdev+bounces-228067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11832BC095E
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 10:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E72544E416D
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77842877DC;
	Tue,  7 Oct 2025 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivpi4Msq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DD284B4E
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824955; cv=none; b=o9GCI/ApIJDb8w0qhK++pIQB2AsYlX67aFFb9j6TjtX5RMooB4nkwI2ed2gou3GQLVL/JOmF7Rkqeykatd6IWNr7lavzlYmYDwBeKdWcyT0EixfodkyclMS9a9IuMTBb4Wpm07bfMrQmao/Yy36U5F0+2hk4AHSO6MhbWTjEpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824955; c=relaxed/simple;
	bh=cPnv7w2X0stTQnku4HMN5Ut9YFp+W6zl1F8RwXMzF3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9uODSxwSiPhWFmWZ4iVG6TJjekgdKfguHwQJYVm0t5eX8oz4yTC9qa1DissGbLZOH6hXlzriIYIQ8mWZrAnwn/hsUYBUHZYUsAQPUTQqSP1vo3EuwO96LTGDDQ8TtmM+itqZWnIjocwB091tEuVAYpmIr1rmR7j6NFJ6dJ9ohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivpi4Msq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b456d2dc440so946080066b.0
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 01:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759824950; x=1760429750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf77yEGo9b9X4Y3EI1g9cCQ5ukTIt05Cnfqv6X1CMII=;
        b=Ivpi4MsqqntPo6zdODELhsRZEB/oKD74Vk7Xus+vqA//xcrjdZWqYpFkN8vsWwKzPZ
         nuFEh/9K1nBmYo9rnDwoBcGz5eoI9q5XoHfCC1TBiiTphIYYbMO0ejmlHzeDK+G9LMoy
         0+KJ7Vj6FoPeFSQ/NhIJQuH30ulD2J3Sx94nufkFJXK9eASv6uqfLkosShKSDkFJL/D9
         ITehkNxpjBQILT6/FpZuxMUmN9ItvDHmcPe4L7jGfsHUHX03DPYG8Td0hhTFPmmyyHia
         LWiBMzz3JqjHkeZvkyK+GPcCrVjZZmzTTeGu9So6NqQj7jS6cvi5W0Juxu3ceSvufz7X
         +ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759824950; x=1760429750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qf77yEGo9b9X4Y3EI1g9cCQ5ukTIt05Cnfqv6X1CMII=;
        b=c0a396Q/6/WneiUv1vleBCekPGCIYtgKXPih4lCKbtU2OXxWqoS7Bpmx/LbejmNgpV
         q4LcX5vRx3q56gWgCAiXO0rVwqb3/pXVmTbK+7cKaY70OWEYgPLfO+gbZ2zaLU2cpSwK
         V9qrvZmsmrka4opBj0WLXI8faESa/8OBZByu9Pshkn1MNkzbNuA93JoYF7K2SXCxNjIj
         /cNr+MyrU/AsI1cGKOgEBMt3oS0ToyGlQHEVXK2gUbUWMfxStXpW9utuhR2hU8J1nkXL
         KTykfGzr7IGKj8DkhGsOa5yyJXduVX2rmtaWJBDVEhhWN9wM1zK7V2vK0Beoa86moMDc
         /tTg==
X-Forwarded-Encrypted: i=1; AJvYcCWwdc83UGtq72zJZ9qnOlMmx0AtT4EgQ9TBR/TyWlwxje+h4bilJnJfJPQt6E7svk8GY0/evEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKSYOvalvT73JoIsNS8G6Ol/ShoR9Ge9TXdvVLk3FJDLP7vwX
	fF+3lj0TDZC/PLqy4kOnUTMQtVKzgXpHsy12xPacuyPhZyUbqi0FCgaf
X-Gm-Gg: ASbGnculvdd3qYaFM/lPuMsGOPWc/AlNj3Ip2bszrCa/EsTol2dEi3fzo3EYHMKhoGn
	LslagaY2U3a1qc0KhwkZqf3aYM94kcqMQUfqjO9zrMa8H0c2GNsh8aLEQ4YqKg8h9eVP3vo5+vv
	/HIrdKF/2Damuxs4asba6OOd7xak1CK2aLyJax0h6yNaP+21sykNdFBu2hkCD5R88tFg2X1EL6g
	mz+YdGQXZYotYhhSArqr1c0+kFFDJpZWTXHGN0bd70KByJYAvY17VHzC6fZBGRBJI2MIhsZgFei
	oNi5fFv06o62pfcTmK4VYL5dam99dElbiVzaf3ZRHf/ZTOipzHpmsvehkFIxOgD2b4lJo+oirEB
	J7lMcUkwVWaZ8mMBEMPCtnrxofPniGzQVA2rFY9K5Z9jW+6Pe40hvpZKiA1NFklkx22EIwyuDAN
	j+a7n+VDyymAamOelLsoAxxNJ9iMWE1Nel2K7xmSddkw==
X-Google-Smtp-Source: AGHT+IFg16oZZSoScCoFNVXKIhQVbb07lghOlKOqecH3B4hiCjRVmKapplUwUi60y/itXKHUx8ALVg==
X-Received: by 2002:a17:906:6ad2:b0:b4c:1ad1:d08c with SMTP id a640c23a62f3a-b4c1ad1d71dmr1040646866b.17.1759824949562;
        Tue, 07 Oct 2025 01:15:49 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4f7eacdfe6sm121313566b.27.2025.10.07.01.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:15:48 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v1 nf] bridge: br_vlan_fill_forward_path_pvid: use br_vlan_group_rcu()
Date: Tue,  7 Oct 2025 10:15:01 +0200
Message-ID: <20251007081501.6358-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug: br_vlan_fill_forward_path_pvid uses br_vlan_group() instead of
br_vlan_group_rcu(). Correct this bug.

Fixes: bcf2766b1377 ("net: bridge: resolve forwarding path for VLAN tag actions in bridge devices")
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

Also see the debugging info send by Florian in mailing:
"[RFC PATCH v3 nf-next] selftests: netfilter: Add bridge_fastpath.sh"

net/bridge/br_private.h:1627 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
7 locks held by socat/410:
 #0: ffff88800d7a9c90 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_stream_connect+0x43/0xa0
 #1: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x62/0x1830
 #2: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: ip_output+0x57/0x3c0
 #3: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: ip_finish_output2+0x263/0x17d0
 #4: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: process_backlog+0x38a/0x14b0
 #5: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_internal+0x83/0x330
 #6: ffffffff9a779900 (rcu_read_lock){....}-{1:3}, at: nf_hook.constprop.0+0x8a/0x440

stack backtrace:
CPU: 0 UID: 0 PID: 410 Comm: socat Not tainted 6.17.0-rc7-virtme #1 PREEMPT(full)
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 dump_stack_lvl+0x6f/0xb0
 lockdep_rcu_suspicious.cold+0x4f/0xb1
 br_vlan_fill_forward_path_pvid+0x32c/0x410 [bridge]
 br_fill_forward_path+0x7a/0x4d0 [bridge]
 ...

 net/bridge/br_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 939a3aa78d5c..54993a05037c 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1455,7 +1455,7 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group(br);
+	vg = br_vlan_group_rcu(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.50.0


