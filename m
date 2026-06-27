Return-Path: <netdev+bounces-302357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1qczNp5AQGqleAkAu9opvQ
	(envelope-from <netdev+bounces-302357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D16D2B5B
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 23:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=kiajtxlZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302357-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302357-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A0D63008D7E
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202AB37FF71;
	Sat, 27 Jun 2026 21:28:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44AB355F41
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 21:28:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595739; cv=none; b=YvR81UJPJqauFzK27VQlNsSRgTqiFqEUylAMwNiaLQIJgQVCZgqJ+foJLeJ5jCmNyGgKxM6kzZIIgm+x+/Cw6ZNVJkno/M1VB87TqOpliVkxiq6cdvYZLpCTBKz4/Bg3SzAF9O3UtMyflmmPXvVUxVdGXJpuPUKc0i6dEg62hcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595739; c=relaxed/simple;
	bh=jhDUUimV3btwK24HPkRLo7McWA/Uq/+L3OCXNwFvQ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFAYGYhcSqdPGt4SzB037HQs95/g5cisOewZ5DTQGT5Bv7BUYMastflZ/gyhjpdlVMSJkmIWNl3A4x88fwJ9rY+E3s0FFSKMS2QPR8+fQSMJVonOl3M23hGl6gKKaDVYdA6BN4HUA02VYrnpx9RiSqj+c+fHHC08aQFn/UTBhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=kiajtxlZ; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c825c88744so10954365ad.1
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782595737; x=1783200537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfUYqZ5wmXGDRjKGvfXADrcgd/xNaAR34+hp3yqisLc=;
        b=kiajtxlZZqptArjAmGtYLP5HoPEZNFW6gDOhzIQzq08jxN4xmFKM3vv81ceh6NMoIh
         H0nt9koyWpuicteFSaa8FgynlapFpjoQjTGmV3nfm5PoDxPg0B7i6M460ZDhOlVO8ks/
         +loUaYGQNpionH3O30zv8pr6/lwT0iHHvFZzDa5qAWkokLLhBLFV8BjQblRiEriD6M22
         1LfivHJ5p62jSH7y+GC7yQYnvOjw6f4o9tYYFJmcY6iNxkzlI1NNm4T5PUPyp/ER3hj4
         +XbO8GAokluv7jhN6jVEkCjvIgSm2ClItfuKzZ7kVVLW6CNxzwzRpDzw7msW8Vl+GGLC
         7QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782595737; x=1783200537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfUYqZ5wmXGDRjKGvfXADrcgd/xNaAR34+hp3yqisLc=;
        b=hn7PAa5WB74fDg8E53JTs0LGtii74getjFzBaTWwhRNDd6uMvQJ/3uYta+xEbq+IHn
         TemEnc0pB/7cocp6PsFIRM1Ow0qGgou0JqA4V6CJT/Sqi/lgp6ZPu+Q7yYFOfPcx4J8x
         Egr7ffc6bbAxHzOwdFXr6HbxJ9P0Cfvaf9zQ0CjOlibOXjVnzWc9z+tUf9bPToSkp7QO
         g0fUhg6dLs4oahnxqWRSQr6TgNS94k1PpZ3Hl+LfuSLefv5MXv0ZkF7dWJZ99tyPUjnX
         ubfayvS5Np8MCnMcy4DNGydJEd4rY9mqml6oKDQbJU6/QtMAq3ncdDV51BxLwv1QkYRT
         nu/w==
X-Forwarded-Encrypted: i=1; AHgh+RqywwRlQJnGkXc/eVkIjvt5BrmxMJIqjWWq5pYZC7+4PAjtAMfdCN7/Ls/ug3pbUI9o0AsnWyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxWbKbBUqmF/koL1hckH0mPgjAVGHiGGEu4C9XQNdKa9bAC6B
	LNP6ZNel6NHEKYjeawcngkGs0TlSpFrssq0aSorNjeCl6TX9pYd4yQ5dgVwzX0IDOA==
X-Gm-Gg: AfdE7clqNAR+/zWjChJO21MbLAMDpiFVQs/shNuxaQjrhIST2EEpdzpViQigJa4mBzD
	MsPhe5NoasEaPP8+V8rq+3iaw0cm2DcdTTX9onk9KWwtiuge1tpi6hh8NsekpFSKrClicSOWySh
	WmQHJ5zH6wdR6oAsUOgrl0ByEidZgKuFM5jmxCHp5Bs/iEt2VTK/XMrPltmTwe6ChhEGwo9Zzr2
	qplovOdYfCxVlPOqL5vyJUds8xS3Y+JfY7EwSN9fKY3Mo7uVL3CCCq0mHisiN34jpoh3/stKQQP
	v8w5hGCuxXEu6zQ9LcflWjeNP66Z4P679RgEy46em/waYN7uWYufiM0JkmERa+8TeBnFc82E0uv
	c+dZ20Qkj5pNtJCUvyA8lYnDxUiEbkHTG9IEUM2trRs5jpPMLrLDdY2+NQSXlRBWTumm5+2a68p
	vHYmVCDMGemA==
X-Received: by 2002:a17:903:2cb:b0:2c2:33a4:aaa2 with SMTP id d9443c01a7336-2c7fc9b9eeamr112189945ad.35.1782595737088;
        Sat, 27 Jun 2026 14:28:57 -0700 (PDT)
Received: from p1.. ([172.56.105.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5b0499dsm63456445ad.34.2026.06.27.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 14:28:56 -0700 (PDT)
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
Subject: [PATCH net] net: usb: net1080: validate packet_len before pad-byte access in rx_fixup
Date: Sat, 27 Jun 2026 14:28:54 -0700
Message-ID: <20260627212854.4025016-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302357-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F4D16D2B5B

net1080_rx_fixup() only bounds the device-supplied packet_len against
NC_MAX_PACKET. When packet_len is even it reads skb->data[packet_len] to
check the pad byte, before the skb->len != packet_len check further down.

A malicious NetChip 1080 device can send a short frame advertising a
large even packet_len (e.g. 0x4000), so the pad-byte read lands past the
end of the skb:

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

Reject the frame if packet_len leaves no room for the pad byte. Valid
even-length frames carry one pad byte (skb->len == packet_len + 1), so
legitimate traffic is unaffected.

Fixes: 904813cd8a0b ("[PATCH] USB: usbnet (4/9) module for net1080 cables")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/usb/net1080.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c
index 5d4a1fd2b524..364c19bd822f 100644
--- a/drivers/net/usb/net1080.c
+++ b/drivers/net/usb/net1080.c
@@ -381,6 +381,13 @@ static int net1080_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	skb_trim(skb, skb->len - sizeof *trailer);
 
 	if ((packet_len & 0x01) == 0) {
+		if (packet_len >= skb->len) {
+			dev->net->stats.rx_frame_errors++;
+			netdev_dbg(dev->net, "bad packet len %d (expected %d)\n",
+				   skb->len, packet_len);
+			nc_ensure_sync(dev);
+			return 0;
+		}
 		if (skb->data [packet_len] != PAD_BYTE) {
 			dev->net->stats.rx_frame_errors++;
 			netdev_dbg(dev->net, "bad pad\n");
-- 
2.43.0


