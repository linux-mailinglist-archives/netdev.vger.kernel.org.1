Return-Path: <netdev+bounces-145097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236249C9622
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB5E1F22506
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1461E1B219D;
	Thu, 14 Nov 2024 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="FAXhaIW3"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10893139CFA
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627209; cv=none; b=tG/HU5S6nS+9D2ASYETMGOUwycuo8x+TvH6KJHZlEBU/t+wMtvjJ2ul3QO1lpmrCrGKuQxPPBv8bA/5sF6lCuuVcElE+YykBbrD4uCtOxt8etLVfKvWElS+VgBUwbVZWqfe845LW8x/6nDVkZbpTdiVMlfqPbChQ67PGKa1vJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627209; c=relaxed/simple;
	bh=gprTeoy7X/Wjqtvvoz0adWqYsbyBH37Bx0rOKOG0ctk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryofjocTZCp1VZX8X5Txip7i57GvBAR9WcQspRf2j+/2G2EUJnGvEsw3Ht3rdr4208PvU8VXvhaOh1EfxsGzwd/FbrS3znDejIrBg+5PFcSnr+rq42OduerzBW1w0YhrSDtqFMjIxBT8sg2tQnJ7clm+XtILu9cTSr/B3gXWJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=FAXhaIW3; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKs-0066RH-7M; Fri, 15 Nov 2024 00:33:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=plGZttL9jrxvU+XUBlrhk9Z1MsQem1Esym1JxdfFUxc=; b=FAXhaIW3c0kMy3LBRtxUgOxc26
	Q9WlvN8bnoW7bhdwiFh84UhK/tlJYTrcwEXBX/VWVoSrOloZ/Kn73hx1gJGpe2/Pka4QfUr3AP9AP
	oSKF6pRkodXY2175GJO0DfjYzinsRe7j4Gnh8TONLjtgpTiFbMhs/C/EjTS6UoBEFwsTib3XEWJOv
	cPaQMz6/lFO8UNSP8utL88izM8gfGHVNgp+T4269YSFKBJh59GhSVG2FQejjaEi2vgL2ZK3i4Zz8o
	Y7UxjMchVZIk+sA3EhcNTklow+Wb3+HhOuU40CntbeL7jZgcQRM6Dj0OLiofJLw+Dio/XVYYtYP1M
	4eBAwUzw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKr-0005mr-RE; Fri, 15 Nov 2024 00:33:14 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBjKR-008nXm-Lo; Fri, 15 Nov 2024 00:32:47 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 00:27:27 +0100
Subject: [PATCH net 4/4] net: Comment copy_from_sockptr() explaining its
 behaviour
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v1-4-d183c87fcbd5@rbox.co>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

copy_from_sockptr() has a history of misuse. Add a comment explaining that
the function follows API of copy_from_user(), i.e. returns 0 for success,
or number of bytes not copied on error.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 include/linux/sockptr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 195debe2b1dbc5abf768aa806eb6c73b99421e27..3e6c8e9d67aef66e8ac5a4e474c278ac08244163 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -53,6 +53,8 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
 /* Deprecated.
  * This is unsafe, unless caller checked user provided optlen.
  * Prefer copy_safe_from_sockptr() instead.
+ *
+ * Returns 0 for success, or number of bytes not copied on error.
  */
 static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
 {

-- 
2.46.2


