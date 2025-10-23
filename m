Return-Path: <netdev+bounces-232034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7BC003BE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6868D1A625FC
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D1130595B;
	Thu, 23 Oct 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmqhZ7I/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032F30594D
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211467; cv=none; b=qmXXnBwKX3tZ97RfP32TgPmM9YxhaMF6cFO7vmJz1yxzfDvLnf/brDiW2BF6IxtzPoecbTLBbFsfLQ5ifoErXb11m1FRJPiVw6rSE1qBO1Pw3og7oxkl1V6u8TaWmhZraaRSxFgC9gKuYqNsaJrgETjCtJFHB/WjMvvuDw3gJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211467; c=relaxed/simple;
	bh=7hxDrmYfmL4uCb+rlo+l53xmaOBb8MRgWfHj7qMo3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LS05KHB2CwvhNs4aqbTVg7HaFgNL20v/vLT5pf7e4gC2Znh3w4o7yEX0XBZsQFxAQ5Zi2Xbitx4xNT70z+9MkygjhECoFIz/ezSpEexDvECd6hjEq4rMzA5aGBcs9xjUp6zBP3Cz0I9yPz9jmnfl8wZMrcvqIhFF834NkLtz5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmqhZ7I/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso691888a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761211465; x=1761816265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBsArCoDTqCrmuwrG6XV4XY+7kFJVzv0tmu/UB8VHY0=;
        b=kmqhZ7I/80Wx6X5WRo9guZVTmUrApHWNUYZZ6vSc0pO6ttnffxvUkmq9XAlU+AdPRK
         4xcbK6WsGPFDH4I3HQFhNQTKfzSeeUBcqp060Z5DhbiVKYSG0W0jAN5HpPA2y3fkqP94
         DbLph4+xznvPZIsfmDR++lc8rPeyZ9PtWC6A34PfydOC/6V+xpZQl1hcTcy1hiqKRDi+
         aEseNiL5XVOK2NClvKltfY8Yw3lgByT7kwYNEWbcJwB6CcQw876W+zKeGoGfryOBte2B
         dSzhU5xq2K2IIkwi/HehyKskmS9gFpWciJODQduygpeP+noH7otC7qaZ1PHjALiM8pOZ
         BZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761211465; x=1761816265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBsArCoDTqCrmuwrG6XV4XY+7kFJVzv0tmu/UB8VHY0=;
        b=l9FiJcoippWuzHYSYqocr9l3bmYD+z73VYuknhouWKFfAjQFMqksBjIadQwV4t6dQu
         dneXcr6ezbGfPzmvztJQ54JnGvMUT/BDNWw5aiXaA2K9cIloWZG96myAAobNRZyV8Tmn
         OX1QD2R4tQdAKfna6Rqmd2aAEAzbX2gVT30e9XIHPpwFbRnG6BvBOxt6lH/SbabK4ofd
         FG8ohIjoyN+2zef5Vg/l0yNKe+rxkcfMTj4kzR0rsbPeZpiLp5jk9PBnzo90QMcjvcBk
         5kbHmVCjpf6CAJkejAGPeAUtQt58KpVa6j8B8ayu3CqcrDb55Akx3BGsGWp4KxF8yUCx
         kh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0EPtphMRL7JkWf9OnzENXFGWttA7LjHl9TFeSQOIPfAfRWnGYq45AsBzIel4wGdEvkTwj3ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaVkiZ69XT/huVRDEacj+LfJ3JFX4c6pMkhTcxsh+bz8fAYNV
	sYQUhDsW1KiBv7LdnKwmdknnR2zLfSK18MubC9l1Ki5dI+ashE5LOzeiyBJ4yQ==
X-Gm-Gg: ASbGnct2DthFn54JkiAQODaJ9h5MY18hKvQotUUhtpi+450sm9xQrs+41KeqaGhYFWK
	bkUXxqnVLgdzaylDb7wRWE2ah45JYeIRS3ip2F9owMkEQttk4O05AjKCNZgfLxTX//mVkxc1n5/
	UHuTHW5cOAKM5Gs9rLZJEPfX37k+tjVxT2vSuukyyeH3k2ZLkbZ7UIe82lZYmauC0zy04CjIFiE
	D0pDK0+W+wUbIMC7uuTwOY1eLtYBL8EqlHCDa9kmb6NUZ8M023BSFRaPkfebb3oXS4OAYpPm9tm
	VX8cWL66iZbwXI0bwYrcGxF8iiQREs9tCLC+WUOtG6hAmYSmQjvUpYNlf9SYkdlWKCwXHj8J2sI
	QpyYh3wVA3V+d2l55P1WscN0cR2GAyKTeN3/KuEln9rICaKt0rLyuwJhhAk9Xy/ro+grsWsnmYu
	Mp
X-Google-Smtp-Source: AGHT+IHalUr6vNOs8qfPskNhGYDAxFHbdZVf1HZccpt0SFrfqRTHW6rBhGI+3XgWrGyDBSunsm9tbA==
X-Received: by 2002:a17:90b:3f10:b0:32e:7270:94aa with SMTP id 98e67ed59e1d1-33bcf8e726bmr30461923a91.19.1761211465292;
        Thu, 23 Oct 2025 02:24:25 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2f28sm5108282a91.19.2025.10.23.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:24:24 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CFDEE4458010; Thu, 23 Oct 2025 16:24:21 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Karsten Keil <isdn@linux-pingi.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net] MAINTAINERS: mark ISDN subsystem as orphan
Date: Thu, 23 Oct 2025 16:24:06 +0700
Message-ID: <20251023092406.56699-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=bagasdotme@gmail.com; h=from:subject; bh=7hxDrmYfmL4uCb+rlo+l53xmaOBb8MRgWfHj7qMo3xk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk/Px+MDO8p+DXzUdRFOaOW14u3JcYekrVQyZYoio15v 6StTdK5o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPp5WH473A1+OAaAet5j54z 3SxlY25ZOP3KrACn8E/C//NzrGz6VjIybJ57+pA1v30//8zjGWLZzyc2Hw8vq5QwDc7cve7VI25 WVgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

We have not heard any activities from Karsten in years:

  - Last review tag was nine years ago in commit a921e9bd4e22a7
    ("isdn: i4l: move active-isdn drivers to staging")
  - Last message on lore was in October 2020 [1].

Furthermore, messages to isdn mailing list bounce.

Mark the subsystem as orphan to reflect these.

[1]: https://lore.kernel.org/all/0ee243a9-9937-ad26-0684-44b18e772662@linux-pingi.de/

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
netdev maintainers: I have sent request message to Karsten off-list prior to
sending this patch. Please hold off applying it until a week later when I
will inform whether he responds or not.

 CREDITS     | 4 ++++
 MAINTAINERS | 8 ++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/CREDITS b/CREDITS
index 903ea238e64f3c..fa5397f4ebcdd0 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2036,6 +2036,10 @@ S: Botanicka' 68a
 S: 602 00 Brno
 S: Czech Republic
 
+N: Karsten Keil
+E: isdn@linux-pingi.de
+D: ISDN subsystem maintainer
+
 N: Jakob Kemi
 E: jakob.kemi@telia.com
 D: V4L W9966 Webcam driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e67..8d2dbb07c44099 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13246,10 +13246,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending.git mast
 F:	drivers/infiniband/ulp/isert
 
 ISDN/CMTP OVER BLUETOOTH
-M:	Karsten Keil <isdn@linux-pingi.de>
-L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
-S:	Odd Fixes
+S:	Orphan
 W:	http://www.isdn4linux.de
 F:	Documentation/isdn/
 F:	drivers/isdn/capi/
@@ -13258,10 +13256,8 @@ F:	include/uapi/linux/isdn/
 F:	net/bluetooth/cmtp/
 
 ISDN/mISDN SUBSYSTEM
-M:	Karsten Keil <isdn@linux-pingi.de>
-L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.isdn4linux.de
 F:	drivers/isdn/Kconfig
 F:	drivers/isdn/Makefile

base-commit: c0178eec8884231a5ae0592b9fce827bccb77e86
-- 
An old man doll... just what I always wanted! - Clara


