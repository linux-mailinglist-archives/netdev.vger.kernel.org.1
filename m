Return-Path: <netdev+bounces-294094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEmoIR6gHmquDAAAu9opvQ
	(envelope-from <netdev+bounces-294094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:19:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CF362B488
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8017530D772C
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9143D0937;
	Tue,  2 Jun 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eec45zW9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9F3CC7EB;
	Tue,  2 Jun 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391434; cv=none; b=dWhiHa/HNDCWq4zpGvuQmiB8cswZIFx8BqVQzZ9XFFBiOyZw+XuC/49Ebj83jGfLofDMGmeFt2YQlMXNwcSCoDddNgx/r84ODWO4iEYgabDKbwHFnM7v2LRMrRoHw7sKRv0FIzLPLnfPetGdX0sR4lPlEmxKV72ehg0UlUoG1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391434; c=relaxed/simple;
	bh=8qVp8OJnYqWyfP+y1omCNI0j4JnaXCuTn0chqe6ckI8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s5btKJuOyQPWY2vEeD4CgxCo5GS9al4XVeHscvClM2s4c9upIhyZ20D4QjVS2gWsz57VOKLXaib1SArb2ePtjvF1xkgNDExtbWxgKpcrlH6Q9bLX497u4BjRfd59WNmQcm7Ydp/+ozaoVkvBhXE1KoyGrEP1mgg6fDLZenwJ3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eec45zW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2EC4C2BCC7;
	Tue,  2 Jun 2026 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780391434;
	bh=8qVp8OJnYqWyfP+y1omCNI0j4JnaXCuTn0chqe6ckI8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eec45zW9ZIllK+4x1gqtx6JnAUQl2hNArT4c+gJ2T8p1CM7a8nAXaufPMMHpJ0Xbt
	 DuPJXo24gXowZWhHRduFHyJpTKggWna5exsKpi8c2OkqeJTDEJQhx74BtLeiPyu9Ao
	 bqe2bAHJIs7t8O7mJr1hB5j76YBSpOQiEwjYKpzgo+c1YEPbegiDc0E3kkXXNYzBH/
	 kHntwW9itziUEkRWrF/NOmPUWA3Z+WAmeOWhXpjahtGgLMKxs9hxioGyzmWuEXQoU3
	 RP05WQHfpDaubs+FWnQONO1kPr0nkq7tn3ELHraBc8HTwudFa2KPxBSA4CGKOzqCY5
	 2DOP2rFHUAeIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8639CD6E57;
	Tue,  2 Jun 2026 09:10:33 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Subject: [PATCH net-next v5 0/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Date: Tue, 02 Jun 2026 11:10:30 +0200
Message-Id: <20260602-net-next-mv88e6xxx-cbs-v5-0-1969758d1fa3@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAaeHmoC/3XNSwrCMBAG4KtI1kaSSZqmrryHuGjiVAPaSlNDR
 Hp3h4BQkS5m8c/jmzeLOAaMbL95sxFTiGHoKVTbDfPXtr8gD2fKDAQYoZXgPU5UeeL3ZC2anDP
 3LnKQIKVpfNsay+j4MWIXcoGP7HvDTjS5hjgN46t8TLLMC14BrOFJcsG9rVvqOe+FP9ye90CLO
 4fFTLB0zKoD5EiFTjceGmfVn6OWTr3qKHKgU7ZGV3Wd+Xf00rGrjibHurNUrhFGV/WPM8/zBx7
 Vi2WfAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391432; l=2984;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=8qVp8OJnYqWyfP+y1omCNI0j4JnaXCuTn0chqe6ckI8=;
 b=VKtmQvxukl3qdywHlKILHb6nMtCcDVPLAh956GpCmgNc9cdoZbjQ3iO0RzAPvyxB+kkweepUo
 PdCsLmLKVCGD1nOoo8hi2Vackb7JmfjCOQPRLLM2oTailLyPUb8/CA6
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Rspamd-Queue-Id: 07CF362B488
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294094-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,padl.com,kernel.org,gmail.com,luminex.be];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Several of the switch families in this driver have switches with AVB
support. The switches with AVB support have support for Credit based
shaping. This series adds support for the 6341, 6352, 6390 and 6393
families.
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
Changes in v5:
- only set the scheduling mode when no queues are active
- use u32 for rate calculation to avoid truncation
- Link to v4: https://lore.kernel.org/r/20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be

Changes in v4:
- add qav info for the 6341
- remove max_rate from mv88e6xxx_qav_info. It looks like the max rate
  mentioned in the docs is just the maximum rate that fits in the
  registers. This is already represented by rate_mask.
- remove validation on sendslope. This isn't used by the driver.
- use accessors for qav_write and set_scheduling
- Link to v3: https://lore.kernel.org/r/20260527-net-next-mv88e6xxx-cbs-v3-0-2f387eb5ff63@luminex.be

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

 drivers/net/dsa/mv88e6xxx/chip.c        | 169 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  21 ++++
 drivers/net/dsa/mv88e6xxx/global2.h     |   3 +
 drivers/net/dsa/mv88e6xxx/global2_avb.c |  21 ++++
 drivers/net/dsa/mv88e6xxx/port.c        |  63 ++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h        |  20 ++++
 net/dsa/tag_dsa.c                       |  11 ++-
 7 files changed, 307 insertions(+), 1 deletion(-)
---
base-commit: 022bdd9c0d036863c4bacd1688b73c6be3001cee
change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



