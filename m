Return-Path: <netdev+bounces-294886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VDxDK357IGql4AAAu9opvQ
	(envelope-from <netdev+bounces-294886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:07:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5263AC1F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:07:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xgzf5J2v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294886-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294886-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB91330EE9EF
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597937B032;
	Wed,  3 Jun 2026 19:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB3537207A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 19:02:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513373; cv=none; b=KxZzvsQenwRwLlvZ32YgI2wKa2y8bvwCr1P+qWZkqW5m8TFchSzbEfSrxdD34mz0MrUHNjo/6AoGDJXGP/7G9f6bPq5nJ5jPFDSoaGw3GYySethiMZUrz7if62QgxNOrSvx+AgIYaaK5Lq8X7O/CfYqlgp37bQDTpxQybe6Mnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513373; c=relaxed/simple;
	bh=KtMgABGlcpTepOluQ1ou8fSMVZFHM4vfpwhadYiKBcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfK3rjBxVNVS9C65NUVuwmGXX9uoSq4wda7FEc6fSdHTn6ugVGu/lQNxtjF/y3Je3l0vokOik4SSNc0FNxkSRk5dx5TUTUY0m05SmQN8GjjMnSREIL0Rsp2vn38am/UXmTU31u/xUoXyzqlT9RW6KoicKOmqzllPSHsfPW1TXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgzf5J2v; arc=none smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e0aa486af8so7539007b3.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 12:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780513371; x=1781118171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czVnTl00M38M+CvcTn3IvYeN9aQCX6IoD9Yd91fGVis=;
        b=Xgzf5J2vT4ydOUrNm1G3+3kyQzc1AvwYcmcIFa55A3SSA3dqiXbo9ZduK8WEnyfmt7
         sjyADD6lJ3yCnqEewTBnPcNXxJKQgy4tpA7MMViBJoAvsv5XHHFyykIKnptoedlPSGxa
         J6+UciEVgSD8WUsjzPBvT1JBm4rC6q1V3vQ+CC6tOI2azAKANKrOPE6vzjsiA276mHaE
         n14Plf0r7Ria1zzwZcC4F8Xesy54AMnIaKoR9kh4bgfsSzLK8vDiT7z+sLFroMJYB7Ym
         fisGhesxqXty824um0IUdMy1vIXjBmXstZMJq+0dz0XOSfGEvQ9xmflp+MMIT2F6YzG8
         pfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513371; x=1781118171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czVnTl00M38M+CvcTn3IvYeN9aQCX6IoD9Yd91fGVis=;
        b=g5D3Oh2OXa1DE1Fh3ooMPUgX3y4gkj21qGLhU4dESLwZjPl+dVM4I3G7ZYqrmGuRwO
         n1fVYpn9YRBDG+gBactaakwcbI12XVzRoslArIEx7zaZHhyLixB4hotB8XPNUWjYhaoA
         +is8aCYbC9I4GB6jygS84Wp7QXvgLHT/0JSLtC3wElSEs2lFPme093iQg4GxGWzQk8ud
         Dk7k2RoU+U500yT0v5Txjg9kF+pWw/lF/G2TpoAEio46b4tWAqGGL/FS39mzOXwZnBnJ
         6qXpubBKRZewiHmcO9fVtuoc1ujroudAyepuwdM2M7MKeEdLj0Vp0D85zTrMUkrHDx/2
         +ozg==
X-Gm-Message-State: AOJu0YxkaeyS3ftm/u2i+o0rdxQwrpfP3EwYgqWn5JOrYYF8aVRlpRKH
	B8VtKWuMvfCY4bK749yaE87s0Owr5nYTQUclS02CQCUJvZQkj9qRFhL1nmVUJg==
X-Gm-Gg: Acq92OGy9ZSVsC7WQC8ULi5OwWWkjMYhCnqfHO/2V0iYFYy70V3Z/7GZo1OocbhxFvX
	hl7fxQGGzsd2bjhXbdWzlTM2S7vrxUrzUrp/zgu58gA0MDxeQQm5bFTqvO1+NWePz7baz5KZ1FL
	D2dRYjTDf+Z/+5CIxFHr89m6nUb20k0UNHuC5sotO0qimZ7LTmal9e4ecgwj/BITSTWA0CPRLQ0
	QJctAIiXsxLvwjqVqt/Tpi/8S38w7db9SIFjOnQb4AvvHtgJqILnjhNQuWN8Gj9kHfzkm5Xo2jO
	xIhXux2mBFDqimzbsvBfnMyIIn/ehObTbtCV/ULcjX85ASPfInIY9D1DTwwJ2FC2CX8mC5NAH3+
	Vt7t7PA1U/5GYyQmLGCpxIF+XptH/NjYbAKOSdOZ5qftQzjpQJCqBIkSOcKXRAzzrtdwCWr0U2V
	huIjsgVHgUEkvwltwI753KJ4JyNqp4b3HzTe0tjIaz+Hr4WATFTx58J0ErbBBJMgE8AdJ5T9XPg
	rynbxIteaFqec9tpUoOjHnDDVVDu8Oaq7QFbeN3
X-Received: by 2002:a05:690c:a002:b0:7dc:d3cd:838c with SMTP id 00721157ae682-7eb8dd70fb2mr4415557b3.33.1780513371261;
        Wed, 03 Jun 2026 12:02:51 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8186sm22350467b3.4.2026.06.03.12.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:02:50 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 3/3] selftests: drv-net: extend so_txtime with FQ with other clocks
Date: Wed,  3 Jun 2026 15:01:30 -0400
Message-ID: <20260603190243.2789335-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-294886-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DE5263AC1F

From: Willem de Bruijn <willemb@google.com>

Add a variant of the existing FQ tests, but pass CLOCK_TAI rather than
the native CLOCK_MONOTONIC clock id.

FQ used to imply monotonic. This is no longer the case, and the
inverse need not hold either. Rename $PREFIX_mono to $PREFIX_fq.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/drivers/net/so_txtime.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index 5d4388bfc6dd..b7be4cabbec2 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -46,7 +46,7 @@ def _qdisc_setup(ifname, qdisc, optargs=""):
     tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
 
 
-def _test_variants_mono():
+def _test_variants_fq():
     for ipver in ["4", "6"]:
         for testcase in [
             ["no_delay", "a,-1", "a,-1"],
@@ -59,13 +59,20 @@ def _test_variants_mono():
             yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
 
 
-@ksft_variants(_test_variants_mono())
-def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
     """Run all variants of monotonic (fq) tests."""
     _qdisc_setup(cfg.ifname, "fq")
     test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
 
 
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_fq_tai(cfg, ipver, args_tx, args_rx):
+    """Run all variants of fq tests, but pass CLOCK_TAI to test conversion."""
+    _qdisc_setup(cfg.ifname, "fq")
+    test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, True)
+
+
 def _test_variants_etf():
     for ipver in ["4", "6"]:
         for testcase in [
@@ -95,7 +102,10 @@ def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
 def main() -> None:
     """Boilerplate ksft main."""
     with NetDrvEpEnv(__file__) as cfg:
-        ksft_run([test_so_txtime_mono, test_so_txtime_etf], args=(cfg,))
+        ksft_run(
+            [test_so_txtime_fq_mono, test_so_txtime_fq_tai, test_so_txtime_etf],
+            args=(cfg,),
+        )
     ksft_exit()
 
 
-- 
2.54.0.1032.g2f8565e1d1-goog


