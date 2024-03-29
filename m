Return-Path: <netdev+bounces-83188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B58913EF
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 07:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933471F222C2
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5483C482;
	Fri, 29 Mar 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlAnn09j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB23D984
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695278; cv=none; b=BAApEYLRVjlbib1j5JFN2OaRuLPG6EyaIjg4CO8F3ZL+t3I+7QLZWkhIhzxx8YOdIULKCf8x24ybqGMKytl6jrDMrNMwgd1ppyYyGoBWN+mdinlL9hqZ4bTiay6lIlZcaPk1B52trHnrmv9ZGjTne9ZI6xBertwxePQ/9d8xXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695278; c=relaxed/simple;
	bh=CNQZlCUYh6uUtBWugyz6LfE8TEoG6TSskO4pMW61DrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbZB4LDUwkMxQuZQXodn5PDgLfFAdToK4ubdnkItXbRMYAnMy+j/ZM3P2yoRsGVU/MHR5OATTmMnPaLY7v+sQvmGiASthdvImE+/tiSBR8+XFJ35IjVvsXb29LsYmnxI6mvyEX33K2paaQQvZoP3/QAl1leWleHHtFkkBgXUO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlAnn09j; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6fb9a494aso1509195b3a.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711695275; x=1712300075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYHX2R3hemhMx/vn2+vN9n7DMd//UCgZgAPcnQkEfC8=;
        b=YlAnn09jdOMcPaptACvy4QspXaMTLJzBVSC38McsYilTQcexH3ZueML3B5fiF5+rl6
         gQPsAueKT/lxbaqmMvafKQ4VWHQBuj18+BVDJUQZoHPjJN6w6bsGd/M1Eb1V03BsusAQ
         ol5ba0+5paxIsIMacsHtKtXN4fgcoWeKDEjyUbf2Qe/Den57VAmVINMeqA+5RUVZj6uI
         58z/be192y4vrUyvmGkgw+0mj3RrbFJrpf3cgRcs6W3DwUXExmhTz9LzReWBjn4q97Fy
         o20ZiBroTmPdQwIlVAKGSikOcMZE6PJ2hWqF/Wg6LCMvPESLRNOUj+Mj/xblbvdqTaOE
         VAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711695275; x=1712300075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYHX2R3hemhMx/vn2+vN9n7DMd//UCgZgAPcnQkEfC8=;
        b=t0xXJh+A549GhQ+m60frgpzEFd+wx8dJW0a2Y241mwV4AClJddWZr6+JIbOOrAHMXM
         qoQeCscnCHAN2boMp5OSiEu9+6l769P1+pce1nXnd5hnhhtyi1nEqTTtqRmJxdVJqT1Z
         xea2IXWLHQAz+WBAjLAuyQhDXGOevNrwfxLpkNLc+kD36ZIr+qwXBN1LZn/bXMwQ/VRq
         qwOuJNbDlGKza/Bg3Nds3kfZ8HfWWgM+Yf85mqtTtLQOrBni0KO6pvtKZwL05PUHcWOd
         CeEgAWUuRfQ+w/CWKQbY1adgFG/kTCCd4DB3ZaiLIaTS5CQ60QQTSk4s4afIWZ23uYr3
         C3zw==
X-Gm-Message-State: AOJu0Yx2xCz81SRSmgwu58J+91oOUnuIO5n+iQ9ttHJsAbD9PN4cxe/G
	cpUeomhwVp1bpk/nuBpYpRbM0bvBcIoDBWBGsVw0hORGn57XKW0Sw+5N2Gdxx8sgZhwV
X-Google-Smtp-Source: AGHT+IH5BdcvsvQjOfor89MW744Zd/WsKOHGWf7NzSspiFEVuRotSHRsrCvqfNofdEi+unhfbqQHEA==
X-Received: by 2002:a05:6a00:3a18:b0:6ea:babb:f9c0 with SMTP id fj24-20020a056a003a1800b006eababbf9c0mr1586468pfb.16.1711695275518;
        Thu, 28 Mar 2024 23:54:35 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79dc8000000b006e56da42e24sm2423251pfq.158.2024.03.28.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:54:35 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 2/2] ynl: support binary/u32 sub-type for indexed-array
Date: Fri, 29 Mar 2024 14:54:23 +0800
Message-ID: <20240329065423.1736120-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329065423.1736120-1-liuhangbin@gmail.com>
References: <20240329065423.1736120-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binary/u32 sub-type support for indexed-array to display bond
arp and ns targets. Here is what the result looks like:

 # ip link add bond0 type bond mode 1 \
   arp_ip_target 192.168.1.1,192.168.1.2 ns_ip6_target 2001::1,2001::2
 # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
   --do getlink --json '{"ifname": "bond0"}' --output-json | jq '.linkinfo'

    "arp-ip-target": [
      "192.168.1.1",
      "192.168.1.2"
    ],
    [...]
    "ns-ip6-target": [
      "2001::1",
      "2001::2"
    ],

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../userspace-api/netlink/genetlink-legacy.rst       | 12 +++++++++---
 tools/net/ynl/lib/ynl.py                             |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 1ee1647d0ee8..d43b9d802527 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -66,9 +66,15 @@ looks like::
       [MEMBER1]
       [MEMBER2]
 
-It wraps the entire array in an extra attribute (hence limiting its size
-to 64kB). The ``ENTRY`` nests are special and have the index of the entry
-as their type instead of normal attribute type.
+Other ``sub-type`` like ``u32`` means there is only one member as described
+in ``sub-type`` in the ``ENTRY``. The structure looks like::
+
+  [SOME-OTHER-ATTR]
+  [ARRAY-ATTR]
+    [ENTRY]
+      [MEMBER1]
+    [ENTRY]
+      [MEMBER1]
 
 type-value
 ~~~~~~~~~~
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index d088bcbcadec..4c9caba4ebf9 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -594,6 +594,11 @@ class YnlFamily(SpecFamily):
             if attr_spec["sub-type"] == 'nest':
                 subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
                 decoded.append({ item.type: subattrs })
+            elif attr_spec["sub-type"] == 'binary' or attr_spec["sub-type"] == 'u32':
+                subattrs = item.as_bin()
+                if attr_spec.display_hint:
+                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
+                decoded.append(subattrs)
             else:
                 raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
         return decoded
-- 
2.43.0


