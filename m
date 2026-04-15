Return-Path: <netdev+bounces-278700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPIbLO9M32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:31:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8C4401FED
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3903C30A61A9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920993CD8B7;
	Wed, 15 Apr 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSS0qaPO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA8391E44
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241631; cv=none; b=sFv4cK2ZgVmGrABwPaUGiYfKj+HJh4jIkCLDzmOxHFCkOPGnXBDji5pnFCnZvIMTzPBOeVtrYqwAIGUSsmNpC5B8AokY4ibkTliliB0itX1W5qTJbbQp9Sbw0PkbKqXW5VP2uPP0Psfu+qfJRru3nc9waVD2SR2KF3S0bMBzpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241631; c=relaxed/simple;
	bh=hMzjVc3Cn9l85etUK1tHR3p0M0YY8+4rAJHaPUKj5Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GHUx358dhXvvO25YvVZ9N46QilvLO4xSUJKNKAkHtCveEMBkxYcq/E0LbipKQaTxGgISptYnBIOics2xtl+YZdcUXT9ee0rsjLhzlIr2ZUmJ9wfH3bdGmUNbbowUmqU9li1G3cJACagMkSIrHGYkQMn0aN4/1gMb4o/R+BZucDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSS0qaPO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so49678055ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241629; x=1776846429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm5iSouNfDbTWxQtC2q/PDgrb7odjtEmqv4Pfv6847M=;
        b=WSS0qaPOpw/wD7pDKo4K34pjkicgIlYdEI+wMXs7jZ1P5Ao3owHB+aGUl3/iVWuOrF
         0XU7HEkJGlQ9y6WCIsgcieoi+bqppZNOPPnUTshNyC41OEYvLas8PctyKpx9O/9jzTOh
         RFO4AIOUfK2IRJT+6IJeM+/gAhayPcwOEQ/E8nf64dcfoVETGpeSTKstCdf3qHzW+bf+
         fl3LnyqytS6PtItXwuZmbwgtd0YkqzigEqXlanoMo7PqDbK9JO3PYTVSnyLrNd0xSNYI
         KyHOa07lGquZbv3tX5RTfYy2Ce2tAdUg4TFaUoD1zfOsgoaG0ZGPb7NS+ZChqP+3p2ws
         KKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241629; x=1776846429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm5iSouNfDbTWxQtC2q/PDgrb7odjtEmqv4Pfv6847M=;
        b=cjNKX7cC1XE8a9+yTd1Aup+pcOdZZ8jQtwZaVoWfbei/0ZFJouFEjc6zGR+pLrZ7H8
         uoG/hm0HHGWMtVoz3NgCXfmv20bWPUBl8YSxR2MUJ3eT0v+jJO7BHhMhTeDoSq/7zsqp
         fkadW6tHtqL9zUONbLqasmXdqH5H7YqgVNYW5ZoHD8kJY3/SLwYzV/1LJh8W7HNS9dt5
         GTfHKirlWPBFvi1ZS2Ng4JaoZOe04s+OOfXuqmBStY4tzELlKPDnTO1paHtj94oRfAaZ
         +qv/ZGwy9EoW+JzMAz3ZRLek3JDJynZSWBgF+4o9UBf4vDMkWWWs7t3JDTAgYeVxBnn/
         nubg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZXItOhf3ip06jLL2yOlWw7iUnwPtX+yyV4w7XSSiDY67xMr8nrn67ahYn8zIgqjZ/Hae572Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxO2j2fykq6LTXF85IYGDtuZUsd/ZZefDiE0JYSbbb7bH1kg4
	6PRt6jEPdsPmwg3BT98usKeNJGg1OacQ+bsNZUbalS0YsEROLzyGpvt7
X-Gm-Gg: AeBDietFJGv+g2TQEvfSD3YSyP97ETIs5UK3LTrI0Ym4U1aGl1hGozuiL9KKUD989ck
	d+GOL1LwU37k1Kg8XPAVCxDHfMIurwpVWSlniQRNChrhzofIrSgFk/NeElKeo7M4tD/KN6qPAHI
	gj67JJFhntwxFPIU0eZAIpSVTHX1Pq+aEMRwj/Lyslflqc8MHkP5iXBELzbPyoZl7U5JDW25Nxs
	1VMybk3bjFGee62fXgzfRskIN4hxYQzPVsj/G43gnqkcxBDsAbiPXq4aVa9hfnJmp+nPlMlHI/u
	luABn1rOflkULVcgSi++VPoB/y6eLtxMksRo9SgErQr2umgRIaDzfEsWJTRASokkje31Yh4A8uk
	HAmzoC1NUrZ2jd3MoVcLf3YY+WEn2w2Ep/9MToUJ++SR4OBlt2ww8MdoufkmT5vcg0nUITwZ3tU
	wajQqcsQxYvLfMC3LIHnOIA363vtxpoMKtAidNPgFUxu54z5kx5Bwuod8EraF1/ATYJ7vEdRa/u
	Eoj5u40ljpSJTMoOys=
X-Received: by 2002:a17:902:7249:b0:2b2:4cd2:e174 with SMTP id d9443c01a7336-2b2d5aa42d9mr154214885ad.43.1776241629460;
        Wed, 15 Apr 2026 01:27:09 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:08 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 00/14] xsk: batch xmit in copy mode
Date: Wed, 15 Apr 2026 16:26:40 +0800
Message-Id: <20260415082654.21026-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278700-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3A8C4401FED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Greetings, everyone. This is the batch feature series. Even though
net-next is closed, I would appreciate any feedbacks and suggestions
on this! Many thanks!

Bottom line up front: it improves the performance by 88.2% stably.

# Background
This series is focused on the performance improvement in copy mode. As
observed in the physical servers, there are much room left to ramp up
the transmission for copy mode, compared to zerocopy mode.

Even though we can apply zerocopy to achieve a much better performance,
some limitations are still there especially for virtio and veth cases
due to the implementation in the host. In the real world, hundreds and
thousands of hosts like at Tencent still don't support zerocopy mode
for VMs, so copy mode is the only way we can resort to. Being general
is its strong advantage.

Zerocopy has a good function name xskq_cons_read_desc_batch() which
reads descriptors in batch and then sends them out at a time, rather
than just read and send the descriptor one by one in a loop. Similar
batch ideas can be seen from classic mechanisms like GSO/GRO which
also try to handle as many packets as they can at one time. So the
motivation and idea of the series actually originated from them.

# AF_PACKET Comparison
Looking back to the initial design and implementation of AF_XDP, it's
not hard to find the big difference it made is to speed up the
transmission when zerocopy mode is enabled. So the conclusion is that
zerocopy mode of AF_XDP outperforms AF_PACKET that still uses copy mode.
As to the whole logic of copy mode for both of them, they looks quite
similar, especially when application using AF_PACKET sets
PACKET_QDISC_BYPASS option. Digging into the details of AF_PACKET, we
can find the implementation is comparatively heavy which can also be
proved by the real test as shown below. The numbers of AF_PACKET test
are a little bit lower.

# Batch Mode
At the current moment, I consider copy mode of AF_XDP as a half bypass
mechanism to some extent in comparison with the well known bypass
mechanism like DPDK. To avoid much consumption in kernel as much as
possible, then the batch xmit is proposed to aggregate descriptors in a
certain small group and then read/allocate/build/send them in individual
loops.

Applications are allowed to use setsockopt to enlarge the default value.
Please note that since memory allocation can be time consuming and heavy
due to lack of memory that results in complicated memory reclaim, it
might not be that good to hold one descriptor for too long, which brings
high latency for one skb.

# Experiments
Tested on ixgbe at 10Gb/sec with the following settings:
1. mitigations off
2. ethtool -G enp2s0f1 tx 512
3. sysctl -w net.core.skb_defer_max=0
4. sysctl -w net.core.wmem_max=21299200 and sndbuf is the same value
5. XDP_MAX_TX_SKB_BUDGET 512

taskset -c 1 ./xdpsock -i enp2s0f1 -t  -S -s 64

copy mode(before):          1,801,007 pps (baseline)
AF_PACKET:                  1,375,808 pps (-23.6%)
zc mode:                   13,333,593 pps (+640.3%)
batch mode(batch 1):        1,976,821 pps (+9.8%)
batch mode(batch 64):       3,389,704 pps (+88.2%)
batch mode(batch 256):      3,387,563 pps (+88.0%)

---
RFC v4
Link: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/
1. fix a few bugs in v3
2. add a few optimizations
The series is built on top of commit 2ce8a41113ed (net: hsr: emit
notification for PRP slave2 changed hw addr on port deletion). Since the
changes compared to v3 are too many, please review the series from scratch.
Thanks!

v3
Link: https://lore.kernel.org/all/20250825135342.53110-1-kerneljasonxing@gmail.com/
1. I retested and got different test numbers. Previous test is not that
right because my env has two NUMA nodes and only the first one has a
faster speed.
2. To achieve a stable performance result, the development and
evaluation are also finished in physical servers just like the numbers
that I share.
3. I didn't use pool->tx_descs because sockets can share the same umem
pool.
3. Use skb list to chain the allocated and built skbs to send.
5. Add AF_PACKET test numbers.

V2
Link: https://lore.kernel.org/all/20250811131236.56206-1-kerneljasonxing@gmail.com/
1. add xmit.more sub-feature (Jesper)
2. add kmem_cache_alloc_bulk (Jesper and Maciej)

Jason Xing (14):
  xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
  xsk: extend xsk_build_skb() to support passing an already allocated
    skb
  xsk: add xsk_alloc_batch_skb() to build skbs in batch
  xsk: cache data buffers to avoid frequently calling kmalloc_reserve
  xsk: add direct xmit in batch function
  xsk: support dynamic xmit.more control for batch xmit
  xsk: try to skip validating skb list in xmit path
  xsk: rename nb_pkts to nb_descs in xsk_tx_peek_release_desc_batch
  xsk: extend xskq_cons_read_desc_batch to count nb_pkts
  xsk: extend xsk_cq_reserve_locked() to reserve n slots
  xsk: support batch xmit main logic
  xsk: separate read-mostly and write-heavy fields in xsk_buff_pool
  xsk: retire old xmit path in copy mode
  xsk: optimize xsk_build_skb for batch copy-mode fast path

 Documentation/networking/af_xdp.rst |  17 ++
 include/net/xdp_sock.h              |  17 ++
 include/net/xsk_buff_pool.h         |  10 +-
 include/uapi/linux/if_xdp.h         |   1 +
 net/core/dev.c                      |  49 +++++
 net/core/skbuff.c                   | 152 +++++++++++++++
 net/xdp/xsk.c                       | 279 ++++++++++++++++++++--------
 net/xdp/xsk_queue.h                 |  40 +++-
 tools/include/uapi/linux/if_xdp.h   |   1 +
 9 files changed, 473 insertions(+), 93 deletions(-)

-- 
2.41.3


