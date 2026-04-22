Return-Path: <netdev+bounces-280300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAQgKIVC6GmZHwIAu9opvQ
	(envelope-from <netdev+bounces-280300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A6441D02
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAE783025711
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1A3A16B1;
	Wed, 22 Apr 2026 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6eeN1yF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85243A4F5B
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829034; cv=none; b=UQKxVCrfJIO6n6Hi+kPU7lICs/0Y1coafxgQilrIF+HUaMSQ43s6KT2ZSvMtTlnufEF33wzRZCAYHuShHOTLioflJh68S9J1o+kwP8WsYKnfFU2+LVvyyTuqCDlbdrYu0Vm/m65dzERkuZXHP0+TLj/Ve0GdJAqttDCqw164CjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829034; c=relaxed/simple;
	bh=Y8cIJSbwKxm8IRUgTgVDsnhOlpbwrWMFM1NAxZoC6mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvJsIAvkSAQ94Rt8IZgptYH3YrpS9JtwihBtPlfkEjxLftzeKGgGu1kLPTyO9NaHy2bqey5ERaOSyomxQC/p8c4Y1547aJ/b2p5nDvkCAi5U4jIPs++09IndGqRb7QZFqBnh+GW5RMLhhYlYh+UVRuulPdDcESX684XVSWO9Aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6eeN1yF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so2291609b3a.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829032; x=1777433832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q09KfaozepH2LUse2hL0T0apyQAKIb5vyRGtj6T/eCU=;
        b=Q6eeN1yF2lTxcOMSBMhwgS1jiXD3BhzHLCeGT1CKxs/RDl8FKEPCOzukhqLzhtH8YH
         m3o1n61/zV9+rUI92arroaycgMG4gQhDNlDHNtvPPhhlvkkLmJ2FF20We2wUUfUAcDum
         L8ZUS7z34jZgZaAXeRx8gAVCYSaeWqeFd4Zei5G90oRcWmvpVmuSmQFf3YCDdTMbEUWz
         3KFju9Y0VFTLC4ezRZdMF+DnC6Gf84IMd2mV/S2lWvJLER1MB3qAnZhNiQ4qIbYusRgB
         IXE7CGyss9U1GGrGoqADdfyRC+81wnWh3OSOOcVxxCveU2Taf+ppw9JmeoEyO5sx1+Qa
         Qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829032; x=1777433832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q09KfaozepH2LUse2hL0T0apyQAKIb5vyRGtj6T/eCU=;
        b=pgdQ0wGlVupDvY0BSALFcPW9d6vM3vCDGU1qoXVU1Nw/COzbceRnuc9R8eDHZ+dnXS
         Beko6gMAevXi1wCESzXwWSkJyb8pWX+bgBplbzNX/ufjtXGQwZv5SK4UaY17Mpbu4wZB
         Po8TaLZO0es/Nlwuu82SuoOhAaTCPu8tsOz8MJu6iVpreswXOAe8qcLXOW5uFOGO9GWW
         jx8bXYhVpjkgnsRSI5XRl0gMFazNPfDPwRF7qe2EQzzIZ39GS7g7pllKGKi97uCy1Gpl
         /QYCOCrtSUHagImTl7UF9ZvCOgR78u34b73K5/S0d4uBH+y6joImREEYMbzrdbsvFgdy
         +Z+g==
X-Forwarded-Encrypted: i=1; AFNElJ+RR7aHvkvS6OOrxtBAIC0PsBf4QT1w/1pp4hnhgp+YdEQLuk94PD195utRD3xGNOrOybZFuc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAubOycwiViw8PRZmoNA4vdxxKt1mxQ1a30vqvnxUJjF7sNc/
	+CX30hADB358jRnA13Qp0d53Xl9Jx8ikZiyG8lHRpasQj6sztbknr+jr
X-Gm-Gg: AeBDietZCSUR4CwcWseHZrCZucUUyBXGXjdC+/+VHzRgDOcH/cmrYmZCVlcUPS5colx
	5gndLMYoBa5djuqqoYrUoeneNyixAXndQR/u/q/7x31ZRlqCopiRUMTXkZ8NAw0zq2zDMo9jCTe
	mOLharmf3DuA38mRC3ucTfeK7XLKW1i4Al1ivCS+318jcUGNwb1YTAQsIXmuosOO1oAsYHmUJgg
	HM+kxJf0yfy1r7F+h9NPz+UdAM+rG1f8cipAG8j3GnAA+A+XA9tlLG2H5RTOg4QHRdwpu8HQlVw
	W2twnnPD/6OI2QPS/2v6uzkmo3zwqOK4tOqE2P9i7WHjmp7Ts+yPkTRV2R6cJNDlW3Ag2KDwhnu
	4XWT7d5cpXbo/EcAnmd2inYMGXL/MFFOwdNOpQOOWvfelKeOgZINHXZQzMiEkZosdC3ibOA+xMx
	vgyuXL8eKxjiiG1NvW+e3Bg3fSfQQdPxbHCb4+D5rMmxmfZR6oRBD6bAL120sh5/DEjOpr2CWxi
	61yDj1w
X-Received: by 2002:a05:6a00:2993:b0:82a:6461:6d1e with SMTP id d2e1a72fcca58-82f8c92a5fbmr20231914b3a.46.1776829032071;
        Tue, 21 Apr 2026 20:37:12 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:11 -0700 (PDT)
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
Subject: [PATCH net v3 3/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Wed, 22 Apr 2026 11:36:45 +0800
Message-Id: <20260422033650.68457-4-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280300-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 471A6441D02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding
any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
to accumulate subsequent descriptors.

If a continuation descriptor fails (e.g. alloc_page returns NULL with
-EAGAIN), we jump to free_err where the condition:

  if (skb && !skb_shinfo(skb)->nr_frags)
      kfree_skb(skb);

evaluates to true because nr_frags is still 0 (the first descriptor
used the linear area, not frags). This frees the skb while xs->skb
still points to it, creating a dangling pointer. On the next transmit
attempt or socket close, xs->skb is dereferenced, causing a
use-after-free or double-free.

Fix by using a !xs->skb check to handle first frag situation, ensuring
we only free skbs that were freshly allocated in this call
(xs->skb is NULL) and never free an in-progress multi-buffer skb that
the caller still references.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6521604f8d42..d23d1b14b8b4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3


