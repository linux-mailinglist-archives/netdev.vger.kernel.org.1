Return-Path: <netdev+bounces-296783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I8DhAO9RJ2ohuwIAu9opvQ
	(envelope-from <netdev+bounces-296783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:36:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF365B2F1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:36:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WCtgnRPI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296783-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296783-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321EC304C069
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68743403FE;
	Mon,  8 Jun 2026 23:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCD32B13E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961492; cv=none; b=t9gvt4sYafnEYZ+K+Rb7JxkRwOOZk0JmvkCxSlo1agw2834dfaZ0m1RaH55eyI6tRjfd8jqUSi2mhlP89VeWVAiM4Bou1JUmuCddAT0bk3FSchMoaew7msdbLTJtoKKf+h/JXu9gR5JKNJADD8vtLV4Jn4Zl+u4rhY9JMR7uBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961492; c=relaxed/simple;
	bh=iJbBRl9K/I68pFQ5Sv+M/lNSXaUqcmRfL+kD5ISEqsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7zLLTF3myaK7kdaWGonY/mPl7ZQE4CxIDYvi9S7sS7YTT5rthrbylaiwX70/EuP/GvZdL7BNBhIFE6jj0Tqs9yJUEkDU6fyUmMpE/1IpbzaskhJggEG2hQmxViYiyF/uOMUeIaWojug2+NKtfYxUGrGehWr9YcnL2dUi7u/4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCtgnRPI; arc=none smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e2f345692cso6683787b3.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961488; x=1781566288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/6ZuBOG43wI0XV1LNowOZ5Qyn8haY2GSHMaGgLDZj4=;
        b=WCtgnRPIgKF2B0KHLTM6ANbgLElxckIv2QrrFU7FryMIPgaxPCnl9BCvOhoDai3HTw
         AZgXKLyGLQnEcashimoRcKfNyelnoVJYzjO4GKD0wBxdnb9eVykACvMul6u0AMn/GZgc
         CB0kpVrATeyRAjUEJKYg7NAjXDEENn8qTFt4s6FcWrfHj4mK49hbdlu44uoFUfqMxvTJ
         ny04hNrh7tRfvc40LbNHdnhpquhDAKPRxyCtFCsfnFrFFIvA9VubrQSDfpJwT4LGfA51
         1+DBGnE20hP4NlQqT/1M/DP6+k0wgZnEVgWzVvTfz70R7cjqF4N5Av85+iHHWekIfslL
         lhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961488; x=1781566288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/6ZuBOG43wI0XV1LNowOZ5Qyn8haY2GSHMaGgLDZj4=;
        b=gSL2FXwa/QqgeF/5JLRG/O+DIchjH+LFZsoc60ZvzTbiv3f7rs+X35gkp14RNN6OeF
         OQc2pXar3DiIastPOc+uEKYCmxfQZ2mF4+32CZ4QL/2HXakeWhZgRiLhy6qkLfHYw2u1
         FDtngJ8VRcsMgnaHHaIepfTdVzWSCzOE0bm3W40IyXkr0nAVU50beo/68PBGgeGR7vol
         n+57BKsjkhHaq5xljvHg9my53fMV+mniUr7ls9tEUCJMUub8rAt3iL3KVJ55oo+ceAYn
         Ox770tHswMtkPqg55OKH0c9lPOMWTbnCNy2vXLRmx1lDojHQ43Q8TGMl8U7ZPNoU6vO0
         XXYA==
X-Gm-Message-State: AOJu0Yx4rwHxgdSezTl9YMLKpGRY44/iDLqpA8GCtrFvFF4dmLdi7Pm9
	Mn4jJWhed4wZCOL0ZYFloGPQ/HR8pvx/mWfk/GLVvrfACSjd8nnHmJ+MiwxUjw==
X-Gm-Gg: Acq92OGin/8eIj1pK/aOIP6mXx4S4fkUW0zv5+TaXPwBIZavGHSwfVpfzueyhT002R2
	kTuf6VUW+2YIABCUTNQN3dgTesxpedoEjNYn6JeVvi91t/nM3EgeN6//jYlY5XZ6LvF9qAbmLkr
	HqtwFxlO3rDr0CUCVoOYLFU+nenFOUz6ZOnGUlcgJ/RYF1r7ICORdVfA7gfusrJ35ckA9rjK5BL
	mfEjfNsMpioBEqfIuTtzkh65KriRHtAAt1abKf2GlfyQe4zAkXtTx1jvEwf/9/CROqt5CWX8Kg2
	S4MD/UD8lRhoO4QyO6DR7POW9YcHyYAnz49d1cczA3m/HHpIczmI9t2qTH6uG6q919uLZe37dPL
	kcKgTA7reFMeKfkOfTtmXE6ZOtK1BTQO71XVV+pXqJzLz/lpbUCul46NlEYIO/RlUTdsXGTSEQm
	iTYVX9kY22GPgcvEHbNpvLi40+iuiKdJfc0Zzmd+QGCa+w
X-Received: by 2002:a05:690c:d86:b0:7b6:db48:2f1d with SMTP id 00721157ae682-7ed079ded73mr102078047b3.0.1780961488537;
        Mon, 08 Jun 2026 16:31:28 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7efb9b99e2dsm25436037b3.20.2026.06.08.16.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:31:28 -0700 (PDT)
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
Subject: [PATCH v16 net-next 09/10] selftests/net: psp: add cross-namespace notification tests
Date: Mon,  8 Jun 2026 16:31:17 -0700
Message-ID: <20260608233118.2694144-10-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296783-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.py:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fb.com:email,netns.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51EF365B2F1

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


