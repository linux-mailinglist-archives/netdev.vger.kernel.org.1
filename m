Return-Path: <netdev+bounces-223576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74E6B59A5C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855A72A0A8C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F8832ED43;
	Tue, 16 Sep 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dan87C+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DF324B1E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032814; cv=none; b=fyImyL5V5rsk+s1xDNKr3a7ZaXWUPLHyPijSPCYGKv7/wpv2O4vfSiXbP6pBh2aVbh7em4ny2iJuOEGlHeWuxDSzOm+63ijOqDAUeX4/8MrquDflI9oxWZ4mLCggWtt/9wbTT3/OsxMQ9viNBU/2BBko83pzjt60vU91yrzTeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032814; c=relaxed/simple;
	bh=g4MftbRK97uaPTNqkfHTpo3XTx2Uokw8lxGpAx8oc3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Srty16qZ7Q+NCK7JfXNvOwImPt1A7vtvYFThnA66JPIL6TNebG8A/IrW7ruytscXAty0ozDgEhhkCkMKfl25//k4JD8o5ujb/Ge/hVPOAij7YRG/sSFK8ZZyl7P75s4zNwwvDhqIgfr3XvIJY3Wve4KOi6bplQ6B+854AYY41Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dan87C+t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so53101615e9.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032811; x=1758637611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5mPB/ajlezba9OcsHXolpRsK04nUVrxLVFQVFJ4vSE=;
        b=Dan87C+tNj/VwSJ3bMItpMMbTpShWGSXZKoUdPn6/3SPoCybQ6w4ZrNWxn0OzdFJci
         Tln+BrjcY8kndM1el+8sDkkjfh7YDw1poowtEV90iJkmKdRNkNUd6pEveayhVjpepXHQ
         lkKMcbrBYmWRbVTRRqBkfK2t4t2hZB8H0qPwg4/F3NY+im0GOzzQ/HMf4gYgLEzNmEpK
         ObcrmHit56T9aEE67A2WHFgNwKlH9uL3O7TTofx2OoBg67RUzWjA77lBRRijYCvQ8gaq
         fe3WaKtLytAMsTUtHjeRZ1Bwq4+5VXBmZzjvRgPTjulWFjZ3J6BSFbQD1TvCpz0hZmE4
         CA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032811; x=1758637611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5mPB/ajlezba9OcsHXolpRsK04nUVrxLVFQVFJ4vSE=;
        b=EGpYReXt3SwM0V8baJekjQUzpIV4UXaHG6hBM+msBkjlQ3cS93hXv2kw9XbS8VZGC2
         ytPWMfMnf2mvpXrP87sqeP0X3XBPPYkLv0bEQ2kEi3mnmc62C2Saksp6ipGG3ggtohdK
         IsoFXUtSBYCCrvEYg5L8AkmNg08c4gfGpYU4xwr39JzKnmehRZJPv3L5KzocrERtlMLP
         xl3knwcDvbSVpeWZw2yDpVDge4RoUYc7uBosCggEH3nOgM8lZjTMwQFRL/btSt+LBUQ/
         0kD67ymyLjq+RFkVVfGoVGcWkPAofDrLL2Ae0Ke/qc75X+ISW2mUICuMJUySmldRGEjH
         m4jw==
X-Forwarded-Encrypted: i=1; AJvYcCUNlUPr1qwKT2gg6dC/Q/lXY3fcRHTcXhm4hO+C+g0voNlwuUpdiV9mh4mF5M3vTHunhIUX31A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6aD2ROm0WQ2utUNH0wiRPW/iQcj99Ukx1Mtvcv8BlggpgKjS/
	OrQ02FIZ0OFiQ7sr92qc8QtrDIyqCPcI8hY1cBUSlxK6dNR3bW1qRcOM
X-Gm-Gg: ASbGncudDnobAvxTUpCORH22nUzP7ZkEgi/DSJhNsMmgffatr+PZePr/W68Sm9JcblB
	lA+UBKLQ+2Zy8M8y0URrCYAYNVWs9nXlzqopJKwqJYY9jeI5oxccxPhkJoXfcBgzf27yAALIdut
	bcY4sRCbzItWxrAIbwGcq7tvdJxrlzQltQtRf8gCivxCdWQHtvuF2G4naPM3537AsFds05s9cOW
	Krs5ha2ndh86LqBSrVlycWOSAgx9WQ7YONQZ/m2jrE8vf+4Vvh0Lrx2JEMeTFdpdP4Scff6wvTs
	TK3pNTTUCV2XFJ+mZs605tR0BKkiS4uV5N216AbUPovKIV3OOOnAyEvTQoS7AuBqqOTBgAXUWvN
	rFDjDOw==
X-Google-Smtp-Source: AGHT+IG56d3uwFKHBHEKA0hRQ/cEwgPlxlygLDJb71Qrd5b5Nu5WaVkE0Bo1D9KmfENJ2iet0EnN6Q==
X-Received: by 2002:a05:600c:6549:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-45f211efde9mr106819395e9.26.1758032811095;
        Tue, 16 Sep 2025 07:26:51 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 04/20] io_uring/zcrx: remove extra io_zcrx_drop_netdev
Date: Tue, 16 Sep 2025 15:27:47 +0100
Message-ID: <651db906a0c3eee7e83c83a9d4edd6260c0a4413.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_close_queue() already detaches the netdev, don't unnecessary call
io_zcrx_drop_netdev() right after.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index bd2fb3688432..7a46e6fc2ee7 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -517,7 +517,6 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 {
 	io_close_queue(ifq);
-	io_zcrx_drop_netdev(ifq);
 
 	if (ifq->area)
 		io_zcrx_free_area(ifq->area);
-- 
2.49.0


