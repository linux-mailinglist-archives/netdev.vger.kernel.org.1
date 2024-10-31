Return-Path: <netdev+bounces-140647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DCA9B76C5
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29F02869EC
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D3186E2E;
	Thu, 31 Oct 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FT19YulG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F418453F
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364716; cv=none; b=PcXJrXoAO+VMp0oke55mj2FKzwNMMh28rIYYvKyqd4nfMazk7PU7kf4E04s+cNxzWAHIOGzgh0FEAmegyd1C8xTqS1wMq8FHeZKoS0jV8uLZPcgJEPo5TbF4oSUUYeegAiHPRNnLywCFXyp3s3zL4H5ivLGjC9TZn2qGArzdITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364716; c=relaxed/simple;
	bh=keLAsrbqu5wusbLNmVx4so4/6s67Ngs933Swj8QFA3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNXdVgc7Bs1QB3/YxT6PkjyzzXELQwYbXgMCKg1RoeT8h9AOcQ+6jB3dGVWuN7AECtLwBmgNxvNbRD5kKiCO3/lhfF/FcIo9HIGpi5nMKJ7IZlEIhKCjQJNImT0H34Ipob+lxMxB3VE3SQmRRxSr5q0LvCk/5W5LcfHoWVr83/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FT19YulG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f7606199so686115e87.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730364712; x=1730969512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbjI29rEhU99xCQgy89HXzzOvneufGgxKzspf6W7IOs=;
        b=FT19YulGHySnN39XpJB9eDBe+5y8bp1YywSDAJOMTf34qYY4Lk7y3LfZlARe3uY6Kc
         cZk5xl8UbqWTOLwWr6d44nZp3mltpg+0yo1/APgafoQQ+wBi3HUBT4FbfEms7Hq8VkUC
         JCrBb2dFr5aIOrEs67bLI6+5UFADAzvRw1N0FQR3OrnsO+JezGq9KpHbX/E5hZwXPaK9
         2Xj4or4t+LQP6n2kkn8jueNflrZ/xA/ecwcQejagjZSD6/tUOPnjWGtlkG03TOv4pRvg
         Q23d8gqDNCU5mCMKyKTdD1P8PgduV+c7HKXEc0Nvelynf5abHQ6YrFvdNKY7+dydFoOc
         nOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730364712; x=1730969512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbjI29rEhU99xCQgy89HXzzOvneufGgxKzspf6W7IOs=;
        b=vJzWj1hWHh/EMMQs4QxuvJL3cHYeemQZBg//9nxkBgU8iotJjJ6ZqVLxUvnipEOzpc
         V9wxoVAQKh6T46ExzNNdwIKAhzJNtjZT8dN3nwUFW1d6p2vp93d3ELsNEB0rOe64kyVw
         FoptI/gLwNZtqfQz0CHqJffB/a9nNEVUvMYknpu4sKSInNY8Afg7Wf5IrKaRmP/me2xH
         w+cePnkYjsjT70UmJ5jgfjrGEJP2LQrs0si4y/kr/AZOgdwLsiMfGyFD++wZvsDmWSVB
         Ifk3MXTA5eNlYnkWJdWMyh2YsyPjvoFc5cWotEQJVMl45JJP9Piul2Ec1TVmfeuWAWyI
         J/+w==
X-Gm-Message-State: AOJu0YwbDdQEav6Z6A76Vk43wArPiZrb7d8xIvoPuosEX/drSFYQVgBO
	plJv5WVtkiNwEMFh0gyVHOr7Ai35SviSvWu/AG2XE6pIlUnLmaFziJXhLSmwrZE2h8qSjlfsw6m
	u
X-Google-Smtp-Source: AGHT+IE3R0ZFeOqnz66KU1cU1oBGqbRxu7LdsyGachcQjg06jZsCgMepoi5QRHMR4XpCtcrRc6xkqA==
X-Received: by 2002:a05:6512:33c5:b0:539:d428:fbf2 with SMTP id 2adb3069b0e04-53b7ecdebbcmr3857181e87.13.1730364711966;
        Thu, 31 Oct 2024 01:51:51 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4b82sm1454565f8f.43.2024.10.31.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:51:51 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	roopa@nvidia.com,
	dsahern@gmail.com,
	bridge@lists.linux-foundation.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH iproute2-next] bridge: add ip/iplink_bridge files to MAINTAINERS
Date: Thu, 31 Oct 2024 10:51:43 +0200
Message-ID: <20241031085143.878433-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add F line for the ip/iplink_bridge* files to bridge's MAINTAINERS
entry.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b49d69eb2dd..84931abd561d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30,6 +30,7 @@ M: Roopa Prabhu <roopa@nvidia.com>
 M: Nikolay Aleksandrov <razor@blackwall.org>
 L: bridge@lists.linux-foundation.org (moderated for non-subscribers)
 F: bridge/*
+F: ip/iplink_bridge*
 
 Data Center Bridging - dcb
 M: Petr Machata <me@pmachata.org>
-- 
2.44.0


