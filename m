Return-Path: <netdev+bounces-241560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3BC85E30
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4DD1342AB7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8F523183F;
	Tue, 25 Nov 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKabxgKF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F7222578
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087099; cv=none; b=WabqKmfVl+H9jjRfZwIlq/qrtDtgss4YgX94/F5bO+Rzmuxc+35qFw9C/mfUth0IRFvu/ftV6SlyJFVUwViP4w0D+HUhMRRyv/it/6ldNKUNr8LmeCROWfXHBlJtf9/e/LgJYhRVxTR9wp4+ysVP4tTcq4KKNHvswMz6w6Y1xUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087099; c=relaxed/simple;
	bh=nA+k6iX459snoTOM0GGJbS4jLXPAcaEsfIkYacHVgUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNfUb9+BEDxpVVEHmjDtN5BkB9+3paXL/6Sj8Y/5M/NNe+aWr1l8EhQErUW0ib9q9l3LpDxnVdzTDvBU8vSJUSkgcJnPw0fNrQ3pVWGiugN3seS/y9PzABu3Qw5Kk8+CM8dywqb7X/2KKh8bYncAFgMaQzNi6usp+vF9fuPKez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKabxgKF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764087096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cbzUnzLbnw2rNklTyEmC18llDge/w8iFlOT6nojAbRM=;
	b=iKabxgKFO+WmEmKhEgtSL8S027q75CeTxqViZ1JAsFuGgLDO/nERUadTnzgLhvrh+qjURV
	9TZ2D0iE3HAmKu+rdymsszBIu50d4VMDbwkvbtFUIsEbAO3jNdycraQxF8+TSsjQ3lnVQL
	YzBPhOBDk9NCLrbkxVBpEv6bL+SH4U8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-8Ks9OxspOVW3hLDSjfJWig-1; Tue,
 25 Nov 2025 11:11:33 -0500
X-MC-Unique: 8Ks9OxspOVW3hLDSjfJWig-1
X-Mimecast-MFC-AGG-ID: 8Ks9OxspOVW3hLDSjfJWig_1764087088
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A4EF1800561;
	Tue, 25 Nov 2025 16:11:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.183])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA13A1800451;
	Tue, 25 Nov 2025 16:11:24 +0000 (UTC)
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
Subject: [PATCH net-next 00/10] geneve: introduce double tunnel GSO/GRO
Date: Tue, 25 Nov 2025 17:11:05 +0100
Message-ID: <cover.1764056123.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 drivers/net/geneve.c                          | 520 +++++++++++++++++-
 drivers/net/vxlan/vxlan_core.c                |  16 +-
 include/linux/netdevice.h                     |   5 +-
 include/net/udp_tunnel.h                      |  32 ++
 include/uapi/linux/if_link.h                  |   1 +
 net/core/dev.c                                |   4 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/double_udp_encap.sh | 340 ++++++++++++
 9 files changed, 888 insertions(+), 34 deletions(-)
 create mode 100755 tools/testing/selftests/net/double_udp_encap.sh

-- 
2.52.0


