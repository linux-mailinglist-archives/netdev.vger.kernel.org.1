Return-Path: <netdev+bounces-71862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C17855602
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5861F23F0A
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3671420B9;
	Wed, 14 Feb 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PORiuqgN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3527453
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950050; cv=none; b=q6B+K4hfL0h+AS3juJe1q5C6N9pgtyE54YCnbEgDn7qqQjADDNcL3D733HdCEhq4lkSwuQoJLZG3Iu64GUerXWyUQR/j6ba1vh8REwDnEmU7enKUfDbO0i4DoAkShMvUG0cUnYfYYVuMq3jne+yLKllWDkh3f3iMahym/Oo8hOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950050; c=relaxed/simple;
	bh=92FzybQ0k/QQSRZIXOZq2u6SesnBUJmYVfIEOiul8QU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j8MZVeZbFN6xyYq5doTym8hjbBV5BexsJ828M17IMHgMbfDHi86Llg2ZM9RjI4spjYKcHUJ+R/f0A3rdfo848KRYEkFon/uBGK1JeBG0m/+iirBk39+AVTGiVR7iL/ve+seINbQ2kHWtUtEzX46EaNFllWSQurOeQ1uEl3z+OCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PORiuqgN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so625580276.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707950047; x=1708554847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cbBOEAdMKtHU21rqPFfqL7h7M//5Xm4Ynv7hO4s8OY=;
        b=PORiuqgN3YpORj0iB3mss/O3GREJn/8JAup3hW5Ar1YheIU/lKh6mQ4OdrfdIcWtCW
         r+x4SicyAcNiJwRhONgr6/uw5A4DU+5AaublgXqc1j5WlNnLZk6/adCh4X7BuFKJuhh9
         Z5uaBJoRTXMycgh51i9+agg1/wZpW107E+qdHe/yStmrpQcaCJCtuiJpaIw/bKLYeE/q
         5RsPS1d7OvwL4n8tGbaEwOf6ruyLiU167CD1bShhTSPESbTiPC0KNH9Vjl8qQBKj/QPb
         F+vx7brNzdjiGYM1YS9fDYSaJbasHtxlOgZRz363XnORSmNRHA3ci80kMDSWEw7TPdAl
         UmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950047; x=1708554847;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cbBOEAdMKtHU21rqPFfqL7h7M//5Xm4Ynv7hO4s8OY=;
        b=OUW6hKol7sYI1CQaW0A5JzJ1UJikFZFrjUqLBjjhIQd+BthrQjHdDNM7/jpUinZ+PI
         iJJoVR3AnaHD1ecILCbG2DXQm5rpNsqruGyTUCiLjHYwkMPyf7sJgaJ0ne0e1CgxBqBG
         lDKC3mNT1t6tc23H0SeC2KX+okZEHHe+PrJUldafGfJfBfFRgzFlnM2KbIzsbZW7q9LI
         /SQGsF6y9pfH41iB/pFKC+ioKIN3fxvOfZs6XwPyXCrruwqaqDSrEn0hc0XFPqbBy6hM
         PZ7LK9MPl5kQ6vPvVuIS5BbqIHK0z4Sc2jahco1h7BJ2wnJ8nKQwWN3y9+vPyNf2+yUw
         uidw==
X-Forwarded-Encrypted: i=1; AJvYcCW6QgCG/BX2iifeFmDua472pZZn7ObSqzRWTkQdmx+KX31TUO2u5JjS/jSp4kmvrPHQlzdXJgtdGp1gBkY5FP17a2CvOsf+
X-Gm-Message-State: AOJu0Yzx0dhFBVzGsbFgkUKYggCO5Uc1U5VrKQ4z/XXK2Mq3cdNVBlr4
	HuSW1GpFZvrPKzM3hv9O95+34MqqJrUtW7RBRdDtAFkbIdIPlYXuv4KqZYeFASf2OjYTdfyp2WS
	biLzPYuVGrbX28k/hd914Yw==
X-Google-Smtp-Source: AGHT+IEOSORb6qxpucbb7XFNLoqJ4v4xQQfWM1UzuHlSCt/LPMOKzRv0czrYkhgLen57vRBQVrdmEA6kMTh9iErNeQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:e4bb:b13c:bc16:afe5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:f0d:b0:dc6:deca:8122 with
 SMTP id et13-20020a0569020f0d00b00dc6deca8122mr588946ybb.5.1707950047502;
 Wed, 14 Feb 2024 14:34:07 -0800 (PST)
Date: Wed, 14 Feb 2024 14:34:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214223405.1972973-1-almasrymina@google.com>
Subject: [PATCH net-next v8 0/2] Abstract page from net stack
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Changes in v8:
- Moved back skb_add_rx_frag_netmem to .c file (Paolo).
- Applied Paolo's Acked-by.

-----------

Changes in v7;
- Addressed comments from Paolo.
  - Moved skb_add_rx_frag* to header file.
  - Moved kcmsock.c check.

-----------

Changes in v6:
- Non-RFC as net-next opened.
- static_assert skb_frag_t compatibility with bio_vec.

-----------

Changes in RFC v5:
- RFC due to merge window
- Changed netmem to __bitwise unsigned long.

-----------

Changes in v4:
- Forked off the trivial fixes to skb_frag_t field access to their own
  patches and changed this to RFC that depends on these fixes:

https://lore.kernel.org/netdev/20240102205905.793738-1-almasrymina@google.c=
om/T/#u
https://lore.kernel.org/netdev/20240102205959.794513-1-almasrymina@google.c=
om/T/#u

- Use an empty struct for netmem instead of void* __bitwise as that's
  not a correct use of __bitwise.

-----------

Changes in v3:

- Replaced the struct netmem union with an opaque netmem_ref type.
- Added func docs to the netmem helpers and type.
- Renamed the skb_frag_t fields since it's no longer a bio_vec

-----------

Changes in v2:
- Reverted changes to the page_pool. The page pool now retains the same
  API, so that we don't have to touch many existing drivers. The devmem
  TCP series will include the changes to the page pool.

- Addressed comments.

This series is a prerequisite to the devmem TCP series. For a full
snapshot of the code which includes these changes, feel free to check:

https://github.com/mina/linux/commits/tcpdevmem-rfcv5/

-----------

Currently these components in the net stack use the struct page
directly:

1. Drivers.
2. Page pool.
3. skb_frag_t.

To add support for new (non struct page) memory types to the net stack, we
must first abstract the current memory type.

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for safe compiler type checking we need to introduce a new type.

struct netmem is introduced to abstract the underlying memory type.
Currently it's a no-op abstraction that is always a struct page underneath.
In parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.=
com/

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Mina Almasry (2):
  net: introduce abstraction for network memory
  net: add netmem to skb_frag_t

 include/linux/skbuff.h | 100 +++++++++++++++++++++++++++++------------
 include/net/netmem.h   |  41 +++++++++++++++++
 net/core/skbuff.c      |  34 +++++++++++---
 net/kcm/kcmsock.c      |   7 +--
 4 files changed, 143 insertions(+), 39 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.687.g38aa6559b0-goog


