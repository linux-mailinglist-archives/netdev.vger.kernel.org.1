Return-Path: <netdev+bounces-78581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CF875D12
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396821F21E97
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 04:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB92C842;
	Fri,  8 Mar 2024 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiIJRki2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0802C68D
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871351; cv=none; b=EBTN4RtNU8GyG3LgSe7C+An/iJ08CqEVr3o7AU5YnayBc8N8z7J4Nfqt6knPwTYa9QtuNKIN59zDXUXM2mYhd95ILunGUHICWEaUk3zfoTd69+8p8owMeVzVDyl6ePqy+Ks1KmzvtyoTRNujffu4Sb3OS9ZqAuyNr8fcT+8/Swo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871351; c=relaxed/simple;
	bh=F/Qpmes2HGB6EVODxpgYogeabifpxO1cqXahOhyFwm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8iBoMuaeQahh6Oo+Viq6vDKuNRq8SyS0JjnBGFStfUcma3DalHy95Ge1Ikkx+eqeuqaAVqu7LA+WIQnUHkUMdfV7gPWYIUJcwRS73DplSJ5B7OoOrHt588XH7PM9Xk2lZ5vhvAQExICISWgj3i4Cn8NwF/a7G7ykIMiRy7aAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiIJRki2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc0e5b223eso3041165ad.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 20:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709871348; x=1710476148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RliGD4xondvaJ5HudSmz0tFa3GsMzAHhg1qB2Kwjlg=;
        b=AiIJRki2CxPoAWSropzvdxoYW7K0VHaivEGNe+F7qEra+Sd8+N0zH64sH3BxMcHJHd
         PER163J4u6kx0xfwaM3EYKVreRAV33wHOudKWkdKWmkxpNXA7ch8vIAb9jxpkT08cLla
         P+BXcnoPe0moRU2v+H/VyFLYFiEkLiGTX360z1WCGthILLfSCunExNpi0F1148fZ4jjW
         OeV4x78hQBy+cOWqAA1MXn0RQ7QiCSal1+aXG4/8FCdTgVd2u4T8Pmqu52Kih58+VqP/
         Fq3ypnrCQCRPKDsKLXqpPeLinUghXp+5cK1OrBEoxJwci75FrpT5Iyt/0TU4GnfatqRx
         vkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709871348; x=1710476148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RliGD4xondvaJ5HudSmz0tFa3GsMzAHhg1qB2Kwjlg=;
        b=KLFaxxrinOvt4QYdQIsi1rbErYzmFNNGDUwIxjLzuK6vMt20w/UhMqsvsLCwb9bv/K
         te0xKjy8MGsxdlvAdqEi850ArY2oFA4g13CCJp0UwPQ2rvDR06YH8BgS8ju1MCdOL/hg
         tIKQM5j8ud31K+R8LsZdIRIlx9IT4GPnWnRKv3oerDOVJmeoJfTai0A7i/hqBnYJqdVT
         /Img1RDSl9FYFWyWrQTIljpcm8hZLpKTvKZo4aAed5sL9r+mgC+zir3Qu42WoieRz2lX
         h8fQumnPeF7yEji0ojQi7FO6EfYWDnwNcx3s5yXsReJ6H0coBD+kMhwdCJWNGSy0EQXs
         KFSQ==
X-Gm-Message-State: AOJu0YyHY63aZtjlGQ/MRNM28ec8UfiZSKSBvtn4ZbJAVGzoXWFXX808
	d2RCiPM1CDzIA4tVXgtDp7dIiqHq5NYyEi+K9pZeOjnrOcmm/uwC1il8EBL3ojbhTg==
X-Google-Smtp-Source: AGHT+IEGn9JhE7vZ2TlQd8qFfdKgVoYb0eyyHYIuzOU5Qk/956vCEdZpo46lYlb9wEsfJXeqAtm9Nw==
X-Received: by 2002:a17:902:d546:b0:1dd:66d4:4d46 with SMTP id z6-20020a170902d54600b001dd66d44d46mr1260236plf.66.1709871348137;
        Thu, 07 Mar 2024 20:15:48 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kx4-20020a170902f94400b001d9aa663282sm15476187plb.266.2024.03.07.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 20:15:47 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next] doc/netlink/specs: Add vlan attr in rt_link spec
Date: Fri,  8 Mar 2024 12:15:18 +0800
Message-ID: <20240308041518.3047900-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With command:
 # ./tools/net/ynl/cli.py \
 --spec Documentation/netlink/specs/rt_link.yaml \
 --do getlink --json '{"ifname": "eno1.2"}'

Before:
Exception: No message format for 'vlan' in sub-message spec 'linkinfo-data-msg'

After:
 'linkinfo': {'data': {'flag': {'flags': {'bridge-binding',
                                          'gvrp',
                                          'reorder-hdr'},
                                'mask': 4294967295},
                       'id': 2,
                       'protocol': 129},
              'kind': 'vlan'},

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
Not sure if there is a proper way to show the mask and protocol
---
 Documentation/netlink/specs/rt_link.yaml | 69 ++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 8e4d19adee8c..5559ea18ccc7 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -729,6 +729,42 @@ definitions:
       -
         name: filter-mask
         type: u32
+  -
+    name: ifla-vlan-flags
+    type: struct
+    members:
+      -
+        name: flags
+        type: u32
+        enum: vlan-flags
+        enum-as-flags: true
+      -
+        name: mask
+        type: u32
+  -
+    name: vlan-flags
+    type: flags
+    entries:
+      -
+        name: reorder-hdr
+      -
+        name: gvrp
+      -
+        name: loose-binding
+      -
+        name: mvrp
+      -
+        name: bridge-binding
+  -
+    name: ifla-vlan-qos-mapping
+    type: struct
+    members:
+      -
+        name: from
+        type: u32
+      -
+        name: to
+        type: u32
 
 
 attribute-sets:
@@ -1507,6 +1543,36 @@ attribute-sets:
       -
         name: num-disabled-queues
         type: u32
+  -
+    name: linkinfo-vlan-attrs
+    name-prefix: ifla-vlan-
+    attributes:
+      -
+        name: id
+        type: u16
+      -
+        name: flag
+        type: binary
+        struct: ifla-vlan-flags
+      -
+        name: egress-qos
+        type: nest
+        nested-attributes: ifla-vlan-qos
+      -
+        name: ingress-qos
+        type: nest
+        nested-attributes: ifla-vlan-qos
+      -
+        name: protocol
+        type: u16
+  -
+    name: ifla-vlan-qos
+    name-prefix: ifla-vlan-qos
+    attributes:
+      -
+        name: mapping
+        type: binary
+        struct: ifla-vlan-qos-mapping
   -
     name: linkinfo-vrf-attrs
     name-prefix: ifla-vrf-
@@ -1666,6 +1732,9 @@ sub-messages:
       -
         value: tun
         attribute-set: linkinfo-tun-attrs
+      -
+        value: vlan
+        attribute-set: linkinfo-vlan-attrs
       -
         value: vrf
         attribute-set: linkinfo-vrf-attrs
-- 
2.43.0


