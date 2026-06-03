Return-Path: <netdev+bounces-294977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6gPXD1vBIGpW7gAAu9opvQ
	(envelope-from <netdev+bounces-294977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA563BF93
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:05:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OEvlEsa6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294977-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294977-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90AA730BF300
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD024DD6E0;
	Thu,  4 Jun 2026 00:00:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A303A168C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531200; cv=none; b=mLp0y8q4PgWpips9OPlnWr2CfRKfnwvI4quFN2JiVZEmFMQyI8mI3QhUoJR3n2sPQkvLaXgJvc4lr6ULgIgDKzWfgDq1wqpNDUUkWL/c8KkRuUzhm+abgRf97laSFt1r6ukTmMX3eTqmEHRm5G4ksUwU/DqKNRiNv4/3ZtT9oXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531200; c=relaxed/simple;
	bh=n8jvIh8rSy5l4r1sikRBZ0KKujywm2brYKxHwyQnGmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+UFA6zDzOaOxHsZQJmJFHB8B6qv44M5MVcjcjL3F07DBgfpH7QZcfGNudtdGXK9UEFxGxcdx6BYRVPk9N1s+bh6+wbBfglRE4BDZe5f4qUlqkoSIihMuwK+ZpP2sG4ufwS5KuOYKWwSlNGuLdILDKme7Tub/Cisa6DslyFsbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEvlEsa6; arc=none smtp.client-ip=74.125.224.50
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6603d54b317so25221d50.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531198; x=1781135998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K41qv9ZHZPYFOsHREWMOzv3cTvIXZflhgrFt4tffsU8=;
        b=OEvlEsa61vOFIWQmSMlNvSGMqrKyfEKEHAKWXY+F2o2Nb94thWAmKu95wjZV3ka4qk
         jF33qdFEYc38oCJmgl8deGEhG7k8CcsaQG3a5ABHAkmMp8O3eUpA0knNPB5/3kBdWXgL
         9mOOKD4Kbs96Op4pM/1wqXE3TI8LlacwxePXHipeVjb4KPR+Y6ttw1Csqxfi1hWdwdkD
         I07fXzMF7oeBNq3xPTlVR0vckvbcxJYm287wr4lWSp2In1hUtAJSFZA2Ox08o23Lqiyl
         u5gnIo2gsVTMA2/rwn5ppyzB5t+qVM4jNGiQBeGUBOFN5ugwi8AjilW7rwV3Kvi6GacP
         EesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531198; x=1781135998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K41qv9ZHZPYFOsHREWMOzv3cTvIXZflhgrFt4tffsU8=;
        b=T290UK87l6LNxt/hfmKObJnkly3t1kd8BjsqbIfnjZ+PnPadXmdgq97DkfTUV+sEEq
         fL9swhYt0hYb/QurrutEyBSEjKpg6G0pkhQyGAbJ4IGT+/8kyCVlx6OXaDflmc64pPQa
         qnGwit61BPM8G7kmFbrsaMimNiKvS8IDOvJN5Lcd75J1WKBxcxDC2iP89e4EXp5RQQNm
         fU6vB33kJ/m5edrO75WkGkSO0wee8BWwnTXYbc6wT3yU63F5pmll/cvAZHNWJnTEsaJM
         epfQtH1YiwrvwnKbU5GuABD8/CHnQsIIzxHJou/KazU2THV7jOPQU3AnMSY6hDAojLYh
         8ZFA==
X-Gm-Message-State: AOJu0YwUByAC71G5RUSOOHCTWwyU8oBf09osCPCqaBHZ0/zdmVcawshF
	8E1q/sRov8tz+y9fLIRQCl6z4X9Xizli2vpdF4L90r070Lf2L18QpwKDi6O4Ow==
X-Gm-Gg: Acq92OHIGWHdlvprR7tstYLBHBW1lh1piV4Q74Ea9xQtG17YqTKPD8tK8+QORI4TkmV
	iFhrzOGM67sP8bDqRH7v6tovGC8kJ4rSpg5ogDWLkgkSDlqVXKKfX8zxjMSOU37WaHpUHcmP294
	GwduZB5sdvbvA5/Ss2NLVrlkH64yZ8/hoguG6KhPHrj7smrfptlLTL6meYYHG6MzA1bhlPsq7AA
	+VUWrMaebRYOYCC5rDCv6Cvlv9nWmqbScHctKFHKVa2OsajK7JZ/aswNQ5KNg2wp/ohsZyWpvu9
	ySpTOGahAk9Jy2/bp++S4jsI4s+cuPwyV2kOUbJATYcZZETbik5PlrCjZdjPZdhE1Aj9ri82Iv0
	er+QPpIt7dE4XZHCcmLbUybs/BEsXJarfYM18xq4BsP8i7X0SVJECtsNMOAbfpqA1LW+qt+69sK
	zfa/y5NgwT+ZdVQKHwFNejTwS33zXMm9ZlGw==
X-Received: by 2002:a05:690c:3481:b0:7db:b065:fe71 with SMTP id 00721157ae682-7ebda6ad51cmr2577127b3.7.1780531197859;
        Wed, 03 Jun 2026 16:59:57 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:1::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d62046efsm2851847d50.11.2026.06.03.16.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:57 -0700 (PDT)
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
Subject: [PATCH v15 net-next 08/10] selftests/net: psp: add dev-assoc data path test
Date: Wed,  3 Jun 2026 16:59:37 -0700
Message-ID: <20260603235947.2986110-9-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-294977-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,vger.kernel.org:from_smtp,fb.com:email,netns.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BFA563BF93

From: Wei Wang <weibunny@fb.com>

Add _assoc_check_list() test that associates nk_guest with the PSP
device and verifies the assoc-list is correctly populated.

Add _data_basic_send_netkit_psp_assoc() which tests PSP data send
through a netkit interface associated with a PSP device. The test
associates nk_guest with the PSP device, then sends PSP-encrypted
traffic from the guest namespace.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 tools/testing/selftests/drivers/net/psp.py | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 015af92c8d7b..f07d0becfede 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -19,6 +19,7 @@ from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import KsftSkipEx
 from lib.py import NetDrvEpEnv, NetDrvContEnv
 from lib.py import NlError, PSPFamily
+from lib.py import NetNSEnter
 from lib.py import bkg, rand_port, wait_port_listen
 from lib.py import ip
 
@@ -602,6 +603,71 @@ def data_mss_adjust(cfg, ipver):
     _data_mss_adjust(cfg, ipver)
 
 
+def _check_assoc_list(cfg, psp_dev_id, ifindex, nsid=None):
+    """Verify assoc-list contains device with given ifindex, no duplicates."""
+    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
+
+    ksft_true('assoc-list' in dev_info,
+              "No assoc-list in dev_get() response after association")
+    found = False
+    for assoc in dev_info['assoc-list']:
+        if assoc['ifindex'] != ifindex:
+            continue
+        if nsid is not None and assoc['nsid'] != nsid:
+            continue
+        ksft_eq(found, False, "Duplicate assoc entry found")
+        found = True
+    ksft_eq(found, True,
+            "Associated device not found in dev_get() response")
+
+
+def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    """
+    Test basic data send with netkit interface associated with PSP dev.
+    """
+    _assoc_nk_guest(cfg)
+
+    # Enter guest namespace (netns) to run PSP test
+    with NetNSEnter(cfg.netns.name):
+        cfg.pspnl = PSPFamily()
+
+        sock = _make_psp_conn(cfg, version, ipver)
+
+        rx_assoc = cfg.pspnl.rx_assoc({"version": version,
+                                       "dev-id": cfg.psp_dev_id,
+                                       "sock-fd": sock.fileno()})
+        rx_key = rx_assoc['rx-key']
+        tx_key = _spi_xchg(sock, rx_key)
+
+        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
+                            "version": version,
+                            "tx-key": tx_key,
+                            "sock-fd": sock.fileno()})
+
+        data_len = _send_careful(cfg, sock, 100)
+        _check_data_rx(cfg, data_len)
+        _close_psp_conn(cfg, sock)
+
+
+def _assoc_check_list(cfg):
+    """Test that assoc-list is correctly populated after dev-assoc."""
+    _assoc_nk_guest(cfg)
+    _check_assoc_list(cfg, cfg.psp_dev_id, cfg.nk_guest_ifindex,
+                      cfg.psp_dev_peer_nsid)
+
+
+def _get_psp_ver_ip6_variants():
+    for ver in range(4):
+        yield KsftNamedVariant(f"v{ver}_ip6", ver, "6")
+
+
+@ksft_variants(_get_psp_ver_ip6_variants())
+def data_basic_send_netkit_psp_assoc(cfg, version, ipver):
+    """Test PSP data send via netkit with dev-assoc."""
+    cfg.require_ipver(ipver)
+    _data_basic_send_netkit_psp_assoc(cfg, version, ipver)
+
+
 def _try_disassoc(cfg, psp_dev_id, ifindex, nsid=None):
     """Best-effort disassociate, ignoring errors if already removed."""
     try:
@@ -713,6 +779,12 @@ def main() -> None:
 
                 cases = [data_basic_send, data_mss_adjust]
 
+                if has_cont:
+                    cases += [
+                        _assoc_check_list,
+                        data_basic_send_netkit_psp_assoc,
+                    ]
+
                 ksft_run(cases=cases, globs=globals(),
                          case_pfx={"dev_", "data_", "assoc_", "removal_"},
                          args=(cfg, ))
-- 
2.52.0


