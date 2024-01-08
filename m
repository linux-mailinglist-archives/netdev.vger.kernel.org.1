Return-Path: <netdev+bounces-62461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDD82771F
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 19:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD411C21FA1
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5834C3DC;
	Mon,  8 Jan 2024 18:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CE54F84
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a298accc440so231596966b.1
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 10:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737780; x=1705342580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ws5fykPmiwXjLHnf6jb+XYXz5FMvRNyMpF72pclFh/s=;
        b=Ko3VO3rgMCijHdXXPhQRPOZzH9nw4KO5aZu8zAo+C9RePJyafp61AEB/flkp7N+0b0
         /NMBYBAdNxxt3yJg7YLoiVlFgPV6ZkDqAtx8AfNPanYjhlZMu/KEG35eVvEYO5z/e1SG
         uCm8XO4nTVZwQffqyUCoVpCXFnC8FnuniSBB8mEHNsJPCQy8IYXkrZNBNaXDxBP/akoN
         fILJeZiM/hxPq7LvbSWED7Sil/Zl49kFm/GfNzd7NrBptlvnZ7UZWBwEHHs06aP/+0Bq
         E+bwOcng1C3NQlYWnzLcdYmdht7FG1pP+rpg8dVkqPkQ+FJZVmGyot1FPgi83V8LLqcW
         Mudg==
X-Gm-Message-State: AOJu0YweRBgO7MjIdxiaeT/00q+tvyzw3rDEmbWQYks9HKO16ZtPjHz9
	gfvrEQ3O7AbCyb/mAwaQLPw=
X-Google-Smtp-Source: AGHT+IFAZrpXG34ncEtwoIvlXLJRR51y57DNnO1QD8vnMpQRfmUUy5zzySePT6Hvo0zKaV46dyh9Lg==
X-Received: by 2002:a17:907:8f8b:b0:a28:cba3:ae83 with SMTP id wh11-20020a1709078f8b00b00a28cba3ae83mr1287836ejc.105.1704737779859;
        Mon, 08 Jan 2024 10:16:19 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906489400b00a26e4986df8sm133026ejq.58.2024.01.08.10.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:16:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 00/10] Fix MODULE_DESCRIPTION() for net (p1)
Date: Mon,  8 Jan 2024 10:16:00 -0800
Message-Id: <20240108181610.2697017-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are hundreds of network modules that misses MODULE_DESCRIPTION(),
causing a warnning when compiling with W=1. Example:

	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020.o


I am working with Jakub to address them, and eventually get a clean W=1
build.

Breno Leitao (10):
  net: fill in MODULE_DESCRIPTION()s for 8390
  net: fill in MODULE_DESCRIPTION()s for SLIP
  net: fill in MODULE_DESCRIPTION()s for HSR
  net: fill in MODULE_DESCRIPTION()s for NFC
  net: fill in MODULE_DESCRIPTION()s for Sun RPC
  net: fill in MODULE_DESCRIPTION()s for ieee802154
  net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
  net: fill in MODULE_DESCRIPTION()s for ds26522 module
  net: fill in MODULE_DESCRIPTION()s for s2io
  net: fill in MODULE_DESCRIPTION()s for PCS Layer

 drivers/net/ethernet/8390/8390.c      | 1 +
 drivers/net/ethernet/8390/8390p.c     | 1 +
 drivers/net/ethernet/8390/apne.c      | 1 +
 drivers/net/ethernet/8390/hydra.c     | 1 +
 drivers/net/ethernet/8390/stnic.c     | 1 +
 drivers/net/ethernet/8390/zorro8390.c | 1 +
 drivers/net/ethernet/neterion/s2io.c  | 1 +
 drivers/net/pcs/pcs-mtk-lynxi.c       | 1 +
 drivers/net/slip/slhc.c               | 1 +
 drivers/net/slip/slip.c               | 1 +
 drivers/net/wan/slic_ds26522.c        | 1 +
 net/6lowpan/core.c                    | 2 +-
 net/hsr/hsr_main.c                    | 1 +
 net/ieee802154/6lowpan/core.c         | 1 +
 net/ieee802154/socket.c               | 1 +
 net/nfc/digital_core.c                | 1 +
 net/nfc/nci/core.c                    | 1 +
 net/nfc/nci/spi.c                     | 1 +
 net/sunrpc/auth_gss/auth_gss.c        | 1 +
 net/sunrpc/auth_gss/gss_krb5_mech.c   | 1 +
 net/sunrpc/sunrpc_syms.c              | 1 +
 21 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.39.3


