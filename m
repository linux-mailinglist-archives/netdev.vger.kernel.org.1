Return-Path: <netdev+bounces-292356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC+QEc4OF2p62wcAu9opvQ
	(envelope-from <netdev+bounces-292356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:33:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A80EB5E6EDC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB21300A7EB
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4B342E007;
	Wed, 27 May 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1R3FY0W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDF42DFEB;
	Wed, 27 May 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895988; cv=none; b=M2OgiPzo7O4w+SoRPnU8/Uzky8n8rUBhnnQRgddDaaAHEEn3iG/8JnrscZTVUhu4MXH6/03McThwZ7AvlN+4fQOuiQJWPxhPzvCuz1rjcS9rzMAgC6ZaRds1ns7De5dRO1d1Q8CYL8fgCz8XqZ/bsSaP0YPKDYsZnGwNiPFIY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895988; c=relaxed/simple;
	bh=O50bUWCUlEAX65YFS4bgnEKO/t542CcWepe9YlMR7/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HmTvzAhdQMjJVLC318QEF488FQ3SskpxT2wD6kLZ1DpztymgsDFkbzyMG5XAPtQyr0bJhrqNAeHxr/3/DMlY+sxxJj64VofRprwzaw0yrPOHkF0J8ssV11xreJ54kP/STXekhDzcFNpANUjmgFt4ITGTqRUJzZQJDT7USl5Xa0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1R3FY0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBD1DC2BCB3;
	Wed, 27 May 2026 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779895987;
	bh=O50bUWCUlEAX65YFS4bgnEKO/t542CcWepe9YlMR7/Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=U1R3FY0WNVPTVAKyzExwOkqckzBMxWkgiA8ngNEAP3kv7AVimAgPOrTwBIoO7tRk3
	 VHBTu6pEWLNjmQTFh30iUtOlMXEe1TkSQyfpz/tSVqtdCt6NfPbbrGDLYRdXePpTwu
	 PbhGI1vy70rBa6M2WFUs0+o6SvMN9dAK1o5DvTKIbEJdRrprFTBbia+Hq8KUB23jun
	 pq20GviErQ5i+RSTZl69iChUwUdIxIG53dcuGcUYzMWRpaRsyujXBialcciSu4GKVZ
	 3skrWKOLmzwO4eEGsx3I13mvyUUCe3ZJTtC+J1uAHrc72VcW4uwm2dbo4Hy471pszm
	 /bmLroUbLtVlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE44DCD4F54;
	Wed, 27 May 2026 15:33:06 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Subject: [PATCH net-next v3 0/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Date: Wed, 27 May 2026 17:33:03 +0200
Message-Id: <20260527-net-next-mv88e6xxx-cbs-v3-0-2f387eb5ff63@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK8OF2oC/3XNSw7CIBAG4KsY1mJgqEhdeQ/jAsbRktjWQCWYp
 neXkJjoootZ/PP4ZmaRgqfIjpuZBUo++nEoQW03DDs73In7a8kMBGjRKMEHmkrliffJGNI5Z44
 ucpAgpW7RWm1YOX4Guvlc4TP73rBLmXQ+TmN4149J1nnF9wBreJJccDQHW3oOUeDp8ep9Wdw5q
 maCX0evOlAcqcg1LULrjPpzlmX5AOQfbJEPAQAA
X-Change-ID: 20260430-net-next-mv88e6xxx-cbs-2121169caa68
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779895985; l=2237;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=O50bUWCUlEAX65YFS4bgnEKO/t542CcWepe9YlMR7/Q=;
 b=xb+ME6nTeycVy+QX18jeCv4B4F7HiP7nItW2st3c7WW/D5AiteKZTqvnGlBNiUIt2nFFKgMJ4
 0RYogS+naQVBWvVsjQoV/6BL69KdbSYluS31cEE5rQE8zdUaPxJg5zz
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292356-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,padl.com,kernel.org,gmail.com,luminex.be];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.0.0.6:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,luminex.be:replyto,luminex.be:mid,luminex.be:email,0.0.0.4:email]
X-Rspamd-Queue-Id: A80EB5E6EDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several of the switch families in this driver have switches with AVB
support. The switches with AVB support have support for Credit based
shaping. This series adds support for the 6352, 6390 and 6393 families.
The difference between the families is:
- total number of queues
- which queues support credit based shaping
- shaping granularity

Eg. setting up 20mbps credit based shaper on a 1GBit link:
tc qdisc add dev p8 parent root handle 100: mqprio \
    num_tc 8 \
    map 0 0 6 7 0 5 0 0 0 0 0 0 0 0 0 0 \
    queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
    hw 0

tc qdisc replace dev p8 parent 100:8 cbs locredit -1470 hicredit 30 \
    sendslope -980000 idleslope 20000 offload 1

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
Changes in v3:
- clear cbs_active_queues bit when the rate is set to 0 on
  port_set_scheduling_mode failure
- wait for the MV88E6390_PORT_QUEUE_CTL_UPDATE bit to be cleared after
  writing the scheduling mode
- add num_tx_queues for mv88e6191 based on it's family, as nobody is
  able to find a datasheet for this device
- reverse christmas tree variable declarations
- fix egress queue selection for devices with 4 queues
- Link to v2: https://lore.kernel.org/r/20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be

Changes in v2:
- tx_queues defined for all devices (which could be found). Thanks to Marek Behún.
- Link to v1: https://lore.kernel.org/r/20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be

---
Cedric Jehasse (2):
      net: dsa: mv88e6xxx: use the hw tx queues
      net: dsa: mv88e6xxx: add support for credit based shaper

 drivers/net/dsa/mv88e6xxx/chip.c        | 161 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  22 +++++
 drivers/net/dsa/mv88e6xxx/global2_avb.c |  21 +++++
 drivers/net/dsa/mv88e6xxx/port.c        |  45 +++++++++
 drivers/net/dsa/mv88e6xxx/port.h        |  16 ++++
 net/dsa/tag_dsa.c                       |  11 ++-
 6 files changed, 275 insertions(+), 1 deletion(-)
---
base-commit: 022bdd9c0d036863c4bacd1688b73c6be3001cee
change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



