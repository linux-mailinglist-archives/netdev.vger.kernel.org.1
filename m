Return-Path: <netdev+bounces-142738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B19C027E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F49CB226EA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7124C1EE00F;
	Thu,  7 Nov 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grlZWmoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D128F5
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975825; cv=none; b=WePfBIXeTHvWkjwh5l687WN/r5P//0GVnVugm+Q6vb9CqztL5pZUvd0i0D3RUFkHpv6vaWdImZ2qXOCTUldkSpOxX2Kx0VHX4gXjsRKoXlf0VsSlB3+lpzPDkkZYf7A+LEeY6QmAShG73hrMfZk6Wk6zNYI3ajfCkfJ3Xf4NAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975825; c=relaxed/simple;
	bh=WODWf4kizp6Gb43EtRkQfRAQmJvFlX5SfA19hWLvooo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vzy5tRRewkq6nOHCKiDiFuWtUQ/esmEe6Mw9iPfCzTZSFM5qLTGh6wc8uG4n8eMUx8T3FocJFjUFJuZEP1NoKx2eK1ZJb18DF9AyiXn3sgC/alZfSZQ258hrsUfJPGxmxbPUYiUQXOicvR+EXbkbvvT8xhJ7fEUo7OZLvaQbY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grlZWmoI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e63c8678so782980e87.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 02:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975822; x=1731580622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfZVIGt8Rmy75o208RSK4hSdJkPI/4dSjeFGxBLdUh8=;
        b=grlZWmoIgoHjm6M/cY96BnXRI3xLoiUW4/n8AwGR1Xv3QFRCySdko8N7KJ5r+cxvSN
         PmxH+qqhxjsiKHCofnIbtxsyz29ujKTtcm4Gce6paPYwJhNzklzVoPD4bAJLlRIbHe18
         qhKUmTvCbYs5L0x5SIkABYNwzy3hjLi5NhuSaeNloqMzaHTCdAettl4XyWfdCmVUX6Xu
         oO7YYBDlHQIKFP0ETzkw50kKNXK1rmGZ0FusfwxxaH6ykOmk/3qaSEYVYq12hzBMI5Mf
         HPXnFHV3h1OSNl9GLIbGVA0nIIZX0AAKYrWJETIbGyBzESgnTOSg6jEsSZnQLGYdtxRj
         VtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975822; x=1731580622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfZVIGt8Rmy75o208RSK4hSdJkPI/4dSjeFGxBLdUh8=;
        b=gDYgbhv3embtcJ8ZN9MKf+nOvFQCMQ/045kaCsTJczSdc1YkikqdDfEVqSTWnfT/oB
         wuo0dTImEgCN84fAWSy5U0CdnNdvwgKCUxc3UKJl/fVx+9EtBUNkqVpBO9d3/NK8DjiC
         hAY+hMfj3yBjBeF2DYWmbixHcmHIVLR42M2+uy3skVtyFU6ks+9vFD1DYrr5TmwCazhn
         WloXJyCjqKcTOEf5UJqFECdBniKQRgPVmHojR0nkGu7H7xIW99SvLh2PxifZk7aSubWi
         Ir9O8x2nc0uSEuvcCOVLz3CQv+bM7OPk5sBD5sml9gj3+yf8FE9sAASOK6BDl9+6sxrE
         6uZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgUzpynzoyDHU7h6v3W308VRwAHkrZck/Zyq7LlNUzQ3hmoCAIPCkx9FIhBBajRrZouKAN7mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3T4N4jeHII9VcP6NikguvS7RZaobCSuf9agj0wPFKNyC+ABo
	oMD4sl1zqkph2y7HSRhOTUEh8OQyDkKkbzacPXuDIBPXICuj3qIt
X-Google-Smtp-Source: AGHT+IHxkKwKzxkqB/vK0lp80N/+iOYb02NNcmbAQEHv3G4+1z49VyK7rPqMqOkEMoLHx00Q9mNkPQ==
X-Received: by 2002:ac2:4e13:0:b0:539:9867:eed7 with SMTP id 2adb3069b0e04-53d65de94b5mr12747124e87.24.1730975821693;
        Thu, 07 Nov 2024 02:37:01 -0800 (PST)
Received: from localhost.localdomain ([178.219.168.100])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9e4fsm160025e87.221.2024.11.07.02.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:37:00 -0800 (PST)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Dmitry Kandybka <d.kandybka@gmail.com>
Subject: [PATCH] mptcp: fix possible integer overflow in mptcp_reset_tout_timer
Date: Thu,  7 Nov 2024 13:36:57 +0300
Message-ID: <20241107103657.1560536-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
to avoid possible integer overflow. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e978e05ec8d1..ff2b8a2bfe18 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2722,8 +2722,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
-			mptcp_close_timeout(sk);
+	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
+			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
-- 
2.43.5


