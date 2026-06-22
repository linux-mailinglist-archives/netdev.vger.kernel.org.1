Return-Path: <netdev+bounces-300953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id we3dMxy7OGoPhAcAu9opvQ
	(envelope-from <netdev+bounces-300953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:33:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C9F6AC88C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=OICmwXGg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300953-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300953-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D101300B774
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11693546DC;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D161352029;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102810; cv=none; b=Muz40WT8ju6I6M8lS/8yPSrghlaY62HqodSg24Q0ROE4cvayYhkCvZl1aIFiDKwy9r6/rn9i39IWqk4PvrXOLsltMyrQH3cj9RUZw8viDcZUfSYT5DHtB1PVk9iMQyohStShJHHuWDMEXaPruH3VFSFWrgBOZgvzuUlMW8bGkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102810; c=relaxed/simple;
	bh=SlilqLnNR3Q4g+urDMRHsH9UzQw3hURV/MRbu5xRLR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GCBr/VT0zndzZt3YHqlyyi2PfpnBDl6Js4egWCE/TA1lhWXLbLcamjCMu9aG78w4p/+L0SkRnfFHbVlmRQmb8e92fL3IRGuqV2AvyIFwylQrUgQR8dlCi8nJR1CfaKQp8iOBg5lXiNWPV1dnJl8Lp6V1zqyP9xVwq30SN9RvgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OICmwXGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4579CC2BCC6;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782102810;
	bh=SlilqLnNR3Q4g+urDMRHsH9UzQw3hURV/MRbu5xRLR8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OICmwXGgZzyVtanvS/yS1Txa8udxiA5hXC/obdb1+LWImyc90wfaUlErmVPfppoRx
	 eMjk7kIHQ82y4nsUJwMCU/C+udYqGMwgAbPtJACxktJFWZV2tRKBaE6+0OI0gqb8UQ
	 zrmmW4gWgK4jLqyBuR5MhrW8KMPuMWfsqIgl2eW31xb7VJ32I6NB/R4Nx1bsSF/+Jb
	 v5ZKFGZVXvZSaUvvQw06WEY3b3luM1AVkTnxbYBJ7e83o4TSeYiHo4mQSgJTW+Yy5m
	 uxlgNszdF2oq8O2KHzWQTohkSDSCwLWcMeT4FeeunFOzLCP1nzaA7V/8XswHGhNce/
	 q8Y3FCpqI9Rgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2469FCDB46F;
	Mon, 22 Jun 2026 04:33:30 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH 0/2] Fix to possible skb leak due to race condtion in tx
 path
Date: Sun, 21 Jun 2026 21:32:56 -0700
Message-Id: <20260621-fix-race-condition-and-crash-v1-0-87e290d9357f@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPi6OGoC/x3MMQrDMAxA0asEzRXYJjYkVykdhKwmWuwgl1IIu
 XtExw+Pf8IQUxmwTieYfHVobx7xMQHv1DZBrd6QQiqhpIhv/aERC3JvVT/OkVpFNho7LnMNOVM
 pmWfwxWHi/r9/vq7rBtBsbxRuAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782102789; l=2224;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=SlilqLnNR3Q4g+urDMRHsH9UzQw3hURV/MRbu5xRLR8=;
 b=q8rYtD4fr9w/nMSFulKO+HEpL6q6YTqMovs76yAYIPhrwzjWahoc4RH7IsycUYGjiK79q/2iU
 GkIp0lV6PY+A0HDI902sQX2KM3349U69IumWjyUhCp9GE1YF/POyrMT
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300953-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:pier.beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:Parthiban.Veerasooran@microchip.com,m:Selvamani.Rajagopal@onsemi.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48C9F6AC88C

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
Selvamani Rajagopal (2):
      Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improvement in buffer overflow handling

 drivers/net/ethernet/oa_tc6.c | 75 +++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 27 deletions(-)
---
base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
change-id: 20260621-fix-race-condition-and-crash-94d055a665c4

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>



