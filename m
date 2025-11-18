Return-Path: <netdev+bounces-239432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 394F3C685F4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id E1CB92A906
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87732D0CD;
	Tue, 18 Nov 2025 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="P0zCj8GV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FB309F0A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456041; cv=none; b=s72oJEaXsgMDZRK2sIbEqghVZahAn3T53Rgj+2eTEAThDATvueCoWsf6H9ZRruZF7Kn/t1iJvdffvUSA0pL8FRJBytwbJTBOF7F2oLNwQaLzfeTu0v9cCFumPfkVmwzY/s0izTGcC2vYH+ZyOo7f0k9uIu3PmYX0W+BYG6t0la0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456041; c=relaxed/simple;
	bh=ykjWh10rQg85UM06jlLeZGr4TzY9MDuuWtSTNaW1J+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EczwNwD0cQmRt8G4Xmw/wOZa31qVga7XEkTXR5bbPDkKkueq9R29genMplEdozamG1xs/fjn9BolFz38JIhs0iT9KwGBoldWHYrEfYZTv3+7dTLoOpvj1hEvJtjJLJx4+GfbYZkCN2sV1eIQCjrEtflBigybJCJV156N4chbiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=P0zCj8GV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4975A207F4;
	Tue, 18 Nov 2025 09:53:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xo0bvQVTrzLj; Tue, 18 Nov 2025 09:53:50 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7560920743;
	Tue, 18 Nov 2025 09:53:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7560920743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456030;
	bh=xsz0MDaWbRLAjfhtDqZOvmy40vSp/TutfXmdjhc4S6I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=P0zCj8GVlJP6LJfi161+iUOMi1A9ipSeXLdSYdb1nZlHYeE732e9SH23dADUoe2Vn
	 o2ktQcNi96BGy7qTpkTsIc1K1HXXYCIHhotP8S78fpHRQrNdndcd4/ZG5UF3JMmhQk
	 6ObPbAGTbqxJ7HMWvBHdu7kqOiPrg7D9GGrwNAoiQK32zFJHaIKK2FqxSrfss8xf35
	 pV7oTFQb7WxQRqxgI1khI8mpyoGjG65wpEuWexIePeq3NXBqkTOPzE6U55NL9q0TUP
	 308iquGhL6gkriOdtZTogCCq0MvAaTiTX9aRxQoE5AssGhgx1E3jsAxDne8NQ0JXP7
	 i2mG/VH9jWsXw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:53:49 +0100
Received: (nullmailer pid 2200653 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:48 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/10] xfrm: make state as DEAD before final put when migrate fails
Date: Tue, 18 Nov 2025 09:52:36 +0100
Message-ID: <20251118085344.2199815-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118085344.2199815-1-steffen.klassert@secunet.com>
References: <20251118085344.2199815-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

xfrm_state_migrate/xfrm_state_clone_and_setup create a new state, and
call xfrm_state_put to destroy it in case of
failure. __xfrm_state_destroy expects the state to be in
XFRM_STATE_DEAD, but we currently don't do that.

Reported-by: syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5cd6299ede4d4f70987b
Fixes: 78347c8c6b2d ("xfrm: Fix xfrm_state_migrate leak")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 721ef0f409b5..1ab19ca007de 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2074,6 +2074,7 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	return x;
 
  error:
+	x->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(x);
 out:
 	return NULL;
@@ -2163,6 +2164,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 
 	return xc;
 error:
+	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
 	return NULL;
 }
-- 
2.43.0


