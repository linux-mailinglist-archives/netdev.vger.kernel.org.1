Return-Path: <netdev+bounces-73751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1818085E208
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1E11C24568
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C019481733;
	Wed, 21 Feb 2024 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p3rAnV5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA481740
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530872; cv=none; b=WGC9pQFX0WTfaQH5qCntCkO1uDzneXGj0uRBBV7ZXLpIGsUy9wA0+9odf9i4VPNu65WcLReQgQn2aQw/MMetA2eHlgdTDDabCJmw1VOzaU3xcTheu4xHSQ3j8EnO02BK1UN8uVaYfatgf2xJ/5Ws1LaD+77R1Cz1fkxxShU26I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530872; c=relaxed/simple;
	bh=CK2Zn7IT1YhyI394J2tFidsf2bcKR/w+ZOUToE4nD+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpV68aIGpNIMkBhsaCWBd/dztbnZ0xXhPyIMMGu+Xg2he4mCNq/dha1Gu83tIsnDulFYXVbxt19d9AzZXAjA9AHwb+DjwDvT2McmNOpT45JS9tmXWjztXemL8jZyf+AbnGDWnj/sGhllJdEFkdGZMww6vyUdJrHGUFbtXdRaRWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p3rAnV5j; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d4c11bd34so2621423f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708530869; x=1709135669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgSKmQ6GQ4Auw6c9me4dvApmwDymjR34/yKN41/IEuk=;
        b=p3rAnV5jeLu29umGiwDOSUY4yEaqXn4dIGrE9RToCH+gJOknQ5EEfbgV+jdUU3fHRN
         Wa1yqzc1nGdD8vW++wa4boYfNnBbBTpO+WgVnp97soV2YT2VtA5f3IvBFrvcH/IocASq
         g4wNbbfgRvxTxuOTLZ93I7KE0Y+W4v//KcbBn0CaKBYijgTXgQKtnzwjGCib59NB+I+K
         xNQEyGQhKs3mS795S0MsJv+XgR1FeZl5DBtFIWXHWQuxFw/tGkrOTPSRNwXBJ9nW2Mw6
         f9GcTp7Jxwy78D3aNFS0IjoeBJTHNJ/hLDQDbagolrZx9i71D+SSB9msPKLeCBs37r23
         DN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530869; x=1709135669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgSKmQ6GQ4Auw6c9me4dvApmwDymjR34/yKN41/IEuk=;
        b=woJ3lhK2hPYdXHgGD0GnPNxJm+End953IpaIHetQyjSOloxT4ZWqsXqE82JcyuyKos
         D48+Y1Bo8wqzXml0zImsv8CcX5+tF0pq2whyj2cKvC4D9SBUNhwdqJBY4WCHJrj/PYxQ
         sUuPHs8XkunB3Xvd8x9UUtgyjHodbZkM2uFef+Wl+HePerXaUSR+TIZWLXfYdZdXOXaH
         3z0uuD+2jMhe7iNBarIpa8+cOxY4Pz79kCm33LE9VHmxzGD3D7Ca22WplDfDhIwocRgQ
         PyHKGUrW+yH86cGxkCxHcYlyJYsrEPDF2sITKbATCJSd1jaYE9IJPe9+6QtBMkMqhHBw
         9C0Q==
X-Gm-Message-State: AOJu0YyOrjuI3Qod3a5zCIPSZ+1p4x11jAwUaw5CE0976dhawrP0uu2m
	BE9zTb/qkFLYlL4L0wRgp17hAeuXlAFZVPyd9gGqlWJe1k9qutMtzi2FTlT9ue6JRo3UwLSuHZz
	R
X-Google-Smtp-Source: AGHT+IFoQYAZ0KHv9nNx69XV4lZlsycYvobBx+7HiqFb8cysWfby4JF79Of2Pa/3RuYxKg0G9GuvbQ==
X-Received: by 2002:a5d:64ab:0:b0:33d:7606:808b with SMTP id m11-20020a5d64ab000000b0033d7606808bmr2897720wrp.68.1708530869185;
        Wed, 21 Feb 2024 07:54:29 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033d873f08d4sm368410wrb.98.2024.02.21.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:54:28 -0800 (PST)
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
Subject: [patch net-next v2 3/3] tools: ynl: allow user to pass enum string instead of scalar value
Date: Wed, 21 Feb 2024 16:54:15 +0100
Message-ID: <20240221155415.158174-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221155415.158174-1-jiri@resnulli.us>
References: <20240221155415.158174-1-jiri@resnulli.us>
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
v1->v2:
- s/_get_scalar/_encode_enum/
- accept flat name not in a list
---
 tools/net/ynl/lib/ynl.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 38244aff1ec7..14ae30db984a 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -438,6 +438,23 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def _encode_enum(self, attr_spec, value):
+        try:
+            return int(value)
+        except (ValueError, TypeError) as e:
+            if 'enum' not in attr_spec:
+                raise e
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
     def _add_attr(self, space, name, value, search_attrs):
         try:
             attr = self.attr_sets[space][name]
@@ -474,7 +491,7 @@ class YnlFamily(SpecFamily):
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
-            scalar = int(value)
+            scalar = self._encode_enum(attr, value)
             if attr.is_auto_scalar:
                 attr_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
             else:
@@ -482,7 +499,9 @@ class YnlFamily(SpecFamily):
             format = NlAttr.get_format(attr_type, attr.byte_order)
             attr_payload = format.pack(scalar)
         elif attr['type'] in "bitfield32":
-            attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
+            scalar_value = self._encode_enum(attr, value["value"])
+            scalar_selector = self._encode_enum(attr, value["selector"])
+            attr_payload = struct.pack("II", scalar_value, scalar_selector)
         elif attr['type'] == 'sub-message':
             msg_format = self._resolve_selector(attr, search_attrs)
             attr_payload = b''
-- 
2.43.2


