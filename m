Return-Path: <netdev+bounces-300983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YWDzGwfsOGpqkAcAu9opvQ
	(envelope-from <netdev+bounces-300983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:02:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C69606AD7A4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:02:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nZ9RAtJy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300983-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5695D300E3E1
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20738E5D7;
	Mon, 22 Jun 2026 08:02:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714938E5F9
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:02:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115327; cv=none; b=ien2JHBBvPw57w/ka90zY5TeEbcuvGfGny+pGJk2IQMxHxauzrDuOFrjIp1iTXRsLnLwt4Q4tPMSNt84KAEE7ySYR4F433Y4Mz1zmOCJMMx8gpuKe0JsXSQzyFyLSnb6beJLOoUGJWeOKqrfgIDpA3GKlnoVQiIQp5ZRsSqdhpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115327; c=relaxed/simple;
	bh=XtlAZCp5/3F/xwVUnuePPqRADO4ZsJiWAhJuz4RSiB0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mia0GveQdeFA39qJM7imXVJ7geg4O6S1SEpB9wnXBHoKBVu1ABnJKW7+BvGgohCc/WAZQu0LrA1WdA/zV7IGJFcWx20mC2TA2689edPpggEibC04+zoeA/Nie5oLs/hgOQdNRCMQwY5YjiblBVedK2F6gCOKWaHtIihjgu5CpkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZ9RAtJy; arc=none smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso2897577a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782115325; x=1782720125; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIY8NrKQY33GiAZXeNgSrvmyjQBHSuRv6lsLBuV2R68=;
        b=nZ9RAtJyGf12YTxGAK4GPun5ZkVDAQQ5986MRkF0IHgJ0JJj/4vkC3XMa5jOtJFzfE
         fJmec0g+sX/9plfJg80/kMEZRiy64SSxyAv4ug8vw3CRglV/Gf8IgFGObvPxPW0zEg1i
         39V4cSR2HTsIYLRbrSzID32J5YxriwpHqDpZVwKO5t0Z0YQsBYVi6dEAr72r/FEQcW9w
         kiDDXx4nmZPbjR/1+3fgwUi/PNFNItBBC9emPncxNsNSmcYDObqfOhZtzMJ5XDNfDbba
         sObBTk/nJKqcZ4rrHmg64aUXLSYAc9xkpvYU+cWZfXWqJ5Zee93NsN4ruTFnPbOcWyKK
         LWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782115325; x=1782720125;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIY8NrKQY33GiAZXeNgSrvmyjQBHSuRv6lsLBuV2R68=;
        b=qpVgCO77eH0JZFmKdzs9FpazN+jCXv8uS4W8NBlTmloYPCbUM7tMp3qdCrAuNKyGeD
         xv/V2K1330BrTj8/eORBx3SSSxZU5Px074q7tA+kGOaOuRaYN0NWGAvUyxPc1vG5nypr
         X1PjQodoj7iqdm38fIsJyqs1cJMW+BmBOYxnx6liu5W3PDOANlkRGw5gf8RLC0vpYrx3
         cv7adJvTqV5SPRjhBzaTZsqz0vxT6o253Zu4KPxl26SiBxfG27uUa7jzgrGFnSDbqn1B
         b9Cy9ULV+ZCQx1hnumvYXsNPVSDE6ydPoRc4qgeFNdhf6793LY213NwBU8/8e10Rut2l
         3iwg==
X-Forwarded-Encrypted: i=1; AFNElJ9Wxh3YbasRKgZEqwILauC480MAzBYkM1OIe/tTiphXimAT9WhyqLqkFGBy+JGPcPRuRFJCpG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6cy9gGVD6/El1iOh29jVQuV4ZD7MAxHfBghRnUlJovhqWq9B
	1pTYsRVzLJCXPBSsl2WD4fSoE+asZvV9c46FZQq4mgtV9giVbme95Gf7
X-Gm-Gg: AfdE7cmC2U4/zwW1Hug3XNfqUhF4eoxeYfm2bN21uEALmfadg6j1MWHo+7wnZ2jStVK
	ylzmUtcE70wJb7ElU0xrRRxcAxKnBI0Ok5b79gAd+c7PbJv0LRudEH4fPbJlNKIFH6c1JunsQKP
	fid6d4KNSQI86ndFjIef1ldDLXsvF0fjtkOumIDLIqpEB4lNRbOzr0WdfNDDOYckffvinyvOMTb
	iIXzULXFP2sT3HWvidEaUu0qP3M/BF3RIKPejSP/UYIv8tf42nQrmeKPP6R/Lby2m+SUB6O5IVb
	tiwxxvFjEuOpqtju7i+kppvSC+plfx+OPxr8owgO/zm2+r5ObfwjpFtjh/z8AoyNV8g1f/IWhkM
	SgkRU4FBTi04Q3+lLIv/26SpbnmaXznO5a4jB1jjAOXbiSBTrFl6UMgEqnktreCx1tW7no02RxI
	d+SLcBqRbGko6kolo8G9jvnsRTMkB9vxinNpdEyw==
X-Received: by 2002:a05:6a21:7105:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3bb346583d8mr15583404637.33.1782115324909;
        Mon, 22 Jun 2026 01:02:04 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc374375csm6564925a12.13.2026.06.22.01.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:02:03 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH net] net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()
Date: Mon, 22 Jun 2026 16:01:57 +0800
Message-ID: <178211531778.2216480.12637613349790980750@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,maoyixie.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C69606AD7A4

kalmia_rx_fixup() computes usb_packet_length = skb->len - (2 *
KALMIA_HEADER_LENGTH) as a u16, guarded only by a pre-loop check that
skb->len is at least KALMIA_HEADER_LENGTH, which is 6. A device can
deliver a short bulk-IN frame with skb->len in the 6 to 11 range, or
leave a short trailing remainder on a later loop iteration. Either case
underflows usb_packet_length to about 65530.

That bypasses the usb_packet_length < ether_packet_length truncation path.
The device-supplied ether_packet_length, a le16 up to 65535 read from
header_start[2], then drives a memcmp() and the following skb_trim() and
skb_pull() past the end of the rx buffer. The rx buffer is hard_mtu * 10,
which is 14000 bytes. That is an out of bounds read.

Require both the start and end framing headers to be present before
subtracting them, on every loop iteration.

Fixes: d40261236e8e ("net/usb: Add Samsung Kalmia driver for Samsung GT-B3730")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I asked about this on linux-usb on 2026-06-15 and got no reply, so I
am sending the fix.

 drivers/net/usb/kalmia.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/kalmia.c b/drivers/net/usb/kalmia.c
index ee9c48f7f68f..0dd0a30c3db4 100644
--- a/drivers/net/usb/kalmia.c
+++ b/drivers/net/usb/kalmia.c
@@ -276,6 +276,14 @@ kalmia_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				"Received header: %6phC. Package length: %i\n",
 				header_start, skb->len - KALMIA_HEADER_LENGTH);
 
+		/* both framing headers must be present before we subtract
+		 * them, otherwise usb_packet_length underflows and the
+		 * device-supplied ether_packet_length drives an out of bounds
+		 * access below
+		 */
+		if (skb->len < 2 * KALMIA_HEADER_LENGTH)
+			return 0;
+
 		/* subtract start header and end header */
 		usb_packet_length = skb->len - (2 * KALMIA_HEADER_LENGTH);
 		ether_packet_length = get_unaligned_le16(&header_start[2]);
-- 
2.34.1


