Return-Path: <netdev+bounces-184052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B14A92FDC
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861371B637F4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70A268C43;
	Fri, 18 Apr 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMnYhm9C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840F2686BB
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942642; cv=none; b=k0iEtqGAqvgXVE4xZz9e9y+DQ7Lh1j/RtdVhlFFhJbjYRT9RBTG0zwkBmHv/v1ob5VJjHAkvyu2BBkMg8BBQDfZtQxp5dBJG3YJyBPytjTbEXtj2Ia+AgaupYZd9skTMmxiXyfjCIUsK/vfWXp9gLw8MzUGg4nzKyBWcdm4O1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942642; c=relaxed/simple;
	bh=N9Vkb/2/qy6YSp+CB8tTINpDM1Zx+KsmVi1N5yZysPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQZXZAfOdm3087Xdq8cELO7d0V2tlJVvj0QEFAySUa9Vu+FDABduaJElhYtmlLxMecy2+ngbVxEVoNk3EQhcmRKefSAfmG4rYEDVHYUTa7f74ca87tQGWfMEdvjdShoKhEibKZwJukxPomktRZ5+/6CrFfLjSlYcc7OcX2ye0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMnYhm9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D094AC4CEF2;
	Fri, 18 Apr 2025 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942642;
	bh=N9Vkb/2/qy6YSp+CB8tTINpDM1Zx+KsmVi1N5yZysPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMnYhm9CovPNdrKtSTcf9mAieJYGomeicq5gO65goZEVpga0tdd5w2VgFKFy3J04h
	 PPdxWeSw4Fz0utSPmmZT6GOqbRAVyvaEq+zNh9TU4dW4rci/UbE7wIFHIPyr/thT2J
	 imG4SPczvRoU/cW1tlJw4qydIY1ylo0XrQK/wwfgi84h8IZxWw3/AOJGAEHoaSQo3d
	 F1FWmaZ7HSg6sByJt3Xi9W9l9Ciz1RnTR5qb3T5m6zI7lyOaJ8Xua4HRvL0b2C3o9N
	 ulaDfwhyLyMgQi/FmQMZ2DyAhJZwZXWei0UPy+mEyKfGrICyLt2wmbVtYjutojxB3D
	 mBD3LkRIEoSXg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/12] netlink: specs: rtnetlink: correct notify properties
Date: Thu, 17 Apr 2025 19:17:05 -0700
Message-ID: <20250418021706.1967583-12-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The notify property should point at the object the notifications
carry, usually the get object, not the cmd which triggers
the notification:

  notify:
    description: Name of the command sharing the reply type with
                 this notification.

Not treating this as a fix, I think that only C codegen cares.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-neigh.yaml | 2 +-
 Documentation/netlink/specs/rt-rule.yaml  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index fe34ade6b300..e9cba164e3d1 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -381,7 +381,7 @@ protonum: 0
       name: delneigh-ntf
       doc: Notify a neighbour deletion
       value: 29
-      notify: delneigh
+      notify: getneigh
       fixed-header: ndmsg
     -
       name: getneigh
diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index de0938d36541..f585654a4d41 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -234,7 +234,7 @@ protonum: 0
       name: newrule-ntf
       doc: Notify a rule creation
       value: 32
-      notify: newrule
+      notify: getrule
     -
       name: delrule
       doc: Remove an existing FIB rule
@@ -247,7 +247,7 @@ protonum: 0
       name: delrule-ntf
       doc: Notify a rule deletion
       value: 33
-      notify: delrule
+      notify: getrule
     -
       name: getrule
       doc: Dump all FIB rules
-- 
2.49.0


