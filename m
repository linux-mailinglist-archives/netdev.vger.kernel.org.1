Return-Path: <netdev+bounces-276090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EGbHPY11WmP2wcAu9opvQ
	(envelope-from <netdev+bounces-276090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 296683B20F2
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5C5B3045265
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814563CFF69;
	Tue,  7 Apr 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffRCahlM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6D3D091C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580601; cv=none; b=jpvyfWRS2O9UPKG3l2VkJGr2dHDOT2tCRipXUz0EiL42+QlkAlpM6+yW8/dz0Kyi4Ict8RZA5JDlrsgHjQIrATJ61K3MO+R1iMXVwRetnBQv04gLR2t2sCdqk7mon/NPwlpLdWWcYjU1ocf4hwI/kg87dJ4n+57k/r48k4CkfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580601; c=relaxed/simple;
	bh=Zlm9voLeiLWhjmzCyGej3cquzSds89Q/FUS6f0Ubl64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJqH9EkzM2qliwhcW0LZ6g8mbSyRhNTTIXmU6r/jQxfX3RVcC80J/vLRY5hABeDaMACcfU2/ONRVzXfxhPB59tuPEm7cOETZiFQ5BmFfYaGTNuOHQ3H4PDFb8dKKGCOX+HfNDJY2SowrSwmV0mK90ejmBplR1U4+qbjLN4DpL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffRCahlM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b6f9a50eso1775049a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775580599; x=1776185399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOiko0erydel4neRoDYS/JnVnuCjbJBbPKLpvok65oM=;
        b=ffRCahlMlv270/VtfWey66Ak1fCyGhaUo722ggHSYtqSpRYjIz5M10EcKyuvo9+cQP
         HH2hR5dHD/YkU8lzdvHc5FfqDMZA/9LhMQZSc8uc4jGMV7LT+epb+uebi83+/OMP8aB9
         tpjnjLZIDR+k9WSXkgZh7GNwnT7FIf8L8uW+UtCqfzNLD3htvKGxI/KTfkiFhE41ltlS
         NwCnMKQHZeNUbYduyPG+tCqOVYuV7w6kNt/N94ieXox0d7wpj5YNxFSS1shTqtoIisCX
         oFwwxRstaHakkmxqfSGqA3DPD3paZZvB77KZB6hPEDxijeM6l950LZJnenkXuf7l2Gxu
         B7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580599; x=1776185399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOiko0erydel4neRoDYS/JnVnuCjbJBbPKLpvok65oM=;
        b=GyKgJR1yW+++fFc6eOBvOCGyTCNVBq3XcwTXQRpM07y51LxACDAzOqEIqz4VK41Sl2
         vPUEuDUzcvOLayjE85Q8g/+3cTpXpEsR2Xt0NPSrs9ogM2dMv3cKfVIQtZ5S9qNupTPT
         YIspGtPwjopc9mceHViVij1/6RgBFcEMOZA+SbWKaad5ZOeL8zK1/wd8rpn2YjWbmPu6
         RmZlb9TEdHqk6CoWUZDozql7Zku0hklRE+hlKw5B5O69RqpaBUzEprDtuyxMH4z9fEJA
         cjzjHaKalMrHjzNJ0B888Bpp4tlC5FZYy2ZKNw8qQ/GrB2wOb97eiqM71CjixObUG49Q
         h1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUJcrGKh160UDmsvWdiVgbcJnmbBK5W8MlHBW371GVyUz0KkqsBROBG7hXtYd1qo15f2fNvq2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BQ6m2pmehWVghernP63sl9TmbtbVcTzyBGN3Wre+aPiD9+Fl
	PZtl28g1MasBMHLw5+shb5wOzhFW+sFnYOz5Sj6TzOBRhKC58skUjawB
X-Gm-Gg: AeBDievyBh+dW1NPTTDpXFHbcohH93xTwRrokyNwe2Yh9SsN7HDikIsa+tj32Op4DNA
	8AxluXBsUSLQ0/3saI0mjgz8VhGlJK5xfZuU2GaO9V3xOiiNZG4XrSORzm6GPsNiv6C3gc8x8iv
	s7ymeRXArFfuSK3a5p4qZ35GVZ7HEjhgCj6VLG/0c88guh1MJ+RC1PrXW9kIuF9x0x7uMiednAE
	utat3aK7mnusLTi3UX3H/u42Ww7UJByIZ56sr0KEQtYBXE8zCq8lz22Vx7s0VYU5asA04/MIOCO
	3+pExkF5u9wLkPnUKFbUpEvtG/309fh7cVi/wPCDa7NdiYc5Uhp08O8EBJKfyvIUJV3Jab1yBK+
	D88fQPfcpf7oLtDKQg/Gd22ez7+dtT24mUWv8Fpmg7V+KdwAm4r9HxTvSZ3TeWH1LA9wnp0sP6U
	wK8hKDJ4D7GCjJcO2O/fTdYdiOoTKQ
X-Received: by 2002:a17:902:e790:b0:2b2:5840:80c4 with SMTP id d9443c01a7336-2b28176a79cmr199525645ad.25.1775580599252;
        Tue, 07 Apr 2026 09:49:59 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af31sm173288085ad.52.2026.04.07.09.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:49:58 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	Chris J Arges <carges@cloudflare.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Dimitri Daskalakis <daskald@meta.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: drv-net: ntuple: Add dst-ip, src-port, dst-port fields
Date: Tue,  7 Apr 2026 09:49:54 -0700
Message-ID: <20260407164954.2977820-3-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407164954.2977820-1-dimitri.daskalakis1@gmail.com>
References: <20260407164954.2977820-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276090-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 296683B20F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dimitri Daskalakis <daskald@meta.com>

Extend the ntuple flow steering test to cover dst-ip, src-port, and
dst-port fields. The test supports arbitrary combinations of the fields,
for now we test src_ip/dst_ip, and src_ip/dst_ip/src_port/dst_port.

The tests currently match full fields, but we can consider adding
support for masked fields in the future.

 TAP version 13
 1..24
 ok 1 ntuple.queue.tcp4.src_ip
 ok 2 ntuple.queue.tcp4.dst_ip
 ok 3 ntuple.queue.tcp4.src_port
 ok 4 ntuple.queue.tcp4.dst_port
 ok 5 ntuple.queue.tcp4.src_ip.dst_ip
 ok 6 ntuple.queue.tcp4.src_ip.dst_ip.src_port.dst_port
 ok 7 ntuple.queue.udp4.src_ip
 ok 8 ntuple.queue.udp4.dst_ip
 ok 9 ntuple.queue.udp4.src_port
 ok 10 ntuple.queue.udp4.dst_port
 ok 11 ntuple.queue.udp4.src_ip.dst_ip
 ok 12 ntuple.queue.udp4.src_ip.dst_ip.src_port.dst_port
 ok 13 ntuple.queue.tcp6.src_ip
 ok 14 ntuple.queue.tcp6.dst_ip
 ok 15 ntuple.queue.tcp6.src_port
 ok 16 ntuple.queue.tcp6.dst_port
 ok 17 ntuple.queue.tcp6.src_ip.dst_ip
 ok 18 ntuple.queue.tcp6.src_ip.dst_ip.src_port.dst_port
 ok 19 ntuple.queue.udp6.src_ip
 ok 20 ntuple.queue.udp6.dst_ip
 ok 21 ntuple.queue.udp6.src_port
 ok 22 ntuple.queue.udp6.dst_port
 ok 23 ntuple.queue.udp6.src_ip.dst_ip
 ok 24 ntuple.queue.udp6.src_ip.dst_ip.src_port.dst_port
 # Totals: pass:24 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/ntuple.py        | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ntuple.py b/tools/testing/selftests/drivers/net/hw/ntuple.py
index c50b76198fba..12f0d395f825 100755
--- a/tools/testing/selftests/drivers/net/hw/ntuple.py
+++ b/tools/testing/selftests/drivers/net/hw/ntuple.py
@@ -9,11 +9,14 @@ from lib.py import ksft_eq, ksft_ge
 from lib.py import ksft_variants, KsftNamedVariant
 from lib.py import EthtoolFamily, NetDrvEpEnv, NetdevFamily
 from lib.py import KsftSkipEx
-from lib.py import cmd, ethtool, defer, rand_port, bkg, wait_port_listen
+from lib.py import cmd, ethtool, defer, rand_ports, bkg, wait_port_listen
 
 
 class NtupleField(Enum):
     SRC_IP = auto()
+    DST_IP = auto()
+    SRC_PORT = auto()
+    DST_PORT = auto()
 
 
 def _require_ntuple(cfg):
@@ -69,7 +72,7 @@ def _setup_isolated_queue(cfg):
     return random.randint(1, desired_queues - 1)
 
 
-def _send_traffic(cfg, ipver, proto, dst_port, pkt_cnt=40):
+def _send_traffic(cfg, ipver, proto, dst_port, src_port, pkt_cnt=40):
     """Generate traffic with the desired flow signature."""
 
     cfg.require_cmd("socat", remote=True)
@@ -86,28 +89,42 @@ def _send_traffic(cfg, ipver, proto, dst_port, pkt_cnt=40):
         send_cmd = f"""
         bash -c 'for i in $(seq {pkt_cnt}); do echo msg; sleep 0.02; done' |
         socat -{ipver} -u - \
-            {socat_proto}:{dst_addr}:{dst_port},reuseaddr{extra_opts}
+            {socat_proto}:{dst_addr}:{dst_port},sourceport={src_port},reuseaddr{extra_opts}
         """
         cmd(send_cmd, shell=True, host=cfg.remote)
 
 
 def _add_ntuple_rule_and_send_traffic(cfg, ipver, proto, fields, test_queue):
-    dst_port = rand_port()
+    ports = rand_ports(2)
+    src_port = ports[0]
+    dst_port = ports[1]
     flow_parts = [f"flow-type {proto}{ipver}"]
 
     for field in fields:
         if field == NtupleField.SRC_IP:
             flow_parts.append(f"src-ip {cfg.remote_addr_v[ipver]}")
+        elif field == NtupleField.DST_IP:
+            flow_parts.append(f"dst-ip {cfg.addr_v[ipver]}")
+        elif field == NtupleField.SRC_PORT:
+            flow_parts.append(f"src-port {src_port}")
+        elif field == NtupleField.DST_PORT:
+            flow_parts.append(f"dst-port {dst_port}")
 
     flow_parts.append(f"action {test_queue}")
     _ntuple_rule_add(cfg, " ".join(flow_parts))
-    _send_traffic(cfg, ipver, proto, dst_port=dst_port)
+    _send_traffic(cfg, ipver, proto, dst_port=dst_port, src_port=src_port)
 
 
 def _ntuple_variants():
     for ipver in ["4", "6"]:
         for proto in ["tcp", "udp"]:
-            for fields in [[NtupleField.SRC_IP]]:
+            for fields in [[NtupleField.SRC_IP],
+                           [NtupleField.DST_IP],
+                           [NtupleField.SRC_PORT],
+                           [NtupleField.DST_PORT],
+                           [NtupleField.SRC_IP, NtupleField.DST_IP],
+                           [NtupleField.SRC_IP, NtupleField.DST_IP,
+                            NtupleField.SRC_PORT, NtupleField.DST_PORT]]:
                 name = ".".join(f.name.lower() for f in fields)
                 yield KsftNamedVariant(f"{proto}{ipver}.{name}",
                                       ipver, proto, fields)
-- 
2.52.0


