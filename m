Return-Path: <netdev+bounces-74017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399C485FA1A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7421D1C25208
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B3314535B;
	Thu, 22 Feb 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2ekzz9dE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094012FB02
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609445; cv=none; b=ZbzvOwEMTnxDcGFvO/jNYEsbiFdPMFajI5VEab9Eg5eq5DDQv9Mg8SqHjcLmObJ3xcJ3MEWsh7JzlReWlpowXclPWHo73E7SBr9saPFnXR+RW1OIzfJGvdTdvhdkqRaT641VGc8j1bN53QQLV2JRXmdpRcEpaOtOa6eZ3zI72jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609445; c=relaxed/simple;
	bh=0lDaAsR4W7Z0DjQ+oq/bkBeHfxUAlWrt6e8jEuJOfOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiZdyCiJy+CotDuHCphS9mr6zvUf64+iz7GjjD67NI3y/QqAhU1puRwCamo9JCliH/C9OsYvCxjdTwVS5q9DavHEodQiFn2jBHvmcAtEKMTkRpxBU30glpN9y2bp3V0L2VRJ7nYu2rdArj0zClWSIR4br/K6T8q4wYkHfWH1bpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2ekzz9dE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d36736d4eso3578632f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708609442; x=1709214242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMPthOOurzrYeChkIv/lThMImRodm5q1y0tKDgpysO4=;
        b=2ekzz9dE2BDNiQmhPbmkLIXsL/CIiZluur3abIMUZLMt+wgWMI4TU/42HlnZ3X68iE
         AyaTxIwrkhlSA/hQlZ+CpCNHC+8U3iZHxh5rDigjrZyBGwN3oE7VwwkNkJFk6SQFPUX+
         olUBYC+Ag7sBSxxofDNhuZ47kuRKsXztoTS5lRyfJjzOggXF/4WVRFwIyJnqX0wJgEj2
         GscLlaQOkD9B8P/mX4YhNOsEHPsobCt8F+WhS+SukpDCbsh036A+g/jeP67HFnPIa/9v
         WBo8xlzHSAfwpaD4bhnTY5zsEk712z1QjoqFXzpDwPKc8rwKGKv/VT0tBVdbBvPk9thi
         odIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609442; x=1709214242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMPthOOurzrYeChkIv/lThMImRodm5q1y0tKDgpysO4=;
        b=WxRWLpC5CFQNiQogW62tbobq/sy3J/NjPw39H97ygejHLKrMkZhjvt5vlxSJxKPoSd
         0Xyk+VuzzrIGPTeIZJ18i/LrqW4WkEIE2y1M9ou+YDroz4omp8110A9jrx4rA0PJNdX+
         c72foui1Bqseg0tqsxZghg4QB9FdVoXo1A59RctH7YFp3UNNkqOVgkdeXsWgSCuTfeXc
         Ne3dJqHemCy0OA/3kiWzrLhLMIxYX2mYccwgqJu7PIhz2gdkFqvfeODtHzIEf44lZXhI
         K341fzKNEZv9ckz/WWZEB27AZTwVhngwi6UyWffQALCGw+fQZfyAfXN9nTAyDYwGzUoP
         CIEw==
X-Gm-Message-State: AOJu0YwLm+FglX8OhXDPkAMbilUtIin1UPYKNupH9N0RNpE25MOGmyha
	zSUqjFPfJzMZ9DmawkorGhN/WGSQYDayAsKrFLIu4EYchhAvqZvK1PnLMNRTh7fh29ey0EEW1MX
	8
X-Google-Smtp-Source: AGHT+IE5NMFF0Tu52dlkyPKiOo75py/opnnosZCFIKrq2R1pSTNZOY8iHYnM5C2KFEziUu5ivVrSwQ==
X-Received: by 2002:adf:f647:0:b0:33d:7e42:e3de with SMTP id x7-20020adff647000000b0033d7e42e3demr3063321wrp.16.1708609442136;
        Thu, 22 Feb 2024 05:44:02 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t17-20020adfe111000000b0033d56d43fbesm12032849wrz.115.2024.02.22.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:44:00 -0800 (PST)
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
Subject: [patch net-next v3 2/3] tools: ynl: process all scalar types encoding in single elif statement
Date: Thu, 22 Feb 2024 14:43:50 +0100
Message-ID: <20240222134351.224704-3-jiri@resnulli.us>
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

As a preparation to handle enums for scalar values, unify the processing
of all scalar types in a single elif statement.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/net/ynl/lib/ynl.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 1c5c7662dc9a..e459a130170b 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -474,14 +474,14 @@ class YnlFamily(SpecFamily):
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


