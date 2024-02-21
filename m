Return-Path: <netdev+bounces-73750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C258E85E205
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789DD28189A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3708121B;
	Wed, 21 Feb 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="10gV8Hpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F178B70
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530870; cv=none; b=UHd3iP4tMHDqEEZrZ9i15hsNNoFM7BHjzrJ+l6AXQebF/xGVk6nnkOeyItLPj2wRPsNADeWubt41O+PRWi97rE16mJgZZRcTbA7cpbb18vR1jcioe8bYk26+vTgIJsAOIbS/u0nNZEbftdYnjlvQQyw/XZ8fDwxEqFUxzn9doTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530870; c=relaxed/simple;
	bh=ZAijF8H8mV+HKyhjaM5pp0WYBFh+lTDCmsHsPYS6rK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkvdXYpq1WOgmH0q9RC+NTu30v0aIflwh7EiyRMs1kjFUBXpg2jWsiQS/vNuZZVAnlP++Q+Fg5Jv77dE7sEe2A9up/k+BjXb2vbkBsvBu9rzOXofzuJFXWSqVvDiToyLjlragHieF5+r44F20/186QFrmiJi1+j3XQOeVf3Yimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=10gV8Hpi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d220e39907so75391001fa.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708530865; x=1709135665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHVvHPCPXKuXh5TNyV3Uph7jNYGzOOiHwYhKYNT3XBk=;
        b=10gV8Hpi0nqk/bHCPt95I16kEQo39Wh8WSgvnRnGEvhqFtjCTcJJQpOEnL6svJyPMZ
         OvgTjfQs8+hRHV4/VX8jYqHJjp+iMbJMr9w46b2flrpOaEIxEboAnDYfqwNySyShPAci
         8CFCxwZ3d2sfFvvrirVLZRsChFviuJugn5Y5SS/I57iTimGvHXferAmyLcKXoV8JXKPU
         ExfCoO+Y5XLfIIzhQqss+Gul8MKfvVALVILC0gn6BUH+IBx/O2lVeWbCp6b6kp81ULL/
         sjBd1yOFXQmQqkyJKOuuxnWBtu8UGjXlPZAJHEshuIAw2cDhunpuvy9v/Osd7HQsK7kB
         2m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530865; x=1709135665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHVvHPCPXKuXh5TNyV3Uph7jNYGzOOiHwYhKYNT3XBk=;
        b=IA2Rk1Xj+XZK0zpa1E7RdmB0nfQVMtSNllcBwxah3OTPWe42PNGN+kA/ctQUgMECii
         EDTtfOwuqYTeBp2NkUjIg4j8wc/jmBdvefo/qXL0CNL8g4cbsY4H1ExjRodluHKeugZY
         kt2vTEJ+ae07NNcuoIbZTnWEPsqnCKJKwTLOr/MLSVxH9M36rfaxk7amj05LoHdoI9ia
         jvNngt/1cR958XBnBwctFONKQu7VUnAWIEMLpvt7KksHvfjRdgqxMcmjE7ehmuYPCCFI
         fAUHZrLNuCI8/YW80c2uya40pEuoBY3Fy6GDaE77TF/yRs+NEAJUCK+LdDGQRzwuoEN9
         Gung==
X-Gm-Message-State: AOJu0YzTRwa6vz+Ph00F/xWsdw7gEic6S6hoLJVOB+dKDf6NeFy10Vxb
	aFV+DCZnjychuFWqiADWmh7QogqW6Ew7QrjTJ+oi+YSykp9ejMMhjjOzyiQx/ZwMPkNjRIO9nen
	I
X-Google-Smtp-Source: AGHT+IFFYKz2olECThYSHAYNm/n6LjDCFrNdJTdwunp3Fr6S9Wv8OknO2njthp7mkh6/OSh+wueyJw==
X-Received: by 2002:a05:651c:2125:b0:2d2:5cca:cf6f with SMTP id a37-20020a05651c212500b002d25ccacf6fmr308408ljq.18.1708530865337;
        Wed, 21 Feb 2024 07:54:25 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b00410c7912c6esm2894465wmm.14.2024.02.21.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:54:24 -0800 (PST)
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
Subject: [patch net-next v2 2/3] tools: ynl: process all scalar types encoding in single elif statement
Date: Wed, 21 Feb 2024 16:54:14 +0100
Message-ID: <20240221155415.158174-3-jiri@resnulli.us>
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

As a preparation to handle enums for scalar values, unify the processing
of all scalar types in a single elif statement.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/lib/ynl.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 4a44840bab68..38244aff1ec7 100644
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


