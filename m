Return-Path: <netdev+bounces-225281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2642B91C0B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FC719032B2
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B9527B325;
	Mon, 22 Sep 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewloeGIy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76059231832;
	Mon, 22 Sep 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551970; cv=none; b=YUFeC5ZbcAD3sJYU5qJ5VdmzW96l+TBLfPYgvTcqqqqFC96eY8SiapEwbyIqYBITAlLxLimWOGVHJqk9hMzs0K3UD2rMSVaTu61TzQzpY4gT6ct20xIiUJLNHpLHqpcdVMVxv2MF27v5XOmW/mWiNur4TVzJJkATYsT50fwjdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551970; c=relaxed/simple;
	bh=XUyYu1eYga/BDEMIdszJKKF+XHr9UK13KXG6TovG4ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=neLvQ/i4HsTH0w6+rWzZb1mHdnD/6HF+T3H2QZFW4QF4BvFDjYT3wwwkfHJ4BunuMWii3DfE0KNxZjpNI2R1r9jgFjeJxIi0gN6Fo5o4HZLqyaU5bcXpYvBdTFh5UMAxltgrriCjJCaB0oxm6pk0eMFIYPuhI+z525YawdjYblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewloeGIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF91C4CEF0;
	Mon, 22 Sep 2025 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758551970;
	bh=XUyYu1eYga/BDEMIdszJKKF+XHr9UK13KXG6TovG4ag=;
	h=Date:From:To:Cc:Subject:From;
	b=ewloeGIyQwxY+LI+JeKAaLxERVQuJ1tkHBJDwIzhbQZzaSdZQUODYxGFIszzIqg7j
	 7Uc58pCCruDgadAgm2SjK6Yy34evEi3+Qnw8V0hRRg6kIjl4OBdn1u5yekNy4dY6zv
	 9IwSOQE+YRqbbto6AybI1hzhksn4kyxiqbedo6mvhZp4a8LvR+tIxjbTQlxq0hNkz2
	 lki+jgF9fcjWgr2qKNnI+pCHYLfnRFyNy/d1d4Xu7/bzYo1+jkQfzz1tETGDFlOJUM
	 bM2YGGtMQFgX3tZY0gicDqeZPZH/64S8E8FmyyztO2TSiF1C3aJbTn4q3M+TVTOpk5
	 SINPEeS8DE33Q==
Date: Mon, 22 Sep 2025 16:39:20 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] tls: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aNFfmBLEoDSBSLJe@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the new TRAILING_OVERLAP() helper to fix the following warning:

net/tls/tls.h:131:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/tls/tls.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 4e077068e6d9..d06435d186c0 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -128,8 +128,9 @@ struct tls_rec {
 
 	char aad_space[TLS_AAD_SPACE_SIZE];
 	u8 iv_data[TLS_MAX_IV_SIZE];
-	struct aead_request aead_req;
-	u8 aead_req_ctx[];
+	TRAILING_OVERLAP(struct aead_request, aead_req, __ctx,
+		u8 aead_req_ctx[];
+	);
 };
 
 int __net_init tls_proc_init(struct net *net);
-- 
2.43.0


