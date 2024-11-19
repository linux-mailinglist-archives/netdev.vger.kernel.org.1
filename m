Return-Path: <netdev+bounces-146251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D7F9D2704
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B81B2C588
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F71CC88A;
	Tue, 19 Nov 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="mJ56papW"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2391CC161;
	Tue, 19 Nov 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023149; cv=none; b=TTh90B1O+65/wsBaQIjQT4Lty/EDuvOmbqdTedYOBeMgZdmBq7yogutnoXBciqEzCbvNVJObM3k0ICrvkQzh3B9Oqtcv5BIjOCBphfjhl8S5x34X4sfIOVXSHbzCsvcKYrm+EZbAIUhD+fwSlj7M3SNhyLPD1uHo93pJVKCtg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023149; c=relaxed/simple;
	bh=gprTeoy7X/Wjqtvvoz0adWqYsbyBH37Bx0rOKOG0ctk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEQAq6BZWrI5ljsde4iyyCFnJHr7Tnc6xkqgzVr09icnTfXXtp7gYQJChmT4MHrzddFExFYxonqeX/m8kz1os1JKxVerxD4wNuaKOVLolTjVGbRJLtS80O0qR0DueJzvdkJv4OAK9j23bPJa9whMHsyJQalMGWuC/b1T32ILem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=mJ56papW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tDOL4-0024Sf-Fy; Tue, 19 Nov 2024 14:32:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=plGZttL9jrxvU+XUBlrhk9Z1MsQem1Esym1JxdfFUxc=; b=mJ56papW9RMQMmygxVbsQsG8J0
	aOMv8cHvg7vJ+giqvQKrgknqtXxcur6zCNR1MKcwTmQGuKLoGnx0h6W5gVY0s7oXPU7XI5qYA4ggT
	o0fF4vRHgtDJXS6t83NZYHYyS3N+DwDr0sjBtcXzk0YWQ+RxU1KoZPD2Ez/aTk6P+g2R4Mq0oEc/x
	2P+Yum5vQ8fe/su2pQImq6D5xsSiGNJNeQdAZlBULrwAYu5Eg4X/pGIaCX4Wopc4kqokw6mMDzy8+
	dlO8dltsoaKmddV/XtE4ygEkitGosOOqKgLlRKByQqnAxeJozpGiAeCdcI3Cjij5Op0QWQKaDzL3Q
	8Bfc3M1g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tDOKy-0006NX-R5; Tue, 19 Nov 2024 14:32:13 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tDOKl-000XIx-TX; Tue, 19 Nov 2024 14:31:59 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 19 Nov 2024 14:31:43 +0100
Subject: [PATCH net v3 4/4] net: Comment copy_from_sockptr() explaining its
 behaviour
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-sockptr-copy-fixes-v3-4-d752cac4be8e@rbox.co>
References: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
In-Reply-To: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
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


