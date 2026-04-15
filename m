Return-Path: <netdev+bounces-278701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM2fGOhL32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:27:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C6401EFA
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAD0C3041D66
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2003CE4A0;
	Wed, 15 Apr 2026 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i32lwl+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB9391E44
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241636; cv=none; b=vFplQ8SsCKx0j8cptSLgRSwo2q1ySk2UjTkrTtH7dUWxarRiJJHxN3Azdv/4JCV/+PQ6Cc2QbWB1ZmETZlijZ4khaeEOtZ1alneF85XUwkOqToSCe82txijgscTTFLlzz7DEZzWAQfLakX7AAocuHqQW3kkYbs53K7b9CBdf3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241636; c=relaxed/simple;
	bh=+m/WLK9X5plutyFPjpd3AQb1360KbNZd5kcMYtPDi+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnT5MEWQaW2cO8yqmsbIsS3uoqmNMIaj+3Oa/qyzSnSjXPD0IDm0vCp4bOi6GHudsB9+5/fKtk6ie947xmar1xZrFD/h9cBvgWMFxrXC+Gl5y+Hsn9vKMC3WG4UTGaUuVzgrhehKBCJjrUAAvWRMidRWj1zAW/JlZH8n3xvuZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i32lwl+f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad4d639db3so33798145ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241635; x=1776846435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ16P9ql425c7rop6LMTVQazhXI3kn8UEVCSS+AQW4A=;
        b=i32lwl+foT3R6hVy5eOMhRm0dr6YZpghTxdfJ7d8j4NnW4YL5mLTCB6uii96EWCSEC
         soJzZCTY7AP9HoXoPWiVMVaI+xXozpvcT8/sWhVT0zlcM44LrIpyMHlnBkAIwkcHyn3z
         fNdSWF1/XLfiChYw9g91ELU3nz1g+nSwTIllyPiJX0VQ+V0RqruXab2JtWhEoAjTZBzI
         ZTg5JVJqYd1XcrdE4AWShEWl2dAFmAQ3SB5gCVXODm3BLTcxiTLZLIDIs9fFov3k5gfZ
         IbbPvoRPHeHw1mIbE8DqIsQrdvC/KMwav/b3PlTuP5gkfNWBT9dRuW25POZLlDKT4CsH
         TDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241635; x=1776846435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJ16P9ql425c7rop6LMTVQazhXI3kn8UEVCSS+AQW4A=;
        b=nQmshP/590mL3TM3+xHV8A7h7vCHS4g0jidR06d21pMlYhImERgYjZx+ROS4soiqI4
         9+hekHqbBNiEn60taw2tqdY8m9PKYyBEi5yy4Q0CZBGIB9Pi/+/CyXz5sJWIbHo1c1C2
         KSdQJ++aNrBQjaYjWk5urdoEjQ84Rd0reNFcxOYjGfaJGgRLJBxJU2OCji1oykVRd7w/
         TDO5yqJiJ4OYfkg3n0qbmZJMVtRIaCUsaagTqS33ObDBwpbInrSJIO9cL+pvEpxp4a3g
         t5GZhFr0P3qbTK24UqOBNFfk2mh9tTGmK8i4dKvuYmt/tzRdX8SPzmf5OoiQB66vgask
         1MDw==
X-Forwarded-Encrypted: i=1; AFNElJ9tSjeAwMOom26CBaAXskg2YTKBKmTbs1rTeesDvnBJMy0XAJn3y4lQyxwrv+azJrlOMjFNXZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9p8tDbOmfIq1yAYO75FAzDHaCSFlS97ZFIcJZqkr6fp8eE3i/
	AxKgtNsKHrzTtAUKeXoy1e9UEDF2/dLw+e0Hp8gCwTcCOC0uz1I4M/Aa
X-Gm-Gg: AeBDieucnIVtPxT5JJdeb7io8me6UIWs7pfx/ltvDEvo5OfyKoIRMxhLim2fLECAD9q
	DTGReHasMeck29BtJ/kG4FUWMmwWLUhlC+Ruc5OYVra5hzr5sspFwsngILRvZBLTQ77eaMD9v6p
	M3NfZuPMuo3h7sTMylRk9vjM7TyW+6vtLivcHJmoL7GQs/v4jrSQmImKpxPjAswwBBRKo5z3bEg
	7HWd8gBS4BKaV2NIdv3YUh3BleyWyMS3zV6hs8ffeTnFRbhWQT3oWBBjh3OQMximWd43uWuJaxp
	R7W8IHBVyPUuTdRA4mrVjEC7x8IPaqrHeuZNHFlc5ibG/0Lf6F6Cs0mcIL+pMMSbbh4f97NPZqj
	Dmf0Elm7HUFOjAArXSVs+J20phN9VFF3cz6CKQOS5gavyupRHHKrRhYgDJ752bAkoGFlWwSEZ3D
	yZYYyYEeIe6JR1WnSIXUEk6u9MP+bztYloET8PEyyHzPSwYdox7jAn85LKP1kJIauR3RX25N43Z
	Ea+WMhY
X-Received: by 2002:a17:902:bd42:b0:2b0:61f8:9f01 with SMTP id d9443c01a7336-2b2d5aa6ed3mr134711005ad.44.1776241634503;
        Wed, 15 Apr 2026 01:27:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:13 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 01/14] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
Date: Wed, 15 Apr 2026 16:26:41 +0800
Message-Id: <20260415082654.21026-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278701-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CF1C6401EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Add a new socket option to provide an alternative to achieve a higher
overall throughput with the rest of series applied. As the corresponding
documentataion I added says, it might increase the latency because the
heavy allocation cannot be avoided especially when the shortage of
memory occurs. So this patch don't turn this feature as default.

Add generic_xmit_batch to tertermine how many descriptors are handled
at one time. It shouldn't be larger than max_tx_budget or smaller than
one that is the default value (disabling batch mode).

Introduce skb_cache when setting setsockopt with xs->mutex protection to
store newly allocated skbs at one time.

Introduce desc_cache to temporarily cache what descriptors the xsk is
about to send each round.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 Documentation/networking/af_xdp.rst | 17 +++++++++++
 include/net/xdp_sock.h              |  7 +++++
 include/uapi/linux/if_xdp.h         |  1 +
 net/xdp/xsk.c                       | 47 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/if_xdp.h   |  1 +
 5 files changed, 73 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 50d92084a49c..7a8d219efe71 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -447,6 +447,23 @@ mode to allow application to tune the per-socket maximum iteration for
 better throughput and less frequency of send syscall.
 Allowed range is [32, xs->tx->nentries].
 
+XDP_GENERIC_XMIT_BATCH
+----------------------
+
+It provides an option that allows application to use batch xmit in the copy
+mode. Batch process tries to allocate a certain number skbs through bulk
+mechanism first and then initialize them and finally send them out at one
+time.
+It applies efficient bulk allocation/deallocation function, avoid frequently
+grabbing/releasing a few locks (like cache lock and queue lock), minimizing
+triggering IRQs from the driver side, which generally gain the overall
+performance improvement as observed by xdpsock benchmark.
+Potential side effect is that it might increase the latency of per packet
+due to memory allocation that is unavoidable and time-consuming.
+Setting a relatively large value of batch size could benifit for scenarios
+like bulk transmission. The maximum value shouldn't be larger than
+xs->max_tx_budget.
+
 XDP_STATISTICS getsockopt
 -------------------------
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 23e8861e8b25..965cab9a0465 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -45,6 +45,12 @@ struct xsk_map {
 	struct xdp_sock __rcu *xsk_map[];
 };
 
+struct xsk_batch {
+	u32 generic_xmit_batch;
+	struct sk_buff **skb_cache;
+	struct xdp_desc *desc_cache;
+};
+
 struct xdp_sock {
 	/* struct sock must be the first member of struct xdp_sock */
 	struct sock sk;
@@ -89,6 +95,7 @@ struct xdp_sock {
 	struct mutex mutex;
 	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
 	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
+	struct xsk_batch batch;
 };
 
 /*
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..6122db8606fe 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1218,6 +1218,16 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
 	}
 }
 
+static void xsk_batch_reset(struct xsk_batch *batch, struct sk_buff **skbs,
+			    struct xdp_desc *descs, unsigned int size)
+{
+	kfree(batch->skb_cache);
+	kvfree(batch->desc_cache);
+	batch->skb_cache = skbs;
+	batch->desc_cache = descs;
+	batch->generic_xmit_batch = size;
+}
+
 static int xsk_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -1247,6 +1257,7 @@ static int xsk_release(struct socket *sock)
 	xskq_destroy(xs->tx);
 	xskq_destroy(xs->fq_tmp);
 	xskq_destroy(xs->cq_tmp);
+	xsk_batch_reset(&xs->batch, NULL, NULL, 0);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -1588,6 +1599,42 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		WRITE_ONCE(xs->max_tx_budget, budget);
 		return 0;
 	}
+	case XDP_GENERIC_XMIT_BATCH:
+	{
+		struct xsk_buff_pool *pool = xs->pool;
+		struct xsk_batch *batch = &xs->batch;
+		struct xdp_desc *descs;
+		struct sk_buff **skbs;
+		unsigned int size;
+		int ret = 0;
+
+		if (optlen != sizeof(size))
+			return -EINVAL;
+		if (copy_from_sockptr(&size, optval, sizeof(size)))
+			return -EFAULT;
+		if (size == batch->generic_xmit_batch)
+			return 0;
+		if (!size || size > xs->max_tx_budget || !pool)
+			return -EACCES;
+
+		mutex_lock(&xs->mutex);
+		skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
+		if (!skbs) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
+		if (!descs) {
+			kfree(skbs);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		xsk_batch_reset(batch, skbs, descs, size);
+out:
+		mutex_unlock(&xs->mutex);
+		return ret;
+	}
 	default:
 		break;
 	}
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 23a062781468..44cb72cd328e 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -80,6 +80,7 @@ struct xdp_mmap_offsets {
 #define XDP_STATISTICS			7
 #define XDP_OPTIONS			8
 #define XDP_MAX_TX_SKB_BUDGET		9
+#define XDP_GENERIC_XMIT_BATCH		10
 
 struct xdp_umem_reg {
 	__u64 addr; /* Start of packet data area */
-- 
2.41.3


