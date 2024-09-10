Return-Path: <netdev+bounces-126826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830049729D6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3842862F6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6617BB12;
	Tue, 10 Sep 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zm8+H34w"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E517ADF1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951325; cv=none; b=PxlYbzpEFq5XndiFtHVBiScVP9r3Ky5bgdFxuQ8c9P3w1DRlBX+qHkCvi7yY88A9YCt8/vYpJ6rdee4E4mHjVcFRfpl+XyaHRPsB7/CxNQnPcc8y4ThigTDiiD1R13qH7XTRzMtzpiqbzSk597uslFD1YRlexH98AB5J6TtfIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951325; c=relaxed/simple;
	bh=RJdxDspsIkMexFz8u6rSIAX8xha9ppNa4YIYohlVjx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPNuTjlDIAn6lrbG98dmpwQEdinqSfRWBJnYtiHMqa7v8q1XQTLE5Ep+kxXC55ZbTU8MjBoGzgkq4hk/h4L+tB9qbhFOw1KrRyqOoxU/U0uT745FXhk8BBI+Stuy9mtiBRpS1mOj2F5l/6HQxMdOCbx4G2K7APQfPm7qKRl2kpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zm8+H34w; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6AD1620899;
	Tue, 10 Sep 2024 08:55:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8NYefbJl8yeT; Tue, 10 Sep 2024 08:55:22 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DEB0E2074B;
	Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DEB0E2074B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951321;
	bh=IRztqup5ks2ZMtLrfzn4qHW/9FuWOjd4TSiMvDaUn5w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=zm8+H34w9/b3si24+rzNDU/NWP5ifgkw8iODEHgBHaGYx77BooASgYaYORynAqVrM
	 IwEpbEwqoTwGDJX29sgoKGTkNwnRsdHuysotYJ2F0ck1kQg+Vw+TAYixmqDgWJ2sTM
	 crgVaumvc2ANstTJrkFX0sGWkwRgUlGgcjdtxB+lksi7b1HLgGrcjaJMOJisKpDyUD
	 Pb0zCQ/6nPnop04FeBFAMONq/hSu7b31/dyuMjRj3xcD7raaU9J+0hRk9RWH3i9Bn/
	 TswqFp+FU5uC0pcEfVY3m/VvopxGe1IHGlEtraiFSB/Y3QTY3QMWqCsnHML8hCGxfr
	 QMUOUEFeRPXJg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:21 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 208FA3180085; Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/13] xfrm: Remove documentation WARN_ON to limit return values for offloaded SA
Date: Tue, 10 Sep 2024 08:54:55 +0200
Message-ID: <20240910065507.2436394-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065507.2436394-1-steffen.klassert@secunet.com>
References: <20240910065507.2436394-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Patrisious Haddad <phaddad@nvidia.com>

The original idea to put WARN_ON() on return value from driver code was
to make sure that packet offload doesn't have silent fallback to
SW implementation, like crypto offload has.

In reality, this is not needed as all *swan implementations followed
this request and used explicit configuration style to make sure that
"users will get what they ask".
So instead of forcing drivers to make sure that even their internal flows
don't return -EOPNOTSUPP, let's remove this WARN_ON.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 9a44d363ba62..f123b7c9ec82 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -328,12 +328,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		/* User explicitly requested packet offload mode and configured
 		 * policy in addition to the XFRM state. So be civil to users,
 		 * and return an error instead of taking fallback path.
-		 *
-		 * This WARN_ON() can be seen as a documentation for driver
-		 * authors to do not return -EOPNOTSUPP in packet offload mode.
 		 */
-		WARN_ON(err == -EOPNOTSUPP && is_packet_offload);
-		if (err != -EOPNOTSUPP || is_packet_offload) {
+		if ((err != -EOPNOTSUPP && !is_packet_offload) || is_packet_offload) {
 			NL_SET_ERR_MSG_WEAK(extack, "Device failed to offload this state");
 			return err;
 		}
-- 
2.34.1


