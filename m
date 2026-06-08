Return-Path: <netdev+bounces-296777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EUmyENhQJ2r1ugIAu9opvQ
	(envelope-from <netdev+bounces-296777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:31:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C865B2C0
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:31:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QFaOC4sF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296777-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296777-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C22B301C5B1
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AAE342539;
	Mon,  8 Jun 2026 23:31:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BE3403ED
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961486; cv=none; b=Z0VCfLR5gAtrlFSkbOVAohiTnqKPVdEr7R/n9BTxQMUD/aZnIxA5kk+0kD+047ZfKvxTU9oo995wz2OXI3gpCQc5/JpRClp/qWSCv8WpnoIG8o8qYR8cfm5isw5g0sIEQLmQBo0ijuSQSGxubJhnZiJAa0N8rAeRXHhnoY7Lmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961486; c=relaxed/simple;
	bh=o4bCrAPqY2OwVJndIypN54qGLFUZi/XgPCOACyik5aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFjthjRxpyA4VN/XO9SjT0BVmN5K6tG1Nfb7vMM0DZhuKsghbQB+oAjCIQKzbNvXwc0ABmKlBFUGrqQCePklEMwnw4eA7mnb9q6mVVLIFc+sPaK6q7Gg2WMCTuHpPQ3n/XLVuYvrhGTgrHmBPH5BhxUiRI+fZkCI5R0c6lc2l0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFaOC4sF; arc=none smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e255c15ffcso7091497b3.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961484; x=1781566284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2wB9AL1QlGCOzz5Bq43cZT2ped99U/TYYqDX0RD9rY=;
        b=QFaOC4sFnwpFO5y/RXYKK5aTvIsv9ru0h4mD2bVdVBoaAGEJa3DG3OWsvZleYYqP9M
         v/vKlReQECpaTDR3FOMfPAIXZejLcndffT3V7zd5fzyOnhnSxsv0oMCNfjjnduvdsMpi
         oWpQuFcALuw92onkvTNKLAVyJNLlkIr5kcfDv0h5d1aCm+dOsz/Uv0JIYy1xfkH+9xAP
         H2JOE0druj04uyo6ttD3bL/5+PptiKmUSc4xEGhP3pjtmRdnT9bh+ONVmFEbcFjSyZVD
         VT8KKCnPgAtk8eBIuVzjYwB6DB9BLHq7awt8GbDzgVF2tMwpIFPNopymHAzJQHYCjdNZ
         Pzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961484; x=1781566284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2wB9AL1QlGCOzz5Bq43cZT2ped99U/TYYqDX0RD9rY=;
        b=E8Y9eckd/AQgD6qu+OrcnRvZBzOpOqn2yPeqfYqXE81dwIZ7D2Ayx1TJDk04lipLri
         FdnMbyB+7hGIAGxGylaEhGaeqBPBY/K9zLP+84I1k8ExFmZ/wmquDEOBNAMvmGeyDlHk
         ilJSPX8s9ulIurHLxeKO/XkNDnGarbfxN/zSgikXlcCd8zJM5lY5W4OydbDyXDsIZ0t3
         fJSOs2PuFMkhtz0/euGu0ua8B6I67eosRDamj3vEOd/nzfwK1V6uSt+JNAH6MVVi1Usp
         RsKsHjrlVtqkYTAvnjw/nuwGT47eKX/M8xACBc7JFmor0LjLIBmWTGAH3KkKggBMhPSD
         grTg==
X-Gm-Message-State: AOJu0YyZ6+Ezn6ECIU8r9/69ZDMnt1LHilTijm4/E5XY+9d/z84Knnmv
	RyURrPrmdi32Lo/0XYJMjSNw0EDMVbY4OWg/pQq2QJu8uJ5oN6JpzDj7gzEppA==
X-Gm-Gg: Acq92OHmM9N+Zx0qjyFLhFcWmRPWlOf7gtyLeCJV14+QDEPPUXj+jDK6ukz9B09S7uY
	0OBCOqaX32Zd/oXdAzqprBUoEd/vxUDHotq+EKza7wJC4/1JZofg/g43YHsnXd/Fmu4AKAPOq8p
	1EosqhAZiJNtOCeIkgGpVmiksDqbfRZkwJ08WrbqkhZWPFoNGkFcEvYp3pRehSc1Rq55d84fpzW
	7WNU1TNKc7wRZtS1RWIYm4qovFY/myrYY+4UO+6qcSamxL45/4ZY7msTdEyEcmFOIHkCmRF3fSZ
	LKC6bLfzpn1HI5OCDao3oG9vD0XomlFSzyjOrdVRc9l4FNanoUa2CmVqNNGF3Ere8hjiwDMKwHU
	02sugYT5L9io9G1mUAqHkSRvpTci0nH/D0iDHcdmVj8OnbC5bqr2Iqk1/kYAqCPY09KD13KyOaC
	o6LtnJ4K3nAHl0uPwG6IaySXuzJM58Z+QImg0=
X-Received: by 2002:a05:690c:3181:b0:7ec:58dc:f23 with SMTP id 00721157ae682-7ed0cbf90efmr96537217b3.5.1780961484296;
        Mon, 08 Jun 2026 16:31:24 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2399ab1fsm90787357b3.33.2026.06.08.16.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:31:24 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v16 net-next 04/10] selftests/net: psp: refactor test builders to use ksft_variants
Date: Mon,  8 Jun 2026 16:31:12 -0700
Message-ID: <20260608233118.2694144-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
References: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296777-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C4C865B2C0

From: Wei Wang <weibunny@fb.com>

Replace the manual psp_ip_ver_test_builder() and ipver_test_builder()
functions with @ksft_variants decorators for data_basic_send and
data_mss_adjust. This is a pure refactor with no behavior change.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 tools/testing/selftests/drivers/net/psp.py | 46 ++++++++++------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 864d9fce1094..6d5114be4c88 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -14,6 +14,7 @@ from lib.py import defer
 from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
 from lib.py import ksft_not_none
+from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, PSPFamily, NlError
 from lib.py import bkg, rand_port, wait_port_listen
@@ -571,24 +572,29 @@ def removal_device_bi(cfg):
         _close_conn(cfg, s)
 
 
-def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
-    """Build test cases for each combo of PSP version and IP version"""
-    def test_case(cfg):
-        cfg.require_ipver(ipver)
-        test_func(cfg, psp_ver, ipver)
+def _get_psp_ver_ip_variants():
+    for ver in range(4):
+        for ipv in ("4", "6"):
+            yield KsftNamedVariant(f"v{ver}_ip{ipv}", ver, ipv)
 
-    test_case.__name__ = f"{name}_v{psp_ver}_ip{ipver}"
-    return test_case
 
+def _get_ip_variants():
+    for ipv in ("4", "6"):
+        yield KsftNamedVariant(f"ip{ipv}", ipv)
 
-def ipver_test_builder(name, test_func, ipver):
-    """Build test cases for each IP version"""
-    def test_case(cfg):
-        cfg.require_ipver(ipver)
-        test_func(cfg, ipver)
 
-    test_case.__name__ = f"{name}_ip{ipver}"
-    return test_case
+@ksft_variants(_get_psp_ver_ip_variants())
+def data_basic_send(cfg, version, ipver):
+    """Test basic PSP data send."""
+    cfg.require_ipver(ipver)
+    _data_basic_send(cfg, version, ipver)
+
+
+@ksft_variants(_get_ip_variants())
+def data_mss_adjust(cfg, ipver):
+    """Test MSS adjustment with PSP."""
+    cfg.require_ipver(ipver)
+    _data_mss_adjust(cfg, ipver)
 
 
 def main() -> None:
@@ -611,17 +617,7 @@ def main() -> None:
                                                           cfg.comm_port),
                                                          timeout=1)
 
-                cases = [
-                    psp_ip_ver_test_builder(
-                        "data_basic_send", _data_basic_send, version, ipver
-                    )
-                    for version in range(0, 4)
-                    for ipver in ("4", "6")
-                ]
-                cases += [
-                    ipver_test_builder("data_mss_adjust", _data_mss_adjust, ipver)
-                    for ipver in ("4", "6")
-                ]
+                cases = [data_basic_send, data_mss_adjust]
 
                 ksft_run(cases=cases, globs=globals(),
                          case_pfx={"dev_", "data_", "assoc_", "removal_"},
-- 
2.52.0


