Return-Path: <netdev+bounces-79499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00334879885
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 17:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934951F24079
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C87D3E1;
	Tue, 12 Mar 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="D+cHjqy6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486167D082
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259578; cv=none; b=K17fCvgwRur035Yj1YriUP82w/wP0wyALZCQ3LHlFzM5KoLN68u19KZbZtG7r1DR5gXRDDgPuXBh3lCqi8BSUgnL+Eps0DG3xjCdxbuy0dJF7id7TEfjyIZWhy2YvaigCNQ8J6BP3agIe/9T67tx1xLA/3OX7vHR+PbFhBtFas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259578; c=relaxed/simple;
	bh=ffxPWdRj4cwEa02QJ/6eA7MLrxqYDm6XBwpjom5fPoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ALW6pbEoXNjK1dwlAE9wByEMALpjSB5weUkPmOBFa2U0la3xBZ3ne5WMSRVmX+nC8P9NDnETDnvtgT4a7anxuuVUlG+BqgAQU6Cmak0AYPmaG3WMJ7IxMDh1X1G0ult86sATzYJG6GN4uQ3Q/tNqHDLyytOKGjJpHbFro8TSR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=D+cHjqy6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513173e8191so6017264e87.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710259574; x=1710864374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2oo5V7KMbjzB0VE7JVYY25Mw2tIhasEA32KtjALRCr8=;
        b=D+cHjqy66G+zZi7LL13uY4DN8izTM1dtLMSx6Bn7Rpatn0WOU1Tjh7Q51BtI5KvIoz
         5aurAlUDZl7xPy7bI2m0NIES2nhtPnQ/tA1q9b+rAQtHqYff0vRIiV/0Dpw9l5C5/+zp
         VgP2GAvH01fRtHgtaSO6RWhpVfiEW6KSA3S1bPwCkMzVz5dDFI4h8R6twUFSSXMIqr6Y
         vve5Qg9lkGPcRelAiHnKFzVXnqXm7zFrZ9FNFXnreOpOoxwnVNTsgBuU/BE9dSFYJvED
         4L1Nb5717VXfTngsHXdd/IN/LQEvpxCm5zOydmT9rF4L0owUMyZC/i8lNAreaoRwFLwJ
         LUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259574; x=1710864374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oo5V7KMbjzB0VE7JVYY25Mw2tIhasEA32KtjALRCr8=;
        b=ALzxbHR2FfxkD2tZgQO33O2Rx3nVMOMjyEdZdz0QVql6KGdIJzGY7HABws18Yc5V/D
         9RmAJTtb7Xe29VXiJYBc0CWP8WMPA7es+C1tklBTYRqD5dl/8xp/+ybQbc7KR/693qW2
         XKLTFy4o/m3VfRklxn8VwpZiU9qA661GCsf0c5zC/MLXWKex0rjPkF5Bk0IFk++g9eVt
         5YNaOnC3+Tli9lgzQPprl4nvxDv5IxgxInxzfF15SrvWwYfeegOKyTMwnOgjNoHPyGcg
         LCSQC6917TlRveTwM1uD1P7qYZnAx5dCSniZSDjPGfh2OUSJc5b4TOYIYz4+RtCrHQjf
         1ptQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOo4KJV+IRfv+0AmaiF4Eu9YUzHfMdGtZDxhzZt14Ne1ZYu+cNO15nqMfbX0UQtSSQm4AOQ2k7yB7WeV0p36GxMVFY8w3O
X-Gm-Message-State: AOJu0YxIK4zD7ALQZ68JaZCwwIiN68KnxuUT/90kRHw0ri2muU6ifecF
	tHmdmjoJHpYl9G5KhUlsbmKnQPQ6HIeZ3hcfjaM/x12pyLaAifvg9TjQ5c/iDDw9dLuNyiOvomo
	dVLc=
X-Google-Smtp-Source: AGHT+IGG/4pdRTFr/CMG4iunQGGONt/Uljten+wu5aH/Nw8HevuiCQrjhw0Drtz4MkQQkXN/X/yM6g==
X-Received: by 2002:a19:9112:0:b0:513:2c86:3498 with SMTP id t18-20020a199112000000b005132c863498mr428344lfd.48.1710259574342;
        Tue, 12 Mar 2024 09:06:14 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.7])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b00413e523b7f9sm474253wmb.43.2024.03.12.09.06.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Mar 2024 09:06:13 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net v2 0/2] net: veth: ability to toggle GRO and XDP independently
Date: Tue, 12 Mar 2024 16:05:49 +0000
Message-Id: <20240312160551.73184-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is rather confusing that GRO is automatically enabled, when an XDP program
is attached to a veth interface. Moreover, it is not possible to disable GRO
on a veth, if an XDP program is attached (which might be desirable in some use
cases).

Make GRO and XDP independent for a veth interface.

Ignat Korchagin (2):
  net: veth: do not manipulate GRO when using XDP
  selftests: net: veth: test the ability to independently manipulate GRO
    and XDP

 drivers/net/veth.c                  | 18 ------------------
 tools/testing/selftests/net/veth.sh | 24 +++++++++++++++++++++---
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.39.2


