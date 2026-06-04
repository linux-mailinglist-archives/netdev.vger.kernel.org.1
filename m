Return-Path: <netdev+bounces-295099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sSFCCEU5IWp4BQEAu9opvQ
	(envelope-from <netdev+bounces-295099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C663E0B6
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:37:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=lRD4rZXD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295099-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295099-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0DF330142B9
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095A39D3F1;
	Thu,  4 Jun 2026 08:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14C34D3B0;
	Thu,  4 Jun 2026 08:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561821; cv=none; b=B3xxmwasc6MtLAFdf5eW5MjnImCQoXBomQW/dIVqVkuWmo5saN8w8LoQJMrM/RFeKvDD43GH50NhPufSUTDDiFOXqMmfaZsrqMgA62aSTWxEAS7Yt99Ou2YcJucgq2k4NNXNKI7RrUtGVTdGwmhPQQ1QlVcLkyBIC6CExOigWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561821; c=relaxed/simple;
	bh=bGDZ2KmYMu8TPrWbvyodp+cEnNoB47xZ8xSbg/l4UNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fa2LzBQX9FeiVmFt3TwTwifT30N2ATXD4DkEGzx6uuy0mTs1HdbmWpga8qS0DresKnwOKRVNAbEb5V98PCDikYe6bhgLKaLsCyyBqNUtPfAUWHjLyseJmYLDQD4rvQXK0o3Hp8eKXWTo73nq3Nj4/QluUC1eUyR8upoLETH0lDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRD4rZXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 612B5C2BCB9;
	Thu,  4 Jun 2026 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780561821;
	bh=bGDZ2KmYMu8TPrWbvyodp+cEnNoB47xZ8xSbg/l4UNA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lRD4rZXDVde4KhqpCT0RBcKEjzGT8mVIGNpr2JDx/LgjTr4v9nMw85VikBLmD4NNq
	 XJ9MjKJA+lsxq1rVdYHO/sI9ao7Cl9bfllVlIkBzGQTut77nONzaKbUBbOIGVDD5xb
	 rw/jnDfC+gk2xmT2F+rusK3TvmxhRxqiwrL+IclLWo87h0i2JXnABQkJ6Cqvtt5PCl
	 tylYMk8jg/oyT5Sfpru5MTWF9M0yG0M2hR9sGWWrwPMynW///kqce0i7CfhnS1YP+k
	 9/pkBTgIkWBQhxuHXA52an5KELOwKPhLJxcLNrmZGXPfRR/1+T8wF+Vz0yIx4XBzPx
	 Y/aGDrFlXUg6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A9FCD6E57;
	Thu,  4 Jun 2026 08:30:21 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
Date: Thu, 04 Jun 2026 10:30:13 +0200
Message-Id: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJY3IWoC/23NOw7DIBAE0KtYWwdpwQaDrxK5MLBOKPwJOBZSl
 LuHfKsUW4xGO+8GiWKgBF11g0h7SGGZS+CHCtx5mE/Egi8ZBAqFCms201Yub2zatSaVc2arW9k
 aw8JkK4UbhtYIZaEsrJHGkF/rR/g+Qv9uIl2uhds+9U/rqpfV1PjPcjYxwQXnyhRJ6W6XT8kOi
 ZhbpilsXYXGNMJ78s4ahaOhVo9e85ZcXY8SuefYoJMW+vv9AYgTS/sBAQAA
X-Change-ID: 20260603-net-next-mv88e6xxx-pcp-prio-5752caa7926b
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>, Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780561819; l=2032;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=bGDZ2KmYMu8TPrWbvyodp+cEnNoB47xZ8xSbg/l4UNA=;
 b=Pkc1VjKFsVN4zwDEY/02NcavPpe08EC0GqN9rrjLAWxSbSY8Br3Kf/GmPvMdEcmv4fTDTrkIE
 Bit53QYOoWfBUNvr3AjMZBVJVqZYfQwGg7sTHSiUNTNAXqupyRfdq67
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295099-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,padl.com,gmail.com,luminex.be];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D3C663E0B6

This patch series adds support for dcb pcp app to the mv88e6xxx
driver. The pcp app is there to configure pcp based queue
classification.

In the Marvell switches this is done by configuring the IEEE PRI Mapping
table. There are different hardware implementations of this table
depending on the switch:
* a global table
* the 6390 has one table per port
* the 6393 has one table for DEI=0, and another table for DEI=1 per port

For this the DSA framework needs to be extended. The implementation for
pcp-prio in the DSA framework is very similar to existing dcsp-prio
implementation.

There's another patch series [1] on the mailing list that uses the same
IEEE PRI Mapping table to implement MPQRIO. To me the dcb pcp app feels
like the natural way to configure the pcp to QPri mappings in the
switch.

[1] https://lore.kernel.org/netdev/20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com/

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
Cedric Jehasse (2):
      net: dsa: add support for dcb pcp app
      net: dsa: mv88e6xxx: add support for dcb pcp app

 drivers/net/dsa/mv88e6xxx/Makefile |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c   |  36 ++++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  17 +++
 drivers/net/dsa/mv88e6xxx/dcb.c    | 229 +++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/dcb.h    |  21 ++++
 drivers/net/dsa/mv88e6xxx/port.c   |  28 ++++-
 drivers/net/dsa/mv88e6xxx/port.h   |   8 ++
 include/net/dsa.h                  |  10 ++
 net/dsa/user.c                     | 126 ++++++++++++++++++--
 9 files changed, 467 insertions(+), 9 deletions(-)
---
base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
change-id: 20260603-net-next-mv88e6xxx-pcp-prio-5752caa7926b
prerequisite-change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68:v5
prerequisite-patch-id: 8ad59c43368d4639e0cabcc59a7f6e487560d3f7
prerequisite-patch-id: 88ee88bf34ac3631056bc92c6c6251c29cf7223c

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



