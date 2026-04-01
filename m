Return-Path: <netdev+bounces-273895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFoqMAetzGnNVAYAu9opvQ
	(envelope-from <netdev+bounces-273895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:28:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CBE374E77
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 07:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F14FA301379E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 05:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B313815FC;
	Wed,  1 Apr 2026 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ktMLcu5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBA37FF6A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021282; cv=none; b=XdsIe4tAar8WSCqAGbDuHugEhzT+uYi443fMfTZ+torBSVSgnLOU25nrONE6EFcZG81Od4G3BG9WI0dxhVWigr6L80Q/ScksXz4XNDuWBQ9UtSKMsrUTzb0Vss4K7CeyaRWceePIV7kMBLyZyvkndm4+abercpM0uuBLyzqHJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021282; c=relaxed/simple;
	bh=VD/BrkY+P9EZvzyKieGsPzn58utPMgfLt7RRVf8OBvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfAz7tziUlIjreD70MR3e3HwhAetavJ5RWNMvaBMi395QPP1WjPoy0KUQ5UU801Ni9ABsBmsTe4ZwMTuM674ThxBxWrguVJHYv/32bCofrJpzYJqx+T2AQHUGCd+tc/761j+TrvCT74w/J98lbcDDMEw4Gw9E6CiKr1scyn9Mgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ktMLcu5X; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab232cc803so31071245ad.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 22:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1775021280; x=1775626080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dtnjV/UQsHz5i0eYil7AmCFv4jaBC0RE9vTuxD9kdg=;
        b=ktMLcu5XPuPdlQoZ+w0ftcniQbvv+JariVNU6Q9c+4hnjfd7qsJzH4VG244gD0CNzD
         80QtsygCSL1rH9gUYEBMBLGasR5zc9FYK7SlsZfopXTJYlLwfWqOU/VeD1fr0PX3VuwC
         MwZq4Au2bOlLY4zxyEZAlnni5KIPcowzd9pDrBqB1jD93YldM35jpzbTazxnRasJMFDk
         628k6FP+hlHSZJxkOMGFcxreOrW/CEMv77zwtrwv7MCJ/ofnuUaJcRSeFBUcUK5GZucA
         T9AjwI6BjhSCTzGwjUj1Fkq9Q4t+6Vr2hJHi7QxTsCqqHSm91pB1pxFgk5bDs/Q6AbRF
         Dsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021280; x=1775626080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dtnjV/UQsHz5i0eYil7AmCFv4jaBC0RE9vTuxD9kdg=;
        b=magc/dMSqywia9kdY4LMJxzMZjjP7hiA+9Ie2tU8PcidgM/K8sEGpg27cashIuyZMZ
         2Y0tKjzw+9bqV/6SbNcRIiEkdiPteu2ZBmo7cp92LNr3NZP4VtcNqQBKiEgm2joBhDYX
         0rN/zUQu546aJA4Tt+teF4RMd2Aiu/yyqzHeoMjFyqA+ArztT0cH5bUH+MlHL8QyOsqH
         jS27Qp9r8Lm2l/nsFoMsenvFYDZ2TIiZSdbmcTFxbS4tdzzyBh3+7RzSdc5BiagwGFqS
         sJHB0VydhHChksH+DIzi13CqGMV9B5jtQwyAB0W++gmyOGQlLBMI3PIrytsrxh/zMrf0
         YaBw==
X-Gm-Message-State: AOJu0YxRXOBO6AkdKi8wMy3akMgfpUh+tgVk7IFyrCXCb+mSGBpuxl7H
	mRmxZLJu6hG1WpQ82OwNy2dBQlFEKjdUljgo/amoEATaxqDkvN0TYoSoFVWxS1TTGSyvXd7xd96
	uuH8FIdFeiCtlRGGpyelWcJ0MpnUO4fFTJampHeXwsA7I3JqF6EWMtuR8GaFIY3rf/ZhEAHVICn
	OyJARE30jO8F6FwNJuq815DkgbU3S0jEvK+1XRA8xuzjB+bw==
X-Gm-Gg: ATEYQzyXHNRfL15ryN5qK9GGfW4FFYMb6XB/VFr6aX7VOOtk3ejOYq1i9nK/UVxT/Gh
	4KZxKWArl9OIKhg/ciyTNZVn7Xls9wa6PZAGUL7T1S3lAQqQYH0anFNI+qtFfZo8C53reexWxyS
	Yn71MAzv5/EvRDX537EC944/KzCKQEUUsdTbzm93RwcvJcwie2MR2Cxvd7mXZMlfJutM6E8I9yn
	+efV8G2z6GU2LFbMiyREy6l40J9H8AMsEfYtqWIKbjXRUcWr7wR9kVii/+pk5o8gNdzDRAYGbxn
	dJFYwgifnCjiGIj6cRHH7e1Lt2uFxc3E5fr1lf7QjDsdh7nAGyDs62OlMcik+t9OcFZM7skCs/a
	l2OdSt0+tyaoRHi3kFGeveAkXxRcJaZg6PhaxEf/v+wXWUoeIBOAUFq/ATYb/uv2RvmFR9W8Hl/
	voctSJYX5RK04ryfLRsHa520P8OZaP29ro8+udwklLHrjyj75Z1w==
X-Received: by 2002:a17:902:f708:b0:2b2:6cab:313c with SMTP id d9443c01a7336-2b26cab38b2mr12456065ad.20.1775021280346;
        Tue, 31 Mar 2026 22:28:00 -0700 (PDT)
Received: from bms-ytl-d1-app-10-251-178-27 ([147.136.157.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266b92fsm134019025ad.23.2026.03.31.22.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:27:59 -0700 (PDT)
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
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH net-next] selftests/net: Add two xdp tests to xdp.py
Date: Wed,  1 Apr 2026 13:27:46 +0800
Message-ID: <20260401052746.314667-1-leon.huangfu@shopee.com>
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
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,shopee.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273895-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xdp.py:url]
X-Rspamd-Queue-Id: 61CBE374E77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In "bpf: Disallow freplace on XDP with mismatched xdp_has_frags values" [1],
these two XDP tests are suggested to add to xdp.py.

1. Verify the failure of attaching non-frag-capable prog to mtu=9k driver.
2. Verify the failure of updating frag-capable prog with non-frag-capable
   prog, when the frag-capable prog attaches to mtu=9k driver.

They have been verified against Mellanox CX6 and Intel 82599ES NICs.

With dropping other tests, here are the test logs.

 # ethtool -i eth0
 driver: mlx5_core
 version: 6.19.0-061900-generic

 # NETIF=eth0 python3 xdp.py
 TAP version 13
 1..2
 ok 1 xdp.test_xdp_native_attach_sb_to_mb
 ok 2 xdp.test_xdp_native_update_mb_to_sb
 # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

 # ethtool -i eth0
 driver: ixgbe
 version: 6.19.0-061900-generic

 # NETIF=eth0 python3 xdp.py
 TAP version 13
 1..2
 ok 1 xdp.test_xdp_native_attach_sb_to_mb # SKIP RTNETLINK answers: Invalid argument
 ok 2 xdp.test_xdp_native_update_mb_to_sb # SKIP RTNETLINK answers: Invalid argument
 # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:2 error:0

Links:
[1] https://lore.kernel.org/bpf/20260326124205.1a3bb825@kernel.org/

Signed-off-by: Leon Hwang <leon.huangfu@shopee.com>
---
 tools/testing/selftests/drivers/net/xdp.py | 53 +++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index d86446569f89..fe34b491778b 100755
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
@@ -693,6 +693,55 @@ def test_xdp_native_qstats(cfg, act):
             ksft_ge(after['tx-packets'], before['tx-packets'])
 
 
+def _set_jumbo_mtu(cfg, mtu):
+    ip(f"link set dev {cfg.ifname} mtu {mtu}")
+    defer(ip, f"link set dev {cfg.ifname} mtu 1500")
+
+
+def _exec_cmd(cfg, obj, sec, ip_opts=""):
+    return cmd(f"ip {ip_opts} link set dev {cfg.ifname} xdpdrv obj {obj} sec {sec}", shell=True, fail=False)
+
+
+def test_xdp_native_attach_sb_to_mb(cfg):
+    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+    mtu = 9000
+
+    _set_jumbo_mtu(cfg, mtu)
+
+    probe = _exec_cmd(cfg, obj, "xdp.frags")
+    if probe.ret != 0:
+        output = probe.stderr.strip() or probe.stdout.strip()
+        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
+
+    ip(f"link set dev {cfg.ifname} xdpdrv off")
+
+    probe = _exec_cmd(cfg, obj, "xdp")
+    if probe.ret == 0:
+        ip(f"link set dev {cfg.ifname} xdpdrv off")
+        raise KsftFailEx(f"driver unexpectedly allows non-multi-buffer XDP at MTU {mtu}")
+
+
+def test_xdp_native_update_mb_to_sb(cfg):
+    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+
+    _set_jumbo_mtu(cfg, 9000)
+
+    attach = _exec_cmd(cfg, obj, "xdp.frags")
+    if attach.ret != 0:
+        output = attach.stderr.strip() or attach.stdout.strip()
+        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
+
+    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
+
+    update1 = _exec_cmd(cfg, obj, "xdp.frags", "-force")
+    if update1.ret != 0:
+        raise KsftFailEx("device fails to update multi-buffer XDP")
+
+    update2 = _exec_cmd(cfg, obj, "xdp", "-force")
+    if update2.ret == 0:
+        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -718,6 +767,8 @@ def main():
                 test_xdp_native_adjst_head_grow_data,
                 test_xdp_native_adjst_head_shrnk_data,
                 test_xdp_native_qstats,
+                test_xdp_native_attach_sb_to_mb,
+                test_xdp_native_update_mb_to_sb,
             ],
             args=(cfg,))
     ksft_exit()
-- 
2.53.0


