Return-Path: <netdev+bounces-186224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB27DA9D81B
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23AD1BC4464
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 06:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6B17A317;
	Sat, 26 Apr 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcQqzjUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451C86334;
	Sat, 26 Apr 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647638; cv=none; b=Va26GNf5LF3/C97AW3xbhD1RL69NkSi9hFzG9ttLb/j08BXmR7vasurc/DO8/9F7CdgOrN1npmEuC728uJF6xgPAT02+Z+WLxt9eXoZaNq15XNfZSjhJgNWGxdBLnjylvFeefZp6lG7f3jEzJA96Asq3gL7JpkRMSEaPvA1mOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647638; c=relaxed/simple;
	bh=QwtSF+WjGaPQF7JvSMBlPqQ0wIJ63A/hKVWs7QDW9SA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HfBn1Jw5P1/k+jnXSWcHZngnzqmA+m5PEEd9SNk8Vy4G1HPtMh2wJoxRl+NaSmhEFaAeNvZsUJNhYXrrX2vqzf8uBODK8J2c7W6KiMKp6VHn+CqUhXVKJG4Z7rBVMvQ3ulYEcYFe1j5haVeq/Lp/bXIGQxvjmtFmwQXBuOHV7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcQqzjUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1318C4CEE2;
	Sat, 26 Apr 2025 06:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647637;
	bh=QwtSF+WjGaPQF7JvSMBlPqQ0wIJ63A/hKVWs7QDW9SA=;
	h=From:To:Cc:Subject:Date:From;
	b=rcQqzjUN9Xn2T41c/JoWACAV8n9xQIRWN44/6CG3WeWYyPoGCCjTGt2+ooAlDnbkp
	 IP1IJRXdCmKCd4bu95wn8W8V6NzUcwdAYqvGCPf0Zfr7HKTei0Yb5/fZWLcUKm3ib2
	 Q35IXUxF22yDvYOSv11eFdmjUk4yFtlbk/nbHTbaJNng58UlBCjuFUF5IXIOpY8X5n
	 YjtaFSQcQgi1Mtf8MgHaGSoc0f8jmFW8cvqsbpAtQWTk0ScM+q3FtwOf6nOBwL6U6y
	 HS5/eB68zOzsf+eoqUq+RpY4YWXCxxt0JVKo5iArSvUAA1i+dBRN2hg6XVcytLNQCj
	 GgUYsQGGLH5ww==
From: Kees Cook <kees@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: Kees Cook <kees@kernel.org>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] pds_core: Allocate pdsc_viftype_defaults copy with ARRAY_SIZE()
Date: Fri, 25 Apr 2025 23:07:13 -0700
Message-Id: <20250426060712.work.575-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=kees@kernel.org; h=from:subject:message-id; bh=QwtSF+WjGaPQF7JvSMBlPqQ0wIJ63A/hKVWs7QDW9SA=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8FYKmzBfOyTj/PKAvwej7YTO7WDLDv4fatwxfzPK3l /YVV6nvKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmAjLI4b/pZmiibvv57xUrBW/ L3b1iFdlzZbPzKz2G8plFDSSk92mMPwz3c+w1pff/mRVdTBr1B/LhmvnMh9/n/alc8oElXXqPBc 4AQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

This is allocating a copy of pdsc_viftype_defaults, which is an array of
struct pdsc_viftype. To correctly return "struct pdsc_viftype *" in the
future, adjust the allocation to allocating ARRAY_SIZE-many entries. The
resulting allocation size is the same.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Shannon Nelson <shannon.nelson@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/ethernet/amd/pds_core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 1eb0d92786f7..451b005d48d0 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -415,7 +415,8 @@ static int pdsc_viftypes_init(struct pdsc *pdsc)
 {
 	enum pds_core_vif_types vt;
 
-	pdsc->viftype_status = kzalloc(sizeof(pdsc_viftype_defaults),
+	pdsc->viftype_status = kcalloc(ARRAY_SIZE(pdsc_viftype_defaults),
+				       sizeof(*pdsc->viftype_status),
 				       GFP_KERNEL);
 	if (!pdsc->viftype_status)
 		return -ENOMEM;
-- 
2.34.1


