Return-Path: <netdev+bounces-250330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBDED29021
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE8113018416
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD193242AD;
	Thu, 15 Jan 2026 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmV23DrH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="npBOFfDI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3E1C4A24
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515969; cv=none; b=CMwYpUZKyiitirDYWXQoRw2tgLalbXwdpUfG5l6IouNBo/HDGPBDzgTJM5z82gyeyt3JjRrN+GeDD3ISBwoktNo8YA0/AGbFO4UGZt/pUzELMPc4SvWAwLxeccoMnhvp57CFsWj0Q4GryTDCx6vNIUosTNqhdH8zelnNfLHiVoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515969; c=relaxed/simple;
	bh=HAhZBVOAndOrwaivbJzPBiAv/kgx9YIV8eA0/DOxyos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXGkHvUZ7kFzNVo2xYRcK61lZ1sGUPWhoLv7LAWlNKLiG/aVJRnDpx2hPIzBeLmGo1s/8U68dDxvfbHG2Xd8jcxWx2NQJIuJm9HdEt0O5cMJl15qGkQl0BkK97UhwjcTAz9i7qlTQ8OHXpafQoUdm0nGjPuEbYWf32FtyszxblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmV23DrH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=npBOFfDI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768515967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1miKLy3Py4+m2LBM84rc6I+GGI6VlQkCR0LFVsJnfk0=;
	b=EmV23DrHWxAxVr2jrYgLH313FIDKAuR3oiIsLgJJs+n9aSNQsYjy0m4bHRQdCp/ijErTKw
	e0nUrUULqr7ve8ODVvVxzr7BsYsP+daspJih7A64SvS0Gjre/mq1/0KDxpP6I72CZ4BWSn
	DkJpa3oWDji7MrqYhv8c3JBAoaFU+iQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-XxGpBlcmPNGw7TAtRUaJJA-1; Thu, 15 Jan 2026 17:26:05 -0500
X-MC-Unique: XxGpBlcmPNGw7TAtRUaJJA-1
X-Mimecast-MFC-AGG-ID: XxGpBlcmPNGw7TAtRUaJJA_1768515964
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432c05971c6so942543f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768515963; x=1769120763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1miKLy3Py4+m2LBM84rc6I+GGI6VlQkCR0LFVsJnfk0=;
        b=npBOFfDI4Y39RrPRT8agzoseiFCj05uMSykYxjQ+LPxFIS1mFSuZkpnZEUXYF+oT7Q
         LZJ4yGfoDF8gM/4YsqiiHHPqbO5ET3FWjRr1jCwp/gGLrdyBXwDLc2xv3Dvrng1LVZzp
         wsCGlpWmZPQSjzTPyV5ZcxrHRp2kNSUv0rbqvZHgME3aD4eEAga+uHGMfC1bKA/A/y64
         RbmIbH+W2J9zxdYDLKod3fo+2jCXQdr/+XdSCthjgpJibFFBbuuu0UKYp9tyzLrkmeTd
         l6mV1MVbYraAEbeEiaANZKYZy0kMFy0nvniFV4Yp1HNfDxIua4lzsTukH5BU2NYH+aNz
         /fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515963; x=1769120763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1miKLy3Py4+m2LBM84rc6I+GGI6VlQkCR0LFVsJnfk0=;
        b=EeV4ynt1cojFHfsETDIvB1Oa82/KwQl2/kmOv2q2dqtriUS+Ozq7yiBRZnybQBK510
         IOPVSptU+9A7R4eM/USFuor8VRxXThUWggSUEM9BcFBuZfFwy+04rp4gVoDekbP9p6eY
         hJcbCqhGQyUhPkeVq0qghZGjzqL9MWf7GDUxNRjFu7bv7DjAg606x5mfEo71S35eiWCj
         4Y1OBSoDo5H7JE6J0IOUVCb4ZcYOJ0l6np8YEz12Ik5dJiG3hRO5iIf80vntHYhjFS/u
         5T9Htx61Ni3g5m/VYpNpUfi+SMPUW8cl0gdnMAk/1I+uWlwU65LSy+bD4dC8q1q95aKT
         krPw==
X-Gm-Message-State: AOJu0YyCnLoGqtNa79S8UneVZ3goOeoYNpAJTebc/xqhXZgeBWXME33M
	JlCGLl/ZMgPK2tllIWlU7IcYsMoTPecxW7MNZzpqTBcN0/3ZfR5vWmYUS+Xb4LDR+3dQjGxusSm
	RiJATE2FAEfkItQnnkJOav9dd8iHGM3KqLQpXyozOc1FNHxseno8L9u3EprFdfL4y0eBk2emWBn
	rVpKA4kX78U0XVqHppg+KX1ehY2LFS7GpIO3mqZpPiaw==
X-Gm-Gg: AY/fxX4o7nKxHodzDbkrAzy33eJqtIDG2S645h/vGPG+oeHj48FalLOzz9C30WrKBtz
	wEkQ//APt65nUNzUs+VdLXJOKObacxVZiHUg3ovqgNWGGtio+VtGs/OYiv23IZWfQdurm1DnH9U
	bFffrMvDStUw4EcbcXye3m/BnNfrzdb/4qCrHqksKq8qC2KRvSpyQKd93m7pGJcM0y42jzh8sGQ
	2GNhEkl2JPc7rVdSA8vOXmklXIfm75MGyoHz5/MHIbyX7FRGiUa4lrFXZFmXWbbzwHS3cKiuxZu
	/N97/AaIWkxxX3z00I4LoiblhCij+/iqd4hY6AQXzkNSfTKFpa8QnN2F/UNcpBFU/roH4MTov2/
	gOi//cj/UHqLC2VYB4216uTZ0gA+VikOvTU5jhUQMK+z7kQ==
X-Received: by 2002:a05:6000:258a:b0:430:fae3:c833 with SMTP id ffacd0b85a97d-434d755262bmr6220023f8f.7.1768515963017;
        Thu, 15 Jan 2026 14:26:03 -0800 (PST)
X-Received: by 2002:a05:6000:258a:b0:430:fae3:c833 with SMTP id ffacd0b85a97d-434d755262bmr6219993f8f.7.1768515962614;
        Thu, 15 Jan 2026 14:26:02 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271dfsm1395487f8f.15.2026.01.15.14.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:26:02 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next 0/8] net: macb: Add XDP support and page pool integration
Date: Thu, 15 Jan 2026 23:25:23 +0100
Message-ID: <20260115222531.313002-1-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tested on Raspberry Pi 5.
All the changes are intended for gem only.

The series consists of two main changes:

- Migration from netdev_alloc_skb() to page pool allocation model,
  enabling skb recycling.
  This also adds support for multi-descriptor frame reception,
  removing the previous single-descriptor approach and avoiding
  potentially large contiguous allocations for e.g. jumbo frames
  with CONFIG_PAGE_SIZE_4KB.

- XDP support: Initial XDP implementation supporting major
  verdicts (XDP_PASS, XDP_DROP, XDP_REDIRECT, XDP_TX) along with
  the ndo_xdp_xmit function for packet redirection.

The driver now advertises NETDEV_XDP_ACT_BASIC, NETDEV_XDP_ACT_REDIRECT,
NETDEV_XDP_ACT_NDO_XMIT capabilities.

Previous versions
=================
  - RFC v1: https://lore.kernel.org/netdev/20251119135330.551835-1-pvalerio@redhat.com/
  - RFC v2: https://lore.kernel.org/netdev/20251220235135.1078587-1-pvalerio@redhat.com/

RFC v2 -> v1
============
  - Removed bp->macbgem_ops.mog_init_rings(bp) call from macb_open()
  - Fixed includes (remove unneeded, moved one from header to macb_main.c)
  - Reverse xmas tree ordering (gem_rx, gem_rx_refill)
  - print_hex_dump_debug() instead of print_hex_dump()
  - Replaced rx frame length check with MACB_BIT(RX_EOF) for data_len
    calculation
  - Removed NET_IP_ALIGN handling in rx buffer size calculation
  - Updated debug format string to include rx_headroom and total size
  - Changed types to unsigned int in helper functions and variable
  - Removed unneeded line break

RFC v1 -> RFC v2
================
  - Squashed 1/6 and 2/6
  - Reworked rx_buffer_size computation. It no longer takes into
    accounts extra room.
  - A bunch of renaming (rx_offset => rx_headroom, removed MACB_MAX_PAD,
    MACB_PP_HEADROOM => XDP_PACKET_HEADROOM, data => ptr, xdp_q => xdp_rxq,
    macb_xdp() => gem_xdp(), macb_xdp_xmit() => gem_xdp_xmit())
  - Deduplicated buffer size computation in gem_xdp_valid_mtu()
    and gem_xdp_setup()
  - gem_xdp_setup() no longer close()/open()
  - Renaming from rx_skbuff to rx_buff is now got split in a separate commit
  - Open-coded gem_page_pool_get_buff()
  - Added missing rx_buff re-initialization in the error path during rx
  - Page pool creation failure now fails the device open
  - Moved xdp buff preparation inside gem_xdp_run()
  - Added missing rcu_access_pointer()
  - Turned return value in -EOPNOTSUPP for macb_xdp() on failure
  - moved tx_skb to tx_buff renaming to a separate commit
  - Removed some unneeded code and set MACB_TYPE_SKB for lp->rm9200_txq[desc].type as well
  - Replaced !!addr with a dedicated bool in macb_xdp_submit_frame()


Paolo Valerio (7):
  net: macb: rename rx_skbuff into rx_buff
  cadence: macb: Add page pool support handle multi-descriptor frame rx
  cadence: macb: use the current queue number for stats
  cadence: macb: add XDP support for gem
  cadence: macb: make macb_tx_skb generic
  cadence: macb: make tx path skb agnostic
  cadence: macb: introduce xmit support

Théo Lebrun (1):
  net: macb: move Rx buffers alloc from link up to open

 drivers/net/ethernet/cadence/Kconfig     |   1 +
 drivers/net/ethernet/cadence/macb.h      |  40 +-
 drivers/net/ethernet/cadence/macb_main.c | 827 +++++++++++++++++------
 3 files changed, 659 insertions(+), 209 deletions(-)

-- 
2.52.0


