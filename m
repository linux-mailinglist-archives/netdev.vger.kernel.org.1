Return-Path: <netdev+bounces-296782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yLDNKOJRJ2oguwIAu9opvQ
	(envelope-from <netdev+bounces-296782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:36:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F043665B2EC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:36:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=odTp+P8q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296782-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4E3830488D6
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D878308F0A;
	Mon,  8 Jun 2026 23:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28645039
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961492; cv=none; b=uy8mpFD8AjndxdeR6R7e1UW8yLazXZZtBw9+2stG0b/3twBmfYgtqdKXaELUR0cN9zbxOSuF/Y15jbuEnvq+BafXPqF7z3fH7LrI6zWPisyXXhhlWa2kggDTaAIlMmaO5U4o2JKl6VMx9pW2zDAMyGFGusAdjVfZUJA4CiYcA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961492; c=relaxed/simple;
	bh=OErfIgc93WlBaUA2iuv+WTpy5wJtOQ9r0WlgINcLtEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXkgLx5rv+ClPofOAqQIzrTkjagQug7ZBJ2IXFqn7fzEe6MToCbYt5LI3PKi/J1QfX6DHEsFDxFDzkqgnawoeDvLvJHMxbPEwdcJtwAKTNmCmRrmLktg8/+NsoxfIv7+5rB5RUOtE0FmmOnjdKuN8f+FDsz/dKuxPHNrrHSDNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odTp+P8q; arc=none smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7efc32aa7f4so2497997b3.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961489; x=1781566289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuOyWu7GAMrOBDVop0nviq2ForKgH/hmskraDlWmRns=;
        b=odTp+P8q9jTWWRyd5CSnbqxzezi2mUQo41sPxPoOMxm1Gc+ZfMjUiuDtjEBAH+wQ08
         uZt+ZEhkO+egWDepgRd77//Vf67QeOyWX6VBnQ8lAkFY0jWnB95BevySVp9S0Mawz2oU
         RrDZGsxc11d8BcBeAhESHivRoWHBFS49bTRU2eYfNv0t6VNX5Lyi45C6DMcbHxWPw75f
         T+If5N9KBEwAeJof52TL0Qx2HV1Udfj+vo3PYUl7IT7eHEv/gCXpbbBeeVZ1jKBXZnql
         UnY2hoNjEiRikaM7C5EqXlLda4L7O6hjp94O7bq0wTKuCET3sYoGxAbFg99ZlA65uO/n
         EEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961489; x=1781566289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tuOyWu7GAMrOBDVop0nviq2ForKgH/hmskraDlWmRns=;
        b=kQj6skHLjaCOWxBdpp6F6oOZoNBeigsWeW0AYY/kx/Im0C5EwSxNiFed2+lGlm8ECw
         Tz2W9n7bpkX14KjQOOc7WVkgtRZPL6XXIB5qvqEBlcgoDO5nBWjsF2QOsWaJweb9jfXM
         Kwfk8X0QTKicib/zEYBlNLw1Dp9rlHixpSVNIvrTwHXSjvw68MrR4nT94i1lSMNkdVAf
         v4goBE/kkKaqZU+5Qc2x5lMksQ9vLbSeHzi1EQ75j8YVKInQ2/JgaYuty1sN7Hq37yIg
         EkYGaBHM8XSBtDlQA0KhPHPUooPwnByaYedCgXicFWKV2kmJ2Ug/9XSuP7vDmSJs+8o1
         yF0w==
X-Gm-Message-State: AOJu0Yy6hhEU0OpHeKrmE9Sb9FNi4ih5GdXbTy6wTj8g3BO3xEhKxAR9
	WT1VG7vTyS9QThZ4VdSayo68yAw/OJDQ5XReAlvkkI6v2jLFVDvBkk3TLmFoYg==
X-Gm-Gg: Acq92OFqNXLpfzDpuHmLIoP5gKvOOt2TfxZ8Pbv8K0mUcQt8ET1svpNK8mQUK09oPfJ
	JkdLvrcKnBTG0LTJSF/tWGiV6wA8jjTnBAfZ7fzXtTTS1Z9ZDa7o7tZRPtzFU99T4k2rargoSIM
	k773NQmKYLgrrRxmhWsUVDpFhxYqAy/EODhaFadYxzTjmSVcQpLZm9BGfd5xnH+Mz8iT4fbxoZJ
	qSA1omijS+AP7X2thRDBzNiGftcLdhzne3OrRy/I/AJ/iOdb8feBt92e2281cyuSP58lk3eGrO3
	R3JxJoD5W1On1jGdAbDCwii9EqcTNMDOfxxCxsSsioAZI7rPxD4bvAyWn/zEsAT63lU8OYOEzuc
	+e3mak+SM1nc9GLTdm/zb8CPMPbnJFyNp1RoMv2PleERgrh6LQO/YAHhu41aqH0qpL65hb+DYcE
	SG0CoAaJy3UDGnSQljG3oDhx8+QzCZpLPEkqpYskf4AfuA
X-Received: by 2002:a05:690c:6987:b0:7ee:3c33:b66f with SMTP id 00721157ae682-7f2b29478c8mr2080467b3.8.1780961489263;
        Mon, 08 Jun 2026 16:31:29 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea235885d1sm89510237b3.26.2026.06.08.16.31.28
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
Subject: [PATCH v16 net-next 10/10] selftests/net: psp: add dev-get, no-nsid, and cleanup tests
Date: Mon,  8 Jun 2026 16:31:18 -0700
Message-ID: <20260608233118.2694144-11-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-296782-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: F043665B2EC

From: Wei Wang <weibunny@fb.com>

Add the following 3 tests:

- _psp_dev_get_check_netkit_psp_assoc: verifies dev-get output in both
  host and guest namespaces, checking assoc-list, by-association flag,
  and nsid values
- _dev_assoc_no_nsid: tests dev-assoc and dev-disassoc without the nsid
  attribute, verifying ifindex lookup in the caller's namespace
- _psp_dev_assoc_cleanup_on_netkit_del: verifies that deleting the
  associated netkit interface properly cleans up the assoc-list, using
  a disposable netkit pair to avoid disturbing the shared environment

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 tools/testing/selftests/drivers/net/psp.py | 146 ++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 78682a425886..315648a770d0 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -18,7 +18,7 @@ from lib.py import ksft_not_none
 from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import NetDrvEpEnv, NetDrvContEnv
-from lib.py import NlError, PSPFamily
+from lib.py import Netlink, NlError, PSPFamily, RtnlFamily
 from lib.py import NetNSEnter
 from lib.py import bkg, rand_port, wait_port_listen
 from lib.py import ip
@@ -723,6 +723,147 @@ def _dev_change_notify_multi_ns_netkit(cfg):
                 f" in {label} namespace")
 
 
+def _psp_dev_get_check_netkit_psp_assoc(cfg):
+    """ Check psp dev-get output with netkit interface associated with PSP dev """
+    _assoc_nk_guest(cfg)
+
+    # Check 1: In default netns, verify dev-get has correct ifindex and assoc-list
+    dev_info = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_eq(dev_info['ifindex'], cfg.psp_ifindex)
+    _check_assoc_list(cfg, cfg.psp_dev_id, cfg.nk_guest_ifindex,
+                      cfg.psp_dev_peer_nsid)
+
+    # Check 2: In guest netns, verify dev-get has assoc-list with nk_guest device
+    with NetNSEnter(cfg.netns.name):
+        peer_pspnl = PSPFamily()
+
+        # Dump all devices in the guest namespace
+        peer_devices = peer_pspnl.dev_get({}, dump=True)
+
+        # Find the device with by-association flag
+        peer_dev = None
+        for dev in peer_devices:
+            if dev.get('by-association'):
+                peer_dev = dev
+                break
+
+        ksft_not_none(peer_dev, "No PSP device found with by-association flag in guest netns")
+
+        # Verify assoc-list contains the nk_guest device
+        ksft_true('assoc-list' in peer_dev and len(peer_dev['assoc-list']) > 0,
+                  "Guest device should have assoc-list with local devices")
+
+        # Verify the assoc-list contains nk_guest ifindex with nsid=-1 (same namespace)
+        found = False
+        for assoc in peer_dev['assoc-list']:
+            if assoc['ifindex'] == cfg.nk_guest_ifindex:
+                ksft_eq(assoc['nsid'], -1,
+                        "nsid should be -1 (NETNSA_NSID_NOT_ASSIGNED) for same-namespace device")
+                found = True
+                break
+        ksft_true(found, "nk_guest ifindex not found in assoc-list")
+
+
+def _dev_assoc_no_nsid(cfg):
+    """ Test dev-assoc and dev-disassoc without nsid attribute """
+    _init_psp_dev(cfg, True)
+
+    # Associate without nsid - should look up ifindex in caller's netns
+    cfg.pspnl.dev_assoc({'id': cfg.psp_dev_id,
+                         'ifindex': cfg.nk_host_ifindex})
+    defer(_try_disassoc, cfg,
+          cfg.psp_dev_id, cfg.nk_host_ifindex)
+    defer(delattr, cfg, 'psp_dev_id')
+    defer(delattr, cfg, 'psp_info')
+
+    # Verify assoc-list contains the device (match by ifindex only)
+    _check_assoc_list(cfg, cfg.psp_dev_id, cfg.nk_host_ifindex)
+
+    # Disassociate without nsid - should also use caller's netns
+    cfg.pspnl.dev_disassoc({'id': cfg.psp_dev_id,
+                            'ifindex': cfg.nk_host_ifindex})
+
+    # Verify assoc-list no longer contains the device
+    dev_info = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    found = False
+    if 'assoc-list' in dev_info:
+        for assoc in dev_info['assoc-list']:
+            if assoc['ifindex'] == cfg.nk_host_ifindex:
+                found = True
+                break
+    ksft_true(not found, "Device should not be in assoc-list after disassociation")
+
+
+def _psp_dev_assoc_cleanup_on_netkit_del(cfg):
+    """Test that assoc-list is cleared when associated netkit is deleted.
+
+    Creates a disposable netkit pair for this test to avoid destroying
+    the shared environment.
+    """
+    _init_psp_dev(cfg, True)
+    defer(delattr, cfg, 'psp_dev_id')
+    defer(delattr, cfg, 'psp_info')
+
+    existing = {cfg.nk_host_ifindex, cfg.nk_guest_ifindex}
+
+    # Create a temporary netkit pair
+    tmp_host_name = "tmp_nk_host"
+    tmp_guest_name = "tmp_nk_guest"
+    rtnl = RtnlFamily()
+    rtnl.newlink(
+        {
+            "ifname": tmp_host_name,
+            "linkinfo": {
+                "kind": "netkit",
+                "data": {
+                    "mode": "l2",
+                    "policy": "forward",
+                    "peer-policy": "forward",
+                },
+            },
+        },
+        flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
+    )
+    cleanup_netkit = defer(ip, f"link del {tmp_host_name}")
+
+    # Find the peer by diffing against existing netkit ifindexes
+    all_links = ip("-d link show", json=True)
+    tmp_peer = [link for link in all_links
+                if link.get('linkinfo', {}).get('info_kind') == 'netkit'
+                and link['ifindex'] not in existing
+                and link['ifname'] != tmp_host_name]
+    ksft_eq(len(tmp_peer), 1,
+            "Failed to find temporary netkit peer")
+    guest_name = tmp_peer[0]['ifname']
+
+    # Rename and move guest end into the test namespace
+    ip(f"link set dev {guest_name} name {tmp_guest_name}")
+    ip(f"link set dev {tmp_guest_name} netns {cfg.netns.name}")
+    tmp_guest_dev = ip(f"link show dev {tmp_guest_name}",
+                       json=True, ns=cfg.netns)[0]
+    tmp_guest_ifindex = tmp_guest_dev['ifindex']
+    ip(f"link set dev {tmp_guest_name} up", ns=cfg.netns)
+
+    # Associate PSP device with the temporary guest interface
+    cfg.pspnl.dev_assoc({'id': cfg.psp_dev_id,
+                         'ifindex': tmp_guest_ifindex,
+                         'nsid': cfg.psp_dev_peer_nsid})
+
+    # Verify assoc-list contains the temporary device
+    _check_assoc_list(cfg, cfg.psp_dev_id, tmp_guest_ifindex,
+                      cfg.psp_dev_peer_nsid)
+
+    # Delete the temporary netkit pair (deleting one end removes both)
+    ip(f"link del {tmp_host_name}")
+    cleanup_netkit.cancel()
+
+    # Verify assoc-list is cleared after netkit deletion
+    dev_info = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_true('assoc-list' not in dev_info
+              or len(dev_info['assoc-list']) == 0,
+              "assoc-list should be empty after netkit deletion")
+
+
 def _try_disassoc(cfg, psp_dev_id, ifindex, nsid=None):
     """Best-effort disassociate, ignoring errors if already removed."""
     try:
@@ -840,6 +981,9 @@ def main() -> None:
                         data_basic_send_netkit_psp_assoc,
                         _key_rotation_notify_multi_ns_netkit,
                         _dev_change_notify_multi_ns_netkit,
+                        _psp_dev_get_check_netkit_psp_assoc,
+                        _dev_assoc_no_nsid,
+                        _psp_dev_assoc_cleanup_on_netkit_del,
                     ]
 
                 ksft_run(cases=cases, globs=globals(),
-- 
2.52.0


