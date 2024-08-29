Return-Path: <netdev+bounces-123364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5D99649DB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D83D1C20DDD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE921AE87E;
	Thu, 29 Aug 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPm0P/Gw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0718E373;
	Thu, 29 Aug 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944829; cv=none; b=DR0zDNVFrxTrgMPSEjCh+svcc9GwJH5fH90MyZARJo0rHNOoPkE+Tg2EzCh8CV/Ga+AdEm+nlxqGaKO+dXRIoxaWNXb3No7wWz+nc4YklSo+UXTR6a2533PxjOlLNSnvTQLtNgdBRUBFX3spTbuk5tjI0ceEnn2HU3KXbZdmk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944829; c=relaxed/simple;
	bh=IXYxlcYCp7DFF63JfA4Y1j/u8NAySHcOeG7Qwvedfv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suPfU07yfLSzLFS8Uc0oyXT2FjzLvTCgHIL87c3DJmUXgzs+8UwaWZ+qvyxoJ7JFuSColG0UaQ3zhXNJF+9WhBKf/1i5oMoanAPeFBO0UJsAxhJZvJU7HzXpsb/2DCuhv+P8HnOODl0BV8tp4BjnAioWOgokUER0TtxuUxTEb4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPm0P/Gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCFDC4CEC1;
	Thu, 29 Aug 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724944828;
	bh=IXYxlcYCp7DFF63JfA4Y1j/u8NAySHcOeG7Qwvedfv4=;
	h=From:To:Cc:Subject:Date:From;
	b=OPm0P/GwGyHHLwYBMTCsMWDq9rvYcsPWhkp0XWmZ/cneWUqNTUb9bk1UBMD8B/ctP
	 4OTKHXQRcVCZsbrqtNYxrPuIaIhGtxhVC+5CRya+SKoyA80zHTmVj5CYIU2ViXQAFv
	 x5Qkfl1GEe52NAo+7QTOn0alqSpCtB60a5SGFOKHlYemxf2PKv/zpkhXF0GVs/PGWK
	 PzCVCOr//rDHFLYTLiMHd36tPxxPFoD89w71uAsshRdC+xuLKQ084lXyWDB5Rv0HpN
	 Lnj08vCIN6IelGvjQtKnibQUY2wYuH0Z7OBPkf6quGYkBRjx9FiNm7pfepdKgJ0TBA
	 2PxKyrca8CC5w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net] docs: netdev: document guidance on cleanup.h
Date: Thu, 29 Aug 2024 08:20:25 -0700
Message-ID: <20240829152025.3203577-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document what was discussed multiple times on list and various
virtual / in-person conversations. guard() being okay in functions
<= 20 LoC is my own invention. If the function is trivial it should
be fine, but feel free to disagree :)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: corbet@lwn.net
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index fe8616397d63..ccd6c96a169b 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -392,6 +392,22 @@ When working in existing code which uses nonstandard formatting make
 your code follow the most recent guidelines, so that eventually all code
 in the domain of netdev is in the preferred format.
 
+Using device-managed and cleanup.h constructs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Netdev remains skeptical about promises of all "auto-cleanup" APIs,
+including even ``devm_`` helpers, historically. They are not the preferred
+style of implementation, merely an acceptable one.
+
+Use of ``guard()`` is discouraged within any function longer than 20 lines,
+``scoped_guard()`` is considered more readable. Using normal lock/unlock is
+still (weakly) preferred.
+
+Low level cleanup constructs (such as ``__free()``) can be used when building
+APIs and helpers, especially scoped interators. However, direct use of
+``__free()`` within networking core and drivers is discouraged.
+Similar guidance applies to declaring variables mid-function.
+
 Resending after review
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.46.0


