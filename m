Return-Path: <netdev+bounces-145690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5189D064A
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23048281FD7
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F47143C69;
	Sun, 17 Nov 2024 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMXPxZAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC63D551;
	Sun, 17 Nov 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879095; cv=none; b=Y2U7p5zwNG0qmH6S42UHjqQAFNnhMuS04a1sSVFV8umBzJrx28Nus9weoxMmrByTgVyCWys70UzJaTDNI7bJ3iaFtrHN+18hfJeRYpattRajj145TSxzRb+MQ7M4vaxXHsI9nBjvcPb2XFQls3oTLgCACIl3pr7PUdosA6Hou2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879095; c=relaxed/simple;
	bh=G33r+idV1uSRZW2ZesqRVElbXM+t4KdXdNp19f0uPjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olfBNK8vr0TVJwnQd7eTV9nZdkOiQDHIgZWl4m5+RX5qH9f4dt4w0WVz93jMG0daGL9RFvMhf8j8cddZbYPfmSJAdi0G8dQPbvDB1m8Ja9DTf1xdj9BgJGKsNjIdbqw3KaFQKR96SXXzW0xS1foylm6CgaUGi6Vn2iOFTZ63VN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMXPxZAg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so487731a91.1;
        Sun, 17 Nov 2024 13:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731879093; x=1732483893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJQ3isTUTy550i+LxVSRUPo7Nc+nw5o3A5g8neEkxKQ=;
        b=NMXPxZAgDZGIg4wTMotosHibXRoBKR5TIWUTq/t0heBzY9Y7KzCN8gU1kfK2DdWVmZ
         VoYrM1eoDG+ZvUY+XRobXnYkTHyRkpCA3Rlt5QnW+khAZCqAhg5lUIKEIT0zYNqaxt4k
         mF2mBcBirkpAmDsBQOPGL2NtufR3EHGvJJfFmH1gMdHjiiPG7MfTYzCia/fhoMj1o9LO
         oWYMxNBIxhVvj5GQgI+cX796bSGDQQjXM+RMILQ55WqKxLzXw0TYu1SgPEdpi7HdGcPa
         /hbk5/qI0b6Sg9vAKkemlaiE7MXx2UT3jsey/SW5oB3szOnViqUMdqFrjaykn4lzUh0a
         FYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731879093; x=1732483893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJQ3isTUTy550i+LxVSRUPo7Nc+nw5o3A5g8neEkxKQ=;
        b=opDDbbQCr3UnRjwbElIcLtMebytKty/mD5HHY6P5i5ximiRDjsZt+m3Pd4uZPQxZ81
         W1SHYULiDbpsKil56cDWZmLlgH4YaXp3zZHlWuwXuauVCfhGtTSCf+I96r+K3w8PUqN9
         xYJq7lrzIYLGngFSWceEzU1eaWotYFPs3v6d70/gj2jbpU6hJXbo3XPFTQm60he423cv
         0dpCnpqGhBna3d8thdpR5p8Y8RlE7+5NBj6WLy0/vDCqwIWrzgYAqDfVC98ayTYNWBne
         Rp5CcO9DvvBfSOHFhOBHzupiFXQ6AWtfqyVytTMkQp3WuzSldmFTGbqTIGwO4mHgn2pu
         6X+A==
X-Forwarded-Encrypted: i=1; AJvYcCXLHp60uea53OfpRfT3xUBO/Mcq+yG5aI2xg3DnoKL0M28s7ZNPPg+4eQECXhS5WkCV3hprbmMK1987OfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIeqhYrDQkqMBLYxYma56IRnGFbsyjJt0XC5tLVc3z2WXrJici
	w6+GBDvS1SQEytds/tgCqETT/yTZO+7AmWp3GRamfzjmBKW9FEN6GMQ3iw==
X-Google-Smtp-Source: AGHT+IHc/2eM4O3mqjMazSoObHLnu/8uU6o6t/+OLEagIRQhSc53J9mNRv2AvqlbnoasncryNaKfMg==
X-Received: by 2002:a17:90b:250d:b0:2ea:2a8d:dd24 with SMTP id 98e67ed59e1d1-2ea2a8decb2mr9482362a91.24.1731879092978;
        Sun, 17 Nov 2024 13:31:32 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f54299sm44277805ad.254.2024.11.17.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:31:32 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	ansuelsmth@gmail.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/2] net: mdio-ipq8064: simplify with devm
Date: Sun, 17 Nov 2024 13:31:29 -0800
Message-ID: <20241117213131.14200-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Makes probe simpler and easier to reason about.

Rosen Penev (2):
  net: mdio-ipq8064: use platform_get_resource
  net: mdio-ipq8064: remove _remove function

 drivers/net/mdio/mdio-ipq8064.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

-- 
2.47.0


