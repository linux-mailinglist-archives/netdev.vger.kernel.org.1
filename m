Return-Path: <netdev+bounces-280939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB4JJ+8B62laHQAAu9opvQ
	(envelope-from <netdev+bounces-280939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:38:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D00459F0F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35537300DF73
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB0E344040;
	Fri, 24 Apr 2026 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9CRg717"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0992DB7BA
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009112; cv=none; b=M4tauL5oYw3cH7E7gF+h4dbcRAcUWCiBvqQjZ1cHWRl4AEdeTQxcT8KvdG+Ha6fWb2yiAhDTKv4qoCetoks5Uzco6kZ/ySH63IZE2n3mFPJl2v/BFgSYoJK9N/hCcgHQy+/5VuVujuBuSb+LneSZqQqCwv0zIeTP0beh0U/beZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009112; c=relaxed/simple;
	bh=fctOOu8ihanad4KwnadnhQVcL0yq7+8B+O+aK7WYNr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DRXtx/Jm0eCfGkURthDghj2+NQnANyi8QIieaNJIqRTzD2ES/tfXe8gUNppH5lzkqrZI/3MabxNeXnTw/BHj+6xvMkGJSW3YpGtXHjp6L0JzpB6Lvu5cSHn7QpCmq6a5m26WjW2HHlOkJI5qLT78BelxAAWmP2oCW/Oxf2ptgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9CRg717; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b458ca2296so47566675ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009111; x=1777613911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=Q9CRg717t7I19+981t/+Nqu1X1tYncjidgdVL6rRcdCjg7iz+MhYt84VgWyHZo+H9W
         xifiwBM8yHMaksoth/4TeDOwCkZ/fzdzygN5U2v5j6kxyyHANcoLyEhzcY7+mZXgCL/w
         kcgK3nP/YNBFULoVvQZ4MjscUTzdfgzhi1+U8puQCCJlXROup2IEHAaEY+C59+DL0I3p
         lsRVwtzaSLdxNwBnDzcsDu9qojE/So7X8CcbTEihbVOoDUl9ESK+fIncfbmBz+PP0men
         k+U5WjMtejKqMwBAuGEbnoGaqg/FgQ43Nyf0mPcJN9ILMR79by3OCoNvDEkEvLLnmJBV
         o2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009111; x=1777613911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i0ej40ghKn8TLZMMNc2ToDzMeEQCp4B7994Wm2iXNOY=;
        b=QNCDTHDIj5HZqubvTiMkINcvcmuh5ZSH5stdCfmhEpxRkYMR/TeIyBzy//Qul3RrsN
         dPwSBt9xPzCXAZhtX/1iZVdb6RFop9iV3IZO3Ds7Px65Wwt5VbOSSdTf0x98IWgSgEpy
         PYGuPAnkhCms6EGTegurHQTaXIcal4rCXcbGPVxcZ1aSrpwoZaSpbR8nrYrS8EGpQb6Z
         HX+nPKonIio72UWYTrHo6Ghjh7uOtLEgpDWjBUDZee6QXAHpNdxSag9mlI3AnOc5EY9j
         op+lh+WN+akJKfJdaWP3XheMKpZzcFksCVnePVmSH9mQFBv7boz/EmM0TTGPIZzGeJk5
         duzw==
X-Forwarded-Encrypted: i=1; AFNElJ8YL1XAhVLXBOMB9+LHoB2KmP1+gaT3Y2ydk7r8DHomxln8r6ExBliM4ZuYAI9jFHgyoxLkvfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBtn7fP+0WVmBHMyxVdDKeaUTlgKoHXu9ePMwre17AFyMLmf+
	3hzajmxfBvXqASHhqACvUFW7hu0LdpdsbgQ3IKges63cKEOIqCDgtImg
X-Gm-Gg: AeBDies81T4iAFnNb5YqaKhJRoxwYWTJ9DoEaALbZYNGPGPQYoLI1HLgrA/ZPMPyyhu
	IGx2ZZUUdgz8rnV+Nyt69aoL8pgB4nPHUpmVon0CAgJ9cxG4H7sp/gp7j1L7VHpeKcoW5lDhq2R
	8hv6X00ZL5OAhNIEiaDXf/DA1X0+XozzISYa35IKi/GpWuSNXfOj5Yjyfz+lr9ZqfpMCRGoHH7A
	6NlM2GXxKrhqUBq9DIz4X/9qvZXw050vQTUB6elMzuJ5dCa5bcFMwv1UvD4KIoUZoDpK/zBejL7
	8GMw+z+nzeHjzCQQil4haYrRQjV+QZn/J0SLIHp5kF7j+hMGPE9Z9ZorqXOyR9MopTq+n1x6LTI
	NxHxh6k9sKkm12lij2gdZA7PZGgC4GsVPykPjajb0sdlJzm4VAoFKPUWV1pSRDJD2G5J3hcpS/p
	410orQG64X6dZcb0TPNNYSV7pBCsoZ8cjisqY6uCQcygXqg2kWiWNxRk25utLXO76PeA7Q3Q/e/
	HTR3AqITsOXOrC9nsLEDD1ILgUW78VtngSn6KYo
X-Received: by 2002:a17:902:f645:b0:2b4:5ff5:e51a with SMTP id d9443c01a7336-2b5f9f51abcmr301815925ad.19.1777009110586;
        Thu, 23 Apr 2026 22:38:30 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:29 -0700 (PDT)
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
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
Date: Fri, 24 Apr 2026 13:38:09 +0800
Message-Id: <20260424053816.27965-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00D00459F0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280939-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

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


