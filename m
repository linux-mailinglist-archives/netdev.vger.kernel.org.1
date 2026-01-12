Return-Path: <netdev+bounces-249166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E2D15522
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF49D3013EE0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787BA32ABFF;
	Mon, 12 Jan 2026 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAyxLhJw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9BE573
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251057; cv=none; b=a4Nw8Zd6mVm/bl1rl43WlXvj8Yq3iYGYeD7KiF0+T9PsqoqWc0FewwQ7vgwRqCCklf+mjM6QKcyQVVlLToLs9hkEIRwuLGk+db1AhhQEV49Rgmex9FwRKlLDpiwSCrv6LIex5RQzP5NznTwBSl3oPz4AINiiEV/A+aSdSNfKHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251057; c=relaxed/simple;
	bh=uckPNOcl/4NsEUJrOcq7QlJnEGoOKBoRA6u1ertgQF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpOoXSNXtdrNH4LKuVOCeriYQ+STeOl3kg9wc1k+dD38wfisphVsRypXL3HAHqN/SFVIBocY1ysrUQzilhbsvUbxlezcW0irClbZEYZmwVuHvYbedZ6fcx2tSgDwezhoQd/PZuEgz+G8o4xr4vb5QHeGC+bcLP5GwweyLiEpgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAyxLhJw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768251055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rIELnXNZxUE9aJxTOuMuVBMw5QH1Qanm7T3MH9M5Fws=;
	b=iAyxLhJwgGY+HQZFxwb+uHI7ywqKugmWZksdp+Hmiac2MxRrFXt1N7weu1Db3EKPwEDdHo
	/Vslnk9j08XNs/S876+tNJ0h3QM4Fs7H7ACBjSz7RBajsOrKqs7mt/MXloiXCeiNQcnSOe
	Jb9LYFyF2iuRJe6A9a8pIUU980qQxXw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-EHrKya_OOnSuGAsPTX7rrg-1; Mon,
 12 Jan 2026 15:50:49 -0500
X-MC-Unique: EHrKya_OOnSuGAsPTX7rrg-1
X-Mimecast-MFC-AGG-ID: EHrKya_OOnSuGAsPTX7rrg_1768251048
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D56141956061;
	Mon, 12 Jan 2026 20:50:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A8791800577;
	Mon, 12 Jan 2026 20:50:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH v2 net-next 00/10] geneve: introduce double tunnel GSO/GRO support
Date: Mon, 12 Jan 2026 21:50:16 +0100
Message-ID: <cover.1768250796.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 drivers/net/geneve.c                          | 532 +++++++++++++++++-
 drivers/net/vxlan/vxlan_core.c                |  16 +-
 include/linux/netdevice.h                     |   5 +-
 include/net/udp_tunnel.h                      |  32 ++
 include/uapi/linux/if_link.h                  |   1 +
 net/core/dev.c                                |   4 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../testing/selftests/net/double_udp_encap.sh | 394 +++++++++++++
 10 files changed, 954 insertions(+), 35 deletions(-)
 create mode 100755 tools/testing/selftests/net/double_udp_encap.sh

-- 
2.52.0


