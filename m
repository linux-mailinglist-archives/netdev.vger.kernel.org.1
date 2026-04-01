Return-Path: <netdev+bounces-274249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KZluJ8Z4zWkAeAYAu9opvQ
	(envelope-from <netdev+bounces-274249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 21:57:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FD37FF96
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 21:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B4D93013A46
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008933E374;
	Wed,  1 Apr 2026 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="STdnQ0+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FA224D6
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073474; cv=none; b=M759QuanJzFWPsnP7RaH+vIMwqhO1cnaB8HcHRzGXbD5vAmduFvmRkeQCu7LSLWY+4UVxjgS3TsOHxqIfpCRAOBVppP4uI0OK37U5HeQAkJEpIsNHURzga5gmKlG6145Q8mtn1xUECfz6iYEKLKjDEOX+ktFUkhXZlx+SG31vW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073474; c=relaxed/simple;
	bh=unEbOdgeG11Dld7ycx+4oWww6aKqjFlb3XITUjj8xJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DssbcEkv2kmTgyS8hcu+fzzwrPfVuApgOXceuYMKtwdtZG0V0xbOWMksHjLSCSyZpaFJv2LJWSwmPng3CWLNxn/ExHM7cprkLgv6xJCGvjZV9yNeV8+KHgRRADVlC8xrLMzMGQrBDZGwqGS5C8TDegJMfmoNqKCTbOOppvOCzjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=STdnQ0+l; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12776bebe9fso401889c88.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775073473; x=1775678273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeITYxK34c/QDzcWz7FhrmR9ZS2GxFl1Q0wwk/XvrR0=;
        b=STdnQ0+lWiocYIJyVmuvCHrqzSz+dRo/lEVN1klQ30ZmXgXbjqOdItypPfyMrslnse
         n5wfRZXHt4fcHY8lAfy3UfBaB83h3vftY4vj4fE1OgXwpSycNgZAkmMJSFzRr3LLszxa
         xVKBM2uh+Vz3N7l9gQJve27K0xMU71vasEXpE9EvjWHR0gnAJrfVr+YhiuaICMOELYRm
         aVVNKHNdc9tR1wM10UA5YKQomrudAgDL+DDtycDIyNyCUWxFD65U9H6UfZP5OT9GfUgC
         vDv0P49q/3Z/ot5q66fnTPM1xnKlli+VsDiia+ONNzoLPaqxnsmojLqnSmzZXp5D41U8
         2biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775073473; x=1775678273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeITYxK34c/QDzcWz7FhrmR9ZS2GxFl1Q0wwk/XvrR0=;
        b=qolnQQ0oa6WUGE3pqWiiZGcn/1HkcqP8SmznzAC8NxFAjg8BAEO4WXbrmyNo+7xgPV
         zUa07bBOORb8Xjgc/iHwIrDEdusjCoNwahYF1W2eynKQANcLNGZnIfeWRNAz7MYihnfy
         8WwlbDG9RLVCHqsHJu0nyZG11i4VXVpLB2QbJN+YGTwvo6fnSbHviMZkqtuMskv7JT5l
         xbN6o9mMnNSeMhFDYzJze0J/Ct7qW0qvKarfyCUhnKYWFxzborJXzUh6Zd255MIf9muv
         A5SVe++cZ/s0EzOmOFFun3htklbgizrqVyvhvhCc+i3Eezq4aECyZbJzw0hqqNpM4HX1
         c+/w==
X-Forwarded-Encrypted: i=1; AJvYcCUuYIvrzTvxbmSpuzNcIfFSHZqjivZBuMrmKpou7SUCK2oPnO37kVr8ymFQbmGTB+eUVYAg7D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybE56hbSsyNfA0GScr6paXh3BvTV0BOpw6BQTl2RsjnIPZFrSn
	ZSNV5uLOy7M1fJEcgNKyUCfsD2uyGjIDPjPjVgyjLxblxtbxsdsOCXWCLLIjAg6u1w==
X-Gm-Gg: ATEYQzzKCGmtXvSH8p+i6NISFvu0cBDfsnQ6e7ONeuuLQ58Rd7AY0GeNTAQssKK76zl
	4GcgQaJQ1Q7iVBD6sA9CsMdG7AG7eBWn0l9lRCXM5iCQgpotcJ6u3p+nhLtIjndVHKqO6WOBmpv
	GYdO/tw70gfWs+x3Ita+nYMbFqU32pEbPKiC3STiIy7ubDsG08jXibLHr14W8hrfO0eJ6vZ5T8R
	X0vQ1Nr7ZBdZe6sjoG8JVSVQvGaKb+SmgV3f7G7vf4ADH6VsJb09tfUPkVjq4WG5JcPokxCInC3
	+yewiHsO2mvs2X2AC+zKhqH7QATuGAFMLGhcORu8J6UgqpQYI3AChYDXCG7nZECOlsOePXwZ2+3
	vIk+x68GMxTov31jo9gshWwTkyxMPMfjOBwngnNOiJDuDbTLm5BQPbXpUcI42XFuh84NJaQNOLO
	/tB2U2FVDfpgCIMqPoqfAFrHQ5zCD+3oroZG7QxyIMCs/2HesTDq9mLw==
X-Received: by 2002:a05:7022:fd07:b0:12b:ed30:5b85 with SMTP id a92af1059eb24-12bed305f94mr912158c88.2.1775073472682;
        Wed, 01 Apr 2026 12:57:52 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm1540852c88.0.2026.04.01.12.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:57:52 -0700 (PDT)
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
Subject: [PATCH net] netfilter: nfnetlink_log: initialize nfgenmsg in NLMSG_DONE terminator
Date: Wed,  1 Apr 2026 12:57:35 -0700
Message-ID: <20260401195735.564488-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274249-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: D98FD37FF96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When batching multiple NFLOG messages (inst->qlen > 1), __nfulnl_send()
appends an NLMSG_DONE terminator with sizeof(struct nfgenmsg) payload via
nlmsg_put(), but never initializes the nfgenmsg bytes. The nlmsg_put()
helper only zeroes alignment padding after the payload, not the payload
itself, so four bytes of stale kernel heap data are leaked to userspace
in the NLMSG_DONE message body.

Initialize the nfgenmsg struct after nlmsg_put(), consistent with how
__build_packet_message() populates nfgenmsg for regular NFULNL_MSG_PACKET
messages, to prevent leaking kernel heap data to userspace.

Fixes: 29c5d4afba51 ("[NETFILTER]: nfnetlink_log: fix sending of multipart messages")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/netfilter/nfnetlink_log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index fcbe54940b2e..ad4eaf27590e 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -361,6 +361,7 @@ static void
 __nfulnl_send(struct nfulnl_instance *inst)
 {
 	if (inst->qlen > 1) {
+		struct nfgenmsg *nfmsg;
 		struct nlmsghdr *nlh = nlmsg_put(inst->skb, 0, 0,
 						 NLMSG_DONE,
 						 sizeof(struct nfgenmsg),
@@ -370,6 +371,10 @@ __nfulnl_send(struct nfulnl_instance *inst)
 			kfree_skb(inst->skb);
 			goto out;
 		}
+		nfmsg = nlmsg_data(nlh);
+		nfmsg->nfgen_family = AF_UNSPEC;
+		nfmsg->version = NFNETLINK_V0;
+		nfmsg->res_id = htons(inst->group_num);
 	}
 	nfnetlink_unicast(inst->skb, inst->net, inst->peer_portid);
 out:
-- 
2.43.0


