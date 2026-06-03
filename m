Return-Path: <netdev+bounces-294979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OSngHYDBIGpl7gAAu9opvQ
	(envelope-from <netdev+bounces-294979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:06:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6263BFBE
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:06:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BtZKbW+8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294979-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294979-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A9630C9384
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054D4DD6E4;
	Thu,  4 Jun 2026 00:00:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6E4DD6DB
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 00:00:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531201; cv=none; b=jPmzUKgSpdmC3gGy2P9Qb2vEUECjc7X1xiVQLuFVst/lYBTZLVPVnvwcNUOSf/HoAW6phC8Ujalfqc57sKNUK9uRP47l3UfAPWCmJg/AxCV0sv9N7AOuMVZQWp2t+n7eZ2z2itDec1RSxS/EyLVPmTGbnq+0ytA/RTwSt1SUZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531201; c=relaxed/simple;
	bh=OErfIgc93WlBaUA2iuv+WTpy5wJtOQ9r0WlgINcLtEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1cJLM9ygyo9OnZbeA5mDHnbY1fxMhZu77dpkmtcY1Dd3jv8btLPwR24uqbvkt4ejM3A4QoZhKfzbnzYiKU+FPhFybjudrXP/55Fg3u8sivs1i+HE/eAghaWm2EhG/Q0ZQd33s40pbSnk0whPDRoM9e+0tWpmkjLnggDpFGr/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtZKbW+8; arc=none smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e3069c43f9so145567b3.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 17:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531199; x=1781135999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuOyWu7GAMrOBDVop0nviq2ForKgH/hmskraDlWmRns=;
        b=BtZKbW+8gCCmuOuSXxX2HOfDBpOnwVMel4H/+6MoyZHkjK8RmEpu/PRBP3kSMQ71PY
         jKvBYsaxjUIfsgvhEilIEJS2lwcq7qaCOSjPw5WYOnK4ODxDDyZhtv5RGAfcir1pCUq5
         84Uj/6sx+0HXaO3GN8W6xKWMXoM2s994ugpu3ApJ7/Sr8GtjeFKuK/UszqCP8kMhdlhv
         n+eajpkTOHC7nV2CCvUi8kxS6QVNJHoTNbywvT83Y68FivTqMd2BccbIQFZVdq3gN5bM
         cKycSpeTNts4Pp0OU9qjOc1X6RSSglIqxJsOiWerG9XNdnWmknuO7lkSbDf8C1u9WpKx
         hAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531199; x=1781135999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tuOyWu7GAMrOBDVop0nviq2ForKgH/hmskraDlWmRns=;
        b=XD5VDkqyk/mwAh0rBQ3dnHJsEjPEslnb7sCTj3eVCvE9QB/VWrE2GWRcivV47g7eBe
         ut5vwNCBmGops8fitBHpwNFH1igUeX86vwBnycPXCXafe46/NtG7p+TcFWOtQcNeY4Ix
         HtfXmt3IDMLEUVV0pdltEmGy8l+HTd2nbmlMX9D9Xiloud5rBhpzNaSscvGR3bkvyEBM
         4Nzk+XkZN3GplhpRiiWjfwlDPbUqMpM8UVn0uGActLy6IHz1mEfT5YLfVpIll3Z6JFDM
         hqvSxr41oqiWw3UT8ishV9/yI2pbHIr7m7ESSRKv3AtcJDAotZq/u7vsCx7dVziEniI5
         vJvg==
X-Gm-Message-State: AOJu0YxYk2YywhKICC+4lA9zvMvbX7Ez8kbnSfccQYJ71a35+HxTCrGX
	eEJwKf3J4gBCWuft/MU2naau5eSig+D+rek651RQMZjp2tiZFlOsu3VqlixKuw==
X-Gm-Gg: Acq92OHk7c9oudrOdIn6cATtp68SE2QblsjfEq/7YdrlgFMTOOhamwKp6X4Gj0VN1M9
	lkZWoxGMMr3hksjWjlySvbx0C2Ftl632VCx7e9skEGbBztFXGu4fR0rXqhk7dA2z5ymXfqjjhK6
	DypnTNnh/N2NRU6Rpa6j3zxzeYFfJACKyggi6th2LwnonNVEMJErlaH+OpE7hfr/inwmgodCKst
	jjz3JABS57127nGstrkSDWlGEt6JZpUbaOzpQ7ua8QHw3vH/Mbx0envlM2J/3oNDLM+sIWSnhTH
	ofrYN9m8et1XO+yUaL2DKSfjjqqtBS8KvAtkwoob05IN/W4Lj65acxWP0O0XdVBAZ3jitbxkYcQ
	KqiYtOn49k/PNQxMPoM5fmubY8c23Vl+xtjxe21DaQLq2bPwwS2quv4+vEjORRQbmruLKdfHK9S
	AfkOH331OxbXOKggX4lOMXXczzcE7EWQiLUA==
X-Received: by 2002:a05:690e:1c1a:b0:65c:124e:61c5 with SMTP id 956f58d0204a3-660f40a5e61mr295898d50.0.1780531199138;
        Wed, 03 Jun 2026 16:59:59 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d6488b1csm2878847d50.19.2026.06.03.16.59.58
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
Subject: [PATCH v15 net-next 10/10] selftests/net: psp: add dev-get, no-nsid, and cleanup tests
Date: Wed,  3 Jun 2026 16:59:39 -0700
Message-ID: <20260603235947.2986110-11-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294979-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netns.name:url,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9B6263BFBE

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


