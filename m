Return-Path: <netdev+bounces-194776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6690AACC56B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134611894174
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C1B230BC9;
	Tue,  3 Jun 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py/Jmgqk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4D22F755;
	Tue,  3 Jun 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950050; cv=none; b=gfHENRcNFlGEfKCKrkySWVRVVjgrZEDSntXrZ3p0STLyxFQyD3W27n2vNLAKx4eI60algrmoksejo/+1GRGdd18HSswSai9ieYDGpX4n+Tzwgq/TThrYpzMxGPUwVuAo8PHkvJd0XL7k9zcMBD8CvasQir/AzjFQdcJKmtGGTm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950050; c=relaxed/simple;
	bh=Cf9EAXyNK0VxD7speigkvYTyuNOgS7Co5M1zyvhQst0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7gtZkNuCgF0lTy3GoLaf6VqMEcTNsqkwIEdAEnPTnmGnpBptqsmG/HgknLYPefLAI/BLNn44qOg3ZVOn0EuqkJTjpLtXtbS/puZ3lml0QxdvI+nKdDJ3iVKwTob+3T90aY4Kf82sRcoO8IcDXByikhpe1zG8ZrIQz9EoAWZdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py/Jmgqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C4EC4CEF5;
	Tue,  3 Jun 2025 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950049;
	bh=Cf9EAXyNK0VxD7speigkvYTyuNOgS7Co5M1zyvhQst0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Py/JmgqkOb39XX7aOnjKeJtrVFqeYG6+9c5cJ7LVV7AKNvrckJlSA/Ry9XBh6A8I4
	 JfSBX9n7OmuSCJ+lypFSLt9PgpnUgP0ZK7Vy+3jTe8ndko6BHtuBK7LHuL+lckmCza
	 Tr7oiz2Q5qa3aSv/Q5kwg8Trr//65TYZryVT6SX/0epqilxNASYte0VERQap9Y5Cm+
	 5HTpvZvg+qnI2oxqfMlNgNklC/8rx9+YXdEk2poSeFHrS3INYKDCDYtfB16T5D1rtR
	 3SyPbI4AQd3E/mztM74svyYxKPQEz8XDSaNof1tVgXBZu4+6C9TpULtdOGXiKe5Mgb
	 Cfa7Mk93Qh81A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Jun 2025 07:27:13 -0400
Subject: [PATCH v13 2/9] ref_tracker: add a top level debugfs directory for
 ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-reftrack-dbgfs-v13-2-7b2a425019d8@kernel.org>
References: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
In-Reply-To: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Cf9EAXyNK0VxD7speigkvYTyuNOgS7Co5M1zyvhQst0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPtwZH3X/xIyqMqoat+1/9unMcXFV0vU7LgWpD
 Pqub1sJOk6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7cGQAKCRAADmhBGVaC
 FSfmEACCmSBnXr4xYbvixs+pUwJlKBT58lsHhV6RYOcn5tP9HY7Al/oYQPQ18JRwPadpO1UrSPU
 v32uOfK8G4avgm7k8hK2SEmypk55haRkNHFYZ05Mx8pOfcXlEzSJd8+l4lOXqck0PAJB1nMGXCm
 OyY8WGM4wBsEZMugAyJGVe7vPXwx+9Yiy4rOwUqrDRYgX+hUvnSCxV+GffAzWgfnbyhR6/V56jR
 iG7pj0xW6Kx1DL8l84OEh+d2n6LcMPKOkX180Sp/+6riKmTZTYtmnsLCTf2cSUwiHyO81tyG5aW
 iv964sWd5yL7BczsRCzaOhs3M8TMI3vwsDkL4yvCUuEXSlckiU6CcozuJqXYx5QKjsA2RSeu0Ih
 deNoAVmX0sBUrSRTgpJ9Ud1KXsbN4Jah3Mk+vs7Lo9cO/vWc6nPssjesdbAzMNVDOIwB1R1wVGL
 2jERfOOYDSf6qUUFrkcIKbsZUye2xJO/CwEsdW4noCZL9fedNS75BEaaH4PG5T0UHUDDgtfjfdW
 yotBTiM+RA/4pN4oeV0/WXtnGePjny34OTxUvZdgQw0F1z3zWme6FesX3NgsfMcqds6tsjIdqcg
 uu9NvdZhezXf5E/fRvLlvd3PTR1hdbHNdq/QWojsUujbHwPLR5hwMIbQR2WfW8Rk/+i54ml5bwb
 qVHiu2mOynSJQow==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "ref_tracker" directory in debugfs. Each individual refcount
tracker can register files under there to display info about
currently-held references.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index de71439e12a3bab6456910986fa611dfbdd97980..d374e5273e1497cac0d70c02c282baa2c3ab63fe 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -273,3 +273,16 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ref_tracker_free);
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static struct dentry *ref_tracker_debug_dir = (struct dentry *)-ENOENT;
+
+static int __init ref_tracker_debugfs_init(void)
+{
+	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
+	return 0;
+}
+late_initcall(ref_tracker_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


