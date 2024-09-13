Return-Path: <netdev+bounces-128033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051D9778A1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 08:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AE71F25C5B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 06:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC7318732D;
	Fri, 13 Sep 2024 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSAoD7aK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713415666D
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207672; cv=none; b=vGfFgBH/6vV9KrwHZOHybR1msUqI8u4L+2E+H6Q3zE6IkJVrTZVD/5/Wq70lvFJc9TDjSp0dhP9fetdDL/gUkbXsA7oH2360AcolKKIvQ23O105xMMs6/lZu874ZLkhTb/zt5EVnzLNZX++g/1BQmef0MmPgPr911GEIJylA/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207672; c=relaxed/simple;
	bh=Qn9vFZIIQDppzZHqV0PZeq/qL8NYT/cOW7+cTxel7IQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HTIvKFaKoRpyeOvwCuxbrAEqzjAGaVyVTFsS7voFkX4qaSP8OoDvo4CioTg9NXR+gdo0R4hiCiVBE9tycJVWBgcEav2ct30Jeg5fCR+3NRFoN0vzDvy4IvPL1w0cLL02U9J3I3rHoLBr+TUg0dPHXONXgs4v/JdxgCC0SCZUKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSAoD7aK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b2249bf2d0so36182837b3.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 23:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726207670; x=1726812470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zU158RLcOKHBeCjPsX4GvZJnYHBn9YCtM61eCV0teBo=;
        b=dSAoD7aKwEFANdiyCFJWu/oEMntvoKq5x1+OPyzxbMTK5BXE/q0u+IQBHYb7HuaCrb
         5/SFNS3JM5coEyf3Rs30z3KEJs96E1D/6FKnoIh9aSI3isT42U27577pV39ArYa+8SuA
         CZjpKRk5jI0q45YjzrmVU73Gufw+w45iVxj7KDZG63yg+W/HPFxjMizPOvNowBPWSH/7
         HZ0niDxAnbVhyZnt1yOmdMMYrPRHial0U0ee2KB9nADokgZ3w+qGoD+3tmFyh0TR2sb1
         xUqNg1/9komjF+b1gaSAE6oDesgu6iJTz6M2uBOfA5KZHAEkEUvEuO+xNjg15bBzTRTN
         oBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726207670; x=1726812470;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zU158RLcOKHBeCjPsX4GvZJnYHBn9YCtM61eCV0teBo=;
        b=mN1Cxc4PkJmMIUzibAA9cHk7ZcYgv1lXABd3BootYuqWWH66QCjctEkBrF4FQLH824
         PtuBJu9l1frrkJNu4Jh1nOZygF494z40h7+US98Fg1ecjKDmelEz02ghBrG0Di61WjX0
         c3h/QSiU9j5OCBj8D8DO6kKt8uVLQJCOgnDoFF3Fv1Q941tQhVNqLZi8K3VeNM0y55qK
         xz7ubU1rH9ji4U9gxG4K3Ak/alMuuzQzpWXDzb9593OKGHldBvLOFtgkrQIlOa3vTC7B
         5duyDPqYpzRnoPmYT38r8vW9/j/2ppaCLOPPlyBwcpFdMssJ9p/CNIS39lwN1qx0/al+
         RY9w==
X-Gm-Message-State: AOJu0YxYPc+RZk+wbugPTiXb/befyxpmyQlpG843kJ1Jahc1Y7tpz4ws
	uanpzTzgT+P8pgzM+ZPKf1ApVO035UA1jdSWjwyVpEuxpXhVevT7kGgje1i3d+lbuPcmmXFfsZF
	7g0tscAA0tm03RrivZlQZ4HPU/7tfAbuQH5+f/XqEk8eFjFtTPznFCYRhBG5+VgMVLC8EwmK+Yn
	vx9wq1uMcUAIsZzf8q+rLQf7Yst6Q05BgbwXfBoS9mR0h9FdeXEyDCii1/vIc=
X-Google-Smtp-Source: AGHT+IFiXDKzLAcHwDf50KVgcFjqRPr12bDjQHGm4KlZSMNuZu648rOdSGNh5XOu+wrn3hpE5s5BsWF6kbKejVSTNQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:86c9:0:b0:e11:5a3c:26c7 with SMTP
 id 3f1490d57ef6-e1d9dc4275fmr9133276.9.1726207669285; Thu, 12 Sep 2024
 23:07:49 -0700 (PDT)
Date: Fri, 13 Sep 2024 06:07:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913060746.2574191-1-almasrymina@google.com>
Subject: [PATCH net-next v1] memory-provider: disable building dmabuf mp on !CONFIG_PAGE_POOL
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

When CONFIG_TRACEPOINTS=y but CONFIG_PAGE_POOL=n, we end up with this
build failure that is reported by the 0-day bot:

ld: vmlinux.o: in function `mp_dmabuf_devmem_alloc_netmems':
>> (.text+0xc37286): undefined reference to `__tracepoint_page_pool_state_hold'
>> ld: (.text+0xc3729a): undefined reference to `__SCT__tp_func_page_pool_state_hold'
>> ld: vmlinux.o:(__jump_table+0x10c48): undefined reference to `__tracepoint_page_pool_state_hold'
>> ld: vmlinux.o:(.static_call_sites+0xb824): undefined reference to `__SCK__tp_func_page_pool_state_hold'

The root cause is that in this configuration, traces are enabled but the
page_pool specific trace_page_pool_state_hold is not registered.

There is no reason to build the dmabuf memory provider when
CONFIG_PAGE_POOL is not present, as it's really a provider to the
page_pool.

In fact the whole NET_DEVMEM is RX path-only at the moment, so we can
make the entire config dependent on the PAGE_POOL.

Note that this may need to be revisited after/while devmem TX is
added,  as devmem TX likely does not need CONFIG_PAGE_POOL. For now this
build fix is sufficient.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409131239.ysHQh4Tv-lkp@intel.com/
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/Kconfig b/net/Kconfig
index 7574b066d7cd..a629f92dc86b 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -70,6 +70,7 @@ config NET_DEVMEM
 	def_bool y
 	depends on DMA_SHARED_BUFFER
 	depends on GENERIC_ALLOCATOR
+	depends on PAGE_POOL
 
 menu "Networking options"
 
-- 
2.46.0.662.g92d0881bb0-goog


