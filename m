Return-Path: <netdev+bounces-67928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB9584565C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE101C23D48
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1415B964;
	Thu,  1 Feb 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmdfw2i3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0315B970
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787543; cv=none; b=PNFr/1cVafQCg7ydf094KjtaGaJ/loQbYh65EP4hhQgx/Hv0WUgmUlA8VWrh7jNqEaEif4U8EwSzoQP3Yp87GkdAHiQl0xFRsYIXQldk+PwusqfKwECEa2OWy7WDa3NI/50mL7iC2bzT9nfO+Cv1CdUw5fWDMNsSy/ElWKc55EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787543; c=relaxed/simple;
	bh=3vHeayZEbAbMgt7QSeUkT88j6xc/dSU8VgnDyK+86II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otIXJG38+98vUbsNBWXTq1iVhqZ06jYhsnM/tuIzLayBa0uNXXn7pSKusFKpFgGzyaNEDbW9d90R55b8V6pgxtsIskehSIbaEhWHU3Up/4spgEgvA44wjTcONXZ27jd1+dlOu2D9TNd4t+/Z3JwquCUbuqSeyRLO9nsvwLSCsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmdfw2i3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ee9e21f89so6957695e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706787540; x=1707392340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIIEo1ySOylzpUnHqqfp3SRUyd0L6eTzuJgA2Oh/R6w=;
        b=Jmdfw2i3YJnSGW3m8bucknK6wF6YcfqZ0H9zNdb+6mpyW5NvYsGXm3QbvLspeU4LdC
         WFvKmcczk522IDpV6x0IGshIIDvfCxctpbUhkJlAbOs0OuIY0vfeBqp/2CHisd7iBCy/
         WmsOBLXJBnlTXI/edpxmZZ3xvriJLSr1stdXQyLuB7xHWwqEIEJ4/qsZNW1fNalcoPmM
         JASbuSY11TLRSpSDQMm32NnyT/+VNUmQoYllpybF2G0B84vfHTxx2kb9vMNNLLslggvw
         2/LAxEsWstSHXEL6aD8GTSq10utiAP/e5ZJDO2px3XivgUZBIMMZ1HyWBShJUlLpERXP
         rolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787540; x=1707392340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIIEo1ySOylzpUnHqqfp3SRUyd0L6eTzuJgA2Oh/R6w=;
        b=QSCqGB2uqjdfmjx8dcrz3P+ZdMxikJciTSXV5FIYoS4bn8EXlG3rNTnU5YfIH5lMqw
         9gh5MC78tikKNWJppiiopDXX4GJLgc6MR/c1vLYVv0KPRIZaq9aOP5b8pCAOfiAxhZTM
         p7d2ao7ppf7v1Z53vYTROnn2ZFS9RAQfSIRxo23kAsDxfNCrT5Jsxo+qUS3vH4VspfEF
         6TPQqxUMCanLHwBp7e0ctfNCnXb1y6LkJp944TSgxqS+tPhWG1gzq7sMkTsBS2zCh6eP
         VWe835PVrGYQdWDM6WjJ3fpvCrLQfKAxwpHcMPLbIxUk+x4Tz3ume+WcmxhIyyp2f/3m
         KmwA==
X-Gm-Message-State: AOJu0YwdIZxa0sTDq/a8KzTu+qN86P+mQ+cCbE7puIc/nxYuoLmPVO4Z
	7vgBduJDayAAMkaHH0bMQMJvjdqkXJnCHkFkh34aSNzF2KACnRerAmTSjbDldaM=
X-Google-Smtp-Source: AGHT+IFx3rneWPBtrHPXX+vzyhlTw2Up+/Iqu0gqPc69Ejz/FbVKzFCLnM3QKRytW85YaBm7tILSDQ==
X-Received: by 2002:a05:600c:35d3:b0:40e:f557:738d with SMTP id r19-20020a05600c35d300b0040ef557738dmr1486854wmq.26.1706787539449;
        Thu, 01 Feb 2024 03:38:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVEoQVu1Ka/Eo7W7F5Voaq8aUuLkhd3jG2W+XQzrPmlamJ88hNA2WH7Km+QT9qE5Ki8j4K5YAQOoGm3ghdbDhxVeYks90b5smQCywplvme8qBEw9GhV29kwFYbpO7zdFf/Dk8/8srgJUzo7fGsT7c6cuW1myk1qxScG3BArlrwKWkC9xV9MLKGqshXMF1FZpt8eRF5pKVOswyOKh67f2Ky5T1F7/H+1UPHrZZbjbX3sPosNqFO2oh0QXT2uqHdaxPuh46dilbwPvgL/V/CkbR/IXtQzoT0y94laV9L5XafkCfoFYNbcQWs6u01cAI4GWNN6e4lJjw5pFDUbYSQ=
Received: from imac.fritz.box ([2a02:8010:60a0:0:e4de:af88:4153:20eb])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0040e3635ca65sm4228607wmo.2.2024.02.01.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:38:58 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net v1] doc/netlink/specs: Add missing attr in rt_link spec
Date: Thu,  1 Feb 2024 11:38:53 +0000
Message-ID: <20240201113853.37432-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IFLA_DPLL_PIN was added to rt_link messages but not to the spec, which
breaks ynl. Add the missing definitions to the rt_link ynl spec.

Fixes: 5f1842692880 ("netdev: expose DPLL pin handle for netdevice")
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt_link.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 1ad01d52a863..8e4d19adee8c 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -942,6 +942,10 @@ attribute-sets:
       -
         name: gro-ipv4-max-size
         type: u32
+      -
+        name: dpll-pin
+        type: nest
+        nested-attributes: link-dpll-pin-attrs
   -
     name: af-spec-attrs
     attributes:
@@ -1627,6 +1631,12 @@ attribute-sets:
       -
         name: used
         type: u8
+  -
+    name: link-dpll-pin-attrs
+    attributes:
+      -
+        name: id
+        type: u32
 
 sub-messages:
   -
-- 
2.42.0


