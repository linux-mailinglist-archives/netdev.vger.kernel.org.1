Return-Path: <netdev+bounces-247394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D4CF96F6
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 264CB3012775
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2EE33C1B9;
	Tue,  6 Jan 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBgYGi3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374933B6C6
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717822; cv=none; b=TLs2+kbuMLEJGBp68O87QtN1GFI3Mb4K1KCaA12Axm8bELTRlUWF5K5Je4OjSEAbAyDRJQaj8JZdCKzWnYoIIRX8SUwvOm9XRYQxS3T1f3dDF+AtkFsztg3F36dZmrEucDluk3I4bDMgeeSi1/v2L5QNYqTVECD2x4ja90+D1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717822; c=relaxed/simple;
	bh=/4gcnnVYDuRCHjUXY2veiWgPzLfHL13cbAY+Oohk7qc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qnzLRNsBUW3jefeE5TuySGs9fr6prE+67ue1VRLVgdXK/WYbAiaX8hQeMFp+44V+6dhXysiXMofKyMhBTooCrviUTif7GN7me9ni8CK9qkmaBlFu3pX4Br5dSwP60U0EzbPJhwSX8IPcOBiAZDiStD4ySlncyuUCQPh8zbs4I5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBgYGi3K; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-790656ac3faso19976667b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767717820; x=1768322620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JtQPTk1wkPuWk2efdJyOGAR4spm5fHkvLptds51mJgA=;
        b=PBgYGi3KPG8+918mZWa6+wrih5Cs+bBcBZDXVSY0ct09xnKIyJn13CAlNFPwQpSS9c
         O7qafRdphcIqlebXZCYxO2GdINIRqklmoQwYrby6hfOZgThHIEY2bIWiBOuJAivYF4Wx
         lhMXJSglSzfQsVqhEvAwWj9l5YXe6G7ozkt0n3Yb5NHk7tQbmCQU0zkvOc9dyRw7OIbC
         rb2xMHKUBk2hjRXdeADpWen1WHsWCcnKARzKhREpLhBfikoHz3cpYeDI7sQAHCctKYvg
         W2Xh51Pg7TgIb8EMTcmpUZRIwNePKNYAp9LvSf+BndY30hnF7iwvoNUpd7yOSRAQtr+C
         W7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717820; x=1768322620;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtQPTk1wkPuWk2efdJyOGAR4spm5fHkvLptds51mJgA=;
        b=lq539tNQwmhmq+dsYG15uzveEEkpYVNEAmrP85cPBfNB3sMB9+JYfZhfo0DbyQuQYA
         kSbIMDA6yWFEqFnJi6KM7fRkLJxuJlJWkkwNIXXqYeHNup3OZ5ixKClrlokba+XIpzqe
         DWPpbAqYD4Yzifwr7vN7KTpWwjJUd953xwMswkgjs+4kYly3n6Wgf3CuXep0I6bcW4tl
         0tJHYATFAX4o0oJ0Fejh3b3C0eBuG1XukyxAqSBhOkpSQ5V9O142sJyVP0FIMSHkVRXP
         O1D4yv1g+Y/lZ9DlIjuGoPJeruiv/O2trX0s2deJbpBeDVA8W52zMt2RyVevtvdj0Kta
         UhDw==
X-Forwarded-Encrypted: i=1; AJvYcCXj2tn4za6VWe0zU5dD6hejuOMcehySsptTda9phsihQywbQ+roboZjp8vqTPnlO4FIYau9zEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCJNZgRJN+e2zn5FX7dZvqZozQXPabQ89i+y0Jh+M4J+xfdpE
	2vPii+9zzxmIAdjKS5EzufsTvDpIu/pF1GQeHtMIqIjsFrAGlmV3W/ShtNhptF7PwPhwDNtK02C
	9lKUD2Xm4lOy4cw==
X-Google-Smtp-Source: AGHT+IEhFMZgsIS46Ki1WjxEsDMSTKh2UJoG8f0myhacZzzhQl0PrpwbFMeIe8dQUf0T5CVkaPu+2TlpWOanJA==
X-Received: from ywbmp1.prod.google.com ([2002:a05:690c:5801:b0:790:acaf:4482])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:3805:b0:787:d188:528d with SMTP id 00721157ae682-790a8af0731mr28602557b3.33.1767717820119;
 Tue, 06 Jan 2026 08:43:40 -0800 (PST)
Date: Tue,  6 Jan 2026 16:43:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260106164338.1738035-1-edumazet@google.com>
Subject: [PATCH net] net: update netdev_lock_{type,name}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add missing entries in netdev_lock_type[] and netdev_lock_name[] :

CAN, MCTP, RAWIP, CAIF, IP6GRE, 6LOWPAN.

Also add a WARN_ONCE() in netdev_lock_pos() to help future bug hunting
next time a protocol is added without updating these arrays.

Fixes: 1a33e10e4a95 ("net: partially revert dynamic lockdep key changes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037edb1506e67f6ab5e977ff41efef59..5d6e69a7819a8967fcc5089b1797d47891fec4d6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -478,15 +478,19 @@ static const unsigned short netdev_lock_type[] = {
 	 ARPHRD_IEEE1394, ARPHRD_EUI64, ARPHRD_INFINIBAND, ARPHRD_SLIP,
 	 ARPHRD_CSLIP, ARPHRD_SLIP6, ARPHRD_CSLIP6, ARPHRD_RSRVD,
 	 ARPHRD_ADAPT, ARPHRD_ROSE, ARPHRD_X25, ARPHRD_HWX25,
+	 ARPHRD_CAN, ARPHRD_MCTP,
 	 ARPHRD_PPP, ARPHRD_CISCO, ARPHRD_LAPB, ARPHRD_DDCMP,
-	 ARPHRD_RAWHDLC, ARPHRD_TUNNEL, ARPHRD_TUNNEL6, ARPHRD_FRAD,
+	 ARPHRD_RAWHDLC, ARPHRD_RAWIP,
+	 ARPHRD_TUNNEL, ARPHRD_TUNNEL6, ARPHRD_FRAD,
 	 ARPHRD_SKIP, ARPHRD_LOOPBACK, ARPHRD_LOCALTLK, ARPHRD_FDDI,
 	 ARPHRD_BIF, ARPHRD_SIT, ARPHRD_IPDDP, ARPHRD_IPGRE,
 	 ARPHRD_PIMREG, ARPHRD_HIPPI, ARPHRD_ASH, ARPHRD_ECONET,
 	 ARPHRD_IRDA, ARPHRD_FCPP, ARPHRD_FCAL, ARPHRD_FCPL,
 	 ARPHRD_FCFABRIC, ARPHRD_IEEE80211, ARPHRD_IEEE80211_PRISM,
 	 ARPHRD_IEEE80211_RADIOTAP, ARPHRD_PHONET, ARPHRD_PHONET_PIPE,
-	 ARPHRD_IEEE802154, ARPHRD_VOID, ARPHRD_NONE};
+	 ARPHRD_IEEE802154,
+	 ARPHRD_CAIF, ARPHRD_IP6GRE, ARPHRD_6LOWPAN,
+	 ARPHRD_VOID, ARPHRD_NONE};
 
 static const char *const netdev_lock_name[] = {
 	"_xmit_NETROM", "_xmit_ETHER", "_xmit_EETHER", "_xmit_AX25",
@@ -495,15 +499,19 @@ static const char *const netdev_lock_name[] = {
 	"_xmit_IEEE1394", "_xmit_EUI64", "_xmit_INFINIBAND", "_xmit_SLIP",
 	"_xmit_CSLIP", "_xmit_SLIP6", "_xmit_CSLIP6", "_xmit_RSRVD",
 	"_xmit_ADAPT", "_xmit_ROSE", "_xmit_X25", "_xmit_HWX25",
+	"_xmit_CAN", "_xmit_MCTP",
 	"_xmit_PPP", "_xmit_CISCO", "_xmit_LAPB", "_xmit_DDCMP",
-	"_xmit_RAWHDLC", "_xmit_TUNNEL", "_xmit_TUNNEL6", "_xmit_FRAD",
+	"_xmit_RAWHDLC", "_xmit_RAWIP",
+	"_xmit_TUNNEL", "_xmit_TUNNEL6", "_xmit_FRAD",
 	"_xmit_SKIP", "_xmit_LOOPBACK", "_xmit_LOCALTLK", "_xmit_FDDI",
 	"_xmit_BIF", "_xmit_SIT", "_xmit_IPDDP", "_xmit_IPGRE",
 	"_xmit_PIMREG", "_xmit_HIPPI", "_xmit_ASH", "_xmit_ECONET",
 	"_xmit_IRDA", "_xmit_FCPP", "_xmit_FCAL", "_xmit_FCPL",
 	"_xmit_FCFABRIC", "_xmit_IEEE80211", "_xmit_IEEE80211_PRISM",
 	"_xmit_IEEE80211_RADIOTAP", "_xmit_PHONET", "_xmit_PHONET_PIPE",
-	"_xmit_IEEE802154", "_xmit_VOID", "_xmit_NONE"};
+	"_xmit_IEEE802154",
+	"_xmit_CAIF", "_xmit_IP6GRE", "_xmit_6LOWPAN",
+	"_xmit_VOID", "_xmit_NONE"};
 
 static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lock_type)];
 static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lock_type)];
@@ -516,6 +524,7 @@ static inline unsigned short netdev_lock_pos(unsigned short dev_type)
 		if (netdev_lock_type[i] == dev_type)
 			return i;
 	/* the last key is used by default */
+	WARN_ONCE(1, "netdev_lock_pos() could not find dev_type=%u\n", dev_type);
 	return ARRAY_SIZE(netdev_lock_type) - 1;
 }
 
-- 
2.52.0.351.gbe84eed79e-goog


