Return-Path: <netdev+bounces-65226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF6839B4C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43FB2B225C3
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C03C3D96B;
	Tue, 23 Jan 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym9Nmxr/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C753A8EE
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046275; cv=none; b=vCR/EvqQLKeCrS7a3VmXAP3xl3Ws/QXamxlgKXuHLF1NfOPeHVeTP8w7RdolTTqkf26g1Ah31O8r+l2yFtsDuO/J7cFxEzMmTSci2QVqnLQyHTfm2RGcc5aPrJNAR7U4Dpt0XJSEjvyBIwTt0OUFgKtIdYdPy7suWIoSXmf3aiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046275; c=relaxed/simple;
	bh=dQad2+Z/Xb/mU7me8aRLowsUyHw4NHkMWxImuVtMQuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INcHFNVf/QSr3eNO4Ft6KBXHRBb4dD7Z4E0v4geD96dQtnhZeO/k4u3hGRhi4S4K7nc9gWri6S7BE8nKMqBYt2sg8Yg7+UZQ4UgS92HhRHTXDrpSWta6RdiSJJ01citZIqU6snd7YA0xKgbzNJGwSHK5JhkaR+xZEs6FrywpbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym9Nmxr/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d711d7a940so41843415ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046272; x=1706651072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhR6ETdnDbAnJOABgKbs6pb2nligN/fWqMlDmzJKoA0=;
        b=Ym9Nmxr/c/yn9y134If2wHxp2oGmXbk6bh9M8vinxkHxhHPDQIcKQVWzzI+8MRdo92
         4306pUzH4nlae7Pq7Wv/DvgHisS9buwSJeFgQV9S+Hk10PgTE9P1d5kHrnDidvLE5/BD
         rHZH/7mGqIWxZX17s8hT2igq0/68wR5agpcbMHV/FUyAzpVLa442U1kTYyYD3ZsFWNpX
         rZxd1KkRDG/YnMGZPi084p1SfWIs5lQVreOPz+Q7zl/+D8ChGKJQuCLMNpIZ8N5GcyLp
         ddyGZU3Ep2RRYdf3woazOZ62DiLkqruu9ti5zE3FY0g9MOQuDEDiEamp5bprDrXsAAcX
         UoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046272; x=1706651072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhR6ETdnDbAnJOABgKbs6pb2nligN/fWqMlDmzJKoA0=;
        b=V7VAKJ6Ld8+NrXDbOP95VA46g3VuNbKk3SapZo27VmzVRZpHOLS71jjUCwUTCAn/em
         QtD2u75/U1N0vKDYEP8Qn8aqpuAvr1umatCOWmNCEmZdivhgcX62d6as7E1VpZpr+2uN
         crKhSLbKzJ7z0gIxE4gQtzKzURW9kMaUIzlJwGZ5iqyER3F3lw1OIrqhb+FFM+Z53QQi
         Xe8BEA6LrWIqPJbH2csu9Nwguihx0VUxmBk/abdb0POHUkKFjNDpaZ2WEFpcdZUsme1R
         BlrDvaeoFFh4F4RDbKB4L2KwR0eDVwEMev+SEI1SLiDpdZBLvHL6kmK1YZuPUfwCpf90
         qotA==
X-Gm-Message-State: AOJu0YypMAjoeBD6q4ucQFmH85noSLsrx19EUiGjJA00VUCgaxH6W3iD
	2pN4EK+HBbx8I+ljFglWVjfc0Ob7esFlHJlDuVAaEDdXlsTEG+N/luyy60HDt9g=
X-Google-Smtp-Source: AGHT+IG+lm6wBs6IpeSOgrJA+2myvCAPTCHva9NAotIG0A4kRwo9Dl+Ys3VxUxmqMA0AamunkU5S1A==
X-Received: by 2002:a17:903:1107:b0:1d3:f1ca:6a13 with SMTP id n7-20020a170903110700b001d3f1ca6a13mr7164686plh.109.1706046272199;
        Tue, 23 Jan 2024 13:44:32 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:31 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	ansuelsmth@gmail.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 01/11] net: dsa: realtek: drop cleanup from realtek_ops
Date: Tue, 23 Jan 2024 18:44:09 -0300
Message-ID: <20240123214420.25716-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123214420.25716-1-luizluca@gmail.com>
References: <20240123214420.25716-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It was never used and never referenced.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/realtek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 790488e9c667..e9ee778665b2 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -91,7 +91,6 @@ struct realtek_ops {
 	int	(*detect)(struct realtek_priv *priv);
 	int	(*reset_chip)(struct realtek_priv *priv);
 	int	(*setup)(struct realtek_priv *priv);
-	void	(*cleanup)(struct realtek_priv *priv);
 	int	(*get_mib_counter)(struct realtek_priv *priv,
 				   int port,
 				   struct rtl8366_mib_counter *mib,
-- 
2.43.0


