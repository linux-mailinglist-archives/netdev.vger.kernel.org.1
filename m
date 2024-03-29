Return-Path: <netdev+bounces-83164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D1891220
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B541C23014
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2E39ACD;
	Fri, 29 Mar 2024 03:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWt0Jz81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66644381B8;
	Fri, 29 Mar 2024 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683778; cv=none; b=dM+NtQIjHopPAwHvU1/y8Vxei3TuI/FNopN8tRljYE/5h3KQ1XXA+birq8yH2UvjM+L+6a0T7Dg+fBcafdlIe8duM2WVh6A4GP1lYCZfuD3WmOPXvgkKoeT0KH0bmp7IAGJNbs6JsaVnmKt825kzOZCXieGKIXuZE0/uFT8VTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683778; c=relaxed/simple;
	bh=XVHMVySHfnWaaJYDGRqxggdvnTpYlnoGYI4f+xwElVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pC3AQOMahyXZFaPPBjv4lM9rBdVOdqpoCL6f/sYfcj6yO9WsMBY1os+5dEZAA1qhNcOGcr9x1fv8O3QqjVECzOgwoQyxaGG0fVYeBoB61SqL4WcdLGsSKjI2C50ZHXFE0GRgoUL59eHowvJHkhYBW/FGm1xVmvLcbF3ezgk/hZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWt0Jz81; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-221816e3ab9so764386fac.2;
        Thu, 28 Mar 2024 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711683776; x=1712288576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRUfuK0poJaM2wy2VQc3lzyW7ALp5m5qf+g5j1V9a9I=;
        b=mWt0Jz819TKjNZ23whrIKW5KssfprHOzSaEGJ/CKfNM/fpF+QJXJ7PaMEoHZ7qWXZL
         vZbXwdOtW+7gbvrsRQQMf8WOe5DXIt7mSWlTdqivUhXMQMl5Goqs6sCw27g9bIdoEg35
         HKGzq/Caho1N53dDK7SY9bBQ2rngrndgi4Epr1/EvBJjN/bZQPbAEocA6fEMWv+owIu6
         HXiHdVb5gzqGvIOiypf1+Z2I1LYdznDZ3kZtBOSrKM2P42Mm88eEEcwEvgDVTA4SpqdB
         AV81Cy1Z8oj4tAnhhySHJRmdTbcKBU0UtR5WtQLtYelzOft94dntJYblPB2IfCTNvnMx
         C7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711683776; x=1712288576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRUfuK0poJaM2wy2VQc3lzyW7ALp5m5qf+g5j1V9a9I=;
        b=Y8N30/SuofVeR7YykqF+aWWjaWO3nnKenT9pPHHXNsJZ8MvuwPOUZFfjAcYQOzrfeL
         p4QcFPIIgR2Ai3S3Q1lsvepIpYIKEA1P/C7lbA3DjhnqOSShLESgDr9mK/YcytWelxU7
         k02sskfZ0RFfVPcCeEWajwb0enxsVG/Af1lQs3YSRvwpv5SFbZa1uWFa58Af1xhBj/Q5
         5ZHOXyTQEGAKlQEfGjQ7wkjaFoe+Sq+5muXcY6yToorDTJRk7dJ9to+gIWhVsRM0P3zE
         62OHn2GtgBFpdsTe3iRvsJFwMh2lxymhhMxeNouW+oHcg+FcIi5AAroQVdgSwfhAZijR
         Xllg==
X-Forwarded-Encrypted: i=1; AJvYcCXGdcy/HW+3ZlQMzHtCbNWjIGeAe1L12bJu+B7hUCS3BH1BeY0ACAQnfnc2cVh6yZO3Z/YJTEZ2owOJA2WJr1+bL2oce+6XvEnSxd0XJ8gAMAri
X-Gm-Message-State: AOJu0YyEyaQ2YAfED2zXG/WU/35ukDdQfS+Zou1u29ZIiBos+ZyHcjiS
	+YOnt3kMaUw3Ua+ln4vWRtk9ZekpRdIP7kyvZ84RQ6hidHVTA4pA
X-Google-Smtp-Source: AGHT+IHUNY/CuTFxjAwbzMdzB/uR6+gefaVOBbXrPugLjMkA8c016vLXc2iJbTyWyT07OKPIvYhh8g==
X-Received: by 2002:a05:6870:d60f:b0:220:941d:18b7 with SMTP id a15-20020a056870d60f00b00220941d18b7mr1100722oaq.59.1711683776366;
        Thu, 28 Mar 2024 20:42:56 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78e92000000b006e6c0080466sm2201854pfr.176.2024.03.28.20.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:42:55 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/3] tcp: make trace of reset logic complete
Date: Fri, 29 Mar 2024 11:42:40 +0800
Message-Id: <20240329034243.7929-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Before this, we miss some cases where the TCP layer could send RST but
we cannot trace it. So I decided to complete it :)

v3
1. fix a format problem in patch [3/3]

v2
1. fix spelling mistakes

Jason Xing (3):
  trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
  trace: tcp: fully support trace_tcp_send_reset
  tcp: add location into reset trace process

 include/trace/events/tcp.h | 67 ++++++++++++++++++++++++++++++--------
 net/ipv4/tcp_ipv4.c        |  4 +--
 net/ipv4/tcp_output.c      |  2 +-
 net/ipv6/tcp_ipv6.c        |  3 +-
 4 files changed, 59 insertions(+), 17 deletions(-)

-- 
2.37.3


