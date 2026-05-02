Return-Path: <netdev+bounces-283479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMw4Nr9Z9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:08:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F02E84B363B
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E550A30034B5
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0573538D01E;
	Sat,  2 May 2026 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmoIFbJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE8388E64
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752468; cv=none; b=jSueCYV5zWhFRYvJjzueJ8jT1e1Knbfoht/QY7gUqjzFdwvfw3CKtQyI/5CT2na1ByRlQ6dMwmsDoo0Lyhz4SWDpPxUwHGFlk67LqEX000zEZjc8gbl+NqEyo0fbSlzLJx96a4QRGuwluTD/+EQt22ZUmwQ8VmRz6u0sC2A/zo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752468; c=relaxed/simple;
	bh=FGvDoM9uXVztwtUKgUek9flqeiLXdB/EkIyHK8t010c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=buhorgn/zJYdeqRFKtaxs+cdLGZAT4JNkI3Lpku25stNmPFHOlxCMGnGPJ1kqt2JGZ6/bQuWMni7cbWVxljg62bDLlMdS1hcdnvsViNo7LF+p3aSaHLiN/PsDbEp/pSfCXAB0hnaRGwhLeVFsz6fGaC0G9FZHSlHlaP0eZkgh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmoIFbJD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5239851a12.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752466; x=1778357266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCgbdkfklEvQqwpphvtN/a1Cdnlt6OuamWeTRxx8vKU=;
        b=DmoIFbJDRPSIvEomWGcTisLu9jv5H87ao2MyN3AGqTWni116TBbcAC4I/Us+rcPsRu
         FeDZUThnkk2MH7Igz+4BDBrj7IG3uK2jV6Imigy4u16rK+Ex1M8twaqW8K4E1qora66Y
         XlyJDhtKpyYGHLvWidFLhZBYjQBlBclEtB76hAs0OKmQC3rCNETJd9ftzCTmoBywVyAp
         ERxk4JJpgfXtySPXYBB9KmMGCB7O7rxLg1BzFEKSTI2pI747lKHdOCoul3S09i8m24vX
         Z8N1m6lGkETAg5OT6FW9Nu5JuYEZkyrH1n+/SHeuj3N989YD2u7/2S33MlJ6LfWVD5/b
         pJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752466; x=1778357266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCgbdkfklEvQqwpphvtN/a1Cdnlt6OuamWeTRxx8vKU=;
        b=gNw7G7Lk+euj0TgCLdAB/Cl1WIwqy0WaHEHbFFT57RD14o4EQxnLIhwpGD7+OiFrRk
         ah4oSK2np0RSiHZjwDQpk+iqL6MTXqSDY+6etsDgy7wtvjrdsvXogS504xmzp0EcRMXN
         XmmuHzthWVsvJ8b0wTzOvKxOorDve1MVjNHNUy5AQloeDK2SQeC6iqEOT51J0i2wQ/3C
         2aUU72yMj8ZxwNhKhE8Q0U7j2hU5yiLKG8/JYFv4cALezSTdDyqiLAarl6EufdNCULfV
         KPAbNX76RRuFbGN1m/HxL5L30orw/HUQxDWcCVAiAqcfl5tkIO2w3C276TUc4qy0JnIN
         E4Gw==
X-Forwarded-Encrypted: i=1; AFNElJ95DdsVlt6CM1+xQlti9ZCCNYPpVlMsXHbSeb0cS5k2V2G4IjHTl9JKixmV4hUGyiRxn141SVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BCPbaLEqBdLUD5itUcBVviKHJK7/SVBAsLMEKQJmfgJvlUtD
	ej7aCEhBqn3jZFU1Iqlu6zRoQZiLOURquUqfliFPj++OXSa5xsJA88lw
X-Gm-Gg: AeBDieuDYof6HMfM+a+TNLMqy3pscugehwtuFQoBMZNYCW8/9CdIQU9eemzwnWv0U1S
	z4M41J6rqJrXNBSJaKEY7u09w5hYkfORJiC+ktB8Htr2G9Lu3pbPvzfmErwJthMXz/ClaFiFHDe
	KAw+YnfTsfQ21Irioo50959icfNt/r1uzwpFVuRVnaCiYaKfp3e9qApeb0ik2metqeEsTN00nkP
	cAgNG07mGeyuAAB4Nmnb/JeIwXHU9tEIuNpS+njyMgGi5MoZZVAMlCBzNjAjgcEFbx9s52krSd5
	UGiWUA+JzvM3gH44qvOeiRjFUKTFTVtluRK++FoH/AVNREB/BMoSQ+kRMC3uaT3ytkk4yne1QMV
	Iyl/XdRIBF7CF8dvVjktRRpdcyZNFD1jgRWe2oMzZA6cC03LPolB1mNKvhEgTve7aQVH+kisnhn
	mNLeU0xASc3T9YSflrNEbP06C1Q2eE5jUuUcFQzHoRam8nNn+8JwlaVyRc7eeb0jL8DhwQGB+vd
	iBuDX8qNne3VnfuFw6kxe/D/Og6
X-Received: by 2002:a05:6402:21d2:b0:67c:1fd5:32ca with SMTP id 4fb4d7f45d1cf-67c1fd535d2mr984867a12.21.1777752465628;
        Sat, 02 May 2026 13:07:45 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:44 -0700 (PDT)
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
Subject: [PATCH net v5 6/8] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Sat,  2 May 2026 23:07:20 +0300
Message-Id: <20260502200722.53960-7-kerneljasonxing@gmail.com>
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
X-Rspamd-Queue-Id: F02E84B363B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283479-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,fomichev.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means no frag and xs->skb is
   NULL) and users enable metadata feature.
2. xsk_skb_metadata() returns a error code.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
4. there is no chance to free this skb anymore.

Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 13bacc11fa9d..5e6326e076ab 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -741,8 +741,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		skb_reserve(skb, hr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				kfree_skb(skb);
 				return ERR_PTR(err);
+			}
 		}
 	} else {
 		struct xsk_addrs *xsk_addr;
-- 
2.41.3


