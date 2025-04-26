Return-Path: <netdev+bounces-186227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D5A9D846
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 08:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1071BC1235
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 06:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E411ABEC5;
	Sat, 26 Apr 2025 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSQEqieT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28556FC3;
	Sat, 26 Apr 2025 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648344; cv=none; b=tEvn2DxkEwG730xaC1PpQfhFPWf7vfVTgjrDEN9edXU3uZNFmkamu/zyiYbNYQKW+uGi+hRjTYAGBqw9oGkRolcwqFbNpeMME7XJG6burAUPVROXH56k45ML8UZyksP49xD60OVnzOgQJ4pe8jrHaPBITBc4PVvtl0t7isdU9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648344; c=relaxed/simple;
	bh=XBG+4wFnujKiBtnv5lY/gekFYJMd/l6RllW7ek1RzSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nLj1mvdehALusNmaVkj/Ixs/SoWKcI0VMVn1OEreWcrJiaQBEZ7XEE/BfTkgC2vo2ziAkfcvnsfH7s1s9WHD8V8GsbIIx5kw53to04UAKp67+Aa0aALXtwzqX14wRssYOHFbcG5xAX3TN8ilDEVALf0J9xTVo5kVrtua/rtFRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSQEqieT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2BDC4CEE2;
	Sat, 26 Apr 2025 06:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648343;
	bh=XBG+4wFnujKiBtnv5lY/gekFYJMd/l6RllW7ek1RzSM=;
	h=From:To:Cc:Subject:Date:From;
	b=PSQEqieTcAc2O0zsM8DHXhV5CcHJVgsAkoawjak0F2NEmC7Ig5sStWeJxyZRWrmpI
	 kp7ysY+lRuu5c7Z+ZZJyPhsrARQXtcF4tx8fMbUtIRccQIo65NwBV8McrYbJT2TdzD
	 ToJjSHskrQDMLqgx6bsB/SivwKRSbNCHf4qvssYJ172vUoQtokSO1PjXUVlMqckA0b
	 B4AhmKfSiBNtX3afp/TsHOvhKtLJQlTcjy5cVkkrkLqwKRDqldgn90DGnA3exL7v3D
	 kGadZLFDGUNF5YSs+GrpvTE5vPHGlP0IDAsaWvq8mzaDLah0CVGHehKB/w0zkXkAVq
	 6KUNgE/bxdNUA==
From: Kees Cook <kees@kernel.org>
To: Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ptp: ocp: Add const to bp->attr_group allocation type
Date: Fri, 25 Apr 2025 23:18:59 -0700
Message-Id: <20250426061858.work.470-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=kees@kernel.org; h=from:subject:message-id; bh=XBG+4wFnujKiBtnv5lY/gekFYJMd/l6RllW7ek1RzSM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8VZfdGZw/nOf6tKyuQoF7w6lTN5RCj3R9l66wmHHd7 MRLdzXOjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIls7GJkmK6b+Xn+RX4/8UOP Hp6+ftllm3lq8c6OpKadJVvad82cKcTI8DVCM+7v9Tu7dh5MuC24T8HSMz/z3dez/z72L90Zlu4 gwwcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "const struct attribute_group **", but the returned
type, while technically matching, will be not const qualified. As there is
no general way to safely add const qualifiers, adjust the allocation type
to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index faf6e027f89a..ed5968a3ea5a 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2372,7 +2372,7 @@ ptp_ocp_attr_group_add(struct ptp_ocp *bp,
 		if (attr_tbl[i].cap & bp->fw_cap)
 			count++;
 
-	bp->attr_group = kcalloc(count + 1, sizeof(struct attribute_group *),
+	bp->attr_group = kcalloc(count + 1, sizeof(*bp->attr_group),
 				 GFP_KERNEL);
 	if (!bp->attr_group)
 		return -ENOMEM;
-- 
2.34.1


