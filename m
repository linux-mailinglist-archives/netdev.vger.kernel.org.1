Return-Path: <netdev+bounces-126967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24A89736D2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EF01F27C25
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50518DF97;
	Tue, 10 Sep 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2/jyXDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B587F13E02D;
	Tue, 10 Sep 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970002; cv=none; b=mTo/4QcVdqFtxPwkT4UU2dl1KGpBvA1cnMRAwSE/aut3vuqyGxZiIsTyeaG8YZmp5472NJf/0wcrr9OtPetHJc11clA+Eba628oHyTD6pYGvbdCBiHysQjqzorxwg0N+04pCd8LyP8JweDwVyJHqSybfg/FgGgBeI6GxZurCAFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970002; c=relaxed/simple;
	bh=0uHqGyWQTKBICcZgWP5SFyBnuC7UuUXsU/vLXQ0WYN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uMizCusGUl+X7jxDtkxe6svgguYrjZno7kPKOv2d1EzA8jvgmvlnevtNkeTMIsPc4YsyKQnvlmdPGu9FXt9pk32vN9P81bU2Mpv23yogKn5cCzdgz9UF7qtohgJ+wiSknBiZuDtt95O6zTvxOFrFrH+bIDwdwOOLHETDeV9sauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2/jyXDR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c3400367so4704078f8f.2;
        Tue, 10 Sep 2024 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725969999; x=1726574799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3O0+X2UyQ0gOuFyiHB5oW6tIQsBBcRW3/8B2cCf8EM=;
        b=l2/jyXDR3leqH8NzQlvlQ2hG0tK6qLY3S1VcW1ygpaTvuBNu+h3xKcGjRUPFWq8Sb8
         slz1sRWElKKLd81nGA4kI0Km08Ngo/G2nBbF/9eylXQvpOlA+6FCw8RV/322xBbLeqnK
         38KH+Pbj437fN+KAetjSwQXsBwY1xJpnlVoLQWYlUDMCRC64vArmlh7AsDdBodRdLtt3
         XWwEBn/ZmOZq/sRnn75fRJDh6CfQbwKa+feWHIuxKTN36eZ4DAh/IaCQmhLrDIByZ8Ls
         /2nAEbDh8K8capeyvX7TJsQb+/fESx2Xji27AOTI+5LL2a1bNqJOPrEt65iQNWBw5P2g
         i2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725969999; x=1726574799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3O0+X2UyQ0gOuFyiHB5oW6tIQsBBcRW3/8B2cCf8EM=;
        b=gys38Q5YSoIWNOqSE4z71ST1XiV13R31NSEjLAWL0gacQiEpiXGgJCPPK1y8AIIVGL
         dbbR0iveIL74FbShX190HRF9EjTIEdutEIoyLMBzqK1awz8abjtXkJUlg5POZmhTCs73
         RVIBbw+0NeKfKuURuO/Bbd8bkkhw6zetuEggxTM1FQFd3OueEKfk3tQnCL1cmxcK99Oj
         oVQr59pbrps+EIHNXUNFrUv6UrkeVb45cOhEWO/yYmh2v6IbLGzmitF+VD+snh0fzVMc
         uK5TwhlSAItkDmFKWtxyTnsanh5cTuSzfAQBeFwBf4LH10eYplDBrOAy8fQLYS4LqaXr
         6Wrg==
X-Forwarded-Encrypted: i=1; AJvYcCUMkQVNU/l3zVGyx5TjFSasRfT+I7E3LxKi+CTsYbFLIiziFo63YRmvxCoY9YUnL9yTcLKPAAhi@vger.kernel.org, AJvYcCUzsYbSeCgWHj/xUmbsIALZT/PQKR8x+rjTH3k3hY1Co2vY0Wpl1Z+BP/cSY7zJjJylmbDRiYsP7FGc43M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWq/cT+mxX9iznuAN/t3VyYlBvH7HIC7XQKkcfkWI1E7YWA1dX
	G3DGot5stvsUReDJjzpW8SCKcsI+QkiOFmnsdaEeu5M0eywnCzagqaP9AC1s
X-Google-Smtp-Source: AGHT+IHQn/8VjDWddQEtqhPD6spb3CN4HWurt39gX0dd8Pllpw2ltiFpG//CzBeUnit4t0a3ce2WTw==
X-Received: by 2002:a05:6000:544:b0:374:b30b:9ae7 with SMTP id ffacd0b85a97d-3789243fb20mr8658299f8f.49.1725969998573;
        Tue, 10 Sep 2024 05:06:38 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a340sm8714115f8f.24.2024.09.10.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 05:06:37 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] qlcnic: make read-only const array key static
Date: Tue, 10 Sep 2024 13:06:35 +0100
Message-Id: <20240910120635.115266-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only array key on the stack at
run time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

---

V2: re-order declarations for reverse christmas tree layout

---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index bcef8ab715bf..d7cdea8f604d 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -2042,12 +2042,14 @@ int qlcnic_83xx_config_hw_lro(struct qlcnic_adapter *adapter, int mode)
 
 int qlcnic_83xx_config_rss(struct qlcnic_adapter *adapter, int enable)
 {
-	int err;
-	u32 word;
 	struct qlcnic_cmd_args cmd;
-	const u64 key[] = { 0xbeac01fa6a42b73bULL, 0x8030f20c77cb2da3ULL,
-			    0xae7b30b4d0ca2bcbULL, 0x43a38fb04167253dULL,
-			    0x255b0ec26d5a56daULL };
+	static const u64 key[] = {
+		0xbeac01fa6a42b73bULL, 0x8030f20c77cb2da3ULL,
+		0xae7b30b4d0ca2bcbULL, 0x43a38fb04167253dULL,
+		0x255b0ec26d5a56daULL
+	};
+	u32 word;
+	int err;
 
 	err = qlcnic_alloc_mbx_args(&cmd, adapter, QLCNIC_CMD_CONFIGURE_RSS);
 	if (err)
-- 
2.39.2


