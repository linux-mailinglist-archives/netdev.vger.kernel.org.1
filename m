Return-Path: <netdev+bounces-68219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314748462AA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 22:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559731C22444
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 21:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97C3D0AF;
	Thu,  1 Feb 2024 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnSH6l55"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86C3CF65
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823276; cv=none; b=LY/CUZqs6z87M+9CSeofmj3DeUYS3aBCV6tCxXy3BOOucc4rurzDZXbfutBNsyC6icoMRLHO94Qn0WDDS76iqIBdLb9ospfE1r+PkVONr6JRBzuCPLxPBbsXp2AHogeBaiqbUoEt6T+POsNRvnhLCG1d7ywloTodoiWJrAU2iFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823276; c=relaxed/simple;
	bh=othJChkxBmheJNm5DKHHpVRDPfcuYFKjGZGLn8qPW9I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iKtzMnvFveNL/wVJTTk31svYvvYduV19vbBJf6H7mjEnaZjRqnO1iTP/BShFK3e52C3IjBmMqKtWv26N9Vm3JJ/Ya7HPB4CxE4zXpLo3lH05EltVN8c0WmXQCh4/rGRZgd6vIpe15w839zaA9DEAgebrNFmmP9zZcVx3Qt8tuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnSH6l55; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso2465536276.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 13:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706823273; x=1707428073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ViG5JRGciituJwo/VatacnaZCd2kxLm23koW/J7133E=;
        b=vnSH6l55cc+8C8SJsOJ/8dsFwgGudD/dPnGf54fZCRLb+6AGkr+XJ/8/7+m/2AMjwI
         xbV1+IA4IO0i01PonVSTC2ydFaF2HteCuNTnAoRUTo/Se4QDPmAOwfOrzftSt9iuV5/P
         8GO8+70CaX+4XIkPM0uD92fr09COcqyEUNNmR2cGEiszTfImqZ+NQaEwV1u6ye3Ua8hC
         3zz93OmkWxFahE8XM8yzU2SjyMo9HjUl+yl83vZnR7jNu0b0McAojBf34W5aCl+puUxE
         uWsNJKHHCvXR2MdhkWsEnSlnYSiotUFfSLabTyHt+6Z78SHn7jugAU+mumWh68Li+vRZ
         sUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823273; x=1707428073;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViG5JRGciituJwo/VatacnaZCd2kxLm23koW/J7133E=;
        b=T8DcswQ5Fb07i1rci02BxANMSM1IgDdJJutVPkrtvt8v56bxcZvfczlHmHLbc5PgFI
         sLx57RxY8FO2Mrn94K/Ib+vI61fYUYnmeaGx2R6uYsn7zw5BvMdi6+LMZLCWzaE9byno
         rSuSkLbPnk1OOxBHuDcq3w5WfK1gGeN8rzqJjg7toeVwfJfLFkm9sZP6vsv3UiwjRd2G
         jEBcTMx061O9hdICrEhaq8A5NR9vnvtt2IP+z5j4myUQno34B+MqgSIBppJ7Sr+3cZze
         rzv+ReR0d8DX5WecSMxukkTOQY6vEVLw+ohkMX7N+n5Py30R+6GidjP+VQ/VN4Asy5sv
         0ZXA==
X-Gm-Message-State: AOJu0YwGmdJLD41kfHdAPr2UuS/8Hwv6ck22mSakwh9AI39wwYsjKmo7
	tZjRm9d0VxFuhpYkG64CVczfCcCATQPeIkP27iMR1O0dSR3FcDd2+iSBZxXiF4ujnCiKjONw0R6
	vJBSZzT9/N2tBY4CxLpa5bQ==
X-Google-Smtp-Source: AGHT+IEzX3RYmmtD9Y4B1vEpHmJFGz9iYxIeXJO3bzTkGXxn8S8wlekTjJL7mM7hsXictM8TmH+IYhSe2MKoK6V0sQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:4c26:ae83:34fc:80a5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:15c4:b0:dc6:e823:9edc with
 SMTP id l4-20020a05690215c400b00dc6e8239edcmr66760ybu.8.1706823273407; Thu,
 01 Feb 2024 13:34:33 -0800 (PST)
Date: Thu,  1 Feb 2024 13:34:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240201213429.4120839-1-almasrymina@google.com>
Subject: [PATCH net-next v7 0/2] Abstract page from net stack
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

 include/linux/skbuff.h | 109 ++++++++++++++++++++++++++++++-----------
 include/net/netmem.h   |  41 ++++++++++++++++
 net/core/skbuff.c      |  38 ++++++++------
 net/kcm/kcmsock.c      |   7 +--
 4 files changed, 148 insertions(+), 47 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.594.gd9cf4e227d-goog


