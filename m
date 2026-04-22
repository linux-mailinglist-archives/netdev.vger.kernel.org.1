Return-Path: <netdev+bounces-280298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ7vBpRC6GnHHwIAu9opvQ
	(envelope-from <netdev+bounces-280298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9C441D18
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 073C83042408
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF863A16B1;
	Wed, 22 Apr 2026 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpV0pEeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E03A3E8D
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829025; cv=none; b=FWIky+ifz0KliHZ85nMQjZwJ3SCup4lKlamREzOROlrftjvh6tsicibp2qI6EOF3GPj1/JywLl8/BDGQBWn/9dFXo9x3VQw9UGE3vzwSkViyBFxXkfYpIGRhC52xCz+B6XdWAnAku8nWFYk1OJtkCOaI8mGa6YfdQpTz0IB7/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829025; c=relaxed/simple;
	bh=fctOOu8ihanad4KwnadnhQVcL0yq7+8B+O+aK7WYNr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+1+XJ4971+CJMI9MsU3tlwtion3LpNtSpHNH8//pYnNjvlm8KsqyM22URvYwI0vn5VT/KLs8126/MZ5WnTRaitSJMepyKnQ7F4sfhWGnrg5r3rq5sw50Lptjp/PfH+CCz8bdAp53BYQ/NCXE1/yyGoiSROFN3Ss4diMTNmiJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpV0pEeJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso3298429b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829023; x=1777433823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=LpV0pEeJW0DVwm6MxxOV7xIODT4a70EIBCvv824fRO9GDA727BrucJvsfRa3ub8Zs1
         +fl3ltKKRymBkBbej8jg8oVjWbjlFkAQty01TMJrV0Qxs+g4ZcvM0stgPn1DdNtcS2Jf
         gndnC8EKWMvaiGa19wJOYLl0lDXM69LpVJh8G3my072ePVM1HBgfaHLveLN+KX6LkRWU
         CXvps305HKYr842GxnLbU5e7/LGPqiQuVQsE4f7FWC+BVF1VRG061Fkmwe3q5fXyj24d
         acyUS0KoDVYIc23gtmydSRtGEbcBTJGxkGw/AJCCgqx8BgnfnzEHMIRuSl+EbQv+jY2s
         3tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829023; x=1777433823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=fxjyfCVX6+wGV4NqJekZ/bsXE9XG1anBRdr5J8J8gWaLse3omOxzA8kYKjA1wf/bzm
         KqvFSuaVnTN2x/DkCJk5AifVACDGlXm11oS/5bgoZDpbSmlj1AvlkaE4TnUvWe5e5mJi
         AQpi20/KkXNYO+IGlKk2B1frR7h1o3xP+3kDEGCopwiOIoKyN1pAi3pEloHFFqUGb0CF
         hQwXs5lXBrQ1zJzN7QXqPmwAplOeke93TZwcFkr2B26NOL5kyWTXk4SQPMQCofaRH+Jx
         6uLiWjxvh1A3CUeSveWYutbBShQ6ubqjSyb5N838ovWoyN9eYZ6xBS2ho2oHMPL4wuPB
         kIYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xAoevsBPIz6xm4a3ncCt4j49tVLHRMIBxHlkv75dK5lO2eSAvgYFZuQRYmZbZP/RIJ4pleiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rjAVjpYSJUOq0RQ0drrpyWo7XJWH6R/KPW+2V9hT4GMokJud
	ZAfsyElGR7VrANcLeDlkXJZo/Rkn1Hn2bVDQGzmmWcEcHTLuwLAX7uXQ
X-Gm-Gg: AeBDievaYOKJuwtG3CltYYMKa4AU0Vb7Er7YPipx+TOrV/1xirH55J7CipI76r+vHoO
	XU63CzlXBzZwFaB0MlOHZiYo+Tn2bsf+89SmleZsNrbg3qSj1CdbJtHYWi+Cx4BnDHaG9RXiRaO
	AcBgyfLK06CdnlmSePIVYZDEUBFCEQQLJ6h5zg0rXSNXFWZqgdvQDxvINsYH1WF/iau3s0Qu4Ar
	mFJ7r+rwqLO7qflHOEp6eEeuOdiSBG9FsUSTzbHVUZKGegBs86us9xla4oHOzQG2KH3mp4jIEWq
	i4TpgBLeuCpOHjwNXMt2ri4RVzDY1W0bFv0HVmkJVz6XbZKwBR/704s9ZTNjpfxP8J1BKn4CGN8
	j3VZZQ8bEQo6IcAKc6iScGyLNROFcWZYBo1rOfoSJqjVx6p+ctF6X36efYRywjxKad8dPmw1hR+
	9u2EfA8qY15yCyBcKJe3sbSSC/fjeJ2ZIRAFVhsy4WFxz9muGj/Dh+NnwrmvyuWM5SJ2NdehgSf
	ZnSD6ph
X-Received: by 2002:a05:6a00:4502:b0:82c:70a8:faee with SMTP id d2e1a72fcca58-82f8c830903mr20784475b3a.6.1776829023119;
        Tue, 21 Apr 2026 20:37:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:02 -0700 (PDT)
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
Subject: [PATCH net v3 1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
Date: Wed, 22 Apr 2026 11:36:43 +0800
Message-Id: <20260422033650.68457-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-280298-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 89D9C441D18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

skb_checksum_help() is a common helper that writes the folded
16-bit checksum back via skb->data + csum_start + csum_offset,
i.e. it relies on the skb's linear head and fails (with WARN_ONCE
and -EINVAL) when skb_headlen() is 0.

AF_XDP generic xmit takes two very different paths depending on the
netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
skip the "copy payload into a linear head" step on purpose as a
performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
pages as frags and never calls skb_put(), so skb_headlen() stays 0
for the whole skb. For these skbs there is simply no linear area for
skb_checksum_help() to write the csum into - the sw-csum fallback is
structurally inapplicable.

The patch tries to catch this and reject the combination with error at
setup time. Rejecting at bind() converts this silent per-packet failure
into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
because they do not call skb_checksum_help().

Without the patch, every descriptor carrying 'XDP_TX_METADATA |
XDP_TXMD_FLAGS_CHECKSUM' produces:
1) a WARN_ONCE "offset (N) >= skb_headlen() (0)" from skb_checksum_help(),
2) sendmsg() returning -EINVAL without consuming the descriptor
   (invalid_descs is not incremented),
3) a wedged TX ring: __xsk_generic_xmit() does not advance the
    consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
    the same descriptor and re-hits the same WARN until the socket
    is closed.

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_buff_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 37b7a68b89b3..c2521b6547e3 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (force_zc && force_copy)
 		return -EINVAL;
 
+	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
+		return -EOPNOTSUPP;
+
 	if (xsk_get_pool_from_qid(netdev, queue_id))
 		return -EBUSY;
 
-- 
2.41.3


