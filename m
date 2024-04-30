Return-Path: <netdev+bounces-92337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0C8B6B23
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7166282070
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE455199AD;
	Tue, 30 Apr 2024 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Ai0C7NOg"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A232556F
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460995; cv=none; b=KWASd7Z+ptfSO1XhLd5rjR68SWdM38GMTKrzEJK7ewNr+PaYXHyrNzgujbE5J4Zni49tTC8PtmN4JiMz/p2yCD+wF8+eVY0adT+xNIM9EuVlvBdeDSfnuXHYKn2l2XTExVIQwaF9Bn9hKiPX+7SgoU1EC8V4Ef0Tz2Bx55gdDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460995; c=relaxed/simple;
	bh=TlUOKuXz+sJmH3zkoaKpKP/Q9cgJVpsg9XoV5CNaK2s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSEiuLPuu5X0ye2PvAiaKDpAjwFDBtzsqPiCjtd9+4FG6WN+xee3TdG0qYPJbEMasFS3KS8v8glKB9JQFle2PP4RyMDBo4x9GXpIqq/X52yfBlkKRaO6PAP7TGLQrqH7FxBG5Zfv01Hn6F/1CH63dqcueBAbwDaIViDD+ccmaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ai0C7NOg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E7239206D2;
	Tue, 30 Apr 2024 09:09:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2RVBTLgIVpA; Tue, 30 Apr 2024 09:09:52 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 58ECB201E5;
	Tue, 30 Apr 2024 09:09:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 58ECB201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714460992;
	bh=IL6F0PatEbmU9BPMUrYtmkgk9qSnisrxntJNB/wHACM=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=Ai0C7NOgx2Ru1wq7gbp4T9jgSLd1R4jENX4iUaYQusVX2/1DiIzDQnc9+pG4x2pSF
	 S+VvOjtQhIIjUvUdTSc+tPhvWo7xRtJxuQArWCzAvpaAFwbTXg+FNRf5N9+/1GRgLu
	 nh+ThNSOadx7+1x5ObdVhCXS+fFb4UN2+zVP/8UxwYZbNoRJ+xD3ZhjYlZKDNqyrGY
	 Cv8nxuDTzg5/Xu71yW5E5KE0hepqOlz/kO7MVKxBEOC3CFMaGxDHZbnK6wPfX/grnX
	 uaKRRK6WWPkuT9rVoiZquHpkU+pvqirLmy2bf/Nf4T384rS9QhzdoEy4AtGdw0vyRI
	 jJt2Yof4cjXSA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 4CB7380004A;
	Tue, 30 Apr 2024 09:09:52 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Apr 2024 09:09:52 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Apr
 2024 09:09:51 +0200
Date: Tue, 30 Apr 2024 09:09:45 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v14 4/4] xfrm: Restrict SA direction attribute to
 specific netlink message types
Message-ID: <35892b6ac691f9fcc5545a1f5b364111c25b1310.1714460330.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1714460330.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1714460330.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Reject the usage of the SA_DIR attribute in xfrm netlink messages when
it's not applicable. This ensures that SA_DIR is only accepted for
certain message types (NEWSA, UPDSA, and ALLOCSPI)

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v12 -> 13
 - renamed the function for clarity

v11 -> 12
  - fix spd look up. This broke xfrm_policy tests
---
 net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index f5eb3af4fb81..e83c687bd64e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3213,6 +3213,24 @@ static const struct xfrm_link {
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
 };

+static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
+				   struct netlink_ext_ack *extack)
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
@@ -3272,6 +3290,12 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto err;

+	if (!link->nla_pol || link->nla_pol == xfrma_policy) {
+		err = xfrm_reject_unused_attr((type + XFRM_MSG_BASE), attrs, extack);
+		if (err < 0)
+			goto err;
+	}
+
 	if (link->doit == NULL) {
 		err = -EINVAL;
 		goto err;
--
2.30.2


