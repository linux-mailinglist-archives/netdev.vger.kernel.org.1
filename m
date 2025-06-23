Return-Path: <netdev+bounces-200192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F462AE3AAD
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 11:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0924E18852E9
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9757223A58E;
	Mon, 23 Jun 2025 09:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CF23A57F
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671260; cv=none; b=Eoz/UGdxK23tK/rEnI8x5b+m/AVQPKBMxjG+hp4IqUNU4LzkrXzOFGdYdJ3CaVJ5fdreSndXRuS1OBu+Dy2/hb7TyuPAVAGThxstA+iQDEX5gmqCPQP6sv6+zlhLTlEwY0rU2zFhsuu4l7tU8TA//7FFWj63QQDgkeRYZZw8gDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671260; c=relaxed/simple;
	bh=u0IFeyGygwMjAfJsefRhNXRGve/t2QArFaHVh+uHLAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fGhHblrdligTQ+f7VDmyY5pkYQmlHASwEN8huS1rE3AjY/F4Uk8l+/qt4fXjByDdQtLMFdD9ri/5m34L4VVNphFV1/0UA1QkT730VjY66ZbCzCHj5+r495dc0jSeb/5Rg6wG/uVxyQF9NJ92hJ1XF/v6o5Dnru36aIuH5FW0mzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZ9-0007Qa-Ad; Mon, 23 Jun 2025 11:34:15 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZ9-004vM1-0F;
	Mon, 23 Jun 2025 11:34:15 +0200
Received: from fpf by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <fpf@pengutronix.de>)
	id 1uTdZ9-0056d6-04;
	Mon, 23 Jun 2025 11:34:15 +0200
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	idosch@nvidia.com,
	bridge@lists.linux-foundation.org,
	entwicklung@pengutronix.de,
	razor@blackwall.org,
	Fabian Pfitzner <f.pfitzner@pengutronix.de>
Subject: [PATCH iproute2-next v5 0/3] bridge: dump mcast querier state per vlan
Date: Mon, 23 Jun 2025 11:33:14 +0200
Message-Id: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: fpf@pengutronix.de
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


