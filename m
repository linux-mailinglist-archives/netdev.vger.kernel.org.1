Return-Path: <netdev+bounces-92952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3292C8B96CC
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB8A1C21DA6
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2264F895;
	Thu,  2 May 2024 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="T4yD5NjX"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5947A5D
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639731; cv=none; b=PWlZg8gWsgSc99QWOCIO92IXq8mggGUAsG6jE2u7mlHF6FuwUh0mIkqTpjeoGpN3o9caQ76Yk2NAzK7e3OOzNpQwLVO6Zr4yWAFUqLDPBLGDFM72Ub0LVsVd8K+fGj1A5CYWTkeVQHXteokN3ytI2d8ZfVYNZHJkaleYbSopmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639731; c=relaxed/simple;
	bh=p9QPJoAp0U8WzbtEWgq9DiMOOUvpIPL4Jya3xcYcbow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbhJPHafqT29IR6oKPcr44+ByoXJ3xuoyhiVHz0Xgi1X/mEHRqbRjN10mtrXb7874L1ZXe3JrY49n/DliDWrLcWCiqpKwF3sTzRwUtM0qtwQROjbkB8U/M4CsNewId2K/g8bEBmHzM08nbqMv+0PoCfd0nr6P/CMpTGDEYgVrI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=T4yD5NjX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D4468207C6;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dNJarTEyDpB6; Thu,  2 May 2024 10:48:46 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 535FF201A0;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 535FF201A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714639726;
	bh=95YO8D1/+kPsrYSd4eAC6afEaanRTXJ1OP1JRnvMT4U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=T4yD5NjXTlRtigHtMIcDIdOmMBjDvm+KnvzGNCjiT2I+pE37IrZ28ZRRwQdXKi/wF
	 GhePHHzTraQOVchJq27OETSuEtH4J4HEd34xnzO2pd51bti6TCpKIZ079ll+TAU5x6
	 P7zfFayDDTcc3cytDTJPXVhGO/Xom1FKyZNVdLlVBOExCHVRv7WoeObmspfNIkSCyZ
	 8bGmUhYdeJcZjasIP2FeVW73lO8leOiLB7v6Kimear+6c/DPEU58Pm6K/G1lHIoZIK
	 nI1rVTuSlKtze/1LSd7q4bY5T/ARg3S0TZcjbOMDIiLfExYamiuELb2Pep55fncRfj
	 qpSa2390T0mRg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 46D9380004A;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 2 May 2024 10:48:46 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 May
 2024 10:48:45 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id AD9B7318406D; Thu,  2 May 2024 10:48:45 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/3] xfrm: Correct spelling mistake in xfrm.h comment
Date: Thu, 2 May 2024 10:48:38 +0200
Message-ID: <20240502084838.2269355-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502084838.2269355-1-steffen.klassert@secunet.com>
References: <20240502084838.2269355-1-steffen.klassert@secunet.com>
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

A spelling error was found in the comment section of
include/uapi/linux/xfrm.h. Since this header file is copied to many
userspace programs and undergoes Debian spellcheck, it's preferable to
fix it in upstream rather than downstream having exceptions.

This commit fixes the spelling mistake.

Fixes: df71837d5024 ("[LSM-IPSec]: Security association restriction.")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/uapi/linux/xfrm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..594b66e16395 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -228,7 +228,7 @@ enum {
 #define XFRM_NR_MSGTYPES (XFRM_MSG_MAX + 1 - XFRM_MSG_BASE)
 
 /*
- * Generic LSM security context for comunicating to user space
+ * Generic LSM security context for communicating to user space
  * NOTE: Same format as sadb_x_sec_ctx
  */
 struct xfrm_user_sec_ctx {
-- 
2.34.1


