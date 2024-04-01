Return-Path: <netdev+bounces-83818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09A8946B7
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 23:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8247F281C19
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA355782;
	Mon,  1 Apr 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xqJlfgFm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586E54F9D
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008248; cv=none; b=napsiTZbEjcvLVmn9g2APl6DZQT/+Y7tQu8OSsAXuA/8Llxm4qmf+Dkk6ZwLatDQ31x045bgxG/UuHq1WUL+Io0KCsZsn3d4j3dDt8knr7kBp00Eww2FXuG3MzbsFdAGpKTFTIEJOHbUYsaycRclzpLK/3ulBMRJAErmc+btyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008248; c=relaxed/simple;
	bh=LvCBtM2YQSeJABfcqD051PDiGGBI0pmlfrMCxzUoMmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a8uVDqT9Eqq5zJiRdK/u0RHiQ1RDQTjH3oIbp+wW5I4KfS0ajlbqpG8Bm3TjxHg2KkvDMyOEEccMRW40fCLsnpJD1mULetmFq9c4BCRSRv+2aHFL9w6CcDua9z+A0cKZ0x0/WiJGJATaupzkZVxMPugbdcMP8qTTTdSUMgJayj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xqJlfgFm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a4ee41269so82239777b3.0
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712008246; x=1712613046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XLIDZpDBHrtC9mQGuM4295zuVNtkbE3PLQnEnnfrBMA=;
        b=xqJlfgFmw8EVSNp5ix6dcbeyrN7dLmOMFe9SHW+OycpRPRgMAHRgN2t5LerU4HRTdT
         KmTrH+Dk4u2rRCeuRD3GD/R/X6W3ZDBgF95+9kiqJ2I1ulsuINi0c55F0JSK7v0tHOHH
         5fVHW8PZ4eTjTLqREeHKCeaxxS0GMHCwWtZZ7uCn+j5eCpwkm3Fln1UBQM/YOZrjUNap
         89LDl067TluOt9qOfbERA1tzFi47zLt0YDEFJU7IY8+QjHQaO2D2X1+rxkjg5/4wV0Fz
         0BEuUIgSpyjQ73z9thH5OhAUZrxiIFff8QaSdDFXTzxRvVuOjhyDGaxgB+5D/XxdXYzc
         H5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008246; x=1712613046;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLIDZpDBHrtC9mQGuM4295zuVNtkbE3PLQnEnnfrBMA=;
        b=PQ5DTf4AM5vOIrhOcvHqF3CyKqXmNiv064ZIBp4cb0C4iH8Xw0Nw+5Dq/OpHIu8XFn
         Gde8k88Ah7ne2Aar+NToV6JejO0cRJZkDXGcvorXswigisbXLbFbdgP6DY7iI2tFzwPT
         AiyIQr0UaqkUJSHluuOcUWZZRlFSZvzle8/+SIBij9SwlYRwfww4L3pOpTf/81HQR5We
         GFk2C44fQshInoEDyo/hWSjSWv8u0pqUI/8Ts8IjzhmoE6A2sQQEN3iaIKRWuwCEeicv
         VNsr8z9hVFyTEuRWYAz/FiRa8+iJyQQGrSMXMg4Yp+dxrfqos/RI+hnUf8IXMQjuhUB4
         d47Q==
X-Gm-Message-State: AOJu0YwN86w11pPookLBRcGSAwQDM/vGZHRvCl/ikKdqCTSr2YdGszNc
	T+1btwP8Aqro5pob04d3urN+6AVDmyt+pi3bPogg4JCZJbaG6zwOhNRogOLCWE3uTIOqyfhtnmp
	Ys1DaCftdlWYFnzyNF8rNYmpGVFN1Ek8oT9ZORvGVp9WmMMq416GJfCfjMd4pNjRlxKCH4y4Shf
	o4GlUfX9eToxPO8xhmZxOwBwBhZh996luexFRx/qU4No6wEZFKsQNDmirdPoo=
X-Google-Smtp-Source: AGHT+IHruwWq4JyI/hLsIFHmVo+4Qge4gKmr6iKc/6xRaXQRVz5Jk7BCEwSZk+LRAFeal/Y+Ugr7hvswKysh+BY5+Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b337:405b:46e7:9bd9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2503:b0:dc9:c54e:c5eb with
 SMTP id dt3-20020a056902250300b00dc9c54ec5ebmr3429870ybb.7.1712008246111;
 Mon, 01 Apr 2024 14:50:46 -0700 (PDT)
Date: Mon,  1 Apr 2024 14:50:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401215042.1877541-1-almasrymina@google.com>
Subject: [PATCH net-next v3 0/3] Minor cleanups to skb frag ref/unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Maxim Mikityanskiy <maxtram95@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Howells <dhowells@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Aleksander Lobakin <aleksander.lobakin@intel.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Liang Chen <liangchen.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

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
 drivers/net/ethernet/marvell/sky2.c           |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff.h                        | 44 +++++++-------
 net/core/skbuff.c                             | 58 ++++++-------------
 net/ipv4/esp4.c                               |  2 +-
 net/ipv6/esp6.c                               |  2 +-
 net/tls/tls_device.c                          |  2 +-
 net/tls/tls_device_fallback.c                 |  2 +-
 net/tls/tls_strp.c                            |  2 +-
 12 files changed, 54 insertions(+), 70 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


