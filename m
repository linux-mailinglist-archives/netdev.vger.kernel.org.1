Return-Path: <netdev+bounces-247724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFDCFDD05
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7AA0307633B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FEE32695A;
	Wed,  7 Jan 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyiJ9FSI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172D3254A2
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790468; cv=none; b=FBo+AHu4PbvuQXHmidmwVZMwee2qhwavzKnhlPBfnZAs2HRh6CVKk0uMAj6LXVsCYcVgd9SfVsoCT1unHPmjBzfFNh6LWKTpunQ2OYBJYdwKxLEF45cEwGLgiSRWseUH2cqL1A9QoEHc4K5PXBGZI3Bx1KJ2LXx0t2+LaL4KQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790468; c=relaxed/simple;
	bh=FUFmJmTdDocRXw/96XkrSaYvc942WvcMN/x93ihGNjI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D5mZy3bRXmenVRHCB7bfuTR+gLX+FBIcHrHR2B7/+kplvRPdF8WugN/qrgXr2BPbAa1fLkz+QmUhh6XBZcjRbwPbmjFP/cAPJuKj3KWSskQF2zHy0CKKKs5dlnWjKU9MQ1EQ3ZMfIHcYFIIrsV6as0vg5Vh+sgPDvbsdBRd703I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyiJ9FSI; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a316ddbacso47337076d6.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767790465; x=1768395265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CewfA6ThORyWqRnwJkQK4StlOOBmmNyZJDASXdv9qFo=;
        b=UyiJ9FSIzHUGNb/+m2uBdF8ir3aTbYLPQnDt71/cF3vok+U8LcAfLNHOC0Fnqz6RQ2
         G+nk/3uGx5XlKfv44lQGHfqIPHxxxc8KpwLdnEVfc6NfONbTAOScm2pJkmTQuhO1uWRo
         31It4Q6MdPw1x+rWUK1OddpFfMYwBnRvLmgfFZJwPOiZzwfcIpRss3EtAAVAWRdGOj9W
         OECDyeVXVzHbe0+g5qtRCn+HloctALl49kL696mMLKoWc5JWnCam6/RHq9jZcoKOiM/l
         c1oIJ/HDI8uwZeY9fpSS8m4qpdHVU6QHAcPxoqMKBxyom3aKAnU0SwQhj4Wo2cFIp4ap
         NhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767790465; x=1768395265;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CewfA6ThORyWqRnwJkQK4StlOOBmmNyZJDASXdv9qFo=;
        b=nzsUADG98pLTwCTDmMsOOAmGaoBYxN0yPwcReuIwJ6U32n0fvkpi5m8VG4D3+Tym9t
         D4x1M4r/x0M41g6Oirbk090XniCrh3uhRrka1sgvK3+x/uMA+C6iKjIOufpvWLZE1ko/
         JHXGc281FvPVfP9P+QqQYEJVRRL0BzanMplWB55S7Ve5DpBrCI2XOuRY0GdOItEpCVWi
         AUjcJ/9xI3Ur7KKND1GSzFMjJhwESqYcNdlSgyTTnnuLHiVX0W1U6ifQMB06kSoxRX/X
         yNERcVZIIocwXusUVDpdakSeO8luiTQ5lE0MiL029n0b8qasG54utTayIppD4Chi/zOm
         BMAA==
X-Forwarded-Encrypted: i=1; AJvYcCVGap64aw5HQSjkze+4xIHsak0GZu94Er3kCWKnuV2Fmpm+6R6qWBd0uFuqD1zGdxzS3xFXYfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wxgPwXU8mF4yEbEsdXT2GYx+dToqHMBllk2nIxTQVTcF+NZR
	A6HyZBmsFO9wvMUfzbMqbqjxAEZN4JPgAsGDfsbkRQQg1QMzH/o8Gyc+8/gKC88WhFUD3c7iroy
	dwa1YhDn+rZfajw==
X-Google-Smtp-Source: AGHT+IFLEDbMp9vpxyWnoUConCBXaD0cR4AaymesIDyVmurIZVJnxn4gl391Gke7o4x60DQRpKbF6ZSjlLzytA==
X-Received: from qvbob6.prod.google.com ([2002:a05:6214:2f86:b0:888:3b63:e0cc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:e6c:b0:882:52fc:9acc with SMTP id 6a1803df08f44-890842770femr32539716d6.52.1767790465617;
 Wed, 07 Jan 2026 04:54:25 -0800 (PST)
Date: Wed,  7 Jan 2026 12:54:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107125423.4031241-1-edumazet@google.com>
Subject: [PATCH v2 net] net: update netdev_lock_{type,name}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add missing entries in netdev_lock_type[] and netdev_lock_name[] :

CAN, MCTP, RAWIP, CAIF, IP6GRE, 6LOWPAN, NETLINK, VSOCKMON.

Also add a WARN_ONCE() in netdev_lock_pos() to help future bug hunting
next time a protocol is added without updating these arrays.

Fixes: 1a33e10e4a95 ("net: partially revert dynamic lockdep key changes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: added NETLINK, VSOCKMON (Jakub)
v1: https://lore.kernel.org/netdev/20260106164338.1738035-1-edumazet@google.com/

 net/core/dev.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037edb1506e67f6ab5e977ff41efef59..fed0d4a991a13cc3ebed22bbce7f646ae2987616 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -478,15 +478,20 @@ static const unsigned short netdev_lock_type[] = {
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
+	 ARPHRD_CAIF, ARPHRD_IP6GRE, ARPHRD_NETLINK, ARPHRD_6LOWPAN,
+	 ARPHRD_VSOCKMON,
+	 ARPHRD_VOID, ARPHRD_NONE};
 
 static const char *const netdev_lock_name[] = {
 	"_xmit_NETROM", "_xmit_ETHER", "_xmit_EETHER", "_xmit_AX25",
@@ -495,15 +500,20 @@ static const char *const netdev_lock_name[] = {
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
+	"_xmit_CAIF", "_xmit_IP6GRE", "_xmit_NETLINK", "_xmit_6LOWPAN",
+	"_xmit_VSOCKMON",
+	"_xmit_VOID", "_xmit_NONE"};
 
 static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lock_type)];
 static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lock_type)];
@@ -516,6 +526,7 @@ static inline unsigned short netdev_lock_pos(unsigned short dev_type)
 		if (netdev_lock_type[i] == dev_type)
 			return i;
 	/* the last key is used by default */
+	WARN_ONCE(1, "netdev_lock_pos() could not find dev_type=%u\n", dev_type);
 	return ARRAY_SIZE(netdev_lock_type) - 1;
 }
 
-- 
2.52.0.351.gbe84eed79e-goog


