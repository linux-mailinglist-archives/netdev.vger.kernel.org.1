Return-Path: <netdev+bounces-83341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF4891FA9
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A085428A333
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1C146590;
	Fri, 29 Mar 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Qyum7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752B146012
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720234; cv=none; b=TzAHvFy+mjN6utceKWyb4/4i+aSQq9Sb0+Benglf8Gvuigxb+IgHaAUJvqBvxU02TIV5xt/g93VH8NtIsN5yKcqZgBsVoxOtUCi+mNZT8LcyYQVbD7ZG9vv/nq8UOKRoUzz7sfQglJ4xK1HPpriMYoCZ6yYOpH8HcBL5xGc04cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720234; c=relaxed/simple;
	bh=BmPUv/muxh2IWtSQ2/h2reshEnJ78rACDCkeTIwQEQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKJ86y1x6Pv5+za/YllCpRNUngkcaR++p5VlTo56/6EX/3UEpbfu9Xrn8ueY0zqk48IMlhL4Q23VDkdaz5b1ARfjbYri326gCFHjrY6fbcXJ+06NFK8OgcG6FS83SJXXejKNB4cieQbY0KZ2VDwKnce2RjzaAVHG6XA2yKIMM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Qyum7U; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-415482307b0so12891415e9.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711720230; x=1712325030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkxeyeZNwA9yc/AStPRrWALMQsfLa6sZyGKQd1e3u7M=;
        b=l5Qyum7UkDoKxkh744zWPt92G5d8jkMR0tRIBYF7qXhuN/5S+nyGbibmdQNYEikaQ5
         7Pic6kcrXZcyEdC6aEYd8JKpsfYtEw9YMdFxdCAVX2yRbzSOH98cI78HJ3qjleoicSvg
         HU6TTBk0L8ndLGrIYsHKu/0u+EUN6ZW+UCm6SOgddCZaQYTpO3fR4o/OLvblUTk+DQax
         +LGcK9GEQH8JVJOEeyRKaBzVt/gF8dlXjEsUUIpJ2KmOcsCbLFWTYmmVhxc5tFd6a+9a
         DVkM1i+DvGc0GX1U7YJaXwllTGrcpL3mRsBccuSwae+OkpyjcBfVdmujWI1r5vYeXuwE
         OSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711720230; x=1712325030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkxeyeZNwA9yc/AStPRrWALMQsfLa6sZyGKQd1e3u7M=;
        b=TuKA6+xcLUEAjuMet1RYgYEiEVbmgq5tLaNx3/Qxf89gsOgUnTr+3tINAkLL3vmjU3
         OVWE0Bwsk5Y7FsbNHgu68/5B+1cbzVVyiCrEMo0hxBstLlk8dYhzetCleg35FaRvV5ua
         fG4AH1+Lj+IsNy973VJ9D4KGZOYSka/5Klo7udnbA/TA9/T7XhRDoBFTkFxEiMslFjpG
         bchI6fU2zyMKWaO9HguwoVVfUVXmXTGb199dg4HevnZgjrQcBj4ke0WYUD/gTr01e7a9
         JUiLiHZdPoQsXt4pFXak13EkrcwMfRTE8t0reKSN8U4/QlnnTGcvDZsObQRKIad7YmF9
         bo7w==
X-Gm-Message-State: AOJu0YzzqJRL8LzLJ8E98mB5MNyXQZ+RG+oay0ARVA2vtvWWF7TSYDUl
	0Fvxwm0fbE1BXjPedkULwF6f1j2R42z7jG1vnJJdhPKq91XxosoR39TAiINqGlI=
X-Google-Smtp-Source: AGHT+IHc+GQxrIFb1ZviZJm71pSdkZP6hmkUoi9WiANfeY/tcNWcQmTS3wTFCEH6wRXYAgro9Qtaow==
X-Received: by 2002:a05:600c:5252:b0:415:47cd:dfdf with SMTP id fc18-20020a05600c525200b0041547cddfdfmr2291772wmb.12.1711720229877;
        Fri, 29 Mar 2024 06:50:29 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:3c9d:7a51:4242:88e2])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0041487f70d9fsm8590633wmo.21.2024.03.29.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:50:29 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/3] doc: netlink: Update tc spec with missing definitions
Date: Fri, 29 Mar 2024 13:50:21 +0000
Message-ID: <20240329135021.52534-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329135021.52534-1-donald.hunter@gmail.com>
References: <20240329135021.52534-1-donald.hunter@gmail.com>
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


