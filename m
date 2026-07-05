Return-Path: <netdev+bounces-304820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cj2gBOvhSmpfJAEAu9opvQ
	(envelope-from <netdev+bounces-304820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 00:59:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EE670BB04
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 00:59:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=n+Fjgpku;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304820-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304820-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9276730071EF
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBD0371867;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5930566F;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783292390; cv=none; b=jA+LzRBBgT0zYxG3SlkTg+tG9RTJinOhMFwGPA6UBSLvx3BCl+nJhdC/lpMAmCVouXF+6WYSVSdncVK6VZm3UJTDHTDgEvU1jf0joXv17ESt/k/qrHMRD5QRVJUdS4mq9U5sK/ZVbAm7F7iQiOE5lDWTFlJilihjH4apRuc8iSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783292390; c=relaxed/simple;
	bh=hVEDjOOLTS9teZAywNgIoXsCyEabv/s5fUnTFFQyj1Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GCvak+mMEuWvh3aO9QDhfSMXruQHR3d7J0qcHRvI+HWvnL0pjAJQT0QsIHBBfPim+wKRsgAFjFjYhEhUuXCX39IdHwB0cA+1T3i5jHUrYjph+iY0njkwV3MSW9aCj9q81bw6alodACubJn4/Neq2d1iC5rfomwGlkpszuHB0DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+Fjgpku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 153A9C2BCB8;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783292390;
	bh=hVEDjOOLTS9teZAywNgIoXsCyEabv/s5fUnTFFQyj1Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=n+Fjgpku/2gT15aw3oXHQkfqkwmquxb8TUEul8osmXStXy840xop5IYGkobaLKktj
	 xc7HuQb5NNdWbdUfJ7jjChP6iA5VfLCHfhsrsbYcI8bqiPuFL35dFf2M0i9YICWmqc
	 yw9dWF7MVIfILQ2E8l4Knektw6uk+m51uKQn9a6XpQT2Z7bTD9u9EdASnpPaoYQiA/
	 pY+yiN4rz+Y8oCEILgFyPoNa/0COLWPa76XV/fPQbs0XJ1HioNs8Iatx6pqoMoqNoN
	 cOP8971YlhjSx2t1+xbKoXvPYy1LAROs8R6QnBWLEyA4aSGKrOh7BB/BNeGirIfKXG
	 bm/ops0CRZG9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A5FC43458;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net v3 0/3] Fix to possible skb leak due to race condtion
 in tx path
Date: Sun, 05 Jul 2026 15:59:48 -0700
Message-Id: <20260705-fix-race-condition-and-crash-v3-0-3e51841e4d08@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOXhSmoC/43NQQ7CIBAF0KuYWTsGaKHWlfcwLnCYWhYFA02ja
 Xp3CStd6fL/+XmzQubkOcNpt0LixWcfQwnNfgc02nBn9K5kUEIZYZTEwT8xWWKkGJyfyxxtcEj
 J5hH71gmtrTGaWijEI3HZV/4CgWe4lnL0eY7pVV8usp7+0xeJAo8dq164vtHdcI4h8+QPFKcqL
 +pTMz80VbSbIU1SsBHtt7Zt2xvqopYxHAEAAA==
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783292390; l=3071;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=hVEDjOOLTS9teZAywNgIoXsCyEabv/s5fUnTFFQyj1Y=;
 b=JLa/tAOVOtg5PIhM9ZbP9pc/QWT3z+2uzfa3PLbIODeYcnq8WW6LJPPYICKfMsLEZYGg8j7ip
 ZRpnGXuIwAaDPp0OZ3XMdfq5EwcKr7FUpv7tt+g6S+ewJ+SBRchnob7
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304820-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:pier.beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:Parthiban.Veerasooran@microchip.com,m:Selvamani.Rajagopal@onsemi.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54EE670BB04

Now the traffic is handled in threaded IRQ, and the
disable_traffic flag is checked before handling the
data, new race condition is exposed, in which
buffer may leak, if threaded IRQ interrupts the
trasmit path midway.

With this change, disable_traffic and waiting_tx_skb
pointer are protected by spin lock/unlock pair.

This is highlighted in Sashiko review
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260611-level-trigger-v5-0-4533a9e85ce2%40onsemi.com

Also on buffer overrun condition, probably due to loss of
SPI data chunks, receive path doesn't see the expected
data chunk with end_valid bit set. As a result, driver
keeps adding data chunks to the skb before running out
of space and kernel panic is seen.

With this change, before adding data to the skb, if there
is no space, skb is freed and driver starts looking for
new frame by looking for a data chunk with start_valid
bit set.

[  705.405490] skbuff: skb_over_panic: text:ffffffd2eb72a264 len:1600 put:64 head:ffffff804e5cdc40 data:ffffff804e5cdc80 tail:0x680 end:0x640 dev:eth1
[  705.405569] ------------[ cut here ]------------
[  705.405575] kernel BUG at net/core/skbuff.c:214!
[  705.405589] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP

[ 6703.427690] Call trace:
[  705.925157]  skb_panic+0x58/0x68 (P)
[  705.928726]  skb_put+0x74/0x80
[  705.931772]  oa_tc6_update_rx_skb+0x44/0x98 [oa_tc6_mod]
[  705.937084]  oa_tc6_macphy_threaded_irq+0x3f4/0x900 [oa_tc6_mod]
[  705.943084]  irq_thread_fn+0x34/0xb8
[  705.946654]  irq_thread+0x1a0/0x300
[  705.950134]  kthread+0x138/0x150
[  705.953356]  ret_from_fork+0x10/0x20

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
Changes in v3:
- Cover all the instances of disable_traffic flag with
  spin lock to serialize the access
- Disabling the tx queue and mark the carrier off when
  disable_traffic is set.
- Continue processing received chunks on buffer overflow
  error and "out of skb" error.
- Link to v2: https://lore.kernel.org/r/20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com

Changes in v2:
- Improvment to how error -EAGAIN is handled. Took care of
  couple of use cases where start_bit and end_bit may be missing or
  repeated due to lost data chunks.
- Protected handling of waiting_tx_skb pointer with spin lock
- Link to v1: https://lore.kernel.org/r/20260621-fix-race-condition-and-crash-v1-0-87e290d9357f@onsemi.com

---
Selvamani Rajagopal (3):
      net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improvement in buffer overflow handling
      net: ethernet: oa_tc6: Carrier off when disable_traffic is set

 drivers/net/ethernet/oa_tc6.c | 219 ++++++++++++++++++++++++++++++------------
 1 file changed, 158 insertions(+), 61 deletions(-)
---
base-commit: d7a8d500d7e42837bd8dce40cb52c97c6e8706a9
change-id: 20260621-fix-race-condition-and-crash-94d055a665c4

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>



