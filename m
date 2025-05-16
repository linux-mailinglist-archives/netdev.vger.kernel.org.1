Return-Path: <netdev+bounces-190956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC9AB9764
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DA7A08207
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F750227E8B;
	Fri, 16 May 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="vRElF9P8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757C224B05
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383494; cv=none; b=KdqWPgj2N+c79z2Gm4bv9LFNpnM8+S4VRgXMQM84ZN5KNycjpryr4x+XQfQSuKVWsPho3a3KMVgXFpC9mSzqA/YnyeYAQ/WQ4wpI5P8lprcsUQm8YzAelYI0dz0mLYSjHkldZIApvemZueXsCnkxWQLMBGFCDqE7eHgkVD+eORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383494; c=relaxed/simple;
	bh=GYoe7r92NOyNvWbUFh77gB0wAXLBnwFI82MXVO37j4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueXEx9ImPgMDPVfFFiKHhAEJ8wQS/1uROGkSx9aoL0lJDk1hiD46wWC1FSd+gHq56s98we7wzOmwJLO0HwIt0vnhEQfbtThTNrd88kuurkxCZ8N4odcu6Ti3NbAdCnKm9GCp6gCtbPJEe+S2giaUgwuDbVDgUmrD+XOAcr9GYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=vRElF9P8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso304172266b.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1747383489; x=1747988289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k59NPumrrDZdrADJzq5UX0o38elFaU9p3OwMlLm55t0=;
        b=vRElF9P8QeCoJhdIobhrIig05AXrlaiQh5oqhEwONphl9W9lsWeFEIVH4N4n1gwswP
         ue46LjYUfhqhf7MIYdMt1ThRVwGINLseLv125cisRXZhNofdWIX6FOj+0vm7f0vrijef
         vt8ATusxyBdOIEJWE6pOhKE4VGRuqfbsHYdfIIBm6sp02lgZa3v/avpt0OIvlAcBthbf
         cK3C1PHZdJ4jNaEDeVdai6maeR5dTB3vcqC8Fc7SZtOXMEI1IN8hFXyl/aqokyG2pNpe
         HS7tX9ZDEYHLhtgnj/7WBd3LiVs5lztKNsdGCqbk/cjUUv1M5WRqf1LEZKHxNrEl1tvR
         IDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747383489; x=1747988289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k59NPumrrDZdrADJzq5UX0o38elFaU9p3OwMlLm55t0=;
        b=TKexr+/uHoC4YbnBijhD69JD8tduhn40RsiCZ9JZAlaiBhvJMPvGN0V9M6NU6biT/B
         7N4/BGMSyeTkK3qPokwRqEgGuLxxh3TjeMnhCD/bCIOHsS+IFEg9R7ue/SOHv+sh9ZTe
         jUuSXCMhg7qEOe35Zj3QZ5cu27/LrvRy7prGp++qVH/Lc+YCr8cnHAQ4kwuQHiyyrMmJ
         6RQMTKPtHh+EPlcAvim8sFT+aFodrruSrDaMrNiY9RuNtv9i0hLcbURDcxOItbRJghxS
         xU6N4c1hQOYr+qIfi1kTTqyBN6fEpHj+ya3wB26sthMWmn3YhgEUr0mC29VcPortKHxn
         bHlw==
X-Gm-Message-State: AOJu0YwvyiT1GDkwJlZPABsju2Sgk3QWPjpbgBv4Ycbm1wPvhPxuoBnR
	goS4hsvfxhy4ERR7Vfm7Kd48zioQOUBmis79S+txAyBGDSgrlbq91yAF7lfcuu/c96gW3+tLJji
	rxHQOTA==
X-Gm-Gg: ASbGncsJwYRelXjLx/6FXw0/VA4GOPylaXiupZMuvkqGawt8WkJvOt9pYW9nL+Hgk2u
	24H60PKd8GKnh2ccUP41tL1tTZ/mTXS7A27h0UgRaI5pQGr8kvE1fiCF9HxKzySxLn5S8JtiVLp
	ED7KNPBpQMNdpAUZxh+HN5cK2GJzHLu/uy4wNocleR3D/2xP5oje7gVHrk8wVwiijbsy4lAzD0U
	M6pJVfiyicmTorV8UFIqYW4QVjHEYY0RKvZMMQIc5WN81Tnsy/9JizwYvo5lI973GAG0+uUZJlM
	nj0f9YrEUPXK9tkSKa2FKrp7DCLBwOU6RKc3vJw3Mtc2dIw44LyQyQ==
X-Google-Smtp-Source: AGHT+IEK/s7twkDm0OR5XtH1NSOrfITFUmJvPDQ/dyTyOQXF/QXJqLIk3URyPRdo6S8TjXC3hbGodA==
X-Received: by 2002:a17:907:1b19:b0:aca:c38d:fef0 with SMTP id a640c23a62f3a-ad52d08120dmr249737966b.0.1747383488545;
        Fri, 16 May 2025 01:18:08 -0700 (PDT)
Received: from ntb.emea.nsn-net.net ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad52d2779fasm115052566b.79.2025.05.16.01.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 01:18:08 -0700 (PDT)
From: Petr Malat <oss@malat.biz>
To: linux-sctp@vger.kernel.org
Cc: netdev@vger.kernel.org,
	marcelo.leitner@gmail.com,
	Petr Malat <oss@malat.biz>,
	Xin Long <lucien.xin@gmail.com>
Subject: [PATCH] sctp: Do not wake readers in __sctp_write_space()
Date: Fri, 16 May 2025 10:17:28 +0200
Message-Id: <20250516081727.1361451-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CADvbK_fuv7_Hoo3BGL2_b2r9yY7VT=x6K3a+yBuDd9LAN9bZ=A@mail.gmail.com>
References: <CADvbK_fuv7_Hoo3BGL2_b2r9yY7VT=x6K3a+yBuDd9LAN9bZ=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function __sctp_write_space() doesn't set poll key, which leads to
ep_poll_callback() waking up all waiters, not only these waiting
for the socket being writable. Set the key properly using
wake_up_interruptible_poll(), which is preferred over the sync
variant, as writers are not woken up before at least half of the
queue is available. Also, TCP does the same.

Signed-off-by: Petr Malat <oss@malat.biz>
Acked-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 53725ee7ba06..b301d64d9d80 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9100,7 +9100,8 @@ static void __sctp_write_space(struct sctp_association *asoc)
 		wq = rcu_dereference(sk->sk_wq);
 		if (wq) {
 			if (waitqueue_active(&wq->wait))
-				wake_up_interruptible(&wq->wait);
+				wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
 
 			/* Note that we try to include the Async I/O support
 			 * here by modeling from the current TCP/UDP code.
-- 
2.39.5


