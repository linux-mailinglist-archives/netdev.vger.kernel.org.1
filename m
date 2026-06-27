Return-Path: <netdev+bounces-302350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q053Jmo4QGpydgkAu9opvQ
	(envelope-from <netdev+bounces-302350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:54:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 055C16D2A26
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:54:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=DOKTrW8b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302350-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302350-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 119573015A67
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701436F91B;
	Sat, 27 Jun 2026 20:54:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A28369990
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 20:53:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782593640; cv=none; b=iGw02zzeM40T78FHzXnIcX/IzHm+c4x2ETgHnH52UhpuGfxeyiBLVDJqTMk2Ra3QF6yGMUHKKS4CV+atAzudFuDgwWPkFfAMvAEkFosrereVBeApo+cCZZrvV1pH4TWQIirIkvoLN+0TfqNeXpoKG35VTLQQRCoEFPYc1l11Y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782593640; c=relaxed/simple;
	bh=e7wQOCZ2RmUk/JLlzqi8q5dvkrkwEKZp/vsqcgT7OlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+yRXYLCnQq+Mp59nqbidGeb7o7Thl1ZxJ6P0WYnVl32GaJ7TwHbagM7TBKZU7YiBSG4WXUXgJ+Jl7Rd7jMSQGQsGA/OwxkbTiOBMKJvtzhNkeTKBtECvlOUxBds5BHIGsM0ELfp0jnMmWIqYtLgxYSx/YhPutGLFustQfmLSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=DOKTrW8b; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845c38dee22so985222b3a.0
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782593638; x=1783198438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHRjizZyH2fQDJvnCRDCcWYlVrs6WnvhUFm2dNj9VHQ=;
        b=DOKTrW8bzAoY0Yzfb1G1m3Wqgq7mfZ8C5ctzuUMu3uRxZ37zUjJmGmR3+3bVFcRSw8
         MdjKkP/+cH+ZJqM7mcp6dFnEzqwpn+HU56zoWEc0Wm53TCpSvxdrAYSpaxnUnS2xUNDT
         LthQpw6RFVv6fojSRBKsmVkOMoh/ZF9lSDCxGG9ppMrACmPE3TWsuYTXk1hYRHcypFkO
         8KgcQZh137rNvvZ7I0KOuxF4hDknZRwbsHy/SRnmjsODxwbO48JoKJodyPSiyouDN/ns
         sp5j6CXpqE6lkdBZkOhG3G2gaF+oKFQbWUP3EHwFLJSp2VRqbFTDE5PPNehgsmjFQY4n
         RFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782593638; x=1783198438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHRjizZyH2fQDJvnCRDCcWYlVrs6WnvhUFm2dNj9VHQ=;
        b=fk61k0it2fHBXMnxQynIm3KtLciT1aIlvQji2h1f40gtYNg9Ig/Z+kyNt7SpmAW4Dz
         86FChI3+NF9o13KjWxvlMAfzTxP57c/eh0ilujPzkN6FxqGz7mEhJOaOqPmS9yOwzdmW
         XPGweM4Ucuya1LgOb0USkfICyuvAIVt6U7lLuK1ba1MbqihgUmodXAy2UNH4AMuzO1CU
         rvUKb+WbexAbHjpfQtDobf8/0vRLvM/7RSb9cQ1dsUssGjhyuTMhT1KU/3cBzNvqIU7z
         PDLlQ62EyG/ppuSnuzGUDJaPztyY2E7o10iXT3x/xHCAYdH2DQjVgPTfg4qpNho3+nt+
         IX4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/v9S7tTWzQDZRySW+BUiI6V/7peqHq2jkDtHmrXnpfx3xO3+0GhgibtaPmUFVMpaJYbl7jzzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2txTlgBonWPzeNwrY7G6OzbxL3nrP83/cb+cjasCQ7zHC0Xf4
	EVGRP+ngCeyphXZDBFkx98Sic/vJurumUTnmuAQaKoKVhx4+FKY3XwxksmnKwU7hWQ==
X-Gm-Gg: AfdE7clNy6iamF64d8WSAAkMPz5HbBbvMUALgI/oM4sg70ueJrBffXM+7UCNj2Vc8cA
	MpXRMMZzQSxzw205K0IO/gPMR501ru/od2uz52tSLC/CUIiD5SeIRIcIBEGN48n1o+65Tdm+8g+
	5yH26HPawttp/Vw8lOaEhYMhsoKx1VVeAj43fyYEtmcpswHS5HhbgcdI/WaWjwbkQYF+K6Oucvo
	jNOD4XmUJnfAZh6DuCisKz8VEoLgltZDdAer+qUS6SJ7gIW0utBbqCSyJ1KgoKjsy2oZruu0X+y
	jQGcnHjH0ZR+tbB3DJZ1jyu4w+Dz1zSXIgEKvGXs1id89dh5OMiLvBzywIvVGxfR0ksmL16fxL+
	3trXHRcNVMS6Mm6f/ybXkNHvKvNmyfEo9/m1aMH65grtEHXmEYo2l6vJ1xwOiGW75bfGf991UvW
	Yb76DH/kc=
X-Received: by 2002:a05:6a00:c87:b0:845:a302:2281 with SMTP id d2e1a72fcca58-845d25fb441mr4561069b3a.35.1782593637421;
        Sat, 27 Jun 2026 13:53:57 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec0d:cc1e:95f8:260b:6b05:f94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4127bd0sm8822715b3a.53.2026.06.27.13.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 13:53:57 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] usbnet: gl620a: fix out-of-bounds read in genelink_rx_fixup()
Date: Sat, 27 Jun 2026 13:53:53 -0700
Message-ID: <20260627205353.4000788-1-xmei5@asu.edu>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,asu.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302350-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 055C16D2A26

genelink_rx_fixup() splits an aggregated RX frame into its individual
packets, using a per-packet length taken from device-supplied data. That
length is only bounded by GL_MAX_PACKET_LEN (1514); it is never compared
against how many bytes were actually received.

A malicious GeneLink (GL620A) device can therefore send a short URB whose
header claims packet_count > 1 and a first packet of up to 1514 bytes.

	skb_put_data(gl_skb, packet->packet_data, size);

then copies past the end of the receive buffer and hands the adjacent slab
contents up the network stack, an out-of-bounds read that leaks kernel heap.
No privilege is required: the path runs in the usbnet RX softirq as soon as
the interface is up.

  BUG: KASAN: slab-out-of-bounds in genelink_rx_fixup (drivers/net/usb/gl620a.c:112)
  Read of size 1514 at addr ffff888011309708 by task ksoftirqd/0/14
  Call Trace:
    ...
    __asan_memcpy (mm/kasan/shadow.c:105)
    genelink_rx_fixup (include/linux/skbuff.h:2814 drivers/net/usb/gl620a.c:112)
    usbnet_bh (drivers/net/usb/usbnet.c:572 drivers/net/usb/usbnet.c:1589)
    process_one_work (kernel/workqueue.c:3322)
    bh_worker (kernel/workqueue.c:3405)
    tasklet_action (kernel/softirq.c:965)
    handle_softirqs (kernel/softirq.c:622)
    run_ksoftirqd (kernel/softirq.c:1076)
    ...

skb_pull() already verifies that the requested length fits the buffer and
returns NULL otherwise. Move it ahead of the copy and check its result, so
a packet that overruns the received data is rejected before it is read.
Well-formed frames, whose packets are fully present, are unaffected.

Fixes: 47ee3051c856 ("[PATCH] USB: usbnet (5/9) module for genesys gl620a cables")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/usb/gl620a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/gl620a.c b/drivers/net/usb/gl620a.c
index 0bfa37c14059..09afd137b64e 100644
--- a/drivers/net/usb/gl620a.c
+++ b/drivers/net/usb/gl620a.c
@@ -104,6 +104,9 @@ static int genelink_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			return 0;
 		}
 
+		if (!skb_pull(skb, size + 4))
+			return 0;
+
 		// allocate the skb for the individual packet
 		gl_skb = alloc_skb(size, GFP_ATOMIC);
 		if (gl_skb) {
@@ -116,9 +119,6 @@ static int genelink_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		// advance to the next packet
 		packet = (struct gl_packet *)&packet->packet_data[size];
 		count--;
-
-		// shift the data pointer to the next gl_packet
-		skb_pull(skb, size + 4);
 	}
 
 	// skip the packet length field 4 bytes
-- 
2.43.0


