Return-Path: <netdev+bounces-274567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F6GBB54zmmMnwYAu9opvQ
	(envelope-from <netdev+bounces-274567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555E38A3B9
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B02D630158BB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2BD3E51DA;
	Thu,  2 Apr 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MBsz0uFW"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331A346E56;
	Thu,  2 Apr 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138779; cv=none; b=k74DeQR2TU+Skk0fCQrZhJArfF8pIzGTPE+4vH1A3n8gs/V7nhaHg8+4SZjxAfSl9EIWTsJ8eTYGRS51SX+1hbaakuHaadjXMA/TaQueNbaBJ9o0afr5iUFkZPTNIjQA3YHB7BTkzRd4kSqttnyWp2CShc3ugnTy0o4d6coP3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138779; c=relaxed/simple;
	bh=J1bSDgeo625cSZQDyfNBpr4fnFjA8Mh5pd5UCKVHOkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKJ2aZ8dGdJyoSEz/TbeDQyqfuOs53poQgYtistJvDIAaKgSI/ueQ1YDw0URWf0xZQ+7xtrTto8eJ2YueJSC3omYk3IP4ncSQpuDyrduKecB6Vh5zgI9RZo95mM7E0I+fmCTLwalMjO2WW6mNaQVAF+2Q7KtivqQsYwn7KDAZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=MBsz0uFW; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=7LfYWY9tYYNOeCX79pdeR7TxT4FPSgI5xDFpnJJkcOM=; b=MBsz0uFW/CKW
	4M10XoNLULjoIELabLu3QP5yzhsJw4HY/HIYibUjVDMZw2mxR8E/gwKMMYsJhcP9ep/ErrO1Lbv64
	nE/3bMnHx0CGwesMKncKp613OGnkgA0QoquAuqeKXeDZ9SRWrOTrZnCTg0wxSMKwbUvpbo5Lkqrq6
	6CiymtaT+Al2G81pn48lne3Cp8/5WNHjywf+zdnbbMK3hBM7RP1E+unvIj5d6BiOa72OLkOKHX6PA
	9NR59AIAFHmTSoFUZfuD6HemsX2WAB0EXzHZIVjX9w6s5N3QaSQWGOW+NjQzhQ79xpbnMZ27gNwMJ
	RD4W2WxPpPFB+qDiHmLAWQ==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w8Ie8-003MIM-1Y;
	Thu, 02 Apr 2026 16:05:56 +0200
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
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Subject: [PATCH 2/2] net: add __no_profile to skb_extensions_init() for GCOV compatibility
Date: Thu,  2 Apr 2026 17:05:58 +0300
Message-ID: <20260402140558.1437002-3-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260402140558.1437002-1-khorenko@virtuozzo.com>
References: <20260402140558.1437002-1-khorenko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274567-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid]
X-Rspamd-Queue-Id: 4555E38A3B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With -fprofile-update=atomic in global CFLAGS_GCOV, GCC still cannot
constant-fold the skb_ext_total_length() loop when it is inlined into a
profiled caller.  The existing __no_profile on skb_ext_total_length()
itself is insufficient because after __always_inline expansion the code
resides in the caller's body, which still carries GCOV instrumentation.

Mark skb_extensions_init() with __no_profile so the BUILD_BUG_ON checks
can be evaluated at compile time.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 47c7f0ab6e84..99704d6832e2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5156,7 +5156,7 @@ static __always_inline __no_profile unsigned int skb_ext_total_length(void)
 	return l;
 }
 
-static void skb_extensions_init(void)
+static void __no_profile skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM > 8);
 	BUILD_BUG_ON(skb_ext_total_length() > 255);
-- 
2.43.5


