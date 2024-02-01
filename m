Return-Path: <netdev+bounces-68039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D554D845AFE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB881C26465
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21362179;
	Thu,  1 Feb 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ22FcAt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660B62171
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800356; cv=none; b=rHk6c9X8P0VZa44sOs/ANstsaNGrw1rNEQ8qf+iAhzDhVa8L607PiGsao1OBcZtSAKIhWVuHi1w5d5Ir2UlaEAcnzBgREovD1H229Nh3N8XLwItV5XbjBriPDS7tvFTTd2pD71mqQLSZoz5ZqmqsnrJSJ/c0W+rwAeOZMaHychU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800356; c=relaxed/simple;
	bh=/xG+h5RZC5/8OszqGhNKWWiFitVUqw64NFuzgjp+EIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwAoCz4bYhwiwlodtzYRfjiLmoXW79BQLvRGeQJQ/SJ8A2R/XgVJ8wJROzDRFUetoUtuyzFegkFrOR4yooesH8hBZ8I1fI2ZqGIFBdf/HVd5JTfnyJga64+Xw8R3CIBAwv4srnVECMqOAQ4U3A3z5k0+G3szXqXBBiX6xOwlPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQ22FcAt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso9502255e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 07:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800353; x=1707405153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsHT7PeBiouTdUpMVyh1+ZaNdk9EMDGgtSt1Xhh6ZU4=;
        b=OQ22FcAt+cZaqK5e1/Lrnz+k8wHRzpsPeXDV2THDLfILfXM9/bLB5f3xMo5M7c3AfI
         DdOLKffiEO6hwmL+nHFWFUHpvp9NRbCCYGS8rKARz+SeUyKXkArZ7t6yei/AUqHyLwJg
         kBKQl2/QyVbIbRh/FwNTVmO1CeYcWcjxKYbE3gl+th3abEdU42bZCQprLAbGmg6Dhvge
         XYnaACfBUWImJ9BXmklTnY4reAKcsaR1EX/r1y+YDWi1uggPnL7FWICFOBUl6jk5TBTv
         wJnXoCj6KEhQpHSsRniHMKcW9PXBPmrzpiR7tgzhg0lF4QLLbcMI9pj0ZwTT83Hkfwwa
         cSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800353; x=1707405153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsHT7PeBiouTdUpMVyh1+ZaNdk9EMDGgtSt1Xhh6ZU4=;
        b=PZjtxc7+/hXcwJ+nCKeAF3mk5MQ0ChsYlWOE+GW46g0kOihUpLTcbyCPbCbNg8leqR
         YsD2StoHx7vYH5QDwhD2uqgEL+0y3VOWhxF/MmaAYc+ieuhvZ7D6xks20lXUnO7aPe9K
         roVIWqe8xvq0bjB4Zf+9O7jnU0pZC84fIGhdk0kx3frmf4p+3sW1yqGM/s3dgi5ZeEv8
         Sp5hcNtuyRZxAaVuWMRRAg7xVVThgFkSyY5claC/kPyGe4p9hkCpylCTJhI7gM2nDRsv
         /cEvlSVmSTGV2A3g7Rqgm3dA85W937CjjpGikgG7wILpKyrLcgH3xIdsW2QJ2a06SGNh
         Ecjg==
X-Gm-Message-State: AOJu0Yxpli9cgGsJn3z8VlvHBi9JnwFCrsirqqfwdKdwQ1VE6izbqiwx
	RVQyYKau4ytWBiNCtFG8FC7h+DzhLV5tHm6mQHpZ+aeajbcoAPbp
X-Google-Smtp-Source: AGHT+IGVHKMfHFwiFMnSWp9MjXwAYoAnNRZsfOFQ8efm43FvkVB8mT/Ke9vvL3KNTCqxwZIH/GNWYQ==
X-Received: by 2002:a05:600c:1ca6:b0:40d:8bc2:6059 with SMTP id k38-20020a05600c1ca600b0040d8bc26059mr4555614wms.36.1706800343827;
        Thu, 01 Feb 2024 07:12:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+iL9ZWnZwr4Mk1wn5ywf4R/iSTsK5H6HtFBUOJgShEQFdPalrtHbs7LW809xYv0O2NHfBwzAJYBgKI3P80qW5RREWM2V/SEz7dtfBcKNS7tiYf4PA4l60UE3o25PeTBhfkqv/k7AXE/o7zuvBinK19s3VdBox9V3KAwpEAAUyVRQO5dY8EqlCZx4d2tIHGiTUVsCycvyRciNoodP3kymd1jK+Q3cWhq4z9ijO/yZJwjxkbJGR1zWibpfdG9aWjI6JHgycsmjqbrgC3cKb9qVGWrFmSzUOzPuqo/PnUsMbWXYlBbKri+Zq0VcunLNxmpn8MEK6sAHXqwwm7DV9Cc1QVxIlo47lZ8Ne
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b0040fb44a9288sm4753672wmq.48.2024.02.01.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:12:23 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v2 net-next 3/3] tools: ynl: add support for encoding multi-attr
Date: Thu,  1 Feb 2024 16:12:51 +0100
Message-ID: <9644d866cbc6449525144fb3c679e877c427afce.1706800192.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706800192.git.alessandromarcolini99@gmail.com>
References: <cover.1706800192.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-attr elements could not be encoded because of missing logic in the
ynl code. Enable encoding of these attributes by checking if the nest
attribute in the spec contains multi-attr attributes and if the value to
be processed is a list.

This has been tested both with the taprio and ets qdisc which contain
this kind of attributes.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 0f4193cc2e3b..e4e6a3fe0f23 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -447,10 +447,19 @@ class YnlFamily(SpecFamily):
         if attr["type"] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
-            sub_attrs = SpaceAttrs(self.attr_sets[space], value, search_attrs)
-            for subname, subvalue in value.items():
-                attr_payload += self._add_attr(attr['nested-attributes'],
-                                               subname, subvalue, sub_attrs)
+            nested_attrs = self.attr_sets[attr["nested-attributes"]]
+
+            if any(v.is_multi for _,v in nested_attrs.items()) and isinstance(value, list):
+                for item in value:
+                    sub_attrs = SpaceAttrs(self.attr_sets[space], item, search_attrs)
+                    for subname, subvalue in item.items():
+                        attr_payload += self._add_attr(attr['nested-attributes'],
+                                                       subname, subvalue, sub_attrs)
+            else:
+                sub_attrs = SpaceAttrs(self.attr_sets[space], value, search_attrs)
+                for subname, subvalue in value.items():
+                    attr_payload += self._add_attr(attr['nested-attributes'],
+                                                   subname, subvalue, sub_attrs)
         elif attr["type"] == 'flag':
             attr_payload = b''
         elif attr["type"] == 'string':
-- 
2.43.0


