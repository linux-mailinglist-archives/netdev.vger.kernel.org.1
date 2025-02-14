Return-Path: <netdev+bounces-166588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41705A36842
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10127172639
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E971FCF60;
	Fri, 14 Feb 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4jqj8aJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA61FC7F7
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572050; cv=none; b=WnzL7ch3qSISWRTkLxBdgH0BRB/nff6vCXvRfLmowShCyoCpuhZ8pXoYkeUxNAkTAb6aP2thA1T5AtpID0XQ/aHQpcvICZtIYs4hqpVkKioUQ1XM2Q+Kglg6ZNMEEbUjaapziYFGZk7fx1eR0xAlMWSb8cT5Y2KijeyRsYxV4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572050; c=relaxed/simple;
	bh=42lHGk3Flo2pN8wMz6h/M1EU5H8NqAADQw5fh15RRPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADAyJ2itJSJyPqSb0LyOQBaUC+TvlVdc9X8HBj3KRpyjLOmS4qfDfOunKfdihUxnaMg0cwr59wGWINdJQiebg3z4N8xs6la+Xt+PA+RYfKF5xqIztzjxuO8IHfVAB1SAHKgdZx2eKMXq8Gm/EtdeUhIom/NIVTmVCl4ocvO4p1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4jqj8aJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd049b5428so21637696d6.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572048; x=1740176848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OaDOlBFnjH1ntAx2ceZctZzUu/A/Lq5nTwbWKTLnGo=;
        b=F4jqj8aJVrB72mQk6+5rDDnJvKEfHfU2CFeJyfAESxmudfcu13Z68eA7Pr9nZSy6o2
         tM7TuEwEdSOUv8y/qh7nM631q3bnxjnE88+f+O8uAZpVegD8tMUjZ/LImzeBBCwdgqMp
         swqVlvQmm8LDttJKmplgfu3cGWaDqdt/MQArEpnzy/heCZsouLGAMnHF9FRMPEGk53to
         OrGrtra6ofHjZZswdqUiTocReWMyEDIPPaURa2mrBmZoe84F80r4CnZ/wA8rna/cc1Uk
         cmp/eqR6Y54UufOAg1S4cq/hzLyAKp/nAzGp5va3yBWEN55/L8D7JaXxuKdoPV49pmbz
         mKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572048; x=1740176848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OaDOlBFnjH1ntAx2ceZctZzUu/A/Lq5nTwbWKTLnGo=;
        b=v9v8aofDpUZVtFVuOzHe3MuvYqW9E3hPI6up4KYJsqF1w27ujCIU8PlGVph2D8JU59
         z6ze380AimVUHhwY0Aq6XcvOOqE+hAXGvtsXLELOnuyLE8Co77hao9UMnzPoI9ECo2+R
         a2A1E4tjxd+VjLHBN9BV3Ao7wzFtcq1/n0//Fg9NoryTTFS/GZBeKMICZWr/JbvtBhah
         CpcR5WYweIi0ZTaHdaGfPDZDqjaUjTtYjWJWYMNlybFuo7AIp3nMTCHUM6WSzwJzg3/6
         R/yL+DKf8qHts9zO8V17XQcNqOO+/8I2exiMyuO82+qeUhQHgYnT9h2nQYuo8PXaYh7o
         OYPw==
X-Gm-Message-State: AOJu0YxhJHMFhNJ4QOU5RK/1RzfT29NIqA/99wwEVglJ5Agoghh5eKOf
	AraBTc0ZagNjQdk67de2RF8PrHYJJUFkm8K2UPPtVZA65Xq/I92UxjLs1A==
X-Gm-Gg: ASbGncsZy1vuKhYtdKr/sO4IjEsenBRAKtrA87o34M90pWTNzeutiDeZgfvIRzYPTBI
	ODY46A2KXfT3yrU4fix3wWacNfINuBg6d0FLscdFAAPcZv373XQQhGtXC1KHNGHj2+QBzCb+UZQ
	gCmS7m2aM7sUpW0fI9dsmukweucsSuUrPrzxvFdYHe/G94X8pAmHqrDlYi8/MJL1ljnjOh6FyXy
	0K34EWt+Mb3bOWDlLW4BJ7wkj74R7F30wm7ySTNzf1VIRb/U/ycOaAi/Gmix7evY9rWxj9mj6EY
	+UgDNmHDTFEeOj8t722Tb0TJXCWFmdaaywF1uvQIDaCZZFDGIB4fn0Ik3xbosC/Fiyu1LgqAXua
	CEJXmZMDSNw==
X-Google-Smtp-Source: AGHT+IGO/nx0104CKeECrhDaJ5kKbWQhuirYwUL/Wo151mVPAGjoSg9MPcFD/3uE8xQTqIxcHaThtQ==
X-Received: by 2002:a05:6214:2422:b0:6cb:c54c:b782 with SMTP id 6a1803df08f44-6e66cd039cfmr19319866d6.32.1739572047894;
        Fri, 14 Feb 2025 14:27:27 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848b7sm25832916d6.27.2025.02.14.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:27:27 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 3/7] ipv4: initialize inet socket cookies with sockcm_init
Date: Fri, 14 Feb 2025 17:27:00 -0500
Message-ID: <20250214222720.3205500-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
References: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid open coding the same logic.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/ip.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 305eccdf4ff7..3c4ef5ddad83 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -94,9 +94,8 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 {
 	ipcm_init(ipcm);
 
-	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
-	ipcm->sockc.priority = READ_ONCE(inet->sk.sk_priority);
-	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
+	sockcm_init(&ipcm->sockc, &inet->sk);
+
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
 	ipcm->protocol = inet->inet_num;
-- 
2.48.1.601.g30ceb7b040-goog


