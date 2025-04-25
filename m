Return-Path: <netdev+bounces-185826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50FA9BCFC
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0A81BA08F6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EF189B80;
	Fri, 25 Apr 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfn68UnC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED8188733
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549006; cv=none; b=YM6X6vpxs9VHJYTT0Ekpb+vyUe9oQ62CDQEFQLoPJ47Q+cNlSuu0NtvzHUjhw/85hzg2EMSyDST11xTPEbDM7N1HwghxMGtO9cRYc29fPTN7B9XY8AJ6ifhsNjSPgdl2K/GK8gOMJXGbQc0y2HRa7Yp8QjKi6QjTrFhSoqs1Kqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549006; c=relaxed/simple;
	bh=RYOlSAd/fM/B/KG310KDEcxkj7xgbW32kHOZw5r5+1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbbaQhamdNVGGFNzwy9SoM/MJ2gKteQap8JGLC+aHZoSNWssbkxZMBV1Qmb0ZjksnQTALByY3/yzGVV4BpIojUh6GbbV7A0KkUPZcXM0bqFPskiZDnBvHnyQRL1iWPeVg7nWX5ezMDuyz/jBqX6uxDMJQ1r/9uopsOhPxg6erPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfn68UnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A24C4CEEB;
	Fri, 25 Apr 2025 02:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549006;
	bh=RYOlSAd/fM/B/KG310KDEcxkj7xgbW32kHOZw5r5+1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sfn68UnC/6Dfr8ogS0gTJ+RaMKZqrBXXErNeIpC7kQM/01BAMmtzKLX7XEkLGQrE0
	 ZU5ZeJ2VdkQM/XTy06RDsCr7wM81Dr84J4YHHd8O64xqn5J2RLxgJ1VJ8cJj/ROUxH
	 OcE7DcytKyzNVVpY5DtyfwZ2QgmQoiFbxZTS4LM5f3YLMej7//9mGySjr8BpVa1Yf3
	 5kwkOSKNmFtR5lKQT0b4qjAkCaWhyOowiW8Gryrj8gbDOXYWyrV5JBtdo1d1sRtDF6
	 fDQfv9LLAtqWLwJsnaUN+svkw6ybpY06Pzo1OGfdqexNiVL3VLF0ZUrHn5Dv4oZ9bO
	 5yuTtzmGf/EjA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 05/12] tools: ynl-gen: support using dump types for ntf
Date: Thu, 24 Apr 2025 19:43:04 -0700
Message-ID: <20250425024311.1589323-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425024311.1589323-1-kuba@kernel.org>
References: <20250425024311.1589323-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Classic Netlink has GET callbacks with no doit support, just dumps.
Support using their responses in notifications. If notification points
at a type which only has a dump - use the dump's type.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c035abb8ae1c..0febbb3912e3 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1281,7 +1281,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         self.struct = dict()
         if op_mode == 'notify':
-            op_mode = 'do'
+            op_mode = 'do' if 'do' in op else 'dump'
         for op_dir in ['request', 'reply']:
             if op:
                 type_list = []
-- 
2.49.0


