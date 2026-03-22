Return-Path: <netdev+bounces-270274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NOZPB64yv2mtygMAu9opvQ
	(envelope-from <netdev+bounces-270274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:07:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 804EE2E7B13
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17DE73005AEE
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB917BCA;
	Sun, 22 Mar 2026 00:07:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403925695;
	Sun, 22 Mar 2026 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138025; cv=none; b=WRm5neYFsOHgmN7yZhvuTWS+cxuYNAu1DuiuON+/IzkHrGW9M9uUNUBU6hIt3WdFl2tS/2o4ScSL4PSNxKSUi48jWLpEgFu44KwPao2LN+5OjkZC6gi3CkgwDK/4Xt2yRrL0hIO3YQHH8KuIBj40yurV+v8opAQGGvNNWRv/Sw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138025; c=relaxed/simple;
	bh=KLIMsVn1FACgIiA/yK6zZADMcKBYWKvUiuAOaqynYqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifpXSwDzAGdcqsJyQq6WTide9bCYqSBsigbFB14Xu5eAyAydMAZgIsEhIw+RsX6SVP3oLAOLbI+2VGsBEtlXP1ksJCQFBJBtpq9rGWIcmcKzFFrVcRI2qkqFiG8ZRV5PuUitAkWiOQ2qLsAkSzUNVqITB8/bF0snMNQNS0J4R4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62M06J53021482;
	Sun, 22 Mar 2026 01:06:24 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2 device
Date: Sun, 22 Mar 2026 01:05:54 +0100
Message-Id: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-270274-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniroma2.it:mid]
X-Rspamd-Queue-Id: 804EE2E7B13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

this RFC series adds support for the SRv6 End.DT2U behavior and
introduces the srl2 Ethernet pseudowire device, together with
corresponding selftests.

Motivation
==========

The main goal is to enable L2 service delivery through an internal
SRv6 L2 endpoint, in a way similar to how VXLAN provides L2 services
through a VXLAN netdevice.

Today, Linux supports SRv6 L2 decapsulation only through an
End.DX2-style model, where the exposed Ethernet frame is forwarded
to a configured egress interface. The current implementation does
not provide a native netdevice representing the SRv6 L2 service
endpoint. This is a significant limitation compared to VXLAN, where
the tunnel endpoint is represented by a netdevice that can be
attached to a bridge and integrated naturally into the local L2
data plane.

On the encapsulation side, the existing H.L2.Encaps mode is
implemented as a route-based lwtunnel, which only intercepts packets
entering the IP routing path. Non-IP protocols such as ARP are
never routed and therefore cannot be encapsulated, making it
unsuitable for full L2 service delivery.

Design
======

This series addresses that limitation by introducing srl2, a native
SRv6 L2 endpoint interface. The intent is to make SRv6 L2 delivery
usable in the same deployment model already familiar from VXLAN: an
internal interface that represents the L2 service endpoint and can
participate naturally in local L2 forwarding.

On top of that, the series adds support for End.DT2U so that Ethernet
payloads carried over SRv6 can be decapsulated and delivered into an
L2 domain through either a bridge port or an srl2 interface.

Relation to RFC 8986
====================

RFC 8986 describes End.DT2U in terms of an abstract L2 table
associated with the SID. That abstraction specifies the externally
observable forwarding behavior of the node, but it does not mandate a
specific internal implementation. What matters is functional
equivalence.

This series enforces that property by restricting valid End.DT2U
decapsulation targets to endpoints that provide the required L2
forwarding semantics by construction.

When the target device is a bridge port, the Linux bridge provides
the expected behavior directly: source MAC learning, destination MAC
lookup, and unknown-unicast flooding within the corresponding L2
domain.

When the target device is an srl2 interface, the same model is
realized in a degenerate but valid form, corresponding to a minimal
two-port L2 domain in which one endpoint is srl2. In that case,
forwarding is trivial: frames are delivered to srl2 only when
addressed to its MAC address, or when they are broadcast or multicast.
No general FDB is required in this case because there are no
additional L2 destinations to learn.

Any other type of decapsulation target is rejected at configuration
time, since it would not guarantee the forwarding behavior required by
End.DT2U.

The srl2 device is the minimal baseline implementation providing
point-to-point L2 encapsulation with a single segment list.
Additional features can be added incrementally based on community
feedback and use cases.

Usage
=====

  ip link add srl2-0 type srl2 segs fc00::a,fc00::b
  ip link set srl2-0 master br0

  ip -6 route add fc00::100/128 encap seg6local action End.DT2U \
      l2dev srl2-0 dev dum0

  # encapsulating traffic from veth-hs into srl2-0
  ip link set veth-hs master br0

Selftest topology
=================

            cafe::1                                cafe::2
           10.0.0.1                               10.0.0.2
          +--------+                             +--------+
          |  hs-1  |                             |  hs-2  |
          +---+----+                             +----+---+
              |                                       |
        +-----+------+                         +------+-----+
        |   veth-hs  |                         |  veth-hs   |
        |      |     |   fcf0:0:1:2::/64       |     |      |
        |    br0     +-------------------------+   br0      |
        |      |     |                         |     |      |
        |   srl2-0   |                         |  srl2-0    |
        |    rt-1    |                         |   rt-2     |
        +------------+                         +------------+

The test verifies IPv4/IPv6 host-to-host and host-to-gateway
connectivity over the SRv6 L2 VPN, including ARP resolution
through the tunnel.

A companion iproute2 series provides userspace support:

  [RFC PATCH iproute2-next 0/4] seg6: add SRv6 End.DT2U and srl2 support


This is an RFC posting to collect feedback on both the overall design
and the userspace API before moving forward with a formal submission.

Comments are very welcome, especially on:
- the introduction of srl2 as an internal SRv6 L2 endpoint
- the choice of constraining End.DT2U targets to bridge ports
  and srl2 devices
- the netlink/uAPI exposure
- the selftest coverage and topology

Thanks,
Andrea and Stefano


Andrea Mayer (3):
  seg6: add support for the SRv6 End.DT2U behavior
  seg6: add SRv6 L2 tunnel device (srl2)
  selftests: seg6: add SRv6 srl2 + End.DT2U L2 VPN test

 include/linux/srl2.h                          |   7 +
 include/uapi/linux/seg6_local.h               |   3 +
 include/uapi/linux/srl2.h                     |  20 +
 net/ipv6/Kconfig                              |  16 +
 net/ipv6/Makefile                             |   1 +
 net/ipv6/seg6.c                               |   1 +
 net/ipv6/seg6_local.c                         | 160 ++++-
 net/ipv6/srl2.c                               | 269 ++++++++
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../selftests/net/srv6_srl2_l2vpn_test.sh     | 621 ++++++++++++++++++
 11 files changed, 1094 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/srl2.h
 create mode 100644 include/uapi/linux/srl2.h
 create mode 100644 net/ipv6/srl2.c
 create mode 100755 tools/testing/selftests/net/srv6_srl2_l2vpn_test.sh

-- 
2.20.1


