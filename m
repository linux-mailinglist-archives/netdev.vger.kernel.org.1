Return-Path: <netdev+bounces-188852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A5AAF126
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60AC1BA3FA0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED81D88A4;
	Thu,  8 May 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhOpy3kQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D5F1D63CD
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746671328; cv=none; b=NmXLA1UsrPLEv7ZnzjH5GvC2BbNU/csVCGaAECt/WcufXi1Nx/z0UQ7Yozqpc97fkqw1c5yhHDTmkGhB1cdka8xQdPYeKzwJa65bzXSE/nYG+2zJ8HJi+rPQYfFiNX7ej8OI+hVb8ZX0iYjlkwws1tfMhOhuREgAHpIijx63Zes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746671328; c=relaxed/simple;
	bh=ioCb9m9piDaKQnMvTtca+VPKJJu9GeOrJVK1CJqwnB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmeXzu5eknoLevybDd7bkwHc5VjMcy6lkw5tp02cswYnsEsxuMaur9HPEHAtRq8lf37yLCjX2sAhKiBRhyLS0VbV0LH609ncMDIZcK7yJ5+gjb/P835hOyUTS8lyvPJYAXodrch3dan7JOpWl6ncpWPVtAFfzKqS5P1u6pCms0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhOpy3kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B2EC4CEEE;
	Thu,  8 May 2025 02:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746671328;
	bh=ioCb9m9piDaKQnMvTtca+VPKJJu9GeOrJVK1CJqwnB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhOpy3kQzwf2YTcOQfgoExfI46r9TdskU9vojZd2K4k7nGmq13aMVhPHB4eE/V/yy
	 jwkckw66C8JpLt4P1OjAP78TbvZTrmdHQx2FfDkk/c/Nc2yPO89hWt04ZEJiK3A00S
	 LeUhKA//oeoi3Mo7CSMtoywZ39I5b10Nd8akgThGNIHL0rog1Art4GKXbTQoOxIL+P
	 KEoToa8hRVWxHBQW/rqRi8Eas7JnLB46tc9NS3wu6li92ZaKRJy+HxhKnF/X17ObXf
	 M3tzieNP4rJ756zuq2NrAGlN/KrdRdDrabeUNInFxJ9MD1goFdZAHqIEdKWgOHOFWV
	 jGUInDlRfLiAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] tools: ynl-gen: auto-indent else
Date: Wed,  7 May 2025 19:28:38 -0700
Message-ID: <20250508022839.1256059-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508022839.1256059-1-kuba@kernel.org>
References: <20250508022839.1256059-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We auto-indent if statements (increase the indent of the subsequent
line by 1), do the same thing for else branches without a block.
There hasn't been any else branches before but we're about to add one.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2ae5eaf2611d..df429494461d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1457,6 +1457,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if self._silent_block:
             ind += 1
         self._silent_block = line.endswith(')') and CodeWriter._is_cond(line)
+        self._silent_block |= line.strip() == 'else'
         if line[0] == '#':
             ind = 0
         if add_ind:
-- 
2.49.0


