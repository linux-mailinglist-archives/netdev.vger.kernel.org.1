Return-Path: <netdev+bounces-233428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6BC132CA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D16C4506E8A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 06:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951102BDC34;
	Tue, 28 Oct 2025 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UMMIUITA"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC52BE029
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632963; cv=none; b=WTSymTOmqJEVuxC1kjW2oAKAVxczYsikA2TAKJHg9hwe2YAxUEoiLi/7vArseab68zemfqjDkv8fcrOjH3wVlfRUPhKWn1r52LHoIBYXd8WbCqlI1YgiuLb2SfkEpyG/cYA0nt7/ziEUH6OtSIeWcFZsXZiSM3SVLbkW9CZT5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632963; c=relaxed/simple;
	bh=+dc2O+xTthU7i8ZxGgDJ7CikugU/wahFuIKAr66ISbM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PUjxEHV1hS89MRNXoeeWKxnCYL/EYfI3idCJVVLOpORaZV9I7qEBKUkFBPio3GVSR1e5WWefJhQY7yT0EFkZwC2//+eipI90/purEI3n2ba9EeWtm4hC6D+HVIMrA365gt7Fa3qI3ioojKwYU4Vt0xUG1hv4siggyAPVSbovF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UMMIUITA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B978F207B2;
	Tue, 28 Oct 2025 07:29:11 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eS3hnfcfXYEE; Tue, 28 Oct 2025 07:29:11 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E924D201E2;
	Tue, 28 Oct 2025 07:29:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E924D201E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1761632950;
	bh=ovayAyZxhWyhGsd6PNZUB6cWu1V5GBAmth0bIIxUjxM=;
	h=Date:From:To:CC:Subject:From;
	b=UMMIUITA31QPchEAzNRgl9QPfmWlOcCn7JjHgdwBud1qKFIg3/r8uPG+UiY5FJtqs
	 IUkujMA8zOtDWG9IwIG1h9z5fWUZzR0WbIW+a4LlpvaED/DuGBQbrIpZ9W3Di0kNeE
	 nOYDf+lqImIfmw2ob4u6Lmd4V6JZGMwj0VrE0ILckRkmwPDEs1QrN92yuj4goPKXpC
	 vFZbu+5KVWe7wRgD4xUdJgzHVZhPgZ9b5z0I1Vto2TJLF+YBgq6k8XAGR0uXloVuoF
	 QScj8LFgn6p0ce1UNwk+zcH6/V8xJAt9Z71U/uabK/j5UOOEFKIgeG3qv98zmQFAiU
	 Fqpya4+xWIyAA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 07:29:10 +0100
Received: (nullmailer pid 1349919 invoked by uid 1000);
	Tue, 28 Oct 2025 06:29:09 -0000
Date: Tue, 28 Oct 2025 07:29:09 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>, Tobias Brunner
	<tobias@strongswan.org>, Antony Antony <antony@phenome.org>, Tuomo Soini
	<tis@foobar.fi>, "David S. Miller" <davem@davemloft.net>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: [PATCH v2 ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aQBitXM2fxLb82Eq@secunet.com>
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
will be removed in a second step.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Antony Antony <antony.antony@secunet.com>
Acked-by: Tobias Brunner <tobias@strongswan.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Tuomo Soini <tis@foobar.fi>
Acked-by: Paul Wouters <paul@nohats.ca>
---

Changes in v2:

- Add some new tags.
- Fix two typos in the commit message.

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


