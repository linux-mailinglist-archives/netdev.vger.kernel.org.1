Return-Path: <netdev+bounces-186129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DEDA9D470
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD17A3725
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3CB21D3C5;
	Fri, 25 Apr 2025 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+IE+beV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDD215F6E
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617700; cv=none; b=VHGmh98pozdvDPkY469rZB3jKK8qDXJwKBUuD9oFSuDpD344NgpG1h71Hjl73yc3WJbu9WsFbasclSpaZjpHIsCyb1R4sm5qy6RUZkUaT9AWlYtxeC2KhiZ0aGAwvp2sJZ16ty6f1Ay9KbIN/Px2XVyZxCt3Dvg5jFrFZY4eq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617700; c=relaxed/simple;
	bh=YvdbH0wltp+9JHwrAJCQbIMLHBVucB1FSZQYOCGy+Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StxxsoLX/MDXJJX8Nmh4ydAYDQ1xMNaNEL1MYkOe2hbuHrjYUT3ia7CRgKfb40HxgSWjssYiykdBjGwL0zsfeo5WAxt1uASQDnjdWRzoyHNCiH3wg93q1PR4f9J6acuHEer9sp8JHCWaMhw2pKC5949T7Ar9BTPq1BYb+1rVYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+IE+beV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD0FC4CEE4;
	Fri, 25 Apr 2025 21:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617700;
	bh=YvdbH0wltp+9JHwrAJCQbIMLHBVucB1FSZQYOCGy+Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+IE+beV5zmk7+gWUO3hctCEdbgFVsc6grjXPqRmTY9t5MMj8xC2S8Y1bIJtbzJTW
	 1QVfAr+uPnpevWzFG0UXG7l+gVYuHS8VY2YBgSBhF5Lq88NadQRGAxsBFYp8c5rKqQ
	 IDHkgk3zEYzMKCRvHTN+Uaez5rxcEkDkMshUSMJW0/8o9Tdb0568i1Yi67Qy8kdnI7
	 Kcl0hjqtbbfDPq4SRII9kd1b2tTP8/SXBThPS5agLQBRAdIGGS/UQ/drnXfTI+44xT
	 IYE8/f24b/shvpgnNiYHqboWnDj2i5g0tKKKh2s/LbTcoABWgRIq03ozdZtqZCsr7D
	 AOkWE7BqHnlBQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 01/15] tools: ynl-gen: allow noncontiguous enums
Date: Fri, 25 Apr 2025 14:47:54 -0700
Message-ID: <20250425214808.507732-2-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425214808.507732-1-saeed@kernel.org>
References: <20250425214808.507732-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In case the enum has holes, instead of hard stop, avoid the policy value
checking and it to the code.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0d930c17f963..56d6aa162773 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -358,10 +358,10 @@ class TypeScalar(Type):
         if 'enum' in self.attr:
             enum = self.family.consts[self.attr['enum']]
             low, high = enum.value_range()
-            if 'min' not in self.checks:
+            if low and 'min' not in self.checks:
                 if low != 0 or self.type[0] == 's':
                     self.checks['min'] = low
-            if 'max' not in self.checks:
+            if high and 'max' not in self.checks:
                 self.checks['max'] = high
 
         if 'min' in self.checks and 'max' in self.checks:
@@ -862,7 +862,7 @@ class EnumSet(SpecEnumSet):
         high = max([x.value for x in self.entries.values()])
 
         if high - low + 1 != len(self.entries):
-            raise Exception("Can't get value range for a noncontiguous enum")
+            return None, None
 
         return low, high
 
-- 
2.49.0


