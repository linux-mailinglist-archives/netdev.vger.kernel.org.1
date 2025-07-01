Return-Path: <netdev+bounces-202743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D05AEECDB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57F11BC46CA
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66381F4634;
	Tue,  1 Jul 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amjmgf1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7441E834C;
	Tue,  1 Jul 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339593; cv=none; b=T8m8MM40ouFEkkbfgPyfOgluW2s6dA/0olw9FUAKrZKhN+ijQJuQ6ldPToBXVLP7btMlee3wZ1JVcvihwzaLKFXNGTjmxPdYyLW7tmZGxv1oTl3a5l0aWFjzr0lWfnxkPiEhIkAiwwwEmMx6bSCEKtcKZM9SkbzMfc6aMUgubSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339593; c=relaxed/simple;
	bh=nS/NTSuPs88jg1URWrCr30ZzpSYqdiIYV17z2elsRmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arVVsw1xXstw1+Ag3hJhWqsbRUUUAUtsLCzeahApJErPxjNOjzjiVLg0XIoVeCMferhesLxywAluQ1upq3i19sFkzWIgrkHQ2KR/w9UN04cdJRH56OVpoDH0UMgWo/59t+MqCfxHbJrRtV1rsk5JgJrAU68rdCEECJNr7hf9nqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amjmgf1G; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so2062282a12.3;
        Mon, 30 Jun 2025 20:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751339591; x=1751944391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5WSgjCKP1WBN2c2e+KmwFrodJbjd4SEl3Pp7kvf7f4=;
        b=amjmgf1GUZztOomJjkTtPUcjO3UlV5GKphBf2UAYkDduVKJGIN7vZgO+r9OQ7s9f0r
         BySr5y8kuL6ou6f6og/5+LeuKbc31RvAZJkov7B6amjTOkYBORSyxfBLNe2nQO33dZbZ
         lPgRcfhMat0c8/8yq+I3VP7cPZ47yKRGGJprBL8x4pXLR+RcOB2BJyRS3Gl2cycLLoh9
         x/Bx8Ry86tHiUfcade4UZMvVO+E/IzX5Vxo3tQrp35ylVSgal8fq+fmeN+SKJkflyYL7
         PxmMU1iaHk2vbPku8iWCJAR8ItQavhoyxtl/M0L4aTsSSTYN56Ojb6ZjT8EsGCAYhu7n
         EBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751339591; x=1751944391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5WSgjCKP1WBN2c2e+KmwFrodJbjd4SEl3Pp7kvf7f4=;
        b=hRCKAymdHbQXPDsUD63+0oiAdpef3LCaGR4lfJqDjrIpek07tHJ8sLnn1wVm1+97/b
         /eNvwhaw2uJ1goL8+R1FvLeq5B2CJoZEoBofwzs/5gvthQEFGeRL6ui+4XLG+2HnNgT9
         WO2U954APTM69JEUiqDkFBSg/rgM6ve9urT08tszu39Q3blK3jlYv3d/V+ROS/iqWiN5
         BfJ3mc9G/u+SoSxEdeT1OjnDg8w0n9rOoyssA7pM1KGxMQnIkBNdrPfRYf2g/IE3SFzB
         pGUlzwX9d+GNaxS7Bd45A5tNWXTtT2s8QLCLgjXdjpX/kg057ERY4UTOK9NRpj7yR4u6
         +vmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0rTi4mflVMggf/ybBP9hyCz9LO0XOwljC8Xf6xRAESHBXS07+TBccfDtGAsEFykcWRWGbMxzHeq0=@vger.kernel.org, AJvYcCXKvj+bdC6b9FMow9jw4DManuYuaLUKTx8a4Le3/xCdbvl88ShIOYpESNyThTzsRfZKevI90+9T@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6nyVJoh/MeU4ewZUV5pS5hJS1mP4wK2fkf2aWmlra6DNikh1
	XYBz40k3t1q0l7JJdqCNfbAivjzCsZI5ejRm+1EVirkIHqP/On9YDQt9
X-Gm-Gg: ASbGncvBSZ5XIfM/2oeITyNg+iwTc4jVu4SO0AlYjoD64qseCc12fElWVmmU6+9LHbD
	3tuCIk7vOqVZt0C9eKaEnOGXP2cc00vS8FE7joZEWZ4vF+Prtt8Xh0YchI4kvf5d1L5lo6ytqZP
	fedHJRMmA5RsZGkwNJMFMVgavkMSd4YntvTJQK/3VH9Zygvqc7SnEqCKqmJ0fxmpJNj6lFVc/x7
	GJegTIYYSCKzLR507r1KZt4n2wFRRqYDtZ1RkGb4XcCQWfUecu+n9zFdGPKhhIgmOP37YGAGPMQ
	Y2wwwKgasYaHB0BkseCTTknfYkZQJtZqJuy+qa0PB7abVGLRifsFd+t5sFquCg==
X-Google-Smtp-Source: AGHT+IGsbHbDLP4vTSZ831gE0/BF8Wg2PYwslcfB+I390l+J1xredhihPZYg9krTcJVKSQL501d5/A==
X-Received: by 2002:a17:90b:1f87:b0:311:fde5:c4be with SMTP id 98e67ed59e1d1-318c9316409mr20798224a91.35.1751339591271;
        Mon, 30 Jun 2025 20:13:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a15c2sm10054694a91.12.2025.06.30.20.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:13:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CF556420A82A; Tue, 01 Jul 2025 10:13:03 +0700 (WIB)
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
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 4/5] net: ip-sysctl: Format SCTP-related memory parameters description as bullet list
Date: Tue,  1 Jul 2025 10:12:59 +0700
Message-ID: <20250701031300.19088-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701031300.19088-1-bagasdotme@gmail.com>
References: <20250701031300.19088-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578; i=bagasdotme@gmail.com; h=from:subject; bh=nS/NTSuPs88jg1URWrCr30ZzpSYqdiIYV17z2elsRmA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnJ/sdMz/H4b2FgWvnp3k27m/cFFF4k9FR27t3cuuV7r Fy0t9i7jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzE4QTDP8t3J40reDRPP97m +iS3K/mPxtY3Olun/Z//kpdDIkJ9qwfDP7s2c6kM6dorTI9K513N1/868YwXryZ/2D27FZvP/2N R4AEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The description for vector elements of SCTP-related memory usage
parameters (sctp{r,w,}mem) is formatted as normal paragraphs rather than
bullet list. Convert the description to the latter.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 774fbf462ccd65..12c8a236456e4e 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -3542,13 +3542,11 @@ sndbuf_policy - INTEGER
 sctp_mem - vector of 3 INTEGERs: min, pressure, max
 	Number of pages allowed for queueing by all SCTP sockets.
 
-	min: Below this number of pages SCTP is not bothered about its
-	memory appetite. When amount of memory allocated by SCTP exceeds
-	this number, SCTP starts to moderate memory usage.
-
-	pressure: This value was introduced to follow format of tcp_mem.
-
-	max: Number of pages allowed for queueing by all SCTP sockets.
+	* min: Below this number of pages SCTP is not bothered about its
+	  memory usage. When amount of memory allocated by SCTP exceeds
+	  this number, SCTP starts to moderate memory usage.
+	* pressure: This value was introduced to follow format of tcp_mem.
+	* max: Maximum number of allowed pages.
 
 	Default is calculated at boot time from amount of available memory.
 
@@ -3556,9 +3554,9 @@ sctp_rmem - vector of 3 INTEGERs: min, default, max
 	Only the first value ("min") is used, "default" and "max" are
 	ignored.
 
-	min: Minimal size of receive buffer used by SCTP socket.
-	It is guaranteed to each SCTP socket (but not association) even
-	under moderate memory pressure.
+	* min: Minimal size of receive buffer used by SCTP socket.
+	  It is guaranteed to each SCTP socket (but not association) even
+	  under moderate memory pressure.
 
 	Default: 4K
 
@@ -3566,9 +3564,9 @@ sctp_wmem  - vector of 3 INTEGERs: min, default, max
 	Only the first value ("min") is used, "default" and "max" are
 	ignored.
 
-	min: Minimum size of send buffer that can be used by SCTP sockets.
-	It is guaranteed to each SCTP socket (but not association) even
-	under moderate memory pressure.
+	* min: Minimum size of send buffer that can be used by SCTP sockets.
+	  It is guaranteed to each SCTP socket (but not association) even
+	  under moderate memory pressure.
 
 	Default: 4K
 
-- 
An old man doll... just what I always wanted! - Clara


