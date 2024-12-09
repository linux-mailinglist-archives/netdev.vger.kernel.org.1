Return-Path: <netdev+bounces-150291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD29E9CE2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E281887AD3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBBC153801;
	Mon,  9 Dec 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPskma7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4114B97E
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764992; cv=none; b=rEllI/fSfBc36wx5d3eKfozvTKVBEi01dp2o8z7kRbnRuXKenlWeI2fFMjhhGmYv6S6k5HWQPU0Fdf1z+/ZeN/iMt+4vfprPiVLEJKT6DZvre2IKTO9Vz3Wqcd9tEYP6/H4TIxFSudvpAJA7DHN8vBK/mm+4ZuitviV99g9H+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764992; c=relaxed/simple;
	bh=6WuUUwH3gHhkqL6Geg5HTcFT90fV2BNuVfb02BCAuMU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nm/Nb4Q/WpcdlASyXqsLUnguImKqlmbeLFw5cayj6BptZHVf3Zx12ZvJ9/jmqtYIggapstyp5HxCKgAJxKPxBNORMkewPsh9D/2grrO5oxT+gnsbYs6cK/bMSu6jQmcKbNBAEj0SdQb2jptZo1CoZSzhhEaaKkufgdPva1uKAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPskma7b; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9dbeb848so1558447a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733764991; x=1734369791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vcu7R+0hVbbFouwgTRPW+Y/QQCHn4WyI0pgnS95JVB4=;
        b=UPskma7bBrTTx2psswsHGiAO8G1d6ELmuHRwkxNMZ+n4rCO4m8NqT4vpBQG9zGhbXo
         XJ8xBnJcLxMrXCKJzbyqeKINAcWoLvgUOtteYodrAFF/LwK/R3z6hbDJngvq2eGHUUJ5
         kXyHwyP9aSpWOSUc5lCnBoZa0qnITuxTpfOm0iYgZbj2gzdCgK+BOzwLk2mkvIPvCNK/
         KZbXSv2Hr6pbhagE7dt144bhkcyYro1gg/rjvZBE3gT5TqTGC3YLTUR+FtxkgrspNboy
         hEiGwOOCpMP2nDxgfRbn+T5RXl/KehMnIh3/p9ggf1TzXrdJenwi0N/bXfo+NYElygCu
         bTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764991; x=1734369791;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vcu7R+0hVbbFouwgTRPW+Y/QQCHn4WyI0pgnS95JVB4=;
        b=AANbKzFIEksjHQf9mmklO3Zlxe1ZnVI1Om3n/mX7CAVgo5MDRvNpr9+O5QSQqR9NLA
         YYaHiih0+Ef9sQ3M5yQCsBBGBsHiVrzQ9pFQI8oa7+6frBuGAimCBygKn9+W1l1x9CUB
         1WJ9wPMQazIJbzR6DJSa4Kgnd/wtqklXmaE+DT3SH7mWkqOUMazGsBGv1iqoG6F2JFGk
         Mh38YWV6IBgDc7RJZ8/HVi1rGyghXjF7V2L7iZBLUuUvYn1tyBwwgiMldMiNzdkM/Ut/
         k0RxVgsjdJ3X1fm3eV6HjZHFrOL1Cqas1VV3tGb5t4g2ei1jxzO/LudpSdeHDfHptOio
         koEA==
X-Gm-Message-State: AOJu0YyzPCi8JEbiTsH9QTlW3LZfLdHh4cfo/midkhkHBiL6wcktfsoC
	1OYPIiDSKHqmUi2xyoyv2TyNsAfRcNgbsmjzdgB2kQvqRYVwU5L84nepFpFAwoEIpIfbEkkYN+k
	wJbIyYYgCqZpJpnpkiyJybJEYlWAzozOc7ajwNbGWGqaWHcxqvH1D4z3tYvXMJCobvJo4FSOB6P
	pjpjji1pF2DmNe24CX9dtJLbm17UK/i8MSdYDWfJGHAm8fPzF0EU/yzDbsj7w=
X-Google-Smtp-Source: AGHT+IHwFdgtaA5CQfgLnW5VETq5BsceGrsp8a1IVqplrBkmkNvV7iaPoDLphNxXb40d3+EXo1QIWhIXC3RmqoXH/w==
X-Received: from pjb16.prod.google.com ([2002:a17:90b:2f10:b0:2e5:8726:a956])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:380c:b0:2ee:4b8f:a5ac with SMTP id 98e67ed59e1d1-2ef6aad12b5mr17501893a91.26.1733764990550;
 Mon, 09 Dec 2024 09:23:10 -0800 (PST)
Date: Mon,  9 Dec 2024 17:23:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209172308.1212819-1-almasrymina@google.com>
Subject: [PATCH net-next v3 0/5] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Couple unrelated devmem TCP fixes bundled in a series for some
convenience.

- fix naming and provide page_pool_alloc_netmem for fragged
netmem.

- fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

---

v3:
- Add documentation patch for memory providers. (Jakub)
- Drop netmem_prefetch helper (Jakub)

v2:
- Fork off the syzbot fixes to net tree, resubmit the rest here.


Mina Almasry (4):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  net: Document memory provider driver support

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 Documentation/networking/index.rst           |  1 +
 Documentation/networking/memory-provider.rst | 52 ++++++++++++++++++++
 include/net/page_pool/helpers.h              | 50 +++++++++++++------
 include/net/page_pool/types.h                |  2 +-
 net/core/devmem.c                            |  9 ++--
 net/core/page_pool.c                         | 11 +++--
 6 files changed, 100 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/networking/memory-provider.rst

-- 
2.47.0.338.g60cca15819-goog


