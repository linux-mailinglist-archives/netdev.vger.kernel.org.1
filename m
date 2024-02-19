Return-Path: <netdev+bounces-73010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD1F85A9E0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A101C22998
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697E45C04;
	Mon, 19 Feb 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1iwfo/R4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99545974
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363542; cv=none; b=Rgz1Jc5x6YMLMtM78Y9I67b8SoBjMoNpMideXOrZcMQmvQR/ZNChCSoj7e6NYFBm3AIc3Pl+0B5cpSz882n/1btRySNDBD/LScEI2I4DtoQfT3sSwnNO0UhXKQQEHIspG/B32G7LRk2xBvqq0CPgmi9nhiyJOa1LjjUqupUPY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363542; c=relaxed/simple;
	bh=lvSfM/i6wOhZcCTEXxaoYGvVxCN7p/ZUbuPR6CSRw/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn77ZLIM6A30kGd81ZBomBSl5V7HfrZsryopuEdkocAjiOJKenk/+khec0fECJ2B77HnUwyRfG9yOlV2GuI/8Gr3yr0yZ3z9z0ow1aDo83cZcf7ZAD81PqHp/UZOH8bU9DABZQzSEOpgKX+GsIrZydlYVnYjW9HGKizScYE3uLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1iwfo/R4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d1094b549cso67783701fa.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363539; x=1708968339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSoLiCYPAJ2jEwbCCH45PxOLjMDhrFfC7O2BBdy6iUE=;
        b=1iwfo/R4fQHTw2XOzh5uqvDwk2H631S1w2EZP+1JO+f4/FORRPkEq1BRvRr6PCojj0
         atWDE0Cz2dWhULPPkX9V6Lnq3pQLZw+6E8iE5+IUX1FFfUXogBoKdEYK2YLsn7tPukhV
         I+D8jHPia6U+v44KPfLQsf0UjkDg8knS62SVE3y8ZPnjYxA4u7ZWtSry8KE94W6NqFd7
         tur/+F5ci2Eavtcp+DMAeKTP7ZHR6/LyWx82MylKev+fdIUimDZNWLsk7B8hE8J2AEtx
         LS8C5h7Xlbqe+5UB0GhsDkGMbAod2rg/G3rRR3/In8OUJPVYonMv6g56IWyUc9pZnmjW
         yXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363539; x=1708968339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSoLiCYPAJ2jEwbCCH45PxOLjMDhrFfC7O2BBdy6iUE=;
        b=uq9fEu5gZyryE0bPWf/EYYtiYs8ixHM0HEfwdDH6D+WUccv03VOmnST/VZhP/5ldno
         PKPGIxkTVHGHiOr8y+Ore3Ss7BY4orNFB52T6XiJdiEzAH6TpUYZsQZhSY3FV4Uh7gJv
         LFVtilPlPyZ1W8sXmOx1tMVcUvzCqofcvc4v6o4sr0ieU72J1d8/bRfpf9dcm0ZQTccv
         PCEeVTJufDQV8Oo78Hxvuquv5PqeLniEgEukxsZn61Z1Mo/goT8ra8TFMI+fPvda5DW0
         sUty6h5KCwnbzFN9ZtecqLE0Rg+dqn3QLlOMpUIJ56R3+zed34vpvf5TsuHHa9b41pyv
         WEPQ==
X-Gm-Message-State: AOJu0Yw7XiugufbQ9hM3nYQf4QWquOcJnTPw5XAZgWOJmGsX9NFsDCxY
	BdmDu+8TrNpAuntAl9t9Grh3BxJ5QiV3gTvNcufsJ80s8gqgHp6jU7iYUMtrFeHAkpkVJvdl0dl
	4
X-Google-Smtp-Source: AGHT+IFfK8oxV/mQ12ZeRx+Jw4cq/zmOwIIaXiFmkqFPuf0tiZz6ltjeBLW81coywvSpXjBWtbF6Fw==
X-Received: by 2002:a2e:9685:0:b0:2d2:36bb:5abb with SMTP id q5-20020a2e9685000000b002d236bb5abbmr2976565lji.20.1708363538646;
        Mon, 19 Feb 2024 09:25:38 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b004107686650esm12079906wmq.36.2024.02.19.09.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:38 -0800 (PST)
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
Subject: [patch net-next 03/13] tools: ynl: allow user to pass enum string instead of scalar value
Date: Mon, 19 Feb 2024 18:25:19 +0100
Message-ID: <20240219172525.71406-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172525.71406-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
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
 tools/net/ynl/lib/ynl.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index ccdb2f1e7379..d2ea1571d00c 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -438,6 +438,21 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
                              mcast_id)
 
+    def _get_scalar(self, attr_spec, value):
+        try:
+            return int(value)
+        except (ValueError, TypeError) as e:
+            if 'enum' not in attr_spec:
+                raise e
+        enum = self.consts[attr_spec['enum']]
+        if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
+            scalar = 0
+            for single_value in value:
+                scalar += enum.entries[single_value].user_value(as_flags = True)
+            return scalar
+        else:
+            return enum.entries[value].user_value()
+
     def _add_attr(self, space, name, value, search_attrs):
         try:
             attr = self.attr_sets[space][name]
@@ -474,7 +489,7 @@ class YnlFamily(SpecFamily):
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
-            scalar = int(value)
+            scalar = self._get_scalar(attr, value)
             if attr.is_auto_scalar:
                 attr_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
             else:
@@ -482,7 +497,9 @@ class YnlFamily(SpecFamily):
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


