Return-Path: <netdev+bounces-246830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFAFCF19BE
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 03:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2855D300D4B1
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 02:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B131197E;
	Mon,  5 Jan 2026 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/pNfE2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCF330DECE
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767579003; cv=none; b=SpgQZ/S3nigIGHQo/zB2F/NcYsnKFO4IcTqttt7CAF9rEE6CuByh3FS4/lnaTMZfebJpYibeoDGCzTRQQWbNfxCWHahzyL0NjpaZJ3feGFpjjUxVynkaREy1wjq52clNLJDgMMU5xu6hc1V3/5A4hf1sflGSZkzd8K5aOY3Fqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767579003; c=relaxed/simple;
	bh=/62+PdMKYWZusM9PkxQT48WVPnDAFiAapB1bqFSoACI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6UcdpqsvG8cUQwWtTbp/IUIVx0/VUI+kdw6pjVUikhly6V/ykDnmWGopZ85rAVfZ0vsoV/wHU9xCHIge/v9uq53xD/z3rvMlMBMq5h5Mdn3qLWPQzAikNxh/HRfaUvrSwG3U5d9+rfFP9x8FCsajMUx0kBqT8lU8FYGIh4QuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/pNfE2v; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c363eb612so13936104a91.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 18:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767578999; x=1768183799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3uR6U40GQt+zf96mGqciw1zgkf8BLm2fZvtPLhJCTs=;
        b=P/pNfE2vsLUkN9jOfUJcp9kBERHpR+zM9N7KOziSc9HCTRgZrjNCj67yFQ5F1Q/JVL
         ovy5cHRVAPf3r9mgNYDLwQGs86A8crGYLDPT6sxHbv0kI8Hi6KKUB9bnp/Ax+ixQyZHp
         H8mkNPJDuN7mlZ5QMeYCtUHHFmc15DJ0p/8lyts9SqK3GvvBIrYfW6bfYYLW/X/AbNWs
         1GLqnmIDJ9YHyHh1K57X2kCkV5vBlEodGooAI1sfTtTtj0/eY5imo4wYNOsy4k41A3Zn
         cU52mC6ze6ARNrimOhDENNRUVruHr61FRZ8fo5puQ1CqYigUXF5RimAyyTlFXF6gTeIG
         OKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767578999; x=1768183799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3uR6U40GQt+zf96mGqciw1zgkf8BLm2fZvtPLhJCTs=;
        b=pEaFgC6k51PQyGyIG7rguVu3I8LKe8a7bknsk4UW936OsbwnQabiEtHbQuCeaCgq8O
         TGuP1k/1brQRhXWErNEN5YQCBVZ/4cx32L0PS1EZiFgNAU3mUW54r4vdBejiAcvKEW9G
         OTGXxyKJQ6UrDV7UkOBh63VjZMj72lyA4E0IKO9EN74nLh6m7Q09yxmGYSOhEP7fARoo
         dDOC1WLT4g9j72Bript/xc1pFOj7E/MzzUTEfk4odTeV5CHq0FNS8i57uXsrGn8FBRYb
         J5kF+yt4WuhU2d7VAosdFZxBlcyEou/hRQJOK3D5bEH389/W75yFkpxEJuB+vF2YbzBQ
         y1DA==
X-Gm-Message-State: AOJu0Ywcw1hJqntjOed1t4kQUcm9z0UcFizKhxG4sUcZjEdALYj0nWXC
	UPj1/Zt/wJ1XIaDHcftfgHkudfWmUzxW2Ub5akhjqwFHp+P1XFDHtM4OfuO7PA==
X-Gm-Gg: AY/fxX4hMjZqJysyqMz883O+my0ART9UrCRTEr1zE77dzdWsQuuvFukjCteX9CUZTC+
	tdE2vhy4VfmliXw73+drBgdYoiY9tGTjC4ZK0rw0kb6ok5DZQlm7LwwTd7exl6nRayQ/0la7keP
	sgEZRIEh1I7h7oIlg1HNrVNhoCI7y1y8TVTnpm6rLx+odj6K2sHvMo1+1PY/EHLw0gba1BlIxfG
	kwvGDjKT7v2SoBuTFS/TGUXKPPqSa1cem31M3W5zNP8Iwux0u8kEPi6ZTog1HKnwXROd3ZhzwQM
	XoxHYF5CXc2fnQkwuS8AOlApLaDPnA1oiUR6V8VR9FdBudeyvB4FwpYlRjn+B2p8asm1DBiQN+5
	P5DaaLuJTcZgmtoxP5tUNlGvYBIoTmdbBQ7/5NGdLx6zduJFSHaVVyaAcxItolPjnmxcwZElrYa
	1ufNVd6TyR3DOM6yZjG11AMUY7RRpQQI8GHWTOTPRx6Q3/K5NZ8G2Kqw==
X-Google-Smtp-Source: AGHT+IH/FQXXd4jFqO2b1jSY7VtLWbk5Td6mN+8JRm6l989iuQ0abmOznl3Z29IoRE6/5fMIwcf7jQ==
X-Received: by 2002:a17:90b:1810:b0:34c:cb3c:f549 with SMTP id 98e67ed59e1d1-34e921e653cmr39929694a91.29.1767578999294;
        Sun, 04 Jan 2026 18:09:59 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476fb838sm4427102a91.7.2026.01.04.18.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 18:09:58 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Mon,  5 Jan 2026 10:08:59 +0800
Message-ID: <20260105020905.3522484-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning reported by static checker.

v2: https://lore.kernel.org/r/20251025171314.1939608-1-mmyangfl@gmail.com
  - run tests and fix MIB parsing in 510026a39849
  - no major changes between versions
v1: https://lore.kernel.org/r/20251024084918.1353031-1-mmyangfl@gmail.com
  - take suggestion from David Laight
  - protect MIB stats with a lock

David Yang (2):
  net: dsa: yt921x: Fix MIB overflow wraparound routine
  net: dsa: yt921x: Protect MIB stats with a lock

 drivers/net/dsa/yt921x.c | 76 +++++++++++++++++++++++++---------------
 drivers/net/dsa/yt921x.h |  5 +++
 2 files changed, 53 insertions(+), 28 deletions(-)

-- 
2.51.0


