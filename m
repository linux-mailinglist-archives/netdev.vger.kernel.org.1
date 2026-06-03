Return-Path: <netdev+bounces-294973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cLb4FwXBIGpB7gAAu9opvQ
	(envelope-from <netdev+bounces-294973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:04:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD4963BF7B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:04:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JSww1zuo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294973-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294973-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A017A30A1C1B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E264DD6D3;
	Wed,  3 Jun 2026 23:59:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125834DD6E1
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531195; cv=none; b=WtgZFUDm9UY5ISYEtv9pW1/jGR9Yr30r4U+RQBK++Pf0cGWpXMFjiZqhvpmQlg8UOQZZwaNUSFG4iQhlL6lk6tY+lYcYbSPwuHZnQibmkAsEiqK/ZMAImDBiPnFiHa9N/BA7DklgTPUqhm96IZLmjmjn5mJhePYk492Hf+YnSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531195; c=relaxed/simple;
	bh=o4bCrAPqY2OwVJndIypN54qGLFUZi/XgPCOACyik5aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKc4ak2xLhBFb7dE6saWzrQtzk0uLdoj8kOd5UhkhO4Is6bUllLPJdRteLjod0mwU6qjDlh4TEG9BhIyCHrca5YT0tJ/ZoGvnQNOVyxxmQBb6CZ5Y35F38di67iU0wx9L/ojYoLewWW1tSgbyYkQIVzy+Fr5mrIzQTOwFqS1OcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSww1zuo; arc=none smtp.client-ip=209.85.128.171
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7df68e68103so180867b3.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531193; x=1781135993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2wB9AL1QlGCOzz5Bq43cZT2ped99U/TYYqDX0RD9rY=;
        b=JSww1zuo77b9u4Tp2vJRue66XUZ7cUNjOrD65S0T6E59/bXbz1MpB5o726zrAQhr7N
         N0tAt7emioM2SmwYBbjr/ConVDR3sd9469XaW8WfKDTima0UDavBj5rp6LBcGmnj5Ehl
         +vQiTJwGG63rV/0/A3esSE/d/N2w5GRqhwdz9QAh4eUpBxOkUZBSVXA+w5cb7kzNAg+T
         SnwPBLRh8J14txBjuqtQrwa8rjguKOJCU62K/M51AGsrb2daON+UU7i/IALrmAVT+NWR
         UzEkhbgpBh4U1Ie2cGGssp9RbBKWQ+FiWAhzmgImNQ3YmCaNbYD61ueysikEB1ZqBbCS
         ajvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531193; x=1781135993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2wB9AL1QlGCOzz5Bq43cZT2ped99U/TYYqDX0RD9rY=;
        b=JyesNO7EqLLK0MyJpzbF6z6oXKZti9Z1jOkuAEofXkP9lJoBIQTKSJAJTotyrOS1jM
         +3iojlUYEoe+KmLMexYOMjIQ2FM+N1InNrI5+jzcodW5+ZP06a3v/e7yu7ZwRC7Go3PW
         3b9YhvQhazmSQJ3LFyqeJyc0GW9yJp19oX5DCQVTtsiCIMmYybKI02AAsRP/Wyn7IGsk
         iZ2bDqirUdq0QFfovUjNUqu/xzg4/shx/0Xnk7q9gYOWj1KIdIhsWz1PS7WG38B7dJq2
         616uB8FBZmKDq2eHRtK/Rf9CNfDjr9WAFZGTo4x5s0ibi6tjrl+IhVCk+Pf2mmuC1Lxv
         xPjA==
X-Gm-Message-State: AOJu0YwzdhiuF00GKw74mjBHzgF4T6Js9fX7Vu9N7ny4wQ23O/K8ZZXT
	ip8pybI5+zyejxEqkm4t7/kcSfD4Ma1P2Si6aKvxNki1uDtgX3Nq9hCkOBMA1w==
X-Gm-Gg: Acq92OEfPT96YfPkrsGcAxG9MzPAmqrb1PW8tbpKy9zr1mz/Ya/cKReJYUPftjnJWVj
	IwzUuQauydVBwmnroheFoqIlffqxc0KyvvitrFTvcMNdut7z6viBVRxjlYUI1Fb33WMGqWQuGRl
	QoeOlyT+6YEwbD7+25Q2yB0d3RLmSSfrcGmJMx07yMNnnaGeijP3wug9Pn5KLoIBoiKM1JhdB+U
	kHHFbJK5KeyPXc1WUVQc9kTmZuhtKW5VGfY0WWQhGkMaySUT0zOjnfCEOELAm95pvbFwql9hXS1
	UvqHyxUz0qU8iVZQl7EJ3vMKeSt1vRSoAe8gMVPWkvt1tFkaOmUwcqeY2dC4S/NVg/OCT1H90av
	JGudbFCWPSvy8E4+mvr1GgxPNaqo2R8ayq+C3XJb1o+70Ib4ZEouZ5rsZG1t7oXV5a3XZtrHL1F
	xwTvwlKhqOWGZnWh+PIN99iCdAZfsKQH9dazFnCPaJ5fvl5g==
X-Received: by 2002:a05:690c:dc9:b0:7df:a880:8c98 with SMTP id 00721157ae682-7ebd2b6ee96mr3151737b3.0.1780531193196;
        Wed, 03 Jun 2026 16:59:53 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8d0dsm25424517b3.6.2026.06.03.16.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:52 -0700 (PDT)
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
Subject: [PATCH v15 net-next 04/10] selftests/net: psp: refactor test builders to use ksft_variants
Date: Wed,  3 Jun 2026 16:59:33 -0700
Message-ID: <20260603235947.2986110-5-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
References: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294973-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBD4963BF7B

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


