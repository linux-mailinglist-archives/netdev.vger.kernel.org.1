Return-Path: <netdev+bounces-248019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DAD02950
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D360035D7E15
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDC3793D7;
	Thu,  8 Jan 2026 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zV8Id+ir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31B3659FB
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864776; cv=none; b=Fz9608cH+2Er6Fz4RXnx10tD2SBEh7cAMLsUUyCblS5Q4GPoqd4dusFfN8cbPkxf8n+XUFTutaML3vsmxMPgnwlm2wvlXKhk+8a049ltdgm6hVV0JvAJNxhf9xFnbv6voOMp9FstrvebNBTRoa3DXyr/A6Q1feIXfIW04XpaMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864776; c=relaxed/simple;
	bh=HB1aYQ38Ehr6jAsxsm7H/sf7+3UcedO4CKZuNa5mLKg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a6pkTicSqkHCxb1jobpYgtggQyERFyPyh23G20B5nXl9rpIBLj6muwtbq4zWHtZUH0NqEdggUSGxNpLKeHoKGxi2W3sY6yLliMOE6Ku5ep2bzsvsSna0kJ/WcRF3xW1Nv4cNkMoAqwmzRMRato747D1Ctc00/FN/0ePlCisXhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zV8Id+ir; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a366fa140so53928986d6.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 01:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767864768; x=1768469568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vDzdUm/TFOcZ1qORmw+T2FqCgEjXNFwcS7Hs4V7eonY=;
        b=zV8Id+irabKsB7KtYKLpH+VefQUb9PpGNyiUtaLHkEwq4XxsILG0NIMuyly13OTQ2z
         9V312vYAG/fljhyWqpEZsX+dI3RACCMCNl6hljf9EX5yH9oROqCoAp6VXX2kFBDxH73Z
         zGJws4Tt1GKD6UVnJ6xnMWxW2vHxP6uC0zoZHfLBPaAJuGWFTa+RtLFs6+Ucmd58M29G
         mZbBBwTtW66Yum/KugPIvdfEKhM1QyAGn+MnCbmIjNvNCzu7eP/essmzgZIGXBvkvulR
         67zaUWf7gaazv+1UDUMKBg40R0gD0dAqXM5Ain/AMLVdhY39an3lsxSzRTMt5oPLOyt0
         +dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864768; x=1768469568;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDzdUm/TFOcZ1qORmw+T2FqCgEjXNFwcS7Hs4V7eonY=;
        b=Z2B7Cs9sQM3EqD6s0XFY9f5L111Ln6dpLSWL/+G+0Co8Y9k9TeyzRNiuHG3M1yBLif
         EFWNrf9JmqJgk9p5Olr7BCV/z9L3UQhzoHSK76f+Wq41RKQcYq9uHM+CmXXnwySS+9PA
         cvXHrO7mnCZ2EJ7cVsRcDwdQT5m9zvsm+XEESOEf5MacAepYXyNQqN+nZCEVIhO9VFGG
         Ek9GvJ54WhMk2o1ePPXgzOCZvqgOmE7SrYJOcRnh7MU4lDLGOyGFsdcgH02E3ZlKgigc
         mZfnD11i/kftEOmDNXT5cZNLtjfYNGsgzgyjQ13i1z7Cmhr8vTESD1lp1rRAd5xypO4c
         L2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXqkBA/7P2S79HfT1ACLAWPk0akRnbQY3fSTQ4PBpvGFjffztjogiXA1scsJf/OMQZU3fp6ncM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsCw1MSQqAKYAnchC3hIJRdDplrP3CdtYGDVq5lzjRO7NzGMg
	RgE0F8hJDOrCH71tz7aFzO3tPgOJJMU6ivbNnOHjU4umTQOQS2AtYLlkrEGnKxbPL8bTAGRwbEO
	MtHkgRErTRbOfQw==
X-Google-Smtp-Source: AGHT+IGIMWF0bH2p5rn9Xs57lmJylJd/H3dy/M2vGjOQ+rcuwA3UKhoIMkJw+WQE7KSO7XhUrBBoGpo3xw13/w==
X-Received: from qvbld26.prod.google.com ([2002:a05:6214:419a:b0:888:3b63:e0cd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4b0d:b0:880:264b:7c5c with SMTP id 6a1803df08f44-890842b4931mr73044466d6.61.1767864768300;
 Thu, 08 Jan 2026 01:32:48 -0800 (PST)
Date: Thu,  8 Jan 2026 09:32:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108093244.830280-1-edumazet@google.com>
Subject: [PATCH v3 net] net: update netdev_lock_{type,name}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add missing entries in netdev_lock_type[] and netdev_lock_name[] :

CAN, MCTP, RAWIP, CAIF, IP6GRE, 6LOWPAN, NETLINK, VSOCKMON,
IEEE802154_MONITOR.

Also add a WARN_ONCE() in netdev_lock_pos() to help future bug hunting
next time a protocol is added without updating these arrays.

Fixes: 1a33e10e4a95 ("net: partially revert dynamic lockdep key changes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v3: add IEEE802154_MONITOR.
v2: add NETLINK (Jakub), VSOCKMON.
v1: add CAN, MCTP, RAWIP, CAIF, IP6GRE, 6LOWPAN.

 net/core/dev.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037edb1506e67f6ab5e977ff41efef59..9af9c3df452f7f736430c2e39d16ef004aeaae4b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -478,15 +478,21 @@ static const unsigned short netdev_lock_type[] = {
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
-	 ARPHRD_IEEE80211_RADIOTAP, ARPHRD_PHONET, ARPHRD_PHONET_PIPE,
-	 ARPHRD_IEEE802154, ARPHRD_VOID, ARPHRD_NONE};
+	 ARPHRD_IEEE80211_RADIOTAP,
+	 ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR,
+	 ARPHRD_PHONET, ARPHRD_PHONET_PIPE,
+	 ARPHRD_CAIF, ARPHRD_IP6GRE, ARPHRD_NETLINK, ARPHRD_6LOWPAN,
+	 ARPHRD_VSOCKMON,
+	 ARPHRD_VOID, ARPHRD_NONE};
 
 static const char *const netdev_lock_name[] = {
 	"_xmit_NETROM", "_xmit_ETHER", "_xmit_EETHER", "_xmit_AX25",
@@ -495,15 +501,21 @@ static const char *const netdev_lock_name[] = {
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
-	"_xmit_IEEE80211_RADIOTAP", "_xmit_PHONET", "_xmit_PHONET_PIPE",
-	"_xmit_IEEE802154", "_xmit_VOID", "_xmit_NONE"};
+	"_xmit_IEEE80211_RADIOTAP",
+	"_xmit_IEEE802154", "_xmit_IEEE802154_MONITOR",
+	"_xmit_PHONET", "_xmit_PHONET_PIPE",
+	"_xmit_CAIF", "_xmit_IP6GRE", "_xmit_NETLINK", "_xmit_6LOWPAN",
+	"_xmit_VSOCKMON",
+	"_xmit_VOID", "_xmit_NONE"};
 
 static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lock_type)];
 static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lock_type)];
@@ -516,6 +528,7 @@ static inline unsigned short netdev_lock_pos(unsigned short dev_type)
 		if (netdev_lock_type[i] == dev_type)
 			return i;
 	/* the last key is used by default */
+	WARN_ONCE(1, "netdev_lock_pos() could not find dev_type=%u\n", dev_type);
 	return ARRAY_SIZE(netdev_lock_type) - 1;
 }
 
-- 
2.52.0.351.gbe84eed79e-goog


