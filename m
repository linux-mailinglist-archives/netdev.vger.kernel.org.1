Return-Path: <netdev+bounces-73018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A541985A9F3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A411C22BFB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977F44C8D;
	Mon, 19 Feb 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wK54awbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650247A4D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363598; cv=none; b=UYoCsTt5TK+wERI0DgpATvoJkbh1FJdRyFKb6gisD0g7FR5Joik1QSpoMcKfPBLtUSOPpJjjUFYAxr35CGe3Jm4MFLUgWmH0wLzhOCilPXcEKK2ez25fuT3WKkuG9/SAAT0GbWLXWjHAbeVA90ylWJ4MnR4WzTswB9SxVJTc6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363598; c=relaxed/simple;
	bh=jKndwCTCAzjrCNl7/zG6rOf498cgyEExsuTgouFBll4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajRL56pGEBZM68JtrBa/2vhVK+/ZVxP0siUFxdwn2aYMyxz/ukMz0pNs8UlfDKfxu+jMyUjQqGi+jBJbWB9EnHAUNWSHN3L6KntqiqfP4YNZDaTJX6LiFqf6ITBIsOwr661RBlc7e+vl4XlAn4I5/CtwHF09IXUqFhBOwynTl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wK54awbR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d2305589a2so24701271fa.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363595; x=1708968395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5PryIoP66cTJV5dj10Xgw4cU+fKj9Ha6rspTNzKBT8=;
        b=wK54awbR7MsgzIXYw67zMmV0WGIXSyV8AR2qVqkdCW2VNQRkOu072a9cdW4FPszqME
         JR7Lp3K7HBHriMfH0EK+MOKGfpv+fMXtNgeKAI2kygUYy32c9QfkQvBcUwNEULD1dK3L
         CUPR6+fFnMfoB1Utvo9+lt90U/aCdDyLqrQGRJC0X+kK0Q+qX/WXzEk4wm+CEHLySLwe
         Eqdlq483QgZpOVO5ZwTZw7kgo31crrF1xMmNf/zAZzH2eqLhB7g/yJ5kb6JFyu1lk233
         uiI95Q97cqlfcr83/sfMdBxaF458YO/paresfBI85uskcXWCUWbz6VMYXVZ4v9UMFjy+
         aNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363595; x=1708968395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5PryIoP66cTJV5dj10Xgw4cU+fKj9Ha6rspTNzKBT8=;
        b=dICEcLtY6IjGC4+3/OVJqNsRyFHAJ03Lwna4V+bPilLiXpAX8lTpVDai0D3YUfoFqi
         XkjGVcxcl9KxQ3KYN9nkI9sXYcEsSk9iCeHKb24Y/9ueZ2XoGLgmJPefZlHnqiZVOJzk
         QCjFiFRwXeBPBPWwEetoFoCBSSrQkxRnCPq1d3jST2VHgeksppi3Svj0C/BWRnM4y6ah
         owcD11OOIRrAnTSEO+9W8JlkIUAZpc1IvAWyLRS7WQjlxAcFznGtlFcoHBgpgBEITqGn
         ZeFtc9AWaz/aInTMeeeCzNuE4jQ7yDf9fauE8WUn042t3/+m34wRRjwV4w4tdUpPJWNr
         QmZA==
X-Gm-Message-State: AOJu0Yw/3naq661uNb/UvwlCNow2gZ2oWne9Xt+HKVXXhoq07qc7jS8e
	u9mTLj8//A0our3wgMnmqy4b23KTIY1dSf+/lO96K8FdqPF0s0tTOmOrRLaiaPGjjzppsbtMn2W
	j
X-Google-Smtp-Source: AGHT+IEzQihch9yCP9FJc3ygxQr+BsyNAKO2U/UCZ0ajlt1SLxipbyLPuClYZxy8uwlUeOWiujhDSQ==
X-Received: by 2002:a05:651c:217:b0:2d2:4054:2fab with SMTP id y23-20020a05651c021700b002d240542fabmr1536251ljn.37.1708363594704;
        Mon, 19 Feb 2024 09:26:34 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 14-20020a056000154e00b0033d10bd6612sm11132559wry.81.2024.02.19.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:26:34 -0800 (PST)
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
Subject: [patch net-next 11/13] netlink: specs: devlink: add enum for fmsg-obj-value-type attribute values
Date: Mon, 19 Feb 2024 18:26:26 +0100
Message-ID: <20240219172628.71455-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172628.71455-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172628.71455-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

For devlink fmsg object values, devlink relies on NLA_* values what
are used internally in kernel to indicate which type the attribute is.
This is not exposed over UAPI. Add devlink-param-type enum that defines
these values as part of devlink yaml spec.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index df1afdf06068..fa4440141b05 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -218,6 +218,26 @@ definitions:
         name: exception
       -
         name: control
+  -
+    type: enum
+    name: fmsg-obj-value-type
+    entries:
+      -
+        name: u8
+        value: 1
+      -
+        name: u32
+        value: 3
+      -
+        name: u64
+      -
+        name: flag
+        value: 6
+      -
+        name: string
+        value: 10
+      -
+        name: binary
 
 attribute-sets:
   -
@@ -620,6 +640,7 @@ attribute-sets:
       -
         name: fmsg-obj-value-type
         type: u8
+        enum: fmsg-obj-value-type
 
       # TODO: fill in the attributes in between
 
-- 
2.43.2


