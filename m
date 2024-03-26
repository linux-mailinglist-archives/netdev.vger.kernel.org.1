Return-Path: <netdev+bounces-82242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B0888CE02
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF5A1C669D9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428DD13D2B8;
	Tue, 26 Mar 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChcidYP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D213D60B
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484017; cv=none; b=I1fBlBDBPHc6eRpTicrI8JRbMbq28aS7GEswQwF9xMxlY9b7sMvrxfyhzsUj0EIJYTA7oIR+sgLobxiewtdjZCMkOxZibSOmypJKY+chXJ55zj96SzvkbhB+5S3lHFoNmQ/zwCdqGPEIMU+pLkGa10F6wRd3TDdPUPe8Lymaoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484017; c=relaxed/simple;
	bh=BmPUv/muxh2IWtSQ2/h2reshEnJ78rACDCkeTIwQEQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJOqsHsZlS4EZOQGGAiL6aghchfxHD/BbTf2pNkTXgVj54Iza1alMBsz3/srNVOWxgkowr3bRKZyix8AJuME2ggww/ixmDOT39YYKWFncszZYVqNF+cvyT47VFtVPCJUffJkWfwfw5SDCXl30VcGjpt1otGeKbQ8bnCntDbjQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChcidYP4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b5432439so4632361b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484015; x=1712088815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkxeyeZNwA9yc/AStPRrWALMQsfLa6sZyGKQd1e3u7M=;
        b=ChcidYP4WPhvcAr1iYxs0V+frqSD2Ki276RIUESNfrv/R1YAatjivzHa44LhjgUQ8f
         Y6fJBg7gG4OVCUWtUn0kdxX+spV+aPV0eaUO0smvBMU0SYjq1dwsXpTDLozX9Ni5mkvq
         WWM0H4kINQZT51RGOtQBJdFIbt3nalonxBtz8qHMOgghVUcPOs6noQY+pJ5FNY5a305f
         LGGhgB8zJLqV7yIqvYQHK2/Y10mL31RaXDF1iqf7+p8BiJj3G4XWzaU2Iz/OvS6Kp3bI
         27tXuNZBtg3L9MVIoNI6HwJ1Bjp3UNV/zYIwy06JttwVkbHxeFSJGmihfoMreSuUigyZ
         sW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484015; x=1712088815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkxeyeZNwA9yc/AStPRrWALMQsfLa6sZyGKQd1e3u7M=;
        b=VltYIGTvu2jyiUk9hKFdPqQ4V3O0QPONLdI9w+uiX/SdIfu6xwaY6u4faTN89YDdYd
         lw/eaZ5CsL0NBO7NuJ4hK7RV9rY+tCpSAnubW+2NUwih0TVLkk3rgqcYhMzwzbzRppoT
         KiTUqBdxFjV1HrEZFtHgSN2j9RSriKHnBHcbWoaRZdok9253Icab2AQzznGFfNzxCUtE
         vNB35PgNjYwyfPtCBwvDU32ZODc7B/iFgMHc+COQNT3rxyL6xul7s+3fjemG+vcITzmK
         h3R/MYInH26zC/TANA2EqaYo3bkDHfqAahq6c81eUfQ+64IogImMaSKfR4lFeKOgYvpx
         8v2g==
X-Gm-Message-State: AOJu0YxtewufNuf/7cEZbErKJLVzM9tSDGNAXE+y8XcvFOsYlo37b071
	fSb/gK4F6KlYrDNznKq/RU6noR9tMD7CBaGAvQlhe4CSQySL+7uGUhO9u/pGVGM=
X-Google-Smtp-Source: AGHT+IEoU6NraMAYkDgB87+kVRlOiAyXLSIi2fy1G+aL/w1UJ3fCNy6k6dR7T/8STlI5AOEnQaSQQw==
X-Received: by 2002:a05:6a21:3a83:b0:19f:f059:c190 with SMTP id zv3-20020a056a213a8300b0019ff059c190mr2379872pzb.24.1711484014857;
        Tue, 26 Mar 2024 13:13:34 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:e486:aac9:8397:25ce])
        by smtp.gmail.com with ESMTPSA id r18-20020aa78b92000000b006e647716b6esm6648939pfd.149.2024.03.26.13.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:13:34 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 3/3] doc: netlink: Update tc spec with missing definitions
Date: Tue, 26 Mar 2024 20:13:11 +0000
Message-ID: <20240326201311.13089-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326201311.13089-1-donald.hunter@gmail.com>
References: <20240326201311.13089-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tc spec referenced tc-u32-mark and tc-act-police-attrs but did not
define them. The missing definitions were discovered when building the
docs with generated hyperlinks because the hyperlink target labels were
missing.

Add definitions for tc-u32-mark and tc-act-police-attrs.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/tc.yaml | 51 +++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 324fa182cd14..6068c105c5ee 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1099,6 +1099,19 @@ definitions:
       -
         name: offmask
         type: s32
+  -
+    name: tc-u32-mark
+    type: struct
+    members:
+      -
+        name: val
+        type: u32
+      -
+        name: mask
+        type: u32
+      -
+        name: success
+        type: u32
   -
     name: tc-u32-sel
     type: struct
@@ -1774,6 +1787,44 @@ attribute-sets:
       -
         name: key-ex
         type: binary
+  -
+    name: tc-act-police-attrs
+    attributes:
+      -
+        name: tbf
+        type: binary
+        struct: tc-police
+      -
+        name: rate
+        type: binary # TODO
+      -
+        name: peakrate
+        type: binary # TODO
+      -
+        name: avrate
+        type: u32
+      -
+        name: result
+        type: u32
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+      -
+        name: rate64
+        type: u64
+      -
+        name: peakrate64
+        type: u64
+      -
+        name: pktrate64
+        type: u64
+      -
+        name: pktburst64
+        type: u64
   -
     name: tc-act-simple-attrs
     attributes:
-- 
2.44.0


