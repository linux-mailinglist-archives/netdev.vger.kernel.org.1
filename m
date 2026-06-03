Return-Path: <netdev+bounces-294978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kV06GGzBIGpd7gAAu9opvQ
	(envelope-from <netdev+bounces-294978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:06:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE363BFAF
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:06:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=anbKf9+6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294978-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294978-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3224E30C397A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4324DD6D7;
	Thu,  4 Jun 2026 00:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9454DD6D0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531200; cv=none; b=WQeHYV5dm6uQkKERUwZsy5hN7oseQHSDIZJ/GgBlSWeQAmdVVxz1TpwV/QjtOcSur573/0DtaZh8zUT33GbDnzjvwyCNYpWnx6+8j6ztoSqG5V9RWfVDpHnoPvTlsVjwTonV8gUFAhOLx8axn0pk3WBnY9lpANomvtgH5uG2BI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531200; c=relaxed/simple;
	bh=iJbBRl9K/I68pFQ5Sv+M/lNSXaUqcmRfL+kD5ISEqsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJeVhBoS5H/5RciqA1tfEYY1DnVjgsi/Gh15BMW5Lft4f7B/JQ7ZBJseqNe8LDGWJ3VGHh8nLoTocKi7aYlJtNrPU/2Fry814cdvTqaNktQnIWmBVxItsL/ML5YvXdbYe5mfVGkXEJ5s62AbFMbtxIEWrL99iFsKJRvHLA5Aye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anbKf9+6; arc=none smtp.client-ip=74.125.224.51
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66042b348a8so20673d50.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531198; x=1781135998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/6ZuBOG43wI0XV1LNowOZ5Qyn8haY2GSHMaGgLDZj4=;
        b=anbKf9+6YM/QceD/M31lfhE3ybV22rpZVwTsR0ILy7foY4agnrS/Vg+yySG6odzdGv
         LDtm1Il6vebhMW9bALcNhb6ZMkOhxY4Awy7jqKK4dhdHVqISZiANaVhg25BY3Hl3mlBs
         iFw6k9s8NcxbTHprrwChVLca02PMBaVy2de8jHPP9J3qHuS1gtmwO0maFJSjehvnj5ui
         XfgsI8a6d5Jp8T4RDT1+nFNZ5YNJPYr4ZEoLIQ8j2jzznIs/Fjj3oQQ0EsKeh1QeH/qO
         rQkHHdw2w/Kbg+VERKuF97MStl8a1WZMFoIOErv0GCPKz8IGEnVhhULdYfJIs8AHCG8v
         rtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531198; x=1781135998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/6ZuBOG43wI0XV1LNowOZ5Qyn8haY2GSHMaGgLDZj4=;
        b=d6Zy7Hl1LmJpaL9REasOQhnjkLkw8swZo+K4NqaeLKmMCxjQTK2fWvCLKXlDgoc7D3
         yLdU2MM7dCYo4EkgHsXYqKCsWPsSbqSRQGBOWbViUo0NQhuOE9uOIfF60spR4Xw8d1aF
         VBDgyjQyG6E9Sqny9JyePTQhwgIlG37UmdqH7kojCRJPXFsYB358bw58HjHjwMiPn+bO
         j+2Z+yhVeZXWDBiUzJmTtryCsGYZ/G9ap6rxLYjEvX60Z099urrhN/rLhPYje6Il8yWT
         B+PzP16+TbGemKpRWK09/bPlNxOJdya0DKeamrUIF4kg390rbLFZwLWmcjGL/AhdwLWb
         Fo6Q==
X-Gm-Message-State: AOJu0YzscsKBrcsLhre2CZXAvpsgilA14l8eEh7DkGFrtyt7qgQY9RxF
	syBu2YuF7NHlnHOJ2W1qGhR0eUUkszfpJS/R/SdzYdQ9LHUKvKJFtJ4ZDoDc8w==
X-Gm-Gg: Acq92OGM87bOS5zVBn/s3HJbJcK40mUzwdMdN6vvxcohBCcEsu/1k7pcMf3lmlnpGdo
	DM8HhIHFro7d0nDksRfljrTcQf5oPU9+i1/0mG4NE8UoFIxGjTqqJLFDnsYaw7ddykuXJstAyW9
	AoTt1GeucjKF3TXPf27EBkREQXEVHPtvtcIrEDr/isb8NKhbM8BkQ/sVoPbHInTffDBUpvgsV3E
	bJe3Z6vXkYuMlUMUc+G7gE7fUToSyX5/ccnubIMx2AJzEzNgut81giOQ0azEYbGCBf/nKg/0Zho
	DU6fPu0A8jjTmZ9z7PZ3sf97b9nSdvsWFbdtW+q32+QLE+RgLXs6MEYQrgSZvkXBL+pkJfCgHSE
	FsuRp0UDOd91qpaRRIOxpToC3WlHscP6OZzkqdwr9mmYW9DDzTeifgkxLb2tjkBsBBCxzd/4kNh
	ro+NTGPE4A+Vzll/FHFz+J/1JmhnLlUD4=
X-Received: by 2002:a05:690e:bcb:b0:65c:27b5:414c with SMTP id 956f58d0204a3-660dc4bbd3dmr3346093d50.5.1780531198485;
        Wed, 03 Jun 2026 16:59:58 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f39fedsm2879784d50.1.2026.06.03.16.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:58 -0700 (PDT)
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
Subject: [PATCH v15 net-next 09/10] selftests/net: psp: add cross-namespace notification tests
Date: Wed,  3 Jun 2026 16:59:38 -0700
Message-ID: <20260603235947.2986110-10-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-294978-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B7EE363BFAF

From: Wei Wang <weibunny@fb.com>

Add tests that verify PSP notifications are delivered to listeners in
associated namespaces:

- _key_rotation_notify_multi_ns_netkit: triggers key rotation and
  verifies the notification is received in both main and guest namespaces
- _dev_change_notify_multi_ns_netkit: triggers dev_set and verifies the
  dev_change notification is received in both namespaces

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 tools/testing/selftests/drivers/net/psp.py | 59 +++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index f07d0becfede..78682a425886 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -16,7 +16,7 @@ from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_true, ksft_eq, ksft_ne, ksft_gt, ksft_raises
 from lib.py import ksft_not_none
 from lib.py import ksft_variants, KsftNamedVariant
-from lib.py import KsftSkipEx
+from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import NetDrvEpEnv, NetDrvContEnv
 from lib.py import NlError, PSPFamily
 from lib.py import NetNSEnter
@@ -668,6 +668,61 @@ def data_basic_send_netkit_psp_assoc(cfg, version, ipver):
     _data_basic_send_netkit_psp_assoc(cfg, version, ipver)
 
 
+def _key_rotation_notify_multi_ns_netkit(cfg):
+    """ Test key rotation notifications across multiple namespaces using netkit """
+    _assoc_nk_guest(cfg)
+
+    # Create listener in guest namespace; socket stays bound to that ns
+    with NetNSEnter(cfg.netns.name):
+        peer_pspnl = PSPFamily()
+        peer_pspnl.ntf_subscribe('use')
+
+    # Create listener in main namespace
+    main_pspnl = PSPFamily()
+    main_pspnl.ntf_subscribe('use')
+
+    # Trigger key rotation on the PSP device
+    cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
+
+    # Poll both sockets from main thread
+    for pspnl, label in [(main_pspnl, "main"), (peer_pspnl, "guest")]:
+        for ntf in pspnl.poll_ntf(duration=10):
+            if ntf['msg'].get('id') == cfg.psp_dev_id:
+                break
+        else:
+            raise KsftFailEx(
+                f"No key rotation notification received"
+                f" in {label} namespace")
+
+
+def _dev_change_notify_multi_ns_netkit(cfg):
+    """ Test dev_change notifications across multiple namespaces using netkit """
+    _assoc_nk_guest(cfg)
+
+    # Create listener in guest namespace; socket stays bound to that ns
+    with NetNSEnter(cfg.netns.name):
+        peer_pspnl = PSPFamily()
+        peer_pspnl.ntf_subscribe('mgmt')
+
+    # Create listener in main namespace
+    main_pspnl = PSPFamily()
+    main_pspnl.ntf_subscribe('mgmt')
+
+    # Trigger dev_change by calling dev_set (notification is always sent)
+    cfg.pspnl.dev_set({'id': cfg.psp_dev_id,
+                       'psp-versions-ena': cfg.psp_info['psp-versions-cap']})
+
+    # Poll both sockets from main thread
+    for pspnl, label in [(main_pspnl, "main"), (peer_pspnl, "guest")]:
+        for ntf in pspnl.poll_ntf(duration=10):
+            if ntf['msg'].get('id') == cfg.psp_dev_id:
+                break
+        else:
+            raise KsftFailEx(
+                f"No dev_change notification received"
+                f" in {label} namespace")
+
+
 def _try_disassoc(cfg, psp_dev_id, ifindex, nsid=None):
     """Best-effort disassociate, ignoring errors if already removed."""
     try:
@@ -783,6 +838,8 @@ def main() -> None:
                     cases += [
                         _assoc_check_list,
                         data_basic_send_netkit_psp_assoc,
+                        _key_rotation_notify_multi_ns_netkit,
+                        _dev_change_notify_multi_ns_netkit,
                     ]
 
                 ksft_run(cases=cases, globs=globals(),
-- 
2.52.0


