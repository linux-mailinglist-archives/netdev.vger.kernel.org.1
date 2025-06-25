Return-Path: <netdev+bounces-200985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4856AAE7A72
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37E93AC56E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCA127F18F;
	Wed, 25 Jun 2025 08:39:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DA27932E
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840763; cv=none; b=ZnOOL+IyXtDTSaNtv5BMEQB2Yy3ZBQ3GXv2zZLUPKmUJdwjejTxA/y0YfaACydEzee35i6Z1O905nJQn0qX2SdQ6ZXS+qeGybjxLnZ9xQ0GYhIlQ/SClpGquV8Q1BIf8sO98k1021Ejb9NXlXgfA9QPdb8eBhVvuaBGOXQIEbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840763; c=relaxed/simple;
	bh=CJ7Jl6g41OU3coDm07QKPHbHDsiHkOoOneOtrD6U42M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y0utR83vDJTK0CUdfdmAPvpqbcoiVlkDIdUedC732ZO6616doH/4Ywe728UOPslnhlmEKqGOpMitOV45w4oeb0D/gbfzDwDZmLA2TYvOSwicLaq82wr8ucK+Vc6M8e8tHMHWvb3TCzVR/fEDYSkQ9VbcvHWC99a06hSBBGYZvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULez-0006WJ-Iv; Wed, 25 Jun 2025 10:39:13 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-005Fdl-1b;
	Wed, 25 Jun 2025 10:39:12 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uULey-00FT0E-1O;
	Wed, 25 Jun 2025 10:39:12 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v6 0/3] bridge: dump mcast querier state per
 vlan
Date: Wed, 25 Jun 2025 10:39:12 +0200
Message-Id: <20250625-mcast-querier-vlan-lib-v6-0-03659be44d48@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALC1W2gC/02NQQ6CQAxFr2K6toQZZAiuvIdxMUCBJlCwMxii4
 e6CK5fv/7y8DwRSpgDX0weUXhx4kh3c+QR176Uj5GZnsKnNU2dzHGsfIj6XQ1N8DV5w4AqdLVx
 hL5UzpoRdrnwgrNRL3R/66FmOeVZqef317sCzTkski0JrhMd+tzqNGHsl/x/N0jLLjEuMNXlZp
 GiwTeaW41tIbzNJt0SdhNekIdi2L33KFa3TAAAA
To: netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de, razor@blackwall.org, 
 bridge@lists.linux-foundation.org, dsahern@gmail.com, idosch@nvidia.com, 
 Fabian Pfitzner <f.pfitzner@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Dump the multicast querier state per vlan.
This commit is almost identical to [1].

The querier state can be seen with:

bridge -d vlan global

The options for vlan filtering and vlan mcast snooping have to be enabled
in order to see the output:

ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1

The querier state shows the following information for IPv4 and IPv6
respectively:

1) The ip address of the current querier in the network. This could be
   ourselves or an external querier.
2) The port on which the querier was seen
3) Querier timeout in seconds

[1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2

v1->v2
	- refactor code
	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
v2->v3
	- move code into a shared function
	- use shared function in bridge and ip utility
	- link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
v3->v4
	- refactor code
	- split patch into three patches
	- link to v3: https://lore.kernel.org/netdev/20250620121620.2827020-1-f.pfitzner@pengutronix.de/
v4->v5
	- run checkpatch
	- link to v4: https://lore.kernel.org/netdev/20250623084518.1101527-1-f.pfitzner@pengutronix.de/
v5->v6
	- delete empty line
	- link to v5: https://lore.kernel.org/netdev/20250623093316.1215970-1-f.pfitzner@pengutronix.de/

Fabian Pfitzner (3):
  bridge: move mcast querier dumping code into a shared function
  bridge: dump mcast querier per vlan
  bridge: refactor bridge mcast querier function

 bridge/vlan.c      |  5 ++++
 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 59 +++-------------------------------------------
 lib/bridge.c       | 57 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 56 deletions(-)

--
2.39.5

---
Fabian Pfitzner (3):
      bridge: move mcast querier dumping code into a shared function
      bridge: dump mcast querier per vlan
      bridge: refactor bridge mcast querier function

 bridge/vlan.c      |  5 +++++
 include/bridge.h   |  3 +++
 ip/iplink_bridge.c | 59 +++---------------------------------------------------
 lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 56 deletions(-)
---
base-commit: 6331444995237782f4bdfae7d3cbef7f319d323c
change-id: 20250625-mcast-querier-vlan-lib-6276724b6119

Best regards,
-- 
Fabian Pfitzner <f.pfitzner@pengutronix.de>


