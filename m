Return-Path: <netdev+bounces-241474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14840C843B7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3AFA4E8A18
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BE62DC337;
	Tue, 25 Nov 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="M8CvhryR"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CA2C3245
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063029; cv=none; b=Xy8DL82oeg+E/dewAt6JHjWRhCyMlIayWPK/5fXajAa9xCxq7J5T0znCpe/GA2YhQAmhN/Eab7wj6P2l7E1OzXqiDOg9cXNTYFYFf91VeGvCMGJHiHuQb24kA+CWrSQ6AX9+bSwSW0sdlDebPBEPrvkNV5gKLPPK/9Tzx0DGU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063029; c=relaxed/simple;
	bh=tCWFekDlPnxLEEe1VrnqVBflKAxWBtoDal7VkqZXg7o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swaJ7HPX654irOaNQVxTyAWMuTeXkSBxl58E2BTW2ChDYcQn4s45xlqQhmVN7lqRgoiuLmZf1sJg5E9NJEhcoBkU243ep84+CMHSEdXi21GuGirs17PwCq4kmzpvJoMrxGqCwgpnj4PNvapdd2wVncKIOblzy1s5tXwgsMxQOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=M8CvhryR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0CE872088A;
	Tue, 25 Nov 2025 10:30:24 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bQlDZwA3vRDg; Tue, 25 Nov 2025 10:30:23 +0100 (CET)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 72F7420758;
	Tue, 25 Nov 2025 10:30:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 72F7420758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764063023;
	bh=alB6epYxpbZu415BB7AQW2D0BpZSOsd6CwBG3BPCpJs=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=M8CvhryRQ0T0Jcx9EHqecj10acRO8Ks/df3rVL/vPkeIPXf/imF8uMmK77ceC5PQI
	 7lgNj/Dw0yVYiN4bBRFrpUoDh2ZE7VgTw/Nykma0Ph3BNoUeijMcFwX+YlkElngLUR
	 COFSUHmBvpzZ1hbh3Fyurzj+FOyNOaBC/2/KdD+jrpWKXIfvGI4XabdCTuOTR8FdPl
	 4sVkRfO0Fut6Lurij/q+gVL+WFH8H3ilwJMvrTqPGoBTOEiiIQcfHM2o9BG6tOjzwr
	 LHHSUipd8otYm+KURGy5t6EgWd19JorMCQEzmsmZm7pEeWYcoJB9n1jEJL5NHmw7kZ
	 eJCtDOByHJXEw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 25 Nov
 2025 10:30:22 +0100
Date: Tue, 25 Nov 2025 10:30:16 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH RFC ipsec-next 4/5] xfrm: reqid is invarient in old migration
Message-ID: <9a5b60029d95a264b5fdeaba396200419b4f4bc3.1764061159.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-02.secunet.de (10.32.0.172)

During the XFRM_MSG_MIGRATE the reqid remains invariant.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 2 +-
 net/xfrm/xfrm_user.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 17c3de65fb00..91e0898c458f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2148,7 +2148,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 
 	/* add state */
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) ||
-			x->props.reqid != xc->props.reqid) {
+		x->props.reqid != xc->props.reqid) {
 		/* a care is needed when the destination address or the reqid
 		 * of the state is to be updated as it is a part of triplet */
 		xfrm_state_insert(xc);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index cc5c816f01ed..b14a11b74788 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3098,6 +3098,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,
 		ma->proto = um->proto;
 		ma->mode = um->mode;
 		ma->old_reqid = um->reqid;
+		ma->new_reqid = um->reqid; /* reqid is invariant in XFRM_MSG_MIGRATE */
 
 		ma->old_family = um->old_family;
 		ma->new_family = um->new_family;
@@ -3285,7 +3286,7 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 			xfrm_send_migrate_state(um, encap, xuo);
 		} else {
 			if (extack && !extack->_msg)
-				    NL_SET_ERR_MSG(extack, "State migration clone failed");
+				NL_SET_ERR_MSG(extack, "State migration clone failed");
 			err = -EINVAL;
 		}
 	} else {
-- 
2.39.5


