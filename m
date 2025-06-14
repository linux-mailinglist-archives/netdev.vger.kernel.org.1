Return-Path: <netdev+bounces-197845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E2ADA04A
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278187ABA36
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306621FDA8E;
	Sat, 14 Jun 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKRp4jHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0C1E378C;
	Sat, 14 Jun 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749941642; cv=none; b=YHLwGDbS3rI2B0vp3989rhZ9pb8CNErbk/rlPopdIWpnXWYMrfVK/cwNP0LtpxBkcSV31dAw5scYo8eyn1eCVHCTY1L9xuq+O8A75zs3W7XmPsvYgzyq+2pLcJMjYQHX0ddf+YoJgG3nhoeqjqiiqX2nMNDePtfkvI/gNS+2oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749941642; c=relaxed/simple;
	bh=zT5Bt88XG2yoLSSBLBbXp2kHahf3mi2Wx2aE+1pfqV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfizXojcOFvb9SHKlLur+wc70KJmLTyeuMbEoMC9mSTRb2TZY4pezad6BDuD2P+QnzcyZ3mAbR+O21riXn1wEIDIuvAGdO2xoQGPKjmXmu/I5DavCEt2dfMNslWRtDjPdp86U5bc2OFxf8fVr30OxVOb4h2rxxE6UiT8yiAxSOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKRp4jHq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4519dd6523dso4262525e9.1;
        Sat, 14 Jun 2025 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749941639; x=1750546439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZAQB5AlBoL07khNC9vbJww4NhXkobEbHOnm0PUs/iQ=;
        b=PKRp4jHqRnIhbANEJjXCTpCR/FIcX2Y/IIB+tIAEck7rTBT/MTr9ZH1QC/xTBNfwoL
         ggpVmu+F/U+cjVrou+LU1o5v7rVDHMzg2wa/2WzmZQGr73oc0WRzbl+M/yXKaZraVGvJ
         CF8iLPV9raaYqWREr9t/vldSbk4Zv3OkxarPvldbkp7ojKJAtAyU3DWgA0v7m191k9YL
         nzbKaktpVeMpufpu7TIrH63GWXM0KwidOLehtqXnH1DWJGLjipYpu5Y+2f3tS7574wxs
         TQMnwFP1DS0VAa7f/mePvvjlktZtYTU6ak7fQththSMGbpz2tVUSxkptPiNmgfSCpSKO
         nq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749941639; x=1750546439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZAQB5AlBoL07khNC9vbJww4NhXkobEbHOnm0PUs/iQ=;
        b=fubkLLJZjSZ+xy3n7uMPd7/VpqBdToZliO+sbyU5JMvAHm3AmGfhcsyMIP2e7weSMe
         Hn3A3AR0v7BprJsZo2SFwAWkv7GkfusZCrCJJWeQJWtovng6T5t/5PaqlRMx50jXun/H
         uhapT2H5kaDdDAVTeTemtd9Ac2Waj/Oc+wDmTllgrdXQTKxH11iCmS7z6Yv8uWit/OjT
         dX4trCedq67kFs1sVfe8UdedBx4k7obA9vjgjF1sGjauVbPjORvyKRhcMl5ncOb6O8PF
         oFVc9t12Q7fDAx7O64AV091Rr5zeUO6FL8MJNwBGcGxR8XMUkbxsPvLMfWyti3jQZWB/
         872w==
X-Forwarded-Encrypted: i=1; AJvYcCUFptfg32A0My7ZQ085bWFaE7SHcfbDQO6ILAScGHhJlkE+AfE9U5oaGXRixgSNvPnjBJYZjKavHdzbfzc=@vger.kernel.org, AJvYcCVr9sL/rVatkzwxDjWQw8OxHCj3wpCfO8xFRqgVLtJ2LcGqxw8Ppx42JzyEsr4y9W6BM7Hd8QTJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjV5TPKtnSuTReiw0pcs8AqnIm3gOIK0BXJ3wQfG5w5Ru9yt+
	NDeus6Wy+pRFPjHeKYWAofBAFhem/XqtZPFcr/B2dWkZ3QGRv9igMPlt
X-Gm-Gg: ASbGncsgeqDI24kqkR8+8qW04KIDPYfilvV7UL6tuXdbaK2Ru2gP0ViG6zK6PKI05GI
	qQtdiYNUzHdsTZz4UrCcQGRYilsCccOj0Or/GBwYXCkvne2Bf2VxNfUQpmEqNGkcyy+wSRz1S1f
	RUiqPIhDQGyVGXQexDC7bIH8Lvkt7agjJ+D24b7jFoj5kFdSIKeeY4iBO1+XUiZ3oclhbEBywoW
	H/UXBYrl7+VX/X6cCczB/ldaab/QQharM56K0BOKTUL8g1X2Jr1Q/yy1vEPbZ+txmIo2vQ1wRmk
	bpeoxJ5Xy16sbYSvtg5gLZJdH1HEtcDtvNpGQkB9gElKI7MD22d+BIj/DLvzDbSw1nK0fOLb8R8
	gUOdd2Be7yHCyX4q9QPTw/40=
X-Google-Smtp-Source: AGHT+IERaf2KZh+GM+zOFbKtCwqYrbRWYEK7uzMmHXxZBDqX0TAJ4g7pG5vidf55uXrTDNBtsHDGlw==
X-Received: by 2002:a05:600c:3494:b0:442:fac9:5e2f with SMTP id 5b1f17b1804b1-4533ca4b453mr15175775e9.2.1749941638558;
        Sat, 14 Jun 2025 15:53:58 -0700 (PDT)
Received: from localhost.localdomain ([154.182.223.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm94897025e9.23.2025.06.14.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 15:53:57 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.com,
	jacob.e.keller@intel.com,
	alok.a.tiwari@oracle.com,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH v2 0/2] docs: net: sysctl documentation improvements
Date: Sun, 15 Jun 2025 01:53:22 +0300
Message-Id: <20250614225324.82810-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up and clarifies networking sysctl documentation,
specially the boolean parameters:

Patch 1: Fixes typos, adds missing defaults, and standardizes 
	boolean representation.
         
Patch 2: Adds value constraint clarifications for parameters with u8
	implementation details , fixes typos.
	
In this version 2 , Modifications were made to be more consistent 
and more boolean representations are fixed.

---
v2:
- Standarize more boolean representation.
- Removed inconsistent white spaces.

v1: https://lore.kernel.org/all/20250612162954.55843-1-abdelrahmanfekry375@gmail.com/
- Fix typos
- Add missing defaults
- standarize boolean representation.
Abdelrahman Fekry (2):
  docs: net: sysctl documentation cleanup
  docs: net: clarify sysctl value constraints

 Documentation/networking/ip-sysctl.rst | 117 +++++++++++++++++++------
 1 file changed, 92 insertions(+), 25 deletions(-)

-- 
2.25.1


