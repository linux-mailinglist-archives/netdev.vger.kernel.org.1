Return-Path: <netdev+bounces-231540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A380BFA2D0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01B5E4E179B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672FA2EC097;
	Wed, 22 Oct 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gHEqTrSn"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6B221F26
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113457; cv=none; b=LESdAIM68Hv0xMHFbleh03aqxw2e5Re+jl74KJd7mlBQ3FRz6RvmaxdgzwKVLpf9PhSxjK9Uc2yvY7Rr5LWlXV50EWVg0aWtZTMUBAHJwFj8HHGDBsyvBWHmN+mfq4Oo+iqOVXzBtubbmtuEbtwljXcPGFJx4n8DmuMJ+Oq9UVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113457; c=relaxed/simple;
	bh=AUenBrdFQdFgJAyUxKEClqlrwLJu+RcGEPBPv6XmMVk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j9HLyoJqlWBJB4YazSWH7QbkyHU0Q9z1lhP8I6td92KsJIzZJgRAfSqANp9dfpixBPMtt1V7EDJKoGo7XTYhyg3EzMtu6qNaIPu8ir4meGyKqgCnyhZz4cSiwoPhbprLS5VSRlTp4vGVYMyqZOLvxcivRUBRKUAPlXn0BoTNkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gHEqTrSn; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2621E2074B;
	Wed, 22 Oct 2025 08:10:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HdlF49AaEkJz; Wed, 22 Oct 2025 08:10:52 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 867B7206D2;
	Wed, 22 Oct 2025 08:10:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 867B7206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1761113452;
	bh=ag3pzH3xlmnM1NCT0RHPcgg9qEND51LyRt8yyh4P3+0=;
	h=Date:From:To:CC:Subject:From;
	b=gHEqTrSnjj9BFVrWiocBmy7r3Yy3DI6gCZKIyGXlVCDCYcC+8V5kQZ7OIHxdPEUrF
	 IxCplOcoxhxqIPoqYknfDhckfB0+FvcG7KmYe5X3MYOZZyPk0f0P+MkSTcQxMjTk0p
	 GRA9CoR9XMWXtAHeVp0RSdULzrNMcUikgqb2GxIyvWvr+cbWogemuN+IvA7L88fpaR
	 280+H80xkjje/Q/dXFRLbRIGwsg5oU3uWAzJ7eI2gLXdCSJyyaahUd97EgK/rXvAu0
	 7kQz50yYbXuA8s2DZxTIvchY0UIof/gCNwkTGirt+AfWFr6uLZpQubWYM62nbMjXoP
	 mNsy40WIpX4SQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 08:10:51 +0200
Received: (nullmailer pid 3647640 invoked by uid 1000);
	Wed, 22 Oct 2025 06:10:51 -0000
Date: Wed, 22 Oct 2025 08:10:51 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>, Tobias Brunner
	<tobias@strongswan.org>, Antony Antony <antony@phenome.org>, Tuomo Soini
	<tis@foobar.fi>, "David S. Miller" <davem@davemloft.net>, Florian Westphal
	<fw@strlen.de>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aPh1a1LeC5hZZEZG@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

The pfkey user configuration interface was replaced by the netlink
user configuration interface more than a decade ago. In between
all maintained IKE implementations moved to the netlink interface.
So let config NET_KEY default to no in Kconfig. The pfkey code
will be remoced in a secomd step.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Acked-by: Antony Antony <antony.antony@secunet.com>
Acked-by: Tobias Brunner <tobias@strongswan.org>
---

Antony, Tobias, I kept the Acked-by tags from the RFC version.
Let me know if that's ok.

 net/key/af_key.c |  2 ++
 net/xfrm/Kconfig | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..571200433aa9 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3903,6 +3903,8 @@ static int __init ipsec_pfkey_init(void)
 {
 	int err = proto_register(&key_proto, 0);
 
+	pr_warn_once("PFKEY is deprecated and scheduled to be removed in 2027, "
+	             "please contact the netdev mailing list\n");
 	if (err != 0)
 		goto out;
 
diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index f0157702718f..4a62817a88f8 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -110,14 +110,17 @@ config XFRM_IPCOMP
 	select CRYPTO_DEFLATE
 
 config NET_KEY
-	tristate "PF_KEY sockets"
+	tristate "PF_KEY sockets (deprecated)"
 	select XFRM_ALGO
 	help
 	  PF_KEYv2 socket family, compatible to KAME ones.
-	  They are required if you are going to use IPsec tools ported
-	  from KAME.
 
-	  Say Y unless you know what you are doing.
+	  The PF_KEYv2 socket interface is deprecated and
+	  scheduled for removal. All maintained IKE daemons
+	  no longer need PF_KEY sockets. Please use the netlink
+	  interface (XFRM_USER) to configure IPsec.
+
+	  If unsure, say N.
 
 config NET_KEY_MIGRATE
 	bool "PF_KEY MIGRATE"
-- 
2.43.0


