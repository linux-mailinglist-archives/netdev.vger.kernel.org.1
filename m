Return-Path: <netdev+bounces-245882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D8CD9ED7
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69026301FBCD
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CC293C4E;
	Tue, 23 Dec 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrLnMcNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4A1E5B94
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506988; cv=none; b=CUAo/o4EaYHDloqJvHzUtJlytDoZRllIRZXeEalv4ti9YNy2zZ74Y1ye4tV4y55G/YI8kuxFVk5TStxt7L7/3sKF+obUCDoKQ7b3Cf+aFvQAPlbXW54lkY2TyclfIaELBbT7n2qXfBAfNwS/ldBOzGO9p3zwphglzETAzjr8RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506988; c=relaxed/simple;
	bh=0sO+ExfMY98pSy0ByNVbYOkWKC295gC8jZXiSQWmh4s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ufn/vswxsozoNaWcyDkXlH8gQOi28HL5/A+QmXS4VNyONfoVSpz+/a4MA5MoJRDzM01WndtKoKwN+0JwarbxNvoGWS5pc2L4zVDUdvfFmUAcP3TCKXKxC8U/7hAXfT78PVPrsHebPA6+uJQl3osxje6AIVDrTRf7J74waYV7yKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrLnMcNz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-787da30c53dso50326177b3.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766506985; x=1767111785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk54TIE8w4c5rJwH2KoEkkMPQcoEF2GBpS3X0YnMXkw=;
        b=YrLnMcNz9UvjeYqCmVQIsBVW6YwLQm73G6VOE3VqzA9UuEGGDybIyORdfNUby65x+3
         PfKV8GFiaSxN3yhz0i8GUWGFxRXkD+ZjVVyc+ayofqO3Eza/pvvGY1siz2yc6LCKUOz7
         5EC4hLhUH+NOLAA8Nn3VN00mKaDBs5cI3j2WZaNXzi4cnezIWZXXHOllnuUXZcpp3qj/
         3+7atByuhtCreisvp06O487reL9RbqG9I4A8S27J3R70O3e99dmW3tNyWDu9o0VMGgiP
         f9MyZbt0PXNC5lUpfDldKXY9/1n4s3VYWhGBSBTQJoesCJwVpt2jT+BC8TGQ6I2CP59p
         lzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506985; x=1767111785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk54TIE8w4c5rJwH2KoEkkMPQcoEF2GBpS3X0YnMXkw=;
        b=fsTS3ykDTiUPud0OkZFUn22di1vdnTspQD8IDbm7fYJpQnrWI7y+w/mu5T1WCfrRds
         TrDZuMVsa4Xo6ObozhgYkm3xIanP2AEqijssq757z2dMBmS2jVWOzUTKgD52awWtoKIE
         KtSewTyBWXgYr9qJXXx1MCx+ze53SWeZw2PNZNCNpgyOFEbTaju3mHUPtJTKzMypof4/
         Vtf3SKR5CKx006gsM/yg/GlEfduKWRwSF5u4yBg0XA1zU3fIjhvO1QspsMUx92itU5zK
         FuIofTWkJwcq9ak7Z78PaBH+5OTPmrUZnQmxsdbC9CdYDE364zI137OhIDZ1sCx84qKM
         hhKg==
X-Forwarded-Encrypted: i=1; AJvYcCVTZthjNY1kts6QqaeOig7VrJdJPwW27iNjp0lQjOiiGk1GfbXXnur0U5kyibCv/VqZ5b/jN58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VwbKm4hwPBE0EQxsSv5sKLspwtlxLexHfizUBGYY+TCYgHkG
	kxDhjntPi7Pjs1BN6hI51U96NfThPnGMOmjla2NrRi+P2SHK1wdx+UUidc6sQQ==
X-Gm-Gg: AY/fxX4hCK6dWixwtPu00RCUyMcs4gbc/Wb+UrzpoZlDLvEAFCJmMQJn4pWbnODrNJf
	qcGZsfEGyXVQ3a77WLFhpPUhQubHuzHsvj6V0RUcLQDHt/T3NXxWd+ttX0r0y9xg78+oXEnoRv+
	zaktxRcbsUnfEAPWAdojFfyPW1Sp4lowTVP08Lm7ZtX9fJj/yiD0/UDKboUKyexTVdUHoGk6zq7
	uODjI3cmMFt0Dy8ufoWNXKJOjY1vReUTHq+SXkAoXsHpDCC3SodjLS+4yyY1EJPL3JvKNxg6DJc
	rJp9gWjeb77nQ7FzavzbqGvXitmIa81dzjpk9veG4ljRkNl0jnXntTCwfp/5KijThl70XqW8Pc9
	lQM+hS6vTgU7oNGL8noCo/+1II/bbEGa3UfIf3GgyAOjMec0h1jftW3sztIxrswNLGhffmENf7X
	78CPwVHXI=
X-Google-Smtp-Source: AGHT+IEg2VOV6xQFyK5bxxWkakIqXvU6e21ZRjY5vePVFUMHZX0s4GdRKrmFH3ID33eGm49ucr5Sxw==
X-Received: by 2002:a05:690c:6289:b0:784:8673:6f6f with SMTP id 00721157ae682-78fb418d412mr129503467b3.58.1766506985420;
        Tue, 23 Dec 2025 08:23:05 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:4913:14a4:1114:ff0d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4562df4sm55596637b3.55.2025.12.23.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:23:05 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ice: use better bitmap API
Date: Tue, 23 Dec 2025 11:22:59 -0500
Message-ID: <20251223162303.434659-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use better bitmap API where appropriate.

Yury Norov (NVIDIA) (3):
  bitmap_weighted_xor()
  ice: use bitmap_weighted_xor()
  ice: use bitmap_empty() in ice_vf_has_no_qs_ena

 drivers/net/ethernet/intel/ice/ice_switch.c |  4 +---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  4 ++--
 include/linux/bitmap.h                      | 14 ++++++++++++++
 lib/bitmap.c                                |  7 +++++++
 4 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.43.0


