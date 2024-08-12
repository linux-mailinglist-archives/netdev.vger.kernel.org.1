Return-Path: <netdev+bounces-117817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE5B94F737
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412AB1C20F5C
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B371917DA;
	Mon, 12 Aug 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBS6IPgT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342B1917CE;
	Mon, 12 Aug 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489625; cv=none; b=fLlsBjkyojt+OAqe2zEtzkieu++0lK0i+uvPAu1TMypEw1gWJDPk+eq4eFW/BBErRdzpJkGQTLtBv25qwtOKGQDGIWduemk3ud9VyqCB5oEoyuJzYSt05ulZepzlsiBgbwqutsC2nOxK7msOSLD1W1TOuCsqxwWSvPVkeBgzM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489625; c=relaxed/simple;
	bh=rJ+QuycrY1hJ9dMQrHVutnZn7hr1KoDa3nJRnl5fAo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgbBmv8LmHk/Qlm1IJDhpWv94+fkFSJg5tepXxZPBzCzfjtYuGPjTw2T+V5tmKOz8rN3bpqHM3Hsw4kR9FjiWaScS7l4wu1pDVzutYGWRadsJHLzvPSsuqGFPfyknBazXj75kot+J4bc7d2V4xG/ftCLXbXpT05VztHOLZWrQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBS6IPgT; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f905eb19cso235425239f.3;
        Mon, 12 Aug 2024 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489623; x=1724094423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujEXrLD6iO+Ri/Pr2XRp4rd1UPKLMSXQeTMeA9+ZOL8=;
        b=KBS6IPgT5oXcxzDBJB9n6dMkMYaZZ6qY3VA8eJuz5pmb0KfFIK59rL3vYpH1QFLTpx
         3YvWZ4C46YUOJkDdb2iC1QRE8b+5qYfduaXLpldlH+gJPy7KAEBrAeFYTQm+VA4sFe1G
         wluwwLgOCoYC/nYwlwkLSF+cC+9RAV7yMx+YlybSoG1pbshKj+Z9yZzyrG3HRmrygEEK
         bxdgfTqNl2ZpHQ8XCQML9xWRBPAkPpRIcJE4OQnSYVyqnaA/Rxo5kKZ/EQQj3H+RAw6A
         kp/1xZaFs6Xp55esR8vUl9xYyRVk+QqOW33zupQfFHLthFHLipLUV4IQVl1Ai96HQugV
         vvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489623; x=1724094423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujEXrLD6iO+Ri/Pr2XRp4rd1UPKLMSXQeTMeA9+ZOL8=;
        b=KjWaN4e+Ucv9z1kiXhIXA/BflE0PJ4lE6kjPDDc5LAsoYVz3gKHLTgttPU/DkfSyWI
         8ZCbaUWqVOv64xf+/+UTsRK49V+ZKhaszp7iM9ZcbWI1/q5ld21oxzuqxuR73SZQCRDX
         c7p5BHGNTaMTlgvVrtLGsmEuJLGvgCNzColOXzDtBM5i3oqz1x1p9qw6/RaGOAD2oExP
         WAlvWqlPvcQJi7T+7dME57GD0+g5dro9+1llICEfjvCQ4wJDftv0Y6vbBn/ougG5gvlE
         rpLQndhz4Dd6BmdTnVkbTFclsLgK8rDppjfgMPUNiMUsQTLZCp/yM2PkrCnA144J/wPh
         oipg==
X-Forwarded-Encrypted: i=1; AJvYcCVeUt/4ORikqFNS2v/KmBa08H+kKZ9BTDxmdLabZZllSNB5AtIlffnpO1kikScFuykGcSXsxULtq6LXMvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzQApuAxtdpK48yRem1nDzLiw1zreLSrzoauJ7lsGXWGDPZDQ
	S32mqj+TnMOzpBn8NlGNbdrhIe8dknoFRFPyj0GZ+R+thHyUZht5HDigL67G
X-Google-Smtp-Source: AGHT+IEx7Z7SjEKvdw98nSK4KbvEUlwgObEAPEWnt/ec6q+UmiwZQJX9Oar3vuAj/iQWHponnIPdcQ==
X-Received: by 2002:a05:6e02:180b:b0:399:4535:b66e with SMTP id e9e14a558f8ab-39c47837ed8mr15009825ab.9.1723489622883;
        Mon, 12 Aug 2024 12:07:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a7facsm4334495b3a.59.2024.08.12.12.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:07:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next 0/3] use more devm
Date: Mon, 12 Aug 2024 12:06:50 -0700
Message-ID: <20240812190700.14270-1-rosenp@gmail.com>
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
  net: ag71xx: use devm_clk_get_enabled
  net: ag71xx: use devm for of_mdiobus_register
  net: ag71xx: use devm for register_netdev

 drivers/net/ethernet/atheros/ag71xx.c | 84 ++++++---------------------
 1 file changed, 19 insertions(+), 65 deletions(-)

-- 
2.46.0


