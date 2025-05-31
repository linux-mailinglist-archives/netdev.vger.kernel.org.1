Return-Path: <netdev+bounces-194503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D3CAC9A81
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3921BA379A
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC2242923;
	Sat, 31 May 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkp0Bo2y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DBA241664;
	Sat, 31 May 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686411; cv=none; b=Y6lUfuHelDD5P1qhSlhYf2V4vx7ao5mhetKp4wpsjEWIc2VssA5xpi7soDYo9J9pyUA8GR8xc1349+vObzn+mAB+iyw1RKEga20LAaAjHfOjPM/jPvIJrzOVlO1s672KlOmKCmofGQS1XdWx7NANzmJ1lcsLEWDNN1r8nHPBHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686411; c=relaxed/simple;
	bh=LS49dlVCVfhP+stRhRD81356ZmEOJJqyVMdjDTH3+Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRQeSnvYjK2fDlpZNi5j9mLmdDovs7JIfNBq6RusAdzngcAGh5sJh2SZbCAEd/8xcUwxqcL6NVf+/w38bE/MIR9I+j7bERXELWgDb0CAX/8LxgM9inObVtLLuaw4efqtMBKi9/bPxBGo4l3MHsfMQ2eYZyIRJKVzAb3eLoAx4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xkp0Bo2y; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a36748920cso3102246f8f.2;
        Sat, 31 May 2025 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686408; x=1749291208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq1QgWecPXKEOWBa1UyGhmKV+AVmn4AYKr6Ka0MIC54=;
        b=Xkp0Bo2yNFf/3upmTCzF9bVz3/Vofy2VJokUf2xsrWUheOgwf/uixRKmfFhRyyMgLZ
         uhSN2ijd7DMDyRkaorbTrux9QVFl4rx6xaG0HxDh9MgoKV5xTtexYRqr1gmx4kTGnA8J
         ZQQKUZjaBWdOmxtGVkvdFwKZAt7zyoIWa1qzJpCD1gzs3jkPnCkX0HmOW4I1Mm5em5HJ
         sNw8T1G8Ark4NPEmy8E/fILA5oyDrm0ULCoS+9ZUoHqu3YbTxuZXSmSWTnjBBmJiwLJg
         znauhsu9X8BpaAaPcGhIGUKedJ9Sg8kQ4NKxVoJ4AuLPuLmZheUjaKQk/5z4uT5jXcuU
         nl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686408; x=1749291208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq1QgWecPXKEOWBa1UyGhmKV+AVmn4AYKr6Ka0MIC54=;
        b=QISP05l9e7jVCLXHDOYDTVeNtRXeMdCo9Vl+KvOm/1o+TFWurqjjSo5Lcyz/oje2Ap
         l/hmKI1Jq5xdGKwKBcAocy4ajVf288Ml38YOtLA4n9SY/AFNtJpowkjIRBXK/2pxQNwN
         A0kuKHw/ta1siNLE/H3n43jLc7xxHHgj2vqkQfiy15mArbRXxuDN2I3SgRz603YxoeWq
         hMevm5oucyuCeKd8GnjkXmlVWRVL+LBO/pMH+6QoPiRhguPk02neN3UeyoNG6POaOq01
         wlDBQBdONaZv5dOCg/9MQNdfisJK/avAhfW2h/XrJn4tM0aGtdKkEAW/FacreS19FXts
         gabQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk+wkJQB24VN41Mk7uQGWYmQLnXXlCs65OFZ3Y4dSWiZ2ISoTiURz8eYCx37/Mg2Kl49pnNSZ3NFZ0Ivo=@vger.kernel.org, AJvYcCVy1DPCW00tj5slDCactmm6h5u9TGwUCDWx9TikGni8WKhEzuN3fsSeseH65J+GYrIHFTX9ML9X@vger.kernel.org
X-Gm-Message-State: AOJu0YxFd4bJq742bGEe/MS8OE2A+QQzeU8Q85Tv9EpE29hUUeZtt9jV
	Wc+Ohh4yvi3cEg6c8Vj4T3SkXJRYrYxu1amfHKOspmY9JllLmrt+lcgc
X-Gm-Gg: ASbGncsMn80vWaMWCrN+a3q93TxkoFRdcnCXA+F+nRjYNI9fe4syL8RnPHt8yp6jRsX
	hBmSPx3HK9wO7YVSC2qUEt5I1s/Esz30FnXfJibLjZTirXZ+nV9ubqI9ICueXXxDI+bNK5HYkq4
	8lT8vuM5SdURkbYJZf166il2T7vwdpZ2jrn6BoweTDTaOCDJgE6Un0aS0kuOTtOe7Fc5TjoDxrV
	SKhta/xuJDVXaz23PoofWQ92TpdkoMho8ElG7biMLSfmz2+QyMU/hIlycGfr6yiuyK5VbDwpjPY
	j8T0AyaevmjaRf4mp05hIADx26z+xzt2YQCTtZ/n1j0OBxA+m7cA8TYyt9VjYmUW21wlWQtiiZ/
	W0mtO5WWyRDV1yjyEKC2XA7Y4muP80tBe6torVZo3FmWsf2i5egxK
X-Google-Smtp-Source: AGHT+IFq1s/33PU9NhVhaQIXLsSfqaM0L5mQsKy1IdijhQBIKAlU8lKlp8Te8KHbzSrKWn4AeqH/9A==
X-Received: by 2002:a05:6000:2dc6:b0:3a4:dc32:6cbb with SMTP id ffacd0b85a97d-3a4f89cd26dmr4137946f8f.31.1748686407933;
        Sat, 31 May 2025 03:13:27 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:27 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 10/10] net: dsa: b53: ensure BCM5325 PHYs are enabled
Date: Sat, 31 May 2025 12:13:08 +0200
Message-Id: <20250531101308.155757-11-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to the datasheet, BCM5325 uses B53_PD_MODE_CTRL_25 register to
disable clocking to individual PHYs.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 802020eaea44..7b786d0d14cd 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1299,6 +1299,9 @@ static int b53_setup(struct dsa_switch *ds)
 
 	b53_reset_mib(dev);
 
+	if (is5325(dev))
+		b53_write8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, 0);
+
 	ret = b53_apply_config(dev);
 	if (ret) {
 		dev_err(ds->dev, "failed to apply configuration\n");
-- 
2.39.5


