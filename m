Return-Path: <netdev+bounces-231950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738CBFED99
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C3A3A3B83
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8019CC28;
	Thu, 23 Oct 2025 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Ip85pdkU"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3C1A9F86;
	Thu, 23 Oct 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183065; cv=none; b=Qa9wntbnZx+IxjS/f0vvHIVpfYZQk1yzwvhpE6bfVBc1+cb6SWnG41XOqMJqp0n5KUGddEZ/p6L2/5WeMZ4hshnVPrzimHSfRo4u8Wblnawu9CRWKntSuEKgGrhK66HULc0n9D3dUgo+RmXydH25o3l1BbRzqmZh+FHkKZy39xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183065; c=relaxed/simple;
	bh=59DyMv2/kaUFuprY4Ty/bOg9HiLiF4WHMxqPfGF1CTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADmM2DwX/2GwoXMxrMkXiyUFFyZ+Epbj1mjyQYDbi9FD7zHivs5VLzGPCOBtHjzxn30asVxHDmqr/vGA4F32wJoASmmoDiAbMq36spBv7uD/tzvXE1owCHDHnLYFEELygVUj+hhHtA4keSleZzh1IS6BuniqHYMeSKkRFMXkjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Ip85pdkU; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4xqZkbTQiHBUFbXKjuMKH2VrZh0pCiCiOZb19TYigo0=;
  b=Ip85pdkUKkIBf1IVBVuKNZRbTnYVvFXwWy6Mbr00r7NtjUYJucwEuEPb
   0WSxET6KAPykpoog5NcvVmSxAllU6zSLY3Q8Wtdp2Xuqs8ooiAo8K0cP0
   3tnxhbjpeiMD8bgWOYylrUfAaa+jtXDAH/GVS2gyLod0D/S4N79SNLONJ
   8=;
X-CSE-ConnectionGUID: nnJZ0l1ISVCMoaINK6ilKg==
X-CSE-MsgGUID: sG08PjC1TQyhxodYa+3gGg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,248,1754949600"; 
   d="scan'208";a="245734728"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 03:30:55 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "David S. Miller" <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org,
	kexinsun@smail.nju.edu.cn,
	ratnadiraw@smu.edu.sg,
	yunbolyu@smu.edu.sg,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] strparser: fix typo in comment
Date: Thu, 23 Oct 2025 03:30:51 +0200
Message-Id: <20251023013051.1728388-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The name frags_list doesn't appear in the kernel.
It should be frag_list as in the next sentence.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/strparser/strparser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 43b1f558b33d..b929c1cd85e0 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -127,7 +127,7 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 		}
 
 		if (!strp->skb_nextp) {
-			/* We are going to append to the frags_list of head.
+			/* We are going to append to the frag_list of head.
 			 * Need to unshare the frag_list.
 			 */
 			err = skb_unclone(head, GFP_ATOMIC);


