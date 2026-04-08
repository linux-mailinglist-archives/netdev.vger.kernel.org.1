Return-Path: <netdev+bounces-276416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFUTN5An1mnqBQgAu9opvQ
	(envelope-from <netdev+bounces-276416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:01:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E583BA35D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C9063036761
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F92BE04C;
	Wed,  8 Apr 2026 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="eWBqbu4p"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36693ACF17
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642387; cv=none; b=IXLYAAJq0unaKwKm/AJ4jhw99zwxw1FJTy2uB9phZe5gbpCMYVzEq0GtlDhn7ckwmYgh4Op0oHtlanB8SUmKsgA8Al1awhfcw5uP212/fWKtDG4PsnvWo4+MP1EsHy2Q1mFlxc6jWdtSs8tyhO4nSB1L8b1yRJSTE92x/3QNBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642387; c=relaxed/simple;
	bh=fijbk9r2y+9s/pgjwj9jL/NqCmTtmVeAXUSUjqIUsXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rURgdxAL9yC4mQmkST6jsOtyxVk59X4aaPaIL67QN0ZZbdm4pO2MH7BBSwqf77trmHWrfDNhwhNLlE4y4lQoj2Bt5oCQrd96f+fQo5nNosOVC9Jaz8l5i1c7r1DRLuR3w3FE+ER1rEYrRVyOQLu0P2rBQDnmqfC19UTDdpiPyW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eWBqbu4p; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A026A207D1;
	Wed,  8 Apr 2026 11:59:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L7mPl7jpELvM; Wed,  8 Apr 2026 11:59:35 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1BEDE207C1;
	Wed,  8 Apr 2026 11:59:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1BEDE207C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775642375;
	bh=f9Fj+WubamJQDHKnkQFWg0AzRmyApfWKDDRRjzULtqk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=eWBqbu4p7JoW7AJnaVY+fylrauJnfczmNG69IFFBNxDof/sZoddwzEVC+nO1VwmWf
	 J8MzFPwhhGtujJb6UbWTs5wvOj1DdMszWEBeI9SXL6kE0veQjifrTkKaPKv8Dmk2AQ
	 LHWNB6V++m7EjIaqT7ElEhbWfVPM1OsWzVVTcAc9mJGYt4LbZWpb5m8SUh4i/5P26R
	 smNDPIcjBAO955GNmhdn0Dc4Pka0iS2uUIx2bY4cMRe5hZ4zX1nJRztjshbewJJuld
	 4mQ3IxSDPAvNj2N55q4+QIFGrJHXkEDYSF/Oi0/zAGcU+zODrT0IhNIqKVl27sX/Dd
	 WEBcOUgMf4GvQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:59:34 +0200
Received: (nullmailer pid 256673 invoked by uid 1000);
	Wed, 08 Apr 2026 09:59:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/8] xfrm: clear trailing padding in build_polexpire()
Date: Wed, 8 Apr 2026 11:58:57 +0200
Message-ID: <20260408095925.253681-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408095925.253681-1-steffen.klassert@secunet.com>
References: <20260408095925.253681-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-276416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C7E583BA35D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The padding bytes after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 1656b487f833..5d59c11fc01e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3960,6 +3960,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset_after(upe, 0, hard);
 
 	nlmsg_end(skb, nlh);
 	return 0;
-- 
2.43.0


