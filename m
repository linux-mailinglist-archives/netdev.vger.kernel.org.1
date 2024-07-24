Return-Path: <netdev+bounces-112884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0593B995
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333101C229E6
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D5143C4B;
	Wed, 24 Jul 2024 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQGSH9fP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79448143736
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864577; cv=none; b=mOcUE1Gtej3nq2vOlvijrm7EJOY6HQ3dp/RJt4Los7a2ENmk8p6jr5CE95WjZTqNAfe2RGhK0Nh2BtZ8paklc2/wMsX60puEXUhNxWuoWa/nNvgxSTYpdF6KxN2G2voOv6TntZTmoiSbxmuCMx2HvLZw2+vf9fnCpgeqXRFuNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864577; c=relaxed/simple;
	bh=KvIAvdQZLOfx9KWkTi0xAmv6CSsxLxkChZBhPtTGme4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOV0cjNQaI+UF1G5o3FcEBzGqO3//peFoBfDvkQtYf6PsLnilqd6uGoA9dGGmi/vrw0+AjqKOWEn43dELKpwkadIxxUxCdHyrsV3ZEmkhJ+C5ox6DO3TLc5rCEpkYDOlqCroEi28LzTMtWVsBmi99mB9tDT30GNsInjX/c68ixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQGSH9fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34E8C32782;
	Wed, 24 Jul 2024 23:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721864577;
	bh=KvIAvdQZLOfx9KWkTi0xAmv6CSsxLxkChZBhPtTGme4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQGSH9fPxPoBjDhgzfEp+PwpvNZd+r28TgrIQSeesV0cT7tu55MkoxzV7oYYxct9B
	 AqB5Qid8QoPN56Fk7L3Xq8bf5dSnjLN9jzxt2KbygVAefvuP8i/ah86wwlN4Fg8/fe
	 2x8GGy5WKHp8MzioloVZPozwx8MTFDNXWgTmZIZ/KO89lVj/QH+pE0acDjlHNMUTAu
	 Ed6QtAe8Zgi1wA6oJFMT+mIESnZW3XDlPQOb/5a82vSRdBLBpx0RkdTZ/J80SKG6WU
	 vBBwGV+i+IyL33RA389wtFAiuljkHcShp0ifxqROjbXMydqDLm+mfXVTt6MbvbDYVX
	 vGHtnQB8vo5kw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: [PATCH net 1/2] netlink: specs: correct the spec of ethtool
Date: Wed, 24 Jul 2024 16:42:48 -0700
Message-ID: <20240724234249.2621109-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724234249.2621109-1-kuba@kernel.org>
References: <20240724234249.2621109-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spec for Ethtool is a bit inaccurate. We don't currently
support dump. Context is only accepted as input and not echoed
to output (which is a separate bug).

Fixes: a353318ebf24 ("tools: ynl: populate most of the ethtool spec")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: kory.maincent@bootlin.com
CC: sdf@fomichev.me
---
 Documentation/netlink/specs/ethtool.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 495e35fcfb21..ebbd8dd96b5c 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1753,15 +1753,14 @@ doc: Partial family for Ethtool Netlink.
         request:
           attributes:
             - header
+            - context
         reply:
           attributes:
             - header
-            - context
             - hfunc
             - indir
             - hkey
             - input_xfrm
-      dump: *rss-get-op
     -
       name: plca-get-cfg
       doc: Get PLCA params.
-- 
2.45.2


