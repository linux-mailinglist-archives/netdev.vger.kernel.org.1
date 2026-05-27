Return-Path: <netdev+bounces-292261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CkGBWLfFmo9uQcAu9opvQ
	(envelope-from <netdev+bounces-292261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:11:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8870B5E3E6A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E729B301FD5C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FC22F8E97;
	Wed, 27 May 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jZWvbcfR"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645A1AB6F1
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883784; cv=none; b=PP79Oic57sbZiieroJmaW6/r07LJB3UNMgV7UXhB0gshEHcRrxpJKNVjmH+FpGZah4pTFudWT9Il3R1nZyX5V1Gs3ve2UEuuUHb0cc0M0urJfCqZmDe/ULBoW3zSwVMaXx8H+hwQVcZ1ZVEdvWqFAsJCJ63//FA7EHxZPzdW7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883784; c=relaxed/simple;
	bh=pJcavlr6cIAvc6Ufkk7qo6jwSezY3eYcjkN5yDspN00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lvTe0DOZjzoFCGjNIQw3qb4gxbOYc78j6a8aH9C5bSYxQjak/fZjdJaOTi7ldy2qRLKLSzO+Fd5PbFauGkzKD7HXS4WCKyB1seYJ8VGacMzG110L8C6T8obGMN1uOJ/I7az6zbOhleIalA+OMTYDqvsHQq9TFzMAUAjPVI9hyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jZWvbcfR; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779883777; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XQSbr4FcJ1csOTjVDrtsHlmJ/goV/U5cW0bMEaJtl54=;
	b=jZWvbcfRk+LlfJFsvxI7/zXdLiBYOKagQJ3SpGlMGIg1oJHS1+AR6/VeSpWHMhGxWLEcypu4/io0cZh9loK7xVEIlxQ1ItvGrGbh3RfGhyWrJKByQoBK0wrFxSf3T99k/mFSrJbiS0LCAKbBDfoeMyyzn0IJKhK5aeExogx8APo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X3jgB1R_1779883776;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X3jgB1R_1779883776 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 20:09:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net] net: remove SIOCSHWTSTAMP and SIOCGHWTSTAMP from ndo_eth_ioctl comment
Date: Wed, 27 May 2026 20:09:36 +0800
Message-Id: <20260527120936.24169-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ae175eec4521
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292261-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 8870B5E3E6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 4ee58e1e5680 ("net: promote SIOCSHWTSTAMP and SIOCGHWTSTAMP
ioctls to dedicated handlers"), SIOCSHWTSTAMP and SIOCGHWTSTAMP are no
longer dispatched through dev_eth_ioctl() / ndo_eth_ioctl(). They are
now handled by their own dedicated functions dev_set_hwtstamp() and
dev_get_hwtstamp() in the ioctl path.

However, the comment describing ndo_eth_ioctl in netdevice.h still
lists these two ioctls, which is misleading for driver developers who
may incorrectly assume they need to handle hardware timestamping
commands in their ndo_eth_ioctl implementation.

Remove the stale references from the comment to accurately reflect that
ndo_eth_ioctl only handles SIOCGMIIPHY, SIOCGMIIREG and SIOCSMIIREG.

Fixes: 4ee58e1e5680 ("net: promote SIOCSHWTSTAMP and SIOCGHWTSTAMP ioctls to dedicated handlers")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bf3dd9b2c1a7..7309467d7873 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1149,8 +1149,8 @@ struct netdev_net_notifier {
  *	SIOCBONDSLAVEINFOQUERY, and SIOCBONDINFOQUERY
  *
  * * int (*ndo_eth_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
- *	Called for ethernet specific ioctls: SIOCGMIIPHY, SIOCGMIIREG,
- *	SIOCSMIIREG, SIOCSHWTSTAMP and SIOCGHWTSTAMP.
+ *	Called for ethernet specific ioctls: SIOCGMIIPHY, SIOCGMIIREG and
+ *	SIOCSMIIREG.
  *
  * int (*ndo_set_config)(struct net_device *dev, struct ifmap *map);
  *	Used to set network devices bus interface parameters. This interface
-- 
2.32.0.3.g01195cf9f


