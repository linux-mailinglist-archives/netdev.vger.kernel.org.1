Return-Path: <netdev+bounces-258280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCqzL/p8jGkcpgAAu9opvQ
	(envelope-from <netdev+bounces-258280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:58:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 584171249C5
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24F3F300558B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5436B061;
	Wed, 11 Feb 2026 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBLhnIkv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B322366DAB
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814710; cv=none; b=PX0xoh5UydrvwJWpHfEKAGbIwFqctaWxn8DSQNqFjiy4cSkDFR82e2awbjJDIqP8fj453awdSF7dCRrvwx7cOZgUnrxZOjnqyQtcjdYYQVllQzQfzWijqDZeUjlug11guq29KU1GIus8o7TNDyFZ/nU9WV3wqSROjl2O0YUHekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814710; c=relaxed/simple;
	bh=7JrXWXOu1Mm0T6X98sQ33rF7YPJqs7a96lckIOQ4alA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GPeYGyTJMIix4DOHIF0iMB7uirDkbCyu9pLxuITsOjJxRsUdeOQxjbEHwiAuD8sZYPXrQEmD3LqQQqOTRKXuI2fyXDo6+MGKpYSh42GtOB5e4uPZVaVYBDM0g32M4aH746jPLPPJLsFFVCT2yIaKyh5Ii7hdh9tCdpB9lmH05VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBLhnIkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0643C4CEF7;
	Wed, 11 Feb 2026 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770814709;
	bh=7JrXWXOu1Mm0T6X98sQ33rF7YPJqs7a96lckIOQ4alA=;
	h=From:Date:Subject:To:Cc:From;
	b=IBLhnIkvbEDdB/sWbXwAn4DAbyRDxTzGhbI/kbqGvFTO5pTPaBEYqYFDw827rfXln
	 a+2e6rdZ798gt2zeyPjJXXuxn0tMZclswYu/aDcIMtgUOtifuI75PX/+mxLAVQm80b
	 Theu+dq3aoxveVGswNa18Z99Ez6EbBLIdwj10UxOxjCS7Xdur3X102qt5NRWaMnGhX
	 w8vfRvy+1CTFqWQkVPQ7wC2cmrvhqByVxkKdiVzskiwkPNvvZ7lVjn9r3N+qw7No6K
	 QCN6mjo3LdrjPhdQUcAp5WcZMFaua4Rc2ji29r1aQrA/tKqr5dr+1AKHBTqtV2/IjM
	 kf79G4xg2TdkA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Feb 2026 13:58:21 +0100
Subject: [PATCH net v2] net: ethernet: xscale: Check for PTP support
 properly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-ixp4xx-fix-ethernet-v2-1-07567f886c8c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQqDMBCFryKz7pSMhohd9R7iQuOoQ4tKIiFFc
 vemHqDL9773c4JnJ+zhUZzgOIiXbc2ivBVgl36dGWXMGkpVGkVkUOKuY8RJIvKxsFv5QD31lRk
 bpay1kJu748yv1RZyALpsLuKPzX2up0AX+jsaCAmbfqgGTWTrmp+vH3jfNzdDl1L6AkeXOvi8A
 AAA
X-Change-ID: 20260116-ixp4xx-fix-ethernet-4fa36d900ccc
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-258280-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 584171249C5
X-Rspamd-Action: no action

In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
unconditionally despite this feature only existing on
ixp46x, leading to the following splat from tcpdump:

root@OpenWrt:~# tcpdump -vv -X -i eth0
(...)
Unable to handle kernel NULL pointer dereference at virtual address
  00000238 when read
(...)
Call trace:
 ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
 ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
 ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
 __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
 __dev_ethtool from dev_ethtool+0x160/0x234
 dev_ethtool from dev_ioctl+0x2cc/0x460
 dev_ioctl from sock_ioctl+0x1ec/0x524
 sock_ioctl from sys_ioctl+0x51c/0xa94
 sys_ioctl from ret_fast_syscall+0x0/0x44
 (...)
Segmentation fault

Check for ixp46x in ixp46x_ptp_find() before trying to set up
PTP to avoid this.

Fixes: 9055a2f59162 ("ixp4xx_eth: make ptp support a platform driver")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Use the correct Fixes-tag.
- Move check to ixp46x_ptp_find() to simplify things.
- Link to v1: https://lore.kernel.org/r/20260116-ixp4xx-fix-ethernet-v1-1-9ab3b411c77e@kernel.org
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 5 +----
 drivers/net/ethernet/xscale/ptp_ixp46x.c | 3 +++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index e1e7f65553e7..b0faa0f1780d 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -403,15 +403,12 @@ static int ixp4xx_hwtstamp_set(struct net_device *netdev,
 	int ret;
 	int ch;
 
-	if (!cpu_is_ixp46x())
-		return -EOPNOTSUPP;
-
 	if (!netif_running(netdev))
 		return -EINVAL;
 
 	ret = ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
 	if (ret)
-		return ret;
+		return -EOPNOTSUPP;
 
 	ch = PORT2CHANNEL(port);
 	regs = port->timesync_regs;
diff --git a/drivers/net/ethernet/xscale/ptp_ixp46x.c b/drivers/net/ethernet/xscale/ptp_ixp46x.c
index 94203eb46e6b..93c64db22a69 100644
--- a/drivers/net/ethernet/xscale/ptp_ixp46x.c
+++ b/drivers/net/ethernet/xscale/ptp_ixp46x.c
@@ -232,6 +232,9 @@ static struct ixp_clock ixp_clock;
 
 int ixp46x_ptp_find(struct ixp46x_ts_regs *__iomem *regs, int *phc_index)
 {
+	if (!cpu_is_ixp46x())
+		return -ENODEV;
+
 	*regs = ixp_clock.regs;
 	*phc_index = ptp_clock_index(ixp_clock.ptp_clock);
 

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260116-ixp4xx-fix-ethernet-4fa36d900ccc

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


