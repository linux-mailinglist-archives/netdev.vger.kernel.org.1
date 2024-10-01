Return-Path: <netdev+bounces-130982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7298C553
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC0C28744E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA11CCB30;
	Tue,  1 Oct 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC56QCFZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF9321D;
	Tue,  1 Oct 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807361; cv=none; b=Cs9MExExpt+c+QtHWAInsoXCRFIim5OnhKCfE1x+geodKrfWV+i2WElkBuWZmT8m2/sCa5TOv+Y0aiKyP0kZTnr/IjohxY71m5H/G+3HQ6mLaUBvh5xUjney0YWPoq+zunlFb9ZbNMffE4bDsQtdrr9iPnXMZl5aO6H3u3/02z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807361; c=relaxed/simple;
	bh=mKzdtNEIgcCT9P1DB0AuLjnrPoNxWxIEtQkyVpnAFWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGI4h6j1NeVlRsMDxhkakaH7XWY5+qWlfhR20JTQB9+OaiFU7Dpo4kPP1sIumid5kb24AJrg5JaOjZUCu8+JBd9DR639Ke40HTUSa95nCbC83rLbX+0fSJTGBi+Pd+EfdIbho5ODBgbXbRa1DRJiysy05eQbQH1k7LBlEKsZzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC56QCFZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso4570980a12.2;
        Tue, 01 Oct 2024 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807359; x=1728412159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yNMqNPKdQYn0gEa8Zwr032aSRC+n25QcqGjI//D7qw=;
        b=KC56QCFZYYEsyi2gMx6qOT5WoiS9xImv4LjsCdQAmVqx4kN8ecoXRkSBZeOoWUPTrA
         Jn+ligj27GoZfce0GY95K7Pzyicorp3G/6pFLIbQnR6A3MdtKIngMsZENK65LJPFCAd4
         88zG63/2C3znIOyyvZ8E92VXtcY4xOe+Z0ECvxO7ay9bcH1Jvg8dzPwIdV+RjxgZWcBF
         p56Gj1sBOWUd5BsXg8SHPJOSMUOr9a6gf70gLehBcTrJgnmHMmPCmqUt7ZxPvJAVOKFo
         UWjLnFQbpgnEPxmNmss+xGZnBJ6lXeqQxMxCVrB9ogB67YQo++jFwI6sgyIK0VeUQCor
         NQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807359; x=1728412159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yNMqNPKdQYn0gEa8Zwr032aSRC+n25QcqGjI//D7qw=;
        b=e2B6YiVPRQ3rVvhMSrVERGjIkUpOP0nGanvnXfjYCTvg2ep1WiwUmpVWcYSkyaBFXE
         mQpNjWCKvab0auu5zlIow41LTL6bLDRB4Dg9JlKgt7JYowCKOU/nBDIs9IRil+AriXDt
         vK6MiWmv0/zLwjyDMUSyX5sQhoWNL0CCnQ7GA862xDW43HGzoOxPNaPIZ8fcATx3+92x
         hVVheTXL7epo2qVWWFRFbA9ucr5ztYSQMs3vLIR3os7gN1D4aM3FO88N2BQS6Nj0QVGb
         SqwVk+Xq7IB+6BM2RTmMfeyh/Ws3pzYgzmIBinJtepJQ3GcDS31h956EFByiyNuqPt5/
         GVEw==
X-Forwarded-Encrypted: i=1; AJvYcCWjgzacxYhlPDns2lFI6ntKLAfX8+FEXX3GHu/oSsbOriwjlK6F0rGCQGqUjtit75tvc0eNjAmhKhyEjag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvUwj5AdZnmM+n2nu0h8JByxDaUsSaEUsPwJtakegAZApqpce
	s0bFRI0G14/KKKEpAsBR/f6EEzEoXE4u8oOWXlUhyYnuAr9mfC/v3p4yTDSL
X-Google-Smtp-Source: AGHT+IFwhR5ekNYcxPKTkn/38wwnxrSgwvizSpD2YlhM5d+YlO3cU7VLRytLSIN66umHLhAh9T8PAQ==
X-Received: by 2002:a05:6a21:3983:b0:1d4:fcfe:e1ee with SMTP id adf61e73a8af0-1d5db0cc68bmr876533637.9.1727807359168;
        Tue, 01 Oct 2024 11:29:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 0/9] clean up with devm
Date: Tue,  1 Oct 2024 11:29:07 -0700
Message-ID: <20241001182916.122259-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It happens to fix missing frees, especially with mdiobus functions.

v2: use reset_gpio variable to handle errors.

Rosen Penev (9):
  net: smsc911x: use devm_platform_ioremap_resource
  net: smsc911x: use devm_alloc_etherdev
  net: smsc911x: use devm for regulators
  net: smsc911x: use devm for mdiobus functions
  net: smsc911x: use devm for register_netdev
  net: smsc911x: remove debug stuff from _remove
  net: smsc911x: remove pointless NULL checks
  net: smsc911x: remove enable_resources function
  net: smsc911x: move reset_gpio member down

 drivers/net/ethernet/smsc/smsc911x.c | 231 ++++-----------------------
 1 file changed, 31 insertions(+), 200 deletions(-)

-- 
2.46.2


