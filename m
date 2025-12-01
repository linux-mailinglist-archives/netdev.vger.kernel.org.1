Return-Path: <netdev+bounces-242922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35670C966D8
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0822B4E21F3
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B04301498;
	Mon,  1 Dec 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQNO0DCA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F8301472
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582189; cv=none; b=YJJoz7zODTtXZvgQzzCDbdVZYseyrYe3fni7TJVPxFQKe2S3GK4o4u6Fw6o2erEz+ti/nUv+3WNlOKM2d3p0xYXHkqJukUVAfKCa0vnNfbmQfFOC00Cyr42MgoJeO1mp6X8wHWv1/NYQVeNaByIPKvL5gA7rEEbWr2HHYFcjcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582189; c=relaxed/simple;
	bh=462lREOkRpEoeeu8M2Oz3B/npcl38HPbxe50tFwzt9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3tGxmWs+7UOdZB/P+srgdDJ4XBwdTdzzIG3XlgQNEEg+s0DNeGY0WwWu8YL/tyHpmCM2p0Zdcrg9IfzjvOVuZvLa0o2ezOyLUMuuAUKiMrIjWe8cYhWS+wpvzidaVtngCeCzvLlE4ANzFRDdC5l9ruanPuQ+EJ8KsutMCFfUco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQNO0DCA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso4547910b3a.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764582187; x=1765186987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEnNeKm6PasouJ6IBgdzdUnKLJS5b0EQJXM1XULzMOA=;
        b=eQNO0DCADs045w2kPE7wW0c/WY2jOWo4XpBo+FBzsJx56XPOCt8NiOTXeizY4odvej
         zUKzX+HshzPW7uQ/v8mkHT5cMZrrgwWD8oebAhVCxzcIp9uRvbj93sNXSH7XjXjBQBMG
         8gCu389K444q0yDjJwkakZ6V3uVn+VCl2F0AlYhKQ/XVTEDaLRobrVoGg4xfYMb9/6Rx
         bxHrCXHv5+WUDNPHIArsv70Qk0yLOsieDajtqOtJqCFpAfaECUimdmjyVUWtKrlCpk6d
         1BssaoR3OcuXFQSF+Cij5XGmOuVcLHUuInjappWlKk2mqdVUxjwLiPu2YeZxwbqo3fx1
         Peog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764582187; x=1765186987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEnNeKm6PasouJ6IBgdzdUnKLJS5b0EQJXM1XULzMOA=;
        b=doHKxjqmKtQQ4TirkH5yGIgJDaRTlEB3VzhSojPXE7YF6255nJezmbG0A8/8dTkW/v
         k8DccLg+fbU050Zbz/OFCTtTbKkwfAAo5MvvXa4426tP2Fbm3nMLaehnqBjD9hbYX9rL
         LL3zk32FgHorVgV0Vcdm5GSG3XBCOnbK+DT/y5EOMBmuy8WkihO/UmDTPZ1HqAHbOvCg
         wlSIWi3XvwOt2tgOfZqpwAw94RcSY0+3u5KlSsjM9LUkqi08oLbAPiV2tjlOnagAJeAt
         XJvPZrEFo8AGxQjKB7RVBe+0OXGM7hsEl7tXqNwmR8ZaWkzz3ZXNReqOuncqFfVCPJ/7
         URLQ==
X-Gm-Message-State: AOJu0YyP4Dky3MbaR0hwmdnfXZEYI5vLaD6ILXgmqSKAHdASvJgroM0P
	mpZg8TZvx2Dtnz09mHRHAX+GhYI1fpAaE05Be+2anE+sRLF5HFY1e1q3NIPUnA==
X-Gm-Gg: ASbGncuBQ+uFcc8jUb/k0yMQ/Hoilt7cUdYZcxS1lHgduTFd8XHofVGs5/BYpMuPww3
	8kQaVRZn8UBAh/syXoiwDC7enYw1x1XFVB5F7Lbmq0339rjtEg+mkmhbINTWm3ivHubsDdwCvAz
	DntXDTxCj+TIKQkZDCE89DEMJkVCyHI/OYSltOCgufHFsAmAOOhZLBch2HK+OXh9xCmG4yaJ4sF
	YevyCnIdYT6dh6dyiqVVtgbiC4xkEcNFvl06bPSDYfovsLLwCdWSNIBZlFjsLq0/jygPHz1DlGQ
	oaNy2SuuyIsEKO1BjuM8CRSLV7Sic6mnrFSVV2NeAP+bfO94FLew0fw2kkj6dnki0kR/4EPf0FW
	wk5+vsL4b02c9P0LukxdR+u9h2uiheo4UYHcravg94YRz9q6gHPaSePtseL5XfIrOOriJh2S+pi
	8BtFCxC0XCiLYc58Et/1KRTg==
X-Google-Smtp-Source: AGHT+IFSFoQvGiT2HjZ0Ucpapr1cyZgrVx8Vo14dxCpDS1JIGsA9Vx+W0al6m8pZDqk7S5GeS1sTsA==
X-Received: by 2002:a05:6a00:c89:b0:7b7:ac37:9235 with SMTP id d2e1a72fcca58-7c58e1122demr40798787b3a.15.1764582187227;
        Mon, 01 Dec 2025 01:43:07 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f9260a4sm12928333b3a.58.2025.12.01.01.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:43:06 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] net: dsa: yt921x: Add STP/MST support
Date: Mon,  1 Dec 2025 17:42:27 +0800
Message-ID: <20251201094232.3155105-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for these features was deferred from the initial submission of the
driver.

v3: https://lore.kernel.org/r/20251126093240.2853294-1-mmyangfl@gmail.com
  - fix type in commit message
  - remove HSR in favor of simple HSR
  - remove LAG for the moment
v2: https://lore.kernel.org/r/20251025170606.1937327-1-mmyangfl@gmail.com
  - reverse christmas-tree
v1: https://lore.kernel.org/r/20251024033237.1336249-1-mmyangfl@gmail.com
  - use *_ULL bitfield macros for VLAN_CTRL

David Yang (2):
  net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
  net: dsa: yt921x: Add STP/MST support

 drivers/net/dsa/yt921x.c | 115 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  35 +++++++-----
 2 files changed, 137 insertions(+), 13 deletions(-)

--
2.51.0


