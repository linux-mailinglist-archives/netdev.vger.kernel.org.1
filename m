Return-Path: <netdev+bounces-218144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9875B3B488
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09127C207A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3AC27A454;
	Fri, 29 Aug 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LxLwQCbT"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BB10F2
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453271; cv=none; b=KzxelZC4piMHD1qQu8tusjF6+wnfrJgp72VbxX6g6tAWIsvMbvvJ6aASUsFlTwbHkbqQdDirU49sZnISf25ZJOuIb2W/NPxZ0A+wfKq24yDeFDtWp+rp9hFmraEWG7MrhwfL9DVd5f0FPwrW6Qq6zCWTRxKXF5LtPKEy0Icz67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453271; c=relaxed/simple;
	bh=L7BuRtA20QsphjS8b3S8zmKwyODYjhGwpe4PV1aMgwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H1QxX4WbILHD/6VoSBZgzfbVYJDT6L7rcfpp68TSetJzJtWcs9nJlLVV+IqhqO3DzN42uJCT7Z4Xg0DkS20L2YLEeRbyy67zCCkI6RL/gY7IosdNgHn/NANlVjKQYxf6M5cWR5Xc4kT7GgZKDoeBZoLuwAKwGfQkDPCKBO6B6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LxLwQCbT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756453267;
	bh=+T+xZjsIONGo79r+XOKR6H4lg9MCiB0GBnxyfV5lUIQ=;
	h=From:Date:Subject:To:Cc;
	b=LxLwQCbT+X8RoBWqNyaB8lecsh5fily+erRrZkpHx8n4fHmdpF9QBR5SXsHHMjtHw
	 w9UwZNY1JfDld1YKKs8Tw/ISWmB1d0xmc133TrCwvzw6KkiVtUS4kBW+mIRqjojknW
	 Tc8Pvtb6zHHl2fNnUiWwyMizJk2iyQOQ1QbUYNHWzr5MAtHKW5OmaLzg4jsWv5hNlK
	 TsLKg3g0TZOekh0clFtR+l6s6n+sTboLcfFEvR4yefVcsa77VcLAJurcp9eKf4RnH1
	 eZIkPpda6gupbeMJX2JCfGmrHBxB/wp0hGOJJpuHq0/AyzZPn7R6yAKCULGqbBr8mN
	 f6HX7Tw+gUwTA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 11DA06F574; Fri, 29 Aug 2025 15:41:07 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 29 Aug 2025 15:40:23 +0800
Subject: [PATCH net] net: mctp: usb: initialise mac header in RX path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mctp-usb-mac-header-v1-1-338ad725e183@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAGZZsWgC/x3MOQqAMBBA0avI1A5o3L2KWGQZdQqjJFGE4N0Nl
 q/4P4Inx+RhzCI4utnzYRPKPAO9SbsSskkGUYim6MWAuw4nXl7hLjVuJA057FTbD7WoaqMWSOX
 paOHnv05gKcD8vh/XMREMagAAAA==
X-Change-ID: 20250829-mctp-usb-mac-header-7b6894234dbf
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

We're not currently setting skb->mac_header on ingress, and the netdev
core rx path expects it. Without it, we'll hit a warning on DEBUG_NETDEV
from commit 1e4033b53db4 ("net: skb_reset_mac_len() must check if
mac_header was set")

Initialise the mac_header to refer to the USB transport header.

Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 775a386d0aca1242e5d3c8a750c1d0825341caa6..36ccc53b17975912c7d310fe8d58eb91fe482732 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -183,6 +183,7 @@ static void mctp_usb_in_complete(struct urb *urb)
 		struct mctp_usb_hdr *hdr;
 		u8 pkt_len; /* length of MCTP packet, no USB header */
 
+		skb_reset_mac_header(skb);
 		hdr = skb_pull_data(skb, sizeof(*hdr));
 		if (!hdr)
 			break;

---
base-commit: 007a5ffadc4fd51739527f1503b7cf048f31c413
change-id: 20250829-mctp-usb-mac-header-7b6894234dbf

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


