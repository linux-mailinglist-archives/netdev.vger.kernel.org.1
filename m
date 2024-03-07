Return-Path: <netdev+bounces-78407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2441E874F35
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 13:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35FE2814BC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3322D12881C;
	Thu,  7 Mar 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+xoelLE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B712B141
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814890; cv=none; b=WEpZ2X+UcXpUMXcreCxtrmV/F8yYrNvmNxBFRDKdpPEwPiWYpmhc8FsFXB92dWRTkAhE8dvk+j0MMukWXXr07r9NO1jeVMWsghP/N0Gr4Yvpahj6DcQ13E3CaSX+H7hOw31zf35Nu+sHf86g0KRYbLdu4sdp4mXOBJMCpy8vuhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814890; c=relaxed/simple;
	bh=e6KSUwN0sekswoiFdP6GDKC2InvN+qRTRrOhFgJO7jo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cipa35nfdSHFkR4aZpToEYFTkybwhmQHL25t2t0+8v5aRFVNKHsqw8MpQYGuaJei+2VVXpxkr5a3jNgXc1F131kpbQ+5x8YMw+RTFwD/77TNGHOkDCijFB1AO2qyLlEUeHEiUArPV8v7ZK5ellx092ZGgRZktZaRHT944W3A958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+xoelLE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so12570417b3.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 04:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709814887; x=1710419687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=noz4zhVkHcL4QKsBJqE5wiswrwuI+OzYHE9Vf0PMNkM=;
        b=o+xoelLENpmICmMNMnjGXU57OUNk7YFSvraUc1llgflb3OBZFSmyTt26hSY9hJ13jS
         gtEBWOECTMpoTSMbt0FCoxbSjz165pYxP/h8gqHWRxthWWAigLBTjJg4Tq0ZSweMigP0
         bPyXs0bEbsvqHjU26bRsy+gnqbGhoxKtQHR+cN+LGmoGf/Ttkg4uTTNuM02yfXyETroU
         LkuALTWhZnVLY9309CcFHYBGx5Op+ABLekeSLZbC6nvOsVMKMiB6fPQ28dQPPqMfgtQ9
         woVKrzNr9HRG9Mi7/eQyu5hu3yNceSW6GDnk9m26m1+xXyy0oNxJWrDj9FfYmzv49wrT
         +9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709814887; x=1710419687;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noz4zhVkHcL4QKsBJqE5wiswrwuI+OzYHE9Vf0PMNkM=;
        b=r22ValdejO1uMlp0xT9q3WNdkhk3i5Xk2QprIyZL5WW+Ykhv9yyjctheIuAIianFCq
         1CP7YNDfeyinVs2rj6T2mUnP+bKdEPQg32bgtvjL/LxoUJCa/XgckKsURKRFNq/lTMg+
         xboom/4escHfn7SPYLIQI8D4o7IhwgX5JEiPSw0wY293DvYnC3s/0JbDewWmrrPMR8dx
         rxM6Rc99DTAEoVU1v2VDOezyYo4pNzQoZrzSg6G6USHq8tQfES6BMEIittx8tz4Qdo5R
         cwEAHKliF8/5Si5RKoOmGhWbiM+kUT6x0R9QEUyj25357rIXmLsAcDegCnOh9Dd813gJ
         7v3g==
X-Gm-Message-State: AOJu0YzgcJbGDV4yHqjynNrKMFtBHIWlJ6vIZcG5lE57InG1+oIyApO+
	VQBsnsIubUtdaYjBYxC/S7LXfb4bFcZLy3IxiXP1UjDI8pxHfz4YhgLXSi4E00/e/n/SPvoEocI
	A/pJe2+3UPw==
X-Google-Smtp-Source: AGHT+IGAyAuRde4MyhC7VgiOQdAI4x//vfyafx+c244nN1UijHrsuvlbN9886GJwhelEML9RXyLqyWCmLDgCRQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:dc4c:0:b0:dc6:d1d7:d03e with SMTP id
 y73-20020a25dc4c000000b00dc6d1d7d03emr770197ybe.8.1709814887466; Thu, 07 Mar
 2024 04:34:47 -0800 (PST)
Date: Thu,  7 Mar 2024 12:34:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307123446.2302230-1-edumazet@google.com>
Subject: [PATCH net-next] net: add skb_data_unref() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Similar to skb_unref(), add skb_data_unref() to save an expensive
atomic operation (and cache line dirtying) when last reference
on shinfo->dataref is released.

I saw this opportunity on hosts with RAW sockets accidentally
bound to UDP protocol, forcing an skb_clone() on all received packets.

These RAW sockets had their receive queue full, so all clone
packets were immediately dropped.

When UDP recvmsg() consumes later the original skb, skb_release_data()
is hitting atomic_sub_return() quite badly, because skb->clone
has been set permanently.

Note that this patch helps TCP TX performance, because
TCP stack also use (fast) clones.

This means that at least one of the two packets (the main skb or
its clone) will no longer have to perform this atomic operation
in skb_release_data().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 18 ++++++++++++++++++
 net/core/skbuff.c      |  4 +---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5c3b30a942d092f583d7c7c81cf0c7ad88f32b48..687690c5646b8d6e82d9d757ba5f358091f4e155 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1237,6 +1237,24 @@ static inline bool skb_unref(struct sk_buff *skb)
 	return true;
 }
 
+static inline bool skb_data_unref(const struct sk_buff *skb,
+				  struct skb_shared_info *shinfo)
+{
+	int bias;
+
+	if (!skb->cloned)
+		return true;
+
+	bias = skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
+
+	if (atomic_read(&shinfo->dataref) == bias)
+		smp_rmb();
+	else if (atomic_sub_return(bias, &shinfo->dataref))
+		return false;
+
+	return true;
+}
+
 void __fix_address
 kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 532cd394d6cbe7b1242308154b38121574ab3845..bc41e74c9c66f0b84fd9f78b863d02033036f0a5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1115,9 +1115,7 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason,
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	int i;
 
-	if (skb->cloned &&
-	    atomic_sub_return(skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1,
-			      &shinfo->dataref))
+	if (!skb_data_unref(skb, shinfo))
 		goto exit;
 
 	if (skb_zcopy(skb)) {
-- 
2.44.0.278.ge034bb2e1d-goog


