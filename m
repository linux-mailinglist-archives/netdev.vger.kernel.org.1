Return-Path: <netdev+bounces-218457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF09B3C7E5
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 06:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93FE207848
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584F327602C;
	Sat, 30 Aug 2025 04:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhdIlGs6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFC22B8B6;
	Sat, 30 Aug 2025 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756528325; cv=none; b=hfO10OqMSzkjj9X1nOfFdZxR0uLIFT29i6xAkzn7ZT1cMi5G8qhMAf9nZtV5ZiqTLEBzQy6ILcUvM7qZQzc7wypeJ7UauUJXTi2670jPWlBOBiqRDZHhOuZxtR3yu2Q1m/7l1w2Hek5azaynWUcecwAfqHCmKXgBhAi0DFYHrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756528325; c=relaxed/simple;
	bh=WldPEhUC1d23+BmvEZWoFhEOaqsO0CCDxp7iSglovQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rv8gice1rL0GkmXzpifviT7Ut1+Z63r5T/bMZvLOCeBaXVwLWWm6Yg9mh+s83KBsWZ0n/DZl6dzUZ4dhSUofTQiolQOWc7V9oD2X16ZIIY95i2rQ6JB1BGkrrepuQSKvwE2BrHGYOx8KMG57h73x2+Quh7ursqzDkCb4NbgmhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhdIlGs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9C0DC4CEEB;
	Sat, 30 Aug 2025 04:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756528324;
	bh=WldPEhUC1d23+BmvEZWoFhEOaqsO0CCDxp7iSglovQc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RhdIlGs6n/ZfredTqHW2vfwTdk5GjyJgEytjiogZ+0gQ6UD43yJNPd3AEveqnaYQM
	 TvWknwHeybNQkSeT5/4x5XzKw3ekRbs83ADqK4RGmMCJ4J6oTkxEZjI4XykSI4qGCE
	 LBfZEQdElh37sL1nWa5ncYLNkQKlbsMUSiCbc6WItQZTsp5aQIetcgd0dclySxM4vy
	 kas9/f/5LJlillMRKH/BF0VIU+P72Ind2+JsKm/LH68uD2K/boNUQyp+gBCk85vTSk
	 IE61PhmHknpU8q36pa8sSRGa97LKFTu48Ndgg/aTjpOU165ysiSOBYXwxIyqxdFBu2
	 iNpd38ObiOeKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963A2CA0FFF;
	Sat, 30 Aug 2025 04:32:04 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Subject: [PATCH net-next v3 0/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
Date: Sat, 30 Aug 2025 05:31:45 +0100
Message-Id: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALF+smgC/43OQY7CMAwF0KugrDGkLkFhVnMPxMJJ3KkXTVESF
 RDq3QmVkGCDZvn19Z99V5mTcFY/q7tKPEmWMdbQrlfK9xT/GCTUrFCj0RYR3A6KPwONMAQDKRf
 oJF5ICgLvW3S7YDtjg6rAOXEn1wU/qsgFIl+LOtXGUWZwiaLvn/ir2w4k8bnsJZcx3ZavpmbZ/
 +eBqQENaCyaoK0J3v1SqhJt/Dgsdyd8t+xXC6u1N60+HByT8c2HNc/zA2NsYK47AQAA
X-Change-ID: 20250822-b4-tcp-ao-md5-rst-finwait2-e632b4d8f58d
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>, 
 Salam Noureddine <noureddine@arista.com>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756528313; l=1637;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=WldPEhUC1d23+BmvEZWoFhEOaqsO0CCDxp7iSglovQc=;
 b=ciqtYjJqTISaaN7jCvkPQzW/WDXSWoWLHIBR6o9gMyehRkJlpTuB0IeO8QiheKFfwsRaCNnEu
 f9b4z+mqd8oASdWRf02Z+7AKSEpEywTkcx5YLqxrxhkJvZwUwVEHIaU
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com

On one side a minor/cosmetic issue, especially nowadays when
TCP-AO/TCP-MD5 signature verification failures aren't logged to dmesg.

Yet, I think worth addressing for two reasons:
- unsigned RST gets ignored by the peer and the connection is alive for
  longer (keep-alive interval)
- netstat counters increase and trace events report that trusted BGP peer
  is sending unsigned/incorrectly signed segments, which can ring alarm
  on monitoring.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Changes in v3:
- Assign NULL to md5sig_info before call_rcu() (catched by Eric Dumazet)
- Link to v2: https://lore.kernel.org/r/20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com

Changes in v2:
- Fixed TCP-MD5 ifdeffery (Reported-by: Victor Nogueira)
- Call proper destructor for inet_ipv6 (Reported-by: syzbot@syzkaller.appspotmail.com)
- Link to v1: https://lore.kernel.org/r/20250822-b4-tcp-ao-md5-rst-finwait2-v1-0-25825d085dcb@arista.com

---
Dmitry Safonov (2):
      tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
      tcp: Free TCP-AO/TCP-MD5 info/keys without RCU

 include/net/tcp.h        |  4 ++++
 net/ipv4/tcp.c           | 16 ++++++++++++++++
 net/ipv4/tcp_ao.c        |  5 ++---
 net/ipv4/tcp_ipv4.c      | 37 ++++++++++---------------------------
 net/ipv4/tcp_minisocks.c | 19 +++++--------------
 net/ipv6/tcp_ipv6.c      |  8 ++++++++
 6 files changed, 45 insertions(+), 44 deletions(-)
---
base-commit: 864ecc4a6dade82d3f70eab43dad0e277aa6fc78
change-id: 20250822-b4-tcp-ao-md5-rst-finwait2-e632b4d8f58d

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



