Return-Path: <netdev+bounces-64851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE968374D5
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259DDB27F3C
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF62D47A74;
	Mon, 22 Jan 2024 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="y2g78O8x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6047A6C
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957584; cv=none; b=BViN3qKcKqyQqT5F3OzJBVbX0WOtVUIY6bUywQFL9ZiEZSuunRdBW5UT98XEfWF9OYHYATzqDWd0DC3HHkGTSWrjm0dzQTGBKovG5uucSGQXWUjylexLCVZW6zowlhdBOw6bZXJ/xDGuSUnz3AQgb9HtvXd2bHovEsimf2AjZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957584; c=relaxed/simple;
	bh=we2tJlnUQoyFBmXIgCxQKmIAvUO9WottmLs7Hg8P/E4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArzRzy4k91GPTVwAAylI7UDCuEQj6nXrlNeGOcBcbCJep2ks+fNx6SImMBEQXFAANltLCTEapFYyFTE5/4z4Jo/ik4u9qq17d36+7qKhZoqR9mPgZT3VpsOWPfvSI31P8hEsqPq2Kt8oX+qEbqErTXSagb2cduPAUlH0zYTFV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=y2g78O8x; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso1699169b3a.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705957582; x=1706562382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HqK1FfQSTBEOxDirrkwqtMCsYe2oUlNdNplmne1kglY=;
        b=y2g78O8xNCgAGMk6eFrZCp4C6cG27eisJWVWL4kYgrC96wbvI2XXTOulggV+zUUvmO
         R6yOXSegngxPs3/b8YohfD3hHgt/D/waif0VCfWezAOqNA4RnbdKJSKaLe8N94A2C2yN
         /1mdWlGCoC9TBy2ChTeSVFwTKPu3oTQfq5SjEE9FycqAINxbtIe0TVTYt2TTXIE0aiS4
         yoGZd24XvFF7/wNU2EJ2UPoiZj/WqbLiwA8UdsaFahS9DE1L6uCHRinPDCfO5DOQsMSB
         l2LPHBVcXigM7jkx3Cp53XU8v/rTX+M3cS+6kSlDThwmnv1gZQjQ12GHT4wRE1742Pi7
         R65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705957582; x=1706562382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqK1FfQSTBEOxDirrkwqtMCsYe2oUlNdNplmne1kglY=;
        b=B/C5Ma5C49nD88tFKZrtIi7vhvRhiMbwoBhiacnlHEdfRN/2sMcXXOqAFXyrtP7MPq
         qYQih8Mo2j0K9FBhS9xR053ihiV2a8rGPcX+CUVNRLe71BGKnugXLij/W7Iaxk518IE7
         dCxmorjWIwzdTxOAMupwgjX1CiMKmMv1plmRPSTsRd9QbDMt1/lBUcZ1Lx/+UTh7UJVT
         lf98BXFPIG66OcylH7H8bGZb5sKwOddtAy8BSj1K9mt2jfG6IHoWD9Z3BqPqAzSrEnpL
         0nzDzQjELfSeuS2qL7+QCTBqGwX/x7iidG+EPFfXzfXefKwkxxEobC1yWKMQzb4hhOJa
         joFA==
X-Gm-Message-State: AOJu0YwV18z3pL2L3vForSUSa8+YQXnc9sm6bVAIpl7B4rEcnO58Bz+P
	el8ulE4OKL/rh8LrUye2p2ODPNUpSEc5ZTmxec3ibDWLOtSERSV8Zr7qlM25DMubwd/PTDhA3+f
	xbA==
X-Google-Smtp-Source: AGHT+IEW0MgItSwxpP5KjQQWiWGiX5KL6vM7jsoyOJi3Bul2XCKmGskeTtHpHs6UxT/61/AWU3yi/Q==
X-Received: by 2002:a05:6a00:a0c:b0:6da:4d94:8838 with SMTP id p12-20020a056a000a0c00b006da4d948838mr3251865pfh.42.1705957581984;
        Mon, 22 Jan 2024 13:06:21 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id r11-20020a056a00216b00b006dbce4a2136sm4559306pff.142.2024.01.22.13.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:06:21 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH iproute2 0/2] some musl fixes
Date: Mon, 22 Jan 2024 18:05:44 -0300
Message-Id: <20240122210546.3423784-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix subtle differences between musl and glibc which are
causing iproute2 to crash in Alpine Linux.

Pedro Tammela (2):
  color: use empty format string instead of NULL in vfprintf
  bpf: include libgen.h for basename

 lib/bpf_legacy.c | 1 +
 lib/color.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.40.1


