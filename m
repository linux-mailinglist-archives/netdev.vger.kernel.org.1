Return-Path: <netdev+bounces-302217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id efhKNredPmqTJAkAu9opvQ
	(envelope-from <netdev+bounces-302217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:41:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 372856CE97A
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:41:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=jvEOLDnv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302217-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302217-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16E3B30785CB
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395643DC85B;
	Fri, 26 Jun 2026 15:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BED39DBC5;
	Fri, 26 Jun 2026 15:35:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488142; cv=none; b=PwrCm3xFZ524gCcjqzvSY80todxflFrs7XzEdTMM/nOB+GLPuqDuu+V7swXhMDQzmhuU8fpS6xVBlWPm10BwFi9uYXNDN9+0O1PhvbEhjzQsKqC0JKi/xJzXZdUGCugHNMaOYtYe29NkJUVD6XzXlUDA4m0Wz+0LthyxXT21BLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488142; c=relaxed/simple;
	bh=fZWL5wzmVFAxPlXq//5HPlDfG8/hhfP+jSRo0zwhFIY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kDd6mjMmYHARyaKw57LnFmtCZgN5ni289kGX39mofydcZcDUogGf9owJvA3i3AZL7daWE8wopTUj+BKI3Shh8Sv60XsNxXgqDP3ZTF6gFI6SSAGIPBiD+KdJYsLlkwSwLLkWpzcrvxPIgmY4Tzto47TDC2tK6Ekmk1B14OJTtic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvEOLDnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4C6AC19425;
	Fri, 26 Jun 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782488141;
	bh=fZWL5wzmVFAxPlXq//5HPlDfG8/hhfP+jSRo0zwhFIY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jvEOLDnvakn6nCFpKs/Pm11SxRSKqTLfY+ryPcSlJOXW67wL9j4mNe4qYvF62yvli
	 tUg0raFLxO7L7v91UnceA5j5QNHZ7Vf69or/hBC2e1nWx/QiC539OI3WSXwGQbM20Z
	 xZjNH/PL3BVYyxzigUhhZZ+xbvgE3dUNqiR2jpvjnO4bEYEcFhKgSI+hStlIPbN6px
	 jhWtp3iNgeZpTYprnaBsQLgSiT2nU5ZZH7y8Cq3uQmWW5fRz3E6V2W4cNqpKgNBNga
	 CjmQ+YBMRx60dhefsiSebgavU9Ltq5ADf638d+6/3Nn56gA2mJMsSwV3+3xB2HG0H8
	 fZ4mk0M3mQhyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD1BC43458;
	Fri, 26 Jun 2026 15:35:41 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net v2 0/2] Fix to possible skb leak due to race condtion
 in tx path
Date: Fri, 26 Jun 2026 08:35:17 -0700
Message-Id: <20260626-fix-race-condition-and-crash-v2-0-b6c5c10e604f@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWcPmoC/42NQQ7CIBBFr9LM2jEUC7VdeQ/TBYGpzKJgoGk0D
 XeXcAKX//+X90/IlJgyzN0JiQ7OHEMN8tKB9Sa8CNnVDFJILbTsceUPJmMJbQyO94qjCQ5tMtn
 jNDihlNFa2QGq4p2o8k3/hEA7LLX0nPeYvu3y6Nv0n/3oUeB9JDkJN93UuD5iyLTx1cYNllLKD
 1/tSHDOAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782488122; l=2607;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=fZWL5wzmVFAxPlXq//5HPlDfG8/hhfP+jSRo0zwhFIY=;
 b=c/oAHFcGtFoALiyo+M/qx9oUKUw+FCxzUOG83HQqdZRSi2He/c24aXaVtUAfOtmekwMjBbZip
 k/zvkLmIsnKCqHBIZvCyROjCthEH2mvyOxA/zo4M9woWN6Whowmrw9l
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302217-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 372856CE97A

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
Changes in v2:
- Improvment to how error -EAGAIN is handled. Took care of
  couple of use cases where start_bit and end_bit may be missing or
  repeated due to lost data chunks.
- Protected handling of waiting_tx_skb pointer with spin lock
- Link to v1: https://lore.kernel.org/r/20260621-fix-race-condition-and-crash-v1-0-87e290d9357f@onsemi.com

---
Selvamani Rajagopal (2):
      net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improvement in buffer overflow handling

 drivers/net/ethernet/oa_tc6.c | 91 ++++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 27 deletions(-)
---
base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
change-id: 20260621-fix-race-condition-and-crash-94d055a665c4

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>



