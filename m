Return-Path: <netdev+bounces-215025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E727DB2CB56
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFFE171C4E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7F30BF71;
	Tue, 19 Aug 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqTMmyAA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E71304BAF;
	Tue, 19 Aug 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625658; cv=none; b=UjzAue1neEWRjpF3AT7cFZQyH8Ov13dciCD7f3vwZC6mouWtWHZQwfw1CBw6xK1hMwOOxCj3GFepB7grO7TA1xRIEnRyEzw4y6ACHEzgcPG6jDrCStKjWEs7NK46MrQ/W/NqGIp+QVw4q84a/zyvz9idf7yqLX/GsZwB2z6H1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625658; c=relaxed/simple;
	bh=eRCBXhLbKeqTIjsWMkFHj5vXSRh8U03prKJPMmsdQgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hq2IAh7pzAFVAonITBy/QDZgX+CEA4ZPgBbL9mSlVOMlbGuEo9+L0reN69DuhBvtMKzFZhAIiIVveO/t23ZyKZ95dvZk8w9ckY1bzrp8O/S8jxaMCuJYOuEuls28BLERi2kGJOjl/pzU0zQf98ItfpbnIw+HL0N8dbWfg5ULvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqTMmyAA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b05d252so40091185e9.1;
        Tue, 19 Aug 2025 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755625654; x=1756230454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbvsSLtIOWC9soGuxx9uLFYHdgGFZpcrprHbW8s+3mI=;
        b=mqTMmyAA9JvVdzYs/uhPHzJpwE3zVvLDyQkrq9oegwVuhJEFxc57ohJ+TW80WMU5Po
         f50z4LlAqeGrkdBxiDZqEib8B8fZW10Dhm3E+dtnr5FrlNBwIj2deZ5ef/TLO7cEEKt0
         YjZp4sX6Dvi5qcQ4bySeOyNCSoo/gFFWZg3Hamr+wODH0CwqUZ2q51+uVNSFqn5etj75
         HOVevWiMyjAblRi+NRRWIbyUDAbupTLcBBJur2B+6OOBSMlK4fGwDc37x9f43LXrJb9o
         1T0U3kRuGfsu8Xdww7gKd5BNruF6sdJgm63ZjmBCjm0e2uelIl5N7Lc/R2P1f3kaZu+O
         QzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625654; x=1756230454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbvsSLtIOWC9soGuxx9uLFYHdgGFZpcrprHbW8s+3mI=;
        b=R7tcE/862tR3F4wwDbGPaTSrR71NsdMhAzjiR3HxxR80pmUkAF3iIdCWTYG9nsPxXI
         O5cOXGoKUi4OvgYHYLKmhh70aO5buSS9PBVLV2vMhl7wykcuFy0fqqUL4Y3XJx8AeY/8
         ertEAKyxKtZEY+eD6TZ5GuqCuW3qb00NnHY6rsVGLs7k6qgUberY4QONzFRW0HOnM1Bt
         EfjSKrz9VTcMIQSEwt7xi1XrTAS5d3KnGiqMSIzjcLyz6Sa7lhvIJH/L3kfrpEUuLDD6
         W88q5uAdk8AioSqBKBvYwD12J4qn68ryr206NhYL1SIiIEkaHEDgjNppdYjbeMwQBaAG
         iABA==
X-Forwarded-Encrypted: i=1; AJvYcCVEgfrGzRV1Gf5V7ZSu7CI+cSo1XO4MJSAnrslmlJTipB1cCHAcWYjg87UA1Y2KthEo9BaQRTbxhEgiMg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtDiN6eRdXyqL+69C1a+50gJB7i+cKq+yMPqpqFR5jB2jI2jt
	WupeBoQ1taGhq0CyKryWstr1pebhjfT6i3ShMg4+7+IktV0uzjcE7AdSfTfouArX
X-Gm-Gg: ASbGncsvoBI4/X38LNw4kDjTaPRWEH9eB6TZ69uqUcnhDLPqOVuoOII/ubn7CIF2VzV
	GzXu890Fc8kkroyn1zbevTdbG3tIYzirppb51dXHiVecKCZtL2OPP1GTiynimNGo1JguUcHqTVx
	0U2QaI3cV00/fjI7CtbRrDIo1zzx72TKPaxng7VynK/vTlosm1svGNyQw1fuUEid03mjrQkuByq
	u8xU7Qac1b5NIAKA/BJGE2ulIZl59bbN5kTUxP8KWVmXw1M3S1wrwc+i1WbO/gJeHGAa9DkQFPF
	KNdc+JPWKm47x//j5tJIt8amFAgbOSPPE9fwOogQ8uxiVxVLLuB4p4ALteCGquqqMoorGXY9o7M
	DwK3WaXFBjxNseQkiIGomKwrODDajS4IB/qw=
X-Google-Smtp-Source: AGHT+IFVoposqeSPh/42ZscM12YtW+myG+SpIPa3CT2Hf4QpSxbqNyWJfrcHaoh5VOm2wpmkh1fcOw==
X-Received: by 2002:a05:600c:630c:b0:459:e06b:afbd with SMTP id 5b1f17b1804b1-45b43e11dcemr32653595e9.29.1755625653365;
        Tue, 19 Aug 2025 10:47:33 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm232181565e9.24.2025.08.19.10.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:47:32 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v3 0/2] net: ipv4: allow directed broadcast routes to use dst hint
Date: Tue, 19 Aug 2025 19:46:40 +0200
Message-Id: <20250819174642.5148-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ip_extract_route_hint uses RTN_BROADCAST to decide
whether to use the route dst hint mechanism.

This check is too strict, as it prevents directed broadcast
routes from using the hint, resulting in poor performance
during bursts of directed broadcast traffic.

This series fixes this, and adds a new selftest to ensure
this does not regress.

Changes in v3:
 - Improved selftest
 - Use ipv4_is_zeronet to check daddr

Changes in v2:
 - Removed unused variable
 - Fixed formatting
 - Added new selftest

Link to v2: https://lore.kernel.org/netdev/20250814140309.3742-1-oscmaes92@gmail.com/

Oscar Maes (2):
  net: ipv4: allow directed broadcast routes to use dst hint
  selftests: net: add test for dst hint mechanism with directed
    broadcast addresses

 net/ipv4/ip_input.c                       | 11 ++--
 net/ipv4/route.c                          |  2 +-
 tools/testing/selftests/net/Makefile      |  1 +
 tools/testing/selftests/net/route_hint.sh | 79 +++++++++++++++++++++++
 4 files changed, 88 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/route_hint.sh

-- 
2.39.5


