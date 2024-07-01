Return-Path: <netdev+bounces-108268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 685AA91E8F6
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178A71F2334E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC017084B;
	Mon,  1 Jul 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Z1tUz9n2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4A16D9D4
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863744; cv=none; b=AZXboxOxtg+zG6W/DB7bRsznshWoraddqzSXtfZRUztgy0UnBLQPiHdBtDcbjUpYQgTelisJ0DAqISiG2PancbC6HfDpltKO7tYxkjUSS0G6gmn4LOkA3xybjrovWGfiGXry6mReT7QXvWoymGgqSv8VFcJovP4BxDa9cm9xLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863744; c=relaxed/simple;
	bh=7jKnZ6ePIo6VCBoIov7zVF6xjnmelNc72zCU7n32MDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKEyWIPhiesOiJxDNoWXXg8Ec0VKba9Sx7ZpeeFY9cSMwg6fFLJqL9S7oGcWfkTUDTqqlLyeU4ziYINqbsr7BOQL0C+dS6D9YSaqL2wr+JPTAHuKOcdwnRC5sOPdu5l63zTBB/A0EERFfVM3q67PdSJdJqLrNat0Q41hHU+KLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Z1tUz9n2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7178ba1c24bso2154499a12.3
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719863742; x=1720468542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61ZyYjhYYNBZVEzKLg/hj86qg6mkRXItd8q/o7xs+AI=;
        b=Z1tUz9n20REq/+PsEHjFFeyuUlzwC+SxY0iJwG2I8jcTeOZGjYXH7u5V4EoSuD56cb
         DuOM0Am17+bxGuR7qDbY5n2oxDwhGT1hfRQh2Gwq5dxE4v3rGo8JpS8Q2KqWp3vZyXhJ
         AQwc7pV22e6WzljdfZF6AVYw60+IPWDFAINcZf4sXQKS5FmV8454siLIyXtImhQ1gN3P
         DyhHQT7oaElXRmvuvE2SzWcvs5SBV5MwS5aEVhc0Nl0JrVYLiNdVkLuaMuEWdWmCJELO
         UimRjb8xalQNkOwIhshlY86pRw7Oqg4aydplQVKeXH4Dmzxm6Or73s8f+07IIUf+qVSa
         MQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863742; x=1720468542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61ZyYjhYYNBZVEzKLg/hj86qg6mkRXItd8q/o7xs+AI=;
        b=mJ3GyjKDEa92Ah8xsH02kmTLNR9I0TnTRQ3zxh5QX6WcktrXw+zT6SnbDE7YhBeiEL
         87eyjEhejwr0F5moIqGqOiEkI1tzLbV8LXHajSUMCMmnUZSgwuz4adNJL3Ns7DL5+a5q
         m5edjqAHihuigHB9r9XR+++rYy6oMxqwYA7mUWv7AIQl0k+Li1v+GKWiselLpxxtmHdD
         hToZ1DgYcniRMSUEg+jrcNwOQB1GEU5eXgBatm1X5KbWaL3NlktELUXoaJ2lcDiXrD/6
         U751nnuYNZNJmjFVcNiAdHvl20Dmn1Wx8g6kIvCCCy0IP847kRU0elJ3W3KqnSXn+Rm+
         6Fqw==
X-Forwarded-Encrypted: i=1; AJvYcCX7i/X2dgLhoNkE98DsJZWK81uN+S94Z7Dvli48jG6A+yGq0qWz+PKV8aGVEG1lWhetjhjXQy1rN7r4ZqprWlpbQfzWarKW
X-Gm-Message-State: AOJu0YwySmv73ZCpHfkcdmqdskexjgtN5Ji7y4EYtVPL6x1CAu41hbwN
	kV2fv/JNDbERIspcS2Iaw5ZQpUoqFQ3wmfJfJxnxIosnhEzZ4DBZG8ZveF0tNQ==
X-Google-Smtp-Source: AGHT+IGIKQ7/gjxnqqYBpMVXf/4AF9OUT95veSuWsUMXsw8fQFggqDdIHRjFvEfwvgIsQklCD6W3kw==
X-Received: by 2002:a05:6a21:33a2:b0:1bd:2215:923e with SMTP id adf61e73a8af0-1bef60f5ef8mr11276631637.4.1719863742519;
        Mon, 01 Jul 2024 12:55:42 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:56da:44f:4289:b808])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599c44sm68785155ad.273.2024.07.01.12.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:55:42 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 7/7] fm10k: Don't do TX csum offload with routing header present
Date: Mon,  1 Jul 2024 12:55:07 -0700
Message-Id: <20240701195507.256374-8-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701195507.256374-1-tom@herbertland.com>
References: <20240701195507.256374-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When determining if the L4 checksum in an IPv6 packet can be offloaded
on transmit, call ipv6_skip_exthdr_no_rthdr to check for the presence
of a routing header. If a routing header is present, that is the
function return less than zero, then don't offload checksum and call
skb_checksum_help instead.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index fc373472e4e1..b422fe7be427 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -832,9 +832,11 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 		if (likely((transport_hdr - network_hdr.raw) ==
 			   sizeof(struct ipv6hdr)))
 			break;
-		ipv6_skip_exthdr(skb, network_hdr.raw - skb->data +
-				      sizeof(struct ipv6hdr),
-				 &l4_hdr, &frag_off);
+		if (ipv6_skip_exthdr_no_rthdr(skb, network_hdr.raw - skb->data +
+					      sizeof(struct ipv6hdr),
+					      &l4_hdr, &frag_off) < 0)
+			goto no_csum_offload;
+
 		if (unlikely(frag_off))
 			l4_hdr = NEXTHDR_FRAGMENT;
 		break;
@@ -851,6 +853,7 @@ static void fm10k_tx_csum(struct fm10k_ring *tx_ring,
 			break;
 		fallthrough;
 	default:
+no_csum_offload:
 		if (unlikely(net_ratelimit())) {
 			dev_warn(tx_ring->dev,
 				 "partial checksum, version=%d l4 proto=%x\n",
-- 
2.34.1


