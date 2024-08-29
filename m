Return-Path: <netdev+bounces-123512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB329965246
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E101C23D12
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252218B47E;
	Thu, 29 Aug 2024 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj3X8goF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE818A933;
	Thu, 29 Aug 2024 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968122; cv=none; b=tjt5xfsrnKC52iScn5PHHcMotKe2L9JgFs/Nykyr2+ys+ee8B+CfZmWFQqZDtxiuAmijX/2zPjELfn3+6m6LPz9841/m+/sERNYauTrHHHRzuZq0yMtcKmb/HAwqf4lmWlx+pc6T4WQp5d2wGj97qLz2LqWKkE1zqo/5L549XMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968122; c=relaxed/simple;
	bh=ClZTJ22mrbLe4vhaEPwBtwExAsf6SDZ5kNm/gR/u63Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLhMaA3z5SMi9btwCx0YROWVdJzeuPy0tpzmgeadoAg21RrJTCEp4ZnkfM9CnLh3AhojTJkQd6DmHBG1R8tGMRhPzzkLgXMWAKZOTG+9cDlRUzA2S68DwKZnKRXeVRxwHA3TBhEJ9skWCHyseNb5xJy+KFFL4re8P562woEA0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj3X8goF; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70943b07c2cso756951a34.1;
        Thu, 29 Aug 2024 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968120; x=1725572920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SO+Q6EzPs5zUKPyWEYd/uHAfo+Cruq14XyujkLL83EQ=;
        b=Kj3X8goFG37ALHf452rJ2qaY+cTUXn3EKyTiIBTnHJob5/hte+DSN5uIHJqsHUy/qp
         ciqhFtxSMQyNx4uHxOt8VWXB3CYj/DpTP/pwipKOvHVfj0MAECfR34BnDQv3TwKr725E
         NAyqK3A1s/NYCjh3xInsz8ggnWAIGBTtPZq1iDlAhu/prdWP9aKfmqQ7spg0aH9L8Bje
         ZYogDlS6a/DCh/YIcoRrs8gRbPzmz4PYw6aSzZQ1EcQic4blUYGWBRJ9rBplxzbWoGVl
         27RPrY834aBjR4Weh0YBQmo5EPfmAYhAl2ctbuY174dSwuhIcFOZaHuCwJzfirFl1sZf
         Uz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968120; x=1725572920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SO+Q6EzPs5zUKPyWEYd/uHAfo+Cruq14XyujkLL83EQ=;
        b=XaNCBO8n5ZMNxKjfK/rVdy1+okNvdv2QnlzQ1iu4CHPqnj237LdidCPbDpkpmcbVkv
         LMnCiONGEEG3Q2FGR7QTZSr1NkSMaJpnlu5DhIfVsY8+Sa2tcDSyQEPz7SZZun8Si7Xy
         TiRE2JI3aT8hy/RKi23mXQyah9dxjI04x5EalzwUY/XjgQEV4jVQLixCXUNSHBwUcSBo
         xitf38fmKWXWPEQvehKHTK3l7dehLEamQ14DNpmcb6YQ0pKjLe8kELgs9j7S3ukxFQM9
         JgetFi8bIDLxJd6m+rKLh/R077MmGFMPf0Wkl9IZsFoDr11OzXPTp7kcMh2QjcENCNa5
         GZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXJscINW1RazXAuUw2vv8sKMfDDG0D7Cv1DCtcRStmmsoC7JReuHbc/DCk82RJHcphD/xN7sRUBZd44GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzilY5HzzIg19o2WF7632I2VzVGmrhrO1bzP5ugdBV5aJG/qqTw
	k5BJaZ4B3rKxoEcBl5Svlor9sALjok++heVjfOhR46yekZzSkkT6APkEpNv3
X-Google-Smtp-Source: AGHT+IEfWS9XbisgCsKEOy5wemG+RapPG01S3iQaELYUc0KqXS/kmpBchtOqrmbK04v9gxZCqB8OWQ==
X-Received: by 2002:a05:6359:4597:b0:1b6:d3:a628 with SMTP id e5c5f4694b2df-1b603cce721mr528003955d.25.1724968120080;
        Thu, 29 Aug 2024 14:48:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77a7besm1708029a12.37.2024.08.29.14.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:48:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 0/6] various cleanups
Date: Thu, 29 Aug 2024 14:48:19 -0700
Message-ID: <20240829214838.2235031-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow CI to build. Also a bugfix for dual GMAC devices.

Rosen Penev (5):
  net: ag71xx: add COMPILE_TEST to test compilation
  net: ag71xx: update FIFO bits and descriptions
  net: ag71xx: use ethtool_puts
  net: ag71xx: get reset control using devm api
  net: ag71xx: remove always true branch

Sven Eckelmann (1):
  net: ag71xx: disable napi interrupts during probe

 drivers/net/ethernet/atheros/Kconfig  |  4 +-
 drivers/net/ethernet/atheros/ag71xx.c | 75 ++++++++++++++-------------
 2 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.46.0


