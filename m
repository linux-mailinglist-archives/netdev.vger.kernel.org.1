Return-Path: <netdev+bounces-280942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAnuOOsB62laHQAAu9opvQ
	(envelope-from <netdev+bounces-280942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:38:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF490459F08
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F01B8300382B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098E73446C4;
	Fri, 24 Apr 2026 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFwKF2Aw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023C2DB7BA
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009126; cv=none; b=A1UL0LSPt70XbBIuaIS9VDNoGlbfV5jwxgjRhTNoKkR7LDpyvNy+PaV+N2+sxMvsRBdJ3QTxauyv7BEYcAsmP/2S32pRJFMvxxWrytoS+ebqKL2+m6+q65HcWD2Vaf3t3krmZ0sdI3ZQw//0ulNrNhiv+W/1Lmk1ZQcM/MF6pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009126; c=relaxed/simple;
	bh=fO8jrrKrL3//RQFLKox8KTxmstVGkIWBmewzmec/Pj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qW+mkN2P0eqccb9ddolXqTZzuT7GAreWz1MngM1sTQMvTWMk1QQfRcpvWFyAnZhHv6VJAmITHXJDGdCo75mqPtURvP1o4KgiUuRBF2Z+NJDeK2TPqTTa/Iy8lTX9nV3gk2EP+s4B3czpf6ExUriKV0CIkjufvQlflw5sqL3hi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFwKF2Aw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad4d639db3so37928855ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009125; x=1777613925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DEVP4Wy5pIi1F+YdVvQMkTO7AT88wSCJdPYFga9Kt0=;
        b=EFwKF2Aw1Urvf/b/jjGXFxMfcF+6GOtO/3fBfsS0JjViNE819nc1u7ZrKgMqyVWxwG
         1HxFJT92KKYyaFEmk5sk9zW2XucMUUEv5Rm+w5SBku1TgCOF16yAPS8H3BlKnm7Er1SE
         cl8smqkxi6RFqWABMgPbwDRpnZgmZ46pam4XjUNSpAVhiER7Sx2Bl3unotlm5QH7ulAr
         SGRur0Uk/f947CR6wOM6KnrhUpvYLZutpIz8U22bQXOYeJxYxvCRTXp/MBqknFGU/jgj
         rGYwZvf1T4SL2GnGvxqiaOe0xR/UlzBdkpHHwSsWBxcfAAewy6txY2wkkhLzOFMNFRAv
         nJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009125; x=1777613925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DEVP4Wy5pIi1F+YdVvQMkTO7AT88wSCJdPYFga9Kt0=;
        b=TgbZgy3UGR520yFTqmov8QDm1ftlEdgsxhW1k//qWTPMh1A07BvjKoerVbiiv60M54
         1J6HU4ODsDQFuvECdBV143c60Gty7d2DpyaqDYncNzf0ocxAAh3/NsRMwAGZWpwEjecx
         eBlkDuI/i93O4zI0ohZVdwPJZYnznViPqqUQ5K8VyDFcGwT7n7SAwaa/P0crOdv2D6Dc
         slHatFdNjw/mUDMnJfp/78znELR0By1Y2lXFDW7oPsCdjEpMwrCKjdh8qFAk0KU1UcOc
         LwaqlKK0dZx8U2IyEGvRBi0EMKbvwT6D763uUPGao1vfPeNA5/VwKe2XlxuTpFmY7g4k
         gAhg==
X-Forwarded-Encrypted: i=1; AFNElJ/YY5/SacVbWZ9al2UepvVm1+GP6PpXIXlYY+d4gU6eHoYfJqK9ZcVqM1VPEvcUkAvonXrzEJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwW7B9cYhLAgzvaIKZqRS2nkqjrpmJTrF0ymYj5U+i6oayiphw
	wJN6fqBWPCWRH3ak2tXRxsEWohQBXRacZkhhY731mCfZHc8BBBY5WiqA
X-Gm-Gg: AeBDieu1nEgFZUrj35RGE0y5l3dGn+PdleXSgdiLUxhpX50qRaRSmSI73yrB1mIrhq4
	/sTl9EF3pOU+NSqJYlo7gNvP0lBWLsNIvzTAqU0XmTeU6eeWvoOPHlTJL2xO1q4+fUzddTiyuwC
	M3qOXkbdrF67g7uD85/1e4AI09uok5OhKO5eZ4DQ1XtMLWsG4Mfe3VOlV+6iz7n5bA1FMGYIhyT
	AW1auFXKQS0wgH/gZOaxuHeiQiMVUTzM0wFuuUejZZJZ/VEQzEglZvjg+GcByNrmyH0bzSp7qUw
	j88fk4l4iNJ84Jzn7Wd98GMIH6gdpFVYrlW3Drro3Nrb8QtLhibeBbNDcB1fV3oT0Wh1WVWGKQI
	XTHH7JsjrAPv/Z+xG8VJbS+DkoVmzdwK81q507gqIzotC9Zo+KLBeqBP2mMOnj09XWVSYNSgvT7
	GaNaDWcxQtx4OqzeGavdi9NSkx2uK3SO444Ip0yX+5IZf6usPnbK+5zGa5C3HG0yM3dxXEKZdy5
	6pZAWzLVsXxFrTQ8pZYQ1DeTvKCitJSlmKRadI2
X-Received: by 2002:a17:903:2acb:b0:2ae:450c:951e with SMTP id d9443c01a7336-2b5f9f08968mr321477595ad.17.1777009125221;
        Thu, 23 Apr 2026 22:38:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:44 -0700 (PDT)
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
Subject: [PATCH net v4 4/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
Date: Fri, 24 Apr 2026 13:38:12 +0800
Message-Id: <20260424053816.27965-5-kerneljasonxing@gmail.com>
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
X-Rspamd-Queue-Id: EF490459F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280942-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: Jason Xing <kernelxing@tencent.com>

Once xsk_skb_init_misc() has been called on an skb, its destructor is
set to xsk_destruct_skb(), which submits the descriptor address(es) to
the completion queue and advances the CQ producer. If such an skb is
subsequently freed via kfree_skb() along an error path - before the
skb has ever been handed to the driver - the destructor still runs and
submits a bogus, half-initialized address to the CQ.

Postpone the init phase when we believe the allocation of first frag is
successfully completed. Before this init, skb can be safely freed by
kfree_skb().

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index d23d1b14b8b4..88ec6d2cbbcf 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -739,8 +739,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
-
-		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -834,7 +832,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -884,6 +881,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
+	if (!xs->skb)
+		xsk_skb_init_misc(skb, xs, desc->addr);
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.41.3


