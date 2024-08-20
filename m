Return-Path: <netdev+bounces-120269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87223958BEF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B985B1C21AA1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13585192B83;
	Tue, 20 Aug 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vsMCI63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82218E345
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170143; cv=none; b=pkJslAZiNUVV8AYkbskhcuHkdNUyvuYYcfTiQvEyD+Fxj8kHe9bs75f5NizpUYJ9dSEaceI02tG1F0ByBGA+43BbTPQ9LhR7bsweWcriwcXE/X4BeyqrAcJa58OInenRPiqDL8nLszJ+phsqWbNOha5XhIDDUykAV50ZOvnllUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170143; c=relaxed/simple;
	bh=1ULWY9nupF+YlHGaM0IfFgrZ1dG7dFYweYOK47nwiF0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qneXrJbsUth4RURr+U+rE6K9+HTCcODz7ed0SAnyWQIh06b64bnMHg+RxroG1iIxbp9wgXYOjNLRz1ASInlIl6FP4fdTSPapNiJhVD1dwP2uRSngfYF8VE7SUjOwFWbHcuByMbur4QDuEk6xArWvP3dYIMmOxNiTYUFGhSuxahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3vsMCI63; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b46d8bc153so51637097b3.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724170140; x=1724774940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n+6imcf0VXTiuPdZwTe927CtvK3j92ZXt73bdDN7UKg=;
        b=3vsMCI63Z13vsHdFRo9IzG2eIcMcZx0PSHufvbYz88zVTD9RbRlibfqx6D49RjZ72u
         mMha6Ys5tLmUwaMEJIbK7X1DJFFNGRspOGXEfsiYF6PmZxHvFge1KJ8AMbf6sjiQQMgo
         4rHFpRBsldfCnm8VIz4aM0+HCXSEyUt943FGI5LTNbbjSTLxgYyc5r+gc+/EkOfd/5rB
         SqN/RmRG9bB90/wVPRyH/yeIIU/Fwt5vDiI/qNuuKAfIeGktX9wvgtE/O/Cg6tYhSjXi
         xH3HAu8JEDL24aJ9q0X/2tD/Y3J3wpB3WKScyPTWThd2/RT06u/tamuH+TD1eWZwCVK6
         NtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170140; x=1724774940;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+6imcf0VXTiuPdZwTe927CtvK3j92ZXt73bdDN7UKg=;
        b=YMRHT5Prdhj/Cf2Tg4vLHA1xzjISqSllcviWoebHgn6HRwUcW7uf7CLebxHKP7GoxI
         e8pz39bXWL1b/OvA6k+XeN08AvhY4DTQsBJQ9s/z1R6g5dD97Kv5ga6qtGmPL+3NVXoq
         M8UQkR3wQVRqmEHz7XrbZp1qn1gSUuDQY7SqHg7pBiHTBSoBKslV1MkhVpey9L8zZFl/
         WzZ6rX5qe/DKdEFd5LNziUMnVR4cHREHgSdATdtj8I8uHFBMOCjvuQ4z0big+oobP18o
         3H1W6U/gtXUsRHoekBeZdZ6BtHYUUW5h9NLR9PaZwnmeydGPYU/MnGbC9OfftcwulSB/
         p1DA==
X-Forwarded-Encrypted: i=1; AJvYcCXAmJ35gCNPgixODPhfpyagC3C8RReU9kCEUbG+OF8lOtdYbqQTHlwXJeMUSjj60TehHra9PoKwsj5QOm3hbFNvHou2vm6T
X-Gm-Message-State: AOJu0YxHwDXCWdemQqEmqRiCUkcPj/uVUdg14ME4KU5cNPz2BTqKV4gG
	1/7MyJ4RrDmvhRe4KREWFMdoQEGenpufmW7NdskJPLK0f/P8+f9vhIFqpIz0Xwgq68SAUXn0gR7
	MN4X7sdT0pg==
X-Google-Smtp-Source: AGHT+IH5KmVd4GsMVagxgGSNowSH273EIZQvfAuaSaSZ6f/Mdw/IxU/b1aEOdX/OJMvdSiNePPdIcJJybu8SYw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:9089:0:b0:e13:92a8:c3cc with SMTP id
 3f1490d57ef6-e1392a8c82bmr28317276.0.1724170140391; Tue, 20 Aug 2024 09:09:00
 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:08:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820160859.3786976-1-edumazet@google.com>
Subject: [PATCH v2 net 0/3] ipv6: fix possible UAF in output paths
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

First patch fixes an issue spotted by syzbot, and the two
other patches fix error paths after skb_expand_head()
adoption.

v2: addressed David Ahern feedback on the third patch.

Eric Dumazet (3):
  ipv6: prevent UAF in ip6_send_skb()
  ipv6: fix possible UAF in ip6_finish_output2()
  ipv6: prevent possible UAF in ip6_xmit()

 net/ipv6/ip6_output.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.46.0.184.g6999bdac58-goog


