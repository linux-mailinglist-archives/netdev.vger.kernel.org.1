Return-Path: <netdev+bounces-152740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2BA9F5A1D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D0118913D0
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EB91F8AD1;
	Tue, 17 Dec 2024 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW18wFrH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462871F8ACD
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476861; cv=none; b=Viq2eXYL7+CbeLP8dxmSy5WKkM5zSe9SJ24LrI0a8p7xprkpIvMfj0hDR9hgMKbMO2pLwQXQvrK/qgrqDZ9QamMBOWkN8XwSIY06V6BIdqwE6OwqsMFEpsX73FoZ2G5Fo7430BbJB7w14pTsctxYqpT6J1qsJ8UnZixUHkpke6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476861; c=relaxed/simple;
	bh=7mix4CBxaP5ZoGAe9DjFq7wBm6yg8IlXmZDSxySUEMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpG+/3OmzZ/HjH010O2Ml6V58OJi+MdeNYozFmTHo+gmZ0JrpLV9htjCfYsOHzaE3YOCVt4nevgIparu61+kC60oGBDlMsM2GvFlJNVQAvvz3CpHymhQLoz5Q0+s6lwOrTlGHOW7+uh7laSr/VylwajTcGlTtVSg4Dp6CLO+dI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GW18wFrH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734476858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ij5MfJPgkkaGBajKzIPKAogaLjr0K7ZGFZkweajIzh4=;
	b=GW18wFrHGu7CVlGE3QgJMezDOR34I3GgfeujFsdzLGm5pzUsZ8QBynOTpdQf51liJuxadb
	+7FCcQo7Ih8LKX6x9m/5hBdpigxFBjGQ0QzCuhm7/6uGXgPEM7n0op8BDNxT2Kp4uqGV3x
	6msAsgL3muIlmXIdWXOGdVbRG0qt+YY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-3s26DiGZP9eISVo4ZukYtg-1; Tue,
 17 Dec 2024 18:07:34 -0500
X-MC-Unique: 3s26DiGZP9eISVo4ZukYtg-1
X-Mimecast-MFC-AGG-ID: 3s26DiGZP9eISVo4ZukYtg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B649A19560A3;
	Tue, 17 Dec 2024 23:07:30 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.88.79])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56E7819560A2;
	Tue, 17 Dec 2024 23:07:28 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next v2 0/2] net/bridge: Add skb drop reasons to the most common drop points
Date: Tue, 17 Dec 2024 18:07:09 -0500
Message-ID: <20241217230711.192781-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The bridge input code may drop frames for various reasons and at various
points in the ingress handling logic. Currently kfree_skb() is used
everywhere, and therefore no drop reason is specified. Add drop reasons
to the most common drop points.

The purpose of this series is to address the most common drop points on
the bridge ingress path. It does not exhaustively add drop reasons to
the entire bridge code. The intention here is to incrementally add drop
reasons to the rest of the bridge code in follow up patches.

Most of the skb drop points that are addressed in this series can be
easily tested by sending crafted packets. The diagram below shows a
simple test configuration, and some examples using `packit`(*) are
also included. The bridge is set up with STP disabled.
(*) https://github.com/resurrecting-open-source-projects/packit

The following changes were *not* tested:
* SKB_DROP_REASON_NOMEM in br_flood(). It's not easy to trigger an OOM
  condition for testing purposes, while everything else works correctly.
* All drop reasons in br_multicast_flood(). I could not find an easy way
  to make a crafted packet get there.
* SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE in br_handle_frame_finish()
  when the port state is BR_STATE_DISABLED, because in that case the
  frame is already dropped in the switch/case block at the end of
  br_handle_frame().

    +-------+
    |  br0  |
    +---+---+
        |
    +---+---+  veth pair  +-------+
    | veth0 +-------------+ xeth0 |
    +-------+             +-------+

SKB_DROP_REASON_MAC_INVALID_SOURCE - br_handle_frame()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 01:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL - br_handle_frame()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E 01:80:c2:00:00:01 -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE - br_handle_frame()
bridge link set dev veth0 state 0 # disabled
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE - br_handle_frame_finish()
bridge link set dev veth0 state 2 # learning
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

SKB_DROP_REASON_NO_TX_TARGET - br_flood()
packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
  -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
  -p '0x de ad be ef' -i xeth0

Changes since v1:
- Add patch #1, which makes it possible to reuse the existing
  SKB_DROP_REASON_VXLAN_NO_REMOTE drop reason from vxlan in the bridge
  module, where a similar drop case exists.
- Don't add SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT. Instead, use either
  SKB_DROP_REASON_NO_TX_TARGET or SKB_DROP_REASON_NOMEM, depending on
  the case.
- For better clarity, rename SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD to
  SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE.

Radu Rendec (2):
  net: vxlan: rename SKB_DROP_REASON_VXLAN_NO_REMOTE
  net: bridge: add skb drop reasons to the most common drop points

 drivers/net/vxlan/vxlan_core.c |  4 ++--
 drivers/net/vxlan/vxlan_mdb.c  |  2 +-
 include/net/dropreason-core.h  | 18 +++++++++++++++---
 net/bridge/br_forward.c        | 16 ++++++++++++----
 net/bridge/br_input.c          | 24 +++++++++++++++---------
 5 files changed, 45 insertions(+), 19 deletions(-)

-- 
2.47.1


