Return-Path: <netdev+bounces-84706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B9889817C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23131F2595A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEA6947E;
	Thu,  4 Apr 2024 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U404crrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E22F32
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212294; cv=none; b=CvC/PCKUM1NN+4zYcjy/VcjnRKAEzdWl1HDFKnYqEJ8Oe+4bkXDyXsts3+pEsIH0fDBgY+bwWN7/1m8prI/PUmVf8iFxjM3Z4P+4jhopcrfEwZQBcJFbk2Ps+E3OzPO8E9Rsui11RIMBDAUHvD5z8/K1I4wnWd/7om8tfWemjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212294; c=relaxed/simple;
	bh=oOmlQAEORIzjAc6y2Z3qZCvryucRQZA7LJW7DZhSj9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEghydC+YMFHK3XQiErGvO60koAnJAd5AW13ujyEEKIuRnAAm7ogyaeNMJek6KjsTf8e9CKgKM6fTbQtjpYnJspjFQ50woZqZfw23QNT2c8IjhjvzUgYRIZPOw3QvENTs3Utqx9B73sY2NQkRKF+MTp+AsQCSKSD1xHb1OWF5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U404crrl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0d82c529fso5661875ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712212292; x=1712817092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtLOk0GpOhhh5hKiOm0BZsMmgrf83bWbYZ5z1KRHZOU=;
        b=U404crrlVZaL8gBFrNHBLMzsIjFph2kH1oRHsz9ly4gMPg94ewUik1THVK3raxhmuP
         We1avYuEw8PxKksfRPFPqNE3UmIFBU0DvPN2NgR2awHTCfmqq/p6wcbfWGF0HQ57gUYT
         10Mi25FUShRUpv1mVl4uk0Ltym8fcIwXDgY9CBiVPb9xx91h/62ldrip8gjbjsmmh5qY
         mA/aQnOVlRcMGGQlcptym6/Z5yMAvtMbp/7fyMCs+R6xNZ7Q4eumZgh5FePfWiyB2iTP
         77ojN/ACbgNwBYS48Hk186imUoMEH1c6kdk3fkPHI/a5W1jpL2c5slEeZpiSn6DjAQ88
         VSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712212292; x=1712817092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtLOk0GpOhhh5hKiOm0BZsMmgrf83bWbYZ5z1KRHZOU=;
        b=MFCmqsLmHQ5HPrSUEES6I7BPyIHmO4vDfSGzYBcTdreOgEpMkxdQeoiP3NTdsrYW+8
         03kGoLlYE1nNlpgbIKROzv2vg3TP+7QhlISKJxw7278ky/VgAY8Xc5S0h7KiGWbCMUUs
         LEL87EbrfWo6lQLNDkHSphaNrjwUYTs2M47gYNWOh7KSY2ReTCD5bcrOsaFkFjcZK1MI
         YZp2PwRD9hqzRIQ7zcbbD3w+q2ZV0+WIu5yhpVecmM5JPjCdOcxcdB1og4ESyhGNkarZ
         V4BD4L71NUUi38jhc6WucWYb6osKDzrdXr4bH2gDWotiCkc+2lellnFWNVDhWM/rI1vo
         0s3w==
X-Gm-Message-State: AOJu0YwMpbiNphb3YpQE05IahHleRk3VpGnzflHzVP/gzH0HTZgUJG57
	15pLXt5tmZDfkdiYJh7Tjt3zDHPltfC68GZMMvyKW+pZiAdyowM02Bm8naFUGhFJvlqI
X-Google-Smtp-Source: AGHT+IFKAqTGkVdpM3SCumMccf2hZTi/IQJroSN7bArGKqs1C6RRnZXw0i8GZQO4d65lqZeiMCVlcg==
X-Received: by 2002:a17:903:1c1:b0:1e0:e85f:3882 with SMTP id e1-20020a17090301c100b001e0e85f3882mr1788223plh.38.1712212291945;
        Wed, 03 Apr 2024 23:31:31 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001ddddc8c41fsm14429558plg.157.2024.04.03.23.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 23:31:31 -0700 (PDT)
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
Subject: [PATCHv4 net-next 2/2] ynl: support binary and integer sub-type for indexed-array
Date: Thu,  4 Apr 2024 14:31:13 +0800
Message-ID: <20240404063114.1221532-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404063114.1221532-1-liuhangbin@gmail.com>
References: <20240404063114.1221532-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binary and integer sub-type support for indexed-array to display bond
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
 .../userspace-api/netlink/genetlink-legacy.rst         | 10 +++++++---
 tools/net/ynl/lib/ynl.py                               | 10 ++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 54e8fb25e093..fa005989193a 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -66,9 +66,13 @@ looks like::
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
+    [ENTRY u32]
+    [ENTRY u32]
 
 type-value
 ~~~~~~~~~~
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index e5ad415905c7..be42e4fc1037 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -640,6 +640,16 @@ class YnlFamily(SpecFamily):
             if attr_spec["sub-type"] == 'nest':
                 subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
                 decoded.append({ item.type: subattrs })
+            elif attr_spec["sub-type"] == 'binary':
+                subattrs = item.as_bin()
+                if attr_spec.display_hint:
+                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
+                decoded.append(subattrs)
+            elif attr_spec["sub-type"] in NlAttr.type_formats:
+                subattrs = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
+                if attr_spec.display_hint:
+                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
+                decoded.append(subattrs)
             else:
                 raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
         return decoded
-- 
2.43.0


