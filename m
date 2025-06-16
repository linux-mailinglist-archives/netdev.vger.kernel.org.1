Return-Path: <netdev+bounces-198198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D1DADB924
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791473B109D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDCF289833;
	Mon, 16 Jun 2025 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="EdIjWRlm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783B28934B
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100100; cv=none; b=HPVHkeT3KhqCr4Qyz6O5js7+zAYhCnGp8HKw91jkRGCS8OFw/H31NoZ1AEnlmCE1priTGYwjUMVocR4nTBxtrM1CcFkCxuO9zWAUOcB6yOUpmLZYtu2GnF+8YLDDDGTO+fvvv6hjyTs1XzLmuN+pzdkYIVh9LwoELcq7Chje2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100100; c=relaxed/simple;
	bh=Ies0A18IZwSrI/eLbcX9DaY8TWKOaXPh9/SwIMwvA8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5lPYBoIeBf8Z3Y4qTWQatrtxZoLTtK9fG2Kxlrwxbq9j8tXANQKU58AgiAX3x2bByT7eK2+RNiKwHQi/0cjg3kSuc/9X6mjaBIlwo4zVBubzFDYcFFDZybuwUdRLcw9wiwX5qKzlhBe8N1mqn+FcxKZogwC8SlL1B//NQwW6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=EdIjWRlm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2fca9d7872so3099114a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750100098; x=1750704898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jW1QwklMTdvIcHHoBzH/SvEHyYWXHnOgFvLhDffGMAA=;
        b=EdIjWRlmKCgK1KAf3wkDZKOmISUdJMusXq0v/lAJyZ6/0gDFFG8zCRVWZVWWSGjcSg
         KNOFrYIVPC31G7RpCWWQnn5nYQK7kAjknmWX4C4myi4jLZ+jin00f/9WyES9CfRE9UDX
         tBbiZM1H3rwsYX+rt0rL/O2WZfCTuwBXBUE1p8Qjd6V42aJFx3Ojg5TTb6pamc6WIt9o
         /+PNIn1XVnleSd7XsiYmU9CnGWerh95+D8xsdZHv2uNGo/93vsKXQER58k9gdAdDSBnw
         VtWKWySxp8el+AHIEc5oRdVU6VodNPUJvFFLjQ8UkigQ862bNTUKJqv4RPwLYVkg/Fzx
         mWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750100098; x=1750704898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jW1QwklMTdvIcHHoBzH/SvEHyYWXHnOgFvLhDffGMAA=;
        b=c7goQszHlvvXPX0KU6p74sqnxZVtwAh3Ij2ecBVbZbmSDppAMHK3DYcSqGwMMHpirI
         6Yxqk7e7ZAsRwHTVADbqrFZjqxcDkf1zDhjtbHXKcKI1JJFAOCO0S+UJRoy5O+qDogI7
         HMX6D3xEemdCh6wtbwnWxMj1IFp4PmX9FUZEeheiVQphqaniANZPSmn+erThKqbGA0R0
         I9q9UDazLLNeWaZWNuhiJhmmIcwlZF8R4U+dvxYBGEL7PbkAum18ItGEVeiq63EwBRak
         pjQUrrbW+4biBsY1gWWY2qokcHChT5bj9Yv0+QEWwWGqx2gKY1fFsdkmx+XBffFDciMO
         YTkg==
X-Gm-Message-State: AOJu0Yy4gpL1NRKg3QczdVkO+W+aEb69J3FeiauwYIuNZiW+KExzw+9T
	AJnZLUoSvPRUjfbSuySRtKvxvN9lIeo4yCoL3STFjcM5CMFGF5xqPRvsV/396s0z3tqNhHHov/R
	9Vf2Y
X-Gm-Gg: ASbGncvJiiMJPWT/e1m/u9qFlR9dOUwotdcc6qtXkCoXjGCIeSCU1+giSGqmTP5eceT
	LBmlUqvyXccJhDhxGMURefDStkKyrZGs47p3CLYUejzv3dUYodK28sT0aeD0MfLm1JWkzFWGv74
	wa4bDhPZnQsXq4xNInzmxd1d0FfP5lOXBZrvpqlc7IVNogRJITEvfxWZSaVM4/RRre4W2VDpbd/
	s+agEu7+FqUMrn/VqwmH+FJNFVkCbtf9Hhdz9zvzqU79vVtb5265cHCwCktLVupAmejfqiPjLMb
	LLLawn/g1m2RpMIVwZS9HSyoikNlDSl8CwYLCSBheCuAZUi1
X-Google-Smtp-Source: AGHT+IEXt3yi3+cb2IeH/cfJepHnpTwdj10aUpaT5KQtQVYggbTBMerYJ756+66oz+T0f4+2MUhpwA==
X-Received: by 2002:a05:6a21:6d91:b0:1f3:3ca3:8216 with SMTP id adf61e73a8af0-21fbd469acemr12303340637.5.1750100098541;
        Mon, 16 Jun 2025 11:54:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c54sm7314974a12.47.2025.06.16.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:54:58 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v1 0/4] net: fix passive TFO socket having invalid NAPI ID
Date: Mon, 16 Jun 2025 11:54:52 -0700
Message-ID: <20250616185456.2644238-1-dw@davidwei.uk>
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


