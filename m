Return-Path: <netdev+bounces-276403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFajOjYj1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:43:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B523BA09D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B65CD301AF5E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18FE3B0ADD;
	Wed,  8 Apr 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BBm2cwq5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC513AEF5D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641392; cv=none; b=nVf13f+ODusMm5Ik+Wk+vOV/i8AdTcT5U+z/NYVt/lm89bLEFVp7G9MGcSDWee8+9TzGsW/oDwU6RX2RCvVXh3JOcMYuHTQjPNgiTfEbpvigqX40nOWvl4yhRGiIo9WlRYTaVOhHjBt2O+cAYdadakivG9ZcMzV75EoKDS0AVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641392; c=relaxed/simple;
	bh=Zl3KgDqLZubXIuE3pPY4Bw42hHBkOTDD1Ar6IXlXOIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=up4fpn4a+7JznpkZlM/fdp5/cccQkoOFpW2sq64k8JeoTCziIUrgnTNKtKjDsHDkr9n+Po8a0G8fBILFMNn6UFpcdg45hIx7tKIlFE0QvKgxYaY2bIZRdtgO8sevq6KBZI9XMIc5Fp5SM46ZH3pfJwg7bPW+XO9Bw6dmZpoyneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BBm2cwq5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 73B87207F4;
	Wed,  8 Apr 2026 11:43:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1g7HLMtsvhQ2; Wed,  8 Apr 2026 11:43:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7A1172065A;
	Wed,  8 Apr 2026 11:43:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7A1172065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775641386;
	bh=MYNGsVgOGJKqUhNzFmpNsWUR5BIL9tKi5YLBoCOxVxY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BBm2cwq5bLK7QoXEk/GVxviiSxjeU8k6zxUrrjNy8F7np3diBQeV7Z5ELTiFkWb+h
	 bzwSO/2N1Dzohj0i6Jqvhw12L4cZPwf/ISgIJGTRU7TJKrlVYgaicMl3vFGqTAzeJl
	 JPe2EIIXxCBtdrzfjnnpB0mFIwnrH+cqrxKXp4Se8MrZwFsC7/qmrA7bixGag8D5y7
	 6umGrDjl6u+4HyX1O1brkAr4uOuMo+L4qa1zldOkW9kBOlrkm2xPUPo8bB5p/dTLJg
	 M73KlLh+Xw4glTfvG9U5oPc8A1nbiXqqr/Fx2VYeQFm+XMg0GGlpz5kERcb6CdikH+
	 UNgM+HSRPeAkg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:43:05 +0200
Received: (nullmailer pid 150869 invoked by uid 1000);
	Wed, 08 Apr 2026 09:43:03 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/2] xfrm: Drop support for HMAC-RIPEMD-160
Date: Wed, 8 Apr 2026 11:42:41 +0200
Message-ID: <20260408094258.148555-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408094258.148555-1-steffen.klassert@secunet.com>
References: <20260408094258.148555-1-steffen.klassert@secunet.com>
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
	TAGGED_FROM(0.00)[bounces-276403-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 71B523BA09D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Biggers <ebiggers@kernel.org>

Drop support for HMAC-RIPEMD-160 from IPsec to reduce the UAPI surface
and simplify future maintenance.  It's almost certainly unused.

RIPEMD-160 received some attention in the early 2000s when SHA-* weren't
quite as well established.  But it never received much adoption outside
of certain niches such as Bitcoin.

It's actually unclear that Linux + IPsec + HMAC-RIPEMD-160 has *ever*
been used, even historically.  When support for it was added in 2003, it
was done so in a "cleanup" commit without any justification [1].  It
didn't actually work until someone happened to fix it 5 years later [2].
That person didn't use or test it either [3].  Finally, also note that
"hmac(rmd160)" is by far the slowest of the algorithms in aalg_list[].

Of course, today IPsec is usually used with an AEAD, such as AES-GCM.
But even for IPsec users still using a dedicated auth algorithm, they
almost certainly aren't using, and shouldn't use, HMAC-RIPEMD-160.

Thus, let's just drop support for it.  Note: no kconfig update is
needed, since CRYPTO_RMD160 wasn't actually being selected anyway.

References:
  [1] linux-history commit d462985fc1941a47
      ("[IPSEC]: Clean up key manager algorithm handling.")
  [2] linux commit a13366c632132bb9
      ("xfrm: xfrm_algo: correct usage of RIPEMD-160")
  [3] https://lore.kernel.org/all/1212340578-15574-1-git-send-email-rueegsegger@swiss-it.ch

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_algo.c                | 20 --------------------
 tools/testing/selftests/net/ipsec.c |  8 ++------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
index 749011e031c0..70434495f23f 100644
--- a/net/xfrm/xfrm_algo.c
+++ b/net/xfrm/xfrm_algo.c
@@ -290,26 +290,6 @@ static struct xfrm_algo_desc aalg_list[] = {
 		.sadb_alg_maxbits = 512
 	}
 },
-{
-	.name = "hmac(rmd160)",
-	.compat = "rmd160",
-
-	.uinfo = {
-		.auth = {
-			.icv_truncbits = 96,
-			.icv_fullbits = 160,
-		}
-	},
-
-	.pfkey_supported = 1,
-
-	.desc = {
-		.sadb_alg_id = SADB_X_AALG_RIPEMD160HMAC,
-		.sadb_alg_ivlen = 0,
-		.sadb_alg_minbits = 160,
-		.sadb_alg_maxbits = 160
-	}
-},
 {
 	.name = "xcbc(aes)",
 
diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index f4afef51b930..89c32c354c00 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -62,8 +62,6 @@
 #define VETH_FMT	"ktst-%d"
 #define VETH_LEN	12
 
-#define XFRM_ALGO_NR_KEYS 29
-
 static int nsfd_parent	= -1;
 static int nsfd_childa	= -1;
 static int nsfd_childb	= -1;
@@ -96,7 +94,6 @@ struct xfrm_key_entry xfrm_key_entries[] = {
 	{"cbc(cast5)", 128},
 	{"cbc(serpent)", 128},
 	{"hmac(sha1)", 160},
-	{"hmac(rmd160)", 160},
 	{"cbc(des3_ede)", 192},
 	{"hmac(sha256)", 256},
 	{"cbc(aes)", 256},
@@ -813,7 +810,7 @@ static int xfrm_fill_key(char *name, char *buf,
 {
 	int i;
 
-	for (i = 0; i < XFRM_ALGO_NR_KEYS; i++) {
+	for (i = 0; i < ARRAY_SIZE(xfrm_key_entries); i++) {
 		if (strncmp(name, xfrm_key_entries[i].algo_name, ALGO_LEN) == 0)
 			*key_len = xfrm_key_entries[i].key_len;
 	}
@@ -2061,8 +2058,7 @@ static int write_desc(int proto, int test_desc_fd,
 int proto_list[] = { IPPROTO_AH, IPPROTO_COMP, IPPROTO_ESP };
 char *ah_list[] = {
 	"digest_null", "hmac(md5)", "hmac(sha1)", "hmac(sha256)",
-	"hmac(sha384)", "hmac(sha512)", "hmac(rmd160)",
-	"xcbc(aes)", "cmac(aes)"
+	"hmac(sha384)", "hmac(sha512)", "xcbc(aes)", "cmac(aes)"
 };
 char *comp_list[] = {
 	"deflate",
-- 
2.43.0


