Return-Path: <netdev+bounces-238681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A5AC5D838
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 016F24F2C10
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABEA324B3E;
	Fri, 14 Nov 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0FJNJQhY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995701B87EB
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129214; cv=none; b=XpbNvovTshAlwwiMIqVY6O8kFlbHCTyuc7tj60wTdm5gXd0x1QL2aziN6t5hXyLvlhEupCuQXEMw7GL5glSeqQKgztwTkNyLIVOngcvgzxDCXmp0HXpw8YXDzgZK0DBgCWFuHZPNQslSC87qTgr44UfMFdL0mptqKE9Nfm/bam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129214; c=relaxed/simple;
	bh=8CNdMewGsx41bEggjctKUhb3l/6G3t2HoNXMXWwEL3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V4ukuz9IQBjReXs++pbau3Mo5/4TyjDAEYOJqJfv6ylID4h0ijeR5WLxAL/Y0F4bqRTVp8tlo8wKIb4DVRJBVh92Gnlw60de6YGiQKn8E172lpYbA6ySgk4EVZgCJh9/PoJ3FFNJV0h4qwL5kVMVNPSdu6M+kTljKiPgS36mcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0FJNJQhY; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b259f0da04so540398485a.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 06:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763129211; x=1763734011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wE+vpHPbepYVrAYzO9oSKhRrZzx0m16Vg36Pmk/k+7w=;
        b=0FJNJQhYGphQ3500DbfcDZRCex9ISiq+uj98tmcjaGLedRv/2D+E9clsib18GrqDRc
         9bw/lNz9S+7yJH8z1PrX2pPsB88Nyk0Q7BlfRs+/di/XjpPBiC0c8IuwuCwUAhpBXR8/
         rIIs1gqjRTm3RmS5i/UjFBmqdwKQVRFEJyVi7dms8nkqYFVvOZET+zqAGqqSH+VOjMrs
         JeM/DxFm01E1z6/4iPkPot2tojJv3t9gKUVclvn7k2ZpqV2a3aSRw8yEvzdl1WrLEYwf
         vMl7obzf1kyx6dM7FosKhAq7uE1XRXwh3AnUNLmDKHUuc7EFgF4cx33Wvms4WDAEYHYK
         XSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763129211; x=1763734011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wE+vpHPbepYVrAYzO9oSKhRrZzx0m16Vg36Pmk/k+7w=;
        b=k09XMl4bHIUvxL9P10DcP/+BrdVghLM1fJi9tZoNIZlidLub7lnOSHDlgpBrXvOKdV
         0lnsFCDydUN4BiB7/AHJxa8WSDGAvgiXpyqSGAVGE165agZAJc3GNPNVAysIilakWHnk
         j/kp+30NXiEKctg3wWGTYjH+6RoYyodavEnKv2bzQIT1ioYevrDjLaG/dkY7s91iyRG0
         1maQTst1oT1HUWapiNd1uXtUO8nQj+CwC7/notgI2oh8BZT1RSFBo9GEIflbw3H3W1PD
         kOgjfSilkZ4vevUAGyV0ri+44Au+lKworN09uPH6yC1loG1vNt6sk5SYgwNjL88D6SKT
         CH+A==
X-Forwarded-Encrypted: i=1; AJvYcCVl/gGzTDT+UsZD7HC2DDpsF9UTh34v3zQVOagHoHnMSoqVVKURJ3muGjVCq+b/Xq7pyqJvL3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGPOFOY0bP6C5PU2kTirTT9yFCvJfOTRboJN6sNazP39s9VnL
	dOd5vtixv6R35ljrZn8C4aLS0t7gG6VG1NafgSRg3Ti4XaRqT8n0tMjNPKEdxbG6hpeOKA3v62o
	lUntqbg9h054yfg==
X-Google-Smtp-Source: AGHT+IERsD2Hotq/N9BuslL3Nt6Isjtbmmy0g7XfPf6uSCNXSmONnk3+qeMEeYBMbw/paPedg5dsNWG5AFOC8w==
X-Received: from qknpz1.prod.google.com ([2002:a05:620a:6401:b0:8a4:f21b:9d75])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4095:b0:8ab:5cb2:1f68 with SMTP id af79cd13be357-8b2c31b8ed3mr370659485a.69.1763129211372;
 Fri, 14 Nov 2025 06:06:51 -0800 (PST)
Date: Fri, 14 Nov 2025 14:06:46 +0000
In-Reply-To: <20251114140646.3817319-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114140646.3817319-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114140646.3817319-3-edumazet@google.com>
Subject: [PATCH 2/2] rbtree: inline rb_last()
From: Eric Dumazet <edumazet@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a very small function, inlining it save cpu cycles in TCP
by reducing register pressure and removing call/ret overhead.

It also reduces vmlinux text size by 122 bytes on a typical x86_64 build.

Before:

size vmlinux
   text    data     bss     dec     hex filename
34811781        22177365        5685248 62674394        3bc55da vmlinux

After:

size vmlinux
   text	   data	    bss	    dec	    hex	filename
34811659	22177365	5685248	62674272	3bc5560	vmlinux

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/rbtree.h | 16 +++++++++++++++-
 lib/rbtree.c           | 13 -------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 484554900f7d3201d41fb29e04fb65fe331eee79..4091e978aef2404b56d7643d9385727c69796678 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -58,7 +58,21 @@ static inline struct rb_node *rb_first(const struct rb_root *root)
 		n = n->rb_left;
 	return n;
 }
-extern struct rb_node *rb_last(const struct rb_root *);
+
+/*
+ * This function returns the last node (in sort order) of the tree.
+ */
+static inline struct rb_node *rb_last(const struct rb_root *root)
+{
+	struct rb_node	*n;
+
+	n = root->rb_node;
+	if (!n)
+		return NULL;
+	while (n->rb_right)
+		n = n->rb_right;
+	return n;
+}
 
 /* Postorder iteration - always visit the parent after its children */
 extern struct rb_node *rb_first_postorder(const struct rb_root *);
diff --git a/lib/rbtree.c b/lib/rbtree.c
index b946eb4b759d3b65f5bc5d54d0377348962bdc56..18d42bcf4ec9d581807179f34561f4561900206d 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -460,19 +460,6 @@ void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
 }
 EXPORT_SYMBOL(__rb_insert_augmented);
 
-struct rb_node *rb_last(const struct rb_root *root)
-{
-	struct rb_node	*n;
-
-	n = root->rb_node;
-	if (!n)
-		return NULL;
-	while (n->rb_right)
-		n = n->rb_right;
-	return n;
-}
-EXPORT_SYMBOL(rb_last);
-
 struct rb_node *rb_next(const struct rb_node *node)
 {
 	struct rb_node *parent;
-- 
2.52.0.rc1.455.g30608eb744-goog


