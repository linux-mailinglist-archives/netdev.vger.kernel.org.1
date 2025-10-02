Return-Path: <netdev+bounces-227609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6159BB3688
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9187F176699
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81392ECD01;
	Thu,  2 Oct 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJypa9EG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB72FBE1C
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396351; cv=none; b=lup35S6EZmrnZAbT85a/GzAZ3XabhXKzIbNonpzuR5X0ipKv0Mv6ZOYCinq2AIux7OekQp9tdUkktXqLlebEkfhP8KkcXUPofXoIcCGcgU+XAJVTzrFN24jXXmXDUBWwELofCbefPfFl7NY40m0wWn3tGvfhmwZJocmeBOtT+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396351; c=relaxed/simple;
	bh=RcmqH2hasCTaFwdsE15p4QyVlD2841+fk/eWY30INW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y3JcQIYRLf5KrTcpzFo2UyAfvBZe9EP+Z8ZZbdzkYAL/Fuw7r/I5V1xeoQZEasW+EqfyPCoHAaG9aspzAraGgKISX7vah3purgJYmXWK82pg+XQVvperuLvwU1wKqbAUl8oKIHXCPtKdpaJvqq8gL7MeaOJUNJ1g9GyTiklCryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJypa9EG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57bc9775989so738351e87.1
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396348; x=1760001148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqNzjYH5xlRPvKllO+jZgkU+xZgzkgDqg5jPD9MUtBQ=;
        b=hJypa9EGu2ug5HTSvzHbjgDgACV+06oTvhx4gGfjGCmkIiYmZ1xyIR+ggSKmyh6LGa
         iq51Bkvt6auQSDX0dMvP/NXrGsBecjWWxl/ZUrn/rm/c88ENc/z2DH4Qeiaij1LKMgiS
         khkFvyNY3+S//Inb6VpaKjzo0DMvky4tkH8Rs6NbSZnBl/LlzfV6BxfcQEPBfKfRVWGD
         cKLiI3pdtS4qqM6xFkH6QzQX2mFE3B8pngsQHKu0KKn6uGh9DVy2L73C7hEp6hvLrfN/
         OoFXHKkb7Hf1dgtTThxrZy2V9Bb1nMS1h3v2mgJC1pPZV3TSFyYAWLCFSmAuUZE7fjYZ
         kRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396348; x=1760001148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqNzjYH5xlRPvKllO+jZgkU+xZgzkgDqg5jPD9MUtBQ=;
        b=aWpZTVBNRUhCoxMJd1qTeipu/8Zgz++HbND69HMSpmifo9SUF4c/ch09EBOydomDnb
         lUnLWUpCIHYHTnyIjjaFEk0kSDggk8iLUgGlyYjGakjsIpMn/3Nenc7AJ3vmcVhRnA78
         OnQ50JrPArGlcQDCKLB7CzEHCWlparrYgoj4UtHx4bEv7xt1GE38yWgNtgIOcezn3+If
         wiFUbvRJmnhfUaWTyYfQbmDKo8eDEqnUDG0f0ObXD1bS9901vesh+ti2Ln4bMGH+6ni/
         PG1Fi08PdymZbDpK5FL6QuhWFmXQbzqJTFSfnLZcghprkyEVJZX9mu8RZSOHN68/61im
         r3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV9LerNgezPYc14w+0bOsK43WKG6eErQ+c+GdhhSachZ3YjeGSwKhtGOZ+7fTwpk1ON5h+PZcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzks06nM1KppwiRL9um5NvfdFsRtHQCRdYvdRxYXbB51fG4CWjR
	P1EqCnOdzWcGzA5qgO4TnNpqoLl0gqpkl/trvI3JJ3l8+hllafBNHZRa
X-Gm-Gg: ASbGncuL2fx3in7Cfu4iJ3SCvhYttfGLZBH38Tf+HjvlXmiWEAqhayJqfj74aV24Bqf
	1pUFCLqTvCwLaoU+wsQ+WdQPJgAsSII9ojt/4aY920tOlGXr1vI0vKnUDPYcZqW8ArA6cjkw8xE
	LYHSE5gg2mo28YhNn7aJf5JGjkG6kDKacZvtf6lvJ7gUYH4qpJ/MlnCt+ZlYi0A5i9DSSR6MNdz
	KbBeD1mCiNXNvTA+lF/wiB+jVmINO1MpKa5/DmqcGUNkC1Y5Inn3ewOhhOh2CmgUNHGbF/lG//7
	uUuXkiY/Et1u2IwEUSta5HzCs49aCg6G60LDKOLC5txIpZK0YKK8a0RrvPS/HCEnAawW4jBk8QR
	Qm/xBHWxttR6NI4QYNjCMG8Bbe+o9hVv0mfTVeQtkFIDjQsLlHHUeNAIh83iraT/S1iX17Y8121
	2SR7KPtApKUF0JBNcRbT5PVnwCdYmxO3gKm9gJPeHu
X-Google-Smtp-Source: AGHT+IHmqauzbTKWvBhZLJdCPvoDD7qhBbz8dS6RzJZSNgA9ON9JkpJXzzCBzfbtFuPX9cZ/Tbb5Hw==
X-Received: by 2002:a05:6512:3da5:b0:57b:c798:9edf with SMTP id 2adb3069b0e04-58af9f4ee42mr2234249e87.56.1759396347888;
        Thu, 02 Oct 2025 02:12:27 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01135b77sm661206e87.38.2025.10.02.02.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:12:27 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] fix uninit value using in tg3_setup_fiber_mii_phy()
Date: Thu,  2 Oct 2025 12:12:23 +0300
Message-ID: <20251002091224.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

There is a way when we go to the goto fiber_setup_done label 
and the condition current_link_up && current_duplex == DUPLEX_FULL 
is met, then the tg3_setup_flow_control() function is executed with 
undefined values of local_adv and remote_adv.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 1589a49b876c..1fa61328c1b9 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -5802,7 +5802,7 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 	u32 current_speed = SPEED_UNKNOWN;
 	u8 current_duplex = DUPLEX_UNKNOWN;
 	bool current_link_up = false;
-	u32 local_adv, remote_adv, sgsr;
+	u32 local_adv = 0, remote_adv = 0, sgsr;
 
 	if ((tg3_asic_rev(tp) == ASIC_REV_5719 ||
 	     tg3_asic_rev(tp) == ASIC_REV_5720) &&
-- 
2.43.0


