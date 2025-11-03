Return-Path: <netdev+bounces-234915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26FEC29D18
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 02:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68033B03CD
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 01:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F2127F4CE;
	Mon,  3 Nov 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwRgezbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F627B4F5
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134666; cv=none; b=M9ce+NxbEFQgWa5rtF1yQap4jmc6G6MW2vBom8fxdhUci3o3QT5GHzxc9biWQWZi0WzFBmieOVZpRHS/NmkN2znWXpFKmRetxDY5Wr9t4+/Y5s6gccEMpm3ZOPMmwJltk3Pmg/NTSGL3wnJlEOHw4gtCdR5SEwX0sNrBha6VGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134666; c=relaxed/simple;
	bh=0r/UGJ3UaHLl4TwoicvZX0eMMWSJJZ+kcuaobIcvNx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uANX9DFxKoEVWBYG/XZHB42NYWhtCAg3MPlEN3ev8MKxopgcAuDBmJsUYsA6GrheMwzKdKG59jmSedyUCwXruO1WWbkk60IXQhk4FTc8op5nJAycdR0jtJateIuxDnYZK5nAvdB7m4NAUApDq7o46GrAAOz55mWqTv0mtAPkulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwRgezbD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7811a02316bso3051191b3a.3
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 17:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134663; x=1762739463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KN/frS9jg4jcQJc1DwfaOMBwxNMdwpEGRN00rohe3M=;
        b=EwRgezbDlhoWcprUkaNEHibHFGQ8dNtgj/2Q028Qf8vv5WZnvFsAkRziTvSbnXQq8/
         Q0mHrpFuqfUMj2MZKFRYGIbHJi98zM84cE1zeRISng+g9+fObEceqZs528gvxbrK/RZ8
         oFNk6Fsv8H8ph5Cbxg++0eybjG/LIBQPi1W9QTed+kRvoinB7cH2geboDc9ZaQPX6gx3
         Ns6LUfV2ZUhfIGjTGrXpGERnyS+bgJdLesSk3NRd2fm480nDgt7ykrc+YBuU+ubhJlwv
         kDd9HNikS2AMwCmfyf1siOztmltQWabtukqAHeLRWgguVSwX++3tzPt124SCAdZd4AlZ
         HptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134663; x=1762739463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KN/frS9jg4jcQJc1DwfaOMBwxNMdwpEGRN00rohe3M=;
        b=ZnnYqDLZXf3wecWgULe5JUHnLYKGsEPGMiDDlKmV/7oxUpx469ahsqHG3RDx9upuXW
         hLAskE7EZAST/X9/QyzvKINAtRT5YYSu9Xb8um5JvHltBIPKFah9xogNPxms5I33clPR
         5vo5fzH2d3J0uyMgSOME9+vaD3FImOBOFoSLOuQftC0t4bXHdyb46FLaxMFah06alExk
         RRBI5r8eM61U95d9DhBQQ+btODB6jZWLFUpfJTkLSQe0tCKQM9ZfhWX1sEQ+lYiXDquL
         7iP+ResTnM3bxwEoi9QAtTGVBabh9XvVH8U+rCMRajjpRnZyXgtjMQCWnPIET+Nr5ioi
         iQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCUXqE1SyBnqrKa/1RUnINgAjDvc01hd48EOQWWTo1SeKB2n78Yo2heToQTmsivw6357w5mS11E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DGCg1e+12AAaVb13NNnZ+KlUx/DwdvToZlZRKtPgxwbp8Ny7
	dul3hMzYQr6BHtwmAXntJd4Y9UFRLhnm++cvJRtWLzR7Lw3y2hEAwJaf
X-Gm-Gg: ASbGnculPazB+SMPNEO5pByHDXWofEVXFXQUF+49oc/caP/HOC0tjab1LBTRnRDLf6Y
	lIRvmyM0uD8zqS47J9U1muNEUCGHaMNfx/Cqe0ZyXl3WOOWLqgn6I9ormbzIvaEB4H/yGkoM+8V
	3NybYzvKsgSg7AnrkNH60wPSOzcgFs4pyDoT61TiHcu5al387zoD0TA2KJexUyVvf294/Cmu6O3
	Ceb9+SaJJEWIo9jOITh2Qvet4Oge6YXvw31aShYQhh3o7GnZApVZN0A9F7uDxSjdZCQA5piX2Nd
	E1rVqC+TKMV24KIWpWqcXPoWKDqsawdJfFanJPshHT8dyeudbk4xn03XQUw6oGybNOEN12W86VD
	nU1TAUI09kaqnDYTrjUH4tA9h6AWyWvINS3kHo8ndrAPhgw6NmBsWWkkc1Ki7t+iEQrYKhYFsGY
	KhGqjBaIrI/Yg=
X-Google-Smtp-Source: AGHT+IGD4WRREftRM6ToUw5Q5yEFGiHtK4Gw2g6ae24ZSedhjeRUUXh9RiimnhCWPd2uKN0IPOjeMw==
X-Received: by 2002:a05:6a20:6a08:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-348c9f667d4mr14767943637.8.1762134663232;
        Sun, 02 Nov 2025 17:51:03 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db87340esm9078805b3a.63.2025.11.02.17.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 09F9941BEABF; Mon, 03 Nov 2025 08:50:58 +0700 (WIB)
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
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v3 3/9] Documentation: xfrm_device: Separate hardware offload sublists
Date: Mon,  3 Nov 2025 08:50:24 +0700
Message-ID: <20251103015029.17018-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=bagasdotme@gmail.com; h=from:subject; bh=0r/UGJ3UaHLl4TwoicvZX0eMMWSJJZ+kcuaobIcvNx8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnBX/m7b25d7r3tVfKtM8QcHml1VyUNKF9cw7funk7 tpoyfq3o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP558bw331326LAFd9vrv4j 17Xb4b7jk9zE6E+z64qdjpRdOnpbOISR4dWt0xvu2HB9cqlRfZXM8HvOdof8bsNQl8i7SbuCfr7 I4gIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sublists of hardware offload type lists are rendered in combined
paragraph due to lack of separator from their parent list. Add it.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 86db3f42552dd0..b0d85a5f57d1d5 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -20,11 +20,15 @@ can radically increase throughput and decrease CPU utilization.  The XFRM
 Device interface allows NIC drivers to offer to the stack access to the
 hardware offload.
 
-Right now, there are two types of hardware offload that kernel supports.
+Right now, there are two types of hardware offload that kernel supports:
+
  * IPsec crypto offload:
+
    * NIC performs encrypt/decrypt
    * Kernel does everything else
+
  * IPsec packet offload:
+
    * NIC performs encrypt/decrypt
    * NIC does encapsulation
    * Kernel and NIC have SA and policy in-sync
-- 
An old man doll... just what I always wanted! - Clara


