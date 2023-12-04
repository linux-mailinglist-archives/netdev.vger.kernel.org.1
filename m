Return-Path: <netdev+bounces-53620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06160803F0E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84DFBB20A3E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2F533CCA;
	Mon,  4 Dec 2023 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBnbKwgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD85C4
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:12:40 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c5daf2baccso71000487b3.3
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701720760; x=1702325560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y63sRH03VakaPo/Lt9g0fnAD/Gnn8ok7qeDnLJyPB0M=;
        b=WBnbKwgtG+yjUxwmkBh3OWo1AqpYcIhh+AZrDoxyoSdoJZJAz8XIQzsk1lYOIHpv5U
         CV1iYjDpJuDLjrV5OdHxCQy0wCENi2M3BkcVbmkq8vYP4MEOZhILS+ED7KkgyBm8tHjR
         iOO/3EPeguIN/b+3nwNnLb9v5X8kX0pbIcgoDgKlE2rbGM0NFzaKMTpQAA2O/5HfvIgB
         +sqlzAgTDJYuGecetoig5Xh2pP+JGXBiqTrJHnB3Nzs8TacG5woyCDY0+BsAapl6hVXU
         OswtAyLy1RZcmTs7dp6ldXNd4jyRxXLTFemb0I+XBruzOjCwXYd0aNA3FXa79DoV1oxM
         KGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720760; x=1702325560;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y63sRH03VakaPo/Lt9g0fnAD/Gnn8ok7qeDnLJyPB0M=;
        b=OcrXpB9ntwEz4GwT1DzJJ/kWgbvkdXWw2cY0ISL21bKD3P8kh31rpxpfQQXYE45eob
         fg3InrOBq5nCEpi7ZTyso3wkjHleNCWlXkPdQ2LdoCpEHWivEVTM+sbuAi+6hmDZjUYF
         AgX1uLJf2+jBPHPqMivtYpe4WQM85Kj+5Mo82yz3gUXWtII3h+nycJy/SWVXtg86bdnk
         epa9KV5+QM+x75zS//EFwXKaNkwkO36/DP5/L0n8Y7sF6CtOGJRtRRkO7vyO3f8yv+Pt
         0K+NpV1vNTgBb+unpMWnm5bviDag2LxD+cVf0SWVwgFKEf3xf+nV3sGedxxwEhuOVe0y
         braA==
X-Gm-Message-State: AOJu0YxUekltkS5bwfil31M7l0aabc1uiUaHAftm+i+cJRnuwWJ3uhUr
	WijA2WhNnrMrpMKrYk4jX9yTWVZEJshctNE=
X-Google-Smtp-Source: AGHT+IEYQxx0fIfDy4Z03PSLWOCtxUZCPzJ1n3BdKORMTEWLbjmVrdmaDTfkh7rkpTbyotcSP+yFz4ZtrikZoXc=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:690c:10:b0:5d7:efdf:7712 with SMTP
 id bc16-20020a05690c001000b005d7efdf7712mr155448ywb.9.1701720759861; Mon, 04
 Dec 2023 12:12:39 -0800 (PST)
Date: Mon,  4 Dec 2023 20:12:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204201232.520025-1-lixiaoyan@google.com>
Subject: [PATCH v1 net-next 0/2] Reorganize remaining patch of networking
 struct cachelines
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Rebase patches to top-of-head in https://lwn.net/Articles/951321/ to
ensure the results of the cacheline savings are still accurate.

Coco Li (2):
  net-device: reorganize net_device fast path variables
  tcp: reorganize tcp_sock fast path variables

 include/linux/netdevice.h | 117 ++++++++++--------
 include/linux/tcp.h       | 248 ++++++++++++++++++++------------------
 net/core/dev.c            |  56 +++++++++
 net/ipv4/tcp.c            |  93 ++++++++++++++
 4 files changed, 347 insertions(+), 167 deletions(-)

-- 
2.43.0.rc2.451.g8631bc7472-goog


