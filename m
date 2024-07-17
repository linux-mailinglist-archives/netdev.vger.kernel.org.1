Return-Path: <netdev+bounces-111927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF39342A1
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 21:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5860DB2287F
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DC31B5A4;
	Wed, 17 Jul 2024 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieGoyf8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353D17545;
	Wed, 17 Jul 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245065; cv=none; b=TTjwFx7uP9Nqy/DQm7TLte+Md4Qmz0OAtUooVxjsUxron+RP9LyhSmH/cZnEf/jAZ42LiQcaM/KRC+sLK1yKCxEb4ltsbnDpnCD9Os/R51abzL5Jubhv02DyyKpR7JWuXsUxOg9h7160vA954XacjelQDzXX6AtXkp4HvE6E990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245065; c=relaxed/simple;
	bh=bFfUTmZhh7hT6/EMtWiTrjq3FhelUtCweU6Wgq5/2N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfZRM19x0zQUkxVk8GqsrY++r8r2F+a86BWQ49RWBcCXh3UJ+rBruaExLGneqx+kghbATcunx3MPvDOi0G03X2SW7+9AfDiTJlpDhgMSKGfGz6yOWWspZjsN3pV9FVD4ZZf6gNfVMUhNafaVEhhYJXj8T3o6dTjKjYXL8V3I1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieGoyf8z; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea5765e75so35634e87.0;
        Wed, 17 Jul 2024 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245062; x=1721849862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gymw2PmOFIJa5I8yFcx4dcvDPlj8mVxnCXcmhBxCSLE=;
        b=ieGoyf8zqzGOJhIXQHoZ/vb8f6Mw4DEmJAiu4x2/z9mX0OZ0JF8JXdtl499rMHfwx4
         5qMlGpwDntXd2/5+3aCTD6cqALbcTj1T14qWzsXFG5N4C4Mye0nZGk/pw88hqF5RHyWV
         03BVjVNe3ylLxUvyv2c7Bt8TFaCv/mNELC7x4cqWIR0s2DOACDet5skj1TfT8XD7gDcC
         0iS7PdTON3+vwBZkE95fLks8Ef5Z9aVr0U4iGTjedxD7e6y5jWYzAEHb3bA5IYuCvTqR
         DaRG0GfpGHHnUNd1XarmZIoRg4sjUatj8w/2NyDSpXMYkyBxUSbDk1tQHla3ADWKojnt
         qx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245062; x=1721849862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gymw2PmOFIJa5I8yFcx4dcvDPlj8mVxnCXcmhBxCSLE=;
        b=LH3ypSBdj3Qk0OzGx8/9MqoKMFIzpjeKeoejle3TMJrLBKsJJhcWYRCbYqgoIM9BCB
         ejpbScMlfigki8CNC+ouWz+koiSUt2dX0hJSSG+ml0AKbJUtk17lS/VRD68jQvAzFWM5
         AVXRSFeIgUIXjacXXMuHO1kr/39FhYJK5rlZ2l8XH0kWdewLptFcHTynYUCqRY5imI+L
         wJfa6y3zC0bgw9zLlZve4L8agAkC5R1RCpI5t0WWDJCC3utJb/MAFMz4ycGfoc0OXy3y
         Ks6KyrThE8ZU8JJLf43LlYwVqVHt4d/86Mip6YP6fFhmncAeP/NHdqXIlE7ynhrDRN4B
         oxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnb/x63Phfzpi2EQigrGJ7Z8kM6bbp1lLckZGwg4iUlTwddHnjR/9WuOpND2kHKbfmZ0b/54Tko64UC99KfTtk7Zel6Y/a
X-Gm-Message-State: AOJu0YwNO7o7UKXJ83D7U1lHvqzjc/hG+XiVLEwtY0bONWNmZ0kca8MM
	apVytzr93vOj0AAPFi8dn7PztH3AZZ6wL3mXAiLDFVj2PAKbk9327r2m7gVt
X-Google-Smtp-Source: AGHT+IHs8ZDbHsu5GJojIFasvFZklAwqLUt9s98QP+obn+/jKs9p6qSriQe+6nruo/5UfQ5u433b9g==
X-Received: by 2002:a05:6512:2207:b0:52c:e00c:d3a9 with SMTP id 2adb3069b0e04-52ee539c212mr1958996e87.1.1721245061868;
        Wed, 17 Jul 2024 12:37:41 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::101:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59f7464d40asm3080535a12.68.2024.07.17.12.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:37:41 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH 0/4] net: dsa: microchip: ksz8795: add Wake on LAN support
Date: Wed, 17 Jul 2024 21:37:21 +0200
Message-ID: <20240717193725.469192-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add WoL support for KSZ8795 family of switches. This code was tested
with a KSZ8794 chip.

Strongly based on existing KSZ9477 code but there's too many
differences, such as the indirect register access, to generalize this
code to ksz_common. Some registers names have been changed to increase
standardization between those code bases.

In addition to the device-tree addition and the actual code, there's
two more patches to correct the erratum workaround application using
the now available indirect register read and a minor correction of
existing KSZ9477 function comments.

Pieter Van Trappen (4):
  dt-bindings: net: dsa: microchip: add microchip,pme-active-high flag
  net: dsa: microchip: ksz8795: add Wake on LAN support
  net: dsa: microchip: check erratum workaround through indirect
    register read
  net: dsa: microchip: ksz9477: correct description of WoL functions

 .../bindings/net/dsa/microchip,ksz.yaml       |   5 +
 drivers/net/dsa/microchip/ksz8.h              |   5 +
 drivers/net/dsa/microchip/ksz8795.c           | 230 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz8795_reg.h       |  17 +-
 drivers/net/dsa/microchip/ksz9477.c           |   8 +-
 drivers/net/dsa/microchip/ksz_common.c        |   5 +
 drivers/net/dsa/microchip/ksz_common.h        |   1 +
 7 files changed, 258 insertions(+), 13 deletions(-)


base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
-- 
2.43.0


