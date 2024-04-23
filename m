Return-Path: <netdev+bounces-90543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29848AE704
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A38C287430
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07B12A14D;
	Tue, 23 Apr 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mjyEvhcN"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3E12C480
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876656; cv=none; b=f6KHVGhZ38VuRJWGpXRBFIL0GwJG9Txsa2YT/yyb+6Yc1c+RCSr5xnJTGgR+tG1TKGzB6H0aJ5nf4F6RDlIp8eC+5gdzKCbwUv3OpBk94jI2eUah2822ZEjbymJpN+Y+NEP+9C956P0AnkeLtMb0SSXSRQQIU99LGb/zaYg8lWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876656; c=relaxed/simple;
	bh=h03mScMkNzLek+50/Q5WWNMBF6se3HcD4eXBao/gDYQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpKJYwRWNdL5zOTSolysq+zA5VfqhZXynZ53OcqlzIFORqtRFLQbbvUxvlSoZXSH7WyFHJXw2mkatbG22PUVI/IzmcTMZmIqsnPY9b9fr1L8NU0JF7y0vyzrID+Oj5BgVtcogUuoQVji2xBnTZzb+ChSh88RrItl//sSzQo2w0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mjyEvhcN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8708A2074F;
	Tue, 23 Apr 2024 14:50:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4iM50U4Wy67Q; Tue, 23 Apr 2024 14:50:51 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D3E8820518;
	Tue, 23 Apr 2024 14:50:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D3E8820518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713876651;
	bh=9R8ETc6mZgTgbDVqJe9XuKfHxUT6RlVfAyMezWW+LpA=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=mjyEvhcN3so7ULr4mrnGQOWTiwhO0pCSU/JNbA9aAMwu8f2nIWHwEA6J8o+5rpvuM
	 AAKJkAqJmHEdQrrT9EpyVSTR3k1+vWoWpaSiH40MZkW+hffBSCqSbqimCebAWakzH5
	 rgfRa63SNk0BIMyk84mCGwTx1hScjUliLb0YCVB1wNQiR9rjywdIFtu035CS+yTCDM
	 btIhH3BZFMdsJnNy1k3DEhg209mZex8FXbHfw6AFh/wd6NGqB2hOfFD+E2khREXWEV
	 5fjVJqCgOpCdplfHFMM9iD1sJ6J42W7vQWMwFt3oL2T357vFJKbh6u9vN1DP+agjQx
	 /YIvA0w05Yubg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id C708080004A;
	Tue, 23 Apr 2024 14:50:51 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 14:50:51 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 23 Apr
 2024 14:50:50 +0200
Date: Tue, 23 Apr 2024 14:50:43 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v12 3/4] xfrm: Add dir validation to "in" data
 path lookup
Message-ID: <f7492e95b2a838f78032424a18c3509e0faacba5.1713874887.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1713874887.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1713874887.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)

Introduces validation for the x->dir attribute within the XFRM input
data lookup path. If the configured direction does not match the
expected direction, input, increment the XfrmInStateDirError counter
and drop the packet to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmInStateDirError     	1

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v11 -> 12
 - add documentation to xfrm_proc.rst

v10->v11
 - rename error s/XfrmInDirError/XfrmInStateDirError/
---
 Documentation/networking/xfrm_proc.rst |  3 +++
 include/uapi/linux/snmp.h              |  1 +
 net/ipv6/xfrm6_input.c                 |  7 +++++++
 net/xfrm/xfrm_input.c                  | 11 +++++++++++
 net/xfrm/xfrm_proc.c                   |  1 +
 5 files changed, 23 insertions(+)

diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm_proc.rst
index c237bef03fb6..b4f4d9552dea 100644
--- a/Documentation/networking/xfrm_proc.rst
+++ b/Documentation/networking/xfrm_proc.rst
@@ -73,6 +73,9 @@ XfrmAcquireError:
 XfrmFwdHdrError:
 	Forward routing of a packet is not allowed

+XfrmInStateDirError:
+        State direction input mismatched with lookup path direction
+
 Outbound errors
 ~~~~~~~~~~~~~~~
 XfrmOutError:
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 23792b8412bd..adf5fd78dd50 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -338,6 +338,7 @@ enum
 	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
 	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
 	LINUX_MIB_XFRMOUTSTATEDIRERROR,		/* XfrmOutStateDirError */
+	LINUX_MIB_XFRMINSTATEDIRERROR,		/* XfrmInStateDirError */
 	__LINUX_MIB_XFRMMAX
 };

diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 2c6aeb090b7a..d5bac0d76b6e 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -266,6 +266,13 @@ int xfrm6_input_addr(struct sk_buff *skb, xfrm_address_t *daddr,
 		if (!x)
 			continue;

+		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEDIRERROR);
+			xfrm_state_put(x);
+			x = NULL;
+			continue;
+		}
+
 		spin_lock(&x->lock);

 		if ((!i || (x->props.flags & XFRM_STATE_WILDRECV)) &&
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 161f535c8b94..71b42de6e3c9 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -466,6 +466,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	if (encap_type < 0 || (xo && xo->flags & XFRM_GRO)) {
 		x = xfrm_input_state(skb);

+		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEDIRERROR);
+			goto drop;
+		}
+
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMACQUIREERROR);
@@ -571,6 +576,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}

+		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEDIRERROR);
+			xfrm_state_put(x);
+			goto drop;
+		}
+
 		skb->mark = xfrm_smark_get(skb->mark, x);

 		sp->xvec[sp->len++] = x;
diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
index 98606f1078f7..eeb984be03a7 100644
--- a/net/xfrm/xfrm_proc.c
+++ b/net/xfrm/xfrm_proc.c
@@ -42,6 +42,7 @@ static const struct snmp_mib xfrm_mib_list[] = {
 	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
 	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
 	SNMP_MIB_ITEM("XfrmOutStateDirError", LINUX_MIB_XFRMOUTSTATEDIRERROR),
+	SNMP_MIB_ITEM("XfrmInStateDirError", LINUX_MIB_XFRMINSTATEDIRERROR),
 	SNMP_MIB_SENTINEL
 };

--
2.30.2


