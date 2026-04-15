Return-Path: <netdev+bounces-278712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPeFC95M32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:31:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2B401FDE
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AA4730676A4
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783653CF669;
	Wed, 15 Apr 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyHXiCg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5C3A3E78
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241704; cv=none; b=cZ3zEV40hQsrqhaRG0YKXzm7Qh5FD3Gv6VdVP1x+5Gx0o7VA7Zbc85axFQD56IP4+YOJEZVtFqS0n5edAVFXSb0R6zqz8Sn3BK4xF3lNJhoLON4ojsUcn5ja7HwqqT242p0Ry69Rcis9GlWMhkpS2aBAGMvyY26tE+evUs/QI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241704; c=relaxed/simple;
	bh=9fU7EhCw/bsyzLgVuRnp1UTHLjdH4tz74eyq3t/3PUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzKCFWPLU54cXPlAZAVsm9PLweKWP3YfgoZq/7LuOdzJnIsRwMGXGT9wWLk4kShXQxt4jpeInh8fDZnn5IBm5rVWFa+UJM42mRSYruGmVBVW89E8JiMCqH4fAqtzoZh/viSc5DRXH7g4X5QH0Lq4d7ZjvhV5Iz/MvGGH62nnvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyHXiCg7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad9516a653so32719395ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241703; x=1776846503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clm0Pa1JF3el2FcpxvnKLy4LJkpIBZEl1lkmZ7vr5Y0=;
        b=YyHXiCg7hcg9NHOWv501H3Q0Pt/atqEsP9DciHxoxsK5B+Pw1nNOZoQYSzfcXSFmsy
         SAe2IiUjSNJlBoJm9t2SAqmCxA8DKozwg+zLBUNWAgbksx6EznTFu5hLGeeL21JjNIS+
         FO8+p2ZCbHPApSQTxcrIASsex+s+Y4g1gu/FduPi8YCpQnFBwXdG+meQVr2ikjAzfcp0
         UP/JcYtI6JHRaRBTb2ZTJaEk/ZDmNAp2bq0vz1kDD1iqOCQYT8GWbIeaCZV+qfk8ae1t
         EP9wBHcVcPXlt/XlN/7j1P1vlz4eQ6RFdPuf83ZMGHX1F1rFuXOUOeXc1LpuDR29cK+1
         QHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241703; x=1776846503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=clm0Pa1JF3el2FcpxvnKLy4LJkpIBZEl1lkmZ7vr5Y0=;
        b=PzZG4e8l32SkVIlbc1+TMHSEeN6eZlq5Ed7sssLdRbEasgjbfKmMdoEgOsBwBqllEI
         mmyPyEnNFuY3wOnVYzq1BNFExKd4E4RiJJy5YcIRtqEbDnC9VpFrGK4Wp0gJl8kJzxvJ
         w1avEc6zNOHYe3b8VM83ShOFh4/aXUh+Ye2oSu/Jlsx24QkbJ9EwcSPIUh/fXGiHoWR8
         Fv6z5pHHZsVwGVxbFKU/nwNfzTUu15HPd8TRtlUAjBgomVKaZQLMDhp61ZuknxaF4/h9
         LBDf8sAVK5nlhvSZm7Emyt2jMkkaiVniyAhvnByjaPVloIPbloDz0uwTR0LoHm1/EobW
         7iRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Y9aPr+zbAsh3NLxZGUMiRicxx1257l5mQBD7EbhCr0SDjhiOrht8rdNfYJwGcFsBMtypedd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc99GjVvWobhuSIzJ4tK0XgW1yZbya2b1d74n+lX0FoWBEMBL5
	yb7OKwH3TjoVh3NCoagbrRon9ffwN+6VWqYN3bzGRPERx4WWTFvQz/NV
X-Gm-Gg: AeBDiesLXHonhu+1lBpAZsGYuZvS3ZwcNhmjZTD3gD7+2LCmI2OJtCIWmsPZ+iVAnVW
	v+HbzlJF+3UVM7NbtsCknXb4ZKj0ZTAPnO8kIRndcaIeHCCPpdIme5svS0XeexSb8Lxm6mX4OMv
	fKbT88IcA+WZd6BcFIS6eW34Gd9NTXwWv+TC5fLEMYSWnRTcPViyMGdiKr3PeLMw6M7r/m0X4Wo
	DAzLhl+/fngxK20qHhtGP+rqOQ0VpKckC9rH90kO2ASoqrvoTjg9X819WPWFCSYgpsoGKY/Cfdj
	ZCYkNqXvmA3poKr4gUf4UG30XmZp79wZmq0thDnI9VM2nXHXetxb4qQqKF5J4d6MtYUefmDRq0R
	Yrt2o2K3oDnehkGq2dmwogQH8tE3RwqzbCceChQ3+X4VpiZThIBLZ20qfqO5QoXp6t8dc67c1PB
	CPIadNi9J73ciimaCxKX3ljTmKSAX7RCnpNaLhX/R+ssDnrcNP86/wHOYEr4J4U8x6JcBVDcsKP
	WdDNp2f
X-Received: by 2002:a17:903:2f45:b0:2b2:ebed:7af8 with SMTP id d9443c01a7336-2b2ebed7ebamr135992625ad.1.1776241702626;
        Wed, 15 Apr 2026 01:28:22 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:21 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 12/14] xsk: separate read-mostly and write-heavy fields in xsk_buff_pool
Date: Wed, 15 Apr 2026 16:26:52 +0800
Message-Id: <20260415082654.21026-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278712-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9FB2B401FDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

perf c2c profiling of the AF_XDP generic-copy batch TX path reveals
that ~45% of all cache-line contention (HITM) comes from a single
cacheline inside struct xsk_buff_pool.

The sendmsg CPU reads pool geometry fields (addrs, chunk_size,
headroom, tx_metadata_len, etc.) in the validate and build hot
path, while the NAPI TX-completion CPU writes cq_prod_lock (via
xsk_destruct_skb -> xsk_cq_submit_addr_locked) and
cached_need_wakeup (via xsk_set/clear_tx_need_wakeup) on the same
cacheline—classic false sharing.

This adds one extra cacheline (64 bytes) to the per-pool allocation
but eliminates cross-CPU false sharing between the TX sendmsg and
TX completion paths.

This reorganization improves overall performance by 5-6%, which can
be captured by xdpsock.

After this, the only one hotpot is 6% refcount process, which has
already been batched to minimize the impact in the series.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xsk_buff_pool.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index ccb3b350001f..b1b11e3aa273 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -73,23 +73,27 @@ struct xsk_buff_pool {
 	u64 addrs_cnt;
 	u32 free_list_cnt;
 	u32 dma_pages_cnt;
-	u32 free_heads_cnt;
+
+	/* Read-mostly fields */
 	u32 headroom;
 	u32 chunk_size;
 	u32 chunk_shift;
 	u32 frame_len;
 	u32 xdp_zc_max_segs;
 	u8 tx_metadata_len; /* inherited from umem */
-	u8 cached_need_wakeup;
 	bool uses_need_wakeup;
 	bool unaligned;
 	bool tx_sw_csum;
 	void *addrs;
+
+	/* Write-heavy fields */
 	/* Mutual exclusion of the completion ring in the SKB mode.
 	 * Protect: NAPI TX thread and sendmsg error paths in the SKB
 	 * destructor callback.
 	 */
-	spinlock_t cq_prod_lock;
+	spinlock_t cq_prod_lock ____cacheline_aligned_in_smp;
+	u8 cached_need_wakeup;
+	u32 free_heads_cnt;
 	struct xdp_buff_xsk *free_heads[];
 };
 
-- 
2.41.3


