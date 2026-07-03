Return-Path: <netdev+bounces-304413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cGboJ4NnR2ojXwAAu9opvQ
	(envelope-from <netdev+bounces-304413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:40:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E946FFA56
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:40:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ugreen.com header.s=pkvm2402 header.b=PVa6QyZZ;
	dmarc=pass (policy=none) header.from=ugreen.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304413-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304413-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C0AD300868C
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455A35E94E;
	Fri,  3 Jul 2026 07:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35239344D9D;
	Fri,  3 Jul 2026 07:40:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064422; cv=none; b=E+GaCjLRUghMI9Svyz7z2k2gcU5nOoYH1NzLPztmyhwckoXPqbXy+wSus/nnQrJmKduwxsUPFd/P/Hs06yCzTEp17vBsfCQXN9JS4imj4Ka3tBuphZQvMlqPCBV0B46CSWeWowZJPw15kYRRLZcAsAg1/Ev+gdcqSXkBrIVShyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064422; c=relaxed/simple;
	bh=/j5QKa5a42hpwXjlK0+xiXYqS/TjeX5QSZyYY2qzhic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kE96FBnDYxqFiFLOfo2hI1MDkJKyutMCVGqz6MFLLvBBqW052eDYNmJGIlDuV7T7ppNKHaEIyY4BWwXodDSw1hkWmiPkdobSsTfB/OsWJBWKqo35eM4qjAYHj2mOQiFLHt89A79usTPqBScnBhNmyITtftXgLzW+v/zr/2rXEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com; spf=pass smtp.mailfrom=ugreen.com; dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b=PVa6QyZZ; arc=none smtp.client-ip=54.207.22.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1783064396;
	bh=NKFOf46eVmeGr5qC2Q6DRjQ0t0abDc8lrwh59/fJJbo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=PVa6QyZZwbQqM0NJ3PEdnNg20/glReEoz61/FLKZ1MpupLGHhSHFvEFrTxFuIbHRt
	 ZKGf0kMCnu+DHJDJTG00O6dqwwCTmpn089oJTc48d0OP8cGxZsyOEpx81rLW1ZPVaG
	 CRmOPUVo1THlOjv2UAKMOaDzPAO8dHeixtVpZNrQ=
X-QQ-mid: esmtpgz13t1783064392t03d3e1e8
X-QQ-Originating-IP: Yu2uLObz51XsQIdBMiFmhIGN14vHEQGmz72VlPaufIY=
Received: from exmail.qq.com ( [103.17.240.69])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Jul 2026 15:39:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14934850749113018607
EX-QQ-RecipientCnt: 4
From: Hanson Wang <hanson.wang@ugreen.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	oneukum@suse.com,
	Hanson Wang <hanson.wang@ugreen.com>
Subject: [PATCH 1/1] net: usb: aqc111: fix set_mac_address return value for bonding
Date: Fri,  3 Jul 2026 15:39:36 +0800
Message-Id: <20260703073936.462231-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MBlb9jzPUvXQpk6ffg4rqAIn1G0/1Ufa/rSgGHlQeyEsdcrp7D5GnmCn
	3ZYJa1cE3kYgXJOg7DOjev1bnJwA7+S2LgTFxUFWD2F6N5PHOFzNLwtaptbA+39DF4/L3ax
	0yNEbTgXriKqANJDNG+v35tCQKOr63E0Jhxpk4sveYqTYHK3wp5Xjynvre0gkDaiojvYGXk
	I6fY8wvhlF3zcWIcXXriRJquxuP7B9qQ0ang0zBsgjI7GJI/ClpMfOSARFdyynkwnk+4tFs
	BGpw4WOlmBHogSgNH3ofI9ZKGary2K8mA2hOTDDVL+BqLoLTQ8dMB7xNYQxCXiurqYHVO2w
	PFd9nQw2VpcbgmUqvrUCqE677EK1TMMvQy0o3eHPd2el+uG3CleJoYwCNPY/+vYWAX7WEU4
	JGhI5Cv1kssRIK/BAr8IbEmLbWY4LdtiwAZ+m4eCy2CHbwpeuhgzNDtv4i9hwm4w7y7y4aL
	sPzB702+iLwEJtu+G6Bb1CroJaEIHqd36Fn1jPRfV0OUPjSMVCh3U5oEj+ECwSfqesZwaTk
	BOQ0JYir5Hr/i2OzMMja4cNlen4c0fl512jI3EszJ64zsLOUvDadO0rTLcyxGWjiDYcZPEx
	EKh1JnzFgEKitRZDGhHTGDTrBnJVOwPP0kq95A6OCOjhc+vQywMxrx2Eo2xrWdQ2hC/eodA
	rRNnRm8e6tzeiKlxd8a5LLuPulswcUNrbdY1gcCAtWh7h0sUfjHjX3OACMfzuy7GdectFAf
	Di7ghyFCjTo2HcvdNHR6xYVkbqq+EXo+2/FsqhKify76fXV2vrHXjh7+NvgqsIlP4vnPRZv
	wjKzCQDqFOFfPBzjDDfzexjTjO+ZemLv1EbgFLxdiTJX2GrNiiEOnuddrM5KPiJEGNXpeTz
	wjQ4aVlCC8xOBsrHP5YsHIN1ExR6XgxW8NoacRLjaA3DvuV5BUY26wkBx70sszbFITC7FoE
	C9Ocy8jH2Sv3DmlIJwE28qzd7kB5ti2KmmPL6Jq57Cyb59bUb3NtqmPeyn0CoanCXK5l0OZ
	VqR+bjepUkST2pKEEOzVNK8WXcoUjGvkmNA2gmNom8qHiooSW96QMFLfhiq9I=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ugreen.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ugreen.com:s=pkvm2402];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304413-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:oneukum@suse.com,m:hanson.wang@ugreen.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hanson.wang@ugreen.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanson.wang@ugreen.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ugreen.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ugreen.com:from_mime,ugreen.com:email,ugreen.com:mid,ugreen.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99E946FFA56

aqc111_set_mac_addr() returns the result of aqc111_write_cmd() on
success. That function wraps usb_control_msg(), which returns the
number of bytes transferred (6 for ETH_ALEN) rather than zero.

Bonding calls ndo_set_mac_address() when enslaving an interface and
treats any non-zero return value as failure.

Return 0 on success and propagate negative error codes on failure.

Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
 drivers/net/usb/aqc111.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index dd53f413c38f..da5b74637ee2 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -471,8 +471,12 @@ static int aqc111_set_mac_addr(struct net_device *net, void *p)
 		return ret;
 
 	/* Set the MAC address */
-	return aqc111_write_cmd(dev, AQ_ACCESS_MAC, SFR_NODE_ID, ETH_ALEN,
-				ETH_ALEN, net->dev_addr);
+	ret = aqc111_write_cmd(dev, AQ_ACCESS_MAC, SFR_NODE_ID, ETH_ALEN,
+			        ETH_ALEN, net->dev_addr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int aqc111_vlan_rx_kill_vid(struct net_device *net,
-- 
2.34.1


