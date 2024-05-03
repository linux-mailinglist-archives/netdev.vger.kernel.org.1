Return-Path: <netdev+bounces-93196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FEC8BA8B7
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEE3B22418
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F4514A4E9;
	Fri,  3 May 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="edKV8yBm"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D6148853
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724868; cv=none; b=XWjZ96h32aYKkr9ZbJib5NLtOBKJ6CdTLm/pdE1TF1L024Cj6U/Ilu/a1N15ocvzUPXBXbD3TZ5AG5dzaOXvx08LAyFibnC6fJU69QEMJs2p6Zt9dLRN1Wk8VMFY5NRFhMvZ5xsEa+RtIf8NvyzlLCD1fzCu3H5na5niwIxnEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724868; c=relaxed/simple;
	bh=y7pBiiPbvfTb84KF03jVctqm5DzMgeapv2qSbV/91Rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdCnVa8z6hJXFRKzzxtE2Gh2M66xZsua9sZT3slVFxRaddwjbpRB1JBSgxA0TPUfbfwAkD6wzyPtcY6rgkueXW2yRVWVFW13tw6PgFCsbidZZMvfXJ1VQKVhBvvmZ8K1cGSFpj60JyadEpfLhpfd91rOdHyD9ext9c5Uu0Hg07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=edKV8yBm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9220C2084B;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-6zKAzZjU7X; Fri,  3 May 2024 10:27:37 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E7EB9207AC;
	Fri,  3 May 2024 10:27:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E7EB9207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714724856;
	bh=hIXwNTeTllDznsWqMaAGrmoOyR4SXUZatLajLkFpi9E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=edKV8yBm6gDQ1SeULjAW5W6W4aJu/0yJT1zTI3U+6RVi2TR0+oig5Kl8YIyM68e0J
	 KHUksAZMpSP9u3uVJJdghUop0qQFEt7U1a+pGNtQudCxpki+ksQJkXnuFSHGUL1AxS
	 Wv22J8TKPnuR7IvqxhsM65ASf0SHImFmp7ywcR4QcnD0hfcCG3ea/JBPbpySfYo2xG
	 hau8U/GRb/sixfXCMlfDQGkHPBGhHu3iVGLOUgmwQ+kqMY53BssIDaKO9J7Vf8zU4i
	 0mRr5H7ghMa95OTho2k4Z7rOSybRL5UfqiIdjDGnOyk8B/cv6C631hjrtFixfVEM7E
	 8e8qoDcEIkn4Q==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id DB30480004A;
	Fri,  3 May 2024 10:27:36 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 3 May 2024 10:27:36 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 May
 2024 10:27:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 170823184457; Fri,  3 May 2024 10:27:36 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/5] xfrm: Add dir validation to "out" data path lookup
Date: Fri, 3 May 2024 10:27:29 +0200
Message-ID: <20240503082732.2835810-4-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Antony Antony <antony.antony@secunet.com>

Introduces validation for the x->dir attribute within the XFRM output
data lookup path. If the configured direction does not match the expected
direction, output, increment the XfrmOutStateDirError counter and drop
the packet to ensure data integrity and correct flow handling.

grep -vw 0 /proc/net/xfrm_stat
XfrmOutPolError         	1
XfrmOutStateDirError    	1

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 Documentation/networking/xfrm_proc.rst | 3 +++
 include/uapi/linux/snmp.h              | 1 +
 net/xfrm/xfrm_policy.c                 | 6 ++++++
 net/xfrm/xfrm_proc.c                   | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm_proc.rst
index 0a771c5a7399..5ac3acf4cf51 100644
--- a/Documentation/networking/xfrm_proc.rst
+++ b/Documentation/networking/xfrm_proc.rst
@@ -111,3 +111,6 @@ XfrmOutPolError:
 
 XfrmOutStateInvalid:
 	State is invalid, perhaps expired
+
+XfrmOutStateDirError:
+        State direction mismatch (lookup found an input state on the output path, expected output or no direction)
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
2.34.1


