Return-Path: <netdev+bounces-227713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197ABB5EA5
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 06:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A883F4EBDC6
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 04:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E081FF7D7;
	Fri,  3 Oct 2025 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzEl4koh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212151EA7DF
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465946; cv=none; b=r0fQ1DdtmVBPQcZHK1GWiW78qI9OkidNqmxcz9qXEeBjoPzWOGjZ0DJEdoWWdgaDN+GjMAI+/ahRaoieaeZiUZC9g96xxQw6awI2nd06y5V7u/jjuv2z45KE6Z0IZq8/+jjui7HUnT8lTWyt26IzAPSKPEX32l7KZXzpvW74Nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465946; c=relaxed/simple;
	bh=Bl1TRunIta5QQDe3lRPwonbH+J8i9iNM2VxNxK/XmSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf7KfD1yGc8ND4Cy+4MVHcftxZlHVuNC0jovSfDUqVdui62QtM4PYS/9JKyL8ymrs6ao2WC5VrW4C3AdkNePhPHmxKqh7vR0q8ibRO1hENjlmurWPU7HMtXtuTh8OswS0rONimlhL2CxjZkuCl7nEWFIIL0bc4dKSd4mWQrBCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzEl4koh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33067909400so1340218a91.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 21:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465944; x=1760070744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=;
        b=CzEl4kohMhiLGU72A5sArwP+L85QrX67hhJCG3zfczH5RdLXwJ0vzTKv8GqcLt/vu+
         1M3Aw781chc/cYYd/twjVhnvfx377c0fQo7ym4pFuL55xWQ+GxPGILVY1p1Q7YhqcI2n
         N53FYvgdCFEN2LLyxsaJJ7W7WQ55rWANY/ziMWRPFB7o7DiMbMaWx+kFVIWppCSpgMn9
         i11gloJmrGfnF656rGXnu19dPcCrSA8QFG9cc8iouylfpZZFrZlTSLx+ULenE+4rIrXR
         60LTItEVahVkLSp49+MPKEI7p995x4xnc4CGPdkhRULDj7et7w6cJc0yE1eqOa1FnIQM
         dqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465944; x=1760070744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=;
        b=lWeYB73K7LJPtaiJkSc7n3Jql02r3fh8W+yT93cuCKzksKnBcQgcAq3XESjyo2RSJb
         40p/JMES2GEjF9Uki9Sc5yfJBNA6wnDhehqzms4EQhthSX3G4Qv9mf4DsvKhxrv7H0vy
         etvFtA8QxEYzletfowMHIWxPP4uJ5kD6mDO5unclwYsBR9/Rr5gfKpReHbLgQXEQCpcA
         rAy0PN5iXj8h0ex1Ky4oNDxFsiuRz3x4gOYR5X7XyuciEGr6aHy8g97HQn4NkmLQxZH3
         VO+L9OoQZsN7+MB23A1AZO30dQysk/Wxks2Sg9X1sd+WcWe4uC1P2RDbMkQWmttH3sjw
         YZAw==
X-Forwarded-Encrypted: i=1; AJvYcCXXLJiD43f87frrXGLGrALjdzVW4aa+lFwFUfc+x5l/SMduqHRNIEE8sEZ5J8mfQBJAOIB9CJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8EL27AjAftEVSA8gceyI5IREvI7SAueGe9TLF7s3zxDOkQ19
	lPGtBzT0I591+m8KMHNhom5OwmNOHqQmFNJySsNDwKNhNEQg/A7DFq8w
X-Gm-Gg: ASbGncvNkws5F+xqXgeYp5q1cFj5z2v3m+KyKgCl1AnOtTxCSEAW1oIe65qcIKfgX1l
	1bHBn7JEbSzwGV1sBTe1Tj1cHI2C/uUPruj595qoNbfbwcaE2pCGZ21+Jdr3cTRdIG2BiZ9O+VL
	kbTcGmnFlNhSuHg4tWrl7kHW8L77j7eIfYtGLjF8AOhy9/mBCngjZacr4D/pSQhoMGFFWFltLlB
	b3jgiZusZDrSclhsyE0DBgAhE0N6sz5nG0sV8+X2VqdMnGNGHPDcEHW0b1nngTeW+87ZBtB5PMG
	J5yPHi20ojoQg3m5M6Qtmru3stYl1oB+sIZGwaCLXg8evKscV5i9jbqW9DVGoa30QHqCVYUvWgj
	x28Kakt9o54aA4zf/gwOwP5c1r1Dpjoh0C5dTIPFQr6duANCoDAHqurWCliOJJ/8nalwrhR1num
	tJABsDYOcOurSi/ZiK7udXJLFn57rGQHUuonVaIYO8NXpZYgRO9HBxOTG4PtzK8bA=
X-Google-Smtp-Source: AGHT+IGCDoUIKtDX/52HGaffkclK+hmjaIJ+Bue+zX3dUNN6Q+cAazG3rbJtO5YII+rQ/2wJMc8/6A==
X-Received: by 2002:a17:90b:1d92:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-339c264f452mr2016481a91.0.1759465944489;
        Thu, 02 Oct 2025 21:32:24 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on completion
Date: Fri,  3 Oct 2025 14:31:34 +1000
Message-ID: <20251003043140.1341958-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - New patch

 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 0d1c91c80478..194725a8aaca 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
 		/* Handshake request is no longer pending */
 		sock_put(sk);
 	}
+
+	handshake_sk_destruct_req(sk);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
-- 
2.51.0


