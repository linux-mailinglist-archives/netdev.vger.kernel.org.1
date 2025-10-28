Return-Path: <netdev+bounces-233521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D5C14CD0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F107D4E1045
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23113043AF;
	Tue, 28 Oct 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHm/mnj2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB27264634
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657639; cv=none; b=AfdwBHknNRR8DXViQyTJMDu9mBhDKLx0o2dr9FVXuWMQXpXb2gszi6YGCfXZq1yJmD07FLQJMCb5cIzehWk8+jOCJJfCrEfiquzgRKhDdrK0oVxiuMRdaq5+2AD9fdhWiPHo8SvGnJ9P4oAz5AHvORJsFz6dqhfFXEG5eEd3akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657639; c=relaxed/simple;
	bh=OraHByRSkDTKrt5+sOvd0Ht/6LFZDkcv/nCwyeH4DNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+19lSkkA4SjxReg90lCwpg9zwIxl8P3QynLy4N3iju2JtKzs+crpIUNRJQcwYWm30+CSVp3atu33Q1qMRjCIgOAgnpzyUnZHJLqQi1kUOHctiODdYSKZsq3Mpcllul3zG+mPoVxiNwLjGqGSLRWRJGwyUEbQb/LAkdCVnbu1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHm/mnj2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so7871270b3a.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761657637; x=1762262437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzLIntGDHL7+P055GuRT7nFuEDkNdk58z2RuQjYnrI8=;
        b=CHm/mnj2dpn87cmLzHcWzWMEC7+jnqnLJxAqGrvOw4INkKxqRau3eRaSPxvf0uHU4q
         NpcSHskzE7xCm+jFtev4+ckipvkl26thUpNqSu+02D0zSrw1jKWdGcOHcFjuvCcibV6A
         md7vijLNpkG/bKCkbKOmOQou8nyMMbB4iVi2cFHMcmZz9k6L8r37goPqD2wZJMVu9M3k
         OwlB8y7DONRhTKgD4UqMGrHgW+i31yywF0TyNifAUqoReMKyogL1rkZqxRMLel17mN14
         mxWZiCZa7kjXAG25tTPU3vjYkECJHWJ1xojIfWvVvOo0Gt0InoewiXwNIQY0cKIli7Je
         rdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761657637; x=1762262437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzLIntGDHL7+P055GuRT7nFuEDkNdk58z2RuQjYnrI8=;
        b=NpyVothd1ieJFhpuJBv7/hwkeYsHppGKMg6NtCDTvqR3gEYoGBViBAEe+gs5OQBhmS
         rDIlkKdpwhjtXSxvKjZlw4BNyJPAc/TXiMtLsHQizA/+Wwc5u1zMAOi1Nx72TwxYIeiC
         WQ9WRQUyH0jAAjMz17XVsQs9Ls1RcB8z2/PUtwL6OoLSVghVyRrj3c0Up/3OBMTHiiRj
         GtXexF2g+k768EeCd+eiGAI6yg8rn5sV3PkXht6vYyZZn1/WCR5fOg6BPTYDgsOxhlV3
         WglTLkkv96SQLMp4B8lcUV8aslWjsdB9CqNFBYYfWOu7E3E4mEVg/xgfV5FgVCUtfWUQ
         l8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWv5lSz2ch99IMESZgi02g6P0gY7qNffWYonf4l50JB9vaMY70hPl0Ekbgf8eVgR+/nEUb2rtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4DCbSH/dxs/28O7ksP1ntvVdzSMhHpVRS0FILFVQZ3Q6ygG6
	t/6ba5ukdvXs7NEV48oQO0VmZPuDryBdHlJuJNzZk90Ro0fCJGd6ZYkv
X-Gm-Gg: ASbGncvLpKUonwNIHaVUhNm/UyQ4a3LbFqrts51zzJmdmi5mA1t9GIujfJ0MAmYtoKQ
	DBQG7hWwxREyrlS0tVBJPMCxQSa7NC0tM9lb2vDlB3eZwvS3mBaeUmJOMXZqN/O8HBPrJVf+z2B
	QUI4V44fTleoB19AdCEk59sZqRgEG2rkxJSmvRoKkGpJPtYfy6pfgGHejUTTYacYxJw8L/KjwNY
	IkXrX/FJpy4Bef6q0GcYPrxy5R0mhG7g3FC3vhp1wbUCyWOWAkjfMEAC52Bn/QTxOp3W/hYgq89
	2/QN60zYrljVlyZCDeW+uovPpTr1zGLgrmYBOxCwuQPZBdyYdVyCI5TLOb01ZJVIhEs9Hp5bpqq
	0GpXuUxAQtHZTy1l6olK1PC4FS8FUGERj5zfcRnPstc7t8KYbA+JwfmOysdGJq0C06q8f67ZIak
	y/
X-Google-Smtp-Source: AGHT+IE5u7Id+aiml99gQys+AcPpH4Eit68IjE0RkIpz2pZA136//uNZkrUUyLYbvp3Vhsbk8QnGqA==
X-Received: by 2002:a05:6a00:4b10:b0:7a2:7930:6854 with SMTP id d2e1a72fcca58-7a441bbe8b6mr4307214b3a.13.1761657636780;
        Tue, 28 Oct 2025 06:20:36 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301ecsm11844986b3a.24.2025.10.28.06.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:20:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E146D4209E50; Tue, 28 Oct 2025 20:20:33 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Matt Mackall <mpm@selenic.com>,
	Satyam Sharma <satyam@infradead.org>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH net-next] Documentation: netconsole: Remove obsolete contact people
Date: Tue, 28 Oct 2025 20:20:27 +0700
Message-ID: <20251028132027.48102-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=bagasdotme@gmail.com; h=from:subject; bh=OraHByRSkDTKrt5+sOvd0Ht/6LFZDkcv/nCwyeH4DNI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkMh4685/SZl8pvmJU++5ua8Kmnm2r8bY5JrJ3fq23w4 6yZxtWyjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExE/yUjw+xdEx9w7H/gPXmG fn/v9peudQs1/eoZ1evVr59axj91fjwjw+3kG/M2lV+d9uu42qWU41EKmnNVjBcFbelOmGDm/Cd nEjMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Breno Leitao has been listed in MAINTAINERS as netconsole maintainer
since 7c938e438c56db ("MAINTAINERS: make Breno the netconsole
maintainer"), but the documentation says otherwise that bug reports
should be sent to original netconsole authors.

Remove obsolate contact info.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Cc: Matt Mackall <mpm@selenic.com>
Cc: Satyam Sharma <satyam@infradead.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>

 Documentation/networking/netconsole.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 59cb9982afe60a..2555e75e5cc1c3 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -19,9 +19,6 @@ Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
 
 Sysdata append support by Breno Leitao <leitao@debian.org>, Jan 15 2025
 
-Please send bug reports to Matt Mackall <mpm@selenic.com>
-Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
-
 Introduction:
 =============
 

base-commit: 5f30bc470672f7b38a60d6641d519f308723085c
-- 
An old man doll... just what I always wanted! - Clara


