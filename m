Return-Path: <netdev+bounces-92336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298B8B6B22
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25AC28189C
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A82556F;
	Tue, 30 Apr 2024 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="P926Mmht"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387C199AD
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460980; cv=none; b=VFfDCZO51SdFaDmIJVM+l9kHkPIk0UPkri9jWqR/A3eN/VLkIm8Kq40gkbTiFAqaFeGZzysDH5jqXOWEzI2eipDn7/29dNAHCNVlT1htaV8M7w7rzdL+9VWAmi2ORShMpxyBeYgSeUOncthqmbprboZ0plT3XapPvVwXGTYTQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460980; c=relaxed/simple;
	bh=UKUHCjJ9BUAGWVI4AlGI+OzlciTvvP6yXkM+t0BDh5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVg8qzGXZST/GQsGWyqm2aZynArwQYWEb74BaeIs9PjdUakXJlbJokbXvk/AZ77TpCA+WaYrv4iKN+FBMMf82MzO69LsmoZkJWw4EHI+YKxkK4JMrQpgjiI0iEmolBGJ4Aev6n7H8p3G8U+9/0SDUDI+4LGzAZcX7jysJQF4+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=P926Mmht; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2F3D320561;
	Tue, 30 Apr 2024 09:09:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AJTykna_qg_O; Tue, 30 Apr 2024 09:09:36 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 357C9201E5;
	Tue, 30 Apr 2024 09:09:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 357C9201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714460976;
	bh=eObeOxV1/2TKQey8OyLwzypqjRK6sN0ovgzcmmiXUsY=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=P926MmhtZELA6pmtbHLG7slg/QEYdOfjYBVTOByrvxMHVrSHDLQXdNkOz/49B4OVV
	 5pYloCuoHh/zwFZrTV48IF1pDP+qjfbwOR/4hKf0FA3MkGhlgmboeLMFd1ik4CsQ58
	 aUQdYdTpBpqYx8uKAJZpJJBMCxtWEY21CO2tzEcv4+vUYSd5JolFYiocEiNhLvCTaI
	 alH51c8cfsj4Rc0qJ3SKYlM9DRPPjO9ghTn9x6cP7js9NGkfd9CVR9ha5ltY52Fp6x
	 kDomqvfdPK6VvcX1Nnt5BIY80wrpiQNPAY5xowWtsZ+O6CF6QXo8et7OWJpuEtYBnT
	 xDHOdmY6WyDFg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 28F6580004A;
	Tue, 30 Apr 2024 09:09:36 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Apr 2024 09:09:35 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Apr
 2024 09:09:35 +0200
Date: Tue, 30 Apr 2024 09:09:29 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v14 3/4] xfrm: Add dir validation to "in" data
 path lookup
Message-ID: <d03d08d9bbf0feef6ba2ea7cca12588298af1c0d.1714460330.git.antony.antony@secunet.com>
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

Introduces validation for the x->dir attribute within the XFRM input
data lookup path. If the configured direction does not match the
expected direction, input, increment the XfrmInStateDirError counter
and drop the packet to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmInStateDirError     	1

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v12 -> 13
 - improve documentation in xfrm_proc.rst text

v11 -> 12
 - add documentation in xfrm_proc.rst

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
index 5ac3acf4cf51..973d1571acac 100644
--- a/Documentation/networking/xfrm_proc.rst
+++ b/Documentation/networking/xfrm_proc.rst
@@ -73,6 +73,9 @@ XfrmAcquireError:
 XfrmFwdHdrError:
 	Forward routing of a packet is not allowed

+XfrmInStateDirError:
+        State direction mismatch (lookup found an output state on the input path, expected input or no direction)
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


