Return-Path: <netdev+bounces-71964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF1855BD9
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 08:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148AF293EB6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293F10A2C;
	Thu, 15 Feb 2024 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="j8WPJMCg"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D0CA4A
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983620; cv=none; b=s2TsAAXDZ3lj5gTizPtskYJYkpkkQjepbqi13wFhVIM/VtQWfShJY3AFz4O/QCEV9PZ+63DtNYhPQvRmK0RuNUOLF4fGLdmKIf+gIqIQquC4g+A/puU663cjYEn9x9m9GzirErF5sjCjSqqInSJ5GN4U22Oeeb+WlrkCCgG1PJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983620; c=relaxed/simple;
	bh=UvJP61hKzBmSIgBvsibUlpbX1HFWuqrx1ycdDbfv/1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eitgl0d4rkOsIWZvXRn5W4Q+2+iwFihHKCXxOJwemxvCN3ATdRXkRZTydKb4GRprXCmA6hcE2t8LJvvRvX1CTJIAp8cUh6dIuH9k9j/zOogdtmc+T2KMKDXKlwOqz92fax2YKx1j14V1uyZqSBVDx7yON8cBRUy3f7ZFTXxU1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=j8WPJMCg; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 6CBC02017A; Thu, 15 Feb 2024 15:53:30 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1707983610;
	bh=wCcrelw+yx01UqHI9Xi0nS097BNsvbhMtvbVSILWFWE=;
	h=From:To:Cc:Subject:Date;
	b=j8WPJMCgJVBCWoXywgOK05yCB1G4Ver1zNjIpv9d2Rby59uhUDZSjiqaIbTO/ITWV
	 jMxuaRAnaixOXoH+b0WKCVlyIll0FJLiSGDQpDHaxLLAgiZRw4rPrMFCx4n7GjCpRf
	 oaS0G90i3GPyiVVzZmky/q9dAwg0D/XfD4bQ90y1C+qoD49behDpx/h3rQtSW7nzHn
	 B1RKe1Gaqzj4diiqbH753Frgr2swGdscXfM+jcq8BBL7bGy+bCxCnq8yIe6wT9dEGT
	 JviLMy48bf8gO2YZJ8yp1xgOueDlwLVRL4r7bZ/izbhwVqVR4hD0K6A3zDvtcWTlM0
	 3h1f3MleQq+UA==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: mctp: put sock on tag allocation failure
Date: Thu, 15 Feb 2024 15:53:08 +0800
Message-Id: <ce9b61e44d1cdae7797be0c5e3141baf582d23a0.1707983487.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We may hold an extra reference on a socket if a tag allocation fails: we
optimistically allocate the sk_key, and take a ref there, but do not
drop if we end up not using the allocated key.

Ensure we're dropping the sock on this failure by doing a proper unref
rather than directly kfree()ing.

Fixes: de8a6b15d965 ("net: mctp: add an explicit reference from a mctp_sk_key to sock")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index a64788bc40a8..8594bf256e7d 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -663,7 +663,7 @@ struct mctp_sk_key *mctp_alloc_local_tag(struct mctp_sock *msk,
 	spin_unlock_irqrestore(&mns->keys_lock, flags);
 
 	if (!tagbits) {
-		kfree(key);
+		mctp_key_unref(key);
 		return ERR_PTR(-EBUSY);
 	}
 
-- 
2.39.2


