Return-Path: <netdev+bounces-85932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B089CEF9
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 01:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD081F24F48
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE88149DF1;
	Mon,  8 Apr 2024 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="VFX1lHDO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D911146D59
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619132; cv=none; b=aeCzAitVWcrunS0AaoTbEB5Uyer1XqEjyawstAaAaTcEx0cvTnxORTLCiNbofmolUx2xdZCz0L3365Y6+Bz/Qr6dnq449W1Z01oZEyXLdorhR5cSNIUJ2JoM7pldzDt1+9e/ZzfGob8UIL7vxDwHXTLWsdvq6IOk7jkpiJ+jn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619132; c=relaxed/simple;
	bh=bVEIb6e+/B24H+2KosaPTYKZHDeBj1vnRwJgY39tm84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDtlwBzUlX3yDKmDpuaINbEGoaMAUK+HduejYZdUjA8XhlYP0meZuRGDv1NMgTotHLmqH4EdU628Bac4tR6tSp7VLS0jhWaAj01NwlaEy2AQOVIE8U7EXaib1pc/PlPEVdKxMglW7rhlXunC8PA8w5RInKnT/ApXhXXlitsdnr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=VFX1lHDO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso665711b3a.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1712619130; x=1713223930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exMdnTAAmb+Wduf4Gnad0Iboa2uGRYogmdNpnKal3eA=;
        b=VFX1lHDOiQQVzSgAopHWN6pPIPlzmS3V6s5tiWVEOtMJV6VQpjvp75okidtLhR6KN8
         ujAX9rKFtF9j03zNHeQucZpKzpex22/l9V7/LWVs9NWVZJYxJ6NSMgHNMOyKsECEROw6
         mUR7r2ppHb6pEmZpXUYy32+w9P2BWFApX+Npo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712619130; x=1713223930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exMdnTAAmb+Wduf4Gnad0Iboa2uGRYogmdNpnKal3eA=;
        b=p/dsO2XDYYzLGlttE+3fT1RjafG8uBJJtBaSykOajQdyd7he8comDuWXoUHtTdRm+I
         3YbHLfV/Rk1ORd62DlAlU75uj9QBJ09WIOd6EqHEZ2IhVCDe4Gip2VcQPg8Q3sJisrJW
         8+c/HQr1V24TTREkxFPPS6ktzNm+8ST8BZvZfOU7uFG028q776T5eWpAD9Q4JXk8hgP/
         iNkaH5fvNnQc1GdVuob76RkbWdxtF20XoYMfgIi8NgFLiic9xLFAyGA/B4blV5JA9u9z
         iUqb5JxP9qqpq7zpjg/fn553IgB2f1lxVMCK4lkzASRP3j9/TaCRuQYelh9CqU42YvIy
         5fOA==
X-Gm-Message-State: AOJu0YwUhARI8yMgAJoVLc3YioqiS/xoDIfL/JKirfC36AmzmDY1TWsp
	e8NmEdhrrrw1KRUZxWrAtOAt75RQYLeY+6qwawgtL9CaleQ0K1lcBNLR6oq1QUktkRJKGlMMiIf
	i7caWLVJd
X-Google-Smtp-Source: AGHT+IFLeOubTVV/zL+idW19Wk7N/QZ+M7RTkYyLsZ9usATqIisIu03pzt8kKjaqu0XGkjIT1gH8aQ==
X-Received: by 2002:a05:6a00:b4a:b0:6ea:8a2c:96fa with SMTP id p10-20020a056a000b4a00b006ea8a2c96famr10202252pfo.23.1712619129666;
        Mon, 08 Apr 2024 16:32:09 -0700 (PDT)
Received: from localhost ([2607:fb10:7302::3])
        by smtp.gmail.com with UTF8SMTPSA id a14-20020aa78e8e000000b006eadf879a30sm7336815pfr.179.2024.04.08.16.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 16:32:09 -0700 (PDT)
From: Hechao Li <hli@netflix.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Soheil Hassas Yeganeh <soheil@google.com>
Cc: netdev@vger.kernel.org,
	Hechao Li <hli@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH net-next v2] tcp: increase the default TCP scaling ratio
Date: Mon,  8 Apr 2024 16:32:00 -0700
Message-Id: <20240408233200.1701282-1-hli@netflix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iJgr3f23-t2O+cMcyQixNhcTGVVwp3m69J3G28zW4MPkg@mail.gmail.com>
References: <CANn89iJgr3f23-t2O+cMcyQixNhcTGVVwp3m69J3G28zW4MPkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
we noticed an application-level timeout due to reduced throughput.

Before the commit, for a client that sets SO_RCVBUF to 65k, it takes
around 22 seconds to transfer 10M data. After the commit, it takes 40
seconds. Because our application has a 30-second timeout, this
regression broke the application.

The reason that it takes longer to transfer data is that
tp->scaling_ratio is initialized to a value that results in ~0.25 of
rcvbuf. In our case, SO_RCVBUF is set to 65536 by the application, which
translates to 2 * 65536 = 131,072 bytes in rcvbuf and hence a ~28k
initial receive window.

Later, even though the scaling_ratio is updated to a more accurate
skb->len/skb->truesize, which is ~0.66 in our environment, the window
stays at ~0.25 * rcvbuf. This is because tp->window_clamp does not
change together with the tp->scaling_ratio update. As a result, the
window size is capped at the initial window_clamp, which is also ~0.25 *
rcvbuf, and never grows bigger.

This patch increases the initial scaling_ratio from ~25% to 50% in order
to be backward compatible with the original default
sysctl_tcp_adv_win_scale.

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
Signed-off-by: Hechao Li <hli@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>, Eric Dumazet <edumazet@google.com>

---
v1->v2: increase the default tcp scaling ratio instead of updating
window_clamp and update the commit message
---
 include/net/tcp.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3..2bcf30381d75 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1539,11 +1539,10 @@ static inline int tcp_space_from_win(const struct sock *sk, int win)
 	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
 }
 
-/* Assume a conservative default of 1200 bytes of payload per 4K page.
+/* Assume a 50% default for skb->len/skb->truesize ratio.
  * This may be adjusted later in tcp_measure_rcv_mss().
  */
-#define TCP_DEFAULT_SCALING_RATIO ((1200 << TCP_RMEM_TO_WIN_SCALE) / \
-				   SKB_TRUESIZE(4096))
+#define TCP_DEFAULT_SCALING_RATIO (1 << (TCP_RMEM_TO_WIN_SCALE - 1))
 
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
-- 
2.34.1


