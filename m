Return-Path: <netdev+bounces-124697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793896A798
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61B11F2542B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3211CF5FA;
	Tue,  3 Sep 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD0adjyl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946F19146E;
	Tue,  3 Sep 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392596; cv=none; b=cM5EJsu49KWUGZRBPoWDmFZKJu7CBK8HYZaF2JDXSQRMKUiG79LGFRrpHQRgjuGYBmMAbd76J+7pE5bCQvvuJcyVkGCohGljfjn41KGcpLaren90PF4x8VwKNH2ZTzIC+/ybwSrYy02ULG9eBP5PtZojIT+Ru5pbkAflusecz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392596; c=relaxed/simple;
	bh=RsP93kskt6TyMEgKFgfCYUSQ87hA2luB+3DOv4k7XZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okwkfLEmyCJuUW1K7y5eoIctenHSd3+bo0LmTKcxzZb//7fQ4kUSjYqA11ZK33cf/I0uBQsN4WDZ/OUFL7wRMcUzOVdDndfH5UiKMyxFFbwxtfse8l0Y0OYKDFePEr4bhVEa9weJTtuHRBtM1fzxsTcs0X5GnkD1qQxheno7HBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aD0adjyl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-205909afad3so18532255ad.2;
        Tue, 03 Sep 2024 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392594; x=1725997394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7AumO84Tge/7o7E2V2XX+3e+tIAEGTAxhK3TwI2PLc=;
        b=aD0adjylhDHruqe47sakOUniRvI8WXmXoJPI/b8M4Arw0093zeXTKmLBalrs9X8HLt
         ZDfTqKUBV/Xpd2Ky2NOYdBE4ssBThZ4C+0pw7sruJ+QbyJdakdtozjiu78kuMloTpzu/
         gFKZ/WpngdzVmasW/rTwa9CBsKVlNmQiYcRN42y5bpyLoDX52ggt2plXEUGotZYEDlw6
         jqTOdQAF89A49FG2triC8S10SxAUG0d4arxICviBrCzFUlWODnKr9wYfM6FscFO0ku32
         NS1B+WePRfaZVMtGinFYmiG+WHpNQzMh0aUBn1Z3DkAQb2rnbtZvS3lM+Srp8IxTwBHc
         8q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392594; x=1725997394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7AumO84Tge/7o7E2V2XX+3e+tIAEGTAxhK3TwI2PLc=;
        b=RJohUkqBEX240yAIN3tWAMISBB++OnsgXGHkOuUQPxRQVN/5zk3zjfdL7ep8uebKdF
         Q+u8RVyK/8fQpYBCOmF4FL57zziEiS12elSfJR1kNTpIo2HFao1zFeAeBQrMR6A3Pfku
         mbIu9/dI91pmJ0bd0R0EmZnI7IB0DKgmELU486DwmdHFo58cSSsSsDQCj+IsCduERWW9
         8J21Iv2cXDk7nPXtIGR8QjSPIxuagkqlmUOzvY93HtBc2H84eYU8J8Ls0Dq3nZWMzxMA
         5RyI88QqegQanmNQXI6dDR9mIr7m0yXWOaLVUxF3fNfjATywGFDj1L4k5EBfmsyBne2L
         Akjw==
X-Forwarded-Encrypted: i=1; AJvYcCXAGCyVjIHoeDfff8xPzO8TfSXfrr/YTawk3y7C2uv86o+/YG9pMm39gIm/TyEiOnRMTKD0BCzhFf7Xnf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9xqrhnfpPu105P+h0uVzHvV/g3GPSksBgeejWjZkBu5XjAMQ
	bCbkJhbIrwTNIB9PrMN75PU/7A62dR6JJxoqSA2HQCAmn1BA18tbHBBQscAi
X-Google-Smtp-Source: AGHT+IFLIgQs/nyFpUrhKAJyJKwztqci7AiWQpNaMRSBhDAAu/Mudzn3SHTltxZgpKMmmc96MeY6KA==
X-Received: by 2002:a17:903:244e:b0:205:5548:9a28 with SMTP id d9443c01a7336-20555489bacmr125702135ad.49.1725392594488;
        Tue, 03 Sep 2024 12:43:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 0/8]
Date: Tue,  3 Sep 2024 12:42:36 -0700
Message-ID: <20240903194312.12718-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a very old driver with a lot of potential for cleaning up code to
modern standards. This was a simple one dealing with mostly the probe
function and adding some devm to it.

v2: removed the waiting code in favor of EPROBE_DEFER.

Rosen Penev (8):
  net: ibm: emac: use devm for alloc_etherdev
  net: ibm: emac: manage emac_irq with devm
  net: ibm: emac: use devm for of_iomap
  net: ibm: emac: remove mii_bus with devm
  net: ibm: emac: use devm for register_netdev
  net: ibm: emac: use netdev's phydev directly
  net: ibm: emac: replace of_get_property
  net: ibm: emac: remove all waiting code

 drivers/net/ethernet/ibm/emac/core.c | 227 ++++++++++-----------------
 drivers/net/ethernet/ibm/emac/core.h |   4 -
 2 files changed, 79 insertions(+), 152 deletions(-)

-- 
2.46.0


