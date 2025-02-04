Return-Path: <netdev+bounces-162424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22928A26D7F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94A33A7077
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912E206F1B;
	Tue,  4 Feb 2025 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVSvC/Gz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0D13D8A4;
	Tue,  4 Feb 2025 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658781; cv=none; b=TQ8R9EEqlptOgKRBNHFu1FzEZpyePRpf9xavmrwCOKGQVsYCyjSJoNUoWAUfFtqSsRO/1+AMWMiWRxKf9/J+1qd1l6XLgHYsIqt6GMDBQTp9WOH2jdmNPYyaeYdGFrsZLLEM44cjNjnthqMh9vKLqlOb1nQRPlBl0vjB9j/kv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658781; c=relaxed/simple;
	bh=rqTM5/H2fGuXknB3hxNEZXq7colpr67ugPiSrPWpqx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+gqgqAExq4qHvarOMYRBbSSYlxEZYVV60Wk1XI2xcpRikJU5N+JUpwpIPZk9IjeUaA7+59RTwOmAn1CQzwl9tYxT4LSDEULHDSon0S8utUqqerMxVUbw0Mk5xj45xT88m+cvGq0p8pUx6t3ji0CjAs5z2DjqiYSn/ALYPEmtGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVSvC/Gz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4679ea3b13bso40551731cf.1;
        Tue, 04 Feb 2025 00:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738658778; x=1739263578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrivW8pYVgZT7PlyWZHfibLLAxrkpAX4rLKjtvAseos=;
        b=mVSvC/Gz2ZuzhOuUFuzDQJY5lvPfmxmnpYr2jNTQSTmh7ScjAyl1jFjNozm3el1Y5l
         NbfiRIqvjHQfS3ZM1vzGCkas5gwC5X1iDmBDGQzyrOP0t/03MU3MukVG2Wj4MFt/Pb6W
         tcBo/BmmyjOclSqqYUfAEnS4QBvSEd2xkw8qD0HId7VQGpku2CXHugudHmLs/QzF9XLC
         AKztw5l+C+ACdp+GppCZsY+m8a4RIBaG9US4B1TXllrXno3LbmxVbi+P4mhpKt446kZv
         H8/ZxQMFMAc0V5VK83lrFuP7ZWtUxiF/st+pC+flPtivncFzyY3MkQwb+25OQc2tGCO8
         Bdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658778; x=1739263578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrivW8pYVgZT7PlyWZHfibLLAxrkpAX4rLKjtvAseos=;
        b=LI8fV2sSK0iQYT/LTBlSu0wCzRFjGq79OKMSj3H5I48/7q55IcsuNYy7NT/8yufBLF
         Q1PILeR4jXY0s1klyGKo4YAwpW7d3b/FtporNO0LuYoIugafBy+Jl6amCOgGV/o6n6UF
         0b+DxxDEHQSj7A5tz+vx/+uWTtMpGj98dEFYL69zXPs2/DBsmlfgIRIPKrqIvrbypYT8
         eMlaj+Rput8rxhWKCWWamDJSnjUPNat/XljdpVLT9X3bty1681n3rDeHbkFpuz84KKlZ
         yqEvPB+wcvEyPiCUMNcO5dSz+71yXOXqb90HKUB+ebVXldHBzl6RBe3urfR1ArhhaWg8
         F7yw==
X-Forwarded-Encrypted: i=1; AJvYcCUFY50CPKyzFrPws8mEZUDIt88eYoW40PfdHnQdwePp09+aqB0YwL+g3GBpp5r3nCLLP1vBEYqVFDMR@vger.kernel.org, AJvYcCUUp6NskGOxE4kvjaEKrCPhGQtVClZD0YhEewzHJYg89ayLMBc6tyLvy709vthSxfj+7bslDc47@vger.kernel.org, AJvYcCUakO+yeBPZJnv6IFMd2ElhrVpVXWRBhqQPtu+otOz85eMNE7n+SAwZ7DLmu+xf6+Ugj9DSUt0cn2KH@vger.kernel.org, AJvYcCVo+NLV77a6eDWonuFkZgcYt8a2GntK7P9MgybH+Yxj6CKRmtvx3mZ1N9sH38zAp6BtLWSWWU2diUm5O/fE@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDm5Cb6R9k38DTAk6D6otU5l5exw3v8HDqIF/tG4RC0IZaizq
	MZB63ra269Mdf+yLBGFbe7Hz5VoECz1DVS0bJLR2cjejgpwIN5he
X-Gm-Gg: ASbGncuSNmnrqyUlbBTh+ywhyHXN6TSG0d+XV3MhewM5RIKJ6OFc7CvodvX6eSZ8nAk
	CeCi4gb67KmtevBcH8UabsdcB+ve53TaUjrdMCCC1tCyd/bTd6lgWMEmLZH1eg/DUJ5hlEBYm8i
	dVEf3i0+Oo2EZb217yoPeqoYsXiAZI1h8nAfWxFCs49nzKcfi8WL7wTui9yM9BLvo1rr6hvDqOD
	4jLmELQF578+KeXWS0jbPvdP3LQVCKn/S2FG9IYnHnkEuotMKc3LFi+0yvY1jhwJRU=
X-Google-Smtp-Source: AGHT+IG+EiBszWYs4bnKziq7Mw4jET+2/fqiEcn0ZR2EzbHv+C3QyQXxJEoACfVK90GKflhUhfibIQ==
X-Received: by 2002:a05:620a:439c:b0:7be:7153:63db with SMTP id af79cd13be357-7bffcd148f1mr3432637885a.17.1738658778573;
        Tue, 04 Feb 2025 00:46:18 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c00a905ab7sm617630985a.71.2025.02.04.00.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 00:46:17 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/2] clk: sophgo: add SG2044 clock controller support
Date: Tue,  4 Feb 2025 16:44:33 +0800
Message-ID: <20250204084439.1602440-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock controller of SG2044 provides multiple clocks for various
IPs on the SoC, including PLL, mux, div and gates. As the PLL and
div have obvious changed and do not fit the framework of SG2042,
a new implement is provided to handle these.

Changed from v1:
patch 1:
1. Applied Krzysztof's tag

patch 2:
1. Fix the build warning from bot.

Inochi Amaoto (2):
  dt-bindings: clock: sophgo: add clock controller for SG2044
  clk: sophgo: Add clock controller support for SG2044 SoC

 .../bindings/clock/sophgo,sg2044-clk.yaml     |   40 +
 drivers/clk/sophgo/Kconfig                    |   11 +
 drivers/clk/sophgo/Makefile                   |    1 +
 drivers/clk/sophgo/clk-sg2044.c               | 2271 +++++++++++++++++
 drivers/clk/sophgo/clk-sg2044.h               |   62 +
 include/dt-bindings/clock/sophgo,sg2044-clk.h |  170 ++
 6 files changed, 2555 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
 create mode 100644 drivers/clk/sophgo/clk-sg2044.c
 create mode 100644 drivers/clk/sophgo/clk-sg2044.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h

--
2.48.1


