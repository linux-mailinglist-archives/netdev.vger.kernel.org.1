Return-Path: <netdev+bounces-79020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D71877689
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 13:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D70B20AB2
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC561210FB;
	Sun, 10 Mar 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQTQEFQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9722618;
	Sun, 10 Mar 2024 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710072860; cv=none; b=kcwes/kFTl7nuurZOpcHvSS92qFuEBJSVxIzALUYxrp5L/18qj9jCMoIhzB+cxoKsy3mJSeAGI9B0xTJGa0L68c+mdtsql5daXrxs7Ca1UOm6byCR/frSrRsNLVAg1ckAklY8Y0Gw7/1NnEPboam+hGXsfgocBPGNHQKZ7/lTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710072860; c=relaxed/simple;
	bh=teH38ASE4B1X90x37Shf8/P2G9yTLfaBtfwsGauPHPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L9TXteswBgWjJA6CbL91t9bCakGoeHhtODHiKXMzR7V5Xl1W04vkoYr3eCp74DHgncqFTLCWURoN5gGWUjDk+vK1+lcJ6BK8G5aj0BpXYrvRRWztgbaXgr55g9Rwqr2KwV00e8GRs+7P9WY5CJlT9lXp8+X6Y50XA0pozLLANlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQTQEFQC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e676ea4e36so1180113b3a.3;
        Sun, 10 Mar 2024 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710072853; x=1710677653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XFLppo36Umvbtpc8RsHxYQfKcPgDsuGoxP0BP41l1g=;
        b=IQTQEFQCO9fFj/pWVWc7C0FWGO+1mXeya2VIDzZfzFWpewwL7SsESOUWkh0cIg6BsE
         ja83j2wKijpe0wthcK36Sii78035Oc4ne9RKIiS9sAemf76S4pCJkvVFO96v7rdG9WQm
         /ogvK+5R/i4DBi2Qth0In5cMvYuDiYh8cbNX+Ze1aGjPxeuoMUtG8qcwPcBGf4ecC7Ct
         ou14EPOVA1ix8kZlp1LPfwF4ulpwHCouT9LGFzKgF+O34T5ObXDwYDDhOaktn+BEuSRB
         F01og3IqoR/aVMCzgx+bl+UgkORdxriUw1REdggvuBOBc9q7b/7u1rN4GviR5CYnro4N
         gSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710072853; x=1710677653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XFLppo36Umvbtpc8RsHxYQfKcPgDsuGoxP0BP41l1g=;
        b=Vx/QsNEXFDdb7JPUeVYlFGxkTLVqWrrA9nDBpJnm8Ts4EKjdxptXlHJRJIffPF+6Fz
         kMh4xhRx2Zooy1btwZ1rmc0vk7LUamzs9veXlXcPasX3WGLWX6IHwzw2QdhKBTpga0xc
         9KhhC+FF2GE3AT648FZA3CMytug2qSkUcwjz1+s/CucGy+9QIC45xubL1r3tYyeUNbN+
         gyoajtmz/UFd8PhsPQ5njDp4RDwxaY6MhZ6p9z2GuNUrG+Rwsk76s3EZzDMcp94unCOu
         qhdIIPbP1nco2e1sqjfkSO9qx4P34weri/UAuuQNNlWac2tDWFIxuiQ6f7OgWuJCMNKm
         5kOg==
X-Forwarded-Encrypted: i=1; AJvYcCVGoXpkdMvwJ5ysBHWpCGw0JwI31GT1nh/jU1LgFrma6znARRIx7PqdYJntrvd00wqDEzZasrWd5WyCIchdMp0BNUbnR2v4M6bOyzhpgU/4Qv2a
X-Gm-Message-State: AOJu0YzqavSVZHr9Oc8rDU7dooEnvVKmkpKra3XjXirM1fnkc56nvF2l
	BRHFNhoyDzvB4h6C6uYNsN9CV11mAdjj7BxP3ULMwFl4sao33azs
X-Google-Smtp-Source: AGHT+IE9r944WM4pE4W85E7di5LwaxCoRffX5uB1pIPfGE2E1x1fZ/IOcNQGSbKeu3F/zTwQYUYLng==
X-Received: by 2002:a05:6a20:938e:b0:1a1:501e:814c with SMTP id x14-20020a056a20938e00b001a1501e814cmr2074931pzh.29.1710072853393;
        Sun, 10 Mar 2024 05:14:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.38.90])
        by smtp.gmail.com with ESMTPSA id y30-20020aa793de000000b006e5a99942c6sm2485330pff.88.2024.03.10.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 05:14:12 -0700 (PDT)
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
Subject: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
Date: Sun, 10 Mar 2024 20:14:03 +0800
Message-Id: <20240310121406.17422-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Using the macro for other tracepoints use to be more concise.
No functional change.

Jason Xing (3):
  trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
  trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
  trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()

 include/trace/events/net_probe_common.h | 29 ++++++++++++++++++++
 include/trace/events/sock.h             | 35 ++++---------------------
 include/trace/events/tcp.h              | 29 --------------------
 3 files changed, 34 insertions(+), 59 deletions(-)

-- 
2.37.3


