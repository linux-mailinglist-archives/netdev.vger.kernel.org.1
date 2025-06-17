Return-Path: <netdev+bounces-198797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EF8ADDDD5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1719189D471
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2028C036;
	Tue, 17 Jun 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="GPAIv1Ew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A162264B0
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195271; cv=none; b=KGqmvZvBeSPM+LnCAoawemj+lu/M6A8kbAi3QR0sG4YrDjsNPZxDKr5ySEVmOGJk6yAVY9k17KFgRrq69NKdjcamBbc5S09meItR4LGq8XL6trUk0LTtqCiFTY+1Xriy6XrU9aRIVk5+/6xRcjZgQA2Oh4HOy96YHD66+r0G0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195271; c=relaxed/simple;
	bh=G0FSmbP9eTudO2KRHXd52Eh2uZLdEi5te4EY34KpomY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZG+sqKtOHiZaDW0HpcIwtGcZaVyDZXn80Tp0rsj2EWYpAeBfk91/8J/4gvnHWAF8tOc6eecGHEvvzAklMc8YSwtiOxQXaB+YwINBHrsdBrDo+i/wdU/IKYfs1vlvQhBYa5nOzNrGfe5S1JfW0ay6WljPi1Ye1lqwwLDtOIDXAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=GPAIv1Ew; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4965616a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750195269; x=1750800069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErDwQ1SByJ3i+eF/cJK2RqzjKVePWme0fQJtnQFECys=;
        b=GPAIv1EwuUn/6rr9P0nIZoWjYN+3dnyN63P9MuISJ9znw0/f3zovc2ZH+g7VCq469O
         GecqT5yhVqjvpuLs6yQ5yegWNCYLpbz6dpI6lIXlsZ/D3AJBrDUeNB8M0WhFOoZPXOau
         VJHJpauw0Dd/25Eo0/fWMPlwvdcEDFkoqNSHYcY/KE58+sz89eREOXZ2uQfjRGerDqC9
         sWV8LyTaVqsBP26Wzbwml33OjmLE6b7bbBy5nSthQiv7Ty45DxN+4YtEh7bxx8WanR07
         Qo+bmYBpCy8bk58zDVu7AKzV+hiOnkAQWoG1E1masiozhWob9CMZ3ChXSJKpHBZHopCr
         +WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195269; x=1750800069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErDwQ1SByJ3i+eF/cJK2RqzjKVePWme0fQJtnQFECys=;
        b=K1W6DItJ91VY9n+Kc3EGXGLioYyt6haY8nuD7r87rtkNGE9UwnzvIWmSdCKPr8PJiH
         GEwSPnLTOFksayVaiYYH2Bixcz3wR7yFHSHHSfOOpDUpcyGx8u5bp6MD7/5zzhNkgF2f
         Y8GvjjeBE9rYQ8SmIvVrgLzjpIpj/nPOYM7xbRnZlkVDv6qKSZXOfo4iCrX+NAqJqYDl
         Up6K7pyFGaH6IveYGLd2ixLgsmQyBPvAWhrXf2fZsra7Ffr93hkemtxEUG1OysPfa+wb
         p+40v/Yzj1H7FUHHja6uEMFURKs2vGVeR7RnXNwKwIZCk7M57PqRaOp7kqu1kfT1Vtg9
         nbuw==
X-Gm-Message-State: AOJu0Yxsw1FXeIkEYjIaBCQEvjI6rCUDeoKFll5J8j4VwM3zraImXB/y
	b128Dk+LkGk+5nqyq9vDhofQapNYjAqmKe1W1BbH19OF/YWOJ772nYmjHVZhdB7ESYpIh6MP7m4
	k8ZSs
X-Gm-Gg: ASbGncuipAqVByXLC5rGu1lPa/cKaWPDKP5pSb/li26BknnO9hXpuAd6LWdBS+a1OyW
	vQoZ+xOzfzun1Y2Od8y4qLcmiLcwwv1ueyjmws6aVk0xAI816kOiHEd8JMZ3AgIOAPqmS1u/cjj
	fiui2fplBD5f1hSXu622NlRvrwetUIr1ptN/wmvxlt7HQNUlvcpy4P23dm5Pprsxcb4bMy/Bol7
	I2pg+7bHz7IZCs8rkNlm3lBcCbcIr3IEAsKenlovFbrjJajejp8uYSGcbwZu5HhDT22e69AgFBd
	MPf2PaSuw2+Epro/5u0O0k2XSK0R6jSFrjIgVgeFmCiG
X-Google-Smtp-Source: AGHT+IHI8h7zLzASBbeNdZY/xfkS+AHTGPJh0c+c2DCnQyCPiveX+Z3FKmuJe4K6B/2U6HIvebSsrA==
X-Received: by 2002:a17:90b:1c81:b0:311:ffe8:20ee with SMTP id 98e67ed59e1d1-313f1c0168cmr23789959a91.11.1750195269268;
        Tue, 17 Jun 2025 14:21:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19b826asm11212608a91.3.2025.06.17.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:21:08 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v2 0/4] net: fix passive TFO socket having invalid NAPI ID
Date: Tue, 17 Jun 2025 14:20:58 -0700
Message-ID: <20250617212102.175711-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found a bug where an accepted passive TFO socket returns an invalid NAPI
ID (i.e. 0) from SO_INCOMING_NAPI_ID. Add a selftest for this using
netdevsim and fix the bug.

Patch 1 is a drive-by fix for the lib.sh include in an existing
drivers/net/netdevsim/peer.sh selftest.

Patch 2 adds a test binary for a simple TFO server/client.

Patch 3 adds a selftest for checking that the NAPI ID of a passive TFO
socket is valid. This will currently fail.

Patch 4 adds a fix for the bug.

Changes in v2:
--------------
* Use sk_mark_napi_id_set() instead
* Add fixes tag to patch 4

David Wei (4):
  selftests: netdevsim: improve lib.sh include in peer.sh
  selftests: net: add passive TFO test binary
  selftests: net: add test for passive TFO socket NAPI ID
  tcp: fix passive TFO socket having invalid NAPI ID

 net/ipv4/tcp_fastopen.c                       |   3 +
 .../selftests/drivers/net/netdevsim/peer.sh   |   3 +-
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   2 +
 tools/testing/selftests/net/tfo.c             | 171 ++++++++++++++++++
 tools/testing/selftests/net/tfo_passive.sh    | 112 ++++++++++++
 6 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/tfo.c
 create mode 100755 tools/testing/selftests/net/tfo_passive.sh

-- 
2.47.1


