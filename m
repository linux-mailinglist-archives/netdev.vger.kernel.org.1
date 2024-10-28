Return-Path: <netdev+bounces-139432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1257B9B2404
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 06:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C227BB21346
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F7518C01E;
	Mon, 28 Oct 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lLy5zi6d"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05B156960
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730092070; cv=none; b=jSkbXacjvZHFOxenAiy0PaiYS8rLuPQ7DXFlOUaVcmCWAzLaa1mUzQHQg1G3phTtemMU15wLuE9ognWdISw2iJc455K7DPi33POt7jtnj6uvVJvrJNWUBNwSw4o+uxfaf1UNOChOu6h1c2Ljp2f+q1sRk61F62JuzBFDX4Dq2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730092070; c=relaxed/simple;
	bh=N4dhZ6JzUE4CLYN+aQVEtmv40sF6OkYDclUPKfC4LFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTWf5cSdPxpU5TiRv5mI0k6oWIWMRI0bhwyDxYLyJvkIlx9LVheeiXgSwLlVimf6OWuhEn3loaQyfjrW8KYQvxlMQqG0oiDYBsUjqiOwlwSZuQDiyQtljQsbofK7z7HEWOzmW4nPHjWIkVrBnKnF29WWrnYW6cRqiFGf14RJpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lLy5zi6d; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730092066;
	bh=f2Wgny9VTAMDRmRU3TpQm16omarWfJleZ7QkQ1mowLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lLy5zi6dcFViGM7MKVEG810QfkNCOm62jvOfz3K0F5rx0d5L5bn4ii53qaBq0w42/
	 7l/6jRl0/GqviML5Yjv6tvHj4uIa7Owu0ibutBGOlpePTYI+yqPcphF0f24XPCjigV
	 b95D7sacxPbHh9DV/qLFSrjK5vG3cqWHLpjrH/N6UAUfKPM0XK86re3r3bSZbltB4A
	 JrGvcmBa5MM41gZNK6AnlyJ9j4WigyrVkjBClb8E0gMNpK9Z3tKo2/4YEr9TPoZszz
	 ijBvq2207RxOdcfsVV//Iu73JCKSwXDNe/bCqNcRJfY1V0LV4k/8N3yOjQmTHSxiVz
	 3/ol5aVQcdFSQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 667BB69E9A; Mon, 28 Oct 2024 13:07:46 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 28 Oct 2024 13:06:56 +0800
Subject: [PATCH 1/2] net: ncsi: don't assume associated netdev has a
 platform_device parent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-ncsi-fixes-v1-1-f0bcfaf6eb88@codeconstruct.com.au>
References: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
In-Reply-To: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Vijay Khemka <vijaykhemka@fb.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

The ncsi driver currently does a:

       pdev = to_platform_device(dev->dev.parent);
       if (pdev) {

However, dev->dev.parent may be null, and to_platform_device() will not
catch this case as intended by the conditional.

Instead, check that dev->dev.parent is present, and is a
platform_device, before converting.

Fixes: 5e0fcc16e5c5 ("net/ncsi: Support for multi host mellanox card")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/ncsi/ncsi-manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5cf55bde366d1813865ac5da17d232b5eadb2a3e..647d12fde693114cfe3970e75546df48ad4c335e 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1789,8 +1789,8 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	ndp->ptype.dev = dev;
 	dev_add_pack(&ndp->ptype);
 
-	pdev = to_platform_device(dev->dev.parent);
-	if (pdev) {
+	if (dev->dev.parent && dev_is_platform(dev->dev.parent)) {
+		pdev = to_platform_device(dev->dev.parent);
 		np = pdev->dev.of_node;
 		if (np && (of_property_read_bool(np, "mellanox,multi-host") ||
 			   of_property_read_bool(np, "mlx,multi-host")))

-- 
2.39.2


