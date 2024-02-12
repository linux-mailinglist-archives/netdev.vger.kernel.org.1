Return-Path: <netdev+bounces-70897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFDB850FBC
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E016B1C216A9
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282FA12B7F;
	Mon, 12 Feb 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXFAguph"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7B12B77
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707730174; cv=none; b=IpriCdYY8rblSx1qFVMCsXyZm6+MsJdQMVHP1rqguIhZ2vvSYqjXyN9LmmU4Sgo5Rh19Ocj1+iiBO7iIuIDc4pGUirpI+T46dZa8UWw1stezepSQX1tpmbAcTy8pBr0fnx49e2KtBhmiYIj8jwCIIuvwekM98GH1mH/TS2zlTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707730174; c=relaxed/simple;
	bh=KGuzQ/U9oJaJRiGWzOYK4sxYuJ9+hp6QQS0Vu0cItE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+DdQbmqqJGc4V4SQZimL4wXDhcg+wJBIBCra5HVf+QnpCbgzS/3EkJq31+XPWSmxM59l0FwOmvC0DqLMRLVDbWkw7ww4XcPHpepQgvWR0hC70saF/Q/K+NizEKAOsmjQynpbPbbZBfboKbQFy80Cqg808y9twxETiuptMMKUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXFAguph; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d51ba18e1bso29495925ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 01:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707730172; x=1708334972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elhleSSyDLVcBwZpacxS/lf/B8lw4HbZM4ZcwYARhBs=;
        b=RXFAguphgziIxDQxqFxT7LEeNIYERe1rTcwIwStrr6np1ci7FyWN4wW7fN43deslmt
         mLNZPp/0WtXM/ESXgG0wMJhLjj6LuhGDLloqMXLfvOnv5YXBL9yfpdnHWXnXSsu/VIyH
         +HvrXKDgBBm038CvJ44RH/OzEAEDytAWfotGwA5pyKYanCKVDF4tPgrSo5WZTmxG3zTr
         RdZ51kxZihLI/idX9vOwNx8m6e89nuSf60FnB+gOY2lQUpfL8CuSkFLhTAyUWXUwqR2E
         8+d0mWJm/FT8uHtNr1Apodq2+KSCsOk1/rwThKpBWhDToQJay5MVSNyJTBem56BWsz8B
         iTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707730172; x=1708334972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elhleSSyDLVcBwZpacxS/lf/B8lw4HbZM4ZcwYARhBs=;
        b=sefJNNdhOkBdDRpNjAjioDac+ZnqUL/oZ8Kc0MO/qIvwIici7rbFgQ0lWbUtlEIF5r
         jmBGr4mfhk+SmFriZcsG8biTc/TuMiGGKrb9dYWU2XIfemHVlEFzrw+6BkjKtKZ1lH0b
         25iN5Rw2tlF+6rl284Txxo/W2+Je2IYf7YbSml86QiJnhu4Ye2Akkg37laaVfWW5Lv2j
         6Cy691uAemRp5ih9ENdqWTo6r0JO8tbxdCepif13pBTcsrfAiroI387QVGeaxVTbg0QN
         y0iApR4SoX3mb6vRpmuP8gyB75T1OiFsagUMThDSgMu7jh3tdZbpsqGxiEms5eHg0/nM
         tZsQ==
X-Gm-Message-State: AOJu0Yzr4/XkkskNGVSr7Qedv65A09G67l7Adh7fwjp0hfJeBQjRR7xc
	53ENj6c07ehCKkQrFU2UITeUNcZRpGLLjZTR0O1unZ/7A7QBy72i
X-Google-Smtp-Source: AGHT+IHFvoPUitIGXI4FkdLPJOZMi7rxZJRE23QxENjmniXmb6tZ76TtxSN7jGMoY+l8T3c33BvygA==
X-Received: by 2002:a17:902:834c:b0:1d9:7095:7e4e with SMTP id z12-20020a170902834c00b001d970957e4emr6155476pln.27.1707730171922;
        Mon, 12 Feb 2024 01:29:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1ZZ1HxXULYMOCvf0D5VfsPw6JsmYKlWaIVNQDHNhnoyfHtqiirpyBshtX9yNgoYB3Nkmm/g9PaJZwqb5zFlVqwac/ozFvjHhq9ZMKdS5ZTQ59T5wpuyFspDPguLn51kMVBuOMRLWcNgiXN5PDlE7+I2MmAtK7jOJA6lI38EItMZU5/JVxwXVysDSeSJ2cwLw2PqqUeGBgpChP1whRId/ReA93QjhtwUzIUHjV3/0=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id mg12-20020a170903348c00b001da18699120sm4220211plb.43.2024.02.12.01.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:29:31 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/6] introduce dropreasons in tcp receive path
Date: Mon, 12 Feb 2024 17:28:21 +0800
Message-Id: <20240212092827.75378-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As titled said, we're going to refine the NOT_SPECIFIED reason in the
tcp v4/6 receive fast path.

This serie is another one of the v2 patchset[1] which are here split
into six patches. Besides, this patch is made on top of the previous
serie[2] I submitted some time ago.

[1]
Link: https://lore.kernel.org/all/20240209061213.72152-3-kerneljasonxing@gmail.com/
[2]
Link: https://lore.kernel.org/all/20240212052513.37914-1-kerneljasonxing@gmail.com/

v3:
Link: https://lore.kernel.org/all/CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com/
1. Split that patch into some smaller ones as suggested by Eric.

v2:
Link: https://lore.kernel.org/all/20240204104601.55760-1-kerneljasonxing@gmail.com/
1. change the title of 2/2 patch.
2. fix some warnings checkpatch tool showed before.
3. use return value instead of adding more parameters suggested by Eric.


Jason Xing (6):
  tcp: introduce another three dropreasons in receive path
  tcp: add more specific possible drop reasons in
    tcp_rcv_synsent_state_process()
  tcp: add dropreasons in tcp_rcv_state_process()
  tcp: make the dropreason really work when calling
    tcp_rcv_state_process()
  tcp: make dropreason in tcp_child_process() work
  tcp: get rid of NOT_SEPCIFIED reason in tcp_v4/6_do_rcv

 include/net/dropreason-core.h | 22 +++++++++++++++++++++-
 include/net/tcp.h             |  4 ++--
 net/ipv4/tcp_input.c          | 28 +++++++++++++++++++---------
 net/ipv4/tcp_ipv4.c           | 20 ++++++++++++--------
 net/ipv4/tcp_minisocks.c      |  9 +++++----
 net/ipv6/tcp_ipv6.c           | 20 ++++++++++++--------
 6 files changed, 71 insertions(+), 32 deletions(-)

-- 
2.37.3


