Return-Path: <netdev+bounces-289669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMvuFCAEDWrXsAUAu9opvQ
	(envelope-from <netdev+bounces-289669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:45:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A59586585
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 985493015C8C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DD221FD4;
	Wed, 20 May 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNhkK6p2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F36223DE5
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237804; cv=none; b=LXVpzG4/zL12J1RTpqv+biQfbwURLYI7KXHhPbMolU0xTyh25MiVRiksl7MK0373pIn77g+kkbq2FFe5jveycnsTQZ7+9fRdHkZEQceYXemut1RWKsuk/T4hAElvG93WVFXvmlaekL44z+e5PcJYgDRD8D6dd3BIhW41QTON7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237804; c=relaxed/simple;
	bh=5Z8z7HKhwwzvGQ+DZhaWBkbpNq/wQQwAj9Cy5B2t1Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gy0HNBo+EUCy4mqjdLrEWmizTFX4gf60/qyOh8V57hR+0GehC6THgFNwVX6sSaL3Jcnthr6aHuCUpQZ5KjiEPzHceAc25Jjl7lXU1FRWHksrcJHyWBfaglkeieb2NIYuM46fshN8wYM72wxe7eMrwDlHAGWvxfEHqUBUoPQFF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNhkK6p2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so4038261a91.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237802; x=1779842602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5tN8/amkdsPzdOUWFuYid/fcYnfAgsm8Go1nkEmf2k=;
        b=UNhkK6p2/t7s9h8y33hYYGm9My5cDwD5m8wb34veX1CEYKbj219DDdGMwEXQq06mXo
         SYH7RK57sUEO+pTP46LHdireAxH/w6Fw1aqAtT4tC9GEUgVthq3rXJyiyHcbrvxEMg8D
         gs5F9ObI7aK2Zy4kzXt0cUOve6tqwmJ1eu1uOa0D83mrqT8Ay+eUeZdYQorn1mpFd9A0
         X8FNErYHB2qLKKFxlGfOYrymLdaaGpb6cvM6UBqb//Yd7W/A2CBkm8kTjjpyc5XzkNwp
         hON2E+WqgW5mEW9EpkixZf03u/sT2AngWDUgYcgeAmQ7TNMoi4lIz/ONf0YugXdSLJyG
         FKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237802; x=1779842602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5tN8/amkdsPzdOUWFuYid/fcYnfAgsm8Go1nkEmf2k=;
        b=hFYVoovyEvX1EUxHBNflswEA23YUe+kzA9XHIG/WJhjmWQ0n8xuqb8QabLl8F06kd4
         XKlaZxuLWFiZ+f4jicTZRF2+KiAguQi6eBykQuJqU0z1bG33QgdkFcwa6fzDgsrQocFi
         b9ctU387DkBA+nn8moTc4ObJab0XVA05ORTT3V/iWyZP69ABOuU8p0wuxVlZgtcXn+DA
         hcdtKypfn/hgc+yQ+o4hXHIBUtBdxKLED8Pe8sTuJfuGv56ebU6e0z7evFqooynqcVip
         IDT1niIG0Mj/I6bTumpTRKEfnEkmUW9JOZR2KINiMNzb/+Turu2EFQN6FObNxGwTs7WG
         sTCw==
X-Forwarded-Encrypted: i=1; AFNElJ++vK0X+jbrEFpkomeGnvpCFFmCO0/UULq11aJuBKZjQrPJDLIIWpUECMN0vokZPo9z3B0QOBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBM+N7IwY2X6hvumO1kxoTIcFr3qmbSyCmeQXvt6k509FkoMc
	iGurb6WUQZB+2s0Cm05y7a02MxEWrv8oGWgKePNz7ep8giJnrEkV0wfr
X-Gm-Gg: Acq92OFPNEu4OA0JOVdzJAGAm5f1CqLC7h7GTo2yi3uSrfRu0xGKd4oPgl9SkFMm8d9
	WMUWJckptvaYVtN6sKSujp9RPvy6RCRst1fx8xuBzWs61PCl80ggUS2ZkCMI0GqOAA7hNivijs0
	CoMg8idzdfHDIIyVVMtr8n3FnBMccWD6d2I+ov3+8VEtqcWr+fW4HAb3TkCiAwzrgA1tqe0QZTC
	wPjBYSe+BXTNhoRaPTfxeLItxeqx9+t2u38QOT9DRoua5yF5kD+VOzGuoCJ7YSse7OWsii2vyPU
	7t4PdGWA4lCPdM7GjTA3wPxjimRrOcDkUFoDEuSYeoVNnsM3MFKvYsWLzvpwX3Z81//crAKhQtr
	1rpOLwcCU94+irfPF5u/KyeN6HaQsWBOSY5jS2rez1TkPGxce6LPm2lMGYVz0nKJgST8wTL6PZd
	alOkdPD42d3y+/SG5PPr67LsSSb1ruIFM0kPvoObcHTE5F534gnmHi8xYCWod4T3VXn9Uzd73BL
	G2X+aX4l1KpOjQhGm2Yh381blFSI9Y=
X-Received: by 2002:a17:90b:5904:b0:369:1dcf:4a56 with SMTP id 98e67ed59e1d1-36951ca8d1amr21589269a91.21.1779237802511;
        Tue, 19 May 2026 17:43:22 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:21 -0700 (PDT)
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
Subject: [PATCH net v4 4/5] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Wed, 20 May 2026 08:42:43 +0800
Message-Id: <20260520004244.55663-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260520004244.55663-1-kerneljasonxing@gmail.com>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289669-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B3A59586585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When the TX loop in __xsk_generic_xmit() encounters an invalid
descriptor mid-packet (e.g. an out-of-bounds address), the partial
skb is dropped and the offending descriptor is released. However,
remaining continuation descriptors belonging to the same multi-buffer
packet still sit in the TX ring. Since xs->skb becomes NULL after the
drop, the next iteration treats the leftover continuation fragment as
a brand-new packet, corrupting the packet stream.

Fix this by setting the drain_cont flag when the released descriptor
has XDP_PKT_CONTD set. On the next call to __xsk_generic_xmit(), the
drain logic introduced in the previous patch handles the remaining
fragments with normal CQ backpressure.

There is one subtle case: if a subsequent continuation descriptor also
has an invalid address, xskq_cons_peek_desc() rejects it and the
while loop is never entered, so the in-loop drain path cannot clear
drain_cont. The post-loop code already handles this: it sees
xskq_has_descs() is true (the failed descriptor was read but not
released by peek), releases it, and checks its XDP_PKT_CONTD flag.
Add an else branch so that when the released descriptor is the
last fragment (no XDP_PKT_CONTD), drain_cont is cleared. This
prevents the next valid packet from being incorrectly drained.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f4add7be8c93..de953f38b9e2 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1122,6 +1122,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+		xs->drain_cont = xp_mb_desc(&desc);
 	}
 
 out:
-- 
2.43.7


