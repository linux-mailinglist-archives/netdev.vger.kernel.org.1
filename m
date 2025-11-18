Return-Path: <netdev+bounces-239636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED34C6ABD9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39CCF4EF7FC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006052E0B58;
	Tue, 18 Nov 2025 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC5eOepa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB730506C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484237; cv=none; b=iaSSFSbNOaOPklDoGhcH/0Mkf+XM5OD2+i2+tcBQxg+hDTFblwD09YULvRxjfmuaogPx4NwiBORK4xMQ3qBZYcDM9n25/AcGpZ4Eo9pTMHs/wAyLWMlDhAUhSPobZznBZNZH1SjVMJnlU/ej2ZBAI3EA4nGOnjj8tqSgiG68sZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484237; c=relaxed/simple;
	bh=+LVgUS9kVeC/8nV+dll5f40MSzzK5octAcI+dvskmzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ThOGBAJFGqNnet/QMnAMgM7ErfrAWfJpXzQ4iZONke7PBAZtuBKwTLnlJE/yZWStNLtSK1a6qVtiwGgFPdwC8pwyKtcbQXkmKk5rnsFzFQbM8uGUjwpRp1xiCfudgpHoWTNid9//upTLID/hd4usUp1y2fncH7mD6t4LmC7MEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC5eOepa; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3434700be69so7678803a91.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763484235; x=1764089035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cbuphPFMfLGo5gRI8NR3opiZSQijI8mGuMttNZYVmU=;
        b=WC5eOepaodq0FQYccNciNNiO+YJrGiteoZjiWo4Bf2ggG5HIuFXjsBAvFONrEePD4k
         X6tAmMhaPfC7FbyuTtQ9OdilxkqrukKlkzL2Nee9pU9BaWH74Rgelh2v/iYxu40rRtrS
         NLO6YdJy1Cqnv/GibV5n17U0y3b2+WrLV1Lw38p5yh8Vak6ai6Sk8ulM9Kbz/vtE3M6b
         oGlxklwhUbUEPgWTiOkT7/vEW3rBhdiVLj5cXyNrpZBCq5OapeJwixQlB/PdO1dAOJii
         2Mp+tnNoELnTbgj29+uusaMT16Do2rdS79TaT/EdmOduAWFGuo/AcvE704rp76o2Rba1
         zU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763484235; x=1764089035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cbuphPFMfLGo5gRI8NR3opiZSQijI8mGuMttNZYVmU=;
        b=i+6rKBUIeVWgSoEI3zIZ1rKbkv7f00Yccm9JQjH6OcyqQT5sQDwAadT3qnvm2SUqEz
         t5kvb2Pdi0/48HB9tVr1BNgpKnqkJrOywKub69TXOX5xxOtoEAjlPh7A6THe0Ft4Fav2
         YJy8fvMpk54h13ii30xDnVoCyJJQQyyrndhpoMQntdClOxud+hBu3KiIXh3Ei9Y2j07o
         nRx79nvzRmF3ISboae7TFlDnT09pUgUWb6grHyMBYYoMts9K8Nutl2fpPpc9ghnrQ3iO
         JhP3C4lz1a6kbV0doSrQWRMhF7uKUtnGx4bilfeFZrWcSQzkTyKfxs8nc7iV83pINZol
         Gtxg==
X-Forwarded-Encrypted: i=1; AJvYcCUl2vWqg+Q/ocE40WWrZcZV6ys8DMafp2xxqPW+2uXgplEH2Uko7eLU8YyEDmo5cnFmAAcKnWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sGqrUbbxIPwm/q4uL87nsWb7yHoAK4igCKuaYPFgSClr2knL
	zexdPGvGBEESz+PUZIJkAmUl9RhrDmyjV+YffrkLYjdKrqG87p0nskTW
X-Gm-Gg: ASbGnctR0jq3R+sqagsr8kbNgUlGPY/p9wkNmBdgftMa2PQl8RjeEvIjuwcNJOkjfEG
	4ptAHr55IZllyNzx5ICG84XbkdcHX6JYxYfp6CBvI1kd4tf7pQyD+QEumTXXrS94ARPvi0r8ITF
	2KWLBAxjtI/g4IU8culDvRdclZxv8bb2XYTxRWVT+b5QoTW7GjYmaSRoA8SZzQbfi8TVb/e11mr
	INMQIKGvhHwrDS0hAUpgs8J2lZ7+f/NawJQFLNGlR0yDqHwwDZ3qTqd9lSAw6TT8zO7B76CQmB4
	vDf2kch7zR25SPVNaONklyRpTomAk1sAOnzk8DHBWYMpA9KSz2yKvPfBb9Sh+atY3v/bF/mpF4+
	tfqFbpTsE7oOZrZ2wwrCu9uZSM37OjhmbD65qmOWKJaiRSbR3g72dBz2dwQME6Igbwjea85Cw8+
	gKbKtwb5am22L6Rw1yO2tJgI6xfBRxgkt/nrHWTH+ZxxJVjHYfu7+ZJQ==
X-Google-Smtp-Source: AGHT+IF4ROlWaR4DHJA0c22lYuFIfvzSSI1ABiWieRYUfZCEK44GiWIPsQat/bJg64jdJOCTUQirsg==
X-Received: by 2002:a17:90b:4a4f:b0:33b:ba55:f5eb with SMTP id 98e67ed59e1d1-343f9d91d06mr16086393a91.1.1763484235218;
        Tue, 18 Nov 2025 08:43:55 -0800 (PST)
Received: from COB-LTR7HP24-497.domain.name ([223.185.135.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513f162sm13544843a91.8.2025.11.18.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:43:54 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	aleksander.lobakin@intel.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFT net-next v4 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Tue, 18 Nov 2025 22:13:31 +0530
Message-Id: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an implementation of the idea provided by Jakub here

https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/

ndo_set_rx_mode is problematic because it cannot sleep. 

To address this, this series proposes dividing the concept of setting
rx_mode into 2 stages: snapshot and deferred I/O. To achieve this, we
reinterpret set_rx_mode and add create a new ndo write_rx_mode as
explained below:

The new set_rx_mode will be responsible for customizing the rx_mode
snapshot which will be used by write_rx_mode to update the hardware

In brief, the new flow looks something like:

prepare_rx_mode():
    ndo_set_rx_mode();
    ready_snapshot();

write_rx_mode():
    commit_and_use_snapshot();
    ndo_write_rx_mode();

write_rx_mode() is called from a work item and doesn't hold the 
netif_addr_lock lock during ndo_write_rx_mode() making it sleepable
in that section.

This model should work correctly if the following conditions hold:

1. write_rx_mode should use the rx_mode set by the most recent
    call to prepare_rx_mode before its execution.

2. If a prepare_rx_mode call happens during execution of write_rx_mode,
    write_rx_mode should be rescheduled.

3. All calls to modify rx_mode should pass through the prepare_rx_mode +
    schedule write_rx_mode execution flow. netif_rx_mode_schedule_work 
    has been implemented in core for this.

1 and 2 are guaranteed because of the properties of work queues

Drivers need to ensure 3

To use this model, a driver needs to implement the
ndo_write_rx_mode callback, change the set_rx_mode callback
appropriately and replace all calls to modify rx mode with
netif_rx_mode_schedule_work

---

Questions I have:

1) Would there ever be a situation in which you will have to wait for 
I/O to complete in a call to set_rx_mode before proceeding further? 
That is, Does netif_rx_mode_schedule_work need the flush argument?

2) Does priv_ptr in netif_rx_mode_config make sense? For virtio_net, 
I can get the vi pointer by doing netdev_priv(dev) and 
am wondering if this would be a common thing

3) From a previous discussion: 
https://lore.kernel.org/netdev/417c677f-268a-4163-b07e-deea8f9b9b40@intel.com/

On Thu, 23 Oct 2025 at 05:16, Jacob Keller  wrote:
> Is there any mechanism to make this guarantee either implemented or at
> least verified by the core? If not that, what about some sort of way to
> lint driver code and make sure its correct?

I am not sure how to automate this but basically we need warnings to be generated
when the the set_rx_mode implementations are called normally in code (From my 
understanding, usually in the open callback or the timeout function) but not when 
they are called through ops->set_rx_mode. Can Coccinelle do something like this?

v1:
Link: https://lore.kernel.org/netdev/20251020134857.5820-1-viswanathiyyappan@gmail.com/

v2:
- Exported set_and_schedule_rx_config as a symbol for use in modules
- Fixed incorrect cleanup for the case of rx_work alloc failing in alloc_netdev_mqs
- Removed the locked version (cp_set_rx_mode) and renamed __cp_set_rx_mode to cp_set_rx_mode
Link: https://lore.kernel.org/netdev/20251026175445.1519537-1-viswanathiyyappan@gmail.com/

v3:
- Added RFT tag
- Corrected mangled patch
Link: https://lore.kernel.org/netdev/20251028174222.1739954-1-viswanathiyyappan@gmail.com/

v4:
- Completely reworked the snapshot mechanism as per v3 comments
- Implemented the callback for virtio-net instead of 8139cp driver
- Removed RFC tag

I Viswanath (2):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndO_write_rx_mode callback

 drivers/net/virtio_net.c  |  56 +++++------
 include/linux/netdevice.h | 104 ++++++++++++++++++-
 net/core/dev.c            | 207 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 328 insertions(+), 39 deletions(-)

-- 
2.34.1


