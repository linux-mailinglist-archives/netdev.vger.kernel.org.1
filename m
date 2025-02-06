Return-Path: <netdev+bounces-163349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD69A29FA0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F20B7A34C4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68C502B1;
	Thu,  6 Feb 2025 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqEqb7t4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E52A2D;
	Thu,  6 Feb 2025 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816288; cv=none; b=LfkIhAwQew0Z7AEIHDgxJ9AxrMbceQ83Z2BRTn0er6Dcl5HRMQHvyA7jAY0h1ag4Qg146+YojbPGFWd+PYAEbB9i65HB3uvRrygPG4rfLOmWiWVOYx1rZXwjYuk1ltOU4aJrpp25uzmpbynO0jOvQs0GiFh6jUzkkGzGPYpy/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816288; c=relaxed/simple;
	bh=HiD+sUX5DogwZZwDFTTS3We15HNuMBYLuDdPYjMAtM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/qo/AkXIfKnE4sNuWa3cmrn+3EZYd9PVreffZrvdkW3JV1e7PIa0Aop3RnK4isstE8USjGLy9zUFOxrro5u63k5opKCAjDO2VqJq9agB+9NBfoAC1COSERns5iJpHfdYcck0v2NWqCl64MOWlGh6iejcXFyJX6Jonrx5/oqJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqEqb7t4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f05693a27so7276515ad.2;
        Wed, 05 Feb 2025 20:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738816286; x=1739421086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMzXaQZQdeFCGBtaHpQImI/ekjahPsKRElVgyT2QUG4=;
        b=MqEqb7t4Q8JlwVaKC38qhGDAg/3DtSJoWP0WxIW7xV3xdgj6sknJcOUAptFkNbtWwx
         tuRe9B6WpeLj4F/nRlQJq/BNLfeNJ2oUdzoICZ8GNTm2T1zqVZSE8IvrfLznHPQ0X2Qf
         jNkps7ypfnQXMkzi6Z7bY+EIHwuTwF+j/Z2T0NS+z0vOz+pq4R2BYlDjmcBHG5mRkBeG
         yitn/VceheLeXiQBaYBZnOmjheT1Jv9p+b9mJUCuWY9dhmgskQCM7mdqHWkd+/mUbX0/
         82A/FIw7hfc+8ujNJ6HyCReldGMFEgMy5M2oryW8tQs+TIQ/3sMrPjN0CxxDdkyZHhHG
         ZO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738816286; x=1739421086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMzXaQZQdeFCGBtaHpQImI/ekjahPsKRElVgyT2QUG4=;
        b=EP3VNVuETd3rtyTT7VUjjyXtlt7bpbqI56CEdVBbc12atD8AOxzXWYL47YK9pFgBCC
         dI2Q4q+wdcFBt97vl9Ii4Wz+awo0hDVYZj+amUkP5x6PyLO8A9CwNhyfJHVGO59BfM7v
         9ek71ZcNnxTEqrmTFAgUj3YMm1aSMWvof6/k7pyKFgucRtAJqMAVe/eriPQqSz+R9VBs
         2R+nKnWdm8KLNVFIkO3NSH8dVL07jMurI0sFAdJzd7oPW2aSfqz0oh1Zuj4Spj/Eh+eb
         VufNScZ3K4Jugj3+MZc4TT1h9TQKBZXC2JFTP+glLMzxAjcO3833C0/Ff9Rtv7KA2KmQ
         puoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQClwbYm1SbCPwShuWDknzaebv0tMxdc8zpu2ayKyyFLeIv5Xz1NI5u7wjX1O6M7n/9/6LbQW/Fx0wrd0=@vger.kernel.org, AJvYcCWTv0huVjueGdpnCs7dGUhb/SL/2j0Y4dO4wkPY9rUBn4PnsQmC4kLFLeLFaRSBDofNDDaPTrMp@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVorEYTaFOqGmBkzXyKaQ8+i7rGgLE9XEOAm4Nth3zRO7V+SC
	S+EJDn25Pgx3fCjH0+xPZ1znndbbyENidPEJF79pN9A79hqjfZHZ
X-Gm-Gg: ASbGncs6CBiQpJthZ5tIwPQndkggN3WfGZIFSSxCoLYrAXYFHYD7jxcOsNT4gMh2r9P
	74xRhbYbLuUCQeyiorOb24erWthdn/e6gr+DfzJtpja+sQjt+5t9P7Jfq62gDNaLgWz9oS8n0ww
	3WjeDQe3uFYpm2o/tVxu00/Dxj2vaKPHsE20CBSmLFCDBy9IlAvZ+GBMz8PrKarWRH0SB7QM50q
	CgIfAT0dIRM08x6A1CNJWorLcWVLMLrG5xgzkhQ67vnADaWWioi/I46duTuSfqdQD+DQPcVcK5j
	lkEXAy4wLjrQPYZUr0ueScZN0gmBA/ZNKHo=
X-Google-Smtp-Source: AGHT+IELmtILtA8Rpi//cGWk1LYvPHMmLUyUdg8UjctgCHCyQXUaaj7bE5H9AtI3V4+n4325E3ySnw==
X-Received: by 2002:a05:6a00:4608:b0:72d:9ec5:928 with SMTP id d2e1a72fcca58-730351f063amr9096128b3a.22.1738816286235;
        Wed, 05 Feb 2025 20:31:26 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c162f6sm305013b3a.143.2025.02.05.20.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:31:25 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] net: dsa: b53: Enable internal GPHY on BCM63268 
Date: Wed,  5 Feb 2025 20:30:44 -0800
Message-ID: <20250206043055.177004-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BCM63268 bootloaders do not enable the internal PHYs by default.
This patch series adds functionality for the switch driver to 
configure the gigabit ethernet PHY. 

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (4):
  net: dsa: b53: Indicate which BCM63268 port is GPHY
  net: dsa: b53: mmap: Add gphy control register as a resource
  net: dsa: b53: Add phy_enable(), phy_disable() methods
  net: dsa: b53: mmap: Implement phy_enable for BCM63268 gphy

 drivers/net/dsa/b53/b53_common.c  |  9 +++++++
 drivers/net/dsa/b53/b53_mmap.c    | 42 ++++++++++++++++++++++++++++++-
 drivers/net/dsa/b53/b53_priv.h    |  3 +++
 drivers/net/dsa/b53/b53_regs.h    |  7 ++++++
 include/linux/platform_data/b53.h |  1 +
 5 files changed, 61 insertions(+), 1 deletion(-)

-- 
2.43.0


