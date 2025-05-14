Return-Path: <netdev+bounces-190347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E035BAB6667
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0677A87DB
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353CB205AA8;
	Wed, 14 May 2025 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fHbbt0Pa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446944B5AE;
	Wed, 14 May 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212536; cv=none; b=Bq5xXLRVmseixA7QQJA2yVvKT5gZDZyCIG9T/qZ5LMJbqT1b6P8WZMa9YkaeK2A8v9xCxBk68qTV7oD8Lp453yq/sXuadrCjFNS9dal4VWD4JDWcBUfWNRn0Q7BkyQmUvAC5PSGfJ4wuMVoikWuXTz/+Q7PjCac7C2ynYDmsY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212536; c=relaxed/simple;
	bh=+aHpYjrKuFUZJlfPk9knDfGYTwH2A1FdbEFtXVPeCzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QO4++ByPIJ6k8lJ4FERIX3NTWG11DhN7HkKPDVG4YgLkMu2CYFGH/u/wwz+rYIekOl2nGE/IrkW/BWHMSHTaxgOvq2Usbuh5n9vhyWQnD3evmwoF/MtlG2Hiy/v65Zqfno+jJyNm7Ie3bb4UKMXbAaVWkrVfe4sh8MsXcBNx8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fHbbt0Pa; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1500c9889;
	Wed, 14 May 2025 16:48:42 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] xfrm: use kfree_sensitive() for SA secret zeroization
Date: Wed, 14 May 2025 08:48:39 +0000
Message-Id: <20250514084839.118825-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUlLVkNNHktIHR9JTUJOSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a96cdfb55ca03a1kunm1500c9889
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzY6LQw*MDErLj89H0MBCxcW
	PhAwCw1VSlVKTE9MSUpJTklPSklPVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKQkhONwY+
DKIM-Signature:a=rsa-sha256;
	b=fHbbt0PaEaH70m4nk6en1ylxdApAt8FIRrQf2M/3DwY37aEvCvgb5TBaXjHefxkK0Pt07T9uwYCwNR7kweUmmJaBxeKEU/17MIwdlADcdMesBcHMkviRSt3MsmeZ55fAlpcA8Om2YU312qUDbu0BVxIufLkjPNtTI+WHS0OTIRA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=bHBo2SqZg+ZrzoyGVvoJUaxw3/j1ZXT0kAv8OKyNWXU=;
	h=date:mime-version:subject:message-id:from;

High-level copy_to_user_* APIs already redact SA secret fields when
redaction is enabled, but the state teardown path still freed aead,
aalg and ealg structs with plain kfree(), which does not clear memory
before deallocation. This can leave SA keys and other confidential
data in memory, risking exposure via post-free vulnerabilities.

Since this path is outside the packet fast path, the cost of zeroization
is acceptable and prevents any residual key material. This patch
replaces those kfree() calls unconditionally with kfree_sensitive(),
which zeroizes the entire buffer before freeing.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 net/xfrm/xfrm_state.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..63506152f893 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -599,9 +599,9 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 		x->mode_cbs->destroy_state(x);
 	hrtimer_cancel(&x->mtimer);
 	timer_delete_sync(&x->rtimer);
-	kfree(x->aead);
-	kfree(x->aalg);
-	kfree(x->ealg);
+	kfree_sensitive(x->aead);
+	kfree_sensitive(x->aalg);
+	kfree_sensitive(x->ealg);
 	kfree(x->calg);
 	kfree(x->encap);
 	kfree(x->coaddr);
-- 
2.34.1


