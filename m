Return-Path: <netdev+bounces-73009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADC385A9DF
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6070028944F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEE44C89;
	Mon, 19 Feb 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="W3V1p1pB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45C45974
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363538; cv=none; b=dh/ABC8HxoIogmmouCyIPR0cGVYhveaY1Co1wwbpmg6FxZzNWCOOOAaDNQMORXSjVOWhXtXmkUW/CcEAqjl+lTgahxS/6arsCddJyalzOHa37f3fVCRpGZND6ta3Nuf4V/8EOahLhgQE4H6thpGuc5NqouqDLBnLbbVhYx6ztl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363538; c=relaxed/simple;
	bh=7GJNeyqKKI2gUP8y+Pel3YsLRHMvcG0b0D71Qjle/ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0vblX7HP/XJSHmBVYXDq33RuBdkR0PNxC/pMAlKhmxYNlgsJQeuY9Bj+KN4XKUhMCNM1Gwb26eJtKMeq+RdVz/ZZj3HS2xrl9HqSlzbnwOycLxt45bTxQz1gjvPg6uhOP/wX7gxestn/fI8zP69Y+T0umXDSmaifrMljFfwtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=W3V1p1pB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41267d9d6faso7253415e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363535; x=1708968335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA8nIxPfxUck1LxHT5Y/kVmB4xqHdbqDGqS9lzCV8Ns=;
        b=W3V1p1pBrmZuTT0HKf+04f1VMySu0CEtnOC6aTh8UU6dVHMJdn5SpMLW40HYpkGQVK
         rXu/gp5IpMouSkWm0iDnyufFeS0Z0qKJe8nAbFcOcfCAeESMCi4N8Wclkarnq2760yOv
         LlpCHzLO/hak8avlc+1Odf9o9rClofwv5yYNkS6mjssnco2L9ee6Nw6XM3pZsnA0CJzZ
         WgGHAYYobu+enQ3EpF3qkfjOyoKGUdTF9zDToqglVo3SN8AbHZ1FhlP1St18J+89ycpg
         rOH72sE1BJkm7BPrhyPStRtXyNFzRjlW1hSy7TFrfqBsf/0sLAI/MSNQOKKUG4fd2nHm
         FQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363535; x=1708968335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA8nIxPfxUck1LxHT5Y/kVmB4xqHdbqDGqS9lzCV8Ns=;
        b=BdnEOd+GG4w6FRg7twpzpQPFhCzjTBI1n2wsFLiCYa8X7jgYP97QMPSfNLMgF5+2LA
         Fx17novlt0CLxQfQKVpLUEDjCgC/hLa1jX8IwRb9MZmExXUDeFidP1o1toJ3Ye/a3VnY
         0XBQLEtWsom9MFUySQn09n3cKins3hB4qjEl7+HXRFi+DY4Vsu4YiR2asrTykCqJIJm4
         FrwHSQOXUawK8ndZxl70I02NdENPINSzNISdu2i3D0DmvCaOm7MGc6FVol7/GqyHySn9
         y/SArme4/b7cbf6xty3YaBeGg2nyCITqqf6KKQA2KYszUUzvDg58+gqGsBdc0EoPNU32
         v6cw==
X-Gm-Message-State: AOJu0YwakPpZTBWIqLxqWtTf19w4Y1+GnQg8WxQP15QZ9iQlrCzKY8EW
	zngbDHN0VKNTMqclA5PQCRWDJh/CyB2vWmZoMLgFtNCs8kByX7GXeAmDCOjpfmgBjYY7GRUz5lv
	I
X-Google-Smtp-Source: AGHT+IG8s/7WPmn4JNpphEFvBQRyKyHjMhixvvis2sWm4GJD1iSGD3HPxoPxPiYeeUwl2TrN6w2MLg==
X-Received: by 2002:a05:600c:3b20:b0:412:63f3:2b9d with SMTP id m32-20020a05600c3b2000b0041263f32b9dmr2834775wms.31.1708363535154;
        Mon, 19 Feb 2024 09:25:35 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b00412684fbcf3sm2490174wmo.28.2024.02.19.09.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:34 -0800 (PST)
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
Subject: [patch net-next 02/13] tools: ynl: process all scalar types encoding in single elif statement
Date: Mon, 19 Feb 2024 18:25:18 +0100
Message-ID: <20240219172525.71406-3-jiri@resnulli.us>
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

As a preparation to handle enums for scalar values, unify the processing
of all scalar types in a single elif statement.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/lib/ynl.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 108fe7eadd93..ccdb2f1e7379 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -473,14 +473,14 @@ class YnlFamily(SpecFamily):
                 attr_payload = self._encode_struct(attr.struct_name, value)
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
-        elif attr.is_auto_scalar:
+        elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
             scalar = int(value)
-            real_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
-            format = NlAttr.get_format(real_type, attr.byte_order)
-            attr_payload = format.pack(int(value))
-        elif attr['type'] in NlAttr.type_formats:
-            format = NlAttr.get_format(attr['type'], attr.byte_order)
-            attr_payload = format.pack(int(value))
+            if attr.is_auto_scalar:
+                attr_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
+            else:
+                attr_type = attr["type"]
+            format = NlAttr.get_format(attr_type, attr.byte_order)
+            attr_payload = format.pack(scalar)
         elif attr['type'] in "bitfield32":
             attr_payload = struct.pack("II", int(value["value"]), int(value["selector"]))
         elif attr['type'] == 'sub-message':
-- 
2.43.2


