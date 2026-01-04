Return-Path: <netdev+bounces-246781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D807ECF1271
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529383006601
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D351ADC97;
	Sun,  4 Jan 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWwuYig8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF845BE3
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767545558; cv=none; b=SVzupTNrReOSAOMcvUY8di4kiO/hGgaDy/FpltEyTXs2JRGuLV+MMs/3bjZS11A4qCgLlCxq/bH0R6eM0gl47egN5EjfV4bQnyAI0wB+rAHe9SMJnIMFyCjI0uOfVQ6PPOmmGXaGwAToeUjJ/m8RDyKQKtPicNC62bcfBLUm58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767545558; c=relaxed/simple;
	bh=FntpX30+4RbjwCFMmWcoAaThVFpVxaRd4r/3iqGlcgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWT3XLaBKet99ZKYMcwpnflkRhhvZa0O2Zs5EIWLzZkQ8/5as+zVgDI3bxXuTRC93r++uIOoH7lDeMnjQnc17Vwzi/WmVbGUt8mlkYCvIK5a0Gd50/RBs10jZnBGOEO8ReU2+IcNZ3nCgKi4IKDDIDtddm6mdpZy+joxGwCeO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWwuYig8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A2EC4CEF7;
	Sun,  4 Jan 2026 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767545557;
	bh=FntpX30+4RbjwCFMmWcoAaThVFpVxaRd4r/3iqGlcgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=dWwuYig8ZPIYDQ1OM66p7V7rCFE3EFGb77CvXtkNVJuT7OvrWWVIY8lM2HDP7umX+
	 CZCRKxRxCBeCi0wtgqkiiChRUJXgwSEzHPEZO7LgnBrIgKA2t5JOsrqHnUKuOLKCk7
	 C+JQKUQGlIsNWPqY33oPuCo7a6q6CIiuNM6nkMHg8BW/Bx+q+p7fWCsnbBiEIRDPpz
	 kZjjP9lA2c1D8whWgeC5zh5dNDp0AW8dXmCwgALfYHxeQn5LJcIC2v1yriyEtjpeoL
	 NnPi8j4DqJyxne+OxaU0WJjPkPXH99aKfyoFzhtyhh8WAsvmgsoipPdsbAPYGZuvz5
	 s5tKPjzmYvCHQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	hawk@kernel.org
Subject: [PATCH net] netlink: specs: netdev: clarify the page pool API a little
Date: Sun,  4 Jan 2026 08:52:32 -0800
Message-ID: <20260104165232.710460-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The phrasing of the page-pool-get doc is very confusing.
It's supposed to highlight that support depends on the driver
doing its part but it sounds like orphaned page pools won't
be visible.

The description of the ifindex is completely wrong.
We move the page pool to loopback and skip the attribute if
ifindex is loopback.

Link: https://lore.kernel.org/20260104084347.5de3a537@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: hawk@kernel.org
---
 Documentation/netlink/specs/netdev.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 82bf5cb2617d..596c306ce52b 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -142,7 +142,7 @@ doc: >-
         name: ifindex
         doc: |
           ifindex of the netdev to which the pool belongs.
-          May be reported as 0 if the page pool was allocated for a netdev
+          May not be reported if the page pool was allocated for a netdev
           which got destroyed already (page pools may outlast their netdevs
           because they wait for all memory to be returned).
         type: u32
@@ -601,7 +601,9 @@ doc: >-
       name: page-pool-get
       doc: |
         Get / dump information about Page Pools.
-        (Only Page Pools associated with a net_device can be listed.)
+        Only Page Pools associated by the driver with a net_device
+        can be listed. ifindex will not be reported if the net_device
+        no longer exists.
       attribute-set: page-pool
       do:
         request:
-- 
2.52.0


