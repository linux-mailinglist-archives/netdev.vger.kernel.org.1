Return-Path: <netdev+bounces-250771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75977D39216
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 877493004EF6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3519309C;
	Sun, 18 Jan 2026 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmnjlDzS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B35CDF1
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768700386; cv=none; b=CWyuwLD5qwg/SEppjhV4/jgpDJqfdQU8CbOjkvs/kU/G1u0HbaTeoA0JrYob3dxcm9ghr3uPm3vd/gHr45McfEqUwt2IDeKkzoMOqg2wdqUL6OKgrjwAJJTVCmtr7HVXom7CXjCdciKsYdnJmnAzDI1AantuChamsmIYMwVYudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768700386; c=relaxed/simple;
	bh=0jWUJofDiSeSCMKQhLokxiJtefmja8AbzEsGnosWGhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVpVcQ+k9lqLavg/u1qB5k5KA7AYYqmdQzTg0ovegiWrCbUTrrfYOLtFH1nZrHxFxS3mohJ5+tds2EAdZwoZZ05VjEHbm6W96tHyRBezHGgvM0G5PIRWH/4tXrJVYOvaxMdzG+ZuczL/WqXJk6nmga06TP9fCHK9a+8xVXMTp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmnjlDzS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c09bb78cso24172025ad.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 17:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768700385; x=1769305185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw8J2Y7YQaSRnVxHkidQR0nWq3maGkHLEbX9+ftBs5I=;
        b=PmnjlDzS/x2LIHNgEGDrlW4xix6ml4oAdbj/jx2qhxxJX1v3LymRP2EOWy9cLJVK7d
         Ynv6+nca7NLNBPbeGZdNqJsTILNU0ekijbHFaFRbD74+nCyW0GVbNBs4TDKppwGesuf1
         h2IpW30S5Ux4/dzrDI4fEfIBbIZEcWBUDd+9L0EXK6GwLJm7fdRji+iFHvjs186r2qie
         cJ7Ale3rnOyNpgfOD1D6EgCJWsPoJMF7vx4Ch4yB7/XGF5Rke9bhlgfRoA9Y3EImmtVG
         tOYg+4BBN3wfPX6CruXAgVvlGDBxnZX1UMl+Zw1QXt3Hvp1MD+vUexPCoi0iQt9id1T4
         ZnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768700385; x=1769305185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw8J2Y7YQaSRnVxHkidQR0nWq3maGkHLEbX9+ftBs5I=;
        b=fVu3zJBoLT6uCTtzs780iOD+SaB/fSkZBmMzjeEPLu4x9snL6kUyXcOn/4EJKAobFC
         mI3f9wSHq0pSXX05o7ciiBzK/uodoxLl0HIRedg95MKQPRN90yIQQ8sltd3HdBIcStUQ
         kBip/LUWMScHPu3cfnfpTw1WvA/diw2DZLsM/3eRqFp2x3qMoKJDi/+gnW6naUpi9s1j
         HfKytLTdsN9YDBRfmWFLxKgonOsjUANKavfVTfT4KMzlByMDy+CkGZoivrtz/s8RAJQ4
         5q5CKeWohZLQoIFQZtB0BIzI/6txy8KpP3RMRS3xkM5k53p+rN8upMICveiadAy7YpAA
         MpIg==
X-Gm-Message-State: AOJu0YwpmV1gGVnvKHCeSTlw97rE4R2UzBAwmkoqu/FBJtjVBWeFsjvF
	RElINmuUYO8ERRvWkEiy4v01Ylnts7Ckhal+vJArgVhTDUEa67uN4ihUVoggmA==
X-Gm-Gg: AY/fxX5jzuKihL14cT9vvVDwNb6MRN40681gaFdBtJY1S6g5iUyeIg29GV1Dd86XnZR
	HHlrsYN/A2JyA0UYJw/ABArHGS5F4KNova9wHryprZF1FfMRfrdNDhCyr5mIhnbdhmycT0xBdwc
	nZ0Ao5KlCFajJexFJuJdj1oKZYYYEPBJ9rJu4FH7ATfr6Y6GWdpZKU3QnoFI54TbSQZM6dVLF34
	fAbjJYF8RyDd8tPK8Us775pprKNiEKEAY8CjDOoutiWuIMf5A2hwYUaKtklxgxbcFq4EZp/4C7Y
	ixCGmqujn2+qLOlc1EVDrp1NPghRqz3nKYSZw7FFaY0DqqNdZe0M6P5GuopaLSQTCOWp+joReHQ
	QiJqsT1gQDfr3Ia7dGksKSJvS0tjhAv6anWefU7Qju8QLD3GGhTsr6c6MCm9a+1gpcYreuQp2Ur
	0nIZHVX+Qc6bN+nrLqmbZk05fe07gW/dFjcEXzCAS85RADKlMEcA==
X-Received: by 2002:a17:903:3c70:b0:295:99f0:6c65 with SMTP id d9443c01a7336-2a700a5dbe1mr122059915ad.30.1768700384598;
        Sat, 17 Jan 2026 17:39:44 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbbf5sm56030615ad.47.2026.01.17.17.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:39:44 -0800 (PST)
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
Subject: [PATCH net-next v6 0/3] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Sun, 18 Jan 2026 09:30:13 +0800
Message-ID: <20260118013019.1078847-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning reported by static checker.

v5: https://lore.kernel.org/r/20260114114745.213252-1-mmyangfl@gmail.com
  - avoid type casting
  - split patches
v4: https://lore.kernel.org/r/20260108004309.4087448-1-mmyangfl@gmail.com
  - add missing u64_stats_init
v3: https://lore.kernel.org/r/20260105020905.3522484-1-mmyangfl@gmail.com
  - use u64_stats_t
  - fix calculations of rx_frames/tx_frames
v2: https://lore.kernel.org/r/20251025171314.1939608-1-mmyangfl@gmail.com
  - run tests and fix MIB parsing in 510026a39849
  - no major changes between versions
v1: https://lore.kernel.org/r/20251024084918.1353031-1-mmyangfl@gmail.com
  - take suggestion from David Laight
  - protect MIB stats with a lock

David Yang (3):
  net: dsa: yt921x: Fix MIB overflow wraparound routine
  net: dsa: yt921x: Return early for failed MIB read
  net: dsa: yt921x: Use u64_stats_t for MIB stats

 drivers/net/dsa/yt921x.c | 258 +++++++++++++++++++++++----------------
 drivers/net/dsa/yt921x.h | 114 +++++++++--------
 2 files changed, 218 insertions(+), 154 deletions(-)

-- 
2.51.0


