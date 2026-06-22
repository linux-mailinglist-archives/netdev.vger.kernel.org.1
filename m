Return-Path: <netdev+bounces-301012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +vrPArMAOWr6lAcAu9opvQ
	(envelope-from <netdev+bounces-301012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 698036AE3B4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:30:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301012-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301012-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E1C830254BC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C26362153;
	Mon, 22 Jun 2026 09:20:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9F368D51;
	Mon, 22 Jun 2026 09:20:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120016; cv=none; b=KVZYtZolfP3tVhf6xdhNlel7tyFW6DDUQkBiARP4QyNCDfzp1OlzfkLq9xTyJcBrJZX67ZtBvmJnmzO83alrUVeFYvWxDh2vVFR2yW5Nsi4FFlfUkHTxhMeQNHHG6+AHougt9JhGfBX9z5J/oKN303Q75IDw5Ah9xfcImOOnhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120016; c=relaxed/simple;
	bh=0b9JyH16JqUW7ieXM2+9d/GSfTdn//+UMpwrvvlHncw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y2nh8DEoarB2sKRnOtJfN3vLVKk1OSauG2lqYW5PX/NwiteNjBHQ6GJEehauc341GOVOitH+COwnl6tSuvYqBFgPcOSQpQ59Q2dnTju5mZfoppUaHNrQpkm1CYNrX45V0B3Uj4l3c7IzoOYwboEkIncEHJeI4NwKG9gHSES5Cpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E2C8E200306;
	Mon, 22 Jun 2026 11:20:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B64A1200303;
	Mon, 22 Jun 2026 11:20:02 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7E3C91800071;
	Mon, 22 Jun 2026 17:20:00 +0800 (+08)
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	shuah@kernel.org,
	vladimir.oltean@nxp.com,
	vinicius.gomes@intel.com,
	fejes@inf.elte.hu,
	xiaoliang.yang_1@nxp.com
Subject: [PATCH net-next 0/6] tc: introduce FRER action (IEEE 802.1CB)
Date: Mon, 22 Jun 2026 17:21:12 +0800
Message-Id: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[xiaoliang.yang_1@nxp.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:horms@kernel.org,m:shuah@kernel.org,m:vladimir.oltean@nxp.com,m:vinicius.gomes@intel.com,m:fejes@inf.elte.hu,m:xiaoliang.yang_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301012-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoliang.yang_1@nxp.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 698036AE3B4

This series introduces a new TC action implementing
Frame Replication and Elimination for Reliability (FRER)
as defined in IEEE 802.1CB.

The FRER action enables:
- Frame replication (push)
- Sequence numbering via R-TAG
- Frame elimination based on sequence recovery

Patch overview:
 1. Add ETH_P_RTAG definition
 2. Introduce TCA_ID_FRER
 3. Add tc_frer uAPI
 4. Implement act_frer kernel module
 5. Add tc-testing selftest JSON coverage
 6. Add kselftest integration test

The implementation currently focuses on software datapath.  Hardware
offload is exposed through the flow offload API (FLOW_ACTION_FRER);
driver-side support for specific hardware will be submitted separately.

Usage scenarios:

=== Scenario 1a: Talker End - single port (no replication) ===

  The simplest case: a single egress path.  The frer push action
  inserts an R-TAG on the egress of the physical interface.  No
  mirror or virtual interface is needed.

    CPU
     |
    eth0 egress clsact:
         action frer push index 1  <- insert R-TAG seq=N
         |
        eth0
    [R-TAG seq=N | payload]
      Path A --> network

  Configuration:

    tc qdisc add dev eth0 clsact
    tc filter add dev eth0 egress protocol ip flower skip_hw \
        action frer push index 1

=== Scenario 1b: Talker End - dual port replication via bond + cross-mirror ===

  A bond interface (balance-rr) aggregates both physical ports.  The
  frer push action is placed on each slave's egress; each slave also
  mirrors every outgoing frame to the other slave.  This cross-mirror
  ensures that every frame transmitted by the bond (regardless of which
  slave the round-robin selects) carries an R-TAG and reaches both
  physical links.  If one link goes down, the bond continues on the
  remaining slave without any traffic interruption.

    CPU (socket on bond0)
         |
        bond0 (balance-rr)
        /          \
     eth0            eth1
    egress clsact:   egress clsact:
    action frer push index 1   action frer push index 1
    action mirred egress       action mirred egress
        mirror dev eth1            mirror dev eth0
         |                              |
        eth0                          eth1
    [R-TAG seq=N | payload]   [R-TAG seq=N | payload]
      Path A --> network         Path B --> network

  Configuration:

    ip link add bond0 type bond mode balance-rr miimon 100
    ip link set eth0 master bond0
    ip link set eth1 master bond0
    ip link set eth0 up
    ip link set eth1 up
    ip link set bond0 up
    ip addr add 192.0.2.1/24 dev bond0

    tc qdisc add dev eth0 clsact
    tc filter add dev eth0 egress protocol ip flower skip_hw \
        action frer push index 1 \
        action mirred egress mirror dev eth1

    tc qdisc add dev eth1 clsact
    tc filter add dev eth1 egress protocol ip flower skip_hw \
        action frer push index 1 \
        action mirred egress mirror dev eth0

=== Scenario 2: Listener End - shared sequence recovery via bond ===

  Both physical ports are bonded (balance-rr).  Each port's ingress
  references the same recover action by index.  The first copy of each
  sequence number passes (R-TAG stripped by tag-pop) and is delivered
  directly to the bond's IP stack; the duplicate is discarded.  No
  separate convergence interface is needed because the bond already
  provides a single IP address over both slaves.

    eth0 (Path A in)            eth1 (Path B in)
    [R-TAG seq=N | payload]     [R-TAG seq=N | payload]
          |                           |
    ingress clsact              ingress clsact
    flower: match stream        flower: match stream
    action frer recover   <-->  action frer recover
        index 10 (shared,           index 10 (shared,
        tag-pop, spinlock           same action object)
        protected)
          |                           |
          +-----------+---------------+
                      |
                   bond0 (IP_DST) ----> IP stack / CPU
                              [payload, R-TAG removed by tag-pop]

  Configuration:

    ip link add bond0 type bond mode balance-rr miimon 100
    ip link set eth0 master bond0
    ip link set eth1 master bond0
    ip link set eth0 up
    ip link set eth1 up
    ip link set bond0 up
    ip addr add 192.0.2.2/24 dev bond0

    tc qdisc add dev eth0 clsact
    tc filter add dev eth0 ingress protocol all flower skip_hw \
        action frer recover alg vector history-length 16 \
            reset-time 2000 tag-pop index 10

    tc qdisc add dev eth1 clsact
    tc filter add dev eth1 ingress protocol all flower skip_hw \
        action frer recover index 10

=== Scenario 3a: Relay System - ingress sequence recovery ===

  A relay node receives redundant streams on two ingress ports and
  eliminates duplicates before forwarding.  The two ingress ports
  share the same recover action by index.  The surviving frame is
  redirected to an egress port and forwarded to the next segment.

    upstream
      
    Path A --> swp0 (ingress)   Path B --> swp1 (ingress)
                 |                          |
           ingress clsact        ingress clsact
           flower: match stream  flower: match stream
           action frer recover   action frer recover
               index 10          index 10 (shared)
           action mirred         action mirred
               redirect              redirect
               dev swp2              dev swp2
                 |                     |
                 +----------+----------+
                            |
                         swp2 --> downstream

  Configuration:

    tc qdisc add dev swp0 clsact
    tc filter add dev swp0 ingress protocol all flower skip_hw \
        action frer recover alg vector history-length 16 \
            reset-time 2000 tag-pop index 10 \
        action mirred egress redirect dev swp2

    tc qdisc add dev swp1 clsact
    tc filter add dev swp1 ingress protocol all flower skip_hw \
        action frer recover index 10 \
        action mirred egress redirect dev swp2

=== Scenario 3b: Relay System - ingress frame replication (push) ===

  A relay node receives frames from a talker on swp0 ingress, inserts
  an R-TAG, and replicates them onto two egress ports towards the next
  network segment.  FDB learning and flooding are disabled on all relay
  ports; MAC forwarding entries are configured statically to prevent
  duplicate frames from looping through the bridge.

    upstream
         |
        swp0 ingress clsact:
         action frer push index 1         <- insert new R-TAG seq=M
         action mirred egress mirror dev swp2 <- copy to Path B'
         action mirred egress redirect dev swp1 <- to Path A'
         |                                      |
        swp1                                  swp2
    [R-TAG seq=M | payload]           [R-TAG seq=M | payload]
      Path A' --> downstream            Path B' --> downstream

  Configuration:

    tc qdisc add dev swp0 clsact
    tc filter add dev swp0 ingress protocol ip flower skip_hw \
        action frer push index 1 \
        action mirred egress mirror dev swp2 \
        action mirred egress redirect dev swp1

    # Disable FDB learning and flooding on all relay ports to prevent
    # duplicate frames from looping back through the bridge.
    bridge link set dev swp0 learning off flood off
    bridge link set dev swp1 learning off flood off
    bridge link set dev swp2 learning off flood off
    bridge fdb add DST_MAC dev swp1 master static
    bridge fdb add DST_MAC dev swp2 master static

Known limitations:

  1. Only R-TAG (EtherType 0xF1C1, IEEE 802.1CB Section 7.8) is
     currently supported as the redundancy tag type.  HSR
     (IEC 62439-3) and PRP (IEC 62439-3) tag formats are defined in
     the UAPI (TCA_FRER_TAG_HSR, TCA_FRER_TAG_PRP) but not yet
     implemented; attempts to use them are rejected with -EOPNOTSUPP.
     Support for HSR and PRP tags will be added in a follow-up series.

Changes since RFC (https://lkml.org/lkml/2021/9/28/535):

  1. The frer action can now be attached to either ingress or egress
     clsact.  For talker-end frame replication the action is placed on
     the egress of the outgoing interface. For relay-system replication
     the action is placed on the ingress of the receiving interface,
     followed by mirred redirect to the egress ports.

  2. Reset timer reworked following Vinicius Costa Gomes' review.

  3. Vector recovery algorithm corrected following Ferenc Fejes' review.

  4. A bond is used on the end system to aggregate two device interfaces.
     addressing Vladimir’s comment that TC-FRER is not applicable to end
     systems. See Scenario 1b(talker end) and Scenario 2(listener end).
     The kselftest script (frer_test.sh) test this on TEST 2.

  5. Added detailed usage scenario descriptions with ASCII topology
     diagrams.  Added tc-testing JSON test cases (32 cases) and a
     TAP-format kselftest script (frer_test.sh) with five end-to-end
     functional tests and one relay bridge topology test.

Xiaoliang Yang (6):
  uapi: if_ether: add ETH_P_RTAG for IEEE 802.1CB R-TAG
  uapi: pkt_cls: add TCA_ID_FRER action identifier
  uapi: tc_act: add tc_frer UAPI header
  net: sched: act_frer: add FRER tc action
  selftest: add tc-testing JSON test cases for act_frer
  selftests: net: add kselftest for IEEE 802.1CB FRER tc action

 include/net/flow_offload.h                    |   11 +
 include/net/tc_act/tc_frer.h                  |   71 ++
 include/uapi/linux/if_ether.h                 |    1 +
 include/uapi/linux/pkt_cls.h                  |    1 +
 include/uapi/linux/tc_act/tc_frer.h           |   89 ++
 net/sched/Kconfig                             |   16 +
 net/sched/Makefile                            |    1 +
 net/sched/act_frer.c                          |  835 ++++++++++++++
 tools/testing/selftests/net/Makefile          |    1 +
 tools/testing/selftests/net/frer_test.sh      | 1013 +++++++++++++++++
 .../tc-testing/tc-tests/actions/frer.json     |  785 +++++++++++++
 11 files changed, 2824 insertions(+)
 create mode 100644 include/net/tc_act/tc_frer.h
 create mode 100644 include/uapi/linux/tc_act/tc_frer.h
 create mode 100644 net/sched/act_frer.c
 create mode 100755 tools/testing/selftests/net/frer_test.sh
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/frer.json

-- 
2.17.1


