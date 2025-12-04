Return-Path: <netdev+bounces-243498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3386CA26B3
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 06:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CEEF3027CFC
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 05:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031E22157B;
	Thu,  4 Dec 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOAJsXFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78628398FAB;
	Thu,  4 Dec 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764827198; cv=none; b=GrxWKGk4JyESrrJ97y9LnjrCIEOQ3GCCSQMIvKGaD0jM9sI4Vobj/Fn1GlZCwOXgOumw1liFXx9IDSw9PP+nbCiH6TGPSsyL9XI9TUgMKvLlnhSyjMRL5IxzORkXQV1BZXWWN7+m6Sy/61Sk8QioS+yIS9+acvJ6JJYK3GpRfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764827198; c=relaxed/simple;
	bh=/PxA5WkYjvGxE5SUoWmOb08+UitKQZ1fHPy34zDX3PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLiUtYanKFpa16spYKlft85i0v9nsxeddmjiYHEfzEihDfpNb+w7q2hpTq7ex8gOgBKreIwrC0qtQ3UBHyD9qaiLcswn6HvF1sTRn5PEGi4VD+AGI2HriWFnIQadFLfOV90x4mqqhrrX+swayKUiJ+ydpu8ra07Eri1ca6BDS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOAJsXFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FD8C113D0;
	Thu,  4 Dec 2025 05:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764827197;
	bh=/PxA5WkYjvGxE5SUoWmOb08+UitKQZ1fHPy34zDX3PE=;
	h=From:To:Cc:Subject:Date:From;
	b=tOAJsXFH6LsICk6n3RuzJrK0vdYOsDNt/kpdq6VVkpUCSo2irY0slYwbGa/2Hl0nV
	 FnYskwt/Z1sfBhC2pFr3vJn+EotG2H9WxAgqHx2+lbsJhL21tHtx+vfn6kECKd9MBy
	 PWKg3lhkI3SXYM2Ua5UK2DmwDGN2gY2OAtjIiMKYqnlcQgNWMU8CgDbvKNvZBvufvC
	 Cj2TrSU6X8D01vZhIv57BK+KTc+P9G+1kSzUeP++GPigXh/8qg+x2FdWBENPmCqnSu
	 tEVMdR5cRt0hE1hE+8DwUp/ZEOfxER8SkhEJgNsI2JTT2ZajRfJdA1QSX82rsNzATl
	 rqZdvmvYr6GsA==
From: Eric Biggers <ebiggers@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Geliang Tang <geliang@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net] mptcp: select CRYPTO_LIB_UTILS instead of CRYPTO
Date: Wed,  3 Dec 2025 21:44:17 -0800
Message-ID: <20251204054417.491439-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the only crypto functions used by the mptcp code are the SHA-256
library functions and crypto_memneq(), select only the options needed
for those: CRYPTO_LIB_SHA256 and CRYPTO_LIB_UTILS.

Previously, CRYPTO was selected instead of CRYPTO_LIB_UTILS.  That does
pull in CRYPTO_LIB_UTILS as well, but it's unnecessarily broad.

Years ago, the CRYPTO_LIB_* options were visible only when CRYPTO.  That
may be another reason why CRYPTO is selected here.  However, that was
fixed years ago, and the libraries can now be selected directly.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/mptcp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 20328920f6ed..be71fc9b4638 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -2,11 +2,11 @@
 config MPTCP
 	bool "MPTCP: Multipath TCP"
 	depends on INET
 	select SKB_EXTENSIONS
 	select CRYPTO_LIB_SHA256
-	select CRYPTO
+	select CRYPTO_LIB_UTILS
 	help
 	  Multipath TCP (MPTCP) connections send and receive data over multiple
 	  subflows in order to utilize multiple network paths. Each subflow
 	  uses the TCP protocol, and TCP options carry header information for
 	  MPTCP.

base-commit: b2c27842ba853508b0da00187a7508eb3a96c8f7
-- 
2.52.0


