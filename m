Return-Path: <netdev+bounces-73020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6685A9F6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356F12894D3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35047F63;
	Mon, 19 Feb 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BWKiC3gE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7047F5B
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363607; cv=none; b=pKMEimtzEX5zkdjDO9z7DNnJgiqciiYa51qM+ZRhc8HuxQsio9b+WY6G+JIt/xw/xu9vR7OVPYO+GEuA00AxJXK7ul1juo7VM9aFsXziRa8Zd8Pyfy0mtlisZ58MMOdRaegBjsFN3+zOPV/1zgMfCJeJ9c9P+Jal5dZ0GAMdVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363607; c=relaxed/simple;
	bh=w3sCc4InYbI3VoeSCcCMDfSA4cYH8lCampDSWQdidBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEuRYI1FlAff3o+2abex8oBSt6gwuOZ19RV3x+2VLZ50CcmGsjNHONaP87pxjTcXb0n7c64XstqBNfmOI6VpqkUvc8330lE1xOOBrTvxMrOKKapg5BZtALeeVcQLGQk8Pz6qeLIzPvUT0R8VNsp9GoQ+eM0b/rxoXiqsC3aotHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BWKiC3gE; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso54744241fa.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363604; x=1708968404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jx7QF70/4SI2wHM+dTYIOQdmLxXMKSaQkl57wD2M9yY=;
        b=BWKiC3gEMn5foo1eMhWSSnuMxmfDC/cNSiTArMU1a6yOj+KmaheCpjcXPjqoZ/mb5A
         /WpEzUKY/g/dgTXZl66Iol/MRUv5z3ChTAFCz3DuekgQl4Klvyaa45KyCVK8ymByAsj8
         HPPyz0Tqaem9n32QBng+93pF75fU2dbwzKOP2o9x+hpFUh7LZaz3g4kgcK1ps/HkRAKs
         cyvXTwv/SSN9/UpRYhMwE16pBpV8hpu+AjD9SgRa3SL/ku7/uzwJkVIFwmYigSDMT9Bi
         rv/ExcwiwFdbIU+hdRC1oPfzDkt7Bg7wlh/JlzH+UiT70Emxcg4NhXVanYfzWYA69pWV
         T5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363604; x=1708968404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jx7QF70/4SI2wHM+dTYIOQdmLxXMKSaQkl57wD2M9yY=;
        b=P7GXteOtvsbX4sh2gDiJ4jo7yCN22kxznAey9MfVLy/+UrLlhCOic8qCSMVCAgDu31
         xAw+8kQHcQ5DPD5HBlLCBDGflpXXLFF9P/wX5WlmewSXPDOT9HDefKSUBVKStHfK7rG5
         EzHCAvwiO3p+5fnzyYhFCiTUvdi4h4ymHOXE3RrI8iH8yqYBksHirhNnt3DIW9kTxpc1
         /OWTIIPdmGKRjR+pGxNAn+liUz9A+UEG9iIZvVcj2fTZ4ondBA6o9hzgwGBwZz5DaRdX
         aYC8a12Argabptj31+6AUl+nqKEqHhrSmOxzAYfMvKq3ODSvc5eRzilTLo8IP1QLk/pt
         X4JA==
X-Gm-Message-State: AOJu0YxA3nyrl+nREPaVHWFYNxJ8Y9ZvLdlVlnqdSPQOCKfMFc3ai0gJ
	MoMP/RTR6pzYAR0BHZl5gpt9FraFkC/Z8vYgjityGZWrZIy2eJIwOHbiV+ZrCdmWSbpvqikNPhn
	1
X-Google-Smtp-Source: AGHT+IG5DVz7rFriocLYnW3WuE9+UvAyNxuTnGUvreTf2QgfT1273Sx0ZPe1v0KSm9fhApohXMOD6Q==
X-Received: by 2002:a05:6512:1306:b0:512:997a:a8c3 with SMTP id x6-20020a056512130600b00512997aa8c3mr6528141lfu.42.1708363603878;
        Mon, 19 Feb 2024 09:26:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id o18-20020a056512051200b005128989aa1fsm977995lfb.47.2024.02.19.09.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:26:43 -0800 (PST)
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
Subject: [patch net-next 13/13] netlink: specs: devlink: add missing nested devlink definitions
Date: Mon, 19 Feb 2024 18:26:28 +0100
Message-ID: <20240219172628.71455-4-jiri@resnulli.us>
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

Add missing nested devlink subspace definition with definition of two
attributes using it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index d2bc0e366d09..c416339b69a6 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -853,13 +853,14 @@ attribute-sets:
         name: linecard-supported-types
         type: nest
         nested-attributes: dl-linecard-supported-types
-
-      # TODO: fill in the attributes in between
-
+      -
+        name: nested-devlink
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-nested-devlink
       -
         name: selftests
         type: nest
-        value: 176
         nested-attributes: dl-selftest-id
       -
         name: rate-tx-priority
@@ -944,6 +945,10 @@ attribute-sets:
         type: bitfield32
         enum: port-fn-attr-cap
         enum-as-flags: True
+      -
+        name: devlink
+        type: nest
+        nested-attributes: dl-nested-devlink
 
   -
     name: dl-dpipe-tables
@@ -1288,6 +1293,17 @@ attribute-sets:
       -
         name: linecard-type
 
+  -
+    name: dl-nested-devlink
+    subset-of: devlink
+    attributes:
+      -
+        name: bus-name
+      -
+        name: dev-name
+      -
+        name: netns-id
+
   -
     name: dl-selftest-id
     name-prefix: devlink-attr-selftest-id-
-- 
2.43.2


