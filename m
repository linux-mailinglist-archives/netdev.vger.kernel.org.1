Return-Path: <netdev+bounces-283476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDOLC7ZZ9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:08:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D53384B362B
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E47301917E
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12D38B7BC;
	Sat,  2 May 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV/WEb3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04D38B7B0
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752463; cv=none; b=EE9GIhXGhwkys63HvQKoS8qXiGZuFXTXzT0NTG5W6GrvECRwrUI9jLax59Ipj/lxn3+tpgntgYBcZC6n7Cz6VP1BrsWsP01bXg6/5NdUQNY6+yzH9UxG6mHTagG/OfXepr69ckSyuE7E8LqUIcvqYaZxxOX2OVUO3muTUVFj0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752463; c=relaxed/simple;
	bh=K/LAURG9+wJ0eXVQ2YKLQza3gcowCv7irj6gBkQPWBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGSXtknFYfvrYAIWnzCqy4rgRM8HQaFZqS/BWtKfay/3TresRXfjs0su8zCwaJXzXoZlFTyF0uV7JVlCQ3YxMG6kVheGuaPSo0GR9EL5usTRINXRjj9k5Zx8FMtJ5fnWDeglf4c/7GLvgemWVShPfqw8OkCZDU/aanOSif3hbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qV/WEb3Q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso2046896a12.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752460; x=1778357260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW6oxdoX7foHM7PJXeH0dE/YeOwcCSHqe5elQi75+pw=;
        b=qV/WEb3Qp/GviQtppQ/16FS+hZElTQE7Pxm9ysfrLrdoOojFDIXkRrF94Cojx8VpJv
         LSo7LaAEtaY4eKLWOSYbm+zTiinBaN4CS06R6uLfo0c36jK7X02uQdAYcgUOTyERNUvR
         08+vxvn9RQWey/cKwnyZ4WQOZHY6hjASHDuQr+/Ipsw6yc0at/xiBLw+q++cWLViLf99
         p3W8GpHfuaRfkNm3xbKLjEoa+pGTK3VH2/3J7sibIi/ceLMhjIiTC1VSN3nnw6+zWl1B
         0GJBqS5uw+imMQBybvtKVTrKAMXOdcc/e4WIrN6ZmgJhn+w9uQ3LOJ1acUqUBOBTdYrN
         HLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752460; x=1778357260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sW6oxdoX7foHM7PJXeH0dE/YeOwcCSHqe5elQi75+pw=;
        b=Ux0ig65tDpEGb/Gt9A4r3dpd0ovPYU+TslU0jSaqN8rAL3IuwV25Z21Y+j8JQFgPtO
         LcFNf3CYhn0Sw/AjfaA1mHGNntRmkWsnhOJlWZEsf06qf3SeciI476REvScm23GEqhtY
         aKFZGFeJnT98346ErFXLLVmxjSM7rp7K8hxs7pjBzXBrI71knbmR0XKpbygyiFf4iDbV
         LQzol+z2joHX6CxEbloZEi/pda8DLlUW51glKb0++Y75YqQYrGx9WieoE0wvPkCxsbxd
         t5aO3d39c7qfl+AwTy9AZ/FYOlaMmUQik9fjmwR5DjWD75igdkrYVJ8a1JgWdfnTSgg8
         poeg==
X-Forwarded-Encrypted: i=1; AFNElJ8mV+D/aFrwG/SH+rArtBCG+not2KMgGOKKRXGEz8jZvrc59XXD5xAT8ZU5vXcKrOFrLViNzaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCROKJ/QLcKMF7DRe4l0vItQR5jxN+4gDUoY045SblsJolwlv
	pTGEnCcZIKzv5exdUkfZ3Ro4E6A/eDKuYt4HO988KWLDXt/G4iO5uzxi
X-Gm-Gg: AeBDieu6oQphNrtVUbI73443JgxJ/XkAzZCU4b5bvjS24e0y0h5UpnavNGcUBVOciyy
	hJg3Lfq+eqERO4GrSa6VmGB+iJBAkxngxMGqzYJAx69GwaSalB2c72lEnkqDCihgMpBuOrrTSL9
	/hTHYWHcM3Wp7IYVhotk9EqvAiWApXDiC6+sp65U9/N2OFcYeGYo69HbCLNfaz9zMYimPf/ELon
	XSvLM53RDIsMz5ibOIKF2BZ6rtqX2llI7vfGN/h/mAULkfwiEY9D7BQ1u2vxSEfSMHYzbPOE/5s
	f86DMndDDPrn051KRuuD+/54He17xale/nzcObnnBb9ZbXgnkch9G9AMCk+JQQDe+2lxxIDppk9
	HJKjOs2pfal+FA7GiF2vX+ufINXJ8+NUGzbByNK5jBL5uZ/Elu7mx2/IrZ8OUntSrfUDQeRSE5U
	ADf2rrSwTM0cvXnxqftae07Xs1ds8DlBZgNV7GcpzN9UtxCQGiCGxQUJFHWFpbi3Msv0DI7EIaO
	rIA/X2oQ8uzbrN97SIirEJJ0Ead
X-Received: by 2002:aa7:c541:0:b0:66e:4372:7518 with SMTP id 4fb4d7f45d1cf-67c17f32792mr1144411a12.2.1777752460198;
        Sat, 02 May 2026 13:07:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:39 -0700 (PDT)
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
Subject: [PATCH net v5 4/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Sat,  2 May 2026 23:07:18 +0300
Message-Id: <20260502200722.53960-5-kerneljasonxing@gmail.com>
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
X-Rspamd-Queue-Id: D53384B362B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283476-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]

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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index ff1eade29aa6..ae59d1c1d2f8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -892,7 +892,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3


