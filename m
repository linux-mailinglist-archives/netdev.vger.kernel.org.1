Return-Path: <netdev+bounces-89898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CCD8AC1EC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 00:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F29280E7C
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89E3CF40;
	Sun, 21 Apr 2024 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ESX0Trvz"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E71B974
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738672; cv=none; b=MEPUW0YHxleNKNNljo6gcrmUVLgcQGrl05gRKFvItK9JziEhTrMj44ladKWQecfPSbmabIKIDxl98zQMcnz/t9v1nhVqW10uUGEGjV+M6+BO/7h0MUwKiSss8qJ9YRQOC6/GhQPitH8XSEpTonitRsfDcINS0D3DSDfRslQtWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738672; c=relaxed/simple;
	bh=nuxo4MJI4rEDsPcShkc0QJe5ibh+M2L0Iy4GW+LHauQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z++3/FR0I7rCIDwbULahYu0HUIU0pk/wrncf3ueiPod8/Y/JX5xbRpo5+U++Pz8tBicj+kx2LhtpelDXHHAo/PMs72/FI9wwCqNMUan2xiK+nLb3mXkz6q3AGUjJWwr9eyT25z6fO9icUowS2s6zmj0RTh4IJ1w2f4qmvI24jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ESX0Trvz; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A22DB20754;
	Mon, 22 Apr 2024 00:31:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bx4bOIHSAxoQ; Mon, 22 Apr 2024 00:31:07 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1FA5C20518;
	Mon, 22 Apr 2024 00:31:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1FA5C20518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713738667;
	bh=lFwc8FRL77QO87+u5I0ow4VzwfwVNOdc7JlhD3zntQA=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=ESX0Trvz7olc+uHD08SDQ59e9BxBW/4glx/QURUY3whpSNF+CIUXo5mQkM2jqoOa5
	 dO1B9ft7dmNu+RKc85ww+TUvu8Ny4Ia+XWRjkvufAmyXX5feQkIja1vEnLrZnQiA4d
	 90ZBnI/FgyadbWz+0ebIWIiE4OcqgfrI4dJOyXblIduLEe3lNwe/+K5pjHAbc614EB
	 j+bFi5rTXMSxvsSp7w3zHef93LyWPE7GYczZ0Fpg01qmEuKqj6p1ABI0y5Q/gTpk/7
	 XTW8rj4KqzxGr7JzDIB9p71g8N1tJpCuF6qqHEHKl+0+6zINef/sWei8c3lIfApW+n
	 q2QW3HiOWX08Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 0E9CF80004A;
	Mon, 22 Apr 2024 00:31:07 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:31:06 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 22 Apr
 2024 00:31:06 +0200
Date: Mon, 22 Apr 2024 00:30:53 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v11 4/4] xfrm: Restrict SA direction attribute to
 specific netlink message types
Message-ID: <5b468f00ea315aefdac0a7d6f509348b1c32ed8c.1713737786.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1713737786.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1713737786.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

Reject the usage of the SA_DIR attribute in xfrm netlink messages when
it's not applicable. This ensures that SA_DIR is only accepted for
certain message types (NEWSA, UPDSA, and ALLOCSPI)

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_user.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 54a0d750be4b..be977e96338b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3200,6 +3200,24 @@ static const struct xfrm_link {
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
 };

+static int xfrm_reject_unused(int type, struct nlattr **attrs,
+			      struct netlink_ext_ack *extack)
+{
+	if (attrs[XFRMA_SA_DIR]) {
+		switch (type) {
+		case XFRM_MSG_NEWSA:
+		case XFRM_MSG_UPDSA:
+		case XFRM_MSG_ALLOCSPI:
+			break;
+		default:
+			NL_SET_ERR_MSG(extack, "Invalid attribute SA_DIR");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
@@ -3259,6 +3277,10 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto err;

+	err = xfrm_reject_unused((type + XFRM_MSG_BASE), attrs, extack);
+	if (err < 0)
+		goto err;
+
 	if (link->doit == NULL) {
 		err = -EINVAL;
 		goto err;
--
2.30.2


