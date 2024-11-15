Return-Path: <netdev+bounces-145208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE209CDAC5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A5C280CF5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F080518C03B;
	Fri, 15 Nov 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TVFjGSIZ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97A16BE2A
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660094; cv=none; b=fzylxNnY87AMC+pbkSWRYGuZmV5FCNQnakoj7TOuQhAru2rn4PQgGnbD6kH7/lgFVWP5nloMx9Fq5eLNENqK1+YymlSRsiDz7hgEICrZ49u9KDHGHTZEALhA2QTPynPbTqyawzSPkJr5XGGgN1cwRLCI1O8iPMSVC95JfdY3uFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660094; c=relaxed/simple;
	bh=KBxEnafSWnDvnStuRnKAdEoEQ8nxLyVYcxpBPtYpKK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGIfXUJw9EmOcuB3BeBJUbk70tZUFdh04JR128mPlfOZ7zGGNYhk/6wAXXQXB58sruolwUXHkspSCWV0HkzwxpS3DSlO9RlVbrdARzrzPY5Ty+Grdr8d9ggU7xUNcxP8nYCrHa9f5xQm/ztJBOQd3/xx7AfLazKSmIHR6+b9uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TVFjGSIZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C3E6C2083E;
	Fri, 15 Nov 2024 09:41:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SSo-NckQJ3nv; Fri, 15 Nov 2024 09:41:30 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 30FC32084E;
	Fri, 15 Nov 2024 09:41:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 30FC32084E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731660090;
	bh=ry6CCkRQxgfBS8yPRGD17Cg0pnf3JnpRS53HBrGYiOk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=TVFjGSIZ6LB9CLUxlLoh1uSyAhl5xtL+FFBoAqwgiy8YVtArqspdQXaFprzdXb+WF
	 WgofhrVDaVf549CMmw0TEkqU8kWrWVWUoZjXKw8EKlLbQg/GxtjTWmyR9TRJ3NIz3R
	 7gg6pNad7KqPdUpuwbnmzueFyPMihKC7oZvmIIiFl8bsQj3SrYKhIB5LxkSFZU4/bt
	 63/OeTLEiQyOaR6WrtVDSimBgHkQuTo42CUoZ1i2RMeewf64jj8BtmDsJCYkvD7Vt9
	 Q+D19gSA5qhWDK7TfbZAH0KJyf6ewoly/MbZBmNP3uwl5NSyyRf8rYz7JrITDCrL1V
	 jlcjhXVLw2kIw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:41:30 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:41:29 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CDACA31843CE; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/11] xfrm: Add error handling when nla_put_u32() returns an error
Date: Fri, 15 Nov 2024 09:33:41 +0100
Message-ID: <20241115083343.2340827-10-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115083343.2340827-1-steffen.klassert@secunet.com>
References: <20241115083343.2340827-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: "Everest K.C" <everestkc@everestkc.com.np>

Error handling is missing when call to nla_put_u32() fails.
Handle the error when the call to nla_put_u32() returns an error.

The error was reported by Coverity Scan.
Report:
CID 1601525: (#1 of 1): Unused value (UNUSED_VALUE)
returned_value: Assigning value from nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num)
to err here, but that stored value is overwritten before it can be used

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b6ce2b3c6b87..fab18b85af53 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2609,8 +2609,11 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 	err = xfrm_if_id_put(skb, x->if_id);
 	if (err)
 		goto out_cancel;
-	if (x->pcpu_num != UINT_MAX)
+	if (x->pcpu_num != UINT_MAX) {
 		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
+		if (err)
+			goto out_cancel;
+	}
 
 	if (x->dir) {
 		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
-- 
2.34.1


