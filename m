Return-Path: <netdev+bounces-302909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LgDaEGUyQ2rWUQoAu9opvQ
	(envelope-from <netdev+bounces-302909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:05:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9FC6DFF44
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:05:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gNq1B5ud;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302909-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302909-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=hotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E6BB300861C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6303D1A82;
	Tue, 30 Jun 2026 03:05:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCF1A6838
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:04:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782788701; cv=none; b=RSum61LMb1HhgB9dycZrN6Qub+w83clcm321vvEShSORkPS1f3/y5Fca361vNEnTX7uLOewW6My8xQZWOIAi/RtHty/bmYYTXmqaxFp1Ih0x5AJijjCbMtciS+AOqLgxMJMUZk2yGgL+D8Coe2zZ0J1FQXQzVBftkvyHJoat+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782788701; c=relaxed/simple;
	bh=+W6EzEPQ9zQYQUF7E9Ycfbo/nEtiz9mdLa+X+GPDmto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+dX2pQJqp6o4IydrG0YPZ3XDCwIW024JCtTDGPU8uriKrSeJPnLB/TPXWgAUClCzTzVL037qNxlZLcIJnsMazRdLON0l5zC26U6sTl8ILvWFhFwAw03VKyzqBTRkGhUZbg2o4bYKvzhTW/xlb7KA6nuA8TmAKexILU7at1xD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNq1B5ud; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3804e42ad5fso634985a91.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 20:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782788699; x=1783393499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kshaipKl8uIUIY3EQ7x9D9DjcOKW20jlmZOe/RNaAIs=;
        b=gNq1B5udNAdmHd4MBZz+7c8PgJKUU7EJDJRVajnS35RN7enJrZcCAuRH5TiJe97FAW
         x/Ab3DKtNQeFtimTonYKIyF52u/NxlFf54SVtt9CLmgSDYOKWVT/mVuKDVZgzTgsGVHa
         nzL4csp+Vbc+NusUl0ybybahVTziXau11WzAb1WpV2Y0fbLOqbHAB93wCAXSEgPqy0fe
         x0lCtdDS8TbqPZJZzzBMUba3b6U16hqu8r+UN47WJmW82P64Q49GF0YllCDGa4c/6dtf
         jQuACSgGYKJvjsBzIozNIlq8NoyEi6JqTzXls/Qyt9Qk+McyOOZeUzzc9zSb4N4c60mG
         LkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782788699; x=1783393499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kshaipKl8uIUIY3EQ7x9D9DjcOKW20jlmZOe/RNaAIs=;
        b=UnRLeoRuENNBHzs89lzFRHDLwWD2mVQ2vX+USP9VpH3pQTzuUgnkcV54shxRTdbXXa
         j0HPpL3pMU8Jx80T894lXZJGrAXiLref0CU+bQUtHBO2DBq4276khYjLxaxW5n+4HQFW
         ykplVbW7zEngSqPC6glsD/rITYDiejWn2C0+9IOqox5LuCdW4dSQUDiC04Xnfeh26X/i
         lyruMcAAqQfyv6ymldjAtTAXhZsuvp7zY/bD2HLJbLtUlN1XZ8d0sjWvM85PdElQkTba
         R3o1k3QwC/iMDnqGx1os+OU3rmCysqoFcSJe5chKx0oizKFDoQtd9LGuKiVZOjI9cIVc
         mwcw==
X-Forwarded-Encrypted: i=1; AHgh+RriZkDFn0C/DuxCXeFILA/9kEIbTJai5s2S6FbGVBp3zEdMezHpbMg2nSrO9gKglXIS19P+A3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7z3yTUn5/EZC0M36kTuXidTvr84fGQQ0Ewel7VTrqweB7t7h
	Ky7Y3b/qyA4/6+bKIjDKZ+sGe9ntwXOEjX6pvh5ikBHmuL8uPSoZ3Lb/
X-Gm-Gg: AfdE7ckSVhaOfXutyIwktoOlNctBGLFBp6gPISs1rdVYYQcSwkwxnMgN8zWNNN7fSbJ
	lVPsxY7BPEW8m9pdYkxGelyBfRqZoiU42EQdlXXOSo7c3tj8bdY/zz8Y7e8LOeB31uKW2s1oyRZ
	A0wiZcNEedQRHdQS5YvlKHf5bRMlBWbINOdAT5vIm/x8ni6tv0aAP3u2q+keZrx5GDj1hAHEQ32
	W6fbvXvQAxAcquRZirtXEoiEidgmbqsCyFDdU4SjbukHSximNIw9HBsGPEvHHpEOHA6qYP/7CrC
	xc3va6iOM8y/bj6ZT+GS5KLfzeSfgwzrRzMtE5OgcHezzuf4aUkhkV5Hio4l89k8pmef4Tq48UD
	6lpn1RnvBkEVz/Yx/jOhp6wB7Mk04LnAH2wesP+1GIQ3y7Dh0j/f3Y57+HDvE2yI3jH4mPyhwxS
	BGpAy6TZ3vD34LWrpeILwgP/7S0A64G86mFkostZWX9fgrL8mqeZglGVH434xv0oL+sIc9SfNoY
	AlMrg//BWPT5Y2AnLWl6Dw+BnoKKRIZbxsS
X-Received: by 2002:a17:902:da90:b0:2c0:b6c7:2271 with SMTP id d9443c01a7336-2ca2d52aa5emr16072565ad.4.1782788698516;
        Mon, 29 Jun 2026 20:04:58 -0700 (PDT)
Received: from kirchou-macbookpro2.roam.corp.google.com (softbank126051115229.bbtec.net. [126.51.115.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828c6d2sm3604605ad.39.2026.06.29.20.04.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jun 2026 20:04:58 -0700 (PDT)
Sender: kir <610548@gmail.com>
From: Kir Chou <note351@hotmail.com>
To: akpm@linux-foundation.org
Cc: thomas.weissschuh@linutronix.de,
	davidgow@google.com,
	geert@linux-m68k.org,
	visitorckw@gmail.com,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Kir Chou <note351@hotmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH v4] lib/random32: convert selftest to KUnit
Date: Tue, 30 Jun 2026 12:04:46 +0900
Message-ID: <20260630030447.77522-1-note351@hotmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[hotmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[hotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302909-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[note351@hotmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:thomas.weissschuh@linutronix.de,m:davidgow@google.com,m:geert@linux-m68k.org,m:visitorckw@gmail.com,m:brendan.higgins@linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@googlegroups.com,m:note351@hotmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,google.com,linux-m68k.org,gmail.com,linux.dev,vger.kernel.org,googlegroups.com,hotmail.com,davemloft.net,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[note351@hotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E9FC6DFF44

This patch converts the existing prandom selftest (lib/random32.c) to use
the KUnit framework (lib/tests/random32_kunit.c). Unlike typical KUnit
tests, this file is directly #included into lib/random32.c.

The new test:
- Removes the legacy CONFIG_RANDOM32_SELFTEST from lib/random32.c.
- Adds CONFIG_PRANDOM_KUNIT_TEST (defaulting to KUNIT_ALL_TESTS).
- Moves the test logic to lib/tests/random32_kunit.c.

This commit is verified by `./tools/testing/kunit/kunit.py run`
with the .kunit/.kunitconfig:

```
CONFIG_KUNIT=y
CONFIG_PRANDOM_KUNIT_TEST=y
```

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Kir Chou <note351@hotmail.com>

---
v4:
- Changes from bool to tristate in lib/Kconfig.debug.
- Spins off the test into its own module under lib/tests/.
- Adds a prototype for prandom_warmup() to avoid a warning.
- Makes prandom_warmup() visible to the test in lib/random32.c.
- Adds the build rule for random32_kunit.o to lib/tests/Makefile.

v3:
- Changes from tristate to bool in lib/Kconfig.debug.

v2:
- Removes the legacy CONFIG_RANDOM32_SELFTEST from lib/Kconfig.
- Add const to arrays in lib/tests/random32_kunit.c.
---
 lib/Kconfig                |   6 --
 lib/Kconfig.debug          |   9 ++
 lib/random32.c             | 184 ++-----------------------------------
 lib/tests/Makefile         |   1 +
 lib/tests/random32_kunit.c | 181 ++++++++++++++++++++++++++++++++++++
 5 files changed, 201 insertions(+), 180 deletions(-)
 create mode 100644 lib/tests/random32_kunit.c

diff --git a/lib/Kconfig b/lib/Kconfig
index 2923924be..5f185e9f1 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -156,12 +156,6 @@ config AUDIT_COMPAT_GENERIC
 	depends on AUDIT_GENERIC && AUDIT_ARCH_COMPAT_GENERIC && COMPAT
 	default y
 
-config RANDOM32_SELFTEST
-	bool "PRNG perform self test on init"
-	help
-	  This option enables the 32 bit PRNG library functions to perform a
-	  self test on initialization.
-
 #
 # compression support is select'ed if needed
 #
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fd..0214a5859 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3354,6 +3354,15 @@ config PRIME_NUMBERS_KUNIT_TEST
 
 	  If unsure, say N
 
+config PRANDOM_KUNIT_TEST
+	tristate "KUnit test for prandom" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the prandom functions at runtime.
+
+	  If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/random32.c b/lib/random32.c
index 24e7acd93..dad90219c 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -41,6 +41,7 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+#include <kunit/visibility.h>
 
 /**
  *	prandom_u32_state - seeded pseudo-random number generator.
@@ -92,7 +93,14 @@ void prandom_bytes_state(struct rnd_state *state, void *buf, size_t bytes)
 }
 EXPORT_SYMBOL(prandom_bytes_state);
 
-static void prandom_warmup(struct rnd_state *state)
+/*
+ * Only declared here so that it has a prototype when made
+ * non-static for KUnit testing (avoids -Wmissing-prototypes).
+ */
+#if IS_ENABLED(CONFIG_KUNIT)
+void prandom_warmup(struct rnd_state *state);
+#endif
+VISIBLE_IF_KUNIT void prandom_warmup(struct rnd_state *state)
 {
 	/* Calling RNG ten times to satisfy recurrence condition */
 	prandom_u32_state(state);
@@ -106,6 +114,7 @@ static void prandom_warmup(struct rnd_state *state)
 	prandom_u32_state(state);
 	prandom_u32_state(state);
 }
+EXPORT_SYMBOL_IF_KUNIT(prandom_warmup);
 
 void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
 {
@@ -125,176 +134,3 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
 	}
 }
 EXPORT_SYMBOL(prandom_seed_full_state);
-
-#ifdef CONFIG_RANDOM32_SELFTEST
-static struct prandom_test1 {
-	u32 seed;
-	u32 result;
-} test1[] = {
-	{ 1U, 3484351685U },
-	{ 2U, 2623130059U },
-	{ 3U, 3125133893U },
-	{ 4U,  984847254U },
-};
-
-static struct prandom_test2 {
-	u32 seed;
-	u32 iteration;
-	u32 result;
-} test2[] = {
-	/* Test cases against taus113 from GSL library. */
-	{  931557656U, 959U, 2975593782U },
-	{ 1339693295U, 876U, 3887776532U },
-	{ 1545556285U, 961U, 1615538833U },
-	{  601730776U, 723U, 1776162651U },
-	{ 1027516047U, 687U,  511983079U },
-	{  416526298U, 700U,  916156552U },
-	{ 1395522032U, 652U, 2222063676U },
-	{  366221443U, 617U, 2992857763U },
-	{ 1539836965U, 714U, 3783265725U },
-	{  556206671U, 994U,  799626459U },
-	{  684907218U, 799U,  367789491U },
-	{ 2121230701U, 931U, 2115467001U },
-	{ 1668516451U, 644U, 3620590685U },
-	{  768046066U, 883U, 2034077390U },
-	{ 1989159136U, 833U, 1195767305U },
-	{  536585145U, 996U, 3577259204U },
-	{ 1008129373U, 642U, 1478080776U },
-	{ 1740775604U, 939U, 1264980372U },
-	{ 1967883163U, 508U,   10734624U },
-	{ 1923019697U, 730U, 3821419629U },
-	{  442079932U, 560U, 3440032343U },
-	{ 1961302714U, 845U,  841962572U },
-	{ 2030205964U, 962U, 1325144227U },
-	{ 1160407529U, 507U,  240940858U },
-	{  635482502U, 779U, 4200489746U },
-	{ 1252788931U, 699U,  867195434U },
-	{ 1961817131U, 719U,  668237657U },
-	{ 1071468216U, 983U,  917876630U },
-	{ 1281848367U, 932U, 1003100039U },
-	{  582537119U, 780U, 1127273778U },
-	{ 1973672777U, 853U, 1071368872U },
-	{ 1896756996U, 762U, 1127851055U },
-	{  847917054U, 500U, 1717499075U },
-	{ 1240520510U, 951U, 2849576657U },
-	{ 1685071682U, 567U, 1961810396U },
-	{ 1516232129U, 557U,    3173877U },
-	{ 1208118903U, 612U, 1613145022U },
-	{ 1817269927U, 693U, 4279122573U },
-	{ 1510091701U, 717U,  638191229U },
-	{  365916850U, 807U,  600424314U },
-	{  399324359U, 702U, 1803598116U },
-	{ 1318480274U, 779U, 2074237022U },
-	{  697758115U, 840U, 1483639402U },
-	{ 1696507773U, 840U,  577415447U },
-	{ 2081979121U, 981U, 3041486449U },
-	{  955646687U, 742U, 3846494357U },
-	{ 1250683506U, 749U,  836419859U },
-	{  595003102U, 534U,  366794109U },
-	{   47485338U, 558U, 3521120834U },
-	{  619433479U, 610U, 3991783875U },
-	{  704096520U, 518U, 4139493852U },
-	{ 1712224984U, 606U, 2393312003U },
-	{ 1318233152U, 922U, 3880361134U },
-	{  855572992U, 761U, 1472974787U },
-	{   64721421U, 703U,  683860550U },
-	{  678931758U, 840U,  380616043U },
-	{  692711973U, 778U, 1382361947U },
-	{  677703619U, 530U, 2826914161U },
-	{   92393223U, 586U, 1522128471U },
-	{ 1222592920U, 743U, 3466726667U },
-	{  358288986U, 695U, 1091956998U },
-	{ 1935056945U, 958U,  514864477U },
-	{  735675993U, 990U, 1294239989U },
-	{ 1560089402U, 897U, 2238551287U },
-	{   70616361U, 829U,   22483098U },
-	{  368234700U, 731U, 2913875084U },
-	{   20221190U, 879U, 1564152970U },
-	{  539444654U, 682U, 1835141259U },
-	{ 1314987297U, 840U, 1801114136U },
-	{ 2019295544U, 645U, 3286438930U },
-	{  469023838U, 716U, 1637918202U },
-	{ 1843754496U, 653U, 2562092152U },
-	{  400672036U, 809U, 4264212785U },
-	{  404722249U, 965U, 2704116999U },
-	{  600702209U, 758U,  584979986U },
-	{  519953954U, 667U, 2574436237U },
-	{ 1658071126U, 694U, 2214569490U },
-	{  420480037U, 749U, 3430010866U },
-	{  690103647U, 969U, 3700758083U },
-	{ 1029424799U, 937U, 3787746841U },
-	{ 2012608669U, 506U, 3362628973U },
-	{ 1535432887U, 998U,   42610943U },
-	{ 1330635533U, 857U, 3040806504U },
-	{ 1223800550U, 539U, 3954229517U },
-	{ 1322411537U, 680U, 3223250324U },
-	{ 1877847898U, 945U, 2915147143U },
-	{ 1646356099U, 874U,  965988280U },
-	{  805687536U, 744U, 4032277920U },
-	{ 1948093210U, 633U, 1346597684U },
-	{  392609744U, 783U, 1636083295U },
-	{  690241304U, 770U, 1201031298U },
-	{ 1360302965U, 696U, 1665394461U },
-	{ 1220090946U, 780U, 1316922812U },
-	{  447092251U, 500U, 3438743375U },
-	{ 1613868791U, 592U,  828546883U },
-	{  523430951U, 548U, 2552392304U },
-	{  726692899U, 810U, 1656872867U },
-	{ 1364340021U, 836U, 3710513486U },
-	{ 1986257729U, 931U,  935013962U },
-	{  407983964U, 921U,  728767059U },
-};
-
-static void prandom_state_selftest_seed(struct rnd_state *state, u32 seed)
-{
-#define LCG(x)	 ((x) * 69069U)	/* super-duper LCG */
-	state->s1 = __seed(LCG(seed),        2U);
-	state->s2 = __seed(LCG(state->s1),   8U);
-	state->s3 = __seed(LCG(state->s2),  16U);
-	state->s4 = __seed(LCG(state->s3), 128U);
-}
-
-static int __init prandom_state_selftest(void)
-{
-	int i, j, errors = 0, runs = 0;
-	bool error = false;
-
-	for (i = 0; i < ARRAY_SIZE(test1); i++) {
-		struct rnd_state state;
-
-		prandom_state_selftest_seed(&state, test1[i].seed);
-		prandom_warmup(&state);
-
-		if (test1[i].result != prandom_u32_state(&state))
-			error = true;
-	}
-
-	if (error)
-		pr_warn("prandom: seed boundary self test failed\n");
-	else
-		pr_info("prandom: seed boundary self test passed\n");
-
-	for (i = 0; i < ARRAY_SIZE(test2); i++) {
-		struct rnd_state state;
-
-		prandom_state_selftest_seed(&state, test2[i].seed);
-		prandom_warmup(&state);
-
-		for (j = 0; j < test2[i].iteration - 1; j++)
-			prandom_u32_state(&state);
-
-		if (test2[i].result != prandom_u32_state(&state))
-			errors++;
-
-		runs++;
-		cond_resched();
-	}
-
-	if (errors)
-		pr_warn("prandom: %d/%d self tests failed\n", errors, runs);
-	else
-		pr_info("prandom: %d self tests passed\n", runs);
-	return 0;
-}
-core_initcall(prandom_state_selftest);
-#endif
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 601dba4b7..39d283b26 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -49,5 +49,6 @@ obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
 obj-$(CONFIG_RATELIMIT_KUNIT_TEST) += test_ratelimit.o
+obj-$(CONFIG_PRANDOM_KUNIT_TEST) += random32_kunit.o
 
 obj-$(CONFIG_TEST_RUNTIME_MODULE)		+= module/
diff --git a/lib/tests/random32_kunit.c b/lib/tests/random32_kunit.c
new file mode 100644
index 000000000..436435026
--- /dev/null
+++ b/lib/tests/random32_kunit.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for random32 functions.
+ */
+
+#include <linux/prandom.h>
+#include <kunit/test.h>
+
+/* prandom_warmup() is static in lib/random32.c; exposed for testing only. */
+void prandom_warmup(struct rnd_state *state);
+
+static const struct prandom_test1 {
+	u32 seed;
+	u32 result;
+} test1[] = {
+	{ 1U, 3484351685U },
+	{ 2U, 2623130059U },
+	{ 3U, 3125133893U },
+	{ 4U,  984847254U },
+};
+
+static const struct prandom_test2 {
+	u32 seed;
+	u32 iteration;
+	u32 result;
+} test2[] = {
+	/* Test cases against taus113 from GSL library. */
+	{  931557656U, 959U, 2975593782U },
+	{ 1339693295U, 876U, 3887776532U },
+	{ 1545556285U, 961U, 1615538833U },
+	{  601730776U, 723U, 1776162651U },
+	{ 1027516047U, 687U,  511983079U },
+	{  416526298U, 700U,  916156552U },
+	{ 1395522032U, 652U, 2222063676U },
+	{  366221443U, 617U, 2992857763U },
+	{ 1539836965U, 714U, 3783265725U },
+	{  556206671U, 994U,  799626459U },
+	{  684907218U, 799U,  367789491U },
+	{ 2121230701U, 931U, 2115467001U },
+	{ 1668516451U, 644U, 3620590685U },
+	{  768046066U, 883U, 2034077390U },
+	{ 1989159136U, 833U, 1195767305U },
+	{  536585145U, 996U, 3577259204U },
+	{ 1008129373U, 642U, 1478080776U },
+	{ 1740775604U, 939U, 1264980372U },
+	{ 1967883163U, 508U,   10734624U },
+	{ 1923019697U, 730U, 3821419629U },
+	{  442079932U, 560U, 3440032343U },
+	{ 1961302714U, 845U,  841962572U },
+	{ 2030205964U, 962U, 1325144227U },
+	{ 1160407529U, 507U,  240940858U },
+	{  635482502U, 779U, 4200489746U },
+	{ 1252788931U, 699U,  867195434U },
+	{ 1961817131U, 719U,  668237657U },
+	{ 1071468216U, 983U,  917876630U },
+	{ 1281848367U, 932U, 1003100039U },
+	{  582537119U, 780U, 1127273778U },
+	{ 1973672777U, 853U, 1071368872U },
+	{ 1896756996U, 762U, 1127851055U },
+	{  847917054U, 500U, 1717499075U },
+	{ 1240520510U, 951U, 2849576657U },
+	{ 1685071682U, 567U, 1961810396U },
+	{ 1516232129U, 557U,    3173877U },
+	{ 1208118903U, 612U, 1613145022U },
+	{ 1817269927U, 693U, 4279122573U },
+	{ 1510091701U, 717U,  638191229U },
+	{  365916850U, 807U,  600424314U },
+	{  399324359U, 702U, 1803598116U },
+	{ 1318480274U, 779U, 2074237022U },
+	{  697758115U, 840U, 1483639402U },
+	{ 1696507773U, 840U,  577415447U },
+	{ 2081979121U, 981U, 3041486449U },
+	{  955646687U, 742U, 3846494357U },
+	{ 1250683506U, 749U,  836419859U },
+	{  595003102U, 534U,  366794109U },
+	{   47485338U, 558U, 3521120834U },
+	{  619433479U, 610U, 3991783875U },
+	{  704096520U, 518U, 4139493852U },
+	{ 1712224984U, 606U, 2393312003U },
+	{ 1318233152U, 922U, 3880361134U },
+	{  855572992U, 761U, 1472974787U },
+	{   64721421U, 703U,  683860550U },
+	{  678931758U, 840U,  380616043U },
+	{  692711973U, 778U, 1382361947U },
+	{  677703619U, 530U, 2826914161U },
+	{   92393223U, 586U, 1522128471U },
+	{ 1222592920U, 743U, 3466726667U },
+	{  358288986U, 695U, 1091956998U },
+	{ 1935056945U, 958U,  514864477U },
+	{  735675993U, 990U, 1294239989U },
+	{ 1560089402U, 897U, 2238551287U },
+	{   70616361U, 829U,   22483098U },
+	{  368234700U, 731U, 2913875084U },
+	{   20221190U, 879U, 1564152970U },
+	{  539444654U, 682U, 1835141259U },
+	{ 1314987297U, 840U, 1801114136U },
+	{ 2019295544U, 645U, 3286438930U },
+	{  469023838U, 716U, 1637918202U },
+	{ 1843754496U, 653U, 2562092152U },
+	{  400672036U, 809U, 4264212785U },
+	{  404722249U, 965U, 2704116999U },
+	{  600702209U, 758U,  584979986U },
+	{  519953954U, 667U, 2574436237U },
+	{ 1658071126U, 694U, 2214569490U },
+	{  420480037U, 749U, 3430010866U },
+	{  690103647U, 969U, 3700758083U },
+	{ 1029424799U, 937U, 3787746841U },
+	{ 2012608669U, 506U, 3362628973U },
+	{ 1535432887U, 998U,   42610943U },
+	{ 1330635533U, 857U, 3040806504U },
+	{ 1223800550U, 539U, 3954229517U },
+	{ 1322411537U, 680U, 3223250324U },
+	{ 1877847898U, 945U, 2915147143U },
+	{ 1646356099U, 874U,  965988280U },
+	{  805687536U, 744U, 4032277920U },
+	{ 1948093210U, 633U, 1346597684U },
+	{  392609744U, 783U, 1636083295U },
+	{  690241304U, 770U, 1201031298U },
+	{ 1360302965U, 696U, 1665394461U },
+	{ 1220090946U, 780U, 1316922812U },
+	{  447092251U, 500U, 3438743375U },
+	{ 1613868791U, 592U,  828546883U },
+	{  523430951U, 548U, 2552392304U },
+	{  726692899U, 810U, 1656872867U },
+	{ 1364340021U, 836U, 3710513486U },
+	{ 1986257729U, 931U,  935013962U },
+	{  407983964U, 921U,  728767059U },
+};
+
+static void prandom_state_test_seed(struct rnd_state *state, u32 seed)
+{
+#define LCG(x)	 ((x) * 69069U)	/* super-duper LCG */
+	state->s1 = __seed(LCG(seed),        2U);
+	state->s2 = __seed(LCG(state->s1),   8U);
+	state->s3 = __seed(LCG(state->s2),  16U);
+	state->s4 = __seed(LCG(state->s3), 128U);
+}
+
+static void test_prandom_seed_boundary(struct kunit *test)
+{
+	int i;
+	struct rnd_state state;
+
+	for (i = 0; i < ARRAY_SIZE(test1); i++) {
+		prandom_state_test_seed(&state, test1[i].seed);
+		prandom_warmup(&state);
+		KUNIT_EXPECT_EQ(test, test1[i].result, prandom_u32_state(&state));
+	}
+}
+
+static void test_prandom_taus113(struct kunit *test)
+{
+	int i, j;
+	struct rnd_state state;
+
+	for (i = 0; i < ARRAY_SIZE(test2); i++) {
+		prandom_state_test_seed(&state, test2[i].seed);
+		prandom_warmup(&state);
+
+		for (j = 0; j < test2[i].iteration - 1; j++)
+			prandom_u32_state(&state);
+
+		KUNIT_EXPECT_EQ(test, test2[i].result, prandom_u32_state(&state));
+	}
+}
+
+static struct kunit_case prandom_test_cases[] = {
+	KUNIT_CASE(test_prandom_seed_boundary),
+	KUNIT_CASE(test_prandom_taus113),
+	{}
+};
+
+static struct kunit_suite prandom_test_suite = {
+	.name = "prandom",
+	.test_cases = prandom_test_cases,
+};
+
+kunit_test_suite(prandom_test_suite);
+
+MODULE_DESCRIPTION("KUnit test for prandom");
+MODULE_LICENSE("GPL");
-- 
2.52.0


