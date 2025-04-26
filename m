Return-Path: <netdev+bounces-186276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE0A9DCF7
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 21:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460173B1B20
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 19:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF61E8348;
	Sat, 26 Apr 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="GiZqB3TA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158D135A53
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745697332; cv=none; b=cn9pAUpmE8iSpzfh8K9Yagid6J4zjQ9vwqI3S28dSkUDJmhHdmilaPAUk2FDGuknbT7p1T466lnSEzsYkmCNaeDLvijq9PTxXeG+KRZPQ9Slf7rjuzYtmbmBmv10aBR9SMYg3BV0D/3Cpy7ZRc03eKolu9DZM3v8vaIGS36c26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745697332; c=relaxed/simple;
	bh=Mm3eT66BI8eJXzy6q41Q+k4/YVs+h0pb0shECOPCj9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z26h4MGMmGqwmG43c7HHAF6xlbtNnUOl2SzKbIFrtnoxZei70awOW7LmKJCmuLLixvXbNw36Rw2glvaj9po11UCumkQSzyxrtC/Pg74HpqZsZKvX2nfqqftSKO/AvHRr5kHRbkgqztzqVSLzbASoNSsLbtWjlfrL9RNzL6afsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=GiZqB3TA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3081f72c271so3320476a91.0
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745697330; x=1746302130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mq+LUHyxEnu0rrR4Z1R+UEja05V+hbutmMXW8b+c22U=;
        b=GiZqB3TAhbbUbmAI4rJHEGJqrzN1W9srXEMeji/0IdJuCaZAmd4DRwfR5s36M/XbsT
         iBwScXohSbcj2SK+aT8VqqlmEaJIKQZo2Qmh1+0SeiYfQCk6UIDCrcmwoOfIBAPpgn4d
         zlUkFLFgIezV9fDaXCaAYuvIuvD8j1tS0lYn7v3sGAs2g170nhF710z15QOtRrIEUM75
         Dldv3vrXg4UwQXy8ro30hceO7fGiK6R0jn8C7sYoKytGU2Mmt9t3hOhv3r8oqVqd37v3
         9nDe4UUhXfE4XClzTzb967PlXuuCsSKll6LEGk/W+80V6/XFP9TWP2BHLM1zEn5MNaSc
         /tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745697330; x=1746302130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq+LUHyxEnu0rrR4Z1R+UEja05V+hbutmMXW8b+c22U=;
        b=fSOzwvj+CRAd/p1q7rIBVChAQ10a72aRI6t5bUflrH04a0+H7ASuiyCoTOoxV0/COv
         Yc2Uh7074nGRX0DFVYnGFGuqBs1roomYS89i6ut0ltuZt/2ImlWiR1st+NrFlStuFMjF
         86f+pJN0/KEtnfVpDMNye0pPD+qvZDD0e4xBe8WPb4HMlD6q8a6zpV8cgdzoGFpZdyFI
         gAekrkt7D9s+ZYzp1NCGybG7OkMHnkRVbffWBoKmpNNe0n8rGOF8M6tXxq4YM4298UyB
         36JmN7RZJyLO04ue/dWkSGfR10plfs6HZCVTSxrXifjtFhepdSXist/WoGzBaNZTcgE9
         /N5A==
X-Gm-Message-State: AOJu0YzEYNY9gx2Q3+oneIbP/KBsgpsqnRy9SxK5jqW3lIs+NYMPIkzS
	rafg59o75mh9qLEAlSBu0elI7CJDfxUnaV/tz/aSFRpd4/F3R+TZkWzmWvIstDRw/4c30ywsZqN
	x
X-Gm-Gg: ASbGncuv+OkFBYL6hyCnFVuKBoW8VqSdMSCuzl9/T9US5l/ddWjgbnnBlwlNpOPB52O
	gyErCCCXCYmfZYsoKfLmXKQ6JgNz7/CpfbFuiArZSGdTmMc55KT1Mh/M0iCQ7c8GLfHa/ELwKtv
	i1gUU32vaJoly+/0dPYkw+7MD8TbutPOy2ViNeDIOSeqa2wZO1mt9rBe5zttOAlQ9uy4QQP0lez
	5NhVErWDsTDBouQi98NpWJwBa9lMU0DT+DZC5Qwrvm6rrJ4kKcZ51mQ++kM/7QZTPcsA4mOTVCC
	rPxSMbZE5Ex+Z5JGRoJe5zSeLA==
X-Google-Smtp-Source: AGHT+IEi6svapxaRpegPE8CW7zQFc3nCCOApEs9wcZA57UtdKeFpJ6dPrrSl2ZmKvfINR5iXqMqfrQ==
X-Received: by 2002:a17:90b:554d:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-30a0132ba1emr5810449a91.20.1745697330159;
        Sat, 26 Apr 2025 12:55:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03b96fsm5760380a91.4.2025.04.26.12.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 12:55:29 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v1 0/2] io_uring/zcrx: selftests: more cleanups
Date: Sat, 26 Apr 2025 12:55:23 -0700
Message-ID: <20250426195525.1906774-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 use rand_port() instead of hard coding port 9999. Patch 2 parses
JSON from ethtool -g instead of string.

David Wei (2):
  io_uring/zcrx: selftests: use rand_port
  io_uring/zcrx: selftests: parse json from ethtool -g

 .../selftests/drivers/net/hw/iou-zcrx.py      | 54 +++++++++++--------
 1 file changed, 33 insertions(+), 21 deletions(-)

-- 
2.47.1


