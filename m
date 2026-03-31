Return-Path: <netdev+bounces-273774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wArBMgZSzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 702033728C4
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CFD63034EFA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5ED4657FE;
	Tue, 31 Mar 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFWLqiUH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785E2FD7D3
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998019; cv=none; b=aAZWynwsxbIReh3GXCjOj10ByPbdWzlrucGBo/GkzJ+7/crkf6gLZgboN4d3GgHR6euHY7Eo1heYR+ovyjoYLFIiIKJ7/zc4sjnrTz1SQ0976RXWkwQIIgoNzzfzF24yGdz9ET0mATVD/fsTAqdi3Fe+p+tGR7/dQnxqCtkdnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998019; c=relaxed/simple;
	bh=uH+S+6nZMoETKffQbWnB0xVUO8zOVAC/LAftpPnzPcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtkKHVK1QHUYzpmx7oB6LxnX6tleRhunstXMrMyh+TR4zkfMQAh88kzGuFkhdDO5AVtv0YEumR2FGvb/mSui2VwAMm9hpgVk9juiQcTD5SRKzcUzjiyyk/sISx+tVoDQKrJa0vbjd5Bylb2a0Bzh84TlfbRLQHt6ISsF8sDbzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFWLqiUH; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56b65ffbda3so5430869e0c.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998017; x=1775602817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyMo3bZqBoLxHWSj1zUWxXXoAGw/imiy/MTfskhCFgQ=;
        b=CFWLqiUHa5jzuCVT368EtwA+4h7XKMcCawNmXidbmDYf8N8mLAzUbeyRMZOhVMY3Jo
         8Dk4M8MmCPP/gzn/vB7p1fHbPq5UAPrOQcSO5mH5wOr93arTG0qHIFjRs4n62GtOQ+A9
         wj2XqLsgEL/UbgZPRXmwQSdoIb9vwCb/hXyd63vhMgfnvufO0HYCPgv7oCcseohS5RxE
         JuvPKptc4hdYgULoyGh/MaiTRK8639aHiyfCINLEkrtZ3912YkVMz7YNMDZQkTLPQJvh
         ek8Iwl+/dS0JhwdiZhCsvQwM+beWz0sXzRM0Oo/EA8s3UP8oYxjf1MCjQY5fHZCw3Cz/
         sOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998017; x=1775602817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vyMo3bZqBoLxHWSj1zUWxXXoAGw/imiy/MTfskhCFgQ=;
        b=Wrb37EMnMSirHT2NaghRxEw/sqj6/DZA0pMpDwWhVLcGSgXqWU7QG110wVuLs0juT1
         /Fa5JOWaVft1nYKXT8Ujag4ocUemL+6uHmWc0o4fSH3NVSEbR37vhPB6dUr3nqk6PE/l
         ARFvPDxn/m6aOo/Mj62BRMvJSYbO1rM3lLRbBx8lRi9A77xAUNxZINato0mJ0GgiTeGJ
         Lm8L0Q6xX5ntK+/WraOHuJITQCSWwckAPEmQZsAsPp2S8Rh6JFER8/1wzKvCcQ5vtlQV
         etCGeI7xAaAKTfuUmuQHKShSwXPIOIon4+TMqIesAhz+7pHVu0X10Iqd2/Sw9zwfNgN+
         OVuA==
X-Gm-Message-State: AOJu0Yzo92v4v7ZYmZ0+BkOmiHMhEqsQwrwl2k0pAKPNHyW7xEE9Ow2D
	/ENiULp5sN6vuqJWvBG9D+6WvGkWDEI4WbAu0QvM8WhVw5h53AQirROy
X-Gm-Gg: ATEYQzxN9gKIzll0U8Dmk31FK2HNFdC/t+kF5qJduCochR8LEvxRWuaA2/bffQV9DoR
	OI6OZeK1AleUCwuIpn3AOggWzxX+EiNxf2u8yz37oL8Itoo9MpINTHr8wxUWkEyiw4SyJ+M7ZUi
	KxXLRMJbAcGukwH78ODMLgG79cXGs3WLVjdsOjje1YNSyNa0THSq1Sns6Db9LG44EcRU+Vgadft
	pcTre+NeffAzygkh6UqQb72rCeF8ypNKyRZz3DxIHf5pCANF2Xv+KWrN0DQrXfhHP+hxoqy3zPc
	Ae2/M+gvDlmB0Nccg6s5AQRFWR4o9SWmhCf9udgqYYdL4EhpUw6J+zBoiuhQSLRbgHhCeCQmnDH
	e631M2jgEQkbm5yN8dKwmF7kHduFRF0OEs8TnRCh2zsZi2HFIpaQkPA+L8+gjssR8iwpZf+gVcW
	A4ATLycw++s9jKFjtmHlsFmHQklJ3spTzbZ56KIg==
X-Received: by 2002:a05:6122:4f8a:b0:56b:6adf:150b with SMTP id 71dfb90a1353d-56d8a94a490mr860276e0c.13.1774998017543;
        Tue, 31 Mar 2026 16:00:17 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:00:16 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:01 -0300
Subject: [net-next PATCH 01/10] net: dsa: tag_rtl8_4: update format
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-realtek_forward-v1-1-44fb63033b7e@gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273774-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 702033728C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Document the updated tag layout fields (EFID, VSEL/VIDX) and clarify
which bits are set/cleared when emitting tags.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 net/dsa/tag_rtl8_4.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
index 2464545da4d2..b7ed39c5419f 100644
--- a/net/dsa/tag_rtl8_4.c
+++ b/net/dsa/tag_rtl8_4.c
@@ -17,8 +17,8 @@
  *  |              (8-bit)              |              (8-bit)              |
  *  |          Protocol [0x04]          |              REASON               | b
  *  |-----------------------------------+-----------------------------------| y
- *  |   (1)  | (1) | (2) |   (1)  | (3) | (1)  | (1) |    (1)    |   (5)    | t
- *  | FID_EN |  X  | FID | PRI_EN | PRI | KEEP |  X  | LEARN_DIS |    X     | e
+ *  |   (1)   |   (3)  |   (1)  |  (3)  | (1)  | (1)  |    (1)     |  (5)   | t
+ *  | EFID_EN |  EFID  | PRI_EN |  PRI  | KEEP | VSEL | LEARN_DIS  |  VIDX  | e
  *  |-----------------------------------+-----------------------------------| s
  *  |   (1)  |                       (15-bit)                               | |
  *  |  ALLOW |                        TX/RX                                 | v
@@ -32,19 +32,22 @@
  *     EtherType |         note that Realtek uses the same EtherType for
  *               |         other incompatible tag formats (e.g. tag_rtl4_a.c)
  *    Protocol   | 0x04: indicates that this tag conforms to this format
- *    X          | reserved
  *   ------------+-------------
  *    REASON     | reason for forwarding packet to CPU
  *               | 0: packet was forwarded or flooded to CPU
  *               | 80: packet was trapped to CPU
- *    FID_EN     | 1: packet has an FID
- *               | 0: no FID
- *    FID        | FID of packet (if FID_EN=1)
+ *    EFID_EN    | 1: packet has an EFID
+ *               | 0: no EFID
+ *    EFID       | Extended filter ID (EFID) of packet (if EFID_EN=1)
  *    PRI_EN     | 1: force priority of packet
  *               | 0: don't force priority
  *    PRI        | priority of packet (if PRI_EN=1)
  *    KEEP       | preserve packet VLAN tag format
+ *    VSEL       | 0: switch should classify packet according to VLAN tag
+ *               | 1: switch should classify packet according to VLAN membership
+ *               |    configuration with index VIDX
  *    LEARN_DIS  | don't learn the source MAC address of the packet
+ *    VIDX       | index of a VLAN membership configuration to use with VSEL
  *    ALLOW      | 1: treat TX/RX field as an allowance port mask, meaning the
  *               |    packet may only be forwarded to ports specified in the
  *               |    mask
@@ -111,7 +114,7 @@ static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
 	/* Set Protocol; zero REASON */
 	tag16[1] = htons(FIELD_PREP(RTL8_4_PROTOCOL, RTL8_4_PROTOCOL_RTL8365MB));
 
-	/* Zero FID_EN, FID, PRI_EN, PRI, KEEP; set LEARN_DIS */
+	/* Zero EFID_EN, EFID, PRI_EN, PRI, VSEL, VIDX, KEEP; set LEARN_DIS */
 	tag16[2] = htons(FIELD_PREP(RTL8_4_LEARN_DIS, 1));
 
 	/* Zero ALLOW; set RX (CPU->switch) forwarding port mask */

-- 
2.53.0


