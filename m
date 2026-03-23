Return-Path: <netdev+bounces-270762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE8YJJa6wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:11:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 135762FE19B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C34304CA73
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86337FF64;
	Mon, 23 Mar 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZssqvtv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESfjHEgF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C13822AB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303866; cv=none; b=uk0TJCPSful8/Mb/V7QDSXopSKFmYt0IjPZTR2K76OL0lhcGzI6n5qVbEmw0N2jSKiN+3XufsT57WrmerUJdCt/g0CSMvkwXGTxEKLcYIbi85YK0JV5iZRAP2YRYXiFzAPToHiiQQdi/t0Y0obmQUx+YbALVtg05XuLUCJozxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303866; c=relaxed/simple;
	bh=xxDltuTCUQFfG9lafcpm+cegGwDfzwq0UiJOMPWNp6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pLdCBpgA8ZRksJ7xesI1ffSnRqdEydjbW4YNXUHvel1hUePrTbHrrQc84MlcPlHvDLCX2ZP6cbu2oC3s9U4Ojky8MJEiD83ZkvTnU4ZpdMsMznK2TRJTwOZaDh/yA9oA5CQtVJO+6Njga9Q3HgecR+lSzrkUs8EbaSMYi6gzCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZssqvtv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESfjHEgF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774303863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RROtnppLIBAqhf1v+H7IHMFeOVYuOZlX53kZwHxSZd8=;
	b=fZssqvtvzAMuicmWFHjTT70lRQ1NaBONJhneSZMeE1op9efPk94ddS5l7N+vON0u/81a7J
	nchslq41+lGnleV2AUEMREuyBbO84jDUq4ajNDT+w4UToeXVd20i/sRXL47l9rpZmkTRWO
	4qKyfvVddJoHyFGRoHMyASHmPp8WBMc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-_RHiBsSvOMuigtTT5w4cQA-1; Mon, 23 Mar 2026 18:11:02 -0400
X-MC-Unique: _RHiBsSvOMuigtTT5w4cQA-1
X-Mimecast-MFC-AGG-ID: _RHiBsSvOMuigtTT5w4cQA_1774303861
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b3a0d25d8so2617103f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774303860; x=1774908660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RROtnppLIBAqhf1v+H7IHMFeOVYuOZlX53kZwHxSZd8=;
        b=ESfjHEgFhTF7GSs0pBj5G93XkBjhOvkEbcZdoAis96c4Rm9o80cBvwsq4zbfAHvbzn
         9Cgywayfwhr/BTRnHHr1FsQr3w8xQcoXKPtT3amXGBSnEUizisx+eq+DvcI5zsxAYfCa
         qAayMUb9jElVW7DoPfovxoFvme4SoiCSh2VZBVrq5WEfQtXHh1upetFcTCeZLx+Vkouo
         MuXVD0lcZwM+EVVcUVwbXYUAI0RJxUwiwKltu+omzpb7gwdivDOQ/yWF28JjgPi0dNhe
         DbjvANgbguHT7P+UB4z+mX4XuSIQrOt8W6g1mdrdW7sI+2G+/ZsGNcBxCuYgDMMU50Rb
         1vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303860; x=1774908660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RROtnppLIBAqhf1v+H7IHMFeOVYuOZlX53kZwHxSZd8=;
        b=a8sfNcNiUeyY9FmMh+f6xMyVQEJnQJ9JMMEcKUc+8DLZ4+8zXO8B3SGDme2odYKUPe
         0JyvYJaH8bzC8j/0y/lKXE8z1pY1mNp7UWqb/2b24LuKbIdMv44P07UfhU/qMwRKSqEz
         jEr+Vo8wNEFkWfpBBCQxT0XFfSw0hibecDeaMNElagri6mbFAWfvAMNFWw4MEhqhcS5i
         oc5tZeS02OWoEnxIqlaEl+/Jl3lphBeTCGxm/gQuoV3ExwNDY3oNBgfPlqFmrWNqnoB9
         38TNhIqcdIVs0jxJsLONQC+NYQyQigq6NQHpPcqgA3p5UcOu+GTQuQOrJpKS66pjPRam
         WRuQ==
X-Gm-Message-State: AOJu0YwX03Dpwwy4lWmGQxE/rm/WdHo+pH0HxWhgdrNe531Oq5F4aPEe
	vo+Jhk9DplUinR/ye0H5bFhJBYuTxZ7W5T5TujkKIjsP6a+HG5xJA3YfYBDleOcrEMp4xmk+LmM
	pb7MEXWXywXubB/GLSR0BlBX21/jkwpuV11O7GMo0n6yN+YPotOFPRiNKa2/hF3rruJT3tqeEeC
	hfBukBYXosJWtxJCspxwyezQs+t2T9n7qdoGrVl8sZrQ==
X-Gm-Gg: ATEYQzwCeZDbNdzpZEWHZ+h6APQvhuvhopllo8j+8fYWqxkzJFiqjNh2rvEdl/XhfSs
	1Ber4T4gYsTk2kzoGXdE7/1Oj/gobGpNfUTVhoVrLhb5z7EVe5opG5fNpk9llRo5UxBDXMXdH6D
	XHQ2NfKfWVtYkwjKSj5LS45p704vibc4ujRjxWo+TVAGlbw9g7dqZrdfDE4PH4GD6j+uglPFGm9
	VvH5PvcwC1AS1ND88TJZhVNLu0j8SxZZBSl0ccYKGOCVVUyKWvn91WVesNHNCu2dXTPxNZvH1wG
	j1/LcG8abI8uB5ZU8CDg6rBGWG2osKqDh6dHRMplv2HpvQk2M3piCtiSU2UcTthogv5L+sq2bDf
	j5RCV4YMdEwgsiOSf6wNR/o4acxbHpUSbYP1aMafACfUDR3anKDw=
X-Received: by 2002:a05:600c:3546:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-486fee29536mr194196905e9.25.1774303860005;
        Mon, 23 Mar 2026 15:11:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3546:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-486fee29536mr194196575e9.25.1774303859388;
        Mon, 23 Mar 2026 15:10:59 -0700 (PDT)
Received: from localhost (net-2-44-37-38.cust.vodafonedsl.it. [2.44.37.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f822b83sm6185825e9.4.2026.03.23.15.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:10:58 -0700 (PDT)
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
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v6 0/7] net: macb: Add XDP support and page pool integration
Date: Mon, 23 Mar 2026 23:10:40 +0100
Message-ID: <20260323221047.2749577-1-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270762-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 135762FE19B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested on Raspberry Pi 5.
With rpi5 is not possible to test the !RSC case. Tests are welcome
as it potentially changes the offset of the first frame
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
  - v5: https://lore.kernel.org/netdev/20260313201433.2346119-1-pvalerio@redhat.com/
  - v4: https://lore.kernel.org/netdev/20260309144353.1213770-1-pvalerio@redhat.com/
  - v3: https://lore.kernel.org/netdev/20260302115232.1430640-1-pvalerio@redhat.com/
  - v2: https://lore.kernel.org/netdev/20260223182632.1681809-1-pvalerio@redhat.com/
  - v1: https://lore.kernel.org/netdev/20260115222531.313002-1-pvalerio@redhat.com/
  - RFC v2: https://lore.kernel.org/netdev/20251220235135.1078587-1-pvalerio@redhat.com/
  - RFC v1: https://lore.kernel.org/netdev/20251119135330.551835-1-pvalerio@redhat.com/

v5 -> v6
========
  - Fix typo in commit description (Nicolai Buchwitz)
  - Remove double space (Nicolai Buchwitz)
  - Old [4/8] was sent separately (Nicolai Buchwitz)

Note: [1/7] slightly changed after conflict resolution. Reviewed-by from Nicolai
      was not carried because of that.

v4 -> v5
========
  - Call missing macb_tx_lpi_wake() in macb_xdp_submit_frame() (Nicolai Buchwitz)
  - Restore old_prog (instead of NULL) in gem_xdp_setup() on macb_open() failure

v3 -> v4
========
  - Remove inline from gem_rx_data_len() (Paolo Abeni)
  - Rate limit the netdev_{err,warn} in gem_rx() and gem_rx_refill() with to avoid log 
    flooding under error conditions (Paolo Abeni)
  - Fix missing newline in netdev_err() for MTU validation in ndo_change_mtu (Paolo Abeni)

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


Paolo Valerio (6):
  net: macb: rename rx_skbuff into rx_buff
  net: macb: Add page pool support handle multi-descriptor frame rx
  net: macb: make macb_tx_skb generic
  net: macb: generalize tx buffer handling
  net: macb: add XDP support for gem
  net: macb: introduce ndo_xdp_xmit support

Théo Lebrun (1):
  net: macb: move Rx buffers alloc from link up to open

 drivers/net/ethernet/cadence/Kconfig     |   1 +
 drivers/net/ethernet/cadence/macb.h      |  43 +-
 drivers/net/ethernet/cadence/macb_main.c | 967 ++++++++++++++++++-----
 3 files changed, 782 insertions(+), 229 deletions(-)

-- 
2.53.0


