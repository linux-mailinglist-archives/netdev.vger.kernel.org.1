Return-Path: <netdev+bounces-257416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPtyMcpZhWnNAQQAu9opvQ
	(envelope-from <netdev+bounces-257416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:02:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29503F9805
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDCEF3012EBF
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5189C21CFE0;
	Fri,  6 Feb 2026 03:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028513AD26;
	Fri,  6 Feb 2026 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346898; cv=none; b=QVaqj1la5bQD9L8EDAWDSGVLDC78wbw0yU4k8+JdhZ/go8WDud3k6RCzTmmZo7HVXRMTxbNrm96uq8VFQSgzSEjpiCyBogSWdIb7YpXRELJMbtTmZgaVCCclT0BxXviaw35hbEQjznr8XRFOdHoW2d5eoC/fsH/qlzaosDdE08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346898; c=relaxed/simple;
	bh=ph1b516pflgDJTJk68FZ/fNTTr2UOapnr3TDaqCE5Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFuMYE0I5HpnssgOFfX4wpecTgA45lVT69Z/abc5U2VjpAeRhwguPnW8OwwIW5FbxTvTMxUgLy98qj4yBLIBusiIu5PxT4h/Ez/wPIZYh8WH/Y7+jwa9ug+/Aybtg7Ti7RoaPmiFx8pfiAis0Rmr6y1JBcdgXZOw73R14WUM300=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41C4554C9F3;
	Fri,  6 Feb 2026 04:01:32 +0100 (CET)
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
Subject: [PATCH net-next v2 00/14] net: bridge: reduce multicast checks in fast path
Date: Fri,  6 Feb 2026 03:52:06 +0100
Message-ID: <20260206030123.5430-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,c0d3.blue:mid]
X-Rspamd-Queue-Id: 29503F9805
X-Rspamd-Action: no action

This patchset introduces new state variables to combine and reduce the
number of checks we would otherwise perform on every multicast packet
in fast/data path. Instead of checking if our querier is enabled or
if another querier timer is pending, plus if the initial query
grace period has elapsed, plus for IPv6 and for our own querier if we
have an IPv6 address yet - and all this for every multicast packet -
we can now simply check one boolean state variable per protocol family
combining all this, the new ip{4,6}_active. Or MCAST_ACTIVE_V4 /
MCAST_ACTIVE_V6 to netlink/userspace.
  
The second reason for introducing these new, internal multicast active
variables is to later propagate a safety mechanism which was introduced
in b00589af3b04 ("bridge: disable snooping if there is no querier") to
switchdev/DSA, too. That is to notify switchdev/DSA if multicast
snooping can safely be applied without potential packet loss.

An example usage/integration of this with the modified Realtek rtl83xx
switch driver can be found in a draft pull-request at the OpenWrt
project: https://github.com/openwrt/openwrt/pull/18780
This was tested at least on an ZyXEL GS1900-24HP v1 switch.

iproute2 patch:
https://patchwork.kernel.org/project/netdevbpf/patch/20260206023704.4839-1-linus.luessing@c0d3.blue/

Regards, Linus

---

# Changelog v2

Summary of notable changes:

With the newly added selftests things are moved around a bit,
to be able to early on verify every commit that the general
and netlink ABI behaviour did not change.

The locking for br_multicast_open() and br_multicast_stop()
is now more symmetric.

The newly added tests revealed that in the previous pull-request
the checks were insufficient/incorrect when using VLANs, this
got fixed.

An inactive assertion / kernel splat was fixed.


* all: rebased to current net-next/main (a90f6dcefca6)
* [PATCH net-next v2 1/14] net: bridge: mcast: export ip{4,6}_active state to netlink
 * removed the ip{4,6}_active state variables for now,
   using/mimicking the current checks used in fast-path
   to define the intended result for the netlink/userspace ABI
 * br_vlan_global_opts_fill(): removing "const" from
   "struct net_bridge_vlan *v_opts" (for now), to allow
   dereferencing it
   br->multicast_ctx.ip{4,6}_active to start with,
* [PATCH net-next v2 2/14] net: bridge: mcast: track active state, adding tests
  * NEW: test that the new netlink interface has the intended results
* [PATCH net-next v2 3/14] net: bridge: mcast: avoid sleeping on bridge-down
  * NEW: to be able
* [PATCH net-next v2 4/14] net: bridge: mcast: track active state, IGMP/MLD querier appearance
  * adding br_multicast_notify_active() with a simple br_info()
    to start with to track the evolving ip{4,6}_active behaviour
  * br_ip{4,6}_multicast_query_delay_expired(): don't enable
    ip{4,6}_active if we are about to get disabled by
    adding/checking br_multicast_stopping()
  * adding protocol specific ...delay_timer.function resets
    in (new) br_multicast_reset_timer_cbs(), instead of
    changing timer_setup()s in br_multicast_ctx_init()
* [PATCH net-next v2 5/14] net: bridge: mcast: track active state, foreign IGMP/MLD querier disappearance
  * unchanged
* [PATCH net-next v2 6/14] net: bridge: mcast: track active state, IPv6 address availability
  * unchanged
* [PATCH net-next v2 7/14] net: bridge: mcast: track active state, own MLD querier disappearance
  * unchanged  
* [PATCH net-next v2 8/14] net: bridge: mcast: track active state, if snooping is enabled
  * renamed title: "... mcast: active state ..."
    -> "... mcast: track activestate ..."
  * adding VLAN aware check for BROPT_MCAST_VLAN_SNOOPING_ENABLED
  * removing misplaced, second br_multicast_update_active(brmctx)
    in br_multicast_toggle_one_vlan()
* [PATCH net-next v2 9/14] net: bridge: mcast: track active state, VLAN snooping
  * NEW
* [PATCH net-next v2 10/14] net: bridge: mcast: track active state, bridge up/down
  * adding mcast-spin-lock around br_multicast_open() in br_dev_open()a
  * adding mcast-spin-lock around br_multicast_update_active()
    in __br_multicast_stop()
  * removing (now already locked) mcast-spin-lock addition
    in br_multicast_toggle_one_vlan()
  * removing (now already locked) mcast-spin-lock addition
    in br_multicast_toggle_vlan_snooping()
* [PATCH net-next v2 11/14] net: bridge: mcast: track active state, prepare for outside lock reads
  * NEW
* [PATCH net-next v2 12/14] net: bridge: mcast: use combined active state in netlink
  * NEW (partially from: "net: bridge: mcast: export ip{4,6}_active state to netlink")
* [PATCH net-next v2 13/14] net: bridge: mcast: use combined active state in fast/data path
  * using READ_ONCE() on ip{4,6}_active states
* [PATCH net-next v2 14/14] net: bridge: mcast: add inactive state assertions
  * with the moved lock, bail out early if we are about to
    get disabled (via br_multicast_stopping()) and just entered
    br_ip{4,6}_multicast_querier_expired()
  * removed br_multicast_assert_inactive() in
    br_multicast_toggle_one_vlan(), as it can toggle to enabled

# Changelog (v1)

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

Linus Lüssing (14):
  net: bridge: mcast: export ip{4,6}_active state to netlink
  net: bridge: mcast: track active state, adding tests
  net: bridge: mcast: avoid sleeping on bridge-down
  net: bridge: mcast: track active state, IGMP/MLD querier appearance
  net: bridge: mcast: track active state, foreign IGMP/MLD querier
    disappearance
  net: bridge: mcast: track active state, IPv6 address availability
  net: bridge: mcast: track active state, own MLD querier disappearance
  net: bridge: mcast: track active state, if snooping is enabled
  net: bridge: mcast: track active state, VLAN snooping
  net: bridge: mcast: track active state, bridge up/down
  net: bridge: mcast: track active state, prepare for outside lock reads
  net: bridge: mcast: use combined active state in netlink
  net: bridge: mcast: use combined active state in fast/data path
  net: bridge: mcast: add inactive state assertions

 include/uapi/linux/if_bridge.h                |   2 +
 include/uapi/linux/if_link.h                  |  14 +
 net/bridge/br_device.c                        |   6 +-
 net/bridge/br_input.c                         |   2 +-
 net/bridge/br_multicast.c                     | 351 +++++++--
 net/bridge/br_netlink.c                       |  10 +-
 net/bridge/br_private.h                       |  45 +-
 net/bridge/br_vlan.c                          |   5 +
 net/bridge/br_vlan_options.c                  |  10 +-
 net/core/rtnetlink.c                          |   2 +-
 .../net/forwarding/bridge_mdb_active.sh       | 682 ++++++++++++++++++
 11 files changed, 1048 insertions(+), 81 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_active.sh

-- 
2.51.0


