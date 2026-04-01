Return-Path: <netdev+bounces-274130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMu8IUItzWn7aQYAu9opvQ
	(envelope-from <netdev+bounces-274130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:35:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB537C390
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D13103021EB1
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8746AEDF;
	Wed,  1 Apr 2026 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NCoD32ZY"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A952DB794;
	Wed,  1 Apr 2026 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053233; cv=none; b=g3hQLj/DbAy5k8TfQo6AolbFkjlF25IfzycBguzKclmcdtcyk0dRP9e+IJbhZdGq3jgCGLq28KCCRncWwNzsry/u0CGBarS8R2Y2hJTBQQR5N9ftKXRNfgLPMo/OZHyPqWaSirPtW8tov7VjFbP+GR9PXsSGowPVEtkLV0Z/wGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053233; c=relaxed/simple;
	bh=J1bSDgeo625cSZQDyfNBpr4fnFjA8Mh5pd5UCKVHOkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLsgzQHKH9+u/gbWzjKqKG+czdwaD5h1/N+tfYdoRYyIPq4L42/qHN01k9mNKTfe39lHCeuYMeUHP7rbDBfXLH8aQUG4z6vv61W9RWsmodGKeF4pawL2L16ahAp34IIDeGMlp0FAtlo1fNcY1vz9+PAESLqzMgVhZihF1vo6w9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=NCoD32ZY; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=7LfYWY9tYYNOeCX79pdeR7TxT4FPSgI5xDFpnJJkcOM=; b=NCoD32ZYbWpt
	2IfSNwxfuN8Qf+Fy6LkGdySMznhBfRWyna3ZacIDbCrmrkPgj9PELQjYz3Zn3jPr50FysOFqkHh4a
	efppd4XFWVaeV309fm9U8Wbj0IUI6MyAO07HPBa7Lzc1S6J/IFxQISJOiDuI/xo5py9io8CrH9EEz
	uG3xrtrC3X42a/Y7/Z2tdai9A6SV4fQmiugEn8WrVN7UY5ueQJaVcvPHnJW6YyYjCYLVMW64zhwWr
	5/dHoSrfPWa5uBBRCobiX8Eb7NzZQVPkmSvVyrVwvtRMwjRIMFlvL3iEOHsiBnIq6gCtBhh+0zl3l
	d60EG5HJxIbRkqpAh3R+4A==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1w7wOW-00HGGD-0s;
	Wed, 01 Apr 2026 16:20:20 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 2/4] net: add __no_profile to skb_extensions_init() for GCOV compatibility
Date: Wed,  1 Apr 2026 17:20:18 +0300
Message-ID: <20260401142020.1434243-3-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260401142020.1434243-1-khorenko@virtuozzo.com>
References: <20260401142020.1434243-1-khorenko@virtuozzo.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274130-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khorenko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDEB537C390
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


