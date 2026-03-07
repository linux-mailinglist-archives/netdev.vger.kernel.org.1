Return-Path: <netdev+bounces-265067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK/nNKytq2nQfQEAu9opvQ
	(envelope-from <netdev+bounces-265067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 05:46:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC9622A14D
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 05:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62B6F3023465
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 04:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF033D4E4;
	Sat,  7 Mar 2026 04:46:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FDE33689C;
	Sat,  7 Mar 2026 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858773; cv=none; b=GJZqVpnVPILFbyLHqNXXIVn0RFLxNt7BdaLldQrHfk5SuSq50ID/TLIQJM2ls4gxX0OJ4W7PUYYixjN2xRjjqRdOIiFyvJfzoufIMJgJmwgCXdr4V7PRnmYpsasK1NYCmuscIjoqrnBfupuqpai6zveQyfWdTe7w/wCFpwXXhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858773; c=relaxed/simple;
	bh=zl5U91BqNFYXjc6IkWVIHTOokaT0BOAdekh1STHhBpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OuACBnZ5Ep2+AxNiPcKzm9BeHi9jnM/ed/apG3LoaOgElOL1VPhCw/wXTG8dA276+ddgyxcWqgbj4ja7MC6/nXmqsrQJg/EctQR066TNkABReVgFoHAXj8Kqk15tI79cT+vcZAuUuCQcW19XBgCqQdmaPn/5pg11xsjkoNj0X+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DF8A54C9A1;
	Sat,  7 Mar 2026 05:45:56 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
	Xiao Liang <shaw.leon@gmail.com>,
	shuah@kernel.org,
	petrm@nvidia.com,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v4 00/14] net: bridge: reduce multicast checks in fast path
Date: Sat,  7 Mar 2026 05:45:34 +0100
Message-ID: <20260307044548.5230-1-linus.luessing@c0d3.blue>
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
X-Rspamd-Queue-Id: DDC9622A14D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265067-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.893];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,bridge_mdb_active.sh:url,c0d3.blue:mid,lkml.org:url]
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
in commit b00589af3b04 ("bridge: disable snooping if there is no querier")
to switchdev/DSA, too. That is to notify switchdev/DSA if multicast
snooping can safely be applied without potential packet loss.

An example usage/integration of this with the modified Realtek rtl83xx
switch driver can be found in a draft pull-request at the OpenWrt
project: https://github.com/openwrt/openwrt/pull/18780
This was tested at least on an ZyXEL GS1900-24HP v1 switch.

iproute2 patch:
https://patchwork.kernel.org/project/netdevbpf/patch/20260206023704.4839-1-linus.luessing@c0d3.blue/

Regards, Linus

---

# Changelog v4

* rebased to current net-next/main branch
* ensure line lengths of 80 characters in various patches
* [PATCH net-next v3 01/14] net: bridge: mcast: export ip{4,6}_active state to netlink
  * fix intermittent "unused variable" warnings when building without IPv6 or
    without IGMP_SNOOPING support by using "__maybe_unused" annotations
* [PATCH net-next v3 02/14] net: bridge: mcast: track active state, adding tests
  * adding petrm@nvidia.com to CC
  * disabling shellcheck SC2317, as it seems to be unable to understand traps
    (https://github.com/koalaman/shellcheck/issues/2542)
    and the tests_run() function correctly
  * changing order of bridge_mdb_active.sh invocation in Makefile to keep an
    alphabetic order to make check_selftest happy
  * fixing line number passing in test_inactive(),
    `test_inactive_nolog "$1"` -> `test_inactive_nolog "$LINENO"`
  * adding `local lineno="$1"` to test_inactive_nolog() for better readability
  * reduce line lengths to 80 in bridge_mdb_active.sh to make
    netdev's checkpatch happy
* [PATCH net-next v3 03/14] net: bridge: mcast: avoid sleeping on bridge-down
  * adding const's to br_multicast_is_stopping()'s parameters
  * removing extra newline in __vlan_add()
  * fixing compilation without IGMP_SNOOPING by moving the
    spinlocking from __vlan_add() into br_multicast_ctx_init()
* [PATCH net-next v3 04/14] net: bridge: mcast: track active state, IGMP/MLD querier appearance
  * fixing compilation without IPv6 support by always including
    brmctx->ip6_active (but keeping it set to false without IPv6 support)
* [PATCH net-next v3 13/14] net: bridge: mcast: use combined active state in fast/data path
  * passing brmctx as const in br_multicast_snooping_active()
  * removing unnecessary brackets in switch cases in
    br_multicast_querier_exists()


# Changelog v3

* rebased to current net-next/main branch
* [PATCH net-next v3 01/14] net: bridge: mcast: export ip{4,6}_active state to netlink 
  * no changes, adding "Reviewed-by: Ido Schimmel <idosch@nvidia.com>"
* [PATCH net-next v3 02/14] net: bridge: mcast: track active state, adding tests 
  * fixing a race condition in the test_vlan_inactive_brdown()
    test, which would occasionally trigger and result in false
    fails, by adding a small delay, a call to test_active_setup_wait(),
    before checking the current state
  * increasing NUM_NETIFS from 1 to 2, to better reflect both sides
    of a veth pair (most places seem to use a NUM_NETIFS=2 for one
    veth pair, even though NUM_NETIFS leads to correct test results, too)
  * adding address family to error messages
  * adding line number to error messages
  * unifying common/similar code of mcast_vlan_active_check()
    and mcast_active_check() in a new mcast_active_check_ret()
  * adding bridge_mdb_active.sh to TEST_PROGS in
    tools/testing/selftests/net/forwarding/Makefile
  * avoiding ${} around variable names in bash math contexts
  * adding double quotes in several places around variables when fetching
    their values to avoid globbing and word splitting
  * adding "# skipping:" to purposefully skipped function calls in
    tests for inactive multicast state to better highlight their
    intentional difference to their fully active counterpart
  * skip the newly added bridge_mdb_active.sh test with a warning
    if iproute2 is too old
  * reducing one occurence of a double newline to a single one
    in bridge_mdb_active.sh
  * adding linux-kselftest@vger.kernel.org shuah@kernel.org to CC
  * reducing column sizes to less than or equal to 80 in a various places
* [PATCH net-next v3 03/14] net: bridge: mcast: avoid sleeping on bridge-down
  * moving multicast spinlock grabs for br_multicast_open() and
    br_multicast_stop() into these functions and
    turning br_multicast_open() and br_multicast_stop() into small
    wrapers to grab the multicast spinlock and then calling
    the otherwise not self-locking br_multicast_open_locked() /
    br_multicast_stop_locked()
    * fixes a build error with CONFIG_BRIDGE_IGMP_SNOOPING unset
  * renaming br_multicast_stopping() to br_multicast_is_stopping()
  * reworded commit message to try to clarify how the new
    timer_shutdown() use is supposed to work
* [PATCH net-next v3 04/14] net: bridge: mcast: track active state, IGMP/MLD querier appearance 
  * turn the br_info() call in br_multicast_notify_active()
    into a br_debug() to reduce potential log clutter
  * renaming br_multicast_stopping() to br_multicast_is_stopping()
* [PATCH net-next v3 05/14] net: bridge: mcast: track active state, foreign IGMP/MLD querier disappearance
  * no changes, adding "Reviewed-by: Ido Schimmel <idosch@nvidia.com>"
* [PATCH net-next v3 06/14] net: bridge: mcast: track active state, IPv6 address availability
  * no changes, adding "Reviewed-by: Ido Schimmel <idosch@nvidia.com>"
* [PATCH net-next v3 07/14] net: bridge: mcast: track active state, own MLD querier disappearance 
  * dropping the not quite fitting final statement in the commit message
    about this being the last necessary check
  * adding "Reviewed-by: Ido Schimmel <idosch@nvidia.com>"
* [PATCH net-next v3 08/14] net: bridge: mcast: track active state, if snooping is enabled
  * removing update on enabling/disabling of VLAN aware
    multicast snooping, adding it the VLAN specific patch instead
* [PATCH net-next v3 09/14] net: bridge: mcast: track active state, VLAN snooping
  * readding update on enabling/disabling VLAN aware multicast snooping
  * adding a goto in br_multicast_update_active() to avoid
    unnecessary checks
  * turning "if (!br_multicast_ctx_is_vlan(brmctx))" in
    br_multicast_update_active() into an "else if" to avoid
    unnecessary checks
* [PATCH net-next v3 10/14] net: bridge: mcast: track active state, bridge up/down 
  * adding a goto in br_multicast_update_active() to avoid
    unnecessary checks
* [PATCH net-next v3 11/14] net: bridge: mcast: track active state, prepare for outside lock reads
  * removing the unnecessary READ_ONCE() macros in spinlocked
    sections in br_multicast_notify_active() and br_multicast_update_active()
* [PATCH net-next v3 12/14] net: bridge: mcast: use combined active state in netlink
  * no changes, adding "Reviewed-by: Ido Schimmel <idosch@nvidia.com>"
* [PATCH net-next v3 13/14] net: bridge: mcast: use combined active state in fast/data path
  * changing the proto parameter to br_multicast_querier_exists() from
    int to u16
  * dropping unnecessary parenthesis in switch cases
  * avoiding lines over 80 columns for calls to
    br_multicast_snooping_active() in br_{device,input}.c and
    the br_multicast_querier_exists() definition in br_multicast.c
* [PATCH net-next v3 14/14] net: bridge: mcast: add inactive state assertions
  * replace WARN_ON()s with WARN_ON_ONCE()

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
 net/bridge/br_device.c                        |   3 +-
 net/bridge/br_input.c                         |   3 +-
 net/bridge/br_multicast.c                     | 405 ++++++++--
 net/bridge/br_netlink.c                       |  10 +-
 net/bridge/br_private.h                       |  51 +-
 net/bridge/br_vlan_options.c                  |  10 +-
 net/core/rtnetlink.c                          |   2 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/bridge_mdb_active.sh       | 742 ++++++++++++++++++
 11 files changed, 1157 insertions(+), 86 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_active.sh

-- 
2.53.0


