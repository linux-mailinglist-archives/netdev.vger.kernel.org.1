Return-Path: <netdev+bounces-295412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MIkEK+PWIWrYPQEAu9opvQ
	(envelope-from <netdev+bounces-295412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:49:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EFB643042
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:49:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Rujq+fk4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295412-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295412-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFBC93086FC5
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4023C0605;
	Thu,  4 Jun 2026 19:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B23C1981
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 19:42:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602163; cv=none; b=HpmA7kNW5GEWOTBhD4CXaks/vMgDL445zZEEElM1pi/bzEqR5N/LnOdkdJrbN5FXd1ZQdXWNcTjQG4NxfW/0osZ15qcPhKMMF/WcBsqkKisqkX/TpZRftktFVcDVdfvMrflkRwg4k634Kgr5C8fzYxlUZYfTknkFCiTkymH5dUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602163; c=relaxed/simple;
	bh=KtMgABGlcpTepOluQ1ou8fSMVZFHM4vfpwhadYiKBcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDAzZ9xc9BVDlqkHoiRb2Mzo8x5fqnMEg0Alrv8OIueLZtoaWAvNoweGP/moSHhlguidUamNRm7UamVxRC6OGz2yhy8xTqMtwDkCS6173KFfflCohzwMyzkbCl4EwCFaPadBMcy31M+cp3MkAgSQC0h4QeFox+xBb9qKPW5Q2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rujq+fk4; arc=none smtp.client-ip=74.125.224.52
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66043ecf6b3so1369482d50.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602161; x=1781206961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czVnTl00M38M+CvcTn3IvYeN9aQCX6IoD9Yd91fGVis=;
        b=Rujq+fk4PStZVAPxIIw5KzdygAnQLWCHwkxaQZSL47bCxJ8X0AIEoPlIj96r+5UBv+
         WDqR31joAXqv/d0N2eu78XAfF+R1DRsIJ1UQSFV5LD/LLVy0RFnw7hB+DIvZBD6Ap1BJ
         DQpuDNvXIGPiBzcJE7hHdzF0DMhy5+Qdg/jk+Yo/hYS5Hn9e9nqJaGFQkCWfwPk3VZEb
         jpN38KqwPWpFluBWBaPwLuoATNzZJcQXlNLOHgXoDiTCJyma1geOPLRC7Ds+a/vbvKRK
         kbjlWIA8sppPMp8ahiTGpbJCJj6DTdrlEE0/bwG14qLchrRXVOojGnauJ0TfSezMHSJQ
         qOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602161; x=1781206961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czVnTl00M38M+CvcTn3IvYeN9aQCX6IoD9Yd91fGVis=;
        b=BuDyubInpIVIyzxW6Y5z9RxxQvuPkz+V2g36h+MlmZRL6GO+1KOhAAObi0ZNV+byh7
         Sl0MLP6aYPrhPhJ378mqHa98r0OroSoE7sAEUWqk2wKtIWx8pLoPoEc7YkntEDgs0xA0
         9zAEmJOLzXP+UJUoQmWA3lF58X0/KUGIhHqke/92ShDOpEy/KOtGzBiByFMqc8u2rvTY
         Vk0dMTp51rizKxXEKHaE1mNUON94IThO3SIy8sYYlENuc7LS8T9CU5lebBoBaWHu7fnQ
         OVS04zJ7cbYrdrjobC9R1TmQgoMQMzjhxpKqCFJASZx4VkxMgT6+1nBJQOeySOJii3xt
         xJWA==
X-Gm-Message-State: AOJu0YwkkQyzYLHibEhk613eX2iY84B1dStj7z9pp7Gey/sEy6wnodPi
	we8NUIQU6Pv0r66RU18luWBdBq+R5WQfJkfzyB7FGujS90HELG/duN2YDPPs6Q==
X-Gm-Gg: Acq92OEc4yZxnkK2OXA/ui4uiVoC4h67GMtP7uVKpT/8pyLPb1odpW9dNPV6uUy1Cwj
	qmSLaj9xOJId9izKjIN5tgFS3m+Kd9gvbd3X1wLieWuiOiF96zzcBWgTw2sMy28O94WclmhYnrb
	gCFx7acwTgFqe7v5OVdcW4f0difQs/loejdEXzDfpPFeLHfeXgbkbmWRzbjnb4Ae+0yg6UgNm85
	8jfXW2lfWtiHyjPXBsFcfSIyAPOVmYlB7qFGv75TEM7Ufk96ReJP/YYkupOuyMQqac6TII/IzQj
	DnXXkIRJnpw/eWkRzHHHo9tPbbRIBHTc8NZnUHdMGRVQDEb89g0DM7mXcvOXXXxJeJK7K3BH9wa
	3xkfkhwGLSE2evupJyZQX7820I7UWjqtbHIOREXl1+OwDrCilPFD1uRKk80Xe0IiIGkWQs1SFFL
	y8TI5FsziK9CMTPEjB07PIXnZzLJoR5GJS9J1Z9by3sWbgnOizwKiJkuBWW6/lY0vggq7jtCWbF
	irf27KBdwYLyrF0yNzavHYKmYQwgQkKpggOmp8Q
X-Received: by 2002:a05:690e:169e:b0:660:54e4:5db5 with SMTP id 956f58d0204a3-66106fb3615mr238751d50.56.1780602161000;
        Thu, 04 Jun 2026 12:42:41 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f883e2sm4360772d50.6.2026.06.04.12.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:42:40 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 3/3] selftests: drv-net: extend so_txtime with FQ with other clocks
Date: Thu,  4 Jun 2026 15:41:05 -0400
Message-ID: <20260604194221.3319080-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
References: <20260604194221.3319080-1-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-295412-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12EFB643042

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


