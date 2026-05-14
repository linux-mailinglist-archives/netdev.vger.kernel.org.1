Return-Path: <netdev+bounces-287917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNrCOA6pBWrtZQIAu9opvQ
	(envelope-from <netdev+bounces-287917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517F540992
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B212030990B4
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462523A874D;
	Thu, 14 May 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Sh1rVCtM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121A3A6F03
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755637; cv=none; b=SiK+u2+LMm5LEMsrZ+h1cYo0dZ3vYFcEfK3NYhU5Qc6wL3IKzlR6pnkykNneqXWrW8y3F5tFE0AI0OzQ84enFOopRsI3LWxRmhxdENJCqZTvYcuSTg6DQbd46rr/ElUQEbU+u2auef8s6fZSZJnHEj5yblw1zuWZNQJZDjWZKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755637; c=relaxed/simple;
	bh=+CrmjDGr2JNHGvY/tkxLtymQWoIJOtkgZfzqjdARtNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cVFNBI5MmMFrRBK8UJ3opPiBXHF4fxPROClWDj4qreGhDqwo51lzDKPwfeVbaTdsloK6RMgBM5TLbrRo3VCPUrTAwV8LhWr8ooiEMnIjiQO/jRc7npU0k3yKSgjLaHw5MuyNbB63Py8ygrNdLUlGhyg2Q+08xpXpoyHQQYmrkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Sh1rVCtM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd124546379so613133366b.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778755633; x=1779360433; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4uxss1CtZcDp0zNhfAFf+hQx8oKtm2lVjhVo3APIjM=;
        b=Sh1rVCtM7DUXoe1+qA0CuDQC8kGrQiIUMS3uKythfnVjpH7Gz64cBNjQyvnfyPUEL7
         ugkA5QM1nWZh1Qf4djLFa3cxY/PRuVWwBOPM/uONTEBSe+aGDCKktwpHccBEkaT2sB66
         j2BLtLI1ADxoUGNWitbU7LDuMYy5rWI6ev4LKkOuk8lN37U/oy8FHi5nQ9V5zUOuOetM
         vpFs4xJz/D2IfNUFVI5WHmKpBZtGlodXRtW0u8w24TPt3Eu/wzwWYWmTAgXuNwG7RrRt
         +LuZh0jFvAkLKDz4w2d19AexrAh9w6VRxna0zuDcqJyI0Rv/lUI9B8I4TANudacLtc8P
         ybZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778755633; x=1779360433;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4uxss1CtZcDp0zNhfAFf+hQx8oKtm2lVjhVo3APIjM=;
        b=AOCURqUG2R40gyPLuGQ0W4MiXiiOX3onAvEEYlVT5dyDRhdvPUGfsQdpxrRQ6J8dYO
         +POoXCihd/Lq29/2C55qmZQrpDz4xhwH+nO/ourDOWDvu4NyPQ/YpK4MlcBL5/wYSs4F
         IPqBvROavEzGvkwVjpt2cN+r0PHk/qwJhtEIz4tHk6Cs+eRctWNXClhUv++m/MnjPAIL
         nClkz3+qPRxPGj7qSoGQS/lfRc1EesaJkJMmkkZFlRe0hZpvSpnvmSBUq623btbB+ZAp
         bAG5LVI0+wkrB/3GFLuHjTiilUef2PH4OOYJ/cte53bPp0KNhXn2yNgsyN61Vl01QF4N
         OJwg==
X-Gm-Message-State: AOJu0YxfkxUcwhom51pI6KOTh2UmVTrCrZRA3zYeKLH2T3VBrIzslaGo
	9OxKkfZ6WMKHpyf1yGMon/SgdtxRPSbnDO88xykMqbVu7GS0yXfiRa/RDvEQcBcIbLc=
X-Gm-Gg: Acq92OFoi3XK65QK0ph9Y2awNVqIvXbSmcJGdjFOGS1AH3mYbrAtdz7Tq/d9XkIa06k
	BU1ns71VnQe5Hg7xSrNgwXuANE5Mc4Cyqmn70AQgXSo3v1yem82efQ2gU0RSJD8XMdO4ifzLMFw
	Pz/6u5pNc163/i5GlJHf9ffbZZaTGFfds0iPaDaEuGHqpHLCXPh3naVQL31QUSoGE0YFjVMYte+
	/gmc9qqnnEupoB4kcL8hIY1gM3cFR6nYI4hkqu9kE8RgkvnAYxB+1yd3TKh833yoiaIUdAr/mA6
	JzNEc1EDGKaxR0UfqFjHq2okKGCBBlyShkYQUF3fg6JnJviUfZQHikGrbrM1ROQ+MwqIEZYBlFc
	UraYztcNClSaFr+gLXIrbzLO7ic9AnnapAm38fqkeIAZV6dToFpOHPbGomndqgRJ5PyxsOz56W+
	Mfr0l3KUwq1B9o3xrK04ndvV4WSBIqZmwQ1rTrfaOUW29PfNeO/yHWA0tvSotdd7pFiPp+bfNzw
	jLDsWqt
X-Received: by 2002:a17:906:7945:b0:ba6:8f34:b419 with SMTP id a640c23a62f3a-bd3dfc6cea8mr443057266b.13.1778755633367;
        Thu, 14 May 2026 03:47:13 -0700 (PDT)
Received: from cloudflare.com (79.184.84.124.ipv4.supernova.orange.pl. [79.184.84.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c3150dsm75244066b.24.2026.05.14.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:47:13 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 14 May 2026 12:47:09 +0200
Subject: [PATCH net v2] net: Clear skb metadata in LWT BPF xmit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIACyoBWoC/z2Nyw6CMBBFf8XM2jGAD9CV/2FYDNOpNBZK2goaw
 r9bMXF5X+fOEMQbCXDZzOBlNMG4PoliuwFuqb8LGpU0FFlxyg5Fhc2g0U4RlXcDhkeDnURSFAn
 PlDeKpcyOJJD2gxdtXiv7Br1EqJPZmhCdf69/Y75Gf/RkfkTrmCx+e5T+tXcdBvYUucUxxxwrX
 TKdm31ZsVzZuqfSlrzs2HVQL8vyAbhq4IDVAAAA
X-Change-ID: 20260428-bpf-lwt-drop-skb-metadata-9a1bdce705ae
To: Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6517F540992
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-287917-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,cloudflare.com:mid,cloudflare.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

skb metadata is meant for passing information between XDP and TC.
LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.

However, LWT_XMIT programs can call helpers that move packet data.
One such helper is bpf_skb_change_head(), which uses skb_data_move() to
move both packet data and metadata after skb_push(). skb_data_move()
expects metadata to sit immediately before skb->data. This is the layout
that commit 8989d328dfe7 ("net: Helper to move packet data and metadata
after skb_push/pull") preserves for TC(X) programs when skb_push() or
skb_pull() moves packet data.

The IP output path can run LWT xmit before neighbour output has built the
outgoing L2 header. For forwarded, or otherwise RX-originated, packets
skb->data points at the network header while skb_mac_header() can still
point at the old L2 header. If such an skb still carries XDP metadata,
skb_data_move() sees metadata ending at skb_mac_header(), not immediately
before skb->data, and warns:

  WARNING: CPU: 21 PID: 454557 at include/linux/skbuff.h:4609 skb_data_move+0x47/0x90
  CPU: 21 UID: 0 PID: 454557 Comm: napi/iconduit-g Tainted: G           O        6.18.21 #1
  RIP: 0010:skb_data_move+0x47/0x90
  Call Trace:
   <IRQ>
   bpf_skb_change_head+0xe6/0x1a0
   bpf_prog_...+0x213/0x2e3
   run_lwt_bpf.isra.0+0x1d3/0x360
   bpf_xmit+0x46/0xe0
   lwtunnel_xmit+0xa1/0xf0
   ip_finish_output2+0x1e7/0x5e0
   ip_output+0x63/0x100
   __netif_receive_skb_one_core+0x85/0xa0
   process_backlog+0x9c/0x150
   __napi_poll+0x2b/0x190
   net_rx_action+0x40b/0x7f0
   handle_softirqs+0xd2/0x270
   do_softirq+0x3f/0x60
   </IRQ>

Drop skb metadata in the LWT BPF xmit path, just before invoking the
program. Doing it late, rather than in ip[6]_finish_output2(), preserves
metadata for tc egress on the outgoing device when no LWT BPF program is
attached - the only scenario where carrying tc-layer metadata through the
IP output path could be meaningful. Non-BPF LWT encap types do not run
helpers that touch metadata, so the BPF xmit op is the only site that needs
the clear.

Fixes: 8989d328dfe7 ("net: Helper to move packet data and metadata after skb_push/pull")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Clear metadata in bpf_xmit to allow access from tc(x) egress (Daniel)
- Add WARNING snippet to the description
- Link to v1: https://lore.kernel.org/r/20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com
---
 net/core/lwt_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index f71ef82a5f3d..d26cb9bb8189 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -284,6 +284,11 @@ static int bpf_xmit(struct sk_buff *skb)
 		__be16 proto = skb->protocol;
 		int ret;
 
+		/* LWT BPF programs cannot access skb metadata but can corrupt
+		 * it with helpers that operate on skb headroom. Drop it.
+		 */
+		skb_metadata_clear(skb);
+
 		ret = run_lwt_bpf(skb, &bpf->xmit, dst, CAN_REDIRECT);
 		switch (ret) {
 		case BPF_OK:




