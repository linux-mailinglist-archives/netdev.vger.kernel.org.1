Return-Path: <netdev+bounces-70267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D3A84E360
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBA21C262AB
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC279942;
	Thu,  8 Feb 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6FECP8r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D378B75
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403408; cv=none; b=IHxkvlzozaRJxKjqoC+r7izj0gjOqBIYP8r8f8xzrav0CNLkELKOod6GFKXCdLYBAqInifdiyOs5gxZ/XgHV9Nul0uRUvgP+kvjb0SZ9NzfCmq4N5mmvtpT8QCsEAHCLysU5RX7dhwPhHBwLzLSBXhMqYpow2A/jLB5AAYw21vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403408; c=relaxed/simple;
	bh=pCYNjfstlb4jKwI1KW9Nrlg9rEEdGxlyKMgQM/CJJsQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ts7n3vn6XluoQzLOGfCSgB3oNjEKrGBs3db2Uxgaa7f+ssBygdUyad+amv4DOx0U2WijR1RXJsSaoV5Sl6G695Zd8CyvNREqgac4Iua/i1JVLRp7nc6gCZUhL12f1qeLej/D/rs6YLWXKnxbpmN602RbVGsLVQMNsinwOvDtclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6FECP8r; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-68c4f4411f8so20419576d6.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707403406; x=1708008206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PCPnpMCmyUTB6tiTxjO5UUfHysvYBygm9etO61LRCVg=;
        b=D6FECP8ry5Dt1Z/MNUq4JW/LaZnp6yZNJyZdQ/nI47/aumHGF4nfT4P1oXQPrQh+M8
         xTPA5hU95B2xsiGDgMYlT9ss2e2+s3T7hcN/eXfs4JEKHEpcRkrszgzLjVzW7kszA5Gj
         nZY/oWXyd/f46v3Tgst+sKuIueHZqvBgHkDKIv7n9RrJLSZDetuQPxH8E95irjwlZENo
         8qhsKzLIUYrzP8zlBefMAE0U1OoaaytOGFK8EPt7CQywCUjXelW5jPX5jG+T87/IJVvl
         AjrKU46bdOKCplMbOpReG/Lh6NhdshqA1iVllcS5C7ioNFve2Vf0uIbJy37DfCUMp3td
         hq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707403406; x=1708008206;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCPnpMCmyUTB6tiTxjO5UUfHysvYBygm9etO61LRCVg=;
        b=pgQMma/Crku1x9Fs/ldmRbSDbQjOkMBnWy8Y41CirriYarnO6t28JyPYqsuy7/pPzE
         E7AgxsHC7YlaZvrrySfBoV71KDktMdcrfBHoEjAAqws7+AMI3RWM5oyE3kuCS76Vky75
         QFrhQ3XssjVFJGaBEQ3KNUHTyWzgL5ixxLzWTn5PzDlUwTCSdRBnfvUoEn5jh0+3XbQP
         nPNI52+rqcz4OfH8WaKcDN7dG6Pqy98VqRDeF8EmBQW0x9nGFuwHOkzwm9BH8VgCvfi+
         uTchIls+34CMaU0D5z0lIqFJknhHdBo7ftk/NjtA3rKMkQXnA4hat3tPhzgml0jlp0nc
         KAUA==
X-Gm-Message-State: AOJu0Yz9ttKxNvcTvzWFf1XSbNxCavZXVVaiTMU4pR7iif5PvATqa6G1
	mlBQmbhvnKmwEfBFuDx6D5XbGimgyt7ncmkuNdQ/igHkb6s8Xy1V6pDCz6piZEwDo/V6byfUODy
	nL306pVXHaA==
X-Google-Smtp-Source: AGHT+IF4l/wwD5wJwktZRy9xJvzy+9ghxsh0ZGpj1seG3HYt1HI5Y6fmLRasOwJqPfSeXBxC2SQwx9wFr4qiag==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:2688:b0:68c:aaec:10b8 with SMTP
 id gm8-20020a056214268800b0068caaec10b8mr135336qvb.3.1707403405863; Thu, 08
 Feb 2024 06:43:25 -0800 (PST)
Date: Thu,  8 Feb 2024 14:43:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208144323.1248887-1-edumazet@google.com>
Subject: [PATCH net 0/3] net: more three misplaced fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We recently reorganized some structures for better data locality
in networking fast paths.

This series moves three fields that were not correctly classified.

There probably more to come.

Reference : https://lwn.net/Articles/951321/

Eric Dumazet (3):
  tcp: move tp->scaling_ratio to tcp_sock_read_txrx group
  tcp: move tp->tcp_usec_ts to tcp_sock_read_txrx group
  net-device: move lstats in net_device_read_txrx

 Documentation/networking/net_cachelines/net_device.rst |  4 ++--
 Documentation/networking/net_cachelines/tcp_sock.rst   |  4 ++--
 include/linux/netdevice.h                              | 10 +++++-----
 include/linux/tcp.h                                    |  6 +++---
 net/core/dev.c                                         |  3 ++-
 net/ipv4/tcp.c                                         |  3 ++-
 6 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


