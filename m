Return-Path: <netdev+bounces-218178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A3B3B69F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A33561903
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063582E3B1E;
	Fri, 29 Aug 2025 09:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9C2E2F0B;
	Fri, 29 Aug 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458291; cv=none; b=t4A1uF6ojTrnZl5BhIRVdQE07dgDnagj3oZRjUGNfX84qrlqwEZSpx4NVpZbHsg6lRTwRHonh3QBjfaIjvlMWdPWZgMVt81FtEpmEPtU1bMBcE5BZc5njyJSZyXaEgwCZVM2mmwHEMusMJV6sfDR8Yw7peWuQMPppf4i5VdfkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458291; c=relaxed/simple;
	bh=7n8YIYNPVi0kbDbA88EAPm6/YdHyBwlHBbXg4fdgg7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVRdCSifHiixy7uoY85Bs/4VCpFCxnade6ezLJ2AN/ztY+SbqiRiEvlEWxDMZscsjbw/8AjOfs/QMgPNxfCoTAeIQc8nFtdkVH4lotTqseu5krWdPNRigpw5zH8lGfyOt1RM5P34ppn9JoO5bhigUFrGrHDOpEhfPeuJNUmHEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F560541275;
	Fri, 29 Aug 2025 10:57:29 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
Date: Fri, 29 Aug 2025 10:53:41 +0200
Message-ID: <20250829085724.24230-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patchset introduces new state variables to combine and reduce the
number of checks we would otherwise perform on every multicast packet
in fast/data path.
  
The second reason for introducing these new, internal multicast active
variables is to later propagate a safety mechanism which was introduced
in b00589af3b04 ("bridge: disable snooping if there is no querier") to
switchdev/DSA, too. That is to notify switchdev/DSA if multicast
snooping can safely be applied without potential packet loss.
    
Regards, Linus

---

# Changelog

Changelog to / follow-up of: [PATCH net-next 0/5] net: bridge: propagate safe mcast snooping to switchdev + DSA
-> https://lkml.org/lkml/2025/5/22/1413

* removed the switchdev/DSA changes for now
* splitting "[PATCH net-next 1/5] net: bridge: mcast: explicitly track active state"
  into:
  * net: bridge: mcast: track active state, IGMP/MLD querier appearance
  * net: bridge: mcast: track active state, foreign IGMP/MLD querier disappearance
  * net: bridge: mcast: track active state, IPv6 address availability
  * net: bridge: mcast: track active state, own MLD querier disappearance
  * net: bridge: mcast: use combined active state in fast/data path
  * net: bridge: mcast: track active state, bridge up/down

* rebased to current net-next/main:
  * from_timer() -> timer_container_of()

* net: bridge: mcast: export ip{4,6}_active state to netlink:
  * changing NLA_U8 to NLA_REJECT to make it read-only

* moved br_multicast_update_active() call from br_ip{4,6}_multicast_query_expired()
  (own querier timer callback) to br_ip{4,6}_multicast_querier_expired()
  (other querier timer callback)
  * even though both should have worked as br_multicast_querier_expired()
    would call br_multicast_start_querier()->...->br_multicast_query_expired(),
    even if the own querier is disabled, but let's use the more direct way

* simplified br_multicast_update_active():
  * no return value for now, don't track if the active state has changed,
    these aren't necessary (yet)
  * removed __br_multicast_update_active() variant as was used to force
    an inactive state in __br_multicast_stop(), instead using an
    netif_running(brmctx->br->dev) check in br_multicast_update_active()
  * replaced br_ip{4,6}_multicast_check_active() with simpler
    br_ip{4,6}_multicast_update_active() and
    br_ip{4,6}_multicast_querier_exists()
  * fixing build errors with CONFIG_IPV6 unset
* simplified br_multicast_toggle_enabled()
  * no return value for now
  * fixes "old used uninitialized" issue

* removed const from __br_multicast_querier_exists()'s "bool is_ipv6"
* replaced "struct ethhdr *eth" in br_multicast_{snooping,querier}_active()
  with direct ethernet protocol integer attributes
* added a few comments in br_multicast_update_active() calling functions


