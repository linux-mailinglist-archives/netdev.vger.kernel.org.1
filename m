Return-Path: <netdev+bounces-260145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMEIDwicnGmhJgQAu9opvQ
	(envelope-from <netdev+bounces-260145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7817B77C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A82302EE83
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF3340285;
	Mon, 23 Feb 2026 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDIdg1lF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dq9+d5h/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60880340280
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871237; cv=none; b=NIRLi7Kw6UHz4bRaWtwv4awCTvC7vGuYUDpoqmR71cUSHGwOnQEQoffIMDi6ZEvxAM2b4WYt95YdNELzsEgut/vK7tKB8AI2elLlAlUmU58ao8o4xh/qTnDKBTYMD6Ctc5ygQW+u0OojnOSKb8cFMeVRHvhzz7ImzsWyakPGcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871237; c=relaxed/simple;
	bh=bkFr+gEJJhDbKuh6gtC/e1x/xunSNIx/YqEJ4yL/x3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aDU9f2oksYGEKlZM70x8pbc6+F4pmCNhMeIRbJorLuS3LTpf6KkCxEQRpO9Njh5CIbvP3xcswt6m246m1L02e3LjWCVkOZXNZPXEduZfAParkw8S0U9qbMVbb7btRUNthkRqQU/aUpfOSsPsW4tbQuHZ2ayQ9CNgZY41Wl06zcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDIdg1lF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dq9+d5h/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0HqM6wPaklNT23Z6yr2ZRM+qapNVEnC2TDI+Q9p3vFw=;
	b=WDIdg1lFjLTtvsurnkT+f5o5MYEOcQqAuLv91/CyXGLKFc0aou/1YdjovvcaameCYiKtPg
	0qNzEdaAjOjtQryrpbI92yAjc9tQm8wB7+4ONIbxVosJkAzAU1lJTE60S1VBVrYu9DeGce
	4HVS2QkHepO8j6kubvi8XiIgXW1CirM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-BQUifl5pNPqvclPaUvGDOw-1; Mon, 23 Feb 2026 13:27:14 -0500
X-MC-Unique: BQUifl5pNPqvclPaUvGDOw-1
X-Mimecast-MFC-AGG-ID: BQUifl5pNPqvclPaUvGDOw_1771871233
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso34649515e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871232; x=1772476032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HqM6wPaklNT23Z6yr2ZRM+qapNVEnC2TDI+Q9p3vFw=;
        b=Dq9+d5h/Vl6HKjmtxViIKg3QXxxOL/S4MRTc5v9Tx1U2BU2jTzhSvkaUPVBGh1WY8y
         BSz7uSZHj15jT/mwJ0PvI3Nv4GjcQxN2JHJbkRG87Bz7WORAEMfPOap9SjNeA8l8xr1o
         +vKzl+C2d0ULBM+k0jnC48XC7nBxAwv8WDU9GFUaUA/vf7UmPtlvQZMS79X/QW3F41pm
         WPz0oFTugrjvRMcxWj0NmInYYD7tzqXJgelbXzDk7roNGNb0wbimHWdg1yo5nFsDL4hp
         irkuJ+19DKNQDffkNW44htHlNpxXBt0Alx889jUcJwvnJr590uq5jeHukRN/FIUkwjo2
         obpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871232; x=1772476032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HqM6wPaklNT23Z6yr2ZRM+qapNVEnC2TDI+Q9p3vFw=;
        b=FOdXT6vxD5JYUXuhYuIalg7kpssy38TA5ka/rPxBhcA+zVzjU/MnvL6Rim/IcbPvQy
         vDtamZrmcJRod2lAvL5QHy/lZxFqgyAHfp7MeJyhs9peKy1YwFzOEfedx8gaeAwg9aNg
         dTMzExZuUniOxzq8gy02U5y+SGKXuAaZAwH5flRgk1A9H3GXdkVdPMzwIOK6Nbfk39vz
         An1sfL0+0vDRPpqbar1huw7cOMNUOJKKERUqiUqv/ub6HxvIZuXAz8xwj25RCftTcDSv
         YXMUxYujRBa/NNsHFqBzUpTHD6GCmTKovT1/0kbIiF8yALvc3i6NSg/xRZ6XQb+ad8nR
         EffQ==
X-Gm-Message-State: AOJu0Yx3lQAwC1e7CWuoL31lmHdF5a0BHDvJ90q0R85BHngiUO+mM4n1
	MBJWUW4W5Zwdo6EHJhgdqlP7U39GRdIvYgnNlvAN9h2ssIIXQhvmckRVTvok1tVRONw5kFagCIu
	8AIu0RWc/hEtd67G2U9iVCiscShphilVUeesyMMIfm7YzlQyHPqXEMpJ0K7ALeEYpNA6nieri1L
	/EDEkBE8aXbx6SqNlrYMiJVDP+DdVwsn/VuoWBpBxPnQ==
X-Gm-Gg: AZuq6aLirKfMu/KY0cYvMBXWK/M8nyeMa3qfFxi6xRueU2jqFrIhz9n+EAlwuO9HmRP
	MlcXXrVla7pUZJbnbhnWqWG6F1jBiwJmfT86gCN+Mn7hAlkv4aIcjoTapoaZHTm4ircWaLlvuyV
	WyVOVsaqyEfmiKC6VJGl62WDfnfGnbGmK8G2i2u24RUALORGZn6vH5LEHmKQp1VvbQhT0tHCnIs
	F6zTHNvfibkdJ+kZS33wekt/TLUM3dVZ9iajLtD1D0Lozs/TNTUnSsBVsOVlIkSUnogA2HBbp9t
	BC/TDdHp4xMaqHCrT49B5/+MEWlkFXno+f7tRtwBXVYzolhxGWe9yHEEHsbFVykv9E5E6zu1MMD
	OnsBIoJCk9Gz5mJNXvLDmymR65otOw8ChbnvNJ1hYisw+WyHzNcRkSHyjOp0=
X-Received: by 2002:a05:600c:450c:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-483a963d656mr163256015e9.31.1771871232285;
        Mon, 23 Feb 2026 10:27:12 -0800 (PST)
X-Received: by 2002:a05:600c:450c:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-483a963d656mr163255435e9.31.1771871231692;
        Mon, 23 Feb 2026 10:27:11 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316eb08sm308015905e9.0.2026.02.23.10.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:27:11 -0800 (PST)
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
Subject: [PATCH net-next v2 0/8] net: macb: Add XDP support and page pool integration
Date: Mon, 23 Feb 2026 19:26:24 +0100
Message-ID: <20260223182632.1681809-1-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260145-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96B7817B77C
X-Rspamd-Action: no action

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

Some numbers (Andrew)
=====================

  Initially reported numbers (Mbps, w/ drops on the rx side):
  
  https://lore.kernel.org/netdev/b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch/
  
  The numbers are essentially always the same with these two packet sizes.
  cpu0 doesn't appear overloaded. Not sure if there's a bottlneck at the
  interface level on my hw, but it seems cpu can handle more.
  
  Second test run (with no drops on the rx side):
  
  tx side: iperf3 sending UDP (256B) packets roughly at line rate (no drops
  on the receiving side).
  
  rx side:
  - fixed cpu frequency
  - single rxq on cpu 0
  - iperf3 server on cpu 1-3
  - average w/ mpstat 20s interval 20s count
  
  Baseline:
  
  Average:     CPU    %usr    %sys    %soft  %idle
  Average:     all    3.64   15.05     0.87  80.42
  Average:       0    0.05    0.15    10.23  89.56
  Average:       1    4.20   16.98     0.00  78.81
  Average:       2    3.67   15.53     0.00  80.79
  Average:       3    4.07   16.83     0.00  79.09
  
  Page pool:
  
  Average:     CPU    %usr    %sys    %soft  %idle
  Average:     all    3.76   14.91     0.74  80.57
  Average:       0    0.05    0.12     7.81  91.98
  Average:       1    3.88   15.53     0.00  80.58
  Average:       2    4.35   17.23     0.00  78.42
  Average:       3    4.22   16.63     0.00  79.11


Previous versions
=================
  - v1: https://lore.kernel.org/netdev/20260115222531.313002-1-pvalerio@redhat.com/
  - RFC v2: https://lore.kernel.org/netdev/20251220235135.1078587-1-pvalerio@redhat.com/
  - RFC v1: https://lore.kernel.org/netdev/20251119135330.551835-1-pvalerio@redhat.com/

v1 -> v2
========
  - Fix potential NULL pointer dereference in gem_rx() when receiving an
    unexpected non-starting frame without an active skb (Jakub Kicinski).
  - Make sure to release both the pending skb and the current buff in fragment
    overflow error path (Jakub Kicinski).
  - Reuse the existing page pool instead of creating a new one in HRESP error
    recovery (Jakub Kicinski).
  - s/page/buffer/ in netdev_err() print out (Théo Lebrun)
  - Ensure pending queue->skb is released in gem_free_rx_buffers() (Théo Lebrun).
  - Use NET_SKB_PAD for the headroom when no xdp program is attached
  - Add netdev to pp_params (for pp stats)
  - Move ip_summed handling when RX_EOF is set as RX_SUM may not be reliable when
    RX_EOF is not set.
  - Sync for device no longer relies on PP_FLAG_DMA_SYNC_DEV reducing the
    sync size.
  - Introduce rx_ip_align field in struct macb
  - Fix incorrect DMA direction for page pool when attaching XDP program by 
    restoring close/open sequence as in a previous version (Jakub Kicinski).
  - Rename release_buff() to macb_tx_release_buff() for clarity (Théo Lebrun).
  - Do not unmap dma for XDP_TX buffers by ensuring tx_buff->mapping is zero for
    MACB_TYPE_XDP_TX buff_type (Jakub Kicinski).
  - Always return memory to pool on xdp_convert_buff_to_frame()
    failure (Jakub Kicinski).
  - Remove skip_xdp label (Théo, this is a bit different from your suggestion,
    let me know if you have a strong preference here)


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
  net: macb: Add page pool support handle multi-descriptor frame rx
  net: macb: use the current queue number for stats
  net: macb: add XDP support for gem
  net: macb: make macb_tx_skb generic
  net: macb: make tx path skb agnostic
  net: macb: introduce xmit support

Théo Lebrun (1):
  net: macb: move Rx buffers alloc from link up to open

 drivers/net/ethernet/cadence/Kconfig     |   1 +
 drivers/net/ethernet/cadence/macb.h      |  41 +-
 drivers/net/ethernet/cadence/macb_main.c | 850 ++++++++++++++++++-----
 3 files changed, 689 insertions(+), 203 deletions(-)

-- 
2.52.0


