Return-Path: <netdev+bounces-74018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDA85FA1B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E57B261E9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072A1419A2;
	Thu, 22 Feb 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AI1TcbPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A513B296
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609449; cv=none; b=qGmKoSJrFWf+9gDhCxosYPgEfSVxJwvAEDRoUvjSZBKeR5QNzSDguHpnd+ZSpRIDtvdFIAgkHRKUveQ3Sc6SINF4NZii8ndrY6YCI0IVVIAXvh1CTKwOaqxw0qO37C+rinQSVO4/vLnTbB2rqqTJlBBa2n+SkaLvxNOyUEgjzBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609449; c=relaxed/simple;
	bh=TEVRe+sUpzzN+HsUjVxeytZ+wm7epXxye4BPtOPzHLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udOMeQGJu6AWZr2wl1HM4WXzKnl52cZAPHABadO0fVLWsrpot44qsVlui1/gxeLxQB5WLS8sCVDO2+Qyc+XE6gyB09ITPxiyq2QRIFzOs2P+mWMnXc/DKQVcmg5r+e/6Mr+J7AJgqeDGht3kYYBTemIHlULBc4+MDh8eBnqoFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AI1TcbPA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d208be133bso87400261fa.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708609446; x=1709214246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYXsYJGiQfqijxYyQOyyM1nVM3Rpld49x3qHPu0qp+M=;
        b=AI1TcbPAODH9Xv8KIKRg9aAEu//ctFneyK3QlZaIriJ7oNdF/kb/IV930BRDEHzWdh
         x45rMkghCdnGXPCvCfUytlqams/xaQoaxwheYHsSNwx2UWjzGEsEfs6zqoLkoBPJLgjx
         6wQJvmx18YJFQmBxwyJdjvKIHiWnAiNstHDzVTzxU1f7D2FltXTLxUt++uqrA3CpmLCG
         OOA4GsAJAnyyq5aKvpMWYc4jAtjlgLQh2ymcRe1fsGLwEzOn34WitU78igoPzciS5C7a
         zilZelyDVwhP6QMflh0MaSwKzKF5Y6s+6o5KwOxudxJBBVTm51mowkvC29ugF8hVPORI
         fgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609446; x=1709214246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYXsYJGiQfqijxYyQOyyM1nVM3Rpld49x3qHPu0qp+M=;
        b=NROeE5xTCPPDPLFdzH1x+No8mMAOU4Qvxp5vG/xmGbHHVIkYJ+LXojGszv5s5ej3Eh
         bmJLW2AXOZAjVi5Ryvi4p1sdlcA0SVRfCw171CleEIdFpMC4vDw2fSZLPhgPKs1Dr4t+
         iP6R/sGZWrby5ZuXqyBeFkLCa6osKMXWsBBO0/24S9QRIDehW/82L70c/1lgkGEmZ4tC
         uiPdTuIg0yXhliKGRhn17vFRa4RdcWVvcQVtLrlf2aeM4V8bmTS1wQBkpPTsLjzXvTWJ
         KR2pzWz1Sr42pQO9lyjOoqLIyLb+5mbtrUImgC+L6xMZEahQA4baA2NOBMm6wT0WBtBW
         HE0g==
X-Gm-Message-State: AOJu0Yyuay6d9d/e0xfuEVllYMxfyII9ETJxx7bdVTbCNFiVu2P+m26P
	2IxsWfiRPrc0lvsFPKxlQKVRBlV3oeFwKCSWtlh9Z731uVM3WDqF+MQ1dci+Am9zBkx6gLrsuPJ
	Z
X-Google-Smtp-Source: AGHT+IEuFGxllMTJf+x3UmOmWeMA85z9Gsk7lEv5E6LHdi6Ca9JQ1kWolxDfkYIoN6v5wEggogsQnw==
X-Received: by 2002:a2e:3807:0:b0:2d2:6568:eb6c with SMTP id f7-20020a2e3807000000b002d26568eb6cmr595632lja.30.1708609445731;
        Thu, 22 Feb 2024 05:44:05 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b0041262ec5f0esm15648264wms.1.2024.02.22.05.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:44:05 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next v3 3/3] tools: ynl: allow user to pass enum string instead of scalar value
Date: Thu, 22 Feb 2024 14:43:51 +0100
Message-ID: <20240222134351.224704-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222134351.224704-1-jiri@resnulli.us>
References: <20240222134351.224704-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

During decoding of messages coming from kernel, attribute values are
converted to enum names in case the attribute type is enum of bitfield32.

However, when user constructs json message, he has to pass plain scalar
values. See "state" "selector" and "value" attributes in following
examples:

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-set --json '{"id": 0, "parent-device": {"parent-id": 0, "state": 1}}'
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do port-set --json '{"bus-name": "pci", "dev-name": "0000:08:00.1", "port-index": 98304, "port-function": {"caps": {"selector": 1, "value": 1 }}}'

Allow user to pass strings containing enum names, convert them to scalar
values to be encoded into Netlink message:

$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-set --json '{"id": 0, "parent-device": {"parent-id": 0, "state": "connected"}}'
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do port-set --json '{"bus-name": "pci", "dev-name": "0000:08:00.1", "port-index": 98304, "port-function": {"caps": {"selector": ["roce-bit"], "value": ["roce-bit"] }}}'

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- s/_encode_enum/_get_scalar/ back
- push out enum related code from _get_scalar() to new _encode_enum()
  function
v1->v2:
- s/_get_scalar/_encode_enum/
- accept flat name not in a list
---
 tools/net/ynl/lib/ynl.py | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index e459a130170b..ac55aa5a3083 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -438,6 +438,26 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def _encode_enum(self, attr_spec, value):
+        enum = self.consts[attr_spec['enum']]
+        if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
+            scalar = 0
+            if isinstance(value, str):
+                value = [value]
+            for single_value in value:
+                scalar += enum.entries[single_value].user_value(as_flags = True)
+            return scalar
+        else:
+            return enum.entries[value].user_value()
+
+    def _get_scalar(self, attr_spec, value):
+        try:
+            return int(value)
+        except (ValueError, TypeError) as e:
+            if 'enum' not in attr_spec:
+                raise e
+        return self._encode_enum(attr_spec, value);
+
     def _add_attr(self, space, name, value, search_attrs):
         try:
             attr = self.attr_sets[space][name]
@@ -475,7 +495,7 @@ class YnlFamily(SpecFamily):
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
-            scalar = int(value)
+            scalar = self._get_scalar(attr, value)
             if attr.is_auto_scalar:
                 attr_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
             else:
@@ -483,7 +503,9 @@ class YnlFamily(SpecFamily):
             format = NlAttr.get_format(attr_type, attr.byte_order)
             attr_payload = format.pack(scalar)
         elif attr['type'] in "bitfield32":
-            attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
+            scalar_value = self._get_scalar(attr, value["value"])
+            scalar_selector = self._get_scalar(attr, value["selector"])
+            attr_payload = struct.pack("II", scalar_value, scalar_selector)
         elif attr['type'] == 'sub-message':
             msg_format = self._resolve_selector(attr, search_attrs)
             attr_payload = b''
-- 
2.43.2


