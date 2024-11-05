Return-Path: <netdev+bounces-142057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4121B9BD3A8
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCE6B224CC
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625D1E379E;
	Tue,  5 Nov 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPBs4epo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103491E7674
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828659; cv=none; b=O0SBO3I/3jDNS7z2MCQE9ia6/NIfQea0g90UX5BwVJ1W2w4VqYdEuL4pHWcengKxegerOydi5dmHnBl6uEAv8haDsPpgkbsnvwO0JzwqSLVGfZJRhLUopQ6JVPhJWDH5288dleLp32J4qoC6yvMjVI6VGOBp82UvxsiCumhYJJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828659; c=relaxed/simple;
	bh=4CoG5ztSfhB+vYqibwMru86twfsf2jRlsBKwksiaUPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ef3C39thLnrEqy6jt8IlvvC6kTla1e5VH/O2HNyAHhV4g4rWyPDdOjjQAiM5T0YoagYbTAsBXuOPbVQ2h3BLae/fPPbuDajgpN42yt0c9jwPgYuYYmndJlugsPjy9aTgpn8P38y21WMugq9jd6xH4P1PcSgMirxVThbA5NkoOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPBs4epo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e293150c2c6so11973459276.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730828656; x=1731433456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2xIpKVQIkM7eoYB+vOYUgDYcFmV577zVnf0QyWtYmM=;
        b=zPBs4epoyMa2DT11Ih0CBMa56dXKj4y+6Dlf4/mUiR6qe4rDLgBCmT1mN1s9qIw8DI
         3rzOUDzv5hXZqyHxwwM0Gk3jhu9sWz3tbtIcmzSzBSfcQjAKdopVxrce2MjpDQXqLbxZ
         BSXgWpi/jnJyC0M/asUS+AgqVfPeDabazFpd9LOeYvV0y9mBvWZm2Y6oGJjk2XMPlsqa
         8/O/xlBaIMWgd3TSoiexXe9hLM2owlK1+puhXmNPE81yi0kMoFBQr1/1NzOkpmtFxW7g
         s+ApBx6+3YgLRArxV36R9N0vYfgYlp17JJ3d0V31wxOjM0H2TksazN7Wu9KeAMDe8Ww0
         jWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828656; x=1731433456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2xIpKVQIkM7eoYB+vOYUgDYcFmV577zVnf0QyWtYmM=;
        b=K0Edntw74ZNLKqzC9rPyQ3XLot492uNbYmYZi/CKUCy3Wgys9RwcGAGYXOXTTzJMA2
         8SGsavyHJKCjCnhLiEX4P8QZquqIMU/3ly+SHpEdlRa8PZi9PVBrFzRCNnzSHw/njM18
         6VcI5GiEfzlNL4PygpYiGAoHVJlWYTmrkUDGsoNuQ6kqKP7W7SW5MaiA9VFYirNmASFQ
         MznTCA8BNWgmQeDn2FxJN5osD9hJv01hu3D6cANbISFbs+AZIQn93lYKZKwpnkE8sq3Q
         eMhx7xarnfW0KBa1yBvbD1y9wded4PCA6qnikVNBbsQVuXuKQp+jtHoGtNAmi/pazJ5A
         wfHA==
X-Gm-Message-State: AOJu0Yxhy/h4jEUJv+SH8SvYW2CZPa+PkR9eQjEcW6KJlYjzTb9fSHxQ
	4Zb5aiX0ZLpvZeQ4PiOqlGW2+OBWW9bAMRg5sSIpvnugF+6V2+qbXo6Tbwsg0hElCK07rDuP+wE
	OfIX+Do68bQ==
X-Google-Smtp-Source: AGHT+IHuptGGLFCS0l+E1J+sCfNq6XUuYmz1xc3jw8jSb6X7SlAhgLgvWn2zHXJ14S/ygJDgKciTlVRyX8uDyw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:a2c3:0:b0:e2b:d099:1a7c with SMTP id
 3f1490d57ef6-e30e5a3e458mr12118276.3.1730828655882; Tue, 05 Nov 2024 09:44:15
 -0800 (PST)
Date: Tue,  5 Nov 2024 17:44:03 +0000
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105174403.850330-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105174403.850330-8-edumazet@google.com>
Subject: [PATCH net-next 7/7] net: add debug check in skb_reset_mac_header()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure (skb->data - skb->head) can fit in skb->mac_header

This needs CONFIG_DEBUG_NET=y.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f1e49a32880df8f3716c585d13c1085a2183978a..e5095d75abba18c5c5301ddc39c40cdcf5e528ed 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3063,7 +3063,10 @@ static inline void skb_unset_mac_header(struct sk_buff *skb)
 
 static inline void skb_reset_mac_header(struct sk_buff *skb)
 {
-	skb->mac_header = skb->data - skb->head;
+	long offset = skb->data - skb->head;
+
+	DEBUG_NET_WARN_ON_ONCE(offset != (typeof(skb->mac_header))offset);
+	skb->mac_header = offset;
 }
 
 static inline void skb_set_mac_header(struct sk_buff *skb, const int offset)
-- 
2.47.0.199.ga7371fff76-goog


