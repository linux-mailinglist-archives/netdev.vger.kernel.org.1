Return-Path: <netdev+bounces-81466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293FE889F27
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED0A1F379F4
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C915F3F8;
	Mon, 25 Mar 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar8yyvqi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB618786F;
	Mon, 25 Mar 2024 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338242; cv=none; b=mVeL9UTqCy03rCFEo61TBJDoTq0xF6ZHO8Z+5c7VEavo1vJCFnP4Tws3ICi+xJpYUUUDGJxC9w/8UycnXJrHmolQ7OQ2HgEWEnfZVTRJ+Km3RcXBnbH2/w/arig12qJSiOIEROlz4nrsnqpRD6JYEKDFeed+u9uYb5Fwuo8pIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338242; c=relaxed/simple;
	bh=teH38ASE4B1X90x37Shf8/P2G9yTLfaBtfwsGauPHPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PVsKRlzrzd6myRgfDMYND46vEP36mxQ9SdbFS2VMYu322aomskKqM4O+sHQjJaK3jP8/r2WXw0DkPwqlClEdznrG7Ik4/XEPI18v0ISG/CIiJX/PBXFXxn5G3VYF3mPJC6BoIxjSVnS1lR0pitsUYHNLQBv0gcktwgN0+jhVgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar8yyvqi; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e682dbd84bso2474731a34.0;
        Sun, 24 Mar 2024 20:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711338239; x=1711943039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XFLppo36Umvbtpc8RsHxYQfKcPgDsuGoxP0BP41l1g=;
        b=ar8yyvqi1b9wz5VLzRHyMv1jub22l1k5pzDNjasIRX1xL3uxG0OnK0Wz95ptgJrDbm
         DiZFL5iANzB5GgbEtV77KREpZH21wvlIHodtwWi4ch6O5+UE9w+8h7VpJ6AlsU/EnJnH
         SdAMOsC47QAwfFZvgCAsP/SRtTkFJ2ckNulrlbaIjGvUqogXB4bdFd1J4F0u0K0hxO8l
         5/62sEFueNYFPjZpbLZ/ik3Sragdtxw2OKrXe3iYB2DQvHmpBH0Rh36rlHwffkayucDu
         Uml1rKQ4cgl+frHkHDQYgwZU4DPgFScCS0GP/ixD/ZKrh+YeQRVShb3lny4YQXrF24N7
         CBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711338239; x=1711943039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XFLppo36Umvbtpc8RsHxYQfKcPgDsuGoxP0BP41l1g=;
        b=DnIKi2rZixDNTq7eeHskBzzD7sduHgFk4pAczLivduP9K2C2Y0yl6CNwFfEN4WXtl7
         JyqMSxRUEumXUZBCP7caAH865MqdavNZRKH8fnjoikXcfJ8oKehTBx4uFrg+GMF+rXqy
         Lr+7RZ6xNZODDUG/wkS9X4T9DAoMHCZVs5hnIuf1BD680Vqe+RO8FDdwzEPjZcf2whwL
         T2fCAmGFLDeou3PJWTMIolxVnln1m6JfN+zgJceyNtTUdWSww/VrAon2uQyYo2fPSQqq
         o7MiZd+k/SDE2lSf++8qOPJW00UxKbakF15uL/5W4j3a59+EDxzzycN0mDikqFElcf4h
         /92Q==
X-Forwarded-Encrypted: i=1; AJvYcCUodisD9AR4Mp4MfaW8lQwlO6HAEFrwWgVjGAU3yDxLxV0kAl6W0+C3euDUgb+W6GXGzfDZwvgTL7ubcd1Um9B249684ZRZVSjVvNrZGOc3flTJ
X-Gm-Message-State: AOJu0Yzz2iTE054IKszInnZI6sBE8t+YAMZ24UY/mVJans4qYMzdTagt
	9RAP7LWOnA20ORaWakAjIeJtR8xVFNCHrkSEVWlAzqE/jwo/I9zb
X-Google-Smtp-Source: AGHT+IHmYixcHV8K+3RjwVIoS1UeugbmyXSvhC1Y0NyEdKEFU/YXPCpy5uXz876h4cUN0hTlTyZI8w==
X-Received: by 2002:a05:6870:6108:b0:221:9414:4519 with SMTP id s8-20020a056870610800b0022194144519mr7298644oae.46.1711338239656;
        Sun, 24 Mar 2024 20:43:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id fk26-20020a056a003a9a00b006e6bf17ba8asm3300045pfb.65.2024.03.24.20.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 20:43:59 -0700 (PDT)
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
Date: Mon, 25 Mar 2024 11:43:44 +0800
Message-Id: <20240325034347.19522-1-kerneljasonxing@gmail.com>
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


