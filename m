Return-Path: <netdev+bounces-277132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFfJCcEe2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:48:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0803CFFFB
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F73303B4CC
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FB337C11E;
	Thu,  9 Apr 2026 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eVop7GSp"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBC37C92C;
	Thu,  9 Apr 2026 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771279; cv=none; b=Tl0R3sURPxYCIxk6WuamkeORDbNLU7FZIVXrDiynOWacTFp9pKhJ3gb0HGXYs6h7pUjho/j1oafmw03Pfiq3UtRD3sq0Ni31JrSaWAjgwml90QRewdYKXQWlWnV8Do0o/YR9MZRvAHuFAnE8gGJtfiPEYuEgjOvw7WtwT4Te9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771279; c=relaxed/simple;
	bh=8tsXI5GWVUlhJaYC/LK3zhp+R7hyhPbm41VUEHqo5p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZc9Dti5+66GL4r1kzn86pSyIJWSoQW4aYVIxjkfXtyZa1zBikTurMSpRIRe0nfWdBbZ8cJIwC0ICumAPWw+grSMnMODtZP52iHaQ1PbDZ0tMg2vwGUbLWjMmmYfByF6Kr518unrkLX8BZdUoXI2hHi7Qngmz8+CygK12rpzJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=eVop7GSp; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=7SNfDvJtC0DyGm9hfzn/dNerAkSGQ1wxTuVdvFD0rFY=; b=eVop7GSpqu9d
	9rAxQOjmSsWn4sGLDD7vPiyfTVvl9XQ/7W/9tTd6ijQYdssY5zi33q1nCKNIAMAGntrzwVc4EkUdh
	k33Cc8DKiHIAEwggUEPc9ibPDk+IDpZ3fynBOzELunz5bZuWfaifWuZy9ADmz5r+bdyWKbrdl4NfC
	aXaANFWWaQlb0xDt/KxwZD7/buhTlxTghbJyZzgE6cm0yi2h+ua4WtjcwszwFilAx3IM9p/LL/DWS
	OGA6SFRWSYjAHGyHgPevDsr9kykzIVTTVb/J6AFTlNuw0u63sIdwMtCQOXgW7KF35g/i11Fd5sgdc
	061Sh1LBb+NRDv86jUG68g==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1wAxBX-002p6C-2H;
	Thu, 09 Apr 2026 23:47:34 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
	Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 2/2] net: add noinline __no_profile to skb_extensions_init() for GCOV compatibility
Date: Fri, 10 Apr 2026 00:47:36 +0300
Message-ID: <20260409214736.2651198-3-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260409214736.2651198-1-khorenko@virtuozzo.com>
References: <20260402140558.1437002-1-khorenko@virtuozzo.com>
 <20260409214736.2651198-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277132-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA0803CFFFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With -fprofile-update=atomic in global CFLAGS_GCOV, GCC still cannot
constant-fold the skb_ext_total_length() loop when it is inlined into a
profiled caller.  The existing __no_profile on skb_ext_total_length()
itself is insufficient because after __always_inline expansion the code
resides in the caller's body, which still carries GCOV instrumentation.

Mark skb_extensions_init() with __no_profile so the BUILD_BUG_ON checks
can be evaluated at compile time.  Also mark it noinline to prevent the
compiler from inlining it into skb_init() (which lacks __no_profile),
which would re-expose the function body to GCOV instrumentation.

Build-tested with both CONFIG_GCOV_PROFILE_ALL=y and
CONFIG_KCOV_INSTRUMENT_ALL=y.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 59fb4b2bb821..8d75e352e3b1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5153,7 +5153,7 @@ static __always_inline __no_profile unsigned int skb_ext_total_length(void)
 	return l;
 }
 
-static void skb_extensions_init(void)
+static noinline void __no_profile skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM > 8);
 	BUILD_BUG_ON(skb_ext_total_length() > 255);
-- 
2.43.5


