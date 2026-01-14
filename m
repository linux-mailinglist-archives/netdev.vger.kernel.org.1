Return-Path: <netdev+bounces-249897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F07D20835
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEC12303FE3E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A09F2E1730;
	Wed, 14 Jan 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bx2cVkjS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565D2222A0
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411274; cv=none; b=FNvRMyRZe/l7JMP62AAy5NPWaLv8yZpH5CkWbtK7HJA8m7sDJYMkyXwiap8evurEykY/aGqK2yRUGH9ShzBZrsU7/dxy1mx4yV5/Y2VK5qlY09ZWPFsKw3JIS+T2utsJBBfMPa72gTVj00V5IIiCWTeKuTi+T7gHeOYGA8cnUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411274; c=relaxed/simple;
	bh=zzg1yMXbOFKDae++Q6GAcpWYyiWlgcor8OngRI5zbnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZhG42dAzhrw/Rq63DkM01+R5up7GXTwrBL9c+bPdGjTX2cXFCF748G0/iNeTwxrdjifvh8zUO3nwUouwh+Fax2ZaC3m/heNHojCWcux2GL8iYAX04bb1+h3GA8oV46Wec1hOfu58ll+MXWuLl2T342R0ZKHsu1RNGc2iboJW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bx2cVkjS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768411271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SD0XQZNTKQ0J+iGCT6ckeWOnMeMj4edmzjmmPjAQWiA=;
	b=bx2cVkjSMhp3SrPIQgN3rAUwHDPrr0DHuG7Xi2IAHhJ+Sd82Lq0Uud6AqKYTUehKreviBj
	eMV4HxokPDWO0DwgoWbAo+Do3RHRt7XfIlD4DKf76KY2mSRT5SM24wXLK6pBjvQXwBCw3L
	SJhmTMFpib9lL4vwT7xfLxqMF6v2iZI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-NomnKdaGNz24z71kXnM59w-1; Wed,
 14 Jan 2026 12:21:09 -0500
X-MC-Unique: NomnKdaGNz24z71kXnM59w-1
X-Mimecast-MFC-AGG-ID: NomnKdaGNz24z71kXnM59w_1768411268
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C34281956058;
	Wed, 14 Jan 2026 17:21:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB79A19560A7;
	Wed, 14 Jan 2026 17:21:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	sdf@fomichev.me,
	petrm@nvidia.com,
	razor@blackwall.org,
	idosch@nvidia.com
Subject: [PATCH v3 net-next 00/10] geneve: introduce double tunnel GSO/GRO support
Date: Wed, 14 Jan 2026 18:20:33 +0100
Message-ID: <cover.1768410519.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is the [belated] incarnation of topic discussed in the last Neconf
[1].

In container orchestration in virtual environments there is a consistent
usage of double UDP tunneling - specifically geneve. Such setup lack
support of GRO and GSO for inter VM traffic.

After commit b430f6c38da6 ("Merge branch 'virtio_udp_tunnel_08_07_2025'
of https://github.com/pabeni/linux-devel") and the qemu cunter-part, VMs
are able to send/receive GSO over UDP aggregated packets.

This series introduces the missing bit for full end-to-end aggregation
in the above mentioned scenario. Specifically:

- introduces a new netdev feature set to generalize existing per device
driver GSO admission check.1
- adds GSO partial support for the geneve and vxlan drivers
- introduces and use a geneve option to assist double tunnel GRO
- adds some simple functional tests for the above.

The new device features set is not strictly needed for the following
work, but avoids the introduction of trivial `ndo_features_check` to
support GSO partial and thus possible performance regression due to the
additional indirect call. Such feature set could be leveraged by a
number of existing drivers (intel, meta and possibly wangxun) to avoid
duplicate code/tests. Such part has been omitted here to keep the series
small.

Both GSO partial support and double GRO support have some downsides.
With the first in place, GSO partial packets will traverse the network
stack 'downstream' the outer geneve UDP tunnel and will be visible by
the udp/IP/IPv6 and by netfilter. Currently only H/W NICs implement GSO
partial support and such packets are visible only via software taps.

Double UDP tunnel GRO will cook 'GSO partial' like aggregate packets,
i.e. the inner UDP encapsulation headers set will still carry the
wire-level lengths and csum, so that segmentation considering such
headers parts of a giant, constant encapsulation header will yield the
correct result.

The correct GSO packet layout is applied when the packet traverse the
outermost geneve encapsulation.

Both GSO partial and double UDP encap are disabled by default and must
be explicitly enabled via, respectively ethtool and geneve device
configuration.

Finally note that the GSO partial feature could potentially be applied
to all the other UDP tunnels, but this series limits its usage to geneve
and vxlan devices.

Link: https://netdev.bots.linux.dev/netconf/2024/paolo.pdf [1]
---
v2 -> v3:
  - addressed AI-reported possible UaF
v2: https://lore.kernel.org/netdev/cover.1768250796.git.pabeni@redhat.com/

v1 -> v2:
  - addressed AI and checker feedback
  - more stable self-tests
  - avoid GRO cells for double encap GSO pkts
v1: https://lore.kernel.org/netdev/cover.1764056123.git.pabeni@redhat.com/#t

Paolo Abeni (10):
  net: introduce mangleid_features
  geneve: expose gso partial features for tunnel offload
  vxlan: expose gso partial features for tunnel  offload
  geneve: add netlink support for GRO hint
  geneve: constify geneve_hlen()
  geneve: pass the geneve device ptr to geneve_build_skb()
  geneve: add GRO hint output path
  geneve: extract hint option at GRO stage
  geneve: use GRO hint option in the RX path
  selftests: net: tests for add double tunneling GRO/GSO

 Documentation/netlink/specs/rt-link.yaml      |   3 +
 drivers/net/geneve.c                          | 557 ++++++++++++++++--
 drivers/net/vxlan/vxlan_core.c                |  16 +-
 include/linux/netdevice.h                     |   5 +-
 include/net/udp_tunnel.h                      |  32 +
 include/uapi/linux/if_link.h                  |   1 +
 net/core/dev.c                                |   4 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../testing/selftests/net/double_udp_encap.sh | 394 +++++++++++++
 10 files changed, 975 insertions(+), 39 deletions(-)
 create mode 100755 tools/testing/selftests/net/double_udp_encap.sh

-- 
2.52.0


