Return-Path: <netdev+bounces-194498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA2AC9A76
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E279E621A
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE0223C51B;
	Sat, 31 May 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L78DU7tV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75A23BCF5;
	Sat, 31 May 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686403; cv=none; b=ujKK9PnWpfb++T7HRuthB/i4zNP5i59HIoEu5tddE8DWNadnAedntjI1ii2NIMug8zbNWGfefqVLfSM7KmRY2FvQ9utpeJtXjvtNZa5nTfvSuojtvek9xmH/Q71tVTCqSkqfdssUu0+o16D+3JcEerv6n+faqNCIEHzPDuZRZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686403; c=relaxed/simple;
	bh=XVFRmgV0pGlN9XIErmdanh5MPfLR+GksS2fPkb/Rz7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZC7+HFYXAMZQSQAxS2RTGs2DaJwwxOjrCXZZtyNSr9vHVsrRUgA6E1+If0abwEOhnGTWPagNQZlBEDeastydrxM/gUOk3dGTA3HGKC24RW7+INXQ8hrObF9OkvIKVZDlctGtgYPD5Vg43faRP5QMuAQlrgIjXJaBFqQ9GeskrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L78DU7tV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442fda876a6so23338265e9.0;
        Sat, 31 May 2025 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686400; x=1749291200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zvHYVvOURfl5Z7WOGmCpL3hxIkk/tIzVjNzrR9W/TE=;
        b=L78DU7tVGFTDGafj6fvSqh4uJ8ritHlqXA7oNcJD1E9Yu15gKj2STfD/yM/Ls965Eg
         Q1XptTTaGFtZA2uG1ccbSrkyKNscwAziIfQcggw8TndMQnexB+TKKtgNv2EP8t9amHeA
         Wtd0YHUyPd+C/38V0ceDz5NPj/kZg8oYDK1mrODAswMTtAjya+4xV3bu7AwKjD/pvaFS
         RXCuBhdirAbr1sMe944KzySaJYjW5wwt0K0TjoZA+sW7VwgPIRlm0+vws/n5LMUGctS4
         Dmw3frlMRxGTvlHsDOvnVzuLEwBFShpeXzC3+8vBFFcNMBhhBSVH3YDAcWePUzj8j8pi
         avyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686400; x=1749291200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zvHYVvOURfl5Z7WOGmCpL3hxIkk/tIzVjNzrR9W/TE=;
        b=tccr9zMJhDDAi24XrYN3x987d5gun2rGVVT9mqvjpU5fgmmhmhZ+FX4P0zc7t7SCJ/
         PD06L/8BNEBiNoCnT6aO00fn/I/cwcO+/4dW5a2vxVQJjQo0EopQ/gjsOxXaqhoDlFRF
         4jx+YXef44PDqUp7SvH4H64VmUFBhBBtKvfM6HVAD8C+aO7T9yxG6/Qu1p1WeN9Pv9Tx
         W8R5IL0ii4mRlm5PpTL2sSk+CInnG+PqYMVhSB3NULZIb+q1oLJCGC1quYxXakTjE0OC
         RTpwNFwyua39376XnTgGZG5pPMzLPOxXa4c//QgwfCDTpXBALeq0iRuPPRQLt3RWEA2y
         FmxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwH3CZAWH32KmFdYhilha9zwTs/txKVNX3B1YCw/z88LLlU7OQ07y1i45veZryriS2v8TUlDG8@vger.kernel.org, AJvYcCWBtb6jUVitDxz4lbQCsvzMq13FVaMcPn1Rqwf5k/tMcFmt97qvnZzjN/XzMMsYeJYGRHcPH6MRKhH+zrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycamT4tkG4UCE95g0sYiedGQY/p7IWpCNoEMQAa4KrvfNeZdGs
	0i9rTphPSTISscaT2PBp10i2nf3rWKaZ02Bfwy17X1NhEy1cDlV5vMxN
X-Gm-Gg: ASbGnctemHd+ik17FkiT4R81+8d/ANoieOti8CEQW6SSVBG0haEychgiUW2se2W0l27
	KxL/fL6hPithMroQ72PWoRN6l3prFp8ov7ZTLuSqHgMYZjxgQCN5ODlQrAtO4BXslWQlr/ce3/d
	sQJXdaIOQc7pkuxo73ct8gIu7shIA81DOYX8uVvJQGi1pAG/K7Gr7rPB7Qp+fJsH39+SNtbGOWp
	XFZxAddS8TKAluwHv5N1qPdx6gW0NBJuAvgpRHM023JhSIE5A9mBEUhN1MfzPDUOZRR5qFXMtkS
	1YESjvgYIJKTeSuqT7OuhRxmFqqiY8IHco98zO6OijW2JN6yLoU9M0dX8a9K/kJhc8/0z6zAk0P
	ZFptxXsnmCc1sRVvy4mmn+QHFdosd4rdxwvuKKNonXM34OdUBQDO+
X-Google-Smtp-Source: AGHT+IG4SNj2HROMxyKZ9eRynGDDh4tdLTRworQTBkztDD0g8LBmHj9vpDxasmNoOqQFAfXPQubjzw==
X-Received: by 2002:a05:600c:8287:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-4511ecc26a1mr16471375e9.10.1748686400370;
        Sat, 31 May 2025 03:13:20 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:19 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 05/10] net: dsa: b53: prevent DIS_LEARNING access on BCM5325
Date: Sat, 31 May 2025 12:13:03 +0200
Message-Id: <20250531101308.155757-6-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement DIS_LEARNING register so we should avoid reading
or writing it.

Fixes: f9b3827ee66c ("net: dsa: b53: Support setting learning on port")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 6b2ad82aa95f..9667d4107139 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -593,6 +593,9 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
 {
 	u16 reg;
 
+	if (is5325(dev))
+		return;
+
 	b53_read16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, &reg);
 	if (learning)
 		reg &= ~BIT(port);
-- 
2.39.5


