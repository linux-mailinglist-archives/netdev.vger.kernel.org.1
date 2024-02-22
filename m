Return-Path: <netdev+bounces-74175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631678605AF
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025B41F22524
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C719137902;
	Thu, 22 Feb 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmL10Sfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD212D21C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640905; cv=none; b=RMF+EkGU1VAPtP1lrLIsGOQqW4A7P28D/O9eiZcRILZIxF2FO9ZYeKMIe0O4jyBZAJ3aQOfnT3La8ALxBxsrKKTxYLAB2pRX8BwSA26v8+vg6hqsfVkrom5ATmnJGb0HHPrW87v9i+A5r1MwZC4BGOWzEbzbv8gNvD0rn6dlvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640905; c=relaxed/simple;
	bh=gEDlDbq0Sa2xSkplTOU/QGjzncgfTZjdEFN4GGJOZMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuSXXQH6rOQBNuUTUTDyzChueKhdy/Dm3hDnfNxiT1hHIC6PuIy3Iju5HW9eSxwr5yy+2ZonQ8gucU/efKqFXUS8RrMTbJbQvSZX3TjVT8FdHcvI/fpmbfmSQvQSlugI+khGkPsFOGHkgiScMoOrR+U/Ff/MTdf39RJ36OuZOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmL10Sfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F664C433C7;
	Thu, 22 Feb 2024 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708640904;
	bh=gEDlDbq0Sa2xSkplTOU/QGjzncgfTZjdEFN4GGJOZMw=;
	h=From:To:Cc:Subject:Date:From;
	b=YmL10Sfe+RvdgNsFA1B+JXW2+U539zWd49MjKaHb2me3v8mglIloQLHZ4bu9zNIqE
	 jEA0wNTJWCdzJyvqDidL+touVP99qYC3VTxIt/WODKFhvnrVmmPKBfwPDR5JAEr+PY
	 W9XmYKiZYmgsNJ/zS7Pq1iHp9SdCdk1Z/24staDSDanCgODD+/TyFx4bnRgcs/VuPq
	 VYKZETwKDBktVlReDUYWH71WbYkKx32OyKt+AeR0G9iUaMjmMD5my4PEv8JsXg6H+X
	 VjvBiVZcHswVryoAxhhAZTS+OW7DjvG4LY99tpdCJMkAg10dvAbPiIH39VpMFaSDG3
	 YdD38rXwnpXWw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] genetlink: make info in GENL_REQ_ATTR_CHECK() const
Date: Thu, 22 Feb 2024 14:28:19 -0800
Message-ID: <20240222222819.156320-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the local variable in GENL_REQ_ATTR_CHECK() const.
genl_info_dump() returns a const pointer, so the macro
is currently hard to use in genl dumps.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
---
 include/net/genetlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index ecadba836ae5..9ece6e5a3ea8 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -153,7 +153,7 @@ static inline void *genl_info_userhdr(const struct genl_info *info)
 
 /* Report that a root attribute is missing */
 #define GENL_REQ_ATTR_CHECK(info, attr) ({				\
-	struct genl_info *__info = (info);				\
+	const struct genl_info *__info = (info);			\
 									\
 	NL_REQ_ATTR_CHECK(__info->extack, NULL, __info->attrs, (attr)); \
 })
-- 
2.43.2


