Return-Path: <netdev+bounces-177010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A68A6D415
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6010316B091
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10348189919;
	Mon, 24 Mar 2025 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="viTlRW++"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0007F7FC
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797149; cv=none; b=oiTEw0WxY4HeKCNyg5Agqg+uYNRuA21/KWvwZL+7YvY9iAQbC/OgUXdgQgQogVFdkjpXtXHNAN5WfpSQ53JuVF3a+UOoOOlcV+EOMQ2bUr/euSQMz1mUk7LsCturRjU9b5kkH6RVnhozNDCH4iOvFSkWC21jDbz2fPhZ/A0TtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797149; c=relaxed/simple;
	bh=ksFWpgu/qGIAAuS3CYVLIHXzuFRQiKevu6OCZbVTg9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJcni0BcPEYnvSA51VWstQhtgBfZqotVmn+Tu7kBag6aMy1MaWNJ4sX0aM9ITagFwGDtbW5t+QlnkKOfPkUvE+Ab7lDF04JIU678JbXDS34x9dDyIJVGHRM/LGOvDLY7HPt3/DPEgu25hKxyekWnlU4prXkQOAiRBhk7i4L0OM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=viTlRW++; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B606C2080B;
	Mon, 24 Mar 2025 07:18:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZHh8B-_uodYi; Mon, 24 Mar 2025 07:18:59 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A5DE0207AC;
	Mon, 24 Mar 2025 07:18:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A5DE0207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742797138;
	bh=ZfLKHRlzTR6ZquGv/6Ou3ZAnL8x7jkbeO5SvOjY6Hz8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=viTlRW++O5HwWscAVA1CFkeIwrC7Y6mh5YSAf07+TiEIgqdaQC5ATv8T11V0nez24
	 h20rM1HID+UlqZ0YL5KHtYAvuHJOh+g6wF+xVypK8R+nMWuvMvcra/ASlqRBQaY00V
	 kFILfrN60BgoXmuBkaZq4QNs1avt3FnbZmacJJfsi5HaB9qCa0lLVJHPgNO1DLuj3b
	 LZOOmHmB6XGJ3hlwTYb4RK11YfpCHT7Mps/e2r3bWPQhxNjkvvponyXk9Mdn+sS8VG
	 J3ZQ/Eq+0jRd2oZN6bT6GnRJCx9J1QTMNVyjnv1s7oXtGQB/ZiXKug4MxYw+ga/2ZD
	 Ssv63dTrCvTbQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 07:18:58 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 07:18:57 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7B78E3181032; Mon, 24 Mar 2025 07:18:57 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/8] xfrm: prevent high SEQ input in non-ESN mode
Date: Mon, 24 Mar 2025 07:18:48 +0100
Message-ID: <20250324061855.4116819-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324061855.4116819-1-steffen.klassert@secunet.com>
References: <20250324061855.4116819-1-steffen.klassert@secunet.com>
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

From: Leon Romanovsky <leonro@nvidia.com>

In non-ESN mode, the SEQ numbers are limited to 32 bits and seq_hi/oseq_hi
are not used. So make sure that user gets proper error message, in case
such assignment occurred.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 08c6d6f0179f..5877eabe9d95 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -178,6 +178,12 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay seq and seq_hi should be 0 for output SA");
 			return -EINVAL;
 		}
+		if (rs->oseq_hi && !(p->flags & XFRM_STATE_ESN)) {
+			NL_SET_ERR_MSG(
+				extack,
+				"Replay oseq_hi should be 0 in non-ESN mode for output SA");
+			return -EINVAL;
+		}
 		if (rs->bmp_len) {
 			NL_SET_ERR_MSG(extack, "Replay bmp_len should 0 for output SA");
 			return -EINVAL;
@@ -190,6 +196,12 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay oseq and oseq_hi should be 0 for input SA");
 			return -EINVAL;
 		}
+		if (rs->seq_hi && !(p->flags & XFRM_STATE_ESN)) {
+			NL_SET_ERR_MSG(
+				extack,
+				"Replay seq_hi should be 0 in non-ESN mode for input SA");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.34.1


