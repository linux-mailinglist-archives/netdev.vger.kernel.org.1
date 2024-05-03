Return-Path: <netdev+bounces-93199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8288F8BA8BA
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A673B1C22239
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6FC14A094;
	Fri,  3 May 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nXTJQG/1"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501914A095
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724870; cv=none; b=saUu5Hb/pgEV5XFvoHjgekq46IcPWTcQV5x1ECL8cGHsSAZ622orTEod8Kpfg6OiuwFOSw50vtp5IS3+yhPAF5kKCtkNPvAIWLOV6c9JstRQ3Wcy4Ykonxar5Lt1cl2G2fBKCQk/HwEouYDG27sSuMb614Gi9bZpRhWxItdG29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724870; c=relaxed/simple;
	bh=o4f+jYBM07D56iSTbcHXrYHtGPAo1cGgB4N/hHoNucU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyzCHBvZiED84Yg6/d/z7Hg2HONF9Aw3fvzhOiOXUjVTivBoA0uemZX4xfTVbA736O755M7n/DIVqDokl3K4Fuug/8Vz579sBYPInZ0jNNY2Vrop+6QBBhrA2jVVTV32Ys6R3l0bbN9xgk/MwpXCzLxKHxKOE4QzD+fGb0hOYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nXTJQG/1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1E3D9207D8;
	Fri,  3 May 2024 10:27:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Scur2fXx22qq; Fri,  3 May 2024 10:27:38 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A4237207AC;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A4237207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714724857;
	bh=0EQJ9WnAfbRCKRA7PDvR729axiQpiTuZapr1QDJd7Wo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=nXTJQG/189JAGaQPlbwFEzzp5IPwcyfMBUx6eoQkAAvRSNa5YbDq7fo/INTwdwEGN
	 PYR5c6ipxgk/IkAIABj1N9tei3ujrq86S0XIYBNrzUhdfEosuINvQx1y4jwCBdk1kn
	 90ZkGlh1Fwncami6oTAyO2IhT6SOaDVyOvNWhRvUTfpxSa1/koQloF5k8PqrVQ4SSJ
	 VF1Dz+8rtyPxe+nVEzNE/a62FK3SOfgNtMTSxNnokkZ9hcXERIzDOy0swpYZk8Fm/p
	 B3BR0UELH+9nFH0pJAAU2AerDJgUaABQ7MXYLNFnOmQF4sykJJJL1+Bi0rc0aLvaKB
	 L8wpkTZBYkGtw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 98B5C80004A;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 3 May 2024 10:27:37 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 May
 2024 10:27:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1A8753184459; Fri,  3 May 2024 10:27:36 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/5] xfrm: Add dir validation to "in" data path lookup
Date: Fri, 3 May 2024 10:27:30 +0200
Message-ID: <20240503082732.2835810-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503082732.2835810-1-steffen.klassert@secunet.com>
References: <20240503082732.2835810-1-steffen.klassert@secunet.com>
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

From: Antony Antony <antony.antony@secunet.com>

Introduces validation for the x->dir attribute within the XFRM input
data lookup path. If the configured direction does not match the
expected direction, input, increment the XfrmInStateDirError counter
and drop the packet to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmInStateDirError     	1

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.34.1


