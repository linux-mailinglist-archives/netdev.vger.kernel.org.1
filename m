Return-Path: <netdev+bounces-251978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF4ULxEEcWmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:51:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 360DB5A263
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38AA3B0E98F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7C32FA29;
	Wed, 21 Jan 2026 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBPM8yrt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EA2F5328
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011945; cv=none; b=C1ruYCfdwiK43LCduV1+zyDQWvDAJeOlRDfAOfpTKrSg3WKIzM+x1L8o5gJQp51TiIKk/yv3c4iREJYJ5EuHaibtFisLnCds6J9FA7ro71QvVnXQ5JPDKEv/Xf8oqJb2VrdQINBPEx0U6zHWKPPuiOs6KBvGgtBQA1UutLX96jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011945; c=relaxed/simple;
	bh=9Xy5mA21cS5WPiu1qjTAnViGlp0fuWYuc3N4zlNgiuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sv2sgBbGlKYbSrDvBDV+D6OCvvs46IWt/WZp5veAcjB1lJi+ABAWUascmVTXcGUZucMwuGYWYn7Zn8zWI6PN8AYfDYyIxttyoH+RweKT1mAfKm2PAXlFvtN1V3FYpgtKm5h/amC6KhQ53lfmji3biu502Ahl6P7NPR8NfLWrALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBPM8yrt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769011942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uDwquU9MUYM9gxYu9Izi/3laCYvLDlKAC9/OILdGPyA=;
	b=MBPM8yrtMV4OHbQmBRX4hEfU2wxUtb9GTNfra/besDgn7n/y3RzlPcXDw+6puSViWxilUk
	FBDYdXJWCLwbFU3471DX2RSDuVrArUJSaxQBEhzE3vQ+vp0MJqGnuDM26yYdZLKbQN0DHD
	xXXwOT9SyWpTAxjoyZIdQLw5QXmikro=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-O7uc7UXWPI6vI_T6iqsrqg-1; Wed,
 21 Jan 2026 11:12:19 -0500
X-MC-Unique: O7uc7UXWPI6vI_T6iqsrqg-1
X-Mimecast-MFC-AGG-ID: O7uc7UXWPI6vI_T6iqsrqg_1769011937
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0DBD19775F9;
	Wed, 21 Jan 2026 16:12:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A1EA1801AD1;
	Wed, 21 Jan 2026 16:12:06 +0000 (UTC)
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
Subject: [PATCH v5 net-next 00/10] geneve: introduce double tunnel GSO/GRO support
Date: Wed, 21 Jan 2026 17:11:26 +0100
Message-ID: <cover.1769011015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251978-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 360DB5A263
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
v4 -> v5:
  - set mangleid_features unconditionally
v4: https://lore.kernel.org/netdev/cover.1768820066.git.pabeni@redhat.com/

v3 -> v4:
  - better mangleid handling in patch 1
  - use xfail_on_slow in patch 10
v3: https://lore.kernel.org/netdev/cover.1768410519.git.pabeni@redhat.com/

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
 include/linux/netdevice.h                     |   3 +
 include/net/udp_tunnel.h                      |  32 +
 include/uapi/linux/if_link.h                  |   1 +
 net/core/dev.c                                |   5 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../testing/selftests/net/double_udp_encap.sh | 393 ++++++++++++
 10 files changed, 974 insertions(+), 38 deletions(-)
 create mode 100755 tools/testing/selftests/net/double_udp_encap.sh

-- 
2.52.0


