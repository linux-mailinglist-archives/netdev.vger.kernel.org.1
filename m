Return-Path: <netdev+bounces-215638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4FB2FBA4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2462A6234D5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ACE23BCE7;
	Thu, 21 Aug 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjm8FrmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16922235BEE
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784529; cv=none; b=EOxjWukaTIieU6ji4YeGU4KQi0K29jQB2idP0BqRu7HQAke4uCXUvlWBXMfw8y5KgJ39+Mn4UC+I6IiTKi/lAd+/8Q5OeAQ2zaXmEj5HCwWXzZxGOCBFSmePjmv/gZUzkC7ZRWlZ6tqCyoEfPcnDcXscIokw23uvJn8Zh9lqIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784529; c=relaxed/simple;
	bh=wHspB9lP9ytZ5qoP/apoEbwEudQSgCr+8Ne7IMCn/0k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ommOzFEVs5Ygwt4nHfTHM2aHEAelQ85Db7A1VIRtHGJo7ryQ66MMtQHZDatjBitHk3DM6jcSbunlxVr5L72q8Yp82n8aAnnECWNkXzlUzCv5Xtt6e5Hh84jLmrqc+lzY+LEpC4JApGRgD/dVhAcV/uprC+3kWiGqmKFHfmJKh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gjm8FrmB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806b2beso30332455ad.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755784527; x=1756389327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKdnyTkgvffM7mkS2a96ehAiqGPtNgTkiNVc3WNtEtY=;
        b=gjm8FrmBbQp7asF8cKHCZUMTFFwFuB9vQb/JAj3PN17eht+yeIorCau16Il27U+U1I
         JJ5dsZ+vYoFJIMM14w3HOaCqGWIWPhgvSU5gjPL1KADWM7Av6UU1BpuwFlU5CSw5YuYg
         TOCXPp13NYpJyRxKzxff8A9kHDxttawP0AyxDm97h23VZKHk2UxpmYxllJrKJqZhDGWX
         NpM9UgaAOXi157/QiJP14kSTVhYxT4kKzGlKa9RFyo3U4QSYDdlNCP3PqbETuPONjZpV
         b0G3hdifBWN+RYY1Zlj8C6/k0v+dxtmYqD7tzs9rw/2B1dA/I60ysOZU5uJ/lXDLD5+Q
         kw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784527; x=1756389327;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKdnyTkgvffM7mkS2a96ehAiqGPtNgTkiNVc3WNtEtY=;
        b=eevCljTkL5fal8tppAT1s8CqUEqd+gXZtLYUJAMU8wZz6Wv+yhyZrCpZfBeGdMnzDu
         nSeeCjS/8zW/wlMOUMW6PNWS+FrYifeZGkWOugyIMNUOzT0FbNVESE3TUghS1LZ/w9CS
         feUbnYOp8GXUZyAYD31PI4JzB/IG1Ba1JUqfZOngSw6/y3AzxWr8Lizx6iOX4hcqrJOL
         aHnxuuxs24cJwkxt0jbK+lchW1Ha9z2hNcZ640mysQbbUl+tEXoxvXxBavmZQqemjjws
         cCLQNU0imZhtQuSZ8QBkwgifTWocuNwZD9cd+jEOXajXw821yovCyzAn6lig4DNN2AvG
         hkqw==
X-Forwarded-Encrypted: i=1; AJvYcCUC81rvxKRa1DOTXOxrM4OVPBqC071+LFsNn/sE1t0xp7/C63KpkjSI5YS7ydD9Law/Zypcx9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DqOLCJRRWBQ2+Kc9fCoR/7FNALcOsZKULpbIfuppgXw6/GkR
	40WhPNTF5MFNMaLUzAGltMP/uaolbBIlqNl3qiWPvLdc55KF2H7QKdkTQjEyvSLMVDIceg4lrbW
	fLwLCOIbu8BUvLg==
X-Google-Smtp-Source: AGHT+IHsMqhR+FC1Vaoc1hCDg2gMTNywVUl9RwkU/LLcAQVairjJf0TCsVawP0vFsJexqsUgLxEVKVJAb9sjRQ==
X-Received: from pljc15.prod.google.com ([2002:a17:903:3b8f:b0:243:31a:f8e2])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f85:b0:242:cf0b:66cd with SMTP id d9443c01a7336-245fed69268mr38021605ad.34.1755784527309;
 Thu, 21 Aug 2025 06:55:27 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:55:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821135522.2878772-1-cmllamas@google.com>
Subject: [PATCH] netlink: specs: binder: replace underscores with dashes in names
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Li Li <dualli@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The usage of underscores is no longer allowed for the 'name' format in
the yaml spec. Instead, dashes should be used. This fixes the build
issue reported by Thorsten that showed up on linux-next.

Note this change has no impact on C code.

Cc: Jakub Kicinski <kuba@kernel.org>
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/e21744a4-0155-40ec-b8c1-d81b14107c9f@leemhuis.info/
Fixes: 63740349eba7 ("binder: introduce transaction reports via netlink")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 Documentation/netlink/specs/binder.yaml | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/binder.yaml b/Documentation/netlink/specs/binder.yaml
index 140b77a6afee..0f0575ad1265 100644
--- a/Documentation/netlink/specs/binder.yaml
+++ b/Documentation/netlink/specs/binder.yaml
@@ -26,27 +26,27 @@ attribute-sets:
         type: string
         doc: The binder context where the transaction occurred.
       -
-        name: from_pid
+        name: from-pid
         type: u32
         doc: The PID of the sender process.
       -
-        name: from_tid
+        name: from-tid
         type: u32
         doc: The TID of the sender thread.
       -
-        name: to_pid
+        name: to-pid
         type: u32
         doc: |
           The PID of the recipient process. This attribute may not be present
           if the target could not be determined.
       -
-        name: to_tid
+        name: to-tid
         type: u32
         doc: |
           The TID of the recipient thread. This attribute may not be present
           if the target could not be determined.
       -
-        name: is_reply
+        name: is-reply
         type: flag
         doc: When present, indicates the failed transaction is a reply.
       -
@@ -58,7 +58,7 @@ attribute-sets:
         type: u32
         doc: The application-defined code from the transaction.
       -
-        name: data_size
+        name: data-size
         type: u32
         doc: The transaction payload size in bytes.
 
@@ -78,14 +78,14 @@ operations:
         attributes:
           - error
           - context
-          - from_pid
-          - from_tid
-          - to_pid
-          - to_tid
-          - is_reply
+          - from-pid
+          - from-tid
+          - to-pid
+          - to-tid
+          - is-reply
           - flags
           - code
-          - data_size
+          - data-size
 
 mcast-groups:
   list:
-- 
2.51.0.rc1.193.gad69d77794-goog


