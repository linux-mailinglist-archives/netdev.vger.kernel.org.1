Return-Path: <netdev+bounces-179678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CBCA7E161
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39AF166E79
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255ED1D79A6;
	Mon,  7 Apr 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJALCunY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D71D7E5F
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035523; cv=none; b=XCeO9wwObcA1wheNJjhxLxOgOndavyL/z4tEZjUZARuxZpNjNGExRrT1cj9Vzz0VGTU5KB6TSTL8p08l9J7aIlrQG2kR+5rg0epyL5ZXeOt9TwLMBw4GFwaEunjy+6+c9kaS8nEO8v3R2IxsccUsX39iND2QiUBDZQ7oJSp9Hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035523; c=relaxed/simple;
	bh=DnrMjwW8y80OVJq5tsXLXyJch9UJ6gA4haWZSBKjZGw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kO+0CQvE2ue3lOn3afakHGw+JXtakGGm4QHtMMKcqApwLM2c6xkB6GDb0TQBZhIe67HBcSpFgvlpxXJcV7pVMoQg2b25957B48YY7h2bafJpxDY1SjiBr6y27uC0Fn2Sd+jqniG+u/o8u+iTJaVPzlc9KKD1+F8lI5n2j5aysJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJALCunY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDAFC4CEE7;
	Mon,  7 Apr 2025 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035522;
	bh=DnrMjwW8y80OVJq5tsXLXyJch9UJ6gA4haWZSBKjZGw=;
	h=From:Subject:Date:To:Cc:From;
	b=CJALCunY5XwA6fJnawsx9DBCukkaaLIXr0IGlmoYPmZNgWE24Uc2Oj8jZBxmTEysv
	 CRhOPVHuSlXMB+pgd5W91CoFgAw/3aiFj2w6cTaXv1UxOTvU/6UrJFpnYtyMGHYMiG
	 jMlwk9Y7Y2PpC3O6+dtq1fnpKT0PCuo/oQmQuG/m2BrkV1rpBLeACRcC6FQvVHhKfO
	 xckGzy+5mPwDiDiV1tYGEuqgaBXMO4Gz72fGIdZIDp+GavAD0YqV5sDRAJtSq22Inm
	 TPDWihIpBAojtfsSKQxAMS8VPeRlaL7tLTaa1+QwFTH4s6VUIqf75G/eKyXS3srDzG
	 VGtm9bDXnqdBg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next 0/3] Add L2 hw acceleration for airoha_eth driver
Date: Mon, 07 Apr 2025 16:18:29 +0200
Message-Id: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALXe82cC/x3MPQqAMAxA4atIZgP9sYtXEYdUowaKlVZUKN7d4
 vgN7xXInIQz9E2BxJdkiXuFbhuYNtpXRpmrwSjjlNUWSVLcCJcQ75N8YAzGIyvv1NyRNdpBTY/
 Eizz/dhjf9wP4+ayfZgAAAA==
X-Change-ID: 20250313-airoha-flowtable-l2b-e0b50d4a3215
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce the capability to offload L2 traffic defining flower rules in
the PSE/PPE engine available on EN7581 SoC.
Since the hw always reports L2/L3/L4 flower rules, link all L2 rules
sharing the same L2 info (with different L3/L4 info) in the L2 subflows
list of a given L2 PPE entry.

---
Lorenzo Bianconi (3):
      net: airoha: Add l2_flows rhashtable
      net: airoha: Add airoha_ppe_foe_flow_remove_entry_locked()
      net: airoha: Add L2 hw acceleration support

 drivers/net/ethernet/airoha/airoha_eth.c |   2 +-
 drivers/net/ethernet/airoha/airoha_eth.h |  22 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 224 ++++++++++++++++++++++++++-----
 3 files changed, 215 insertions(+), 33 deletions(-)
---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250313-airoha-flowtable-l2b-e0b50d4a3215

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


