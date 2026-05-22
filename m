Return-Path: <netdev+bounces-290775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJlEBm82EGoaVAYAu9opvQ
	(envelope-from <netdev+bounces-290775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:56:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9FF5B291E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 12:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA3CD30058C6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2653D410D;
	Fri, 22 May 2026 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzdWryNy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395583D3D00;
	Fri, 22 May 2026 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447399; cv=none; b=b1/Q33cIOUXoRXMhAFpTF6WgeMca1OX1a3Aj0/ppCoTjgVg/feX4aoeiaU6GyAvdh9bN2bpU8q1z/DpQNghLSxk/9ZxXutdHoCJl7Jq7v6ePW21TlpXxaIfMe0sbdETZ2/dXq9+C4b6cqum3g3kdg0cNmMnxh6NTbbQYEHaAO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447399; c=relaxed/simple;
	bh=Mr7Hc2ODOulp1s+Oi+BCeb6z+UktMYFDq2MlyfBh6a8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mc7AeQMqS0ijXWyRH1t6azxo5xGX7H4SjIB1NmPIRMhMehZ5m5ppvPctXXH0Vi+WF7Fhg0Sh2U5i4RjBf/436cGCpcwFZvLcd1NnqmDKfv4XVR6OrFlKJhHJlTYR54zhpL40u4YJ8rfaNtshvIBKDsSnc9+jpTBc6jMuHVqAOz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzdWryNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA6FBC2BCB3;
	Fri, 22 May 2026 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779447398;
	bh=Mr7Hc2ODOulp1s+Oi+BCeb6z+UktMYFDq2MlyfBh6a8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=CzdWryNyQL/14F8P96L5BPLrADH422nntcLtNPdxkpqEH1VXkEWGg6pqYGrffRiK/
	 hc09CBZzLKWVuMBoMc9oSWiNeIX8AdIF+I5cQ9f4k0jQu0Pl753AZ4sTpFxvCiBZti
	 zOtnWSuBrmUVi3W4e6z+cdkHYfPyq8lns7qH0+a2N+tVjfICW3//3z2hzXVavK3S0k
	 WUzJBcyKY7bueq3xoWVW3w6l6Qd7HlgioD8nV5iQYs7hxP7vDY52MCvER1ribqWk6c
	 jSRPw66SX4BSsFajm9xpgCSaJaUCqJXVClgFBdOXlSIjokVRjiiJCoO8438BQ0CcVW
	 9eWqfL9oaUYCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E8CD5BB1;
	Fri, 22 May 2026 10:56:38 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
Date: Fri, 22 May 2026 12:56:21 +0200
Message-Id: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFU2EGoC/zWMMQqEMBAAvyJbu5DkJES/Iha5uOoWRklEFsS/G
 wSLKaaYuSBTYsrQVRckOjnzFovouoKw+DgT8lgcjDJWNT+FkY6CHLiezpEVEQz/jEYbrW0bvLc
 OSrwnmljecQ9fA8N9P4k21w1yAAAA
X-Change-ID: 20260430-net-next-mv88e6xxx-cbs-2121169caa68
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779447397; l=1489;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=Mr7Hc2ODOulp1s+Oi+BCeb6z+UktMYFDq2MlyfBh6a8=;
 b=P/LPoeETUB+0eM6OJFiiIXC8w+XDQUqR+Y9v43gk2phBF54tnR8c1T1lXeKGHAy+UZ6fiUOpn
 7bOCdaTWPjXCpEJ/8x63oIw9SvLI+S4P5e4V9OlO5X2CBYCFTVbY2Lf
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290775-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.4:email];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.6:email,0.0.0.7:email,luminex.be:replyto,luminex.be:mid,luminex.be:email,0.0.0.2:email,0.0.0.5:email]
X-Rspamd-Queue-Id: 9F9FF5B291E
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
Cedric Jehasse (2):
      net: dsa: mv88e6xxx: use the hw tx queues
      net: dsa: mv88e6xxx: add support for credit based shaper

 drivers/net/dsa/mv88e6xxx/chip.c        | 137 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  22 +++++
 drivers/net/dsa/mv88e6xxx/global2_avb.c |  21 +++++
 drivers/net/dsa/mv88e6xxx/port.c        |  38 +++++++++
 drivers/net/dsa/mv88e6xxx/port.h        |  16 ++++
 net/dsa/tag_dsa.c                       |   3 +-
 6 files changed, 236 insertions(+), 1 deletion(-)
---
base-commit: 022bdd9c0d036863c4bacd1688b73c6be3001cee
change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



