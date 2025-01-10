Return-Path: <netdev+bounces-157206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B259CA0967F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9311E188DA64
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A95C211A05;
	Fri, 10 Jan 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9ycY8UN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B03205AB0
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524556; cv=none; b=TvtxdNA+AGUuPi7MYE53hi7pxdwsXVCmHsw9hzCmNvxkymPOhFPfb4hnxXad/BbaZCeomhu2NKI9GordLRf6YGGBlghX1cLcvAch0pf1jzjEhYB7NdBeIUQj5MjBIvlFtFDGYJMXzjfcV+sElpNqjDjxo3B5iDT9Dd+z0luOc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524556; c=relaxed/simple;
	bh=9D+4Z9J47W2ofvjegJhmDcKZ+QFlF/rAow3aM5C7Lxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eq7EeHfNLv0kHIfYcEHxJhrbxu01X0HXRtkKlRkMy2UsVFGUcYZ+YQyZkqOfwtjeKyw/rZLDYhxHq0TYrKZ44mzFxwkScLNdGxk/VOn08uWzfxECcS+jHZJbUEQC9sV8lbMG4SlGbpnAfaOJkCqbXPrDFz1qlKSe2tUaJsNdX6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9ycY8UN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736524553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0Aufuv6tvqgTXjQty6QjFpekc0/qqApFRYxi5TMKIBM=;
	b=G9ycY8UNeEgRKwinQauy/w8Iyzy9Q6nL4RbHD0j/R7F/IS6nlD+ycHAaB8grBdZA0lB7T4
	ywbwSv+kh2r4jlFiDrr0Z1DFVFegqAznIN2+QKY5cX81XHzsSOcKYrkvc1louSzClUwu/G
	+iMY0crhWh4Op/DSWDFpJzxx1EY5ty0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-eGNVTVJ1NMuUXVt0n3wAjg-1; Fri, 10 Jan 2025 10:55:52 -0500
X-MC-Unique: eGNVTVJ1NMuUXVt0n3wAjg-1
X-Mimecast-MFC-AGG-ID: eGNVTVJ1NMuUXVt0n3wAjg
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aaf8396f65fso223808466b.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 07:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736524551; x=1737129351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Aufuv6tvqgTXjQty6QjFpekc0/qqApFRYxi5TMKIBM=;
        b=qtmacqJ46Aq23bkg/lTg05wwduW6KoRqfsmhkLb58r0MJTo9AsPimwqHbzWke8lIKH
         JdzFclYP70kC6N6oWp0dTUI9bLecxhh0iVRKyh1uN6Jx07+3FjW0RltlptMayyuWHgMo
         M/FPxdTQPOg2Qy9OgOzUVsiulyKT9Ymk6ghiV1rEHrEsjbWBuXIAs+Ul7c2EbVCSoyS6
         w4cV90F2MGRTjV/rP0wxNQbDiYSS4q8srKm2dWdCnM4CcPuUm/s9tRohl6QARORzJNen
         W4EyKxw1mqedd5fwona6+romo7oFn9JvFcHo+Wqo08owKuatTQGSjkR4Ab2OWtPhcEpB
         872g==
X-Forwarded-Encrypted: i=1; AJvYcCX16dLHByk+WqRx3vHXO25zxV2hG55EPxIWYWeKLhjATPPf+lFuMluIWygHYIThtPCs0O0zzxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+PvQ3AaLj1XUjoEGqCYhgJGtHCTSYnPyfmNwODQDonEsr35m
	pGuVA8lPtJHhxJDWbPe/L/8JRNOn1wMZKwNmuU//1rcUdC+wfMVatKNjqgW+sUZxC+VN2mu2t7r
	SURMHV2/VoQ53HiZuSah/6EEhctdccUxnLbFPHSw1Rr1Ue2046TSJjA==
X-Gm-Gg: ASbGncsYvFHRxBFH+lwDC7X9AkEWsQxRnCBipM014+GQZD09kijEMK+gSuRtxYQbtKa
	bUw4d2ufNc/RHHvykKoi605TkkyYTY3rlkyJvUA1YecRYm2UdROBQGsshOcJSwN9U1kCImyNK5z
	omXwAYJm+VAisXGFQ3lyySdYRO9t39u56Ee2A8E4/e0ibvivBbyQdHjRqk/knJIPstWsJ01jNrH
	In49Ck+pdItrrby2+Z9ZB3fbx1QSX8TnUlAi/psCsD6hzFQSzUlqw==
X-Received: by 2002:a17:907:7ea2:b0:aa6:becf:b26a with SMTP id a640c23a62f3a-ab2ab66d9a0mr910802466b.9.1736524550856;
        Fri, 10 Jan 2025 07:55:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5OdaYAzvp03kbItYQpgN/xe5SQSBZSqelB3xOFsA419/d2P50AcFvXRlJ2iXRNzYQchALsg==
X-Received: by 2002:a17:907:7ea2:b0:aa6:becf:b26a with SMTP id a640c23a62f3a-ab2ab66d9a0mr910800666b.9.1736524550473;
        Fri, 10 Jan 2025 07:55:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95af187sm180710466b.142.2025.01.10.07.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:55:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E7675177E571; Fri, 10 Jan 2025 16:55:48 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Dave Taht <dave.taht@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next] sched: sch_cake: Align QoS treatment to Windows and Zoom
Date: Fri, 10 Jan 2025 16:55:30 +0100
Message-ID: <20250110155531.300303-1-toke@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dave Taht <dave.taht@gmail.com>

Cake's diffserv4 mode attempted to follow the IETF webrtc
QoS marking standards, RFC8837.

It turns out Windows QoS can only use CS0, CS1, CS5, and CS7.

Zoom defaults to using CS5 for video and screen sharing traffic.

Bump CS4, CS5, and NQB to the video tin (2) in diffserv4 mode, for
more bandwidth and lower priority.

This also better aligns with how WiFi presently treats CS5 and NQB.

Signed-off-by: Dave Taht <dave.taht@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 48dd8c88903f..2a9288d4b873 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -328,8 +328,8 @@ static const u8 diffserv4[] = {
 	1, 0, 0, 0, 0, 0, 0, 0,
 	2, 0, 2, 0, 2, 0, 2, 0,
 	2, 0, 2, 0, 2, 0, 2, 0,
-	3, 0, 2, 0, 2, 0, 2, 0,
-	3, 0, 0, 0, 3, 0, 3, 0,
+	2, 0, 2, 0, 2, 0, 2, 0,
+	2, 0, 0, 0, 2, 0, 3, 0,
 	3, 0, 0, 0, 0, 0, 0, 0,
 	3, 0, 0, 0, 0, 0, 0, 0,
 };
-- 
2.47.1


