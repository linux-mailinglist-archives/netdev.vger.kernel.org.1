Return-Path: <netdev+bounces-62540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48489827C6A
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 02:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684E01C22877
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EDAA5E;
	Tue,  9 Jan 2024 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPYRu+Ps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEFA49
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbed0713422so1469910276.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 17:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704762898; x=1705367698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdQGlntYSzgRkKM7jC11IrH2xPiRiy9sKIOQ0dx3oxU=;
        b=DPYRu+PsJCAFpiYsTIVJri6h/w/fy1uLSciFjMiyn0DgMv67ZaMPgLC+tBryUPjgZi
         iHDPMWuaa5dNqBXYeBo1bjCvNUpksrU0M75Zp+Nx9AY34hTx8qEvFftkrgEUMQ/L3wzN
         ORI7byvmSPVgOXMz4vgLaI1GBG3HzEKwGsJs9rqKqsj+V092lkRfvxjWdbDy/Gel+HoC
         RtKkzR6/lK/LZqn3wF9jaBsVQITIqVyGA1V5S9GqkBBEilcU8KF/77CjO2noSKlg0lnL
         FASfb6AUcecNkGmG6OZuiW3n3H2qhP9Hj0dAssVbjpSC/rDI867RhikSeRwE77qrbnfW
         B2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704762898; x=1705367698;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdQGlntYSzgRkKM7jC11IrH2xPiRiy9sKIOQ0dx3oxU=;
        b=KsLRe47nxz4G/Ni9yJmrS/HMaR5uu8MULotgIWa+8qhJrGHRZ0+s6+YrCDIgfbAn7n
         QUccNYx+e5gwZ03YlnQzfIZi3pU/7y2Poqrj7H+Wfc3FCMss3MRQOumIBS+Z+bW+UIZD
         09jgF18EJlBfro2QA14Dx5UvOD/UYyASkBZ47NUCyy3xIQ4frkq8PhmaO428mT4jkk+v
         YNc1B5c1/fVMN+88hmOwg6x0Xt+HgdXUeqBGl9HgY954vRa7/vfDUi/WV/67tcjcRqLz
         gMh705hM57jw5i/r/HlAM9SH/rbcMJSHmwsTY84nYlt2BsjEZym9XJViN96EkJjRq2ua
         5AHw==
X-Gm-Message-State: AOJu0YwyzPJeqSm+RV54rhsDRs2g8TC9XTfPCWgj5qlpVVagDak70p1y
	c9ycFZ2SMBkmEKVcYYf3iDSNCywf/wxRRIaJxeH+MONn
X-Google-Smtp-Source: AGHT+IFMTcfam3s9iBf+3ewuAdxMqQhaLRjfMlYY5+2Q4BQfnBf+FFxy45PTQYIZJUCx1Q+SONv8RGq8ht5mNwSSUw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:23bb:bfcc:9879:32e2])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1369:b0:dbe:ab5b:c667 with
 SMTP id bt9-20020a056902136900b00dbeab5bc667mr126227ybb.2.1704762897875; Mon,
 08 Jan 2024 17:14:57 -0800 (PST)
Date: Mon,  8 Jan 2024 17:14:50 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109011455.1061529-1-almasrymina@google.com>
Subject: [RFC PATCH net-next v5 0/2] Abstract page from net stack
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

 include/linux/skbuff.h | 90 +++++++++++++++++++++++++++++-------------
 include/net/netmem.h   | 41 +++++++++++++++++++
 net/core/skbuff.c      | 22 ++++++++---
 net/kcm/kcmsock.c      |  9 ++++-
 4 files changed, 127 insertions(+), 35 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.472.g3155946c3a-goog


