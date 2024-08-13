Return-Path: <netdev+bounces-118138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2D8950B19
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3771C21CA2
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208801A2C06;
	Tue, 13 Aug 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjQisII0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8637E;
	Tue, 13 Aug 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568741; cv=none; b=oRVV9SbKDYO1kWLob+a/wZOuKib1RT7F3QaLY/ioFXKPPQVC3UPqCqalYjuYCa5xZYPArs7f04QsDQgFYHLNaScRi0hBXTc9uC9kXT5cFZdbJgcPv5PWzYcetsAVKEqCPwpAB9J155LdyT2YaIET79zMdgsTam/UOfol5gmpIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568741; c=relaxed/simple;
	bh=8QCG0HKKblAFHR6sw+5NQR32ksbazzT7/yBVnAXLAXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7siWH7yDuY0FKk8SqSe/uXsnvDSUhwS1ZA0P9sOx4iDionVmA1ZW1dXfNkmRStjpIZNT49XgbQam7TDvpa06qUIQ4/m13KBygWRV/sTtVXVL/ISHm+jD4ble7tkwGNjdKFahgyQ912E73dyRV6fO2gAUspsJOKQaHAAOX1yVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjQisII0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc692abba4so48811945ad.2;
        Tue, 13 Aug 2024 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723568734; x=1724173534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhvoic8x4/HWih8RUADONjtyXgrbUNXcRfV7ofegVCo=;
        b=gjQisII0PhbZH0wWCowpeSRVqCBkCtogWtldBg4MdsD+nqod47GqJbrmUZWJWB3sA8
         hbFGjnNMTfO1oy4LG5Qxy0OfqZdkwkWwX/UphXMQ8IMg3fOEPkKQPfgYPM6ebTAd7a7d
         CmK6E72m7pfbKEmi9SbPe/mHxJ0V3CYnmRNR6FPpFIT2PmdzarAs0Xlvz8Nb0Z8Ao1bC
         4f1huk49x8MrGduCtXhWqvdkqZLt9FkpRwU0oIbB+9PW/fAvc38JdxF1txB5xoaEN47E
         L3y9fVXhbgUGwGcHXE6YvB9c1iZ5tV58GXVciDkL3KJR+YUIdZ3IraoxaW/72JrPPH9U
         gGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568734; x=1724173534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dhvoic8x4/HWih8RUADONjtyXgrbUNXcRfV7ofegVCo=;
        b=oevLAUFAHLCBDQ1iseLpotAVi4smoncia/fWLHlHyEwJIXka5AjLqQIiFqHTgcgEJG
         AjVvrBALhL9oERnXb6BSOc7E7hu3kYco6JziaS5m32iAT882qN95DobI3jHWqB73Kwcp
         e0vO0Rla2j9b8k3znbQzkYl0+OjbGT1ywTgzLFvV6J5h0tpffIMLWZha1Mjd9pNJZsYb
         /xANKWIwRwlJm2K8t+m6eiweuYGw9Yua/+lQarn5YIcZ7dCf00lj58F7hwveh6+6Rslc
         ZIchOp/PHh622xnzbntY0RDPO8S1dWCV/6ktM2CWB9BFqtLRh64aLWrbCOhuSO3EI9Lg
         Tnmw==
X-Forwarded-Encrypted: i=1; AJvYcCUOfFFd/sKfCDoX/M87bjIN9HRN4kiSm4G4DwEa1caDNn6MaCLNw95qkG/5k23IEpV+VBcHcdbB0uYmX36QYGKTlYp1g61GUFESgES7
X-Gm-Message-State: AOJu0YwqBR7dSU7FakykI7XpxorjpWdwFm9dheaJaQHyw98AWgwejSjB
	8J04JiolNVxAa5TY4mFbNeBo+A6u/7HCmIqZGN0fmAJ5plqHyO4ZNtQkTFPD
X-Google-Smtp-Source: AGHT+IFE+Mmlk3Upj+zl/d8ABg4fOAR5qk0QGdE/gsYgDG2EtEIXIVpSMnSq2MgzO28KM1r7Q3fzFg==
X-Received: by 2002:a17:902:da85:b0:1fd:acd1:b63a with SMTP id d9443c01a7336-201d6520291mr1526035ad.50.1723568718116;
        Tue, 13 Aug 2024 10:05:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a947fsm15946425ad.140.2024.08.13.10.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:05:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next v2 0/3] use more devm for ag71xx
Date: Tue, 13 Aug 2024 10:04:56 -0700
Message-ID: <20240813170516.7301-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of these were introduced after the driver got introduced. In any
case, using more devm allows removal of the remove function and overall
simplifies the code. All of these were tested on a TP-LINK Archer C7v2.

Rosen Penev (3):
  net: ag71xx: devm_clk_get_enabled
  net: ag71xx: use devm for of_mdiobus_register
  net: ag71xx: use devm for register_netdev

 drivers/net/ethernet/atheros/ag71xx.c | 74 ++++-----------------------
 1 file changed, 11 insertions(+), 63 deletions(-)

-- 
2.46.0


