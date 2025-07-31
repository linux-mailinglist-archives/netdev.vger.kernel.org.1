Return-Path: <netdev+bounces-211285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABCCB178B7
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 00:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CB858414A
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DB273805;
	Thu, 31 Jul 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20230601.gappssmtp.com header.i=@wkennington-com.20230601.gappssmtp.com header.b="h2xO36Sj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD93A921
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999171; cv=none; b=Tzjik2qyA9/G+R0vKlTnbYII1Ja34KEX6ujZ7E2YJyUFAbPU8t2tBaXHVMoEbqY2bC2Mmwwx/ptYWz+tr2+Fl/8D/+cOi0+f7dHfWb+yUsQksvGHhzkbcur1XmlIw9BBaLuNmw71TkBTOF4YQ7ZcgUdqa0SmZoV0ZO+ja8QoyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999171; c=relaxed/simple;
	bh=xUuXvO5tBXupiWoidHOUu1qu6odUdF+spw7OOibRBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukwg6juNSRZ5ztFUy57eLOUiqcGCFFbblvnWLConGgv82M7GDimOYQdDPvkgqkAhnWbKai/Bu3XS1FMRzOHQqAloNV78m02SIdFA/r/kQyatTcxcvAVzrtPfXAMUFoxHAg7o0heDK1/GFkgnTQZ32xVHZZEQvRfdYZ6VOsPBWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20230601.gappssmtp.com header.i=@wkennington-com.20230601.gappssmtp.com header.b=h2xO36Sj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-236377f00a1so12991285ad.3
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20230601.gappssmtp.com; s=20230601; t=1753999168; x=1754603968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ5He2hK+WCkQhDTQKBCbM7B74/3qO7XEi+/ZfuvBm0=;
        b=h2xO36SjwVh9jIGCrNf57KZ8/2Atmq+Uh8EmgUfH2GE3y8q+jrx+Y9CFKlficqZPhZ
         fx75gJzJPmNjXP7jIyBwC5gxDDWeo/yqg11jcWI9+9RyaQKIjDpARUQ6EgVyYobHy8yY
         UNTnNXO9MAiPBPpjLP52UMM3J/VX5fHnvuHpDEVNxMQ9ly6Nt0cGeS0i3F5wIKmEkmCU
         k+oE7XxY5aEtf42rgxz+ig9rkjnZDowucYVapidWlYEIDZSoieX/WuI+stlh0lOh1YcQ
         +IlxvHyK1XA03u1ORsKwpnnMj7rSpZbq0gHOttBLwIIynYThc0Eraf2vONncAOb7H+qB
         bWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999168; x=1754603968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJ5He2hK+WCkQhDTQKBCbM7B74/3qO7XEi+/ZfuvBm0=;
        b=OcyaSFp5gMWC9qy/9K77j1a0zi1VsqrmVgymEgirWtsa5fe1SdL3VCbG2ka9ys7Rbw
         CuZlPEoCWNzZktRW3wEQomLj4zUkXk4ZEM3QJI2OTitXlAg7fSSsbY/23TEuA966G7XL
         sDJHEJ05LO2O+c3WYvkPejMIUd8RsD9ffyPvs0mLdK+fQZCwWMwuj37HOykbylKw8MsZ
         9e08TkiTFwOcOdiLmdxEmqlM0nPdkaQ3YwfItctHhL7xxHsCGXBV2FOe05Y3yEyfQGAb
         z3QtNUdCZMqtbzWCUJQDpeb0k1NDDuDVMwKvAiaoO5IqxGAmAvo2QLr+rbkHmc1pjG1L
         DsGw==
X-Gm-Message-State: AOJu0YwTSR4mR14hcHAnC1U7ehV6a/YGTKCRXpGJ844vHNFFV39i5QVI
	D9GcZ4ICtJU8LFlLw/bfbDHT6jncvI/5VCE3Pijum/0cpiL5Au6P74mjBlYh57zZ11w/GKajtTH
	OXlMk
X-Gm-Gg: ASbGncvvjX3rlwmFK+490RoYzk9hZIpmcA9WXf67L662z0XTpU2kxd/Li23Z7JwN2lC
	afWwaBhaob8dQDPaDCwDfTxDGOA8XjUiuEi/2pxY3CBwgU1bjtsUT1+EhVppMO83jAVDlbros1a
	rR+TxmYPvrD/0vyPR7pMHUroOi6l5TzI0He0oOXI8JdXIsNw5UOovjrHHtMpFoeEj51ILQbVRZG
	4lexAJjJWPG4rt0ha2BCw78Jq7OM7PeXuu7mCavxLQDiQzEjcnpxqBmTS1+V8oCEq0BQr28j8No
	d1fykd4mZy0QgvvWVnKzdwkSqV60QkPflaJAFL41M8wtTtcedNE6oZGObDQJhgwOwCFD/1ViMRf
	8xTYKGNF450yL6VvFW4wL3XVF0UnREPOe3pENaVMWb/p1t95LeVNN3wzF26vHk6Mn4gzWqOOtgW
	lK0LQ098siFw==
X-Google-Smtp-Source: AGHT+IGkkk4ewh9rDML3rzcW+qKAGJXD4hX4bGmngG7gVHPx0qAkB+oNYdjDKZ6AjMLqpgtCcqrmbg==
X-Received: by 2002:a17:903:4b2d:b0:240:8323:365e with SMTP id d9443c01a7336-24096b455fcmr131467245ad.47.1753999168144;
        Thu, 31 Jul 2025 14:59:28 -0700 (PDT)
Received: from wak-linux.svl.corp.google.com ([2a00:79e0:2e5b:9:1387:de4c:755c:9edb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a06sm26705495ad.81.2025.07.31.14.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:59:27 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
To: netdev@vger.kernel.org
Cc: "William A. Kennington III" <william@wkennington.com>
Subject: [PATCH iproute2-next 1/2] lib/ll_map: Update name when changed
Date: Thu, 31 Jul 2025 14:59:19 -0700
Message-ID: <20250731215920.3675217-1-william@wkennington.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with a predictable naming scheme, our interfaces always first
come up with the incremental kernel name prior to being renamed. If we
have multiple links that come up at different times, they will usually
use overlapping names when first seen. The predictable name is then set
shorlty after. When using ip-monitor, all routes will then end up
printing with this same first name (usually best seen with eth0). In
these instances the routes cannot have their interfaces distinguished,
as they are printed with a stale name.

Consider the following example while running `ip-monitor`
```
$ sudo ip link add dummy1 type dummy
$ sudo ip link set dummy1 name dummy2
$ sudo ip link set dummy2 addr 00:00:00:00:00:02
$ sudo ip link add dummy1 type dummy
$ sudo ip link set dummy1 addr 00:00:00:00:00:01
$ sudo ip link set dummy2 up
$ sudo ip link set dummy1 up
```
We currently see the following, notice the address and route lines
```
20: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
    link/ether 82:49:17:d4:21:88 brd ff:ff:ff:ff:ff:ff
20: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
    link/ether 86:61:a6:69:1d:7b brd ff:ff:ff:ff:ff:ff
20: dummy2: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
    link/ether 86:61:a6:69:1d:7b brd ff:ff:ff:ff:ff:ff
20: dummy2: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
    link/ether 00:00:00:00:00:02 brd ff:ff:ff:ff:ff:ff
21: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
    link/ether d6:f6:da:e5:d7:7c brd ff:ff:ff:ff:ff:ff
21: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
    link/ether 86:61:a6:69:1d:7b brd ff:ff:ff:ff:ff:ff
21: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
    link/ether 00:00:00:00:00:01 brd ff:ff:ff:ff:ff:ff
20: dummy2: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
    link/ether 00:00:00:00:00:02 brd ff:ff:ff:ff:ff:ff
multicast ff00::/8 dev dummy1 table local proto kernel metric 256 pref medium
fe80::/64 dev dummy1 proto kernel metric 256 pref medium
20: dummy1    inet6 fe80::200:ff:fe00:2/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
local fe80::200:ff:fe00:2 dev dummy1 table local proto kernel metric 0 pref medium
21: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
    link/ether 00:00:00:00:00:01 brd ff:ff:ff:ff:ff:ff
multicast ff00::/8 dev dummy1 table local proto kernel metric 256 pref medium
fe80::/64 dev dummy1 proto kernel metric 256 pref medium
21: dummy1    inet6 fe80::200:ff:fe00:1/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
local fe80::200:ff:fe00:1 dev dummy1 table local proto kernel metric 0 pref medium
```

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 lib/ll_map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/ll_map.c b/lib/ll_map.c
index 8970c20f..431946f5 100644
--- a/lib/ll_map.c
+++ b/lib/ll_map.c
@@ -118,9 +118,8 @@ static void ll_entry_update(struct ll_cache *im, struct ifinfomsg *ifi,
 {
 	unsigned int h;
 
+	strcpy(im->name, ifname);
 	im->flags = ifi->ifi_flags;
-	if (!strcmp(im->name, ifname))
-		return;
 	hlist_del(&im->name_hash);
 	h = namehash(ifname) & (IDXMAP_SIZE - 1);
 	hlist_add_head(&im->name_hash, &name_head[h]);
-- 
2.50.1.565.gc32cd1483b-goog


