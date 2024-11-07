Return-Path: <netdev+bounces-143074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3B9C10DF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566091C2170C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C19218319;
	Thu,  7 Nov 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="221scneS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9621791D
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014596; cv=none; b=UqNPE5Sh2bmdiCT4c+/6aiWG4D8AKMy6RkhNGx8AxHmkb55uibqlHdKPA1jhZ3Q5v7TBatoDr1rznmWcOfg1tMfwPIrlR7TNv4Q88+Zf9v/OurP1GKTJwel72rF8BAccoFnsB06Y4raa59R2Xms8o5/nXBk2kB5O8aTSAJl+amQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014596; c=relaxed/simple;
	bh=B8lXU5/GjCAU9MbV/zhOPpH/Pl5WyZX8uw4PpD/WDcs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=APs1Zzr1VKJuLX5fK7lHFkuaLJBbZY+jjSDeAcITAPgvmLclxmd+2iK5l58Eo4DReS3yx0K6mKWM//qG9kGZzFLSJSk6vsIaP40AcavORuMX6/2Lt+dMTsthI6btkqWGcNFvz0I3c5TzCPsxzQj2mTEZDkRi2B6TAxMyp6zvrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=221scneS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33140094so26364457b3.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014594; x=1731619394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U0hBZkKcHVOYvuhh4Gtl3CCQegEWym6RvcOQyQxM+FY=;
        b=221scneSF5tvGID6TYUz4NpPlBe2+jjdN0SRcATWtmxnoDTPi+88q0XEr6+uqGwG+6
         TfZ9xYnFOHa9VNcPt4pUZUqCqZquIIXaYdcNuPvwgPMkDnP5znXktYjKUG6lnktCHeYH
         9JlYn477XooWxUhM4PQ6FSKjTMB4Wk5k4M0bkwy2harXD9/z5cOWErASpmIWij/Lengq
         gX+DiSGXJX+zF1mqDHHpixnUoFgKEHBgCpES7ir4wDLT+DKTcCu+zXk0tLJxMnoYuCYQ
         00lt56fh/FBlVxB+EWlgXtkvYxl0vrxYj8FANVvxiw5ZXK2ZLVBJpZ42H37AG6utrGmm
         WUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014594; x=1731619394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0hBZkKcHVOYvuhh4Gtl3CCQegEWym6RvcOQyQxM+FY=;
        b=wp8JJwJlKS15r1YwnN6PVLczzWZ+tKJoJR+HdFBo8eROJgBul/RNAy2n/c4hLBrKYO
         G4T6BW0cZit7eAPgQGnG+38yXyIUErr5NyfcjwqcKQOrLdMoDsIt4Z/hAUtlF9+vd2RD
         gpmszQ1/De3HHao2p8/1P22qsWNZbOkq0ax29p7pPSQyFkpQS9CnRuWfJxkrgrxBfXV+
         cr2NTmt5NPBZLEQwM6NY6XCNAqWR/K51ro+v6pGLFzS5V5ovzX4bbZOv0I6zSVbC0yDF
         NVlUGhj8xuGtEeN52lZ5IBh+scBIeI+8UOr+ZOSqkQqN1jntCS01uawEqGvI5xpCQYxT
         JQDA==
X-Gm-Message-State: AOJu0YzdG5AWw1/3bs9wU+V+1baRKeNvkgDtkDSdc1oeDEkQT1ltANPs
	9nfU9B5dfbJRnb5d5ZkgCR7EjTTgIx39qsgO4sKeDycBU8bVp5Xp5cKu0FbmWUiIoFx38otIEMy
	yRNyiYH+oCvo6W3LVpHqDUasXiBJP/xLUFQ+5HhtS93cFR+O3cMGXdFu9DCV2+sxglLARYqpeqV
	+psID7us4SYUazYzZ8VKZUJeydnsER1gqx2VdFlsotLF1xael5VaH9UQS5St4=
X-Google-Smtp-Source: AGHT+IH6MBIMxvNn6nOxRZPgCps/6+Mob5Qm+rnJ3UqtunnR2PDSvtiNhe/pAknsYrvPgW6ow9HA/O+dXBqqid5UWQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a81:d10a:0:b0:6e6:c8b:4afa with SMTP
 id 00721157ae682-6eaddf9599dmr25307b3.5.1731014594162; Thu, 07 Nov 2024
 13:23:14 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-1-almasrymina@google.com>
Subject: [PATCH net-next v2 0/5] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Couple unrelated devmem TCP fixes bundled in a series for some
convenience.

- fix naming and provide page_pool_alloc_netmem for fragged
netmem.

- fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

- add netmem_prefetch helper.

---

v2:
- Fork off the syzbot fixes to net tree, resubmit the rest here.


Mina Almasry (4):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  netmem: add netmem_prefetch

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 include/net/netmem.h            |  7 +++++
 include/net/page_pool/helpers.h | 50 +++++++++++++++++++++++----------
 include/net/page_pool/types.h   |  2 +-
 net/core/devmem.c               |  9 +++---
 net/core/page_pool.c            | 11 +++++---
 5 files changed, 54 insertions(+), 25 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


