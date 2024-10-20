Return-Path: <netdev+bounces-137285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E469A54A4
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E34AB22DDE
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE931974FE;
	Sun, 20 Oct 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8bO84qC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BA19580B
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435839; cv=none; b=FsfBMfyXGrJ6O0C/oPNPHiyMiSGjjF9smFQ4rHHV+P8tqdJbOgSSnGxO/wtHMaegl9U0LtAgAOvG2btTj71806uifz/4Ameopo7tkHHIAZb+FgnqWuuOyvcpeHmKQar3k1OoV9GxcFe6lJooezmYzRHc7UOf2nL+jsn/crwjn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435839; c=relaxed/simple;
	bh=3yNP2O5oBuWQs5sHz3EqllFsPc8rWcTo+51JDFCCeXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ahtjnL++Vhe5Gcfj3J1GM0UeyK/KERDpy1GicOnPUOD1oxFlg4NxUPXFXYM6NKs/3iWn5FZ9mrDqJtM5crIU7Zu22/8S98a/G84G7OFyettZ0asU3TtwoSGkax8SpdM7KC+SpKVi8K7+rUbgnOUaITY4vP3GFTIZmjIvpH4JSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8bO84qC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so2526724b3a.0
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729435836; x=1730040636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Es0JnrV2BAKiF/Kv25PYCUHjg2d37Dynmab45gVm1wQ=;
        b=G8bO84qC4QNiB88/Y7+E2rlCNREtJqU1Bh1UFnSacQmVxeDNmlT99kFs7sKURJP3qT
         Pe9Mw45wM4aXja2N+VHCU9XzJLQhlVCHqVNTD4N8FJyQea6mQuvNdpyvs57nnrsEUPRC
         uWBXYV9oWSqG998TQISOuZ454Cq9AwvLiOLO8seSw4kIVBmP7pg7akuT6Nw3sqwSGB4K
         6JZZv1UCZM0z9fNPzS9ebW1S6APLk0S2ERbYwqZPVBU5YqwHe+IF0TC1jEbCy4tVKSAQ
         PU4NheGiDpVrlgIPFYHKFROJPjjr36fPjB/EU/+TTwTeyqHJ90MPPMI3gvmgVY6y5Nxz
         4rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729435836; x=1730040636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Es0JnrV2BAKiF/Kv25PYCUHjg2d37Dynmab45gVm1wQ=;
        b=q0DaKdjezMneQ9L7LDq7Pxo3gKG5B5YxJQMDOeLExAPfmj/5oJdIBAMFskEs1Jx9sC
         UMu6ZA/la2KPUSgVdRQyM+mAvbrgrFHmnSD7O7e3RyppBvYSRbO4v7mAU8g9mkjRDG5M
         HunHJV0+XpQe9HDNCjsb3HBgu+vreSIIf2LByjil27975wxwFAWsC2c+YgvhIsrmL43E
         6FyIB5HCQdIS1VN5JG+VVJUYabsK4Uc4IdMjZrof/8TRnNXH81875A3t+hjxwWaQSkOB
         g2NHGY6UFOribskaZOrd0KValNy+QWTYXCCRtl3E5tNzvrnm7r8cxGuei5A/4iFSNuVi
         OCww==
X-Gm-Message-State: AOJu0YxwJu8BpmhnUwZvrlqio2SnoPzGLaOZLoC5uvkT299g0Q3oh1eR
	nMNjhEH5eAYxqR/Jkhe28dx8ksQq79PaKSLT1SP5qEEXqxWn37nr
X-Google-Smtp-Source: AGHT+IFNd3x8Q60VNeC98QY6sgXcytRCLx95stq1Uua+lAaI2XtRmppBP5FjWM3TKRINOOgQccIXbA==
X-Received: by 2002:a05:6a00:2314:b0:71e:104d:62fe with SMTP id d2e1a72fcca58-71ea31ec3edmr12010252b3a.20.1729435836264;
        Sun, 20 Oct 2024 07:50:36 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.33.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415066sm1243979b3a.198.2024.10.20.07.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 07:50:35 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] tcp: add tcp_warn_once() common helper
Date: Sun, 20 Oct 2024 22:50:27 +0800
Message-Id: <20241020145029.27725-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Paolo Abeni suggested we can introduce a new helper to cover more cases
in the future for better debug.

Jason Xing (2):
  tcp: add a common helper to debug the underlying issue
  tcp: add more warn of socket in tcp_send_loss_probe()

 include/net/tcp.h     | 31 ++++++++++++++++++++-----------
 net/ipv4/tcp_output.c |  4 +---
 2 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.37.3


