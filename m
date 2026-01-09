Return-Path: <netdev+bounces-248515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB8BD0A735
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 075633001BCF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8D22E8DFE;
	Fri,  9 Jan 2026 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mn6w4Go4"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C959350A37
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965943; cv=none; b=eUO90osQG77miWsgmxSLLKcyVhurQoI70fJ0WoXkSO0P/CX8zBbFlLQGqEZB8SbOd8Q5RHLQXOfc+8S22jrno0Msfh85Mt9WcAws5YitrKHrg2YHJRDdic+hjU7vFhU12hzXyHmyP6rbKdbelt+UxUJXdHYjfF7mS2ymdNXpjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965943; c=relaxed/simple;
	bh=X5pOr0HXH7690oZ+YMkpzs0sTwAwEvmHi5SArJOSCs0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO8Dz6jle+SSOlb9tN4qhVtAFEeISKMq8W8I74nT+N855SuZfqL6U7UMGJugYx8PYbZCE8c/zPD5H+CX8mEI6CbazAnY/TsqMp1tioyQ24vqpJ/vO0dLyjCeRtSCtKStHtf426YWuUfbveV5a6JhAYJoIhyXzCe5/eMGqYium8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mn6w4Go4; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C312A20842;
	Fri,  9 Jan 2026 14:39:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 783Ms9fccMpu; Fri,  9 Jan 2026 14:39:00 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 43BB1206B0;
	Fri,  9 Jan 2026 14:39:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 43BB1206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1767965940;
	bh=erxwDC74Yd/cL/vhsKRxodetgPXwn5vEI/xF1u2umVk=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=mn6w4Go4/TsJ9PYbFdgapHFlq9Rsjd7dyPrh1zFTSKkzsCX7ulzfgG0s34cWbxes2
	 VBYl3o33eWh+crRu+g+52vALskDDd5KywsCspAwPq4r/zH+sTFDpa/F34/AYJJ/2P1
	 iI8k6mqu5rxvQxAuvH9SIv9rgqkqhpptv2+EFYUfgMnGi6/b29tgNHpnHceOOuwFMD
	 PilwsXFVnREOj3ZvP+WFGsUJUlYyaMxI/cYlNQSFOUs6Ex4ONlwP9R4ATLxxLXcqrP
	 2TBdk3Qw3gcJpaDPUphYh8bkVQxuuI9hRLk4WosEyJbZ+uGIJvT+ukZIMmNELIPvDn
	 F/3EE5eDvnP/w==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 14:38:59 +0100
Date: Fri, 9 Jan 2026 14:38:51 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next 6/6] xfrm: check that SA is in VALID state before
 use
Message-ID: <a405d5032309cc92f1e6b63a167f26e4de15f7a9.1767964254.git.antony@moon.secunet.de>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

During migration, an SA may be deleted or become invalid while skb(s)
still hold a reference to it. Using such an SA in the output path may
result in IV reuse with AES-GCM.

Reject use of states that are not in XFRM_STATE_VALID.
This applies to both output and input data paths.

The check is performed in xfrm_state_check_expire(), which is called
from xfrm_output_one().

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 04c893e42bc1..ca628262087f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2278,6 +2278,9 @@ EXPORT_SYMBOL(xfrm_state_update);
 
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
+	if (x->km.state != XFRM_STATE_VALID)
+		return -EINVAL;
+
 	/* All counters which are needed to decide if state is expired
 	 * are handled by SW for non-packet offload modes. Simply skip
 	 * the following update and save extra boilerplate in drivers.
-- 
2.39.5


