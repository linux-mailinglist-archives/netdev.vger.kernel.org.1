Return-Path: <netdev+bounces-86924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A3A8A0CA8
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34581C20EEF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443E14532C;
	Thu, 11 Apr 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="S8bcwcIn"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009211448EF
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828545; cv=none; b=iJobkyBPS49B4ayyXgbrXx0aFhzqob8lYFL814SK5ad+G1dut0Dz18IDa3yIutQHTu6bDvQihpgI0CPvTSI8QyTywAcGEuAD/z9rk+R8/lh6D9oji1M4NMUrjIY+i6aKTQjO0TGxHUEYc5GrO8cdcuHnEDXB3pTUnLqr/6BriXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828545; c=relaxed/simple;
	bh=EwflpcPhm9ndBUj7xkqCxwDezd7rQrKfl/V41xJrwQs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0jL92bW+oyqDhwWGyu0t1FDuTrpnrjF0fo6qbbAsNiLRuEZQhy2gCEUm5G4TJNNUcOc+sAab2coKNuHFulelA+MPRKGImIBj+C8jKZrYioqH+pmKLKAjZX71hmPUoAYQjC73x3jmkoVWAQHisfFZrTJzZfGKEqZgIxH06m/gXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=S8bcwcIn; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3F43720851;
	Thu, 11 Apr 2024 11:42:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrKQVFk8wZQr; Thu, 11 Apr 2024 11:42:20 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ABDED2084E;
	Thu, 11 Apr 2024 11:42:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ABDED2084E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712828540;
	bh=5xIX6Hg/K+Te4clKFUshRc3TGRSgSiIbrnKo8tYjiGQ=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=S8bcwcIncLgaV+pj7pSJKqqKKRdPnAH/y72xpNrI36XxT1ULJ/LC6/32ENi/HUxbo
	 jbnx7j81TJJTHUsgmzdrMOVJ+SGkTnjEU7F6DDdtbxuWAhT8Etzw8ZlDJyU7F4vvaG
	 xoGILtf3+8RDslGd5bzdvdzXzsfxSNBlmQHcR4K6eBg/lOh8iFxYGf+gJJRs92pHEM
	 ead3LhHuGjXKXgiOGTSmNHxLoRjcQEdYU2ayB8Wi/BqxjzzEZJVpsIeLQoPpZMJIjG
	 gpMfeDIQDD8o9JVYfED5xBSMf4zJIjbYedqo5Ha7sPeBKGjGDFx6XsF+czgzhYXPrl
	 fdOviuqAsFyFA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 9ED6D80004A;
	Thu, 11 Apr 2024 11:42:20 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 11:42:20 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 11 Apr
 2024 11:42:19 +0200
Date: Thu, 11 Apr 2024 11:42:13 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v10 2/3] xfrm: Add dir validation to "out" data
 path lookup
Message-ID: <274c82dfea0d656f59f69ccaab46d4319f0ef54c.1712828282.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

Introduces validation for the x->dir attribute within the XFRM output
data lookup path. If the configured direction does not match the expected
direction, out, increment the XfrmOutDirError counter and drop the packet
to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmOutPolError         	2
XfrmOutDirError         	2

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/uapi/linux/snmp.h | 1 +
 net/xfrm/xfrm_policy.c    | 6 ++++++
 net/xfrm/xfrm_proc.c      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index a0819c6a5988..00e179c382c0 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -337,6 +337,7 @@ enum
 	LINUX_MIB_XFRMFWDHDRERROR,		/* XfrmFwdHdrError*/
 	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
 	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
+	LINUX_MIB_XFRMOUTDIRERROR,		/* XfrmOutDirError */
 	__LINUX_MIB_XFRMMAX
 };
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6affe5cd85d8..7deeb21dae15 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2489,6 +2489,12 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 
 		x = xfrm_state_find(remote, local, fl, tmpl, policy, &error,
 				    family, policy->if_id);
+		if (x->dir && x->dir != XFRM_SA_DIR_OUT) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTDIRERROR);
+			xfrm_state_put(x);
+			error = -EINVAL;
+			goto fail;
+		}
 
 		if (x && x->km.state == XFRM_STATE_VALID) {
 			xfrm[nx++] = x;
diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
index 5f9bf8e5c933..aa993bdd29ed 100644
--- a/net/xfrm/xfrm_proc.c
+++ b/net/xfrm/xfrm_proc.c
@@ -41,6 +41,7 @@ static const struct snmp_mib xfrm_mib_list[] = {
 	SNMP_MIB_ITEM("XfrmFwdHdrError", LINUX_MIB_XFRMFWDHDRERROR),
 	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
 	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
+	SNMP_MIB_ITEM("XfrmOutDirError", LINUX_MIB_XFRMOUTDIRERROR),
 	SNMP_MIB_SENTINEL
 };
 
-- 
2.30.2


