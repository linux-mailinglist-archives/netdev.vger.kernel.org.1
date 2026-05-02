Return-Path: <netdev+bounces-283473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHFFKphZ9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:07:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C474B35FF
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C001300D455
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2D388E7A;
	Sat,  2 May 2026 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L99LJwb7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199D38B127
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752454; cv=none; b=AuS0kBN57n/fkhaV9gJpzBlH1V8IZs72Rhqdp+I4n/UnE0tBFtFdG2bZKkwZgelNIgv9R3LCnGQi1T5M3ssByZ8sYIejMM67o7NMPnfgcJ/Ftsa/ELfiv50B/SSIFrm+nvY8eyKCU4/AtVoJeR3LNonJfvF1agTIOOikGCBrLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752454; c=relaxed/simple;
	bh=fctOOu8ihanad4KwnadnhQVcL0yq7+8B+O+aK7WYNr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqVQWjTDUC6Z4+EPC0UUS//aREtEsQT3B7Rl2Q6VvQwGG94NnA1XcvwF/fBhhWV3NQzd1SkGOoN3XaPOuH5C3QdHQ0GvL+O7dmcbvhT0Zk2n5ZevMZ5X7UWcypiHumGLDEQVost2d4lTPf3XzjJfljQXlJNcRIgyRWhy/JiDFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L99LJwb7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so5153528a12.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752451; x=1778357251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=L99LJwb7ghjZyJGAltcmlCigsj1usM68fDPWZpkd3mI5PpuZCKqf9rBZ8Ot0+3xfJV
         Klvb9dBriboTRcFfzlaxtebi/tbyn9sXgKRGvc6wg9rNngLXmfpyQk6y0IRu4Zv6jq0R
         jvoNHa8bgcdVdFNXXa8eYo5mLZYQCvyVeni/bLh3fAjtb0krx4HUyD4+o2pri/RJvgKT
         jefcTC8GiJluLmgVb05QPMPx1RbsFI1NeiQ29MIpVdabAU7D0uAIiYFfRothlyAytDEN
         4LqnnhfutO3FMlgsNRT2O7Yh2bdgt7pvlzWKk69MPkmyO7PCta7AwddDexDRs16bGoYB
         0Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752451; x=1778357251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=QP0GQtKvrzOSnn8dEFX/rFteFvWOqKgQEKy1dhbGkNvIeWleugCtvj+L8fG28NTt2u
         KU1/pTOMtF6zTYG/weOx7pAvC9XIDFz8UfqulvIEzNQAA88gzGp12FXR1WFT1MN80hfU
         qBt5dIY/ut3iXQ0mb/v/Zu4JWoKNWtfkR46A9IMmTp2wL9hA12v/AXaofb8ZeeV1azOl
         V7T6mzFbEZ3zsdoK98K5IIvWrvyZnar+WZT7RbbqyVX0f5pzhQvoi87xnemRtqE9EB8E
         5F7vyL10urAxewpnlYS4M2FFMctxVzvpjheJo7BD7XArTdHGuIfiU2UB7SIWVdyXMPaB
         IahA==
X-Forwarded-Encrypted: i=1; AFNElJ/4BCDEBJ8e6SjAJM9V9A1c6MZN8uBOTvCR7f8uwdZN4VVscQ9D6Lcurgb3MAhcYXmNNhkz7/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wagKkWDykTdk6VqyICL+XW6rkkdrC2iVk0msdrr9We2wUwh0
	QblLTlqvxG8qTeTIDdQWDf/86z1GyZQFWG0ZJ07NLl5KX+Yf56QO+VIP
X-Gm-Gg: AeBDiev/P0rF6tD/z+wiCeOuECo17kyyrVTLf5ocwyovNxdIM4S99EcCA75F+/eyEVa
	nvHCH3wWwXG1yti8bCuiTeFXZD+48DR1miSPrFqQkzm6rBeiRvPYpnQhLHRNYA69tLU4hKgnX55
	c06lxVCt47Z5+qsDsqlSkXLHwqtsPO+AU5lyd0Di63VusQwXXHZPfsV9scFmKeRThsQLrPy31k0
	X8vqVQ7QN2262eLav5BjcKXyoRCrOzMyA/pSCkAvnGD28UxbvBkKhdsKOU0ubhRqa0CBdZ7CnH0
	qkD/1L0vwSr+HipK8UBixW2snPrn7bpBwyUj2x0DRCGo5wv4gWnh4UzS76XyueiFGGFzqUVSWKl
	v6IMJQLkH3kUjaCRWk8NB1aSo4J0KpLembSPc7ccSFejY6Hjfd2RML10BQHlcri7Dp9Lrt13scU
	05S1FrZobf0Mk9QWrwvKqr8oVwcmMVCNZA+99Fp5fAfzE/Zo6V/0/Raa2mIrSva3KXK42AZXKEQ
	TtOypyjWqCKDyK7emMHnMFnO2fZ
X-Received: by 2002:a05:6402:158d:b0:678:f8f4:a7f3 with SMTP id 4fb4d7f45d1cf-67c1620cccemr1505390a12.0.1777752451354;
        Sat, 02 May 2026 13:07:31 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:30 -0700 (PDT)
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
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
Date: Sat,  2 May 2026 23:07:15 +0300
Message-Id: <20260502200722.53960-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19C474B35FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283473-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]

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


