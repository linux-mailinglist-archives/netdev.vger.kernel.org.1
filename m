Return-Path: <netdev+bounces-140112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1589B5454
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744FBB22AA1
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EEE207A13;
	Tue, 29 Oct 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZPk9c3+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F62076A9
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234746; cv=none; b=a6MVSYggRLltgPTuPJkGaqBWqkIJoZ0dss4T6VBlF59IQWErncLZp5s650ZZth67X1wy5Zxi0u+vr/ikNPP6LBKuI4wAMJ9m6QgriH+1IHQ+89GZ1d2XqkL7zX6YFeUxBqhBhAR56ksJy6lIHEpK/z/BIQyAg0O18BUby7V9DL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234746; c=relaxed/simple;
	bh=UnbV6MuNFExLfF8+2aKHw1foBqeANBQ10VftomuflNY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mQ1XQOTE0ZSReUh7xnPy3mzgr1IO6KzgEX3MnSyyZAnqHYALCpnA9Xu9aVUPcJX89Sal1A9GsWk3SaAyMQ4cFZ/h1ci+sH5lHKufoov47DVnV25MLtI9XBKLt4MJ7OTEdh8FngjcqxHWGL/cFac8cgyZqRhM7h7sikyThSh0O+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZPk9c3+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7fb84f99cso113350667b3.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234744; x=1730839544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=vZPk9c3+3i4LPQrgc5EUjv+ntQN7jaMNT8eDOKl0pxYXqdNzCPjcT5nLCKrqzZ43YO
         CfwxT3aPdsT66+hwQKqB4szxcTBfDp9T5kQKFKq80K82MPihgE5McXFL1ywikdFIeYm+
         aLyYt3hn3tB9dD1TuWnvX3D392d3riJY2yoeWckO8yzhzmqAzG/0torndCCisjRxSLQF
         IwRCFcVA6EZ26wTa+aSqP64lrIMBxMLk3tIcKH4aMbd2ZpUvCrZmKdlZHqO2zEu3yp+U
         8jq4QlrAtnHF05NDSkuHiwusFuC3o9MBYxoeXPry4Ze9YDMwEmJb2/qaIyrt0jplFh+K
         DLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234744; x=1730839544;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=YS3+GRloS7e+r4Z5rIzEk64ehT8KUODhCu/lAWFHrjK4t8n75On4oAVj7xllAyDAlq
         kx/9gvu6BJEo8CdHDVBEzAHGbsPFi7+WOvA9SWkQ6Zs1/w7NbX635iusTTyiIA4G0aa8
         NyLteuBl1VSlp+R3grtJdJuyTWH6sAAJz4x5ATniwJSKspsfDZ1WSxf019JAGnyjcMzw
         MrV0XAYSCG/5SHB8Kt4fQHWC34V+Wl9m5R//XTh0o6lt8C/aP3y4ZDbWSKG9jEJ5IBpg
         62zSSbXpiA5H7HXe1FvDhiSEj5e2FiVS4Xk4c8IxZVnc27NNsfo6QaQdrfXz3lAwB3dC
         HbWw==
X-Gm-Message-State: AOJu0YwCRjHb0XFlOGy3x4ryTO/5sD8Qc+9SwivMyrtCMt9CEO7gZaua
	hEjDRd6ZGi6TpvZe4SN4VyOcPdqAbJos9GoVuq5HHewWPv2/LmMSVOzxqsQNndh09LVM8NAy+UU
	tYuFL1LTbzhOvcDFvVYzWXnXsHom0R/jdF23mjrhBH5V89pPPERHCGFDGY2h627y64SovFAcvwV
	YdO1O7irbNy31Q/6iA2G3fF5bSMOcBgh8DDMDV1rzh5D2ml+mECQkF+lwoFOs=
X-Google-Smtp-Source: AGHT+IGrCicaNsIac7OAa7RKi54mxGcZhpjM7/v5kaVOQvujs4N2Ri/8i1wyq8Q6f5dhrmpQkbFHQ18QLGt8TO/39Q==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:7449:b0:6db:bd8f:2c59 with
 SMTP id 00721157ae682-6e9d8b8f13cmr5280167b3.4.1730234743615; Tue, 29 Oct
 2024 13:45:43 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-1-almasrymina@google.com>
Subject: [PATCH net-next v1 0/7] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

A few unrelated devmem TCP fixes bundled in a series for some
convenience (if that's ok).

Patch 1-2: fix naming and provide page_pool_alloc_netmem for fragged
netmem.

Patch 3-4: fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

Patch 5-6: fix syzbot SO_DEVMEM_DONTNEED issue and add test for this
case.


Mina Almasry (6):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  netmem: add netmem_prefetch
  net: fix SO_DEVMEM_DONTNEED looping too long
  ncdevmem: add test for too many token_count

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 include/net/netmem.h                   |  7 ++++
 include/net/page_pool/helpers.h        | 50 ++++++++++++++++++--------
 include/net/page_pool/types.h          |  2 +-
 net/core/devmem.c                      |  9 +++--
 net/core/page_pool.c                   | 11 +++---
 net/core/sock.c                        | 46 ++++++++++++++----------
 tools/testing/selftests/net/ncdevmem.c | 11 ++++++
 7 files changed, 93 insertions(+), 43 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


