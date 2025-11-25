Return-Path: <netdev+bounces-241457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B6C84149
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E756A3A5738
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE032D9492;
	Tue, 25 Nov 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcUq0cLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080662BCF4A
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060880; cv=none; b=jDHXQKlXTm98L64VCI+9iXJbVY+kaNfW7rGvlKE/ZjiYdM2pN4wYnGbqTGCxeC1/LsKFDoBh9U44NovaA6Y3ljE9WqiTxLIWgiFvhMv6F5A7OWzg5gRFrU+1tz0Y2wJMDUgjFBzFIqbQ+I6BzwDrR6KlbZLrJfEKCr3G8jCdn5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060880; c=relaxed/simple;
	bh=+rPzlTTGDHBiu7g6uncIg7hpYKpcHkzjqyHxm7RSCi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TWQFS7ZYRMsMlMTMfdSEWrZDi5dkS5pNgzmAiW3tSVLFIkqd529npv6xaIwFMvtyDzz5dj0MzWtzEPr2m3HhRAfMmUthhH3L8ArL3thNtWSLfvQonQpBDqxDvsQ813GjeG6sE8imjkg/4jc7m5Ajr7W6cPlYQU6o5BUKSc/jgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcUq0cLQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297ef378069so47712145ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764060878; x=1764665678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2d7ZWjlz2JDe0uOm6xYACisrKq8Q1WaOIOi31l+DVw=;
        b=YcUq0cLQWYYDtcfpqBURMPnZLmlPohvJUbTFePqg/UkiIqbXfRnPEsl3cW9vyY17Pa
         LoKAA2f4Czpa56yi8dsQK6OtF4ZKLAYnKRXV+CraQPH81teZGzJRCIKInx1BIVC7j2VU
         6k7V76dga4kFFSmwcUqD44D1jqDM0tPIo7u39pce+hOV5cxbDZgOIN7UsCRTYWkUqUhT
         dvCgV2An+Rg3hQB9HZqAUhoj3JNGU/9cO4TcrZ4/oS1o3Y8Hvk1HeHgwmm45sJXwGy8t
         w3WtiQrH9q+F9PAf3Jgs84ANXFBh7AafZ0iICUq2xizlUv5CxfozgOaEDznRTZmjk5Vn
         VVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764060878; x=1764665678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2d7ZWjlz2JDe0uOm6xYACisrKq8Q1WaOIOi31l+DVw=;
        b=f0SW9qKHBFzu7pKQAazV6p7D/wDjCOUO5543bLEDLviptVtW6XLEv6JHjv7lsn1Fkh
         WyoCQ/OG6+oHnUoaLBDXO/0X0KoBTpW/rWHsKHCgsUrxboOQHsJz64HeN8UBRgu+L4Wi
         iNB9Q6UM5Swe/ZQtE10Dt44S677cKFCSphlITtuV/wm0uIAsLxbNNMMXlIsoyItsjWfq
         NgeI5s26DjogQLA80Y9l3knn54DMtVv4SaX4LcgWqWrCUJK0zu330+9BaKSZ9pacOMiK
         tgEgAcT8dxGlMpigLKuihgTnRxm0SOKdgYVPBpK+evqcKsX8QYw8kKNWJ1trPiiLDh4N
         FIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo/3AKGxECDnt69QHmEgSrOJ9cl+qhmK3eh7YhnRxpeYi3B7i6r4q50gmEWr9UWR4wKipQXnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRx1cBxm+iZ6I2b2LNbb5wFpci3lZIqQP2Z9MLWH0KGsEgURE
	E3TgziqRPvnbOnAH5TJRIudLwzkqTL7bKvCkZQtToqb5I67RT9JlTjCm
X-Gm-Gg: ASbGncuGqnSYB2aaciZe1wlqimFaT5TPxuSU3tM7+SnrD4xGlF1djaxZ8FzM92X+CvR
	8uDm2xjzEMAVAA+kz4W0VZPAnEs2f+I1LEtAvQWli5zmWhpRnGabP0ASMAs2mBRnMlgFA2OPFj/
	6mk/dQUMznL50Tj/vkMF/2eAax5u3gvsXDmu3ODKYjIrHfilLoMiFSqRj/SPzYCVe2MbKR7r35z
	lIfONqKAJxEz5STr3Fgi55wOOQngRrrOES+VKd7NGq/Z1JLwPkuMB+zGdiPXWML60HtoKs1BDEm
	6lueZn8VzesmKbTU5RekC+joB2hXn3lyefvT5oo+8ZwCm7PkSOUEjz4O08dUd/HKmek37pTIc4X
	NTgV24GMXLPLYAO61KE4iP+ea+yRob4jTnv86fUGh7RI3bDEZsdByzzjW4iJF5FCW4gcD2Bfbtp
	nnGyzz/nCN7EBA5HsL7yWWYV3YznPIcv7J5AxnKsV4eGkcfTFEiskN7HQ1QA==
X-Google-Smtp-Source: AGHT+IFGkQ27GCUa9O+yUVXV2TXGWxmYrK7j83HZbm38J36zxWZGE8Y2JiZgqodn6lng86q8YrtWeQ==
X-Received: by 2002:a17:902:f70a:b0:295:a1a5:baee with SMTP id d9443c01a7336-29baae4ec26mr23315085ad.4.1764060878302;
        Tue, 25 Nov 2025 00:54:38 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fafe6dsm15192263a12.34.2025.11.25.00.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 00:54:37 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/3] xsk: introduce atomic for cq in generic path
Date: Tue, 25 Nov 2025 16:54:28 +0800
Message-Id: <20251125085431.4039-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the hot path (that is __xsk_generic_xmit()), playing with spin lock
is time consuming. So this series replaces spin lock with atomic
operations to get better performance.

---
V2
Link: https://lore.kernel.org/all/20251124080858.89593-1-kerneljasonxing@gmail.com/
1. use separate functions rather than branches within shared routines. (Maciej)
2. make each patch as simple as possible for easier review

Jason Xing (3):
  xsk: add atomic cached_prod for copy mode
  xsk: use atomic operations around cached_prod for copy mode
  xsk: remove spin lock protection of cached_prod

 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 23 +++++------------------
 net/xdp/xsk_buff_pool.c     |  1 -
 net/xdp/xsk_queue.h         | 27 +++++++++++++++++++++++----
 4 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.41.3


