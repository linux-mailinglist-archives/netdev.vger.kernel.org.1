Return-Path: <netdev+bounces-300980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dzX9Bm/rOGpOkAcAu9opvQ
	(envelope-from <netdev+bounces-300980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:59:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 817026AD76E
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:59:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=BLoFBjpI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300980-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300980-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F888303D124
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63593839A3;
	Mon, 22 Jun 2026 07:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B3382F2F
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:57:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115067; cv=none; b=LycuYbIG33ymGdCQVJ1592wPv54EtQ7k5Sndv/NBcScwQJluslHJ7K8bD1BSLQoiAdzs2s0uKYF8Q+6hCoRT4S9TBTq7gVCz4tqqW6gqd4WEkGzPWjLfebICoR0fd4eAf2u5QTLjwTHXfJQLyZszqXU9Ab0Va2fpAIFA0dxgxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115067; c=relaxed/simple;
	bh=KSCcJgShwi6/v7XbGa5PGEylLIDFlEAY7BtxonYQ0QQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcG9tgO0App+Z8JXxUc90sBrc7WCgGA6MxZr6tGD4A0k2h0GUZW1th2YTqjUYa8SkgzpPI5JTWPJt0TFazXhkKXwaRtohbAIzUxXa5D3XfP40kXWoiCg/S6RFvJYL0O/u+BXndbWA+ux9MofEP+Ye11xT+2ADFkHKAYKN5Aa3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BLoFBjpI; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B963620748;
	Mon, 22 Jun 2026 09:57:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vAXLMcOKSwv4; Mon, 22 Jun 2026 09:57:41 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 03E4E20754;
	Mon, 22 Jun 2026 09:57:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 03E4E20754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782115061;
	bh=lSVZss6/UyS3lQDOUqphqgSohm+dc1AW1qzLlZzpYlA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BLoFBjpICmdJ9vfZpuSBy3mJ2CY75fG853L5hHe0elHqnKLxMBiINlSRcWwUJG7iO
	 IeBqCT2unU+5ih1YoZpkoEpg6s81PAlTsICs/Tyy8JnQ4VL7fF9B6xU1uqT4Co6EGp
	 3DUGhzHOd6YYg9Nf8dKbeDHvLGbXnNXT0/u8m93S0cI5jglfqvWpzessw+1SMAopVX
	 0LvE7d77jCd6y0nf9BX0PpEiQ3dDO95koyV45JEuEJZnDvlkXrJHslRBdY5pq7bKyD
	 UDRROPuPQNNONZ+BUtxrB7L/mkl40lq8+J5obu4GnaZzkHtJ0faWl91KZxZJZU0GAi
	 BuiBgU0nCpGNg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 09:57:40 +0200
Received: (nullmailer pid 30055 invoked by uid 1000);
	Mon, 22 Jun 2026 07:57:32 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/7] xfrm: use compat translator only for u64 alignment mismatch
Date: Mon, 22 Jun 2026 09:57:03 +0200
Message-ID: <20260622075726.29685-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622075726.29685-1-steffen.klassert@secunet.com>
References: <20260622075726.29685-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300980-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 817026AD76E

From: Sanman Pradhan <psanman@juniper.net>

The XFRM compat layer (CONFIG_XFRM_USER_COMPAT) translates 32-bit xfrm
netlink and setsockopt messages into the native 64-bit layout. It is
only needed on architectures where the 32-bit and 64-bit ABIs disagree
on u64 alignment, which the kernel encodes as COMPAT_FOR_U64_ALIGNMENT.

That symbol is defined only by arch/x86. XFRM_USER_COMPAT depends on it,
so the translator can never be built on any other architecture,
including arm64, which still provides a 32-bit compat ABI (CONFIG_COMPAT)
for AArch32 EL0 userspace. On arm64 the AArch32 EABI already aligns u64
to 8 bytes, identical to the AArch64 ABI, so no translation is required
and the native code path is correct for 32-bit tasks.

However, xfrm_user_rcv_msg() and xfrm_user_policy() gate on
in_compat_syscall() alone and then call xfrm_get_translator(), which
returns NULL when no translator is registered. On arm64 that is always
the case, so every xfrm netlink message and the XFRM_POLICY setsockopt
issued by a 32-bit task returns -EOPNOTSUPP. A 32-bit userspace process
on arm64 (and on any other arch with CONFIG_COMPAT but without
COMPAT_FOR_U64_ALIGNMENT) therefore cannot configure XFRM state or
policy through the XFRM_USER netlink API, and cannot use the XFRM_POLICY
setsockopt path, because both fail before reaching the native parser.

The translator series replaced the blanket compat rejection with a
translator lookup. That made the path usable on x86 when the translator
is available, but left architectures that cannot build the translator
permanently rejected even when their compat layout already matches the
native layout. Let those architectures use the native parser instead.

Gate the translator requirement on COMPAT_FOR_U64_ALIGNMENT instead of
on in_compat_syscall() alone. Gating on the ABI property rather than on
CONFIG_XFRM_USER_COMPAT is deliberate: on x86 with IA32_EMULATION=y but
XFRM_USER_COMPAT=n, a 32-bit task must still be rejected rather than
routed through the native parser, which would misread genuinely
4-byte-aligned x86-32 messages. COMPAT_FOR_U64_ALIGNMENT is the ABI
property that makes the XFRM translator mandatory.

Only the receive/input direction needs the guard. The send, dump and
notification paths already call the translator as "if (xtr) { ... }"
with no error on NULL, so on arches without a translator they no-op and
the kernel emits native 64-bit-layout messages, which is what an AArch32
task expects.

Tested on Juniper SRX hardware: with the fix, 32-bit IPsec userspace
netlink and XFRM_POLICY setsockopt operations that previously failed
with -EOPNOTSUPP now succeed; x86 behaviour is unchanged by inspection.

Fixes: 5106f4a8acff ("xfrm/compat: Add 32=>64-bit messages translator")
Fixes: 96392ee5a13b ("xfrm/compat: Translate 32-bit user_policy from sockptr")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 2 +-
 net/xfrm/xfrm_user.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 589c3b6e4679..d8457ceaf28c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2976,7 +2976,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	if (in_compat_syscall()) {
+	if (IS_ENABLED(CONFIG_COMPAT_FOR_U64_ALIGNMENT) && in_compat_syscall()) {
 		struct xfrm_translator *xtr = xfrm_get_translator();
 
 		if (!xtr) {
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 71a4b7278eba..3b1cf29bc402 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3472,7 +3472,7 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!netlink_net_capable(skb, CAP_NET_ADMIN))
 		return -EPERM;
 
-	if (in_compat_syscall()) {
+	if (IS_ENABLED(CONFIG_COMPAT_FOR_U64_ALIGNMENT) && in_compat_syscall()) {
 		struct xfrm_translator *xtr = xfrm_get_translator();
 
 		if (!xtr)
-- 
2.43.0


