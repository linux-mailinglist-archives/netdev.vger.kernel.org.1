Return-Path: <netdev+bounces-275533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNhwMVlg02lMhwcAu9opvQ
	(envelope-from <netdev+bounces-275533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:27:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D33A1FFF
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 391F3300FEC0
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C2361DBC;
	Mon,  6 Apr 2026 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="fhl4ULzz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB43355F42
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775460436; cv=none; b=LzQQAuw7PfAvCoaaSkAi5H2m1lvAPnOnWKh9yx+TcUVWC84d8Ui1LMKhgGEgkV7DV+P0mrAng2YO3Hv6IF4IQbl4EsF4Fa5WNwCLg4hOJiNQkqXrbp6ARALcPY6g5+zY2UilnJoW3FD0IlohbBS5z3zxc4TkyA8+aCdfhvV7Ywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775460436; c=relaxed/simple;
	bh=5xf2bbceAjrL9Kn0yXbZUdc9u2qLSvuJAqr0yCPb/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1fKCacCkZfvlD9HqDnULdi3Um2T5y9FWy1ibyLjqHvw3jD49vhPLJQLqlAqKESn2V5s89iPvKF+RC0vwQQjB4bPDIqjRFZzDnwTbuTDkIE85+9hoPLq1Luz5cZko/MeCaQyWbbAyPijRjvtRAK1gSqNhNPluUY9DNnxku9zkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=fhl4ULzz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2269283a91.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1775460434; x=1776065234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+l8xdJ81rnHVCDBCC4cOrkEDKbX4zpmL1qqNzt32Zg=;
        b=fhl4ULzzM3JxbZouxPkKN/7rTjYPN3YEpC3ZB6OYTyX4Eb7eWdz0InUBJR2eUpHwBT
         GM9n+s2IF8A8NQVlD4smGaMYzKRMZyryUeJCwH9cr5CXCNOTL/oJn/c2MLV5NJ8MsnH1
         iGWWSCazM5+HYYH5YwgAqQt4dCjkwGCzGeYbQMoF7dlr5z2fJvhglH6j6TV1NdLvJBFo
         lDoav5ssTuxyaOwadCG4QEu0zGH3Oqc/GNH96JjwPpBDcfKQKIAgOlVFn+FDSV0NbiPN
         HL4dLsekBNrbAKSdbSxN9NCMwQQgP6JUAzECK7g6yZZfhpa0F9avoVHZrnmph4zfBLF3
         BKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775460434; x=1776065234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+l8xdJ81rnHVCDBCC4cOrkEDKbX4zpmL1qqNzt32Zg=;
        b=N1N4gXcDC4g9gdJhwf7ElI9K0Bf6IHxX5ZJLTDFBOt93BGzV0I8rLRDnO3dUJxau8f
         ZuVWuB3Qe6nlMU8z+YB0ZETC2IaI4aLHs3YSVhrfgLPRuySyJni6VEpDdz0gSUytMUfd
         VDgtl5RvJZX+VwcSk+Yo4roadezsRIMH6gfHgrHOzaLzuhNF8MGs1pgtZyNlDmAPey34
         jaTT494IKaupTMIlayDbFiLiSOPfiD6AepzPta09MIBAfPoO9pLV+B6OR1h2+hqtTeBd
         0Rs9o14T0zPObRK/Yr4KO03z/DaSqCtgMNPcX33SC8aVeTqeMwChQWafPC0XNWwdml3D
         SeKg==
X-Gm-Message-State: AOJu0YzaMCh7eiMKGNRbR5fdpWqi8U74CCpGk2Jch8tgItiC3ynhhwh3
	DWO8evXinTR5Bnfy5OD/OjiqW/zn8sBmm3Kwfs4ibDpztWZdG2QcQ1apckwChrvJRyrmAkh5PxK
	OCly/iGxh9dfwhX3Di30uv8p/ExV4fl2CcJMIhhZENv5PZKqhbxNwrYfTm9qKLpOLUaIatdSl/R
	u5OMA3bQMdUl7t/LnAyOfu/LG7VsqfFT7zL+YL+iEYcEtZew==
X-Gm-Gg: AeBDieuIgWzILxuP8eZrreYQeo5LbFKi89J/nDcdfBbDIF2LZCg63cqF/s2dKZgBbJ+
	e9JZLoe+gZwIxoRxxnDUGmZgODUAaf6K4bAi6iHYRS7fe84WUx0SO9ctm3Idtotn3Ei0T6usPlq
	Mw+o3od2bmDvN5zOiqGrvz7VeyzAbVkktZG3EsrQCURISOotVRbnDyTwlaeTQaH8PdIAmJqEp8N
	ySXMeXBTPKkaZGQIx/scfmnOEqUPvWEtxU6Mw6Wp4JjdrDkbSBF0T28cRMNU8Pgb5wK/Hg8z20T
	FSaY2vSRhK0L3cO+3sYLwBYEE55/IsoYCAWqpZZuIOfZmr5rsbxVaYmJv2CIE5vgKXEM6UFejUJ
	isyq30CmAz0cyY3qPWUeij1FWqcjcDAhfR1iumRRG74/0D2S8slAOXGrHMxs0j5xYwX0NkOFxla
	dFtzLAp0ydkUQ6m7oEH2hbPkEu83SOGqyIbfEkptb6g2DcsPalgA==
X-Received: by 2002:a17:90b:384e:b0:35c:d01:d3dc with SMTP id 98e67ed59e1d1-35de68ec479mr10327576a91.18.1775460433873;
        Mon, 06 Apr 2026 00:27:13 -0700 (PDT)
Received: from bms-ytl-d1-app-10-251-178-27 ([147.136.157.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd367bf24sm12920937a91.9.2026.04.06.00.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 00:27:13 -0700 (PDT)
From: Leon Hwang <leon.huangfu@shopee.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Leon Hwang <leon.huangfu@shopee.com>,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH net-next v2] selftests/drivers/net: Add an xdp test to xdp.py
Date: Mon,  6 Apr 2026 15:26:54 +0800
Message-ID: <20260406072655.368173-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[shopee.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shopee.com:s=shopee.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,shopee.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275533-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.huangfu@shopee.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[shopee.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,xdp.py:url]
X-Rspamd-Queue-Id: 289D33A1FFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In "bpf: Disallow freplace on XDP with mismatched xdp_has_frags values" [1],
this XDP test is suggested to add to xdp.py.

1. Verify the failure of updating frag-capable prog with non-frag-capable
   prog, when the frag-capable prog attaches to mtu=9k driver.

The test has been verified against Mellanox CX6 and Intel 82599ES NICs.

With dropping other tests, here is the test log.

 # ethtool -i eth0
 driver: mlx5_core
 version: 6.19.0-061900-generic

 # NETIF=eth0 python3 xdp.py
 TAP version 13
 1..1
 ok 1 xdp.test_xdp_native_update_mb_to_sb
 # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

 # ethtool -i eth0
 driver: ixgbe
 version: 6.19.0-061900-generic

 # NETIF=eth0 python3 xdp.py
 TAP version 13
 1..1
 # CMD: ip  link set dev eth0 xdpdrv obj /path/to/tools/testing/selftests/net/lib/xdp_dummy.bpf.o sec xdp.frags
 #   EXIT: 2
 #   STDERR: RTNETLINK answers: Invalid argument
 ok 1 xdp.test_xdp_native_update_mb_to_sb # SKIP device does not support multi-buffer XDP
 # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

Links:
[1] https://lore.kernel.org/bpf/20260326124205.1a3bb825@kernel.org/

Cc: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.huangfu@shopee.com>
---
v1 -> v2:
- Update the category in subject from selftests/net to selftests/drivers/net.
- Drop _exec_cmd helper.
- Recover the original MTU using cfg.dev['mtu'] (per Kuba).
- Drop the unnecessary shell=True arg (per Kuba).
- Print error using ksft_pr (per Kuba).
- Drop the sb_to_mb case (per Kuba).
- Skip test when device supports sb XDP with mtu 9000 (per Kuba,Gemini/sashiko).
v1: https://lore.kernel.org/netdev/20260401052746.314667-1-leon.huangfu@shopee.com/
---
 tools/testing/selftests/drivers/net/xdp.py | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index d86446569f89..864ca4097b87 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -13,7 +13,7 @@ from enum import Enum
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_ne, ksft_pr
 from lib.py import KsftNamedVariant, ksft_variants
-from lib.py import KsftFailEx, NetDrvEpEnv
+from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import bkg, cmd, rand_port, wait_port_listen
 from lib.py import ip, defer
@@ -693,6 +693,31 @@ def test_xdp_native_qstats(cfg, act):
             ksft_ge(after['tx-packets'], before['tx-packets'])
 
 
+def test_xdp_native_update_mb_to_sb(cfg):
+    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+    mtu = 9000
+
+    ip(f"link set dev {cfg.ifname} mtu {mtu}")
+    defer(ip, f"link set dev {cfg.ifname} mtu {cfg.dev['mtu']} xdpdrv off")
+
+    attach = cmd(f"ip link set dev {cfg.ifname} xdpdrv obj {obj} sec xdp", fail=False)
+    if attach.ret == 0:
+        raise KsftSkipEx(f"device supports single-buffer XDP with mtu {mtu}")
+
+    attach = cmd(f"ip link set dev {cfg.ifname} xdpdrv obj {obj} sec xdp.frags", fail=False)
+    if attach.ret != 0:
+        ksft_pr(attach)
+        raise KsftSkipEx("device does not support multi-buffer XDP")
+
+    # Verify updating mb -> mb program works.
+    cmd(f"ip -force link set dev {cfg.ifname} xdpdrv obj {obj} sec xdp.frags")
+
+    # Verify updating mb -> sb program does not work.
+    update = cmd(f"ip -force link set dev {cfg.ifname} xdpdrv obj {obj} sec xdp", fail=False)
+    if update.ret == 0:
+        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -718,6 +743,7 @@ def main():
                 test_xdp_native_adjst_head_grow_data,
                 test_xdp_native_adjst_head_shrnk_data,
                 test_xdp_native_qstats,
+                test_xdp_native_update_mb_to_sb,
             ],
             args=(cfg,))
     ksft_exit()
-- 
2.53.0


