Return-Path: <netdev+bounces-148716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B609E2FE0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CF2833B0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674FA205E1C;
	Tue,  3 Dec 2024 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6XaANcc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3095762EB;
	Tue,  3 Dec 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268715; cv=none; b=Kma5kaPreUVoX4utmy5cU4tcJd0arpGYh5PjQVDyaKi99c8gYj+wXOvGzcbWU2FNE/G7cMcm6xgfnXQ1ZGtkGO/YK9JNmOqVsaYDDZGSmjGEhiqKQW4ejYhKxIKao9TE6JVAQ2KRzMzxLM5jXkjM2iMcBrUlhkvflbcHTk8cWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268715; c=relaxed/simple;
	bh=VL0BejhggkihvQeOI3oSmY2hCVHE813BGArdHktfp8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fw2RNTayym6G0qQzyQlNTIf9lbh1E7SsoFkrpX71CyfbO5VxAXnciA41EbPkBg3IUi2ixl9u7gChKr938yFKudcdN/bLMl5lfgWL+FCLW2cZiMbZG+b5P16f8SdmiQ/EJlX0oSd9lMEi4STPNkTGUZM0Jvub7gdZZfBrFJmvJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6XaANcc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724f1004c79so4291415b3a.2;
        Tue, 03 Dec 2024 15:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733268713; x=1733873513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MlTmVD1SPaX5ebBMmmU1FyZJLlXQXq5t35CYfxdL8A=;
        b=a6XaANccBPNyKRA7FmgfdwJX1dP9tUkGnMwPp2YseYo5OoVCUh2z2Zvqdy+zyZHsSX
         v+POcrO+2lk/JYeu6RALA4KHa97PlCCtvesN3KvxyjaF2PWvhIVGEXmO9fJHaTlEtLLv
         KAP/Nb1vPRqy2Fg6qb7yS92ZnEccJAOOyZUDGbk1/DUJcEyBd2w0eZDxt+2/3IlEZamv
         sLlAeKrG8lDaY0/jUV2ZxZPImfM9+djUrlMLqMtyX5Tj8FgBLsOrXJXvwbZeO/mHL+WP
         Wb0Ab2nyOMaOZw7krstL+5uFHkW+MZoFrdiK7DjaHB3jOkKqHWMapevq4wixlj2T4PEz
         tEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268713; x=1733873513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MlTmVD1SPaX5ebBMmmU1FyZJLlXQXq5t35CYfxdL8A=;
        b=b2VphE+GlXX/CV/9vCbe1tqU41snYuT+PPeNYnlRRDtgmDNch4+LDMpW53mkIS5UHm
         itP2DAj4DGjLI3wBdM1C1uTLc82HxI/M7T4EI311fkLAU9DGiRe+vUCzpPVG4WvY6mVa
         lHYmYVEe7JyQ56lfwaK4B++tked3rY2KbNln65zJVXhSb9sqgTGXmzViWE9boevOzs0d
         /t7YNPDEGMkU55gZQAdzXve9wt7wPYYR9X6GyMAg0oCpFNTit+kZvGDKe0v/ploCHq1r
         j4gUIUgAkIjqlKWFKShBLtmrR+HvLV1cz3vLoRD9sc8yjxTT0JY7jp2KF00lIP8IfYj6
         gpNw==
X-Forwarded-Encrypted: i=1; AJvYcCVOW67dwwsHk0gmxuxUV7GwirbeeDk6+VS3yKlBaozDGWisO+GJV7UPNSByIymhM8p3LArkU5VicBvJ0nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLkrYSXyUzKoWq/SZIoMFGJEnyU0EL+O0IxTDYBzKR2KZusV5
	ZwrRfvjgnCLiRbC/sIE6VULIDfuYAsF0gbssY+l8XowwPI5ajR6z7sNNayd6hO8=
X-Gm-Gg: ASbGnctadoN80QLpo50Ljq5em3ffCSyiMTSfe14rYLhtQtWxU+i7/6OlpdBBWXBseqm
	qikYLU+U/HVZhqDSj3TtLUL2bHTM0TKN7JSltG41Qbyai1T2kpmvCEmLci0axZ8CibbiEjAqjhV
	Uvv+hiKbapoLrBlNREecgmGpPz19EALBS1764/Et1SXts/N98jqBcZx9YfRs5AAGfqw3xk5awrj
	Fc194xklUyyG5fBY53jrmvoog==
X-Google-Smtp-Source: AGHT+IG6Ipon5j5cyX3WCl6YCxLZR2/8MwEae2X3cxPfyy9dvJWQgX6IClkGB64j0+sCj/BFNiNrtA==
X-Received: by 2002:a05:6a00:2d81:b0:724:d758:f35 with SMTP id d2e1a72fcca58-7257fa4b2dbmr5267172b3a.2.1733268713035;
        Tue, 03 Dec 2024 15:31:53 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a2dc1sm10169172a12.82.2024.12.03.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:31:52 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Joyce Ooi <joyce.ooi@intel.com>,
	linux@armlinux.org.uk,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/2] altera: simplify probe
Date: Tue,  3 Dec 2024 15:31:48 -0800
Message-ID: <20241203233150.184194-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A small devm change with goto removals and a function simplification.

Rosen Penev (2):
  net: altera: use devm for alloc_etherdev
  net: altera: simplify request_and_map

 drivers/net/ethernet/altera/altera_tse_main.c | 128 ++++++------------
 1 file changed, 43 insertions(+), 85 deletions(-)

-- 
2.47.0


