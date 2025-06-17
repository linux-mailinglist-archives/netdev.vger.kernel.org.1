Return-Path: <netdev+bounces-198675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A684ADD075
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11273A8B77
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C72E3B1C;
	Tue, 17 Jun 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVMalrh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE402CCDE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171366; cv=none; b=kKKgjtPNW9rUw9Wid/S4dYZC14y3rmqAQhD5lMl6bnrmi2S5IT6xgEd8HH4/U6sizyurxhPFlFbb/wZWPZS9DOyv/406t2tlXDSAzOARaQUo4JEIPuGCfuyr0EFDdFO8SLVUQ2sYU8v8moojVke9jj+LZipomiDIBVfx2dZ22hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171366; c=relaxed/simple;
	bh=FBPdJtY4lI6WB8wh8hvRiV+BWdKq3nFDJzq0mM8vMJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Chj/r+4mkJLhvpezwCVsCrZHce1ZUBwxd6el9pvUdNO+NqqK7lpMWoEkfOIEbXf3PiFdujpva9/QmjkrEu7lMZsS//6Y9MAKclFVyfEHkFhXCry4m8d8FwjOriQlRI73Pqr6l+DC4cdkqZbCjsTC/7wseaGLiBiZmPVIialJpIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVMalrh9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso10564717a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171363; x=1750776163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofzb7D8+Vka/MHqW9Ze6/jutRfaaH+k6XM8Et+0MOZs=;
        b=bVMalrh9vxDhcNQAcklqoqoFgy/lV2R71D+mvkEncYttvT9q1eiyThE1jWSX9SNPrQ
         XWP5Lcoqkmv2xO/uKgZdT9lQsgHuXil6/csb98J8J40pL2TV/Os40P63Th1RSQ2MYFuZ
         Zxzc31D1OY6q/qFHGjwUapP41mEeCT86xZa9it7/IFDa9W5p7xwFr9JaVG2B8FP3nVVm
         RuPq4n1UF1PUwnG0v6E4cSjdwfEprMUHBfTS0IvF2tw5zKijNLF0Dmib4xCue43mUVGm
         +m/s5tjlk8Kgvzl/oIbx5AJOgY97IxxiEfibKqeFirWPf+A1O+hJ+diDqfHWLX5B2knX
         xgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171363; x=1750776163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofzb7D8+Vka/MHqW9Ze6/jutRfaaH+k6XM8Et+0MOZs=;
        b=gXODhg5crbvCyH2IY8frvkYmH2GhQ+cfm1KOGbqwP1wOyIff6SarPrZlTHRq+lZ84P
         B/bQkquj7B1NUEdTJ/mMglj31KGkisJltiBtJJp1qI1dgsi8nBiN5lJ27OpfeNkygCnu
         MairyFWDM6VxgIzrrk7w2JJIdTgCpZdc7wedfyFiorr77NcJIpV+TemIJhC1an+AdR5f
         equExi3x8O697DQFLl4Mp1pHQbkaUEXobJSWzo6Eeki3gpkxcO7mI98GxWeqNKUzH8pf
         AOx8/4js3LAXkj4B6Rjm/W2FmHchSaKrTJoT73hCAqILusX0v6/9x2lQzSYd/Bi9ghWu
         iZrw==
X-Gm-Message-State: AOJu0YxhERkHZ+7MMHLuI5811HkzwZuayeT0/Ra9xQqhJwTjUGhhueDW
	MGP4ymD8JdjF5FLsW4tQZFTiKb2HREVezhCAYeP9VDjIAo9ppoZJMnwf
X-Gm-Gg: ASbGnctdqrnxcm5MyPAJbnwHQmkE17sfMWNmTMBJxs+jHdfnK7vHUsCUHvAjCsTrk8p
	eFpUGIPn1A3xebSERkpsvxC6pk/nCoUtD6WMER/OplsezenkzyXfDCm0syicueuSnvPhXhR+vz2
	HFCm3VaiPwnhRJtB9/0d/wnUlcETPHorTNuMfggci/6zGsm5u1CrolREl+sCe1VjZc1k9ZIT2CC
	xUbdv/C2b4tLXg8P3n7/r4MWxF1G4FtEvAmC6d2ZAJwn7E6pVirO+1Kn1cMGIXgvKatB8nkDa5U
	QgtLtAgwpQ2D0hIyUV2DoYR4XVD43b2PGQlSSerV3xirXui+8t5v0pgYmA6KkkQ9IGIqiG1dh5H
	JAyyN8J77LrwU
X-Google-Smtp-Source: AGHT+IG2yeEAHoQTQAUHFY7rp3AHpFfs8ad3SClw014FWU+l5fUaKfMzhs7ASLhLyja8U+07yjbA3A==
X-Received: by 2002:a17:907:7f17:b0:ad8:a4a8:1034 with SMTP id a640c23a62f3a-adfad367763mr1109030366b.8.1750171362865;
        Tue, 17 Jun 2025 07:42:42 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec81c5be2sm879272966b.64.2025.06.17.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:42 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 07/17] ice: Remove jumbo_remove step from TX path
Date: Tue, 17 Jun 2025 16:40:06 +0200
Message-ID: <20250617144017.82931-8-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the ice TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 29e0088ab6b2..abf014c3451c 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2440,9 +2440,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	ice_trace(xmit_frame_ring, tx_ring, skb);
 
-	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto out_drop;
-
 	count = ice_xmit_desc_count(skb);
 	if (ice_chk_linearize(skb, count)) {
 		if (__skb_linearize(skb))
-- 
2.49.0


