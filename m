Return-Path: <netdev+bounces-178949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F6FA799C0
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FBC188818C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425413632B;
	Thu,  3 Apr 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzBc0ApE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EF12E1CD
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644242; cv=none; b=uHCpfxq4hv2fv9Jy5ry04LWzt3ngEKxDvBV016QfjhZ+ahBkAATmXp+zfPFeKQ/HID5y9gwIRjHRFP7W/wBh8sY0GF1fKTXS21rDkPiy0k0eO0kgKMFhJvA8RfEe0AtL1QxcmwJ72bolERfboCm+TqPDJxHgrgcQn6kcRc+0q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644242; c=relaxed/simple;
	bh=/kImV4XJUxupbxJH+jfWJ0vpKr9dSQl4P3O9hHL+PAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fx7QdVQclwxZaaoC+BncMVDEodi2cYHo4U+U1Hg2STiPRGg8hp3mh2Yx2auvjhUrc9WQDpwVGZ/yBSLaJfzYtLa55t6NmlkImzFVPCH+K1M1TU4Gd/xk9jG4bMTVMrWTaJa4aiNlUCPttThVDOoOQAJFUpGtT/1/0m2NKQP9QaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzBc0ApE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6F9C4CEDD;
	Thu,  3 Apr 2025 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743644241;
	bh=/kImV4XJUxupbxJH+jfWJ0vpKr9dSQl4P3O9hHL+PAk=;
	h=From:To:Cc:Subject:Date:From;
	b=FzBc0ApERaewQX5gsVRoYy/IFtFz2vMOYwLIbqGm/jUB0iF5CKiOggj3RK8oNixRc
	 A1x2xC3SdmKQylPkxeMzOsghA6ecupu1vgOg9Y9Oi+C7i0k/3i9j/sgZuC8FG9iHOf
	 y7ffrC8IENh0gdp/A61yrL17rqzLdv6gYY6rFCKDipoCs5D2XmXwoks8pgg/8A0GrI
	 Qxyv+ZwtM0gXyGSUXTm2672NpgSa51zZDfHvkLVgwsRkSjUAeiH1qvJHRK+h6Elumm
	 xH3zgxYXDoYfHwFsiQNJt25uNReavQPuRrW8/uRPyDIxX/UHPI5miInqAfHY97sTAD
	 C6EQR4g5DX2EQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	yuyanghuang@google.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v3 0/4] netlink: specs: rt_addr: fix problems revealed by C codegen
Date: Wed,  2 Apr 2025 18:37:02 -0700
Message-ID: <20250403013706.2828322-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I put together basic YNL C support for classic netlink. This revealed
a few problems in the rt_addr spec.

v3:
 - fixes from Donald on patch 2 and 3
 - patch 4 is new
v2:
 - fix the Fixes tag on patch 1
 - add 2 more patches
v1: https://lore.kernel.org/20250401012939.2116915-1-kuba@kernel.org

Jakub Kicinski (4):
  netlink: specs: rt_addr: fix the spec format / schema failures
  netlink: specs: rt_addr: fix get multi command name
  netlink: specs: rt_addr: pull the ifa- prefix out of the names
  netlink: specs: rt_route: pull the ifa- prefix out of the names

 Documentation/netlink/specs/rt_addr.yaml  |  42 ++---
 Documentation/netlink/specs/rt_route.yaml | 180 +++++++++++-----------
 tools/testing/selftests/net/rtnetlink.py  |   4 +-
 3 files changed, 115 insertions(+), 111 deletions(-)

-- 
2.49.0


