Return-Path: <netdev+bounces-141190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB2E9B9F6E
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854F61C213CE
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97917D340;
	Sat,  2 Nov 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Scxvu5Ya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC37140E50;
	Sat,  2 Nov 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547689; cv=none; b=jZkucz6IwbMJtla5ORJvjVqVZtXwKrKNiWb/vEtdJBVcas0MXmvKqbANSrzugv3yCsskyyWJnvI3lWPpv4iW25QIELJgV1zc494JPz08BOz5Dsrl39GBvHbT9ww18bt0A9Kzi8sRx9PkZ0cLTeh7cfPJFYE3SYFIRUZAkrbUtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547689; c=relaxed/simple;
	bh=GNCOilcx5JlUThOsqc+xKrEw5oMdVM0JoKl+cpPWOYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jr+p+7+p+dQ+2qkn305obLtVhFOlOo01NFR0Lrpxo0ztSfWIhN4VgAloggDi0mAtf+ILPpowSeh5QALO9WxTnxxO4dbuHTeltHQNTKX7Yi4QA80Y+grAj4nnS7sZKrN0Jm8o4Rheq1ZcywdvUNFN+j9yQw7AkSG04xEjIx6AsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Scxvu5Ya; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cebbbbaeceso156462a12.3;
        Sat, 02 Nov 2024 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730547685; x=1731152485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ODXSKIPM8Xa+YaYVLc8WanEICuRtJG6U7jSPf/7hZw=;
        b=Scxvu5YaFBjLKtBhna7ZlB7UdwL0Umrq8SXX8A59mw/T10us+7qz1X2Ev3CV/EnO2E
         xGIH7ZZTwIdA02Rg7bzLBeeoeorKcvZmWlaqO17PhPVsrZlMpb6ui563AcQFtLNnJCat
         JKoq3SlookwK/UVMBWwLorTbH7qlzDiDc9TFZXiB5ldQAp/ffUt642rj7KnOWQkbriTu
         4LsC3gNRY4giqpdt5ESPcmJkhlyF2QigABJEt6OOA8gG8KqDWsRgshWLwZqQFhagzkWi
         mmjMKa6HrWaDgB5tqyyaULPxEWJ2g9iOkyGuhNd2pkBvEHT/ZgZnn5RVFttC+apjKapm
         M7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547685; x=1731152485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ODXSKIPM8Xa+YaYVLc8WanEICuRtJG6U7jSPf/7hZw=;
        b=pzyv3NtOwDBogdv14OtzOeFWa/VnZFA0SQAbDomu2TvgZPB2IHA3ifVhuliMddSjD+
         nB+GoF25lRHhIHVCypXlvqc+mFlz9TKn+C6WHhkk1U/yxSTKk5xCM+uDCYea8/JlGwAr
         5QZ2/vM3TFRmKqfMMvJk01HCYtv4mnpzIThiT3S45bme2u5XLOqb6lREflsGu2XiAtGW
         3NVfPP/2Jx4sUK2ROkNhriOxSFhgh+e9fJSbrxpv6l8XxXLGH7s1uAKCE+mKm0hh7Dw8
         4yQkTIXWW4f0Hn6LdcAPlj3t8VRjkSzuSiCLwPxA231LDpvKykj2oFdaama2uU1S+0NJ
         axJg==
X-Forwarded-Encrypted: i=1; AJvYcCWW/t50465TlQzzlnsY3plcdmdi/EowvjzmfcnQaJKPPf82oU4T5xENlDpqcIkqza9gFT2akH+gIAr4@vger.kernel.org, AJvYcCXG84OEB0v1a+e5IBdSAXUJ/uvye+3lwQ3W3ydXdmFkmbzMpJkPkRL1KRan/Ls1rVbqsLzRRVQd@vger.kernel.org, AJvYcCXxZIWgfMba+AXg2mqgT8DL94EBYeg4/VCY/hXuMcgv818YlFFPX70LBF09V/4CguJolmwW3v9kQKrPadfz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RbZbM9Zdjgj+fY1pCqoh+t9ajZnZTqLd4c2/qMqvPCluhe4/
	k6OpCX5Jx1CJ/PZkYbWLfOBkmedza3faZbuL3iyXIkTqYYnL10Hfq5rZi/yQ
X-Google-Smtp-Source: AGHT+IGP63fQoQMFb/ObB1eGQudz2/rh/yY91dTuFfLQmvqaGKroFryYsgP1YkjTo2qDjj678icCdA==
X-Received: by 2002:a05:6402:3546:b0:5c5:bebb:5409 with SMTP id 4fb4d7f45d1cf-5cbbf88efbemr8731768a12.3.1730547685210;
        Sat, 02 Nov 2024 04:41:25 -0700 (PDT)
Received: from 1bb4c87f881f.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceb11a7aaasm2224918a12.83.2024.11.02.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:41:24 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	kuba@kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peppe.cavallaro@st.com,
	devicetree@vger.kernel.org,
	l.rubusch@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add support for Synopsis DesignWare version 3.72a
Date: Sat,  2 Nov 2024 11:41:20 +0000
Message-Id: <20241102114122.4631-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibility and dt-binding for Synopsis DesignWare version 3.72a.
The dwmac is used on some older Altera/Intel SoCs such as Arria10.
Updating compatibles in the driver and bindings for the DT improves the
binding check coverage for such SoCs.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
Lothar Rubusch (2):
  net: stmmac: add support for dwmac 3.72a
  dt-bindings: net: snps,dwmac: add support for Arria10

 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c   | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 3 files changed, 4 insertions(+)

-- 
2.39.2


