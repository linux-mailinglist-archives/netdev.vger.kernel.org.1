Return-Path: <netdev+bounces-77858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F281873385
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2C7281846
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A775EE8E;
	Wed,  6 Mar 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="v2TUdgXb"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B35F86C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719499; cv=none; b=ql1n6fFQ+MdWcfwjVkTob8qQIFPoRoyrVCkRNMKdVONP08ha2WYQZ65N932SxJhRziHDImoC2xWgzvnPBaokaoPSvURmJaN7ELkRvBbNGHHwoddWM5tYjCATnCnKQwqsXxd4BiLQi2lmFL75NvGnTwOfYl1Gxvsgrs9sKdcH20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719499; c=relaxed/simple;
	bh=Rk+nnc5ZzxQrpmJ5WR+tIRNihS3t7XH+hLtKV6qcDMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gofq6vOFVjLfqE/hgmrYSkbkRENIuj0ZyUKNcrIJPh2bmUALSuLi/cGPtLhyy3N9ye/ggX6q0SqZVP2gVVjX+V7MxDkJmgnQgeLbtzUqmchxbB71uXG75bF9n/nZeLFz5jWMWlPtRXoyGXbsidNIMz+V+soWGOtlpvIcsylHTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=v2TUdgXb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 08BE0207D5;
	Wed,  6 Mar 2024 11:04:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QZsSuxuVs3lt; Wed,  6 Mar 2024 11:04:52 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1C5262082B;
	Wed,  6 Mar 2024 11:04:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1C5262082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709719485;
	bh=Q3DVRpKKAb/sEgnzGNOgSTByVSBUWReZzpQe9mBepTw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=v2TUdgXbXYGkcpW/3OoLDdIs2N5cLZZ1VHe1ZXQgLIC89sa4yimAmxDsJKYfPMnzj
	 XZmzMo3tSAwPC8xLuePLoQc/MI5KCv7kun2pK7iKhf5ofH81X3IUWYqJmTMVfMWEtt
	 Ld2VexHNz/+h0mvcZIv3JGFdK9/JJipCdPbe/64n5cgXRw0EW97+/K17H2aHcm8qQ0
	 WJOy5M2jlCXxw8sLToond8c59WoG17/WBYQO5aAR918wBN1vsoVGySKpKz4RuYkux/
	 bkXM0naME7Nun4B1aECwqg6ongbjkauiMYjKdwx2ULpEUN9hkKWyaz6eTuf0B4YSN8
	 s76OqXY5Vx63g==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 0EBB580004A;
	Wed,  6 Mar 2024 11:04:45 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:04:44 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:04:44 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D2875318297D; Wed,  6 Mar 2024 11:04:43 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/5] xfrm: Avoid clang fortify warning in copy_to_user_tmpl()
Date: Wed, 6 Mar 2024 11:04:36 +0100
Message-ID: <20240306100438.3953516-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306100438.3953516-1-steffen.klassert@secunet.com>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
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

From: Nathan Chancellor <nathan@kernel.org>

After a couple recent changes in LLVM, there is a warning (or error with
CONFIG_WERROR=y or W=e) from the compile time fortify source routines,
specifically the memset() in copy_to_user_tmpl().

  In file included from net/xfrm/xfrm_user.c:14:
  ...
  include/linux/fortify-string.h:438:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
    438 |                         __write_overflow_field(p_size_field, size);
        |                         ^
  1 error generated.

While ->xfrm_nr has been validated against XFRM_MAX_DEPTH when its value
is first assigned in copy_templates() by calling validate_tmpl() first
(so there should not be any issue in practice), LLVM/clang cannot really
deduce that across the boundaries of these functions. Without that
knowledge, it cannot assume that the loop stops before i is greater than
XFRM_MAX_DEPTH, which would indeed result a stack buffer overflow in the
memset().

To make the bounds of ->xfrm_nr clear to the compiler and add additional
defense in case copy_to_user_tmpl() is ever used in a path where
->xfrm_nr has not been properly validated against XFRM_MAX_DEPTH first,
add an explicit bound check and early return, which clears up the
warning.

Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linux/issues/1985
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..444e58bc3f44 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2017,6 +2017,9 @@ static int copy_to_user_tmpl(struct xfrm_policy *xp, struct sk_buff *skb)
 	if (xp->xfrm_nr == 0)
 		return 0;
 
+	if (xp->xfrm_nr > XFRM_MAX_DEPTH)
+		return -ENOBUFS;
+
 	for (i = 0; i < xp->xfrm_nr; i++) {
 		struct xfrm_user_tmpl *up = &vec[i];
 		struct xfrm_tmpl *kp = &xp->xfrm_vec[i];
-- 
2.34.1


