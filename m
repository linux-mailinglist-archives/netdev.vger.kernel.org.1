Return-Path: <netdev+bounces-182269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46305A885E0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DA617882F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58D627978F;
	Mon, 14 Apr 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRy9ocqh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E2279788;
	Mon, 14 Apr 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641957; cv=none; b=GqhmIyaq6Aeyk/ftgQWGgfTlnk6ypaRPzW4CbFnJN/TsCd0cIYApyyR7O7qQkEXj7wLiaFMvJQwtCTszrglIPFCvuGI0GtsmvUO/EQkWY/kynjcMhuMOsvKkDJVDIyqOp+TAJH6SbK/l5XgoVX1Vh4y2vGY8KVc9PZKHsVI/JNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641957; c=relaxed/simple;
	bh=SSajUPnbQSKVzXF6E1uLVagrvTLcwv8/FusW/NRPovQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=me0rgAwy6rH4v6tkItJk5J4hybFStMxvZwuUFikBWLFCx2Sx6D6SMZAJNqStSmJrEpQVjtZ6YKBr5jpGx71K4qom1jFDr/ArKjpSugljHKh+Mte/QKTVKCxYzuzlTARaT0py6A1r1NEdCD2l+FJJVozV30N/H/KM/zXE23BHtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRy9ocqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E875CC4CEE9;
	Mon, 14 Apr 2025 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641956;
	bh=SSajUPnbQSKVzXF6E1uLVagrvTLcwv8/FusW/NRPovQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GRy9ocqh4N8HQI21DVIv78Zw1urvsw+0pRLfcePBTeb2plz/oV2iUkT8br3pCFAJz
	 nqty22Xj40WazHZO3TH39/mqXI9RREEZUiYb1a2AmGnQG2z7L+TY2Cb06jkg29Awqz
	 EwmC9S+MUOrALB74saINuju6c9yyePzTbvz9wPBDoYnbNB48UIrammCnIvlSSfnNKp
	 8vMQh/AlDnEWEiKTLqjHZXbNLQRUHBdpMMTJdz2aA9L/73DZ+1/GLxVMCWlA2Qbklt
	 qncYO2giRTjgC0yztuAfy17X60p8eAcx4wfgWQg27obSMYsboieHTxTt+1miBhYoq1
	 /e9h97Jw1CRbQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Apr 2025 10:45:46 -0400
Subject: [PATCH 1/4] ref_tracker: add a top level debugfs directory for
 ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-reftrack-dbgfs-v1-1-f03585832203@kernel.org>
References: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
In-Reply-To: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SSajUPnbQSKVzXF6E1uLVagrvTLcwv8/FusW/NRPovQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/R+hj2kUX5eXDLiaWqm4WPGSrs9x61tpKod4K
 XzgMxKqzV+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/0foQAKCRAADmhBGVaC
 FbCDEACQ2POkqnjyopUj3rPvwD1Sk20Xb2xJJV2km9vgHog0f6k6z9/xx2IsTN02nMlrQHFfACZ
 Q7bVotWODf1jlKfqAyqSXdhD59y6MTZyZpXWWBRpRIbVLgKyKaGNCrK67cKMBc8AR2FSpx/4+Sa
 ZJMBBKOwzzZtF7RXfxxFnsBC4CPSXQ1eh91h9m7BES3mA5QOR7IgaBex/hz12FizW1BMyYYtC/X
 L2zcwvk3KwP6NRder4LAtjkzJhhbx9z0U5Iq+y+qBT6N5wtRABZN1H52JQVnzbIbVUa1fNWy2zy
 7TwqIe/ixuIfCQ0zMC+XCEIWeXX9T88kVRULYwbUUY8jGcE5fTNOxUIShuClXJW6DG5tSBoo7cj
 imMK9zg8QeUvBBNGcVfvNCqB8atrDU4cfdRiT/P4t9FvOvJ+VZUuKpIF4IIba2wDuotLiszLpz3
 /4jQc4FWMlZpx2vqm5OieMZsH77BgXLag/BLJkpywBFh8LSp4OWdbkvRRGVANZusVBkv+5l2e9X
 CRITIyybwDK7bUUMuPTHIYuiSBXTdOUgNK9CW5AmT8wfXTb1HAjow4U0C3p6CB7C3uaUIq4Jbqm
 c99WIewg/NrsV80adSm70IVUmHA0HHm+GpAb2zmDAdov7hvFVD3mIynHH8n+MLElLDpdBdjJwJh
 3GLYxLl07LV59Rg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "ref_tracker" directory in debugfs. Each individual refcount
tracker can register files under there to display info about
currently-held references.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index cf5609b1ca79361763abe5a3a98484a3ee591ff2..c96994134fe1ddfcbf644cc75b36b7e94461ec48 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -12,6 +12,8 @@
 #define REF_TRACKER_STACK_ENTRIES 16
 #define STACK_BUF_SIZE 1024
 
+static struct dentry *ref_tracker_debug_dir;
+
 struct ref_tracker {
 	struct list_head	head;   /* anchor into dir->list or dir->quarantine */
 	bool			dead;
@@ -273,3 +275,19 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ref_tracker_free);
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int __init ref_tracker_debug_init(void)
+{
+	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
+	if (IS_ERR(ref_tracker_debug_dir)) {
+		pr_warn("ref_tracker: unable to create debugfs ref_tracker directory: %pe\n",
+			ref_tracker_debug_dir);
+		ref_tracker_debug_dir = NULL;
+	}
+	return 0;
+}
+late_initcall(ref_tracker_debug_init);
+#endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


