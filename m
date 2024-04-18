Return-Path: <netdev+bounces-89453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E68AA4D4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 23:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106A01C20F0B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBE5199E81;
	Thu, 18 Apr 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7PgwZ1/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849816ABFF
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476764; cv=none; b=lnAzconHDZpOVGG4sgY36GHmIoa5lhaHmTod5X8r4E5Z95fEms5ZT+WL+RLjepeR4MjhpIp398H0Tz/gLK4N6gAbAbQuFEa/3YqezL9lI+SL8jRwA7hmF+hVxkfUY5fbKwJvMptpySEmCCH8UmEms7FcojCajtQZzJ2u9gH9qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476764; c=relaxed/simple;
	bh=aFn9ZL9qTM+3EKdtVahbfOc9tjhQxenfRTVH1gR5n/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=daNHu5PxMCwFNc0HAC/F1QJSbSOxWFHcXFsfhEzxYObNbZzSPGQ0dc6SaWe8BZaM0PUGwf0Zf7tvPTLrnjvJMV/eNRXxF/dExeZ+DSoZ4qKHS/5xKSmixMEBZvuH1d7kGq5M5SGbhJ7EF48IGOUXCpEH7sHJcM/380temMRd2L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7PgwZ1/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45d0b7ffaso2695934276.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713476762; x=1714081562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JzzXC48mMxK1BBdiO/OWVtFaVGIVYI26biIbnCMRi4=;
        b=f7PgwZ1/QMyU71mJOkDsG7gRnapy24t53LLdio/Rh7ryOX26a/gXBo+hvxe9Zvr/f3
         sESD9VkIhEjG02Liks2eT7pSXNPdd/Pf1tyne/Pav5ikkoFONA+wmXHKyKlswFvMFQEu
         3MuUNhdeoEyKEr64aatd8JNZWG9dwL5Rz9D/ya6kW+E0Ami45XNKet1cKANhK7Yeph8G
         Gx+8izDSZnONaKI4CDjqzFiq9hIIn+/wlQDGI212BYixEyWavFUi5nmdZEUJYBjAMYOh
         uU+OiCBggZYOWZSi5DcYOGTK2zRzQbey79zbd5iczPnKDniVow/DAlrwLPirL14+kBnv
         HSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713476762; x=1714081562;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JzzXC48mMxK1BBdiO/OWVtFaVGIVYI26biIbnCMRi4=;
        b=AHcgmYPOZMGfzq18LRJZMMe9M+OR1FtxuGAneVGapU7X1UoWYZYk/J6pyOI41LO82N
         iIrrRlzvNkueNrBjMxzOza3Q74X/iH3bR3MNYJnZ+Wx32wfkP2TdigV5IL77DW4IDMX+
         DRMN+qkgnkioARnfDVHiEht1wwqEctoYqlXyf9iN/8XRRbMtgn1tlwuoghxjxHnMUejV
         L5yDSg2mBLyCglVAlNky6FTl/0vWYTvELNFnqSQdLipRTvHExQGoQrfau/1XH13RnJ7N
         Vbr629PZR2e6X3KS1FhZXirPxrZsodhU0gTDRGvTv8pZVLHcl84cWSje0xXmxC/HthoA
         1+9Q==
X-Gm-Message-State: AOJu0YxlTxD0K38Uc1D2luRchdfPyLCMaerd2aVgkilh2NeCVaPKQrDD
	0vqQdnjatfwgidjb76DOpAYHjrD8MIWal/YkPCOOmAlpbN158/mKxw/TS/JcMDxLY8Mzwycu4WI
	x1BHqabwuMw==
X-Google-Smtp-Source: AGHT+IHJwu3FUv8zhOdgpV0hr08Z4QoWQyYIQc4KyXSTL0B/3TdScu+aP1+4xaeyx5gxZyN0nyh+VVsvg03fqg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b8e:b0:de4:7541:4793 with SMTP
 id fj14-20020a0569022b8e00b00de475414793mr13539ybb.4.1713476761873; Thu, 18
 Apr 2024 14:46:01 -0700 (PDT)
Date: Thu, 18 Apr 2024 21:45:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418214600.1291486-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] tcp: avoid sending too small packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kevin Yang <yyd@google.com>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_sendmsg() cooks 'large' skbs, that are later split
if needed from tcp_write_xmit().

After a split, the leftover skb size is smaller than the optimal
size, and this causes a performance drop.

In this series, tcp_grow_skb() helper is added to shift
payload from the second skb in the write queue to the first
skb to always send optimal sized skbs.

This increases TSO efficiency, and decreases number of ACK
packets.

Eric Dumazet (3):
  tcp: remove dubious FIN exception from tcp_cwnd_test()
  tcp: call tcp_set_skb_tso_segs() from tcp_write_xmit()
  tcp: try to send bigger TSO packets

 net/ipv4/tcp_output.c | 78 +++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 25 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


