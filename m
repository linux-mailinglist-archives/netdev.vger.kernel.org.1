Return-Path: <netdev+bounces-96464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8790E8C60A9
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A345D1C20BE5
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32BB3B781;
	Wed, 15 May 2024 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuZU26kF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9933C460
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753884; cv=none; b=b7GCFJ5ZVJmsMsteC+IayLbdLJmQsQS18QK8zm13Nf7RnlLk6KETWVpqWAC69DPuYVmY+iSlGpNBwVuGTnf0in3ZetTQngIMF72V9D5bofHKq6gynSlHJ6SiQS2RWUaMRu8KsfergQYNY9bbdYttZSjD1/vvlueDlJT76uoYOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753884; c=relaxed/simple;
	bh=SmCF5UexwgEyfY1H/U9hOms5bAG51QR+6EjgsKeilzw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=X/lO4LFdDRO+GsmZRyY6GvvOQD5nKz3Ecn6zzsTjMg5WOB3/ASE83BG+RnWfbZA73JKXpWRwVCsqnbHBUiYCPDOUx5Ty0uQCnpl9JTqTm1ECAm56ph71MGshpAfHB50scNjcUXgIch4pF0MJTW1NBw65wl/XSA85RXgTO10EwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuZU26kF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so1248767a12.3
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715753881; x=1716358681; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yOZ+JB3zuprcdgRJbYmgGrWwuRHSScuPFo4uTF+AWs=;
        b=NuZU26kFLJBb6V2WBlYbwsLU/r4DzSRyJHylr++komlnEu8MK1jgMOBFDPBvAlmgnQ
         DqfI24/PhF3Rh5GssnOmNEwDoSX0aZPrXTGTReP5Mwtc2muhJNO231nevsSny7dhqxn7
         2l8912laIwZX7wZL/4B4B5OkrN+ytsDyk67FVo95N3qvSy+D4960QkvDKt1jIv/8IJvN
         eHKWQ738DfBceGQ+fo7nNGlJLHzkbGullRPR+7R0HyLo1z1Uip9rJ9s1WmNh92SAhAa3
         MoMXe3dsFhpWWZlD16/iwGtjyzQS+5/3d9Dh0vdldolzgM17M5E8Rl0izKJ7CsjIRHei
         /3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715753881; x=1716358681;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yOZ+JB3zuprcdgRJbYmgGrWwuRHSScuPFo4uTF+AWs=;
        b=wqGIR/a8Dfx4YDN5OHLZSLj0g3cN7+94g1/Q3gYUTIp2zd0vBjHQBQucvGrwL9kyn2
         oBMPSWpeTL6Dhyt2V/nwXJw/ao/7g1SNc7u6sEwUwlnKrw1QycsySsyTKwaMNUS5Lbiq
         mEKPyKfHyDSXT7j+IAp9vWseG2gX1LOyUTS5/CPL8wh6nkaLYk0QXzrYAEouFdqGzYZi
         W//oujke6Csc2Uvft7AczloEFlnhxaT5Ri48TLvg5tGHGM6ebWVZp5afdEVZbF6WoA4C
         cXImonygh0KXz4PdBv+pAsM667Eu34NHgnvJhwyEzSgNfE329GrkGjAfE4lvFpwwTlbn
         Nt+w==
X-Gm-Message-State: AOJu0YxjmfHTgFr7h7zZhJEmYXCGCSpaMtNhXhT8SJqwtHUPZpUlKPIY
	jh37QFfdu0oeV/p1t6Wy3rQfkuFgCGMZWe32EkFIMZUOOKc+Wts7A0/Ymg==
X-Google-Smtp-Source: AGHT+IGb8fVucwgExpHXDsKGTnWPDG9FNwYs9KvjxEVLD/VWGhcDcO9uTvUlfCnxiEPbE3iXxiGBtg==
X-Received: by 2002:a50:f60d:0:b0:572:7c13:c7d8 with SMTP id 4fb4d7f45d1cf-5734d6effa0mr13861376a12.34.1715753881015;
        Tue, 14 May 2024 23:18:01 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7731:9200:5d4a:ed7b:b883:3704? (dynamic-2a01-0c22-7731-9200-5d4a-ed7b-b883-3704.c22.pool.telefonica.de. [2a01:c22:7731:9200:5d4a:ed7b:b883:3704])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65aasm8444933a12.5.2024.05.14.23.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 23:18:00 -0700 (PDT)
Message-ID: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
Date: Wed, 15 May 2024 08:18:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] Revert "r8169: don't try to disable interrupts if NAPI
 is, scheduled already"
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This reverts commit 7274c4147afbf46f45b8501edbdad6da8cd013b9.

Ken reported that RTL8125b can lock up if gro_flush_timeout has the
default value of 20000 and napi_defer_hard_irqs is set to 0.
In this scenario device interrupts aren't disabled, what seems to
trigger some silicon bug under heavy load. I was able to reproduce this
behavior on RTL8168h. Fix this by reverting 7274c4147afb.

Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
Cc: stable@vger.kernel.org
Reported-by: Ken Milmore <ken.milmore@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 0fc5fe564ae5..69606c8081a3 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4655,10 +4655,8 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 	}
 
-	if (napi_schedule_prep(&tp->napi)) {
-		rtl_irq_disable(tp);
-		__napi_schedule(&tp->napi);
-	}
+	rtl_irq_disable(tp);
+	napi_schedule(&tp->napi);
 out:
 	rtl_ack_events(tp, status);
 
-- 
2.45.0


