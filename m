Return-Path: <netdev+bounces-225191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A732BB8FE04
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D970A177522
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E938A2FE077;
	Mon, 22 Sep 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmu1dtDt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B72FCBE1
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535042; cv=none; b=UjNW0iYY/ZI24Xyw/x7Nbj0/rTtGwvBObEQ7W3fz0WduOtjX0zeVQyjTBLw8sWC9zm1QAF8bJyd4JqltJ3tyM7P7NBP7OrqGLU6FIthrC1Mq1mRANJznGr5DYFWh+5Y1W7QwT0eKxnkJnEmZZWbtAw4Gw9AJ9QWWTYziQcKc4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535042; c=relaxed/simple;
	bh=j+SwZchskS+hgocwMFiIRa8Uxuzs2JM1eZi5LFBUCrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2GkHsTWQ/Dkeak63NPvkQZqyHP8Y/P1FgfS4y9G2AIJBdoQtvQaP6cQuAiVTiZgIgbhp/Q/8zSJhkAqi0QIRFq9xw4DP4ienOz7E0VNQIw9S4kCUyzIE6QcoLiWgnzZtLXxqfX1aLtxYqUsxdwT5hF1elF3+MXp8gqV9RgEd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmu1dtDt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b55197907d1so1960470a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535040; x=1759139840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5IkhyO4d7SmeNeYV0oRf0k44lMRfG/ikZaQ44KxKsTA=;
        b=Tmu1dtDtiWTlG0mIkf4/SJo0hm7L4R/iW1WJwcHBOq2eCy9e/L5HS+QV7LvFcfDwFh
         JUAdxrTmRpwmbQhyey3is0CfODlgZ8dHVYh/WdMMHdNp0LwCKex07eSD9XxEfYF9lkGt
         hAeUs7ErAgcoPMdPU0qcyg/0m/2IjW2rGYKd5X1K4yLbq9vN0vw+SGKVebaH5HYbrVOy
         QRxGUOLQQItZ56bsjD/ZftIoGffo8uaY3oi8UbsmJzEAqg2mNAV9xFdPeWqISue89TXL
         1+bF/NntDGo2Kx1jKJ/bnIEZrvOAkqljjp7Cq+6XU9g0kqiLK5uuydW+phLA+cGFAgUH
         J62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535040; x=1759139840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IkhyO4d7SmeNeYV0oRf0k44lMRfG/ikZaQ44KxKsTA=;
        b=qxCvdFv+yNmPsFuOehGU7Pdp9mYZr0Mth1Biz2XqCy/eGhVcWXkh4rCR7SWpBxnb18
         VDghPEzb7XxmQHLo1Rp/IPRW6WwBDL1hhQMQC4xTEQ0WZ4XC6y/zSjhgRuwKUMw52ATH
         TVNpMCwTPX13gEhdqqqRXkG6Mm7oVzCabpLJR3uv4ICyL93Fk0bLMmkc3WzIlFOdx10G
         ue1ggYf5wniQnG9M+m1DhFu8pC3g3ZIMaXq5uKAP+ZBT97u4ZH/5kkrcAly9tlezmyVq
         d9GQtfqyKbYv7KRyGewq5j3VB8aw0ghgPqOVJiQv88qQYv7nUTmgm5S8vAY9BIJQ61cy
         +jdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXbK2CKqvwrRBo5ef9ElabeywAJ0GCG71ibsk3epOwXYWB8R60cGO5ZoxnN1JjBhCYRqbZMm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhN3gM3TTiOGvmbZys5gw4A5TuvEqyLDB4WJcE0FULbHMBNLeJ
	JzOUNhoOsAqIc6hrdWASREk2jwEZ4xE3q9Jsh5LRh06hoQ1f36VWIsHm
X-Gm-Gg: ASbGnctZQeWaGSgIsQV9eTaKm4O9CyjJYmJXc0rrdT/YoIcO25W1pncSlHx/u+4K+UI
	6ILmPJdSmV7FaCy4BmitKxBI06qRMIzzNpiX0oXTDaQVSErOP1cNn92BayA4OwSEklGpB9X1Kwh
	zwpOKggHM0lcYIVDTCepqoXRX0hnHOXkiN65EJ9Ub/qbgqkviI/7qAyiOP0vEZLPyKdOjXdr5V9
	KF3hWvoB9vANooV2/6EVEEf1bCbxjIe56qHStOiz9MN/DWoMPzsA5dGzxc69knozDoCgzqJwL8L
	IM+AfgzSi9/k64kMuu0b73pHHacS6QV342EC+sPEN4tANxaGI22cUwI8P5WZvIjRC1M4ItBeHX9
	iT9w/N4nP+uIe5Bhp1L/o4A==
X-Google-Smtp-Source: AGHT+IE0L4SYOwQ/uM3LnAmOPCX9ygYee8Po6u3FqQ5+SV8o4TZTjmsp+YGsJEqc2WdyRLMWJne3sA==
X-Received: by 2002:a17:903:3d10:b0:269:4759:904b with SMTP id d9443c01a7336-269ba57eeecmr157896775ad.58.1758535040355;
        Mon, 22 Sep 2025 02:57:20 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016bf96sm125292965ad.38.2025.09.22.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:57:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8F7E14220596; Mon, 22 Sep 2025 16:57:15 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 0/3] dns_resolver docs formatting cleanup
Date: Mon, 22 Sep 2025 16:56:45 +0700
Message-ID: <20250922095647.38390-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=580; i=bagasdotme@gmail.com; h=from:subject; bh=j+SwZchskS+hgocwMFiIRa8Uxuzs2JM1eZi5LFBUCrA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkXZdan7t05UVlVevWN9WlrEldqvZDpXhGh/1X6ea3vZ NY9zN0dHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIozeMDLuKDj3YpXowoPzW 1ScGoVL33lR+VWfjX/M/szb1nImL41eGf5o7f7qFlb+Jbt/ooxlwSV8ln+2T+mxlJbG6hRcYnlY acwEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are reST cleanups for DNS Resolver Module documentation. The shortlog
below should be self-explanatory.

Enjoy!

Bagas Sanjaya (3):
  net: dns_resolver: Use reST bullet list for features list
  net: dns_resolver: Move dns_query() explanation out of code block
  net: dns_resolver: Fix request-key cross-reference

 Documentation/networking/dns_resolver.rst | 53 +++++++++++------------
 1 file changed, 26 insertions(+), 27 deletions(-)


base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
-- 
An old man doll... just what I always wanted! - Clara


