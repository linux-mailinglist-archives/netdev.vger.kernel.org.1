Return-Path: <netdev+bounces-68910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696F1848CEF
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0573B2814F7
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632C210F8;
	Sun,  4 Feb 2024 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaQdlWyQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2F210E9
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043579; cv=none; b=mPWznIoVCFjt8GZwi4q2kJ8MSaLk2WAr8GwezRma0vbtpNuOxK7H703ozuPropkfUjXReVCrUExjO0qys1+u2TLQKMNSIWHp8pdVVza2qwBgY44hrtWTuu89uujB5h9DhaAllA4DXtw5+BvY1mM2EPeEGtlWTJBqDbIxz3a2XYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043579; c=relaxed/simple;
	bh=q5DtUPAI1E27ZF4kA8oC6FXUJpPzSL45FUt3SPOCsVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WgZWFEFFE5fxVwWwUEC0zgZs86E0BxmMr/zXyFhGOLj4VP9qH4RoqACbuNIRzM3usGjJ2wGJZe1cKqTHo0THiaa6jVNR2Zz7fUwJie4JmpvsgIcYsLt6CjePjC5VaHuaxxcs4RXGjGpVvuT33GiicEYVEuwJuR3gnPvtR4gQ/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaQdlWyQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso2585302a12.3
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 02:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707043577; x=1707648377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg1Bt5ValypCpnqv2XvNHnrqSa/b8ql0aBaLUGFnrSo=;
        b=aaQdlWyQRs1/Oigyoz9qcB/3Vbyg7+xN80oiNvE3B+4Dt4J7wDDzH6oGlLUwnMLZEi
         UGm5vcdjr30ehOdRJFeFxSxcsNCqwUpwUzB0oEq9NNr5ybAaYPBlJ17c+XPp6UeG3chb
         xeP+nO15qQgqLPEUn0LdsowOfwGsy0E7S+8IQFY6DgGYe31oNAr1qv74iuMS4GEb9mlv
         nOgv7WPt/yzYjufLMHwpJZfUKF/ve2MTGEbOJO19J896ST0ve7IdjNfspo7Jnoa6k3ho
         m0OGrX15ZDtS1yyXQDq8DOnYr2iGC8omRom+M0qkSr9/XqENKpjpjfPo+vbjzfgCIw1E
         BZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707043577; x=1707648377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gg1Bt5ValypCpnqv2XvNHnrqSa/b8ql0aBaLUGFnrSo=;
        b=E31AwyZ3d03XYgT6z3NS9dfUEKHKOeqQT0GeeGloKLxpsHcepGwGPOVyZfJ5oghWWB
         FevGuZAdM6TD+kAQMX9HQwIBIaL/bL7dfBMoQx6WAlmDUbwe1kWVq9eJse3w+NDDl/7M
         18oeblWEYKqIWeUSACH8pISAUv1AE1lAtRXUUw+wmAuKYnuCxPUPkAYpuov7AQFp5J/G
         aZ4vKCmlKyoq7wbrhdQ8qw6IjrTV4qT9lYEeECWYmk3X/6VvI0R/gXQj+N/6pMSyy8lR
         lyWpSdHR3dH6FtUyfs2BbCbV2Xb9VlnDXpJHw7wEBz5Zsohd066ykj1K+DdVus/7xrKc
         Md+Q==
X-Gm-Message-State: AOJu0Yy2zDFnxYzD2kWXWGJ2A7n/wm3I06G9UjxME+G1dPsi04SYKIqq
	v9RLGQAbpaJ8ao15RzcFMSRbMHd5jilMIAFd+74xR/pBO0x+k1eW
X-Google-Smtp-Source: AGHT+IHIRi8dyS9VV6sSiU48r8t1b25w5OPRma4ocbp7nYTdxL9wUyHuGxscKVzrdi1ZQ2PxmZwXOA==
X-Received: by 2002:a05:6a00:3206:b0:6db:b287:d43c with SMTP id bm6-20020a056a00320600b006dbb287d43cmr4685068pfb.24.1707043577206;
        Sun, 04 Feb 2024 02:46:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFaJjoWQPdDTOTkbD/gTBiLWrCWo8fwIjg3UxYsCxWCdkFAvv2aDkgqIvV8VisNqCA5Z3koPSqDFChrYmjVVbIcnugDsnR4ePC9G4YAgv1MbGulviYOFYgV1FtxpQ4jKcL+OBT/1jAZGLSMcKyeHXSrvCiym2rJ74v/Rlkd4JkYY7++3okr6/ET9g17vOwaLK/GZdK27PKJlvrJa0yZWrT3tKQpuPrvflvCjo8LkY=
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7880e000000b006dd79bbcd11sm327099pfo.205.2024.02.04.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 02:46:16 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] add more drop reasons in tcp receive path
Date: Sun,  4 Feb 2024 18:45:58 +0800
Message-Id: <20240204104601.55760-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I was debugging the reason about why the skb should be dropped in
syn cookie mode, I found out that this NOT_SPECIFIED reason is too
general. Thus I decided to refine it.

Jason Xing (2):
  tcp: add more DROP REASONs in cookie check
  tcp: add more DROP REASONS in child process

 include/net/dropreason-core.h | 18 ++++++++++++++++++
 include/net/tcp.h             |  8 +++++---
 net/ipv4/syncookies.c         | 18 ++++++++++++++----
 net/ipv4/tcp_input.c          | 19 +++++++++++++++----
 net/ipv4/tcp_ipv4.c           | 13 +++++++------
 net/ipv4/tcp_minisocks.c      |  4 ++--
 net/ipv6/tcp_ipv6.c           |  6 +++---
 7 files changed, 64 insertions(+), 22 deletions(-)

-- 
2.37.3


