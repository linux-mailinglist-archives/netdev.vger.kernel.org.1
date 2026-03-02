Return-Path: <netdev+bounces-262626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIAdEQx6pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:52:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B237E1D7E27
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A26C83002E58
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834353603C3;
	Mon,  2 Mar 2026 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PK2rNJob";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gruKAFf8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D71448D5
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452361; cv=none; b=YRR0A9XlztkgAxNIm4RU6kSw3/FAzv1a4oiLcT1bW/GJ8dErI/b1xI45xFuR3z0laqlKyHXahBAZE66tc5VwfBva0B7E8PIvmkNNXccL7Q38NtaB0gkbw6W5T+WiR6RrW/dcrf73mD1tkuhU0U91dtENZakPQMkQ6r5TLLz5FSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452361; c=relaxed/simple;
	bh=NbzPcaTSWpnMBHobBcGEV8fINXHt9qRFIi77OCLle1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BSrdg3WAJ3dajHvNGkl0xi38IRSS2mvxOMVhzFal4oKg6balQeSu7B4oQx7vtVajAJ6ITjNQS1u7bT+CverOh5FtRHI2v1Rcsig0HSqhOo+Ek8E2NY3kurxbH1MiBI4zqXZeuCQ9XSKgUKHqRRQ/KPpNeCLmoHBAWxUtwgip+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PK2rNJob; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gruKAFf8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JkyxFtCf+Tx/eB5rWy5yXZrfx0kjKqqBUP+zVstmXzI=;
	b=PK2rNJobc9PvCfdWhYTsXMFE/bwIColDy3uzIz5EpNH4py0Xu7SVKGiUKS6ZYog+pRJAAQ
	uloWZb+Z2GUnkm1/2oibYdHLBkB2iGl+g8VeYQTG2rE03nzUd+13ViRh67ELPFgDgIEZYE
	XaUbzgGU4b/HbEXFHnl72l2GRVEKuUk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Rom9RoHUMtKHLscjZqBRwA-1; Mon, 02 Mar 2026 06:52:38 -0500
X-MC-Unique: Rom9RoHUMtKHLscjZqBRwA-1
X-Mimecast-MFC-AGG-ID: Rom9RoHUMtKHLscjZqBRwA_1772452357
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439b50320a0so841784f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772452356; x=1773057156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkyxFtCf+Tx/eB5rWy5yXZrfx0kjKqqBUP+zVstmXzI=;
        b=gruKAFf8EG+QZQbrKzXYW65gCgwExssWiZdl09JzZFaeg8ytkKzS1aiLHWxCqRzTCw
         9TnLF/LofK7UZoa/M8TaM4d8kISnxNfPnK00RvB838f5I9s3SUOMSsZvQvzca8zuGo1z
         /s6ptF/yIf9jxOLNs0xrGKvKo3Fhl1Ke/AMb3k5t5teI2ZhNK9mYc0iklY/6UjtvdhSh
         thd69m9vYfn66NWQmXAOglkMojWwvweuIivIXAx+KHWqm91cz276LDmNDFyCR+6m/EAu
         N2/NcHgToTOXkXbBucVBdeHj2GNQeAVGdJZsFEyClYqhsmwJBB54O7CvQ1hQ/W4HS71a
         sZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452356; x=1773057156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkyxFtCf+Tx/eB5rWy5yXZrfx0kjKqqBUP+zVstmXzI=;
        b=DgtsNVFTEbSNxeIvV2M7tljKb8kwhRolx3ZcCt9a2ql/k1zDgKwfDE3LNQwEA65Zn5
         xVr06qBBj7/1yDS4vXYBHCGn8ehS1/6IlPVpUFQ45e55N+N0NrUZftdjfytTp/fyXVcO
         0ktUlkXf2dLu7QaV7qCCricmyfhEkSciWleRVbSBB/FsSb70XWGeCmk+46i9+26ZQiyR
         H6gJa3CSbMd74AsElDWlOgbU3JCoBmqJxHozjcAWy7/uIuV0rcOCarQvfBBtFwltysY0
         usUNBwAQbGwCyw24u7542x2O51DYZN8KcdAJ9LMqDhbH5bXg2KKV0Pv+e79RL5vWRYd0
         74dw==
X-Gm-Message-State: AOJu0YyI7skjakXihBsS3qPM00k6ZkkZ2aE42pei7UhprHyadtuULHdZ
	0OIlLQy6ItlZVVmXv4tWLpj3nKJR+4xes4/fmPyxk+Lr2xKtsWsCacyogYDaOH3TuGPYUuR4u83
	q/8yjyjT+eocB3pv4ReKwaHFvL2iWa3ddQD/TGTad8w41+NCpucikqySC4Fxj/Lw9cmD/O8oQux
	NXpQlFnJGnnlIzTWuiz63FSaMW+XI3/0ZSQ4PB4GTjjg==
X-Gm-Gg: ATEYQzzy4ZnynlyPqva0sYv2n6LveTH2MoxFMtxqJSxSWUzrgM3OHbmYWjs+IhQwn2k
	ItkBLQ4hlKxm2imfNGkrNwLU/+saHJL298vabCoVw56H4dDO3hb8JN5hOJzsa4IaYHZRwnqAECO
	Zasp7TQiODoOpSH6ZkRabMqmVbhsQMRQQxfLEH6oweXU7vGKcvfZcOEM2Y3WM5NheveRki/RqcL
	tap9yFWR/lfmGGRCcAOY2ZGXIC6nYd3y4iE7copnyMl08eYRM0s97K2+Ykx2G6U3llkeFjYDpL3
	ze/Po1Sj/9h8lRkIW6c3ds6PmbV9vH7tvSAsjj8nnc5lUpFL5g6oWfxBJr5FSRxz13Yyp7iBQRO
	fg7/uG+/BPcmP52i9qBKlMPxi14JSyHLNUEvLxjZsyKc88Nu350tiDknZCQE=
X-Received: by 2002:a05:6000:2dc6:b0:439:b79d:b9a6 with SMTP id ffacd0b85a97d-439b79dbc2amr5809327f8f.11.1772452356137;
        Mon, 02 Mar 2026 03:52:36 -0800 (PST)
X-Received: by 2002:a05:6000:2dc6:b0:439:b79d:b9a6 with SMTP id ffacd0b85a97d-439b79dbc2amr5809259f8f.11.1772452355519;
        Mon, 02 Mar 2026 03:52:35 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503424fsm10336136f8f.22.2026.03.02.03.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:52:34 -0800 (PST)
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
Subject: [PATCH net-next v3 0/8] net: macb: Add XDP support and page pool integration
Date: Mon,  2 Mar 2026 12:52:24 +0100
Message-ID: <20260302115232.1430640-1-pvalerio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262626-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B237E1D7E27
X-Rspamd-Action: no action

Tested on Raspberry Pi 5.
With rpi5 is not possible to test the !RSC case. It would be nice
to test it, as it potentially changes the offset of the first frame
(hw shifts of NET_IP_ALIGN bytes on rx).

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
  - v2: https://lore.kernel.org/netdev/20260223182632.1681809-1-pvalerio@redhat.com/
  - v1: https://lore.kernel.org/netdev/20260115222531.313002-1-pvalerio@redhat.com/
  - RFC v2: https://lore.kernel.org/netdev/20251220235135.1078587-1-pvalerio@redhat.com/
  - RFC v1: https://lore.kernel.org/netdev/20251119135330.551835-1-pvalerio@redhat.com/

v2 -> v3
========
  - Drop mog_init_rings() call in macb_open() reintroduced by mistake while
    rebasing (Jakub Kicinski)
  - Move [5/8] down in the series (was [6/8])
  - s/void/sk_buff for the skb parameter instead of updating the documentation
    because of its void type as this seems to better fit the scope of the
    patch (Jakub Kicinski)
  - Move [6/8] down in the series (was [7/8])
  - Remove misleading check on tx buff type (MACB_TYPE_SKB) to improve
    clarity as all buffers are MACB_TYPE_SKB (Jakub Kicinski)
  - Update commit message to better fit with the patch content
  - Move [7/8] up in the series (was [5/8]) as XDP_TX has now been folded in
    this patch honoring the advertised features (Jakub Kicinski)
  - explicitly return 0 in gem_create_page_pool() instead of err (Jakub Kicinski)
  - Revisit gem_xdp_valid_mtu() and related helpers lifting the dependency with
    bp->rx_headroom. It now always uses XDP_PACKET_HEADROOM (Jakub Kicinski)
  - Use xdp_return_frame() in workqueue context (Jakub Kicinski)
  - macb_tx_error_task() now locks tx_ptr_lock (Jakub Kicinski)
  - Remove redundant check for clarity (Jakub Kicinski)
  - Take into account head adjustment in macb_xdp_submit_frame() while syncing
    in the XDP_TX path and for the XDP_PASS codepath.
  - Some helpers renaming for clarity
  - Do not to leave bp->prog pointer in gem_setup_xdp dangling on failure
  - Revisit rx_buffer_size to better handle the RSC/non-RSC case
  - Return error in ndo_xdp_xmit if the interface is not operating
  - Handle packets count in macb_tx_complete() for the xdp case

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
  net: macb: make macb_tx_skb generic
  net: macb: generalize tx buffer handling
  net: macb: add XDP support for gem
  net: macb: introduce ndo_xdp_xmit support

Paolo Valerio (7):
  net: macb: rename rx_skbuff into rx_buff
  net: macb: Add page pool support handle multi-descriptor frame rx
  net: macb: use the current queue number for stats
  net: macb: make macb_tx_skb generic
  net: macb: generalize tx buffer handling
  net: macb: add XDP support for gem
  net: macb: introduce ndo_xdp_xmit support

Théo Lebrun (1):
  net: macb: move Rx buffers alloc from link up to open

 drivers/net/ethernet/cadence/Kconfig     |   1 +
 drivers/net/ethernet/cadence/macb.h      |  43 +-
 drivers/net/ethernet/cadence/macb_main.c | 918 ++++++++++++++++++-----
 3 files changed, 748 insertions(+), 214 deletions(-)

-- 
2.52.0


