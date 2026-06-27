Return-Path: <netdev+bounces-302316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l/2GNpyXP2oiUwkAu9opvQ
	(envelope-from <netdev+bounces-302316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 11:27:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4656D18FA
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 11:27:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=cWf7OYzZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302316-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACB4D300B088
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD81396D28;
	Sat, 27 Jun 2026 09:27:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74682F7EF4;
	Sat, 27 Jun 2026 09:27:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552458; cv=none; b=A0G/k0qxvTHQFy+imkJBjnCX3F0SjTXBxCNCjn0dNT/8nCGWvSvP0pz9i6Cn98jSes86KThf7k2yZy5SHbjjXm7lV0dgi0YC07lNNk0SnQtFTWvyCmE8S6zu18IBeTT5DOYEY8mr+rT4kR/ebMva0j6IkDreY6OQION3nT4ySPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552458; c=relaxed/simple;
	bh=2sksE9mrMTwqXS27DmqRUSUAaLxtRQqcOObEDQV4qUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kgHvSNFucLDgLYA64rltidsUHHcT3BHrtM09aThR4GPjQ54kK6dpZ8mP473oUvH9qufphC6obbQVWjoIcuDYGQMHN0VxJLcRFxdFqCk7jyKSsIh57VvoI+p25+V52PcJ6ydlpTIc59fPNN0sZJh5ogn+o6y14mUN8xM+ZYJOD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cWf7OYzZ; arc=none smtp.client-ip=101.71.155.101
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fdf9cd8;
	Sat, 27 Jun 2026 17:22:19 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: sam@mendozajonas.com,
	fercerpav@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [RFC PATCH net 0/2] net/ncsi: tighten RCU-list lifetime handling
Date: Sat, 27 Jun 2026 17:22:12 +0800
Message-Id: <20260627092214.373480-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f0863166c03a1kunmb5b491adc8be8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCThpLVktNQkxDSU9JGkgeHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cWf7OYzZu2t3M2LOexcXhflsehnsV7nTYzbkktRM0o+/hGk9QwercykJXgmARVtjIYsrSppqbH71r655BSH/ir7danpCjCXsLtwZ6K+D9IF2atJ6Yb1gvawPhxK9miOwSsV3h3cO9cMS//t5TzH8ufe4yD8jpCO72h+xk6cLFsg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=1NTtOf8NoGC+0DDLouyTbE8AK+VOvoODnH2UcTV8FJA=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sam@mendozajonas.com,m:fercerpav@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC4656D18FA

Hi,

This small RFC series addresses two NCSI RCU-list lifetime issues.

The candidates were found by our static analysis tool and then manually
reviewed against the current tree. CONFIG_PROVE_RCU_LIST was used as
target-matched triage evidence; the RFC patches below are based on the
source-level lifetime review rather than on the dynamic warning alone.

Patch 1 defers freeing VLAN filter entries removed with list_del_rcu().
The NCSI configuration workqueue is a real RCU reader of the same list
in set_one_vid(), so RTNL serialization of VLAN add/delete callbacks is
not enough to protect that reader.

Patch 2 moves the existing NCSI device workqueue shutdown before
package/channel teardown and clears channel_queue while the channel
objects are still alive. Current trees already disable the work item
before freeing ndp itself, but still free channels before
disable_work_sync(). NCSI work can walk the package/channel lists and
channel_queue during that window.

I am sending this as RFC because I have not tested it on NCSI hardware,
and maintainers should confirm whether additional request timer
cancellation or RCU-delayed package/channel release is desirable for the
unregister path.

The patches intentionally do not claim a standalone exploitable UAF. The
evidence is a source-level lifetime risk plus target-matched
CONFIG_PROVE_RCU_LIST warnings for the affected NCSI helpers.

Runyu Xiao (2):
  net/ncsi: defer freeing VLAN filter entries after RCU removal
  net/ncsi: stop device work before freeing channels

 net/ncsi/internal.h    |  1 +
 net/ncsi/ncsi-manage.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1

