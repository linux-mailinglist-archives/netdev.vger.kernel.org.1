Return-Path: <netdev+bounces-83717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781998937E9
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B394A1C20BC6
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97BE5CBD;
	Mon,  1 Apr 2024 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvfmvp+F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2EA8F5B
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711943826; cv=none; b=uCctlBGL9Lrx1yK6r4GauzsmrgAeCgT8mnVtrKOKS+Pv88qgsiReEhl/unCtP6cyaLTwBgfPYwOZMj3cnSW28bFyPa/B1VIfAUCZj92mrpdMLc7XL2JKDYawvrik2dx23HgvHC/4fUFzoEiXGuIujIDb5GjAt5aRpHgiPJUwxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711943826; c=relaxed/simple;
	bh=05MzOygOB8XeDWrUo0PsoMbnKPguLQNiSoiSRiLQiwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5zp+P8Jq9GGYG34K6A23GFCK8rZsC3jqIZEYjuWX4/t+b9ite4gAOsypSRltPdoNHK9frJV8bVZq0kwPj85BRF5s/9uWK9nUl1jYTW/+GibHD/GxHFOqvnYyhvF6ZQlL+5hp9B8FWLhbHBbpt6EQ2hpGFGnaXY2cTOaK9Lv4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvfmvp+F; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e252f2bf23so3521745ad.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711943824; x=1712548624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2aCkdIjTfv09I4mvYheNHYeBlNlq6wZwmHsNpE3Gi0=;
        b=Mvfmvp+FW4S5dW8sE1KKpHyh4QhqnmApHf0OhzHEiUTJnCN6xsXLlqdDqCvZWZgysF
         t0aeg9q/xhb//c+O4SXqUY0nipdPPN4KmBqe6V1A58m/xDp2w4ieracdY4BgZRjEFjxf
         O449SeP2bdKX7SN7ul9Asmfhjnv/EYEBNv3jSsv4wLg/h/TpF/CAt6CJ0M9HC1Qi7EJg
         B+lEVx0c7qR6WxJaVNYFiFuopq7p8HtdSBWl7iH5Mm80LbOig6vY6oKD28+HARKYFamL
         DNuLcoZz4AB11VNfqcDXvIeoANhzuwTvlnljwyrggLIepUPvXStAU0j+PYoDSAudWBh0
         MnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711943824; x=1712548624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2aCkdIjTfv09I4mvYheNHYeBlNlq6wZwmHsNpE3Gi0=;
        b=pTyERbOtOdT8ZosBcOtTfMfehSEEEIO7E69OGOX32/1QBC4ox2VAdReHBGEsuvE+Sj
         7sooiPwqfSyuMcUk28iG3O+6Yg06TseCKUuKLi7l7Y6cBWgLOrIY3VTtQSzUkCi5LjGG
         kBAiTvOf/juarcI7AvovQQjgYSw6KISuhaNBk3XyP5ufLmAPkHQYtjXD5Yozjobg6tEo
         r3UUVMa1Un3sziSBGiw1PDj78iIQM5EYGOExuTqTL1KE4mII161ymealLNnj6xnJcEev
         iwxEEAGWzcAd0ZuMM/n/3bzMzDOBqirVeLhWtxH9qbGjs+4G5uRv0tHOHhvrZdc0pvnM
         pmSQ==
X-Gm-Message-State: AOJu0YxKspNy3HwyPMlJwq+Giib1Wr5Vb2amsIxhjZtesVZis6IwQgKm
	CYWWKQCZ/DZb3a2EmRlRwWz1jEoe1eoRoKy8ve+9dv9LO6jkTGbkWM+ueT+7RTPN5Q==
X-Google-Smtp-Source: AGHT+IHVN/7lJ9WEfdSo92HWyLlboySD00oHdUVQ+oaUGzNQrZbIrU4V/dNz/kcL6dOMYV54GXQ7Sg==
X-Received: by 2002:a17:903:230b:b0:1e0:f473:fd8b with SMTP id d11-20020a170903230b00b001e0f473fd8bmr7740471plh.9.1711943824180;
        Sun, 31 Mar 2024 20:57:04 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902b40a00b001dc486f0cbesm7660143plr.222.2024.03.31.20.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:57:03 -0700 (PDT)
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
Subject: [PATCHv3 net-next 2/2] ynl: support binary/u32 sub-type for indexed-array
Date: Mon,  1 Apr 2024 11:56:51 +0800
Message-ID: <20240401035651.1251874-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401035651.1251874-1-liuhangbin@gmail.com>
References: <20240401035651.1251874-1-liuhangbin@gmail.com>
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
index 54e8fb25e093..6525ef6ca62f 100644
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
index e5ad415905c7..aa7077cffe74 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -640,6 +640,11 @@ class YnlFamily(SpecFamily):
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


