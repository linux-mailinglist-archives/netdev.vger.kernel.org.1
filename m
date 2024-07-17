Return-Path: <netdev+bounces-111899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B30593403D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DE8281C94
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0221DA3D;
	Wed, 17 Jul 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLtExhaQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35D8C06
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721232963; cv=none; b=pA2IHhhJILWQwc3ZrQ/8d62rO5lrTG9drLsVA2/Ost04dnhPeCiXp4Yvn5nkJcegosk3tvtPPfFbgDA6tbgzlTjFraGPIHw42jWhzFsBEpb3BW/zdWbqNiO4tW/gVe8mk5A3KVZzbfF5jG2LISCvOmWeeBzN835uHXlrXy1P1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721232963; c=relaxed/simple;
	bh=UQFkK36VEUMiUruhNCJKbqagrq8oVwkv85suIjsD5A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLwmt5LecEQbtMvjgUeBXj2+riZsEje6SXDO8OeYetphB/z1kfuufk/eAbvB22Hd/XNvSAnMul9znUXduMkQ+q5OBEWzEwZMJWIwfat2O+Soo90Q54x7fkP3tlJRnuu/evO02akNf2aaiaDzFUxs2WK6KQWIXBXooGnPnluaVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLtExhaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F70C2BD10;
	Wed, 17 Jul 2024 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721232962;
	bh=UQFkK36VEUMiUruhNCJKbqagrq8oVwkv85suIjsD5A8=;
	h=From:To:Cc:Subject:Date:From;
	b=gLtExhaQsiPBISHhXWWu7Fqdh86RhzrC30zV12EKwf7JnHcyHskue9BOkPy6ZeOmh
	 zIAZyY3vpuQDuxDuuHzOJaFARRlVqfuAbSGVOKdU5S/kminspL7aORUh3meWXQfhpY
	 e3foNTD2JLEUt42FgUuxejeBy1eE3CXpLVqX+s2vT8Zm4mLillg+tFDhCGlUNdcx3Y
	 1hxbMCVZOXREs7Osw+mFFzg/xRAnM+bFl13Vpu/iicskdio2PRN2N1G8jS87xd7xAz
	 9N4o/d7cJGzf0cRf0gSCTj0IIBDBwWAWV+zRcJS71aaBXNYOFY9IUi/AcpOHFIxtK7
	 dv1CmhLVycSBg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	kernel-team@meta.com
Subject: [PATCH net v2] eth: fbnic: don't build the driver when skb has more than 21 frags
Date: Wed, 17 Jul 2024 09:15:59 -0700
Message-ID: <20240717161600.1291544-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to commit 0e03c643dc93 ("eth: fbnic: fix s390 build."),
the driver won't build if skb_shared_info has more than 25 frags
assuming a 64B cache line and 21 frags assuming a 128B cache line.

  (512 - 48 -  64) / 16 = 25
  (512 - 48 - 128) / 16 = 21

Fixes: 0cb4c0a13723 ("eth: fbnic: Implement Rx queue alloc/start/stop/free")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - cover the 128B case as well
v1: https://lore.kernel.org/20240717133744.1239356-1-kuba@kernel.org
CC: alexanderduyck@fb.com
CC: kernel-team@meta.com
---
 drivers/net/ethernet/meta/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index a9f078212c78..86034ea4ba5b 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -21,6 +21,7 @@ config FBNIC
 	tristate "Meta Platforms Host Network Interface"
 	depends on X86_64 || COMPILE_TEST
 	depends on S390=n
+	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
 	select PHYLINK
 	help
-- 
2.45.2


