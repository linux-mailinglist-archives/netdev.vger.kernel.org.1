Return-Path: <netdev+bounces-245616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6715CD38E4
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 00:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95E4E3008EAA
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 23:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D834523C8C7;
	Sat, 20 Dec 2025 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya4yiPOt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnZRlg9v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3AA14F112
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766274711; cv=none; b=lODiMEZA3OX7qWiSp27EGax8RQTwYwYOFLf1xTxTsMuXdHKarOQsAnQbr+pqioMZ4OsuY69Tv47OVdi5dT1bhhX12gL+d0spAGBnw0oNk7Whki8VJxqlYro/JBvH1d4hR7vN9gef1MHuTqur400ahC7OZlpMq9EXeInsXfNhHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766274711; c=relaxed/simple;
	bh=mwvn+X67PJ/IwJrlHdn06C7/k438HLaKBeO6aIgORoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hd9k7Cb2nPY98oZD68mVCG0yhSWGrUHIyg7Bgtw0g61X9g8eKctDgvnYa1NoqCXQsGAfYgncZK4JfrR85XQINLk99yE0+ko8g/YDow90PLzqPjseycxR0/sU855K3PoojoqhFdBfu6YQV0pM2zOxITD3QwNk0/PdVBjjZ4+uOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya4yiPOt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnZRlg9v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766274709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vg1sxpZEzY2TpdA7sS470ScQe1vD1DiNMWSSWus+qFA=;
	b=Ya4yiPOtWjYiggDisXWYi4y/JfchKHh84MQ8wbRD/28rYcHO4lj1BsMDOzE0IvE6dApL+x
	LNM0ye5iSQ4Vz/Hmz0kxbPp95Jqn6md2NjT6Hzhqp9YPMaO3nkj1DK9X6j9Vh7hKY8Dnqk
	wjDEiFWuQFb6tpOAhr2wOJK3d+MGN+o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-86XFYAsUM5KH0P9TzTbskg-1; Sat, 20 Dec 2025 18:51:47 -0500
X-MC-Unique: 86XFYAsUM5KH0P9TzTbskg-1
X-Mimecast-MFC-AGG-ID: 86XFYAsUM5KH0P9TzTbskg_1766274706
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-64d1982d980so635442a12.2
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 15:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766274705; x=1766879505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vg1sxpZEzY2TpdA7sS470ScQe1vD1DiNMWSSWus+qFA=;
        b=DnZRlg9vx72TDuPfy44KzNO90oS6OpqFJnURjOGByge/8w2YUj43zfzp71UjfbDfFd
         B6CD7DPbuXC227CkcJTwSyVA9sv4wnE/4UWKZAnpMsCv6mqp93GzTt0qX1JOgjZjIDc+
         p4Q0aiZflppYh2jgUUzIwBiVFcf19YbZVGQksrqaYLEWb7IS2FAhWk3aGSTJz2Mrny42
         pbUJ+WsFq3reRQnXUeG7FSc83fqf9MOkYPbpTUHc0RE/q0QZ/77BWzybXm3t5Ob51T/0
         HcfD/5YM57qhtNDb1Nxjs2i6iGS5CaQBXb5/2MHrE15Mk5VIJU9qcsvtp/J9w59lTs3/
         S/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766274705; x=1766879505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg1sxpZEzY2TpdA7sS470ScQe1vD1DiNMWSSWus+qFA=;
        b=mrAyk6H6DeYnjmzMzfmqk70EN2KFI6VY2SmIky9ckCAmm2LFwXI/fvL6unufK1s6k0
         dtTVgoDsP84MRhriGiQrnQB54M/PgShn8NTxCDa4MSdwVl8pA4eTn5nQ+RwxHJ4/+YX+
         WrqVdMRZ68b3rb2G+eVEjK5qU1f6rhLfr/YHb5x/7Gaizt9bs+O0sG0tmmEb9SP5RejS
         LoA8SPplV9w1AQoRRtWKiKhXCPFitevhpKfAH1+kEgyZgx8WA+GlT7eIxrBhbR6OlV+Y
         BIOysaLHXwx9KktPv4tf/MYlYTxO8g0DlxpkAZ6EcBxilqrvxoCXaK5n4BMTyTyOQB2v
         bMZg==
X-Gm-Message-State: AOJu0YxCmtkwBfz/enBS4G1NolJznR4Kjf5yMGpSlaRLgaDBUNYqRNJ7
	9nWDakkfkIs1lyg5faNA7oO4loIIlyOghiYzx4Ol6o5XTMzBAe7SkH7Rg4dL2T8NTfDCuzTiflF
	aECazHMJJ4olgCRAw9iH8T4irX1yBB/AEH8jUCraANmuz3bvOpXa/FJU+aVM1jNxL1ihFMH5Uok
	GDWLIykgJpH4aATAgAcCY9cmBgo4bNxiwA93CxFHj9Vg==
X-Gm-Gg: AY/fxX4ynsu9Gkdqp3oFLeWP2+DJD4D600ZWXmi5qfbM1Qn93xn2qNjdIXZyStlPaC6
	KlMl8XZ5H+aj98nU125jI4UGpSjqbULv+XT1L0b+LR3B86z7uiW0R/fG1qz/S8Cybiyj8vJsvBy
	HZPkIIoYaVk+kqfTmhB0vMFmVFaCEFUagIFPniSbNIq+93BCOF+35hkCqttSqdDCWYf5fdnPkDv
	RlcT83sId8n5AM87EdDgOcGHUeElhdXEEDGLQddLo0IY30d9Xhz9XUnmvBYcQ0BC6mG+hQfms4N
	BsifL3hOkCrK3P3OGt2TPh35YdvS/Vbd09uSE+CuDN6Nkrg2Czi3qHASZxFS+Ih6J0pcBlCh+oU
	iFNrY3LR4MKqGzOBDaogCTfh7UfBBLFfsq0gnRYw=
X-Received: by 2002:a05:6402:27c8:b0:64d:1a1:9dee with SMTP id 4fb4d7f45d1cf-64d01a1a07cmr3620779a12.16.1766274705123;
        Sat, 20 Dec 2025 15:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcvLbDjBnEN2Mlc6iyDvzOhwdSDGk5JXl+vrAjN2hM0N8mLydx4fV1nS44wljGeinnNI6BDA==
X-Received: by 2002:a05:6402:27c8:b0:64d:1a1:9dee with SMTP id 4fb4d7f45d1cf-64d01a1a07cmr3620756a12.16.1766274704657;
        Sat, 20 Dec 2025 15:51:44 -0800 (PST)
Received: from localhost (net-5-94-8-139.cust.vodafonedsl.it. [5.94.8.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91056731sm5895162a12.8.2025.12.20.15.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 15:51:44 -0800 (PST)
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
Subject: [PATCH RFC net-next v2 0/8] net: macb: Add XDP support and page pool integration
Date: Sun, 21 Dec 2025 00:51:27 +0100
Message-ID: <20251220235135.1078587-1-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This was initially planned to be sent as non-RFC, but given net-next
will remain closed for some more, might make sense to start sending it as
RFC v2.

Tested on Raspberry Pi 5.
All the changes are intended for gem only.

The series consists of two main changes:

- Migration from netdev_alloc_skb() to page pool allocation model,
  enabling skb recycling.
  This also adds support for multi-descriptor frame reception,
  removing the previous single-descriptor approach and avoiding
  potentially large contiguous allocations for e.g. jumbo frames
  with CONFIG_PAGE_SIZE_4KB.

- XDP support: Base XDP implementation supporting all major
  verdicts (XDP_PASS, XDP_DROP, XDP_REDIRECT, XDP_TX) along with
  the ndo_xdp_xmit function for packet redirection.

The driver now advertises NETDEV_XDP_ACT_BASIC, NETDEV_XDP_ACT_REDIRECT,
NETDEV_XDP_ACT_NDO_XMIT capabilities.

v1: https://lore.kernel.org/netdev/20251119135330.551835-1-pvalerio@redhat.com/

Changes since RFC v1
====================
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

Additional notes
================
  - Clamping is there and needed as rx_buffer_size + overhead cannot be greater
    than a PAGE_SIZE. This is fine as frames larger than PAGE_SIZE
    are still handled in a scattered way as intended.
  - Code in macb_xdp_submit_frame() and macb_start_xmit()/macb_tx_map() was not
    factored as the skb path, other than being scattered across skb specific code,
    also contains frags handling.
    Probably a unification attempt might better be done when multi buff support for
    xdp gets added.


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
 drivers/net/ethernet/cadence/macb.h      |  41 +-
 drivers/net/ethernet/cadence/macb_main.c | 811 +++++++++++++++++------
 3 files changed, 654 insertions(+), 199 deletions(-)

-- 
2.52.0


