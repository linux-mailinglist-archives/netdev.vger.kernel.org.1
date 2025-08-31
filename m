Return-Path: <netdev+bounces-218560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE72B3D3F2
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21286174578
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028E24679C;
	Sun, 31 Aug 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="nyE345xQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDF1A5B8A
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756652189; cv=none; b=FhxZ42LwzF8nDkSeKAmA2ntkpg3HnW8rf7gdNJIaqPD0bJ7LlVhoWWXm7B9iGQ8N53gg00PPcrGUFDQuaytjoLH9/VKmYrLLDzSwfMo3Gk3dI+Fl/poVI8W07YyLNBMGGK+BFbQwY4xVYJSViGV/dnXespPnki6T7J5Q2SpGtjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756652189; c=relaxed/simple;
	bh=EtfLYB6Ix1bHJE3YAm2Ocn1PZIurA8/YM1AS4zYQv1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ws/UCRbJHedk80Zz2POA+wLFkj2w4NzZfF+Is/AqLNJpqyAPKPsKdsGJ3CeXxDJJbSddNgQfUx3ZwtiAvm2zHcACw3rjjMo0J20pRx8Ti4xEyCO/xtF51WFGWEXrtTMKXk83C4uEhRlCfpcxpAUHh8NCPus/VTOqv9MEGSdY8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=nyE345xQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so1253475e9.2
        for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756652185; x=1757256985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
        b=nyE345xQLfwxPHvLxyJ3uhaokRhb893FhFR76s+U7p4mLAY4I5OWSvpK5zDJ6/EVfP
         tzQ6MCgHE9KLZZvrI47zmcKPW3yjyHkUrOKVLcUCWERAvgB3ExiQ/ub1m/Ih+YsGFG87
         HHYo7xbLycthPDd4z5aY667Nmp8vQi1TEmja88ZyHBFmmKhE65p7fayurx6kR0t+XLzD
         FlRsjTrVZmu/nr4dDRHCdaORvFMaeWOsAkzo6t0CF669L3iAfzZ87itVXyHo5Pdv7sMV
         j5qLgiB5JXTUWH4JsxHcaRo/tE2u86Pb1fnxU/ppbMjvcSOebkFpvp17S9B1kfoTmVH6
         KSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756652185; x=1757256985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9KRu8Ru4f/F2B2xaN1VxeRY/x4K4WntI346qys4v6I=;
        b=YENHr4P/PSGsulxns0kHmAaqKJI4EwwHsMdfbmDzdnW9swwYS1arfja08hsct2UGeN
         b9d5dATF49HqzP6QhD/dBkOGn7td2THjyuaRSODRphQ53Wh6bGyxYhAIogFFDV7RjYrw
         84urqBWb0bpU5xWIibWGpkZfSYK1UrgYaksGJnIzroa1uKIRDq5AeQKy7ipprZBlRLYc
         q7WvcA5qubspQuMm1yRqxSOTbd5qgMeBOS2L39/yBScz/CUgQsEB5mHGefa9zCOaatHN
         HPuTguwCjSIW3zrT4uMeev9iBMxmTnJ/izB2g3yvB4BYR59B9+fz+6dV82yIUgeT9Zph
         0WQA==
X-Gm-Message-State: AOJu0YzzUoSTJXKouVS4FpreqaC06Wi8Mdy7ZV783shBqHKDfteJz5oB
	tz4hdxkVBq29JGQCcci+F4EHWcCIDF/eTFEzdEFYkc8sMnrJSV65xqxiRuekJNdmDu+q2NqGm+k
	bXAx2e27Mp3Arj/LAGA==
X-Gm-Gg: ASbGncvIa5pDvLZAitRKhm8vtxjuKwCvxw2A/PK4JixPbtMMUavEOfn0/uzZ3W2yVCb
	gYdywj8f37NhZdshXxV0EhVSwRQO/vlyl6igNOCvSuadRlbhEh1enE8cYsp99Uyoa00OtdHhN1h
	ZpvZ1NPk8O0O7H9vZcLx3KJvU+4cS5IxD8Gvd54iC/qsGrICUwxpqkutlXTrUYuYU7JaoigZPIL
	+oQtYadmsSLnX6uTdyh0BIe1s/wq/DGUtJSmd7ujbeiYjz92mA9bs8TWU43Id+LjM155b5+btVQ
	GoRijPk6WS8ZVKpg7C79NIVkPjC2AURZ/hzMkX1k45ZzZxZqZckbLNi6nvEg38I5aDSXGf56xti
	+hmDJ6MObU7pnaZTiBJo0Q9KqnWoKbD83zSXr3WDkhdUUK9kVbBfyuGxLhtu/1DwtRltHxnpkYi
	Ti8KU7bCFHmTcypifk4w==
X-Google-Smtp-Source: AGHT+IFECZm94cv0ABA94deFhM69SwEYykQaQ3t0S0Jj1eMYv2dW7N7j1CEH45wVfmQ9gpzQYScDYQ==
X-Received: by 2002:a05:600c:4715:b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-45b8558ad00mr38526875e9.35.1756652185412;
        Sun, 31 Aug 2025 07:56:25 -0700 (PDT)
Received: from localhost ([193.138.7.149])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33fbb3ccsm11425183f8f.51.2025.08.31.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:56:24 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: netdev@vger.kernel.org
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED),
	linux-kernel@vger.kernel.org (open list),
	disclosure@aisle.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] batman-adv: fix OOB read/write in network-coding decode
Date: Sun, 31 Aug 2025 16:56:23 +0200
Message-Id: <20250831145623.63778-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

batadv_nc_skb_decode_packet() trusts coded_len and checks only against
skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
payload headroom, and the source skb length is not verified, allowing an
out-of-bounds read and a small out-of-bounds write.

Validate that coded_len fits within the payload area of both destination
and source sk_buffs before XORing.

Fixes: 2df5278b0267 ("batman-adv: network coding - receive coded packets and decode them")
Cc: stable@vger.kernel.org
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 net/batman-adv/network-coding.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 9f56308779cc..af97d077369f 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1687,7 +1687,12 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:
-- 
2.39.3 (Apple Git-146)


