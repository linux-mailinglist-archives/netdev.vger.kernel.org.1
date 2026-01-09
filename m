Return-Path: <netdev+bounces-248514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F727D0A7B6
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D514A306C3F6
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAE32BF21;
	Fri,  9 Jan 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZZ+DlqBH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB42350A37
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965921; cv=none; b=D6efpdHekgP7QogSjpqHjERYJRarz4H03cMEv1sv7r2wwL77yKoUInXAY7KIF4gDsPN5nZmCYH553k9wHgApSFoShn321PApsLTVyJqu7/3MHIMyGb4cFh6FyDHvfJEdy1oSfM5Yaoc4439zfkdLaKwZN7QdFPwJPN8Wm7YYc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965921; c=relaxed/simple;
	bh=xW6Motlii2+qTLXfqC4Kpmf1OgYw+WsNKOgkszwuN0Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzNooFWc1BBATrNJXhrfIFGZRmgcqHgrluUTRGdm4qOgHtWHKXn7hHUsztnbfS8vQmZm/hkZz28AeD6vEHZaxHU3jyD7N/0OGjrFGNBkanmCKTsUJiF96mOPwcMTXN9XpIjw4e24r4ZgKTl7pzUtLwB7jU0NVEiWiYXmERX71SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZZ+DlqBH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 25945207BE;
	Fri,  9 Jan 2026 14:38:38 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ehsLebdrUnzc; Fri,  9 Jan 2026 14:38:37 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A0EC5206B0;
	Fri,  9 Jan 2026 14:38:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A0EC5206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1767965917;
	bh=I+w1kgmxcDzwFk04EGxq3BmZb5c/Tf1HheFzjp7nzkE=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=ZZ+DlqBHdJE6yO/IXASZrwLxLKTmkQiexpMPnYVfN9ZaEhaOWzW37+At/z9u8ybjc
	 u/MBa2dqc4smGMusRuoJ18EW+DEO/uhybXnr92PUQ8J/fhnCNDEFaLVwGLcmgKyVvY
	 J7wv2zoDglVgntHGxXvME0As2p/HUq8oMlAqBY5vrnWy9sazIwT7dcV6PEM+Bft4wA
	 rBssHNLk0jB2W67ubtEd0EVTzAJFGJgOS+F0lt+XqDZoG3AwU+XROu4Wr8VReTK0e2
	 CTsBH1jJ5S/kLB/VU8xEPfMhkp3U3wINVkR4GdhKzgLlmV4c20JQwRSo92GLQgs5j6
	 R1frpYrN2h28Q==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 14:38:37 +0100
Date: Fri, 9 Jan 2026 14:38:31 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next 5/6] xfrm: reqid is invarient in old migration
Message-ID: <44ed6325fa1d786b289674d72701663a525d8ea3.1767964254.git.antony@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <cover.1767964254.git.antony@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1767964254.git.antony@moon.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

During the XFRM_MSG_MIGRATE the reqid remains invariant.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 358044fc2376..13364d45a7b6 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3104,6 +3104,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,
 		ma->proto = um->proto;
 		ma->mode = um->mode;
 		ma->old_reqid = um->reqid;
+		ma->new_reqid = um->reqid; /* reqid is invariant in XFRM_MSG_MIGRATE */
 
 		ma->old_family = um->old_family;
 		ma->new_family = um->new_family;
-- 
2.39.5


