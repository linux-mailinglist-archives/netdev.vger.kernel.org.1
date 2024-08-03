Return-Path: <netdev+bounces-115464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F999466E6
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A5A1C20B64
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE24A95B;
	Sat,  3 Aug 2024 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0cdyLnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D963D0;
	Sat,  3 Aug 2024 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722652215; cv=none; b=ZRWen1mQJygkASt2m2NiLHfdyfScvLwVOPJIgSjQuOYmWE0BtMZ/WH+sEh/39p5XeTk6AX7XHM6l6pCRW1s5E1uX3eTn17eDeovvzTTX4ChDCpQryMko5nX5IwA6rPGLrsZo9SUEXZk4jIOJcU6D2Z8yXBLjfYT6p9uSs9BLlCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722652215; c=relaxed/simple;
	bh=lff3WItkl7tt+m2ZlMWiQ5UjuYoh2DTr4sm0ru4q85A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h76m8ztGXUmyipzio68paZ7IMtRLKsH9e6J4C1ISLCNMe0iEsfEMHGlyEjpU1bta7FPa6C1ZjSb79biJeggsNriK20sC42SwMmNm3fe+ObA0OFGVF58Vmg8SpUdjpufzk4/xQRtev7uGLn0aqymYONspX2zfI7BBfwHOsAUt7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0cdyLnd; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso6542191a12.2;
        Fri, 02 Aug 2024 19:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722652213; x=1723257013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgJo9q4/RWdklQAygo3Va2c9b+4qbpVa8SK20T9ndb0=;
        b=f0cdyLndo7NaG7/62ZFY7dq1FFOo2/NLFZr42fxKYuicyx2+5aVqqiTkLdxIcYAqGo
         jRwAJ4YFEEzw60/PHyCkGrXJwoReRn2HB4mpbqkQRuyPDMO+wT1Igp8lKjS56EM02Kbh
         SPkychNOMQ1NC+kB27pHtZ94V6EV1rhhOLVUKv3s380IE0DU6K+0l0P7zqhs4M2WG2Tu
         Fp+ud82+V6T/dywJfP7wXM2HA323j3AhCN8e07ivSM+x/2qdi7se0PU3K/k49nrhM4/8
         BQKBTeaXgfKpSiQk/areyI++Xo6RNpFI3Kmeb2wiFRvgx38WPRb6LHUvjvMnbDY7dMdd
         Rvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722652213; x=1723257013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgJo9q4/RWdklQAygo3Va2c9b+4qbpVa8SK20T9ndb0=;
        b=FeHHA2iwO78oN4O/nOHnEme9xqkkL7ZRYvuKyMh+Z4QalP1YNXQlC6cenP5LEGEqrM
         CzMl1ZR52pSPGW8zsD1QSl7YKV+2lkh4K1BQFmnIybBjV6JRRvd7b6Nm4qeXwynF4zUh
         h1pmKgZyTaK0GyQq8AcLqbwg7qzCjTjMHewMTmMkrKQ8qQVhd2GmO17qYfjC16ZxyTFn
         PU1m9Xs9x0cyDZte3GqDnGFFwKKj9T/8aB++MH2MoRQVfWkqeruusk6Y/TLtVexdUw92
         i++2jcXsLcQiJHH4o6AUbVmibErRgi/FnN84CeRbKE/sQLSG9beURFiO0A3Rnza8VSqY
         OJfg==
X-Forwarded-Encrypted: i=1; AJvYcCU0pCWNcIYbWWd8BqODcsr12oEXUwnBJHINOmRG7zhDvBc8xHkY5d9bI8OCw7px/TOB75FhVzqlH7Gy2wEMlKhKOk65MowmXO34cU5P
X-Gm-Message-State: AOJu0Yza7nKcFFyMRXmP99ZSa1tgxgaKH9idkms9ZxY5/kMm1COoF7qx
	evYtPmD0aMEUH0x+CJnK1WMYnV6gPvjNkFMxCblh+MYrI/lFRslA
X-Google-Smtp-Source: AGHT+IEim5BlgZwWjVR/EgRAcA2adf2yuJoxYugEWSVgo/ETJEch7dnAydGdrDnb5CAT5H4IZB9zVA==
X-Received: by 2002:a17:903:1251:b0:1fb:98db:ad5f with SMTP id d9443c01a7336-1ff5722de68mr73198015ad.5.1722652212923;
        Fri, 02 Aug 2024 19:30:12 -0700 (PDT)
Received: from localhost.localdomain ([218.150.196.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59059f8fsm23919855ad.145.2024.08.02.19.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 19:30:12 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: cooldavid@cooldavid.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	horms@kernel.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH v2] net: ethernet: remove unnecessary parentheses
Date: Sat,  3 Aug 2024 11:29:49 +0900
Message-ID: <20240803022949.28229-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802054421.5428-1-yyyynoom@gmail.com>
References: <20240802054421.5428-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove unnecessary parentheses surrounding `ip_hdrlen()`,
And keep it under 80 columns long to follow the kernel coding style.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 drivers/net/ethernet/jme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 83b185c995df..d8be0e4dcb07 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -947,12 +947,12 @@ jme_udpsum(struct sk_buff *skb)
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
 
-	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN + (ip_hdrlen(skb)) + sizeof(struct udphdr)))) {
+	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
+	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb, ETH_HLEN + (ip_hdrlen(skb)));
+	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
-- 
2.45.2


