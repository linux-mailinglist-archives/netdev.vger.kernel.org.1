Return-Path: <netdev+bounces-214718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CF5B2B01C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CA11B28350
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD92773FE;
	Mon, 18 Aug 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2dfYYuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404D2773E0
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541132; cv=none; b=fA61aDP007IydRnLtOaTRgbAsNl4vJAvuT9+7BItCJBqBYmkDKi/h5/r5Nm6GkJCtdZb04JGSCOBPCLHRRYL+T9JuE8TisBXHKQVGDmpOL1/qRNtfCULhIhoTgE+N/lXa5vqTbiseLSoxNpmQjQGbgLs8AkFe9ZEf8XeZkX1dyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541132; c=relaxed/simple;
	bh=o7F/J6kFu8eZOYQTkKFLjaLsHTaJbYTEK9Vart9HUvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJiwziiWTk/VP44TqKTDcBp5/V0om99HajhpUJsMs5YA9qbg4lpRJr1R7Ay2z0Gp4guVKiqrhs0FXM3okFUmeQaJnlMXR17t1Q820rg1sngM9SCxwThXXrXx0rVn+i92QfBFqS4a7Y6xOuTI4M+jvBjQ/jXORYpNCR2HP46zCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2dfYYuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2216FC4CEEB;
	Mon, 18 Aug 2025 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541132;
	bh=o7F/J6kFu8eZOYQTkKFLjaLsHTaJbYTEK9Vart9HUvs=;
	h=From:To:Cc:Subject:Date:From;
	b=O2dfYYuy2qlJ9zd4rM0i3S45fVGuNUhN1R659Xmmpqjq+Rm/BlXNHOIgFaPLV3GH3
	 anzD9qzKRwu8xD1F65Ok99Dw5ClmB9hyxmrmP+EXxlE81De4hC6IIT5sjSD3JnMyOW
	 vZIIjEQM7vc0iyCvL4QO/6p7Z3U4pgeOkW/BnNfEBztUOuNTitNp792lPYw0Mz6u76
	 M5AOlwahhH+02K00aK59WIdYijRQLwTNZcSFuDAhcqbITDgZYOH3JgLTGTAWDBKGQC
	 Ant/TSMi+UjPRT5xxVQO4w4a5eqXn33lp0dZxrcOqGOvvuIv5V4Hv+aZCmC4BhFnVc
	 C1A2V1sUwtvvw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	dhowells@redhat.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	aleksander.lobakin@intel.com,
	tstruk@gigaio.com
Subject: [PATCH net-next] stddef: don't include compiler_types.h in the uAPI header
Date: Mon, 18 Aug 2025 11:18:48 -0700
Message-ID: <20250818181848.799566-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uAPI stddef header includes compiler_types.h, a non-uAPI
header. There is a hack in scripts/headers_install.sh which
strips includes of compiler.h and compiler_types.h.

But AFAICT there is nothing in stddef.h which would need
the include. The include dates back to when uAPI stddef.h
was first created, back then the including of compiler.h
was the only line in the file. So presumably stddef.h
has been including compiler headers to retain some
chain of dependency? Perhaps someone with more build system
understanding knows what that chain would be, given
kernel doesn't include uAPI stddef.h, and user space
has the compiler headers stripped.

Since nothing needs this include, let's remove it.
Builds pass on x86, arm64, csky, m68k, riscv32.
The direct motivation for the change is that the includes
of compiler.h and co. make it hard to include uAPI headers
from tools/.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
More than happy for someone else to take this via their tree, FWIW.

CC: dhowells@redhat.com
CC: kees@kernel.org
CC: gustavoars@kernel.org
CC: aleksander.lobakin@intel.com
CC: tstruk@gigaio.com
---
 include/uapi/linux/stddef.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index b87df1b485c2..3da0266643e6 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -2,8 +2,6 @@
 #ifndef _UAPI_LINUX_STDDEF_H
 #define _UAPI_LINUX_STDDEF_H
 
-#include <linux/compiler_types.h>
-
 #ifndef __always_inline
 #define __always_inline inline
 #endif
-- 
2.50.1


