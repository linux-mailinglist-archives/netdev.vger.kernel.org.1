Return-Path: <netdev+bounces-141667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A531E9BBF22
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDAFB20E82
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2651C8767;
	Mon,  4 Nov 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai9X7ook"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C16418DF89;
	Mon,  4 Nov 2024 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754092; cv=none; b=oE/vs6JMGfmXfdvkzHW05fqT8R+Mj7Ec5niZS2Z8MxmP1mEbxkhkAT0eZ9+vXYzIaoLFnkzcsiW2We7FNqBwqEUhgTMhGx9d+ggmiG+vOoVUhVbg2hkoWoIVk/mN0v0ZkOMVARZEgSQ6KN8aNxuNdfLimhrujg4jIK7YENoL7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754092; c=relaxed/simple;
	bh=ALFJFS3Rkcgm97W6TEJgZ8185IfAfAw8q7GSv94pm9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pa8HyC7eBhFEsxanFkcEXhTWdMZrCccQdkn6EO/evsq2xMKpn3Abxxf0wsdklT71G60rAPqgscxTb8pfSPn9jiSm/zAoI8WHST8ohFua0DFL+Q3/O4uBOLRTKL4k+L8LFL7qF6sgR6vXLFj/jm1UkMqZTLPjjVexWD1Yqk1d1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai9X7ook; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72097a5ca74so4443845b3a.3;
        Mon, 04 Nov 2024 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730754090; x=1731358890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EOZ30S4SAP3QuaB6bi4m6ZHBaGMcsecLVZhaad9YKzY=;
        b=ai9X7ookgJVWfxINgORMejXj7YrO0rnBj8zFCFphDNNHqTDEMjVf1pq/+eRUig60So
         wW9Hc0KfxgZpssXq3gt5bSzOAh3RKblQDA1odh5BU+UJlmn26JnzPBdFrrm1nmMpAmsf
         /VWLI3q4sU7tPuIaXvOZavZT2qHY3/q1TZkq0as2UEdzWJSQx+NtfEVNfyzbJze3Y5Fa
         /8s3BZEkHKIO0FQOCWRGiOmLc6Crfg4nFJweH/obagW6j+LNON7e+P0Qmz+VohT0F4Nl
         p2j9UaASH5chVX8Nh6vDwwTLUrZzXLk75zK94XXP9wuB1CQedR9sjmIN3b2Jp2KTuJHD
         0rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754090; x=1731358890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOZ30S4SAP3QuaB6bi4m6ZHBaGMcsecLVZhaad9YKzY=;
        b=sOkqBVWuFiHdRUHVcU3Uy8YH/tzcYhKj2whkbRGmAu74xEPciu+3Yk4huq+Kkb6jaY
         AKWyyZ3Wtc7XxGhIQ/iNdo/FtmpMU7wqCyHJ74Ow81fXdPHjDdr4/3XE3Gr5FnlcYA7V
         MQ7qGGgyjq/BiUk+esfn7sRQ0U/8bBLNg+DrxR+Z01oZwgTPTd5KER5HwSqvOcvKC+j/
         PwIJ1tvmKtycmrtzoOA0wCbGywUbNkauk6TvlKthcWsZo3/Qv46wstY5nGZVU+4uy6vZ
         juuDS8su5SScYz0YZutG2g3loabr/OWrpGgiuHnPMaef8YYAtMrCH4R0yibyWqvCHwJJ
         Wgmw==
X-Forwarded-Encrypted: i=1; AJvYcCU3jaG/BjpH+3KgDpKClYTA/f2PWrjc8CYmRbFaBTDhrWZdfo7EfrIztq7ybbJomO6JsHYjpa9ybscDHyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEZfwsmE0/JpMrJYn16f89xLVtfGCOgxH8YORE/YsEBuzuDRn
	t2p/zaal6R0lK+dBOh6VQuOE/I/L0LncZOu9Q32HXgK+zVj7OyWKwoFYY44c
X-Google-Smtp-Source: AGHT+IG2k9jTJ8w3WT4q0Xp/IKcaQ8oJnjwc3KL97LKHzDgZ2ZetMe5DuSuE2uDGPwM8iqmYNZlNOg==
X-Received: by 2002:a05:6a00:4fc4:b0:720:36c5:b53b with SMTP id d2e1a72fcca58-720c99b5c7fmr18641347b3a.17.1730754090153;
        Mon, 04 Nov 2024 13:01:30 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm8307755b3a.12.2024.11.04.13.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:01:29 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	maxime.chevallier@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/4] net: ucc_geth: devm cleanups
Date: Mon,  4 Nov 2024 13:01:23 -0800
Message-ID: <20241104210127.307420-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also added a small fix for NVMEM mac addresses.

This was tested as working on a Watchguard T10 device.

Rosen Penev (4):
  net: ucc_geth: use devm for kmemdup
  net: ucc_geth: use devm for alloc_etherdev
  net: ucc_geth: use devm for register_netdev
  net: ucc_geth: fix usage with NVMEM MAC address

 drivers/net/ethernet/freescale/ucc_geth.c | 34 ++++++++++-------------
 1 file changed, 14 insertions(+), 20 deletions(-)

-- 
2.47.0


