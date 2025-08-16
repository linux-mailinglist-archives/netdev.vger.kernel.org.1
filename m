Return-Path: <netdev+bounces-214354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A8B290E9
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 01:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC394580DA8
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 23:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C115A23E35B;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZHHm6Rh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3DD1B423C
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755385988; cv=none; b=SqlNHDVGlORWFRmCmty8XI6iDgJNRIXFC+jMVIVWE3XBbwf2Ru9tbqmAgqOTu5m/LE+0Y3Luq8TketG3N+fhCDTtLcoBhBzq/5wif3OLIgo/A2EBBeFQtbcKeHb8UPKASwzPgXZjp+elhy16J+IU1Oylcmw9TUTipquq2TrL6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755385988; c=relaxed/simple;
	bh=6oq/r2Duv8TUJtLlhHnfA58qlBeaNbRXlhksPZnzC4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oMBImnKifX/6/ssJ4vTGjMlMGZXQtgPl5QO5t3LwamgY7n3w9ohojbfNFlBMpN8R5gKcGZUzf2m1RwTggxXnaoAf4EJyMis8OyPxwmE0ZMqEXkb1DGrMA/vtU602tMZbto8xG9mgyMrKLIe8oYm+vGgg6Xr+aSzHoERs5B4koj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZHHm6Rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28B3EC4CEEF;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755385988;
	bh=6oq/r2Duv8TUJtLlhHnfA58qlBeaNbRXlhksPZnzC4w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kZHHm6Rh0BTLRdE1/ceX89Myb2nD4VINMCI87nThv3wXS7/RaY4dJrvLJXDlZRRiN
	 QnAlRD3HdCScql9XsgB5qUCfUJNhxk9C9WxI6LJllXYodqUbQUscwcvs4Hm1IioZgk
	 spEXN0XeXSmndUsZ+sa5mtFmSBSKrqb6+Ui/djAdhlV2HG61DQlFE1I7RyJrEgGo57
	 qLidM9EmqgWlDdDoZHfooh7Rgf4PD5q8xQi+xpbp/Hb8RvLy3pguDou3pS1HSO2PwL
	 Dv3zcT6OfKeAar13MWr/sEAW9DaLu3lmNUfg08q+EIxSywUGeOfJIkCBkaWtPCoq+E
	 BUzcyTvDTkFdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DBACA0EE4;
	Sat, 16 Aug 2025 23:13:08 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Subject: [PATCH net-next v2 0/2] net: Speedup some nexthop handling when
 having A LOT of nexthops
Date: Sat, 16 Aug 2025 16:12:47 -0700
Message-Id: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG8QoWgC/22NywrDIBREfyXcdS3RvKCr/kcIJeq1uYuoqA0pw
 X+vuO5yODNnLogYCCM8mgsCHhTJ2RLErQG1rfaNjHTJIFoxtJPomcUzbc6/9Gf3zIyqE/0kpNI
 GysQHNHRW3QwWU23DUshGMbnwrT8Hr/y/8uCMs1H2nTFGD3JVT+fRrnRXbocl5/wDZKxDo7MAA
 AA=
X-Change-ID: 20250724-nexthop_dump-f6c32472bcdf
To: David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755385987; l=1201;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=6oq/r2Duv8TUJtLlhHnfA58qlBeaNbRXlhksPZnzC4w=;
 b=g8diLrmD17CmCr2q08HjVmvpTapBE/z+gcgdw+hgV8J2E7Qjp2+DGqmWfEYkPjfbBy/k8R1KR
 ScpZCndKkbBC2pnFdEARxR/9uBbYVXZwnxsK9cZbhDX0AOAOU1Fr/7C
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

Configuring a very large number of nexthops is fairly possible within a
reasonable time-frame. But, certain netlink commands can become
extremely slow.

This series addresses some of these, namely dumping and removing
nexthops.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
Changes in v2:
- Added another improvement to the series "net: When removing nexthops,
  don't call synchronize_net if it is not necessary"
- Fixed typos, made comments within 80-character limit and unified
  comment-style. (Ido Schimmel)
- Removed if (nh->id < s_idx) in the for-loop as it is no more needed.
  (Ido Schimmel)
- Link to v1: https://lore.kernel.org/r/20250724-nexthop_dump-v1-1-6b43fffd5bac@openai.com

---
Christoph Paasch (2):
      net: Make nexthop-dumps scale linearly with the number of nexthops
      net: When removing nexthops, don't call synchronize_net if it is not necessary

 net/ipv4/nexthop.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)
---
base-commit: bab3ce404553de56242d7b09ad7ea5b70441ea41
change-id: 20250724-nexthop_dump-f6c32472bcdf

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



