Return-Path: <netdev+bounces-138547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 438B89AE129
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE591C208D4
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE421CBE91;
	Thu, 24 Oct 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dku6eyo9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF81B392E
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762688; cv=none; b=sjwuiOOlkp0Fe0drDAOXGk6/z1cqGNlzXPxtmCLhir9E1y8nKQmevKvmNlUfkGe/3+G2/GNa3cBJMGlIkSkNf36AZXx+yzk61Q47CcAkzkvEP6HYNg3sm4awOJL6hgZkuD1JMCo5utXUmIvpXifW+tbQy/D9eK1OP7VA/5G3/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762688; c=relaxed/simple;
	bh=Yt9/QpYysY3G8HLUkD/K743uO8sbi2MrBg0gkscHuMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=heAXrLkFQ/9UJFm2+vQ04VWgNjrGHxgC9/sPiQoKgU360DKO5XIx50d6afEkmg/Y8apYAmBG7VAI6yqOXu5IKXhZeTpPVduz/ILIKEUpL371Mz2lgmttavB2nvKJ1kzFmk0P264JO9fG0zwkuAbcn7dLqGNeCde1TcK88PhxVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dku6eyo9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so476896a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762686; x=1730367486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sS8BVlU0N01tVIYnjufzap+1YgN8vofrhpUX+al6V70=;
        b=dku6eyo9DWxyMBdr1zqh63yozpMKhuypNP3ap7P7+arGsbYmpGS9URQSjxU8xULAbc
         yEl1TFL6SduYamG7bByAaguOQz7CtjPIkDH2ybO+HqVc6C4m/xUt+PJ1YYweFhJDdSSn
         GZdCkDkqFtUdUxckRcUToPsambWEqqFAjU80n6d04mZJ88tJSCvgrKOplfWNsvFgGStk
         Ti5ehHkQFkrBnBNGoKXGOIruqAR3DBhb4ObkY1BmmVyZxz4sAgOOK7W1yGS8qy4545b/
         ag6P68H0r/zxtu4DwNfWTLR4MIUxxJQCXcvOQDVhu/UO18BCp1bNgEoPnDuif4BMOgR+
         g0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762686; x=1730367486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sS8BVlU0N01tVIYnjufzap+1YgN8vofrhpUX+al6V70=;
        b=aYFnlLTRBEYmEMf7juekILKuJkkj3P6swtwlb5z/+cP6w6ogsEsMilg5TpqWbklB7Q
         rChFLxXDQ2faxqtoQ4mPg3VVE3E/QOaV51mVUywMyX0nKjDCJONUyfAFnHisX9X9BqPe
         5s4mgXZWlYE7lm0UgN58Md9/hRT9glVttFXxjFJZ5jF0uk9QrKth+573OfZWdCW3yrua
         rTy/9yK7RLsPgWn4EOzKiSVXgJTdOV12YMI8dy4bj4mwhOkS8Qx/dVWS6mGdfxYjmxO5
         pqwAd6gWmwp04Itnoilfo5ahkeLi83SXpFvbxcg04liqOTLsZU4HoXXaPTnvTmbPF1Oc
         aHUg==
X-Gm-Message-State: AOJu0Yy4L3hvFak76PSSAlCccen61gERj9cFClVipVXzTYAGK0JrbL54
	0o9qbtAGcc3NE7OeCQKikvP86DS/fZN0Za3EmlgaXCSyn3EFQtNU
X-Google-Smtp-Source: AGHT+IHrggK/jk+B/uqwVOMgerFsN9ELbT8Y/LWwo0YQXVt+vMoG4xBKpUZ602RVj2+g4VQN1g9igw==
X-Received: by 2002:a05:6a21:164a:b0:1d4:e68c:2eb9 with SMTP id adf61e73a8af0-1d989aa0128mr1411266637.20.1729762686172;
        Thu, 24 Oct 2024 02:38:06 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d75b9sm7613923b3a.131.2024.10.24.02.38.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2024 02:38:05 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/2] Add noinline_for_tracing and apply it to tcp_drop_reason
Date: Thu, 24 Oct 2024 17:37:40 +0800
Message-Id: <20241024093742.87681-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces a new compiler annotation, noinline_for_tracing,
designed to prevent specific functions from being inlined to facilitate
tracing. In Patch #2, this annotation is applied to the tcp_drop_reason().

Yafang Shao (2):
  compiler_types: Add noinline_for_tracing annotation
  net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()

 include/linux/compiler_types.h | 6 ++++++
 net/ipv4/tcp_input.c           | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.43.5


