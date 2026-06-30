Return-Path: <netdev+bounces-302957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id btHNEXdLQ2qCWgoAu9opvQ
	(envelope-from <netdev+bounces-302957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:52:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B47C26E0544
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:52:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=BYFT93R8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302957-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302957-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 116C7302A6E1
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81C3D9DDB;
	Tue, 30 Jun 2026 04:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B4396587
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:51:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795093; cv=none; b=BV8/0ObC9Tji1wk3ILC8yi7YkQZe8V2jl9a+EyOssca8PQPwfr03VZG62HNYmKIMVvTlrFBqDdWol/EAeBm77uPqEsVxZi8O5v/PAuMIK+JAbQvwQErjjKMhx8dZ4Karg2wSDB+DNhzPxoIaawh89f4LbyJ4vPElbIJHAtIhRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795093; c=relaxed/simple;
	bh=PujPPfMdGmHyDlkNHdLKC9VmWX14ZBNcw0Eb/Lc1ai0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSz6+He6KFmSE9fmLIagbGVp0c4n5hSAPb58IaqEgRPz43+GvQ/P0VMUsl34V5Q6MPkfn686hDt/SZL2vPkXl20h4XqipwrT8jYyOzRPYc1bXohxPBiG5S6iGc+Qrr9Ht9NlPJNvfP2yh88vLNZvxTGh4g7jyerP/0/e3f0/MH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=BYFT93R8; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9878bbe88so814955ad.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782795091; x=1783399891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8majgDhsjuju8MljyfR5KkPklBqvXm945cQmfmoHoI=;
        b=BYFT93R8cqXRrt4Tr2VnKuOTaKLAsNSar8WFvL0LeWzqIBWxJLfSRz2Vn2R5sps4al
         mJUTGwWQ4mnlGor9AAic9Vt4BYbH3/0j2xmaSA4H6hhJk+Ak5YTPND2FhKehk7yhb3kK
         3n7qzoAumf2/mn6w8y6RRM2dF/AgnotRgn18zs4NNnyWYh4AQqMLpp8cZWLfKAtZahKx
         DoDdC1iCTzNCAmj4xAlDyV/w5xpmmZT0zRhj8tCey0ieUi4xxSFyCV50vxZpNHZVWXle
         04lHlhx0ycNbnTkpE1z1LP9xpt6jyWdhrYb9JHxTq2Xy/m8fCv0pTK3fYKRPNudjb9mR
         wylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795091; x=1783399891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8majgDhsjuju8MljyfR5KkPklBqvXm945cQmfmoHoI=;
        b=AsMn2n7veb/oE7ObBHhekP8qgfTh6z6kh+7oG5JtcwEf1S0lOg46FloXzW2rgs94JD
         QB7r+EdGG1hfgAcVpstbaRZTDZ47a3YrMwbWXpLwF1FUqsfrRVnIaEIF+6iYXaaPbbMO
         tCHitExbMKv80gLOykJ47S15EB+GQSUe+7xvF68TF/78dCnoaKoSBcNXQct8mYs+u+oa
         spg3BM9p/wwXH0AzBZbEwzztZPdx74zUZ4O9Y8WjY/jHkdxH0H8qqUeC+b1WHP7gn/Hv
         kHUFmwQqAMxDuAvu/YXO4GolLlOfY1gng1hcpyLbFhO3Foc9cF6xY5fKM3zBUHX7yrWB
         2hgA==
X-Forwarded-Encrypted: i=1; AHgh+RrRfsu2ywjNiKyTwSH8vugeS66Wd3G3TSwLeweFbS0tn37WECU7TMv9OkyVC2736Z/QRhoP4IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdls8ZuB6JJYeFOYFIITNfBRVa+I61CvNRJHsj3hRxz9F+C6rS
	lDwFz54zGZTPPw8InbRCgXo1Tu1gvBjYEleoNM9k9ax0D0Zo2P0DYGAp2ZChxCRZcg==
X-Gm-Gg: AfdE7cnrPzQjr0UCww9TUM3LuCI3BBVSCXVi+m82CbuZkjsUhJap8UzObzck8R1UjtZ
	JwK/bkL4I0Higu/cspG1Btrctjn/irh40H6sUUDmu8jStwCpwA7utwek7tcyhRX6901fsPXwf2I
	aoBlrboDPXBxgKkSs4lJA1LmsoGGj1JywmmSCGK/sabt3eT2Xb4g6B404jZP1IFe3LqkPPAaQRC
	mvBgw1g8I/I26icqBt4S53PXW/XEqXP0FjMdPhFNShjze2kXwP8U/RksQHghRIG0uOzOdY0ckfn
	wLS4zSBNvc6uDDv40v0j2sIRMNHA60mRfegy4fq1aJxJU6LjQOuEPoWe9+qkdbzAr+kR43vkZRw
	QGlaVMVm6VCRgCn+YPJtTL6J/MbPhi/EyLEMSKeePWuj2Syquv4t3VZwt+Pe6lSW9aTREH/qccS
	Rcl9X1rQp5
X-Received: by 2002:a17:902:dac6:b0:2ca:feb:2aae with SMTP id d9443c01a7336-2ca44a1c9abmr2328505ad.21.1782795091214;
        Mon, 29 Jun 2026 21:51:31 -0700 (PDT)
Received: from p1.. ([2601:600:a402:c8a0:2cee:3f13:b030:dfb4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382acd0csm4972415ad.62.2026.06.29.21.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:51:30 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
Date: Mon, 29 Jun 2026 21:51:21 -0700
Message-ID: <20260630045121.1565324-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302957-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B47C26E0544

For an even packet_len, net1080_rx_fixup() reads the pad byte at
skb->data[packet_len] before the skb->len != packet_len check further
down, and packet_len is only bounded against NC_MAX_PACKET. A malicious
NetChip 1080 device can send a short frame advertising a large even
packet_len (e.g. 0x4000), so the pad-byte read lands past the end of the
skb:

  BUG: KASAN: slab-out-of-bounds in net1080_rx_fixup
  Read of size 1 at addr ffff8880106c83c6 by task ksoftirqd/0/14
   ...
   net1080_rx_fixup (drivers/net/usb/net1080.c:384)
   usbnet_bh (drivers/net/usb/usbnet.c:1589)
   process_one_work (kernel/workqueue.c:3322)
   bh_worker (kernel/workqueue.c:3708)
   tasklet_action (kernel/softirq.c:965)
   handle_softirqs (kernel/softirq.c:622)
   ...

Reject the frame when packet_len >= skb->len before reading.

Fixes: 904813cd8a0b ("[PATCH] USB: usbnet (4/9) module for net1080 cables")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: merge two validations into one

 drivers/net/usb/net1080.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c
index 5d4a1fd2b524..19f6e1222d93 100644
--- a/drivers/net/usb/net1080.c
+++ b/drivers/net/usb/net1080.c
@@ -381,7 +381,7 @@ static int net1080_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	skb_trim(skb, skb->len - sizeof *trailer);
 
 	if ((packet_len & 0x01) == 0) {
-		if (skb->data [packet_len] != PAD_BYTE) {
+		if (packet_len >= skb->len || skb->data[packet_len] != PAD_BYTE) {
 			dev->net->stats.rx_frame_errors++;
 			netdev_dbg(dev->net, "bad pad\n");
 			return 0;
-- 
2.43.0


