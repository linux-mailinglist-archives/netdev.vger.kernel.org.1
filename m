Return-Path: <netdev+bounces-142056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81E9BD3A7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A5C1C229BE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17EB1E7669;
	Tue,  5 Nov 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J15mcQln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D81E7657
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828656; cv=none; b=VxF/4g7n6ghBNK71myHGNU/IapUfmIB4pvlgP+usbZiD/sE+9fxWKd7XcSjhclgqzcJQ08e/ymq0YdpvmkyEeGrNt/iEZGZgembnTZhZ4AjO+No2pQ/qF2QB232+9k/jhntwfy8C7sUBU/bWs/nsEOr2bQ/1jmQVy22H48PqgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828656; c=relaxed/simple;
	bh=kVUo6zaBQi9wbPpamGGxhKLe03edUpxv+cWu3BPgKGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FO9gkUklJXD0y2M72DJaV3lPA9p8cARSuT/fFfa5VMshwKdyGCsHj1oPeAr5QQfakJfSS7qrEyk/p6/Xcqb9cdVjRQRh/Zisv4fk5VojZPbx4nWM7yCvqh9DFdLJpw0UoblyN+CQNI1JW71bFZTNpVzXepXjbX3Dc78tFV3IQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J15mcQln; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea6aa3b68bso70711877b3.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828654; x=1731433454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkFhoBGw2fMX7qk4RY7eJRvFEk6qririOfq2q/JTD0k=;
        b=J15mcQln1vuqgA+048jQZxAsNDm4n4Vd2hblSXdW4hQj/xHDGPLlCD+Gc1OkA4RKGb
         P9eD5H5zQ3uxidzWcNf6Qy0hbhKUkcmRQo/xykYfOhz3RqzBsctStb/EpT6crtuzw1pA
         zf6iKR4dmFWvF8xd/wC9WIa0qvKJNv67ggzYPfT9G2a1ym1xn9DUfuSjjvdWdm+MochJ
         YaLwcdGEXjR1Oc45fKTyUDYGxXwht9LO4En0xoAgSceM0nJSvAUGUK0puoolGoduFU+m
         BMCAeaDh3zuIIF+lfUtBdvJAk5eBZZoZcC9x8T6lsyILRsXQE6dtBA25k/X4wyKB3xEl
         Zdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828654; x=1731433454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkFhoBGw2fMX7qk4RY7eJRvFEk6qririOfq2q/JTD0k=;
        b=gi+gMXeeXLW0Pp8M+V4jPkYw95YKWFqP7YIfUnTVLV1t1qARx8cGZGnYb9VNuBZ/rL
         87IQYLU1YpJVxLgQ8C50OY4Uhb36OSK55uDegBKl2hhCyTw46C5zfat/Tj8n7Wh06hY+
         CInq1tZ6wy52bMhYMocO0e+zxtrm8tspNuvfhMW17kgpU8MgYyE+7o3Rc5VuAu18pp4R
         Bt2paiTDBTziBafp8GuCkzTYSvJU0BMRwmMtqtWf8qloKYtr5R+BuhAMOb8GzQvEfIdc
         lRy6Ah8dOlYOZQWwbw5QEhrjAXKvSAIe1PpX8PARzRm+xctj+ID3+BAUY6+3iBv+BY6y
         rBHA==
X-Gm-Message-State: AOJu0YzoUcryusJSAyvmQh7HQN5fp0J4DmjGUB4SIZ7WSPDllU+ZbIBd
	fmj8y2C+xKnXIR+yyz3Xwm78tYX/gzSZ2D5B/OxT0dI7OjtVSCg6jqFJnHzc/TGN5TpRK1myAfr
	LWO7maBsP1A==
X-Google-Smtp-Source: AGHT+IH5s+0BMJidg8HcVXuPqjML0RNhP9edcQI9ULnlbtEHO+PQyDLD5239sZGwAzR4qWd1GrWD67UhELyN+Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:998d:b0:6ea:34c5:1634 with SMTP
 id 00721157ae682-6ea525566admr1103877b3.8.1730828654390; Tue, 05 Nov 2024
 09:44:14 -0800 (PST)
Date: Tue,  5 Nov 2024 17:44:02 +0000
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105174403.850330-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105174403.850330-7-edumazet@google.com>
Subject: [PATCH net-next 6/7] net: add debug check in skb_reset_network_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure (skb->data - skb->head) can fit in skb->network_header

This needs CONFIG_DEBUG_NET=y.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f76524844e7edc5fe4e0afc27ce71eed7fbd40f9..f1e49a32880df8f3716c585d13c1085a2183978a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3027,7 +3027,10 @@ static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 
 static inline void skb_reset_network_header(struct sk_buff *skb)
 {
-	skb->network_header = skb->data - skb->head;
+	long offset = skb->data - skb->head;
+
+	DEBUG_NET_WARN_ON_ONCE(offset != (typeof(skb->network_header))offset);
+	skb->network_header = offset;
 }
 
 static inline void skb_set_network_header(struct sk_buff *skb, const int offset)
-- 
2.47.0.199.ga7371fff76-goog


