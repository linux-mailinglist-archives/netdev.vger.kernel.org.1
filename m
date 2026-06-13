Return-Path: <netdev+bounces-298972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SRQjH1xzLWrUgQQAu9opvQ
	(envelope-from <netdev+bounces-298972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:12:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624C67EE08
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:12:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=l60OYMv2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298972-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298972-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 801A330058F0
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCE331A66;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD26279DC9;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363543; cv=none; b=M1ErPL/ES4tpUYkxR2+zEh+68Tx32HpgasRgRRZXQ0qIi3c5lQMxb8mKMNl6vwiBx96WzK5p1o5ma5IrALZEA0F8JlZmdf7LOoLnVd3wkKdf45CCTGkWT3gvrPxhVUzj8RjUgMFDzMOMGnhG0cOiK6uef68exlbm+Dakw5EZ4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363543; c=relaxed/simple;
	bh=7wuzSeV0qr+p1aiw4dVV8bfGRO/5vafsYwhfMCePCe4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V9PxYdu1EQ/XHUXCT+Gv48iv3E+Mx6Z0kDKi4PvXH7XKzasoEHrevri5cR12eBULJfApNSMvBbE2L+giUZj7G+mcUrKb65jUW6Q1Y3nEDPSdYtaatFIMpWJyq/G07SZ5rSvMb78yEGJUuV+3N0zwbts8+QDs3MMAzIaS30xnNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l60OYMv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E72AC19425;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781363543;
	bh=7wuzSeV0qr+p1aiw4dVV8bfGRO/5vafsYwhfMCePCe4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l60OYMv28eV+VN3J/wr45WE7Q5saAWR4+jHoyw3inE7cQfyEg0JYa3bgY9W7Vcwqx
	 diAbvMztGm7Pz9RJr3pHsG26b7+o1rrNwM1WRsC+FOZyZEVBM+AxMyEfH4D/JNKJ1j
	 pafkwWIya57TJHF/qtZ7CgW9jhFx3+TcKl5YmJvzamqoiLgcJNK0L8uVcLjz07SncO
	 ib+7BSYUpVSfz1nr/nszX+XgG9jxgpuLKyBleYKvkX65vbXDEKiHZm9NQDXqupuSyW
	 grDNlRQM0v+d4CqpX9usKP94JeqtbRz8ee73nsbboDImh0vBeHQhSYCof+ecBy4NHK
	 9p/cW9qC8JAag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E846CCD98D8;
	Sat, 13 Jun 2026 15:12:22 +0000 (UTC)
From: Laika Price via B4 Relay <devnull+laikabcprice.gmail.com@kernel.org>
Subject: [PATCH net v2 0/2] ip_tunnel: fix PMTU ICMP reply routing
Date: Sat, 13 Jun 2026 16:12:16 +0100
Message-Id: <20260613-master-v2-0-061b70fd45dd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQ7CIBAFf6XZsxhAQ8WT/2F6oLBt19jSABJN0
 3+X1qPHSebNWyBiIIxwrRYImCmSnwrIQwV2MFOPjFxhkFwqrsSJjSYmDMxIrYVSreZKQ5HngB2
 999C9+XF8tQ+0aVtvxkAx+fDZn7LYvL9oFkww19Va4QWlq8+3fjT0PFo/QrOu6xcFn+wNrgAAA
 A==
X-Change-ID: 20260613-master-a299166b9069
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Laika Price <laikabcprice@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781363541; l=1026;
 i=laikabcprice@gmail.com; s=20260613; h=from:subject:message-id;
 bh=LedJ39BQchjQxS/5EHaqWA5pNnfquMEPobE2MJNmYB8=;
 b=LVcIebVR00z6R4p8iujA6Ffn7Eyt9ylqp9uAu6KtwdUZavaUnhQxaCVR4kJGoDUKbhmLrnTv+
 43OXDxvCGDAASkchl1qKY6PDPxosYWIA5BCkh6ry/qhLr/9k6Qom3Qj
X-Developer-Key: i=laikabcprice@gmail.com; a=ed25519;
 pk=mFSMw2odvyxt1H4QHAdwZVuwHduNzUMDKbWFOcwhDCg=
X-Endpoint-Received: by B4 Relay for laikabcprice@gmail.com/20260613 with
 auth_id=819
X-Original-From: Laika Price <laikabcprice@gmail.com>
Reply-To: laikabcprice@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:laikabcprice@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298972-lists,netdev=lfdr.de,laikabcprice.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[laikabcprice@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1624C67EE08



---
Changes in v2:
- Fix incorrect PMTU exceptions test
- Link to v1: https://patch.msgid.link/20260613-master-v1-1-df796e8e2d74@gmail.com

To: David Ahern <dsahern@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Laika Price (2):
      [net] ip_tunnel: drop stale dst from generated PMTU ICMP replies
      [net] selftests: pmtu: fix incorrect PMTU exception generation

 net/ipv4/ip_tunnel_core.c           | 2 ++
 tools/testing/selftests/net/pmtu.sh | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 2a2974b5145cdf2f4db134be1a2157e9ca4a1cf0
change-id: 20260613-master-a299166b9069

Best regards,
--  
Laika Price <laikabcprice@gmail.com>



