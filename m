Return-Path: <netdev+bounces-190753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2F1AB89EA
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C836D16C1E7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC88D192D6B;
	Thu, 15 May 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChR98yrx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DD34CF9;
	Thu, 15 May 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320727; cv=none; b=g3rov/KgORdpXRMPQ5nVkhaU19uHIXgNXp/9xLaUjjd9f96lteG+0iSbQJZ1732t3Y/M+ptaYPcjaF3zdEE9R6tQA/5zxDEXj86/TyEjQIdlAG6SSsF1jtNhZDgCSrbh0U6eeFYo9je5myn28Se3Exij5gfr4nlxEi3XnFSCeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320727; c=relaxed/simple;
	bh=NmoY497PnjzJmvhyLUTzuh03sgxv+SnIeoHnCzkIZYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NSavZLxNlXh2Jjy/NmgW75dnqPIZ94kgeycVp8eAsapKYXrbJzsk+wcgCYJ5ElJEktSDm+wdDRxEPkuefKxFXiBIC4BrLd+2sKon8YLvVNxdlgeJtoehXKNd/Tl54ij3bHRpo9vXzGYuvABLtpOuZoxKWqyw8fjcL4S5EQwwKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChR98yrx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fcf1dc8737so1993881a12.1;
        Thu, 15 May 2025 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320723; x=1747925523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3rYtHGI7f2bS5Wz8y1R8kta8HvN8vcDb4XhTNw0Ufw=;
        b=ChR98yrxzbkJ3jwU42GsmADFb7j9V0MWNqHm33H1DtyRipHOgfTZHJzOKmvD3GSV8+
         y/ATCiZIcMqREEhnfa29lhx9PdL1y/0woCwis8jXjjyxEHyclalCIbaeYNdUPh1k/EBa
         e5zSzrfkGKt/pGYGfVINSeWBFjvhPKuOrswtM584Wtut58VQkCxnyXce0WoT7eI2o3Va
         w98dw6KA69lrxMksn12GO35y8EjpFH7a+ATROA4z52VydVlZfaPaLn2JspmGnEnuTOXY
         ZSQH6+ijG2rGfaRl8WlpXO9kopaLohccGouQwbCxZYE6/c8+Ymw1p9rDo14XFy10bfM8
         VFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320723; x=1747925523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3rYtHGI7f2bS5Wz8y1R8kta8HvN8vcDb4XhTNw0Ufw=;
        b=UqUl5bv/F2eVf1SjdpeZAlBna0+aUV6B8rhIAsdfvEQ1XwFp54IrspgtfxRTahqoMn
         vXf6lUpecIeD0dAMa+H8HO7BcRo+dJBhQ6VLdPr5dX2oFJZYZSXaMYMqsxV1zIS+axRL
         hxyWqLSkQG9+v3PtUo+m9tlZWJEAsRHt6UJSTwS2IMcrMJcXdG7OE31agDfwcS/ruftn
         M6a4478iTU+ZdY9Js24qv0E7ra9K7bWswLuHpBTh0uiBmCN1oo4N8+MEgDdqGmM5VQFk
         cAYXCdYsfHk+cd57VFCBhEFx43xKrmDFnYoA61eXZPPgFDZhwxapjuBEGEFwMEshlcC5
         5raQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhXeTctkQczYLwBgtMEYXtZASKkbrQD6euXATGiHWrujNHsT055XhZnhA4ycA6kryH13SWjcqm9Hh3mio=@vger.kernel.org, AJvYcCVo3qX1iqk71fcG13heLgDLe71gGfGsKzC6rhQ/adOEJWfidg9/CAyVwf6hGda4Yf0WIW6H3KH4@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGJ5nKJRrddrQ6yV/5ONmoFQaGR1HU0a5hFJ8+mMWz1Hbz8Oh
	pd1cscjBBAf6Gl2GOV5e+VXcABj9ZPoa984pRkceXoWaggsTBwmp
X-Gm-Gg: ASbGncvJCQmePnjG2ct0PZV7zvXvICuW8F6S4ynE52Zneml0nKStABRKvYjbk8TuiGf
	E2AErcCJndcAwBUbCIMH9O8NJmvbH51vXBTOdXwIrWomf4l3pmUUxh1WHin9tjK3qLPxYtDx+Nf
	KHxIYn7XqkZ+4KTFohTpJ8pc4cboYrcGJF18TB9z2n69AvmQS7XDTzNEJuLGAVtxbE58YKs/Ql3
	+2JwKmi2B9GA9DrGojGRd9arE2giIRSBYx2Mbv/Y2nzVbN5Wfb0his17xrXLn5yyIHhNJcL2fWw
	7iRJK6WglcoWYvILG1vU2FyAU5kk+PFaq1bGUxFwz6GqBTbIcikicDmRhaI6QQ==
X-Google-Smtp-Source: AGHT+IFnbQsmJ28PMwm6ZpW/qqXkzMbIj8mfZUAcTRDZys7wkjr4Qrwaxu7LwCnZ1+NttJvuk113ng==
X-Received: by 2002:a17:907:9448:b0:ad2:2c89:7a8 with SMTP id a640c23a62f3a-ad51612af30mr268227366b.51.1747320722901;
        Thu, 15 May 2025 07:52:02 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d275d9fsm871366b.74.2025.05.15.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:52:02 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH v2 0/3] net: bcmgenet: 64bit stats and expose more stats in ethtool
Date: Thu, 15 May 2025 15:51:39 +0100
Message-Id: <20250515145142.1415-1-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, this patchset updates the bcmgenet driver with new 64bit statistics via
ndo_get_stats64 and rtnl_link_stats64, now reports hardware discarded
packets in the rx_missed_errors stat and exposes more stats in ethtool.

v1:
https://lore.kernel.org/all/20250513144107.1989-1-zakkemble@gmail.com

v2:
- Hopefully better readability
- Fold singular stat updates

Zak Kemble (3):
  net: bcmgenet: switch to use 64bit statistics
  net: bcmgenet: count hw discarded packets in missed stat
  net: bcmgenet: expose more stats in ethtool

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 279 +++++++++++++-----
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  32 +-
 2 files changed, 223 insertions(+), 88 deletions(-)

-- 
2.39.5


