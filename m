Return-Path: <netdev+bounces-188460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0BDAACE2D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FE717A293
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D8B20487E;
	Tue,  6 May 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad+W3mdB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F537262D
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560480; cv=none; b=IsfeRqb0XkeN75a9mwrC6wMbg0rT+dkZ4p423VdhCYJWN/1HrXz883E7t9lRPSxhhPhyWIpaHehuEzvCZDfdK5XtjNY90+rTczn6Hz3q4Ea46b4QqSoPpSPit9sQTRHf3rWZp1XB76iyK5mY0/tHBf3fkFoSwDhOdBtAVY40P9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560480; c=relaxed/simple;
	bh=MnbA/0iiQTx19OTnmnIrAGf3tLY3mLnM4nkjIx8WceY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdFy8w/KeeXaGsvlHlZvxWG4m++g7kabca0x3USbr+5zw3ifCLzihGjxzJl5T7sgf8cLk42QKpuKjMmIwpKCBmcCLLHiflXblk54H62xVF5XRENL9a7PbTl3kABY0QHOwk5+GrRZcrEx0fu9wpeXmikmuuiY5iss5j2pvUdv3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad+W3mdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B0AC4CEE4;
	Tue,  6 May 2025 19:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746560479;
	bh=MnbA/0iiQTx19OTnmnIrAGf3tLY3mLnM4nkjIx8WceY=;
	h=From:To:Cc:Subject:Date:From;
	b=Ad+W3mdBdXFxFcwUubK0EclVs8qCb7RaYsLtarUpRq+36p0umOtDNrerFif7sDtnB
	 nvwf4yqedDzTCbIf2nV19hcfNmqEMCyTy5hAs6T7fUKJBdDNpIkYLJrZ+3Kq9osp0w
	 EC+xQcHMzKVmc9PogE5N2fqARnLOY9iW/FHz5KQe1C49TYAyriXJSXXIlIOcwVXt2A
	 8gMUWMFGkGjP4jWh57ce43Z6ggWvJY6De4cRSuTht8+1ZzFkgiWSrnl+VMObYleuqY
	 bukP3LjQ7vLeOSHigEDUG/cZoxCWEW5/oSNGATYBrJ2vgl0cvIOfesrMCFCcLuqNJg
	 MC92zC2lSHSkQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	johannes@sipsolutions.net,
	razor@blackwall.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/4] netlink: specs: remove phantom structs
Date: Tue,  6 May 2025 12:40:56 -0700
Message-ID: <20250506194101.696272-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt-netlink and nl80211 have a few structs which may be helpful for Python
decoding of binary attrs, but which don't actually exist in the C uAPI.
This prevents us from using struct pointers for binary types in C.

We could support this situation better in the codegen, or add these
structs to uAPI. That said Johannes suggested we remove the WiFi
structs for now, and the rt-link ones are semi-broken.
Drop the struct definitions, for now, if someone has a need to use
such structs in Python (as opposed to them being defined for completeness)
we can revist.

v2:
 - pure rebase
v1: https://lore.kernel.org/20250505170215.253672-1-kuba@kernel.org

Jakub Kicinski (4):
  netlink: specs: nl80211: drop structs which are not uAPI
  netlink: specs: ovs: correct struct names
  netlink: specs: remove implicit structs for SNMP counters
  netlink: specs: rt-link: remove implicit structs from devconf

 Documentation/netlink/specs/nl80211.yaml      |  68 -------
 Documentation/netlink/specs/ovs_datapath.yaml |  10 +-
 Documentation/netlink/specs/ovs_vport.yaml    |   5 +-
 Documentation/netlink/specs/rt-link.yaml      | 167 +++---------------
 4 files changed, 28 insertions(+), 222 deletions(-)

-- 
2.49.0


