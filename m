Return-Path: <netdev+bounces-241301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 900ABC82888
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C223349B96
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591732E6A0;
	Mon, 24 Nov 2025 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spMJZRsu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F22F363B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019693; cv=none; b=fBifsqF+ZyNbXD+862mNQCXNTn2IsFZpvTIjOliCggaErqh/bpTumXRtEYvSoVBff1jLfE1D7Xn/eZW4kBFxThMqK9ldXrwq7NMDChRHfh5EGogFMVCYLwhA5Juewk759MXEi71RsZSnKFEiQGUTC1zwvZOVFLD15S6n7Z2yRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019693; c=relaxed/simple;
	bh=FTywxid5XH2Vl9OcyiyAPndaFTzHil5wxhZSmmkjEio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sSCX+gPQKZ491IPrG9ccvEbzTO93vZySdpF/gND9mZkbq2wYBlZy1ie7moNF54ADdXs0r//s8LmFQReFBOuPvF+HSI0l1p1fDeRmAljbYJpg20XbRvxfzlPbrVdF72H3MZa5h46MLeGBfSHo/O6EDrwAvPnLGo+fdHcadTZO1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spMJZRsu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297dfae179bso131599965ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764019689; x=1764624489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ek4hUVO9y+z0mmjDt3EYtGYv2mzbAoP6K3InoOdTyno=;
        b=spMJZRsuO8l7dvlxDmxN4gh5spJgkxUumemzqk4L+DfzFBpkJskTzF7HV7q9EmfdXn
         a0CCFlTCM2ohZy0g458b/suZ1w9BAR5w/UbEseDNC8/d7JBJGnU8yBNyKxtI6MRAQMFL
         1Oktyv5mNaUKdg3r6r23tBcUk3lksPxl+aGJFQ1DyI2s3FDqN1u1UkGAlCi7+02wZ4PL
         Xhd0GR2NYtJCo3ZmEM9K3w+V5sN7XuveFILGGFfuTtZPtScknS39+nyPoOJ1GIfdpR7g
         6NoVoOLWoH4dckDRHWJHS2nyNM4q8pZE7S6VKrmt+lZ7cmDU8L4cPlT+LUhwl8aBZEIC
         86nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764019689; x=1764624489;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ek4hUVO9y+z0mmjDt3EYtGYv2mzbAoP6K3InoOdTyno=;
        b=Vf9fLgPyE/u23GlwdX0eJZIct7GwrC7sCd0oHpawyW8tKyOp/9ByHYR+epGsKbe21U
         5CF6YZqmkKLmsRehlAPv62I/TSvrf4F89WXTfn91jPrwF3XYoDWZa5UiTSMQ35P9u4rG
         sqcP+PP5K1a8zokVSAK0cT5wBofE1612RfgPWu4idvMGsiQ7zLqatiYtIKAwDDjTFjn6
         YXdIaSS1Xx1igDVHxybm7qQjkxB0RPim08XjsyKb/FXllrB2NePHiuZWxuRdxoHwIWOU
         6ml3k1EIDNDjjucCPncrWIQp4MPhXeA1UdfsmeZqmlgWAZU5ykh+YFw78EFoIByojvRT
         VHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg00lmn/Sj7dHOg/lnl2ERrElQHS5dGTNCyokT462fKIpNlYDOhNXFkRqUf1a12VAWmuFcBnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0o/pJnNpU/4GZGiKiS7+X4CEkSfdtX0iuw/DSQP4uqO7up6R
	ecunHBDd2ASpSV5TdMtGujbZLEVJJIe8PMMKDlRG3DY0DRUSu0JHAKBWO9PMnQ9VL4u0ykMiJfx
	bQ+suNw==
X-Google-Smtp-Source: AGHT+IGm6bjqKbTtnOn0gaaIPrMq66d0RSKppjK8SeDBSzXIFhnbIkBFgpO8VZr0oOvylt2MSek0bSD7VeE=
X-Received: from pllj11.prod.google.com ([2002:a17:902:758b:b0:297:f151:16c3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98d:b0:297:fec4:1557
 with SMTP id d9443c01a7336-29b6bfaf6c0mr132620775ad.60.1764019689583; Mon, 24
 Nov 2025 13:28:09 -0800 (PST)
Date: Mon, 24 Nov 2025 21:26:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124212805.486235-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/2] selftest: af_unix: Misc updates.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 add .gitignore under tools/testing/selftests/net/af_unix/.

Patch 2 make so_peek_off.c less flaky.


Changes:
  v2: Rebased on clean net-next
  v1: https://lore.kernel.org/netdev/20251124194424.86160-1-kuniyu@google.com/


Kuniyuki Iwashima (2):
  selftest: af_unix: Create its own .gitignore.
  selftest: af_unix: Extend recv() timeout in so_peek_off.c.

 tools/testing/selftests/net/.gitignore            | 8 --------
 tools/testing/selftests/net/af_unix/.gitignore    | 8 ++++++++
 tools/testing/selftests/net/af_unix/so_peek_off.c | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/.gitignore

-- 
2.52.0.460.gd25c4c69ec-goog


