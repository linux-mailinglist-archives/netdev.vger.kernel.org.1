Return-Path: <netdev+bounces-89896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CAA8AC1A8
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9304B20940
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B145035;
	Sun, 21 Apr 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zCIsbYxb"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20E10940
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738485; cv=none; b=sEzp+5lvb4feJNbez0sd81WO2Yae9z31FiZAG1V4Y7bB2fUHcKWYU9p4vl8BcwjFZw0O47tFG9Cov52eQTKeNMQA7Biq6EvckVJ3nyf7ASLXjvSLl6lvXRuDQWepHu7HxNmh7eHDzcl0GdwC95gAl0Yj9B+fSGH6YTFbxkR0ghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738485; c=relaxed/simple;
	bh=V7wdoj8xSvbM39GmHv//bd2BMssoXbC8jNNVux4Z6qY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/yxwE3QHhXWhYTAVUrQd4QX55RVzRtuyrviJgBfUBjep3VN9TOTIZEo9VrN28czjf7CoWf9q+QRhg3pWgrB2hrolyF/lVTKYbHhNVPYSTp9zKY8O0uscL78QGBKD7odGfN+wLjysa4Pf5eLPzFiDNMZp13QlVkQ7s1WLMoPAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zCIsbYxb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E51C220754;
	Mon, 22 Apr 2024 00:28:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKcnOQ-CcmC1; Mon, 22 Apr 2024 00:28:01 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4FC2A20518;
	Mon, 22 Apr 2024 00:28:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4FC2A20518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713738481;
	bh=I6tDcdy6y9eAnUuQdlnKVp10RBgP6AvJiNMp0tZUQcM=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=zCIsbYxbsngQJRvs6XDxfMyYFTuu6UkkqjGRzcLcKJZiTtZjNwa3N6wdkbaOZBtF+
	 jbxPkB21dqaSuRMyWuGcQvZiHY6U9yzbH/r7/htj2z77fkjzR7+Qz7/ElZx0swuY/P
	 wmgMcG/HEjMDcwibgBLwyazM+f9cs4eUlZ/g04RKt+WMkWdLulJ3SKJY6kOjYtSNr1
	 l3AmCKIZqGdgid5Agvr1WidP01mH+CYXK3msODCcfQGu9+PDHJCEuIfT4EQcu34VQC
	 Khu+lmP+/HgozdzbBXnjvGtTT/rpucxDKXKAwzcxu0HZKREEg2QfDRYGbkNopcPb28
	 ddcxpbclZE5ew==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 3EF1980004A;
	Mon, 22 Apr 2024 00:28:01 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:28:01 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 22 Apr
 2024 00:28:00 +0200
Date: Mon, 22 Apr 2024 00:27:48 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v11 2/4] xfrm: Add dir validation to "out" data
 path lookup
Message-ID: <bae7627414f03223034371142fa870a430cb3c5e.1713737786.git.antony.antony@secunet.com>
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

Introduces validation for the x->dir attribute within the XFRM output
data lookup path. If the configured direction does not match the expected
direction, output, increment the XfrmOutDirError counter and drop the packet
to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmOutPolError         	1
XfrmOutStateDirError    	1

Signed-off-by: Antony Antony <antony.antony@secunet.com>

v10 -> 11
 - rename error s/XfrmOutDirError/XfrmOutStateDirError/
 - fix possible dereferencing of x reported by Smatch
---
 include/uapi/linux/snmp.h | 1 +
 net/xfrm/xfrm_policy.c    | 6 ++++++
 net/xfrm/xfrm_proc.c      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index a0819c6a5988..23792b8412bd 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -337,6 +337,7 @@ enum
 	LINUX_MIB_XFRMFWDHDRERROR,		/* XfrmFwdHdrError*/
 	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
 	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
+	LINUX_MIB_XFRMOUTSTATEDIRERROR,		/* XfrmOutStateDirError */
 	__LINUX_MIB_XFRMMAX
 };

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6affe5cd85d8..298b3a9eb48d 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2489,6 +2489,12 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,

 		x = xfrm_state_find(remote, local, fl, tmpl, policy, &error,
 				    family, policy->if_id);
+		if (x && x->dir && x->dir != XFRM_SA_DIR_OUT) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTSTATEDIRERROR);
+			xfrm_state_put(x);
+			error = -EINVAL;
+			goto fail;
+		}

 		if (x && x->km.state == XFRM_STATE_VALID) {
 			xfrm[nx++] = x;
diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
index 5f9bf8e5c933..98606f1078f7 100644
--- a/net/xfrm/xfrm_proc.c
+++ b/net/xfrm/xfrm_proc.c
@@ -41,6 +41,7 @@ static const struct snmp_mib xfrm_mib_list[] = {
 	SNMP_MIB_ITEM("XfrmFwdHdrError", LINUX_MIB_XFRMFWDHDRERROR),
 	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
 	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
+	SNMP_MIB_ITEM("XfrmOutStateDirError", LINUX_MIB_XFRMOUTSTATEDIRERROR),
 	SNMP_MIB_SENTINEL
 };

--
2.30.2


