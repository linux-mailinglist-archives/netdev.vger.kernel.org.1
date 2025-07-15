Return-Path: <netdev+bounces-207077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B08B058AA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E55171B66
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B343D2D4B75;
	Tue, 15 Jul 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6kIwYsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A11547C9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578681; cv=none; b=ZjWn0zzTQcUiL80GBh+HAYGapZIfbfkjij5EP+CED7XVChRDRj/jOt0GuWDX9Un5E7NTLmTsmuWc7yzcDAW+h6TEGLnKCOQvFm8hiLJSEPCPzVi3v7cyIhkh2SgO+lFgsZRoaDRexB3pWC2d0BK3mjFiEebt7SRV2SJYZHf++Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578681; c=relaxed/simple;
	bh=6gKtrLMU2MmbJUzbr2MjwD09WJvii16BKn/49Hr2dJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbKJZ16meyfF2zY85+qCszMyHR+DQm09uc3f1RdqMhBI+TzQGIikclvxaaZLfwd1QRlRsQK1dyzLaiCp9EZCPF55xcXFiDG7XPVr40td93xSMXUPw+kGxwsieWgYsfuPF145t5ZCNHd2O1j2Vd4JOgEvL7R9jAcVtL/DbDNaZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6kIwYsu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748fe69a7baso4335733b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578679; x=1753183479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zc7ZSINH5VWkuKhmExgblkCXOqcwXbFryyJlYKZGWQY=;
        b=b6kIwYsuRlAfoV858qS99SQy7PmG1A4oUERRfqASnnM9A2o4vi7MHzizrPq8tQ7R23
         ZkrLZZcNu/FCwEi8SIFL3Fdf5kzlPaq2J1e7lywABrdRTnQPu0uM7Qoc6rtG+w8RPBwg
         34bfq5NwbJL/uUiM2clpij8TbFk2nx1qHn2r1cygAHVZ9aN6S+Egxm2PXHXyCCn86F8a
         nyhwg+RYjDADR7WInchHFKIOyOCzHbSUQQLEbju+72LLOe9RpIK7WmbccQ89pbMoLS3Q
         RkkzWVu4YoOiM3lPViWeSPylLrusi53T4FjFUPhOTUPP92RpJtj8ifpKGHpBgN2CIzCv
         yBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578679; x=1753183479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zc7ZSINH5VWkuKhmExgblkCXOqcwXbFryyJlYKZGWQY=;
        b=YM2nharBwUDJ8WTsJeTaCRkbJdj+0gZHfu0SMoww+1AIaoXtruSJ9m/xPmZHSlQMgo
         3gJfrSRMGVPM1oMjzh6R7DSzFzbMw4a0VymIzrxCduCl0m42Mog7Ag/9ocm3TAqNGEZ+
         xFv8IVvJX+xp8azcRsk1dNdKYtUfvzi5OQGrXwS/LU1haUfBUHlwjzFo/hH7IGajkb3l
         DTy4eNAScXGbNqzbfW1ySp/YDfOZLdMIgSv3SwZkaIWdvZkDlN6YAyWfod+BRWhqm2+g
         vek3cK5PIk8+uYPTeftfVnzfv70r3auMbvR4DX2a7/a9J8Q0z8PVAVCHw0Ne5TwgV/Bq
         qUDg==
X-Gm-Message-State: AOJu0YyzGEY3qi3h8nbqk6XP5grgTmDrfPkSnGdxH7oMGYQfhZH1pqk4
	/4Cw3vsyS6BXwLVeRcdQsghSxybZbID5LpWP5yYwLsSxgjAelnj/AyFaPaKsegcS
X-Gm-Gg: ASbGncuQ0V8MEWf7PviSKN/bMbuamWqO6vJE/6h5dMv069UteOUyT9stxoMiiQAiYks
	QxFFPjaMTmpe2qH/PrJHsvbT7As9+8dgbv51VJPSJaj2FPvi9tSN4+UWefl9Ip4L/LngJj688QY
	mhlQFznOJuoI4cK/4ll8ZxmUD9UrvWgiAbVjPv6YtGMvktIEb2zCU3p9fkO9XqZ3xbjH2gKcR0Q
	DOHjS4VmY/UI4/BRQOxOtUsvPe6CHOmK+IDAmVuG+bzSnZPGVoMr1D7daojPR16taDnrOxZ3R9v
	89tyWg6deJi3IBvBqxKRAN+6npwigumpEWOnUcft3GpxRAAPuhtgoOPNRGrBTumqTlvUBSbtgh9
	/JAeRFtaa2sBaPLxO9crvTuDfbSKjxGzUPnQ=
X-Google-Smtp-Source: AGHT+IFf3b0bY43b2Po4Ng2mnOyEI81ruqzIqeVJtahcT9AdqDN5GXEiSvfqYIBI+Q2K3mbsXyYhvA==
X-Received: by 2002:a05:6a20:6a0b:b0:234:68cb:b2e with SMTP id adf61e73a8af0-23468cb0bd1mr13145132637.16.1752578678950;
        Tue, 15 Jul 2025 04:24:38 -0700 (PDT)
Received: from krishna-laptop.localdomain ([49.37.160.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3ecd5765bcsm734814a12.54.2025.07.15.04.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:24:38 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com
Cc: tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	jdamato@fastly.com,
	krishna.ku@flipkart.com
Subject: [PATCH v2 net-next 0/2] net: RPS table overwrite prevention and flow_id caching
Date: Tue, 15 Jul 2025 16:54:29 +0530
Message-ID: <20250715112431.2178100-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series splits the previous RPS patch [1] into two patches
targeting net-next as per reviewer feedback.

The first patch prevents RPS table overwrite for active flows thereby
improving aRFS stability.

The second patch caches hash & flow_id in get_rps_cpu() to avoid
recalculating it in set_rps_cpu() (this patch depends on the first).

[1] https://lore.kernel.org/netdev/20250708081516.53048-1-krikku@gmail.com/

Krishna Kumar (2):
  net: Prevent RPS table overwrite for active flows
  net: Cache hash and flow_id to avoid recalculation

 include/net/rps.h    |  5 ++-
 net/core/dev.c       | 89 ++++++++++++++++++++++++++++++++++++++------
 net/core/net-sysfs.c |  4 +-
 3 files changed, 84 insertions(+), 14 deletions(-)

-- 
2.43.0


