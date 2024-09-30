Return-Path: <netdev+bounces-130608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C7298AE65
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D371F21126
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617291A0BDC;
	Mon, 30 Sep 2024 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNfmMLXO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9B1A0BCF;
	Mon, 30 Sep 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728195; cv=none; b=D6rG3Mi5tgqsIFMxspGG+wG4P1iA/3PXHcD9fuDShPqQrUQuzd3R4mAdJBEZuxAMuqfMfl7cPzdTGd4Fcuk7f0gSTiH6Lr0DNqhxKQAeF0BUBVXAO4TLMVBW+TREx35b56AH+cYJD7TM6qtOznGZ/GK+4A+vi8PyKnDQU2iJs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728195; c=relaxed/simple;
	bh=HRR9bQHiRT+CjeQFS+GpJay61LnVnKn+EnbGQoZ2oyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5X0O686oKr8F9QDj7m7zteYxQD5FX+QhBLKEYtE3elt+kQnuYNOo1LWEt34bvBGtAQ6q+N99bgXs/nywMNKfZi+hj+NxhuFwbCpkVon25BCujfsEdfWvFs3H5o/jSG4ejfTbcIa/Xz8sSS6n2PvQf/Bp+0q2gIrlaNRrkUx2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNfmMLXO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b7eb9e81eso16075355ad.2;
        Mon, 30 Sep 2024 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727728193; x=1728332993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TlNL3fIBPDjIX94VzI+XsLBPzNtcysQHiWGsRof9Kdk=;
        b=bNfmMLXOcLJS6n5dlOW4hfuBoV1OvsjgfjYFtRpDf35De9k4SeqVXbhlcu5ICndBKx
         zBocQtw+k+y074JoWPICayZFIL7LzkyD0a3g+QCC31O7IameaQjHu+OBpyDsk7KipSkj
         Yg3vXxuyK2UJ78sD0TIrNd61zLA1uJVMdGzpexVVQWGF/9p98bVoJS2hhg3lzJjqtabI
         e4Xyz5cXozE+uHTP5RmmTkNCXwWK46SvvOfGhvoC/rlms4LeZTR7JhpiF9Cra3avLQr3
         4rnIRCf8K5He0U3ZWI8TQlFku8sx6PzRl0A3ayI1NialKvpIUnZd+W/VX0DC2ltKr2GO
         ZXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728193; x=1728332993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlNL3fIBPDjIX94VzI+XsLBPzNtcysQHiWGsRof9Kdk=;
        b=KcBIE2bc6e1G9AzmAN6GxtqJnYYSZ7/skaPyaEDn3GkMnElPQ0cDdZOMIA/gXyITjL
         edmQ2i0SUjh5pocy+3cip5D0eoT7PeWFpWW+pHXim7FDudeptwaYmssuco+SKd9yvRGT
         79YhBuoiwCAdh/iXqmC4Qa+F0MtFZE9Dsmxua2/TvD13C4ocCQRPhsdwn36Tk46QUNcq
         3TgurRW+nvhX9r9qz5nfZZ0ept534KwA2TQhP8dOW2nxpS0cbxl0ve+IJhw+v1KFPkJH
         DTX8dPfo+Sm4hlimDcFFejvtPVwlU75O5J/QPm0fpUCTqBS4ALK2bhxQvNBAynEAgvt0
         W25g==
X-Forwarded-Encrypted: i=1; AJvYcCUAfFQYQQ30fOgpaL4CkT+MBUE/JJqcY44A24HevW7kTgPWl7XiEIROFyXkeyK1TJzFQzG9HoE5KIJi6Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIcDG2VWedmsI0WCWMgsT7YhkTHXv8aPHCtGuZi2KghRqiRYp
	ituGzbNDjiakAul2D/Q8Hxe97apIy0a4MYMdLHCTaB1Nx7C+0B+bKPgTQKuG
X-Google-Smtp-Source: AGHT+IGEExGblHSNU0s12qUoLFZZ+ZLKbeNKRFlHy7UNBO6pAD0miTdR3qZkv9YeCcpMfASfl3n+dg==
X-Received: by 2002:a05:6a21:3a83:b0:1d2:e888:3a8e with SMTP id adf61e73a8af0-1d4fa68682cmr19024096637.18.1727728193108;
        Mon, 30 Sep 2024 13:29:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eb3ecsm6812943a12.60.2024.09.30.13.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:29:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: mv643xx: devm fixes
Date: Mon, 30 Sep 2024 13:29:49 -0700
Message-ID: <20240930202951.297737-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small simplification and a fix for a seemingly wrong function usage.

Rosen Penev (2):
  net: mv643xx: use devm_platform_ioremap_resource
  net: mv643xx: fix wrong devm_clk_get usage

 drivers/net/ethernet/marvell/mv643xx_eth.c | 28 ++++++----------------
 1 file changed, 7 insertions(+), 21 deletions(-)

-- 
2.46.2


