Return-Path: <netdev+bounces-261274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKRYG00goGmzfgQAu9opvQ
	(envelope-from <netdev+bounces-261274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:28:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52751A43C4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99706300AEFD
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F213A0E91;
	Thu, 26 Feb 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="FNpM6Q1M"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A93128D4;
	Thu, 26 Feb 2026 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101706; cv=none; b=tsBqLnItZaxKRDdyFZ30Byfko3ek1Iqwg16osIJ24hZDtvRS9A9diF+W45hgduG3FuDtWrwgQ+zuM1tzAV/GXlc0JZRpGkMgYX2EGYv5I6HNPli7O+FgaoUleePeLiH0N75/kdSUoINQ+VuXRjx8AcJV9KjmucwEQizT5DmtH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101706; c=relaxed/simple;
	bh=YIy6M2/AOzp65V88aV0dZ7NcQwMFl2BcAWFhX101+UU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUUjvrAOq0k2fPg59IVHH/g1gjGMgns/MtARrjR3MtUUNGPph+MtPcGnc+Q+g0M8wbg4F0OE3pRR6C3gAjWBuUp7rtuPmTlQv6HySlibRIefEraLQly3XKwUWgT0S8HkqS5aipEOATHHbyldBvTksiFHQHV6l2H9+OPBRQ9pybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=FNpM6Q1M; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C8D33207B3;
	Thu, 26 Feb 2026 11:28:21 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cbss6D_bsPoj; Thu, 26 Feb 2026 11:28:21 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 33E37201D5;
	Thu, 26 Feb 2026 11:28:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 33E37201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1772101701;
	bh=w47EH4sfTJk+vUYce7sc7AiolyK33rRCJj1B95arpUY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=FNpM6Q1M8e3bbnb2wpKnA8S73fx95pQuTkSqOKmZadm0prGnQpaaTsgcqKOpod1MC
	 3zObpj4IRo8J/q8jWPZY9GmH4mRfbQiv+IMQoTzu7ZJiAiRWf+Im/YEEY5cvn+uOBu
	 cpai7U6gV1P4IIQrPSwDWfBtpW92nR8h1RyxEVTZbt1lhhoncjiNC8vt0iNR35v3ds
	 9xGZ8wzjWe5hlrLk+ldv1liTqUVCqTrO9PRMOMUyrwGUWjEXIgSkKEM2qC9cDJLVbj
	 KU42gPuMdXmdomfSG5JpMo39B1crRa/m/NPKFtuiGGaOUXnYI1zfPAItAWJkVg3BoU
	 Hry3ov82XbJfw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 11:28:20 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Jakub Kicinski
	<kuba@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, David Ahern
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan
	<shuah@kernel.org>, <devel@linux-ipsec.org>, Tobias Brunner
	<tobias@strongswan.org>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, <stable+noautosel@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 1/2] icmp: fix ICMP error source address when xfrm policy matches
Date: Thu, 26 Feb 2026 11:27:51 +0100
Message-ID: <19a0156ff6e76baa323a81d710510d399a6ff63a.1772101380.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1772101380.git.antony.antony@secunet.com>
References: <cover.1772101380.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-261274-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strongswan.org:email,secunet.com:mid,secunet.com:dkim,secunet.com:email];
	TAGGED_RCPT(0.00)[netdev,noautosel];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D52751A43C4
X-Rspamd-Action: no action

When an IPsec gateway generates an ICMP error (e.g., Destination Host
Unreachable), the source address incorrectly shows the unreachable
destination instead of the gateway's address. IPv6 behaves correctly.

Before fix:
  ping 10.1.6.3
  From 10.1.6.3 icmp_seq=1 Destination Host Unreachable
  (wrong - 10.1.6.3 is the unreachable host)

After fix:
  ping 10.1.6.3
  From 10.1.5.2 icmp_seq=1 Destination Host Unreachable
  (correct - 10.1.5.2 is the gateway)

The fix removes the memcpy that overwrote fl4 with fl4_dec after
xfrm_lookup(). A follow-up commit adds a selftest.

Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
Cc: stable+noautosel@kernel.org # Avoid false positives in tests
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Acked-by: Tobias Brunner <tobias@strongswan.org>
---
 net/ipv4/icmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 19c9c838967f..4bd421208ce0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -569,7 +569,6 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 	rt2 = dst_rtable(dst2);
 	if (!IS_ERR(dst2)) {
 		dst_release(&rt->dst);
-		memcpy(fl4, &fl4_dec, sizeof(*fl4));
 		rt = rt2;
 	} else if (PTR_ERR(dst2) == -EPERM) {
 		if (rt)
--
2.39.5


