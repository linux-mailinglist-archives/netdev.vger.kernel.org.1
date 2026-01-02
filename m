Return-Path: <netdev+bounces-246607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB8CCEF280
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 19:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF19B3002D1C
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C6314B7F;
	Fri,  2 Jan 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkpFr+Tu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE343054EB
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377158; cv=none; b=ItBay1t4NemuIGphdkATvNEF7pOtQzdstxVSE4hLZ7yVReg/weUfzPm3H0QR4Xbef/rpabx1v2Kr3GS34kPZAW/f80z0LqUcvhO8Bntfrv1lVB5kXrOln1o6lLvSiOT3/h34Rtw96DEMyBO6RGhphgZLqCdpKBAXvnfosIVDiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377158; c=relaxed/simple;
	bh=phyFSkUrMB3Pksaf6iExh+d+KbAxAj4rwZwi5QGD5y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3nBvOSB0fetZmo4Qn8YLnv+hMYKB2AJZI8qQa3zDPB5B9n2jqTyD22raryAF+z2HjI16JSNMsIgCw8BGhlOz9uxXJZsAtYo2vY8brvP2CblK0iFQuzufJ4T6RGDTxbuJ3Sdc4n15SGTiJ0yeEKp60oHPdGXPJ0Ger82qvw0RsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkpFr+Tu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso126705525ad.1
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767377148; x=1767981948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IEjIvWEXiVpq+xSctei6hnvY2nWGFZMrfiOy4jnM8k=;
        b=JkpFr+TuVYfZ3q6rNPELbe3tZjFSgaRvAIckTL7mOS2oKFq3BIJY0MafmydEWQyjBn
         HrduEr/XYPw5tMF4u9k1/PW4vjpitz1fcMpI+ax53gDWMn7XojnbTN2CIoHegDCDKnzI
         /ri64cL6JDMnR132+96w+UrYMNrODqbK8219YFP6gKKv5m2lWsO+rINvmX2uZHzMHXh3
         4RzwEnLRsAVrvC4L80VsvNrOcnoq7UgnnSItLX0JYQytB7Ti8jz/oIK3djtstve8fNzP
         31GEvG5UiAOWwbmNpEI1IZnep+gLwN3dIQoNtoD884LySp8162SKTpYkqRb28JHrzYro
         Svow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767377148; x=1767981948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IEjIvWEXiVpq+xSctei6hnvY2nWGFZMrfiOy4jnM8k=;
        b=r9HFiNCTdBLxeJkl8CjRApz2FKWZ1Z5ZG84oGxk10pcnp7NjTJ6Vv6klzyf8tTFSbJ
         RuZ6VhVWtoJbhpY/IOaVIRxI1ECgZk4rrSyFincugM0omALvotGIbyFc8GvdA2gJ1EHY
         wwrrhXet3YOm/goEB4KyfUSeuWQLaC7Xj0mOXmMu6nOyVHacnkX0CbICWhqgOZmxloTP
         6LEQtVA6xLL6oDxdUB/oFw39svu1UEd6sAjcb0PMqiBOikYIx3JVhK0936QxD1sJ/CNL
         x4stfbFQHzbly6+VqVjldHnGlqWX6q+u/5mGy2Wp8DHqLX6udEWl+OhuvKiXysp1Bs2r
         +aNw==
X-Gm-Message-State: AOJu0Yzw/bJAwYiov0OCPUH0LOZkGdvRXtjfMMvMNSYwFz9lvWHAY49V
	b7/DyF+WjUd4+QRDXZw6E1cICalzB8Sj3YtN4w/CyiY3fMdo9HzglBqD
X-Gm-Gg: AY/fxX7R53HG78H2f/46kKAMd5Udpm92OoYbXdXJraLj7svH3e7YlsnJ3iwVE88OQdQ
	82JngDyHepCDHfkSUYkxgC5HuBp8BcsNmV6OCUl17dUdjPO4VBCHCgKoMsK0Dlxu62crjnvYLOC
	kf0zH6BVwG6oIg3U3TdMt/ENxoTC786Ug9rpkSxMPgMcqTOpYYpQnox7k0/VK2Gd+O6fsQI1oWr
	bbi+74ILYF9AODPpz/JaDdxDQeq01bwUXuciTs80vaDpF6YcxoC+RhUe2TpKrUziVZqdUgRoODE
	uX5/2lT3siDtqPPiHBn2h1jR4EyV6kC1KfAXgsqmYInBKQHuS+rikpLP7cT55j8LR+W97KP6KbI
	zOqZmWOk5cHI8M/znJxws95B2W/ibaCnbOjTNiU0SVEjPWCWQGK0E0bY9XjnA+y+LID3B3GI4am
	bAOwjnLr3+cgq+ZIQOH6GzMtwvjd8zS806rTOlp8jQeZKrCowoojivBj2JaGzJ8AO5Buc=
X-Google-Smtp-Source: AGHT+IGjBOyVzjSp6FfpPdKVvmhw705V4tllHiS+cveb+fAujtHJ8wxvUD8lPZQFKwc3BpWzbtF73A==
X-Received: by 2002:a17:902:d488:b0:2a0:8f6f:1a12 with SMTP id d9443c01a7336-2a2f222ac10mr369988605ad.17.1767377147961;
        Fri, 02 Jan 2026 10:05:47 -0800 (PST)
Received: from localhost.localdomain ([223.181.108.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77566sm386297585ad.97.2026.01.02.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:05:47 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net-next v7 0/2] net: Split ndo_set_rx_mode into snapshot and deferred write
Date: Fri,  2 Jan 2026 23:35:28 +0530
Message-ID: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
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
change the semantics of set_rx_mode and add a new ndo write_rx_mode.

The new set_rx_mode will be responsible for customizing the rx_mode
snapshot which will be used by write_rx_mode to update the hardware

In brief, the new flow will look something like:

set_rx_mode():
    ndo_set_rx_mode();
    prepare_rx_mode();

write_rx_mode():
    use_snapshot();
    ndo_write_rx_mode();

write_rx_mode() is called from a work item and doesn't hold the 
netif_addr_lock spin lock during ndo_write_rx_mode() making it sleepable
in that section.

This model should work correctly if the following conditions hold:

1. write_rx_mode should use the rx_mode set by the most recent
    call to prepare_rx_mode() before its execution.

2. If a make_snapshot_ready call happens during execution of write_rx_mode,
    write_rx_mode() should be rescheduled.

3. All calls to modify rx_mode should pass through the prepare_rx_mode +
	schedule write_rx_mode() execution flow. netif_schedule_rx_mode_work()
    has been implemented in core for this purpose.

1 and 2 are implemented in core

Drivers need to ensure 3 using netif_schedule_rx_mode_work()

To use this model, a driver needs to implement the
ndo_write_rx_mode callback, change the set_rx_mode callback
appropriately and replace all calls to modify rx mode with
netif_schedule_rx_mode_work()

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---

In v5, apart from the bug with netif_rx_mode_flush_work, netif_free_rx_mode_ctx() was problematic
because it needed to cancel and wait for the work to complete before freeing memory.

The problem was that the work needed to grab the RTNL lock while the RTNL lock was held as this function
was part of dev_close()

This means we are guaranteed a deadlock in case the work was pending. 

cancelling the work should be done in a context that doesn't hold the RTNL lock. The only existing
function in the teardown path that did this was free_netdev and it isn't ideal to do the cleanup there.

My solution is to introduce a new struct netif_cleanup_work and a new net_device member cleanup_work.
I am not sure if there is a better solution than this.

cleanup_work will be a work item scheduled by dev_close() that will execute the cleanup functions that 
need a RTNL lock free context.

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
Link: https://lore.kernel.org/netdev/20251118164333.24842-1-viswanathiyyappan@gmail.com/

v5:
- Fix broken code and titles
- Remove RFT tag
Link: https://lore.kernel.org/netdev/20251120141354.355059-1-viswanathiyyappan@gmail.com/

v6:
- Added struct netif_deferred_work_cleanup and members needs_deferred_cleanup and deferred_work_cleanup in net_device
- Moved out ctrl bits from netif_rx_mode_config to netif_rx_mode_work_ctx
Link: https://lore.kernel.org/netdev/20251227174225.699975-1-viswanathiyyappan@gmail.com/

v7:
- Improved function, enum and struct names

I Viswanath (2):
  net: refactor set_rx_mode into snapshot and deferred I/O
  virtio-net: Implement ndo_write_rx_mode callback

 drivers/net/virtio_net.c  |  55 +++-----
 include/linux/netdevice.h | 111 +++++++++++++++-
 net/core/dev.c            | 264 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 389 insertions(+), 41 deletions(-)

-- 
2.47.3


