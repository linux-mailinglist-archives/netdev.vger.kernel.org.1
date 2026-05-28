Return-Path: <netdev+bounces-292759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHOYIJtwGGoSkAgAu9opvQ
	(envelope-from <netdev+bounces-292759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:43:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226F55F5292
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AEFB31155D7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8763FD13F;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QygydfWM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B213FCB18;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984582; cv=none; b=POdfGCLAyIN2T4XJCvlfZ8C+55oLt8EVbLvCZSEP4obaCHBHP1tZ1ZcD7ffzWB+3tuj8SZ4eZ/v+mikP7yKNjO0FNoCEgDe4bjDtfXvtmDaGu3jZfCD2Qd15ZpPRN/vUZ3iU5QAsZwB9t6O6wH/dWMOUyakjhTKNsRmzelwPnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984582; c=relaxed/simple;
	bh=azX+OPVgNWIrCX30lIKaS2K0d90+VU/piOQ7v2TJUhA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AO8CQvnV+Sz/Qp0PrEX8Yr6+OHuTeSAiAxf0BVCU9ABhWbw2BWk2JRwSPQa9be5SjbcjOAw/4MK2h6O8ZQSYSMmVsQQGrBmtac1T7zmW1i1KQqnRGzCltgbnOkjQ6+uqFx2Uvl02WQY89SiPCpLOEubKkFXJdAWBzcJfgmQ1qOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QygydfWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FB28C2BCB4;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779984582;
	bh=azX+OPVgNWIrCX30lIKaS2K0d90+VU/piOQ7v2TJUhA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QygydfWMufaPDXp9M/RaQVkxaBf1Zca0CHF75TlOd7dy7G06PUSVo4RNZks2O4435
	 ZG85pUR7YD80rmpxoqHG643FXPwLLfemFiI5gofvrNwUov3NIXbqmUQ9aytw/51r73
	 ALlCvC71idYev1wDuxTpxg24/94VFWX0dkpaFVo4Ksa5mffHbMg7V4XJAG+/CJ/a9E
	 WAm64VDK1BZTT475/hKUAfSCCnGKyHjjhAKwXlJvDpLWR1Akbv6OtJDKFp5PHu1HYk
	 QuGYe57rWtIt8GAV6rrG7W0QmlC9dBnG4HC7ptC4Ppv7KISOwtch1c8lXKbV2yRWdL
	 3eu4wD4gkCRdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16437CD6E43;
	Thu, 28 May 2026 16:09:42 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Subject: [PATCH net-next v4 0/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Date: Thu, 28 May 2026 18:09:31 +0200
Message-Id: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALtoGGoC/3XNSwrCMBAG4KuUrI0kk5qmrryHuGjiVAO2laSGi
 PTuDgFBkS5m8c/jmxeLGDxGtq9eLGDy0U8jhXpTMXftxgtyf6bMQIAWtRJ8xJkqz3xIxqDOOXN
 nIwcJUurWdZ02jI7vAXufC3xknxt2osnVx3kKz/IxyTIv+A5gDU+SC+5M01HPOifc4fYYPC1uL
 RYzwbejVx0gRyq0deugtUb9OerbaVYdRQ70yjRod32vf51lWd5otL7LVwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779984580; l=2754;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=azX+OPVgNWIrCX30lIKaS2K0d90+VU/piOQ7v2TJUhA=;
 b=du+g7zchRmKIIXYQiciIuzHsG+OqTKk8LVZFdw6q367JWdPscjXAWYxa6bP6MzmH/gnt6TUxa
 WgL7El05VmqDdqzpRkWs0r/QeEcpDcCdQhHtb7JUKuuPU1mqzmOMTNt
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292759-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,padl.com,kernel.org,gmail.com,luminex.be];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be]
X-Rspamd-Queue-Id: 226F55F5292
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

 drivers/net/dsa/mv88e6xxx/chip.c        | 165 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  21 ++++
 drivers/net/dsa/mv88e6xxx/global2.h     |   3 +
 drivers/net/dsa/mv88e6xxx/global2_avb.c |  21 ++++
 drivers/net/dsa/mv88e6xxx/port.c        |  63 ++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h        |  20 ++++
 net/dsa/tag_dsa.c                       |  11 ++-
 7 files changed, 303 insertions(+), 1 deletion(-)
---
base-commit: 022bdd9c0d036863c4bacd1688b73c6be3001cee
change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



