Return-Path: <netdev+bounces-84543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17158973FE
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4AF1F23BE2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB38814A093;
	Wed,  3 Apr 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kowoGhCw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B024149E14
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158130; cv=none; b=VEpv2f4kHt1r/PPgk79ZSy3YqYo2r9oGfdMwwIjtUAleR7quKAYoB6ii8Wqu0b+89+YAvg0s/HWhTX7uPRZUt1FowCbqNE87Pr0eshY5CC0RKkCVgQld1hhGu71ZgQ61x9WJzTvaf9FSEMGb7P+YeBmEI2h2VFgg9+kL9F13jB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158130; c=relaxed/simple;
	bh=au/n60d5o6R0Kg5LapZUOk8iQLSXKBJCXWfesQIY5TA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qdojW7JHGx/vhtLFRCLcJDqtu/DYesG14Q3PtK+uQ12EBSUULn3YB+L0zeq/uwR5FZbx0EJsjmbd51xvvinGsQj88E3v3sPYatrHNDC9BuziihmzxYmzxTUwjBTg9CahXPQZbh1KeR8OJHDDSKT4Wchxb8Cb0TN7FsEcxgny9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kowoGhCw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso499493276.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712158128; x=1712762928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=17B2Qf1CXAMUr3W4NJMc8Syb3k8HZV8FdHJlTbMts80=;
        b=kowoGhCw+51vtxxrqsiyqKTsxKCElZEtbgCnlvA8bF0brJp3UF2SX7JsjR+6QFc0FP
         sW0ju6NMAUXluiZMfmXajsxIdVG4AdiXaoz7tx4sPWPUEEbaYtJN9qzdQVQgPfLSNcYk
         Xrf31oYkj29CmG0s7/tnUz3StCaGN1ML7VE8jQPRk3EG/qcbYcW9nrlHAMsK692Xokop
         ZWwMgs5DdYAY9TeUHwNAUon7IpkQ4fRj+/hMwl3CjCVjOiqvrZoumrwKbzlli0jSztAX
         ipR4FdDYuDEyYCJw1GCwEz63MbrF2/IwJTKTuwOp10lNrXa7WKRdusAypLmkGgypEAXT
         wk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158128; x=1712762928;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17B2Qf1CXAMUr3W4NJMc8Syb3k8HZV8FdHJlTbMts80=;
        b=VKw21vme+sKxztH8Jwz5mNZnlNC0/id1jF40yfJ9a01w2ps0FqcS4RRs/+F9pAI+Sy
         emsQFkgHVAsBPGQ0cMXGQvlktujrI6x17TUlZwaKr3BY2rvaYvqjj6xb1O5FbFUCfjYI
         7NDhPAtST2OpLS1tVrhi3AY7MvpjUEh82KffVe4A0Z1jFbunfcm5pTWBuXyGXgEw4ePf
         86vYVUlmVvCKL1C0WJ7GpMKZeiN8r8qYmZu+5frDWoA4p+hDBNruAqMHQhoZn44MdZEA
         w9E1xK1AHdd57Qi1o+YH+CMxi0Js6/27OOjU1n3AHJy5zrqmflOcp7F6udnqNsz1WnDU
         sPtg==
X-Gm-Message-State: AOJu0YxMwWC5VYt3/KmUP5zMXE+6D/WGrPqpZFjI1rTr7TEFlTrtJzr5
	fRW8C0kmPbCwmkUwmatdW0sm3vBPwmSuThfbqv6ZFDemLPJpxHS7hLvBpIgZ7bjwtnCN2mHvg/P
	n+B/7kXOVIj/dX5K6uGiNcP3iPO7Gg8k0615c/G1PUloaM47TBbxy6VRDHij49Gcspm4NBYMKAl
	FQ8s7TzjYKPGaqbH3cS8C4yEkA4UXmMLEz8N+We/XCmB0rTqFb6gYZL8kgtkk=
X-Google-Smtp-Source: AGHT+IES94MYmNH0qRTfB9Viikhf7iKIYv01lI0fxWY4KSu3Qedos7mJwzWleReGCKpLYhaMFtiAz4SRHX9ukUKvbA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2b88:b0:dcc:2267:796e with
 SMTP id fj8-20020a0569022b8800b00dcc2267796emr793904ybb.2.1712158127831; Wed,
 03 Apr 2024 08:28:47 -0700 (PDT)
Date: Wed,  3 Apr 2024 08:28:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403152844.4061814-1-almasrymina@google.com>
Subject: [PATCH net-next v4 0/3] Minor cleanups to skb frag ref/unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Florian Westphal <fw@strlen.de>, David Howells <dhowells@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"

v4:
- Rebased to net-next.
- Clarified skb_shift() code change in commit message.
- Use skb->pp_recycle in a couple of places where I previously hardcoded
  'false'.

v3:
- Fixed patchwork build errors/warnings from patch-by-patch modallconfig
  build

v2:
- Removed RFC tag.
- Rebased on net-next after the merge window opening.
- Added 1 patch at the beginning, "net: make napi_frag_unref reuse
  skb_page_unref" because a recent patch introduced some code
  duplication that can also be improved.
- Addressed feedback from Dragos & Yunsheng.
- Added Dragos's Reviewed-by.

This series is largely motivated by a recent discussion where there was
some confusion on how to properly ref/unref pp pages vs non pp pages:

https://lore.kernel.org/netdev/CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com/T/#t

There is some subtely there because pp uses page->pp_ref_count for
refcounting, while non-pp uses get_page()/put_page() for ref counting.
Getting the refcounting pairs wrong can lead to kernel crash.

Additionally currently it may not be obvious to skb users unaware of
page pool internals how to properly acquire a ref on a pp frag. It
requires checking of skb->pp_recycle & is_pp_page() to make the correct
calls and may require some handling at the call site aware of arguable pp
internals.

This series is a minor refactor with a couple of goals:

1. skb users should be able to ref/unref a frag using
   [__]skb_frag_[un]ref() functions without needing to understand pp
   concepts and pp_ref_count vs get/put_page() differences.

2. reference counting functions should have a mirror opposite. I.e. there
   should be a foo_unref() to every foo_ref() with a mirror opposite
   implementation (as much as possible).

This is RFC to collect feedback if this change is desirable, but also so
that I don't race with the fix for the issue Dragos is seeing for his
crash.

https://lore.kernel.org/lkml/CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com/T/

Cc: Dragos Tatulea <dtatulea@nvidia.com>


Mina Almasry (3):
  net: make napi_frag_unref reuse skb_page_unref
  net: mirror skb frag ref/unref helpers
  net: remove napi_frag_unref

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff.h                        | 38 +++++++------
 net/core/skbuff.c                             | 55 ++++++-------------
 net/ipv4/esp4.c                               |  2 +-
 net/ipv6/esp6.c                               |  2 +-
 net/tls/tls_device_fallback.c                 |  2 +-
 8 files changed, 44 insertions(+), 63 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


