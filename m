Return-Path: <netdev+bounces-183757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C0A91D75
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4D13ACA3C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDAB24E01C;
	Thu, 17 Apr 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsUJLo3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5E24E015;
	Thu, 17 Apr 2025 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895488; cv=none; b=Glai7o5LUriABJ3mTnwyhgNutih22M0YQ4Q6p8JuMdozLyeuiu1YdYF2UXH8NTr7xVFLhSWbPlU80RRhG4+9URvA0x4Wc0OqzU/dpdcpQkQCCtU7w6jgZMDww/5QahyUDu9F/km6klXnouRMN303AkLdfv/0uAKxx/h3BEWIJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895488; c=relaxed/simple;
	bh=VxNG+3kfMXcsChPXbcYSbdNMZb9CE7AA2dokZt8gS0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QA1VQ5+kHNy8ItvJ6qvX0k/lNfhsJywegQX6h4w7G0fnh9qRIUFJf8qk2X7YSB+nefTnGbw6KaLsEtw5n8TfKy9nlcWxjtg+le0omdlg3gW7xr0YLNKX0T0C3wFzbmEzlb7W9KtBC3VI94yKD4fQgSFJGv/PmwWHc1Wt4ywtHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsUJLo3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052A8C4CEED;
	Thu, 17 Apr 2025 13:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895488;
	bh=VxNG+3kfMXcsChPXbcYSbdNMZb9CE7AA2dokZt8gS0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rsUJLo3X/YuVNBFzu6WDHNJNMsLaQ7EoHx5N7+SkW/91E3KfCsfXPZMW54dRVhxSe
	 kRkE0Ju5HnO6lR84Ur8z4w0MOOVp8doDqVayt0NeR1jR42KsR75l+eHnD9moz4/27L
	 BBdCJqOgE/JnXw2LQ7SWvdR+xiW/PvoWjiteRiZtRx8L8un8Idbc39E4+N0Oy/Cz1m
	 6TXPi2VPMyoYcKJUDKHci3ggLhIzQroyi3gniXEfd3vgbLkQVQeOKU4S8BYAEoCL6y
	 dMl+DpXVP+8g6P/gYZER/QMf543jUni7RaLQAQbgTwyN/P/RzbohUDoejTX47mQVf3
	 GAY2VJPY++etg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:09 -0400
Subject: [PATCH v3 6/8] ref_tracker: widen the ref_tracker_dir.name field
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-reftrack-dbgfs-v3-6-c3159428c8fb@kernel.org>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
In-Reply-To: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=887; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VxNG+3kfMXcsChPXbcYSbdNMZb9CE7AA2dokZt8gS0M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAP32DLpr0qqDT6PpD04gsIth9lWw0ZlM+D2O1
 PHOqpkcRwmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAD99gAKCRAADmhBGVaC
 FTi/D/9mynpNva2Y2s31P55ufruy9DtpXDT1sNWDjCjRuuYjQrqWIPPAZDVlJr7S6OlTbMxCVwl
 fujLlQdts7jskbME2uCpDtiCTaLgZItG1FaUecB+DvlrS9dd/aOhrrMo+he0N8rlX/u2Jcq5r/j
 I+wOlmsVm0C0sO8+SL2B3Xt/hNMwYselTSNGs5qanYLcKELFo66HcNseVrsYO9HqR6XFUQig4k9
 rx8ycya02wzdegNIg2myg0WbES0EdHdSNQvsyu9mR2p+Jxr35kqdnOZLQRlcCUpSwJs6m7BghvM
 neoY56ozidgBAdwm/3YnwTZvyROHwoeq36mxNHPHjIubAlNHliIzvUwKFovNXupSzv518Hlo9cI
 knwmQdD2A3EJCxSXNudAoGC0PsKTsAgvI3+vvY5l2/3FpNOGUObFxu3Y0SL4tLVby4Zl62XjIIr
 1wgWSP97aIvxYMhh+bxSnEVRwv+Ns20Yfcu7iri5mRsChReGUPVezPo4ED64Qh+ZuvVUzc1lEDL
 HxrUIQRs9f4jzIjjJKZ2VX4oiH9QscBWqLpoaEeNyOVXONXczFLK9yC0Sy/z19XFtkKXPJg9/el
 3DHb6z/Qqee90dZo4Kd6KrlWgjq4npVGQeoM8xTe/0xTn5om5bVCGf88Newk/+QQwudgnR28po+
 8D0NrTX7UNdZyHw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently it's 32 bytes, but with the need to move to unique names for
debugfs files, that won't be enough. Move to a 64 byte name field.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index 77a55a32c067216fa02ba349498f53bd289aee0c..e47e81fd048812251eca2820a8b1e89f5750de3a 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -7,6 +7,8 @@
 #include <linux/stackdepot.h>
 #include <linux/seq_file.h>
 
+#define REF_TRACKER_NAMESZ	64
+
 struct ref_tracker;
 
 struct ref_tracker_dir {
@@ -21,7 +23,7 @@ struct ref_tracker_dir {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
 #endif
-	char			name[32];
+	char			name[REF_TRACKER_NAMESZ];
 #endif
 };
 

-- 
2.49.0


