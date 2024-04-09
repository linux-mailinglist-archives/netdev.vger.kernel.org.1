Return-Path: <netdev+bounces-86026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C462E89D4B3
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6720280C9F
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A347E101;
	Tue,  9 Apr 2024 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2p0SvTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62F7E58C
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651718; cv=none; b=PDAQotyUroo2gYfpWeTK/RB27aD0UIviBNmvtd1ngLPDdlQUtoh+YbfiVoYs3GHa7XAEXcBXsTSHT/56jKH7AhjlQ5IZiQZaTgOhCSm2S3vjBLyhHPuXQH8j8mDKEP3NqBL8oeYFnMOsMg+bHdT93rSC7a+ChwreteOyEJlAvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651718; c=relaxed/simple;
	bh=M/4Si6Fq8rAqs0PKkgx/eGtyHC04LUz2dW0jIO/upNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mM9JcdYE8n16bX9HeLnE1z7QrNTvGkEtEXO4Yk+cexcGxUCY3ToG7Iiw+2pvNH9BGpnfkCouwkmswFR+vrZKi1iIDNaFzWjoNZ5RwpAFJdQu6hnhLUr+00kZTuwSdfmwfUiKuO4FGAv9YQsbrAAt2g9oQOCyeVO7ojiQ1qhyRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2p0SvTP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e244c7cbf8so44629735ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712651716; x=1713256516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=voCUxQr70aQ7X2XcCBgPXqAgOizDkI1bsuXagCCwHHs=;
        b=U2p0SvTPf8CNW0WXHCzMBJpPMBFzPYmF0HpgDVRlThL78FxA749GL7o01SuppX3xT/
         x0wmZDDpl0Rk+Cytri46p8IgW9izN8ZqDmXIao1ThSkAFCCqo59bOvkufgVJdIGWts5X
         RfJJJFJ+jA04EVBNvjwrcv3CtXZmlt1xTh7WX995UfXbqp4ZT4f6A9eWPb6Xlpu6rh/x
         jcuVxRCLtEGKPdcBteq3+93OAmH8+cHNNpTweICuoY/Sgkqfo4nXJKUpU+BGcGuTqGzb
         kDmzfn4YNigsOkNJOTbdFDDl/2+nqZalqtQ5XXpZQW6DjKi80lW8szQfqc8TVG738y/Z
         Q9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651716; x=1713256516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voCUxQr70aQ7X2XcCBgPXqAgOizDkI1bsuXagCCwHHs=;
        b=Aftjk9+giuuy/ye+1pql60PceIU9Z4tLTzVeM8XFPwIaiNcmZxsnrXdQH0xGhprdeU
         9+0jYrRNNG4B5q2JolZYkba13NcPpb4nMLmM+nojotmiyUHMxEKyCfac7BKYwncwsphb
         m3o3i+ztpbv8atn+yr4OPTS1cb7d9ENcsvixy+suWaVnB2hcjNeqKo4insNvRdLh62Ce
         L0GxvCTx8PPdpGH/LwC+RdsIlwVaK9TjJdejhLjNRJk4uReIMh/46Ra+So/OQW5aMfS6
         gmE3+x1X24yobb2zhQA78ySZk0uRJPT5jV++Vqxc8UtNqMnlNdCbBFARfMmV3X+Nq0BO
         6sSg==
X-Gm-Message-State: AOJu0YylF/BTNMsL2UVywEf/1qNT6vUEKk+vyqJihV6fvTNTNyLOvzoe
	MuTvYs8BjsZ8aW/OsMXf+ZUoIeb09lSjT9OUwREpuChqUb7LTSZP6rwZ/jHAt5sDqNj8
X-Google-Smtp-Source: AGHT+IFI+IRDT4aGUuQabjJsQVyXsMP6fCgmB/C+zz1YiNyBIoAxzOvAvoiIzQa7Mliwgl06T8XjVQ==
X-Received: by 2002:a17:902:e80c:b0:1e3:e1d5:8563 with SMTP id u12-20020a170902e80c00b001e3e1d58563mr9050954plg.19.1712651716119;
        Tue, 09 Apr 2024 01:35:16 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001e0d6cd042bsm8464911pll.303.2024.04.09.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:35:15 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] doc/netlink/specs: Add bond support to rt_link.yaml
Date: Tue,  9 Apr 2024 16:35:04 +0800
Message-ID: <20240409083504.3900877-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bond support to rt_link.yaml. Here is an example output:

 $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
   --do getlink --json '{"ifname": "bond0"}' --output-json | jq '.linkinfo'
 {
   "kind": "bond",
   "data": {
     "mode": 4,
     "miimon": 100,
     ...
     "arp-interval": 0,
     "arp-ip-target": [
       "192.168.1.1",
       "192.168.1.2"
     ],
     "arp-validate": 0,
     "arp-all-targets": 0,
     "ns-ip6-target": [
       "2001::1",
       "2001::2"
     ],
     "primary-reselect": 0,
     ...
     "missed-max": 2,
     "ad-info": {
       "aggregator": 1,
       "num-ports": 1,
       "actor-key": 0,
       "partner-key": 1,
       "partner-mac": "00:00:00:00:00:00"
     }
   }
 }

And here is the downlink info.

 $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
   --do getlink --json '{"ifname": "dummy0"}' --output-json | jq '.linkinfo'
 {
   "kind": "dummy",
   "slave-kind": "bond",
   "slave-data": {
     "state": 0,
     "mii-status": 0,
     "link-failure-count": 0,
     "perm-hwaddr": "f2:82:f7:cc:47:13",
     "queue-id": 0,
     "prio": 0
   }
 }

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 163 +++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index e5dcb2cf1724..113ecd17c880 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1035,6 +1035,165 @@ attribute-sets:
         type: sub-message
         sub-message: linkinfo-member-data-msg
         selector: slave-kind
+  -
+    name: linkinfo-bond-attrs
+    name-prefix: ifla-bond-
+    attributes:
+      -
+        name: mode
+        type: u8
+      -
+        name: active-slave
+        type: u32
+      -
+        name: miimon
+        type: u32
+      -
+        name: updelay
+        type: u32
+      -
+        name: downdelay
+        type: u32
+      -
+        name: use-carrier
+        type: u8
+      -
+        name: arp-interval
+        type: u32
+      -
+        name: arp-ip-target
+        type: indexed-array
+        sub-type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: arp-validate
+        type: u32
+      -
+        name: arp-all-targets
+        type: u32
+      -
+        name: primary
+        type: u32
+      -
+        name: primary-reselect
+        type: u8
+      -
+        name: fail-over-mac
+        type: u8
+      -
+        name: xmit-hash-policy
+        type: u8
+      -
+        name: resend-igmp
+        type: u32
+      -
+        name: num-peer-notif
+        type: u8
+      -
+        name: all-slaves-active
+        type: u8
+      -
+        name: min-links
+        type: u32
+      -
+        name: lp-interval
+        type: u32
+      -
+        name: packets-per-slave
+        type: u32
+      -
+        name: ad-lacp-rate
+        type: u8
+      -
+        name: ad-select
+        type: u8
+      -
+        name: ad-info
+        type: nest
+        nested-attributes: bond-ad-info-attrs
+      -
+        name: ad-actor-sys-prio
+        type: u16
+      -
+        name: ad-user-port-key
+        type: u16
+      -
+        name: ad-actor-system
+        type: binary
+        display-hint: mac
+      -
+        name: tlb-dynamic-lb
+        type: u8
+      -
+        name: peer-notif-delay
+        type: u32
+      -
+        name: ad-lacp-active
+        type: u8
+      -
+        name: missed-max
+        type: u8
+      -
+        name: ns-ip6-target
+        type: indexed-array
+        sub-type: binary
+        display-hint: ipv6
+      -
+        name: coupled-control
+        type: u8
+  -
+    name: bond-ad-info-attrs
+    name-prefix: ifla-bond-ad-info-
+    attributes:
+      -
+        name: aggregator
+        type: u16
+      -
+        name: num-ports
+        type: u16
+      -
+        name: actor-key
+        type: u16
+      -
+        name: partner-key
+        type: u16
+      -
+        name: partner-mac
+        type: binary
+        display-hint: mac
+  -
+    name: bond-slave-attrs
+    name-prefix: ifla-bond-slave-
+    attributes:
+      -
+        name: state
+        type: u8
+      -
+        name: mii-status
+        type: u8
+      -
+        name: link-failure-count
+        type: u32
+      -
+        name: perm-hwaddr
+        type: binary
+        display-hint: mac
+      -
+        name: queue-id
+        type: u16
+      -
+        name: ad-aggregator-id
+        type: u16
+      -
+        name: ad-actor-oper-port-state
+        type: u8
+      -
+        name: ad-partner-oper-port-state
+        type: u16
+      -
+        name: prio
+        type: u32
   -
     name: linkinfo-bridge-attrs
     name-prefix: ifla-br-
@@ -1716,6 +1875,9 @@ sub-messages:
   -
     name: linkinfo-data-msg
     formats:
+      -
+        value: bond
+        attribute-set: linkinfo-bond-attrs
       -
         value: bridge
         attribute-set: linkinfo-bridge-attrs
@@ -1754,6 +1916,7 @@ sub-messages:
         attribute-set: linkinfo-brport-attrs
       -
         value: bond
+        attribute-set: bond-slave-attrs
 
 operations:
   enum-model: directional
-- 
2.43.0


