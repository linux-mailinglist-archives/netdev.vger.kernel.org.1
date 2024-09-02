Return-Path: <netdev+bounces-124311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2C968EE7
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 22:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5311F23459
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5678317F4EC;
	Mon,  2 Sep 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jthBJVzZ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD501A4E7F
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725309587; cv=none; b=U3cYG+bTpOTOezVIQAZWovhmMazscuTKV0HDd4Ru8HSDMdEwzpexT7m1QKkKA5lKLm9zus6CHB/EgEe8plUtxglz6raIqNy1ee2eOU6U23tjQ8hXdXze08VBRyMA4efxjObmXBrIeIAM6G00zgeXGySob0NB8TxI6vJgomaA7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725309587; c=relaxed/simple;
	bh=3BOwXdlRQi5vopOISrrdCO1dKiGIGz/xztBVotfOc9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHJfYoygjYPsDpttnupl92MS10IoVzCUtxjzxLSw3VRKFAp/fu+plDsf4Z+R2E84QCxpqs99IeWNqty+okysKuDTNkD1I9UHNtsq5pKhQaFR2EllbCBq1zpE34j6x/rh1xL37sNrKieuZhQyPRA92yitKD4kBfBRBZ/yDUXP2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jthBJVzZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B1B0E20743;
	Mon,  2 Sep 2024 22:39:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 432PnkA1C96H; Mon,  2 Sep 2024 22:39:41 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1BD05201D3;
	Mon,  2 Sep 2024 22:39:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1BD05201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725309581;
	bh=0O3MrP90aC+ZQ8EOcBHiEX1v8S71H1YUzMUW9AkYuds=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=jthBJVzZPqZdIIDCFq+kx/gL2GG2UN/RxTTIOjEBYO70VUVbxwKpkRNvaVi7kBYT/
	 6fT2t6xs/ozN2vclHuBKvO6iCkCP8dDjWsjizWByNrsZLRiCuIriAW02vQfMHMdtPu
	 iyPHoHN1oFwlcOiQOhfi3JUQ6LBPXfaXD0iJ+ETenRFBKL1rXJ+KSFGlqz1U9VDGDy
	 NrRbcowAldal0lME32+hBpl+YDS1NFqj3woEZDvOApKl9dv0zaBPSUijrD76eRUrZ+
	 XJVnlSFnMG/41A45DocsPg1wD/dnynw8lO79IYusHg/Z+Iymoa8e0EVh8j5PYiluB9
	 0dQPWopjWSKsQ==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 22:39:40 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 22:39:40 +0200
Date: Mon, 2 Sep 2024 22:39:38 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<dsahern@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<devel@linux-ipsec.org>, Antony Antony <antony@phenome.org>
Subject: Re: [devel-ipsec] [PATCH ipsec, v2 0/2] xfrm: respect ip proto rules
 criteria in xfrm dst lookups
Message-ID: <ZtYiig0I3zKimOVB@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20240902110719.502566-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WH5VD/aLhLS9WLOV"
Content-Disposition: inline
In-Reply-To: <20240902110719.502566-1-eyal.birger@gmail.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

--WH5VD/aLhLS9WLOV
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Sep 02, 2024 at 04:07:17AM -0700, Eyal Birger via Devel wrote:
> This series fixes the route lookup when done for xfrm to regard
> L4 criteria specified in ip rules.

Thanks Eyal for explaining the purpose of this series on the call.
How about something like this for the beginning of the commit message:

'This series fixes the route lookup for the outer packet after
encapsulation, including the L4 criteria specified in IP rules.'

It's just a cosmetic suggestion, so may be improve it if you're planning to
send a new version of the patch series for other reasons.

We ran into this issue before and used workaround, mark instead of L4 in the 
"ip rule" for the outer packet.

> The first patch is a minor refactor to allow passing more parameters
> to dst lookup functions.
> The second patch actually passes L4 information to these lookup functions.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

Tested-by: Antony Antony <antony.antony@secunet.com>

And I have a further suggestion to improve this fix make it more generic.  

I was doing the following rule as a work around for ESP-in-UDP tunnels.
ip rule add from all to 192.1.2.23 fwmark 0x1 lookup 50

With your fix I can change it to a L4 rule when using ESP-in-UDP
ip rule add from 192.1.2.45 to 192.1.2.23 ipproto udp dport 4500 lookup 50

However, when not using ESP, without UDP, and rule with "ipproto esp" does 
work.

ip rule add from 192.1.2.45 to 192.1.2.23 ipproto esp lookup 50

So, I have come up with a fix/hack on top of your fix.


@@ -327,6 +327,8 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,

+       } else {
+               params.ipproto = IPPROTO_ESP;

With this fix "ipproto esp" rules also works.
see the attached full patch.

regards,
-antony

--WH5VD/aLhLS9WLOV
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-xfrm-use-IPPROTO_ESP-for-route-lookup-without-encaps.patch"

From 54cfdfaab12270784623c60d91baf499765e50f5 Mon Sep 17 00:00:00 2001
From: Antony Antony <antony.antony@secunet.com>
Date: Mon, 2 Sep 2024 22:08:15 +0200
Subject: [PATCH ipsec] xfrm: use IPPROTO_ESP for route lookup without encapsulation

When there is no UDP or TCP encapsulation, use IPPROTO_ESP for route
lookup. This ensures that "ip rule" entries like the following match
correctly:
 ip rule add from 192.1.2.45 to 192.1.2.23 ipproto esp lookup 50

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 64bfd1390df0..9b0b1b448dce 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -327,6 +327,8 @@ static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
 			params.uli.ports.dport = x->encap->encap_dport;
 			break;
 		}
+	} else {
+		params.ipproto = IPPROTO_ESP;
 	}

 	dst = __xfrm_dst_lookup(family, &params);
--
2.43.0


--WH5VD/aLhLS9WLOV--

