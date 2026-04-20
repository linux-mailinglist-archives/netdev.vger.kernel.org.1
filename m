Return-Path: <netdev+bounces-279683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ARsN/Lk5WkupAEAu9opvQ
	(envelope-from <netdev+bounces-279683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:33:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09B42832D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F3B300D447
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1047388E4B;
	Mon, 20 Apr 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI4qao6R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F538839C
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673703; cv=none; b=WrUblwdIYwP393BZGfaTdw6mSBBz2A/3G080+pKacj4e/WL8KPAz98BO4zOsm7oEkxrPR7y76k2+gXz06MpVSJmldxrmNKXqWoDDW4NdLoJJOHXPQB2MsomxkkW9QO1xTVxwo3JfoMI56wL+IXKS8iEfEGLYU909vP0uLRJKQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673703; c=relaxed/simple;
	bh=M4+77cOcU68W9THBSjVg8Xbcol4HAaJurQC7Ojwff/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcN8jaPPYcpMnFWdJWT8IddG/gE8wlHHkfixYVohX75IuqzZK82Kfs1wcw91DiZRP6ZmroTcvrCeivz7Qkd4Nteu3jVffd9+oajvzTmH/PuBoGKiXANKhuHKGQwNC9mmRoPidXJOK9E0NPFsp0YnYgOTrPY9EWIO+M/UPEc0HgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI4qao6R; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1724360a12.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673702; x=1777278502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5eoEKPMkgwA6eleJzc6ZMHbLGT+Vc5FYW2VP2CKDVk=;
        b=kI4qao6RuCvFlgAFnbZcP2xRyvEZWpCy172pXAjRLeXzSHYH8v7xU4cuwy8uJuoQ9Y
         CRA/bKYfvGvsL0Te6dralKu/WeunTn59NfGU4FsEfuDiIC/6CO4FPHQaf64FGupuSfjz
         nBhCGr/CpkMngVhD69ceDbq7bURS1SMHRlLh6hWT1ppNbXBQQRBCfClrmSNfoTB06zkW
         1yfnz8+P8Rw47GyphpjsEqXC4o3ipnmNfovu5sIbz14aYHqL7ChxLfFkx8G329aooqmE
         Uw7vnfed5j2zJwMy7tJ2sPKqZlvggHXFmguHz+yjBvTKLAj9D1q8W85I2q6KbztT6Jrj
         WYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673702; x=1777278502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5eoEKPMkgwA6eleJzc6ZMHbLGT+Vc5FYW2VP2CKDVk=;
        b=cdL03zDW9j2b6vqIAjQXa0wM6HAy/9JZcsnz/wkePuO+dOqPRSJR2RYpf1NugakcTa
         nmJ1KtrnsguWF2D38pqzSWz6bDHZVcxXQBpQS2ufnTFDRAJ8UyXpy3vNKPzTJhpuZHUr
         bPQOnZqa6oRIHlx7IjuAYb0NxOGMQj66IzY747WqRPOGJD5HJCXFrmdCtXxybXCHZfYN
         DFnv0+Q8zwFjtVDm1I2K4tFyxvpTWjxaj+NUH0Htf7ESmUoAWUt6UQ7sIYoLr0fcW5Vv
         kwMD1QSp/o+otUYT58mb+KnTpmGRlHY6uq+EMbOMJunzWfZvlFUdSn9ILAiC+OtwB+Nc
         Vuig==
X-Forwarded-Encrypted: i=1; AFNElJ+HxRZsbbiFiXGQkFwfKYA9HqXiwKVfGGogjocVo2le2upay1MVQnht8YCeGZK+Rc9XCmTARcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpUpvCimKtyAiitGqgvHklu5UGdsO4x8HJbqckZL87oGl3f4U
	Hjs9l4taHz2YyVhQTPnNL+3sIy/mSPLtiDeOLc0rTKmvQAPX2XL9fvb1
X-Gm-Gg: AeBDietDsTV8knDWsynvtXM/L/69aquzGyIYG/SAoAVEpmCOOqOtEPHqnq0/vn/fMRd
	r0e9UWSV6WDQkTbpFz49OLww/uCJT55qRboZ/EkLw9sGSdEWAvs6ckfwiI50i4SEO0yMoA2TfmL
	vcH5mTl3f5GtEFnvTLJCgNJ0btfum8xWXvT0bPKY5DAizmeRGznKs+LmYAFyngrTlF+qpKkPvsj
	PE10OGDj2J0ixNpEK8+yr7vLyLAj3dszefRtODH/TESaYN4hhLPq+Zjzu91muDaPbP9cuopPxej
	6DpOSWUd9FTbQelkUVsBeIX5BbvmP9I9C8tidAIUT7kRc8PyxD8k19a/wmh6x4LCcx7M7hFEvtC
	ALVKdG6vw5KTxdB4B0qp+EMYe/jY54FAmev0aDQ5/MJk65EFPw2ulVJRvpPvGp66Xx+EHjXVPOY
	9GvjnU2uiwOUqpYlcD6lohPGzeftWfjltM7QNSEcF2D5RbSCeDJWSUao8cDerrzwrhMn3xc5pKA
	kThZ3FXaUDZZ/rsNzg=
X-Received: by 2002:a05:6a20:7d9e:b0:366:2447:6778 with SMTP id adf61e73a8af0-3a08d93e320mr13740453637.53.1776673701880;
        Mon, 20 Apr 2026 01:28:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:20 -0700 (PDT)
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
Subject: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
Date: Mon, 20 Apr 2026 16:27:58 +0800
Message-Id: <20260420082805.14844-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-279683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 5B09B42832D
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


