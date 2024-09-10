Return-Path: <netdev+bounces-127093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC49974128
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCE4287101
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90541A2C3C;
	Tue, 10 Sep 2024 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDDXl/8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AE1A257C
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990803; cv=none; b=aZNxBxG9Dnbl7olErLKL89NV0mIDzyB1Ktt9V8i610FvN3eCLHnIZLrdBRJ68dsyqwRm1Rop/KUQZXfvbi2p9WYBDE5YELtfAcGfmakz7bBuTW6X6bpIzu96M0ts80JKKttPgpyeUA7Qe6uneFKj554rhyF1vPXAcXp6aoEMwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990803; c=relaxed/simple;
	bh=qKHSMpSfWawa32Vbd+fnMbeb49HZN/VlANW5Lob/Tyc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PXeRKoTf7rmC9PKk++zveAlPu2fLLgKTTCAnH36/h3KKU0YohFB44BuODP4JZ4jqXlKmWQY735zXjSM5hvJhLBcO+jyrh9UoCagebCINJPO1G8sY3jNplyhMGv5QNy0p9Jbkbve18qWNimshTBhMdQejQ0+zYfuxB3mmyMVjCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDDXl/8Y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7d50ac2e42dso602242a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725990801; x=1726595601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=726woS4XWKTL/3BXmGCo4/wYMn9YNrNMAfxFUlE4Z4s=;
        b=ZDDXl/8YXSM6zxoJLcVkMtRmi7wPR9FECyd/cZA+v8ILJk6JOVimB288e5Gk6Ezwn/
         kBVKEN1WalRqE0mHQg4/Hknifvaeo7vFV7+jaSPBjJjPMfWWaMoGFD0HD/MRnW/9Ds2Y
         opkjPWYt4EtaYLgbXgHpmuvH0aPx+dfA01bZ1F6PNI/QdrQcilKlF0RPuxyQkxkTpCOz
         dsqqolyK6x7WZsBnlucDwMudHCuwI1EEdNC1mmmxvmaNYgoidls2ZevzvXGvVcl7cCNS
         i5gakP/NXnFn7dwFxiWf+wWx1oIe+nOrlTnrpBCflx8ju+NteKkeDcdrLLwn7tj2rGjk
         5Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990801; x=1726595601;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=726woS4XWKTL/3BXmGCo4/wYMn9YNrNMAfxFUlE4Z4s=;
        b=xAlUzSDNFRN70Q0YtA7sJ+FZQoHNfAUHMYMbULMmPRJAVgbsO3M/C+LA5HPx9VsqR3
         +XC09QUHGVVZT4JZkDVU/lyZIwnFJ120YGXL9fr8onq8KQiK6SlQW3WD47lvMurvmA54
         NzYsXurSu4Z4uh6xYrNlUEgW8BKJ+6N1zB5YbhGAuXpWW3nWMbexeK/G5WqnCuHJOEDL
         SamfmxeeVY5g0s1G/D43nnN6jAmoB9nMvJp2SSTloSeMZkt8AxzANBFS3Cl6ImZmafpH
         NJ/zNxOKFWYky4RYVVl4BExxxZyVm4Bmb888uwNb1i3xe8Q96wOZ/vAxN2oPzhFoIveC
         +X0w==
X-Gm-Message-State: AOJu0YxnI/nn0vFrsf1F53Z4U6VqLhwx5+TlBQYf2meZafB11NtJJmY9
	X9gqcHx2Uw+SOFb4JjAoIPG7k566SED7yLLiCur3Jn38anJxTxwGs/UDw+asjC3+5XcQFhxzTgP
	YARkyFgEJy7i3Uwt7apb3PtVmP2ubwai/s6yGGTEf8TxFBK8GbzZmxWfRIhFeTWHAvtgWuehAMm
	FFyIV6pAi71weR4Y6jMmYW+jyasWHNMbzorqe//i4g6G2RxTb03IAOoxwGGUFah3nv
X-Google-Smtp-Source: AGHT+IGTsG/QkxhUkAq4Y8PI1Gg687+Ta8fcWxxml2Va+XeadHk6RxnhA6azN2P+T7dL4OJpDksvlvc3wfheXnTpexE=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:76a6:f58f:c4bd:5bea])
 (user=pkaligineedi job=sendgmr) by 2002:a05:6a02:4688:b0:78b:4703:179e with
 SMTP id 41be03b00d2f7-7db0beee89dmr324a12.10.1725990799967; Tue, 10 Sep 2024
 10:53:19 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:53:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910175315.1334256-1-pkaligineedi@google.com>
Subject: [PATCH net-next 0/2] gve: adopt page pool
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com
Content-Type: text/plain; charset="UTF-8"

From: Harshitha Ramamurthy <hramamurthy@google.com>

This patchset implements page pool support for gve.
The first patch deals with movement of code to make
page pool adoption easier in the next patch. The
second patch adopts the page pool API.

Harshitha Ramamurthy (2):
  gve: move DQO rx buffer management related code to a new file
  gve: adopt page pool for DQ RDA mode

 drivers/net/ethernet/google/Kconfig           |   1 +
 drivers/net/ethernet/google/gve/Makefile      |   3 +-
 drivers/net/ethernet/google/gve/gve.h         |  27 ++
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 298 +++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 313 +++---------------
 5 files changed, 374 insertions(+), 268 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c

-- 
2.46.0.598.g6f2099f65c-goog


