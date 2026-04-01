Return-Path: <netdev+bounces-274261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2InBHWuMzWlfewYAu9opvQ
	(envelope-from <netdev+bounces-274261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:21:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B45D380912
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B88430225E7
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B403603CA;
	Wed,  1 Apr 2026 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Mg6TteOv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EB378D92
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078479; cv=none; b=iGcvj6QRfnth1KeOlT3GUiwi4yQur/Vll4PUNUcLdXfg18j+a28JmCAUUuo7R7T1nK4/Bt1dQcYKjIFclJbuchV2gkeSa0xbTMwh+lggnacisSN51ojGxeiKU/cIh+nOTL0F7HXhf7wSHkJ0m87y1mq5WP5hQmt1p9nLE2N+luw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078479; c=relaxed/simple;
	bh=ceiUWFuE6/YmjPbAR+dTCdL3AyF7U/F+ps+er5MNyl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IprWVw7hHLuOVvXOzKy3R10F1YvZgPJrccIiD7repqU03pb+qZvkS0guGwKtShY7x5qLlTCA5P1GCK4g/SXrJiAeQYSdJAwffVs6y3YzqcaiyuGjJ2O05d3H/n0MSHMaapb1VSLYlfTkowhNgdP4qX32yKVf9AfJ4U50lbrutWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Mg6TteOv; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c1632faeb9so493918eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775078477; x=1775683277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj7P4G0mBP6nG/9FnTYA1QuSPTWr/jns+CKVmZY9R/U=;
        b=Mg6TteOvkj/yTagOYA70ENvVsvilvyE7knDqiG1cIrghyWKkqo5OlZiQdyuWHYAMMr
         un+Hob1rh4BU7UikzHeZJLLOlvvi08Djf2GXm2RfWPTm1Gz+3242ylGJGaqKxfKAqSma
         4gxSL4oDipPv/X1guF/LTqdzjrwN9FUCrMhMhDErXjcTQqGXxfQ1lIj6NHfpfXIN2ivc
         QLMqvK6zdQn6s7sjw46wEfPP4CTVHDSDNxUPonEF/doMlCJJZMkqvRJdy28W0gfjPEp0
         PGMTwyNAvBaWY2W+2uRXu17t5e7KXcjWPn7zJmMAnnJ02Xe8eNgLBH7pstHX4OChcM86
         A1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078477; x=1775683277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj7P4G0mBP6nG/9FnTYA1QuSPTWr/jns+CKVmZY9R/U=;
        b=oHpoom0rLe4vStvV0Wiq+rWivFIP8unn4D1W6DK3mDUPbMUObwIMlPFakPjOlA9v1O
         o1CzQpd0Pc/dGxp/Sw43Tlgkk6gzaKHMXreLNVGsbMJgiXYyxtsWh8ybhWNm+2873arW
         /74Ms4Pdw8yiOUOgkX2hQFleWO1ho6yZLXclEhdQkWhpHRZSXEi+fLnJOT8MqS4306iX
         iEsuY2XnVxY4+YNQfLF7RHLRIhtHHDgUyAis0Pcdhu7vzoJ1Sswvz8wELRw4elHRPalx
         FmbLV6u75tYcFikHh638V+gbnY1AGW0y9Th0HPxYVCtckftUKtocNXQHbX8jIhJHzdRO
         7WKw==
X-Forwarded-Encrypted: i=1; AJvYcCUkfKpihc6EEGX/SfRqqJNbn60CAhccdRDhAajF5Tbv3daf7CdycqZc3OP3Vbs6I80x5sKADb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyacLVrp9C9zHIEPuKgGtn8Bvl9NjFoeYlnj2fYdyX1BO5Bgt86
	W4cAdV5xNmwqbRDR4viRJqMk6IGe7lXmkRAbE4Zam4s7lBWva1Odt0bRnu/81jWUeQ==
X-Gm-Gg: ATEYQzxODDmkFIva3oOWCpbNKAcfyprXGl9xM7alC8bDw12PKNrefL38pxLPYdiq6DV
	Z/pLrGQ19dI8oBCbbXBwnO4BvK9kf69am0oTwZtwUotCi5sWzV+Trg7nJvao9xBLgx1s5YQuvhY
	mZBQScpR8XfZbs24A1LHdMhSpcu5iVSOyFN3qRegtSlXQGr6UDyF6yEW+Egj61IDl0pe0JkZ2Rv
	oD/QpShIIloIYIhtaNADnU30Y5lFwUj2pMPd6/ZDqFuNHoGJnAJXSUbCETKcKXxKG7iBoEYshAH
	78APOljsrSwraoCoBI3E6GLtBFeNm3e9i5fa1w67x5y2OLv7GWbInDqlEodqGZpH1+AaHFDr1cB
	8LdM7kgn7hih20NdVs610cAJ8u8QWt88VabRsSPvFJqJ98Rlw8oHCK2E3/GuvMRsiDVi3C2zuJr
	9ZTmcKxZNi3kASFF0+4Cc4h364x5D6RRK+mklGl1F5J/HIEdyQGhwLAA==
X-Received: by 2002:a05:7301:4188:b0:2c5:347:e642 with SMTP id 5a478bee46e88-2c932eae777mr3121226eec.33.1775078476962;
        Wed, 01 Apr 2026 14:21:16 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c7f268esm690144eec.20.2026.04.01.14.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 14:21:16 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	eric@inl.fr,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2] netfilter: nfnetlink_log: initialize nfgenmsg in NLMSG_DONE terminator
Date: Wed,  1 Apr 2026 14:20:57 -0700
Message-ID: <20260401212057.773357-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274261-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,inl.fr,vger.kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: 1B45D380912
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When batching multiple NFLOG messages (inst->qlen > 1), __nfulnl_send()
appends an NLMSG_DONE terminator with sizeof(struct nfgenmsg) payload via
nlmsg_put(), but never initializes the nfgenmsg bytes. The nlmsg_put()
helper only zeroes alignment padding after the payload, not the payload
itself, so four bytes of stale kernel heap data are leaked to userspace
in the NLMSG_DONE message body.

Use nfnl_msg_put() to build the NLMSG_DONE terminator, which initializes
the nfgenmsg payload via nfnl_fill_hdr(), consistent with how
__build_packet_message() already constructs NFULNL_MSG_PACKET headers.

Fixes: 29c5d4afba51 ("[NETFILTER]: nfnetlink_log: fix sending of multipart messages")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: use nfnl_msg_put to init

 net/netfilter/nfnetlink_log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index fcbe54940b2e..66ff23c444a6 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -361,10 +361,10 @@ static void
 __nfulnl_send(struct nfulnl_instance *inst)
 {
 	if (inst->qlen > 1) {
-		struct nlmsghdr *nlh = nlmsg_put(inst->skb, 0, 0,
-						 NLMSG_DONE,
-						 sizeof(struct nfgenmsg),
-						 0);
+		struct nlmsghdr *nlh = nfnl_msg_put(inst->skb, 0, 0,
+						    NLMSG_DONE, 0,
+						    AF_UNSPEC, NFNETLINK_V0,
+						    htons(inst->group_num));
 		if (WARN_ONCE(!nlh, "bad nlskb size: %u, tailroom %d\n",
 			      inst->skb->len, skb_tailroom(inst->skb))) {
 			kfree_skb(inst->skb);
-- 
2.43.0


