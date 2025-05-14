Return-Path: <netdev+bounces-190413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83973AB6C7E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAB03BD7D1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5EB272E79;
	Wed, 14 May 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgcrfvpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D225634;
	Wed, 14 May 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228842; cv=none; b=Qsib/8HDuoCLak26Gt+ldfkf+LQA0Xyu95SIIVrYa558DRfKsUhZ3zjdmbju8k/NwwP63Rc+N0Nl71Lawl7aRBAaPKepbEMhGdlAf3JmDRAjG1Ms+VrFVfhzgbajRWFV0BGrldsCNEM58Wzn+osqmSuLqqWgZKVLZuVpDOgAjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228842; c=relaxed/simple;
	bh=ZWt19gJpyBxCO0Qx7giNrFfawsGCTWfq4f3xf3LJtvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFeMX/lZL9bsaULk7BYjqtHcoeoVeVwWEnaF+sIq+Ee4NJDaz28YWjj6ml4ah2idY1Nmn3ob6PiJh3fHDdDm9pUhBaFFt7YIZPH2p6Vf6knyruaWFzR0RCjfsofW1yRF/1l0cpSL+Ttlmw6OXfKwHO1DjxZGawRPes9C8WEphIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgcrfvpD; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4ddb1173349so2476120137.2;
        Wed, 14 May 2025 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747228840; x=1747833640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh+m4E+zucuQUlh7kBt8Qd3tic2gsjlPHHvbyOaxGzE=;
        b=NgcrfvpDNaCXc6RLgtDhC9ZwP3Z4FLaFZ3hwy6OcQ00KYaZQ0ty3ooiBToIarJohdD
         +9xEFi0AXpqeM1hF82QwWlGXkw39eOiRnIQ10d9KcdpaQSbCZlaDeIdDIpxQxwmYQnpb
         LRssJKKzw3JW8Zc2OamaTmMBbA2y1wFLaG2YI78OcURwC8DXKBZVt8Id4oXbdQjvLr/W
         nfX4b01JY3oMoX/lDBlqrwKbNXiZnfhhjmxQmMlFESkvi9C6TCXwJkffnRDLxk/Alomq
         ZMwITj/jmhmJL+BlH1/4rOA2vOxSQ6O6n8syQTTqva17JjEWDt/29IUcRM8TPDRhcsRa
         nEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747228840; x=1747833640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fh+m4E+zucuQUlh7kBt8Qd3tic2gsjlPHHvbyOaxGzE=;
        b=Cs0rUvMCyUHazr7SpsHCnp0N7Z7k3T1xwoYCT/0Wg51Pc6OK7WzcP9KFTkuP4obaqa
         fFlZLlS0WhVvSQyfC5mJtrdDwkWNVdKoAYZ4ZrPMcB+qtbkQzUnDg9Ho2KjOIC7+uo+z
         FRou9rx/TEKYoOo/RSJbxpSm94+oGxusbrLkJ3nF6rDx7akXJi2U6xgIP7TrHWzrM7ja
         PFV9I7V/WYkLY58aP641gmXlZIolXv1oeVtgPEnZH7MgZbePCyfZWM4XRDsWhv8JxDI6
         QgBNt2x4lK3TyTD0Dh+rr1yEft69fKsCqTbdQIGj/CBf38onhJw84+0V9DSjaqJ4Ru8Y
         PaOw==
X-Forwarded-Encrypted: i=1; AJvYcCUP/BY/KOyHrglCRZOQdkfAVn/TlHjIHgI9+zmSRmjCd1mUN8JEs5rtpohDfHhuiPGFYO1A2ABNWslFWPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSVdM96lYbwvwMi4ww77M/xdhYgOrfh2gae9rGO7dBwBN0/57
	5kToPrS7nuH4Y3ho+h0VHNAhtbpZwKGJYZ6LA55B3/bFD0JVD3n+ME4TJQ==
X-Gm-Gg: ASbGncu3aj2kcY1Dmf1IIOYLK3xYH0P2aB129tREcNxg4KvRzTOujT++zSXu1biIinO
	INFFoQbZnTUZUaauOs09ajoZ1q8JwMHkhNlAUZ/In4Uw+0TrZzEu+R5OSM7UI7Kzt1ZuC/meU89
	uuDh2yHdEVZbEQAHW66fYjnRdfr99EIF3Pmg3F/0sDZqNAE2tfrtL/O/DeD9yofi/lo3lYXTusJ
	fFwyWmDjSGsnA+vOLi9PXo9atKjdKRSfOPwM1wT8p288HSTzeX92k7bnNrG6RW77ZNoYFkbxumo
	j3fJ2HQUVRK3IQOUY4pjllbZmPVtyX1KQgmRBjrXW763JKDKVoaT702W1EUzphH/mTc=
X-Google-Smtp-Source: AGHT+IHpib3Vzj9xPKBQQRXmWA9Yet/IIH3Bc9NFE6IMw31mBiIiC/vReY9tT5T6ESniqt3i7d9cpQ==
X-Received: by 2002:a17:902:da84:b0:22d:b305:e082 with SMTP id d9443c01a7336-231981b9729mr49477455ad.47.1747228829408;
        Wed, 14 May 2025 06:20:29 -0700 (PDT)
Received: from C11-068.mioffice.cn ([2408:8607:1b00:c:9e7b:efff:fe4e:6cff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7546b32sm99091275ad.11.2025.05.14.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:20:28 -0700 (PDT)
From: Pengtao He <hept.hept.hept@gmail.com>
To: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengtao He <hept.hept.hept@gmail.com>
Subject: [PATCH] net/tls: fix kernel panic when alloc_page failed
Date: Wed, 14 May 2025 21:20:13 +0800
Message-ID: <20250514132013.17274-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We cannot set frag_list to NULL pointer when alloc_page failed.
It will be used in tls_strp_check_queue_ok when the next time
tls_strp_read_sock is called.

Unable to handle kernel NULL pointer dereference
at virtual address 0000000000000028
 Call trace:
 tls_strp_check_rcv+0x128/0x27c
 tls_strp_data_ready+0x34/0x44
 tls_data_ready+0x3c/0x1f0
 tcp_data_ready+0x9c/0xe4
 tcp_data_queue+0xf6c/0x12d0
 tcp_rcv_established+0x52c/0x798

Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
---
 net/tls/tls_strp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 77e33e1e340e..65b0da6fdf6a 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -396,7 +396,6 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 		return 0;
 
 	shinfo = skb_shinfo(strp->anchor);
-	shinfo->frag_list = NULL;
 
 	/* If we don't know the length go max plus page for cipher overhead */
 	need_spc = strp->stm.full_len ?: TLS_MAX_PAYLOAD_SIZE + PAGE_SIZE;
@@ -412,6 +411,8 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 				   page, 0, 0);
 	}
 
+	shinfo->frag_list = NULL;
+
 	strp->copy_mode = 1;
 	strp->stm.offset = 0;
 
-- 
2.37.1


