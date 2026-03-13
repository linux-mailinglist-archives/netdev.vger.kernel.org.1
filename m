Return-Path: <netdev+bounces-267552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM3ADMBRtGk4kAAAu9opvQ
	(envelope-from <netdev+bounces-267552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:04:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B162887B8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83AA83060CF9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4F3DA7C6;
	Fri, 13 Mar 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkBQYwHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D63DA5B3
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424900; cv=none; b=mGZnyOO80iKIH5avDBiYKH869O8VTGfKS5VtuM49qMs6KAKepQ0H4MnnA33f781Ta9TS2oIPgx3MSd4b0KyPl5buHYZwPFbadOMS9bF8ciaS0w53exWI3Ck6UVOR9fHwtNqHYzZlhjA8InLS1Iz2Zik+zm3QnMxae48AIzL4FlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424900; c=relaxed/simple;
	bh=MWXEFQ381SLQSXiwYPD6PgTvLJBhNSUHPAJpUG638dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgoXSe+r7vH3KTYORj+VR19pDr6sAH/VlUCs/QRPcHu/31C3pEZc1t0mE/UWcDcmRO8NoP3g8IHoREoj8ZIvFmieDqV4yjhA6EucAZkt0CXhF4+AcawbOQYq8mr2Z8cEQBtXkislU/11vd1PwKHzgXzqDq2J3iROjI/ZBdrh2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkBQYwHq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79628fb5c05so20889127b3.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773424899; x=1774029699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDVR6LO95DY7vyobG5JaDyJauzh65mLzZY7eX52aAWM=;
        b=IkBQYwHqaHSHPu+6JjTmwo+VWeLZUhwwGliyMuoa2dHFK9guFuF80n6s6Q681+14Ni
         t986a79tnycPyxYSgtJFM+NUhBzWVdsoAiioeiGFlJZxDR1hY34+0BlFn4bmO0J/aWmY
         GqHs8ukPG+wCPH/md/l1u5FNRjhzDvA3OzZYX+F68+FSZ2xaw9Wlywsek+hN7Hc3zt78
         LXtJHEKOrxgHXHvhZN9EIMRNeQ+3s/A9ppDcEjIBf0oY+gkvPxZEcPFHukBVDLIhauAD
         mkdFC4GEBnIpK+zC1+o+1KX/VQRea59F0AjgJrL8isTA5l1n9SgQlNHBRsydWLqZTVP5
         c1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424899; x=1774029699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDVR6LO95DY7vyobG5JaDyJauzh65mLzZY7eX52aAWM=;
        b=qVmyEXo7HtlKlLHILipX3gsEHc7AoxB5KR3fMZwKYsM1b8VKuSLRLgl11HG1Vzb4fl
         QkVOl7l7WMIlIG0KYRvprpN+SggiZN8CdWIh4TfX/VGoQvXZDFiN1rsl8cqWmkZygGyu
         lIx4GsJbGWS5bvwqUZVM5nLyf0pfWiHo4BiEYVTcp4MGksy1ueeJ9auEFLgL9SO4yui1
         In2Ze8rJsJsXEleldym0A8nnzT+2RYhwBSQ6HbUk2989xIY3KPc/Skhe+mW5z2CsfMqY
         EX/v5kcXy3EeH1+NOU8otue3UJ/zeI5wZJkGBGW1TkrwAxB/m4LZNgilZF+1InwrE9j1
         J85A==
X-Forwarded-Encrypted: i=1; AJvYcCUfwRKtSNL52zLjM9uKQPqMyi3xLGfSKEhDDrzr6JTMQQ2RX3DIE1YC1AQgWnzfVUMxiG+niLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyddmOmLfCCSglGjLO/ISDWYK2RFBPu4HJ6vKi9Kgl9iwuzHBC
	ZNMWtwGobbc2g+5RzVtWaGzFrqBXun4/lvkOIigWyEOPnHTzaxMrEjNp
X-Gm-Gg: ATEYQzwLrRtIqF8CxE+6/YFpAO1k8L2Fr95l//lodOD5p2bcFcG/4QUSlH9djzzk7dK
	AriXu1BJD5Q5N9qGg8SXUdZxU/JwKkFF/rqA+lzzgoHNRPEBquKKS3NrFoPRTlRg4IA4W+ZETy9
	XP1bd4oRHG8MtebV4lA+hs0CS00e30HIciOmwVOC726x2YfGlBiHTRQPuoWnBCivKOYua163xVV
	LZGftv2ivT9qD76SRCSTEzq15eXCIgLxj3hanie89fr/ejdPqPHcNn3HKI19kiF65q/6kPzDPZ3
	N6yyqTTn17hNoTjxtQJ2uOChw/MEQhLklSaxepjqGmY91mQWKpaVzUkXeW17OQLxRoI40pJeP4M
	l8O60arsrO+NsgsFDvqo8z81EnmSNo6k/3FCdJ58LFJ0pzuLJEGZmmHJr+H4VSDjuQL4OAd3F8E
	R7C3SqASSWKQZ4mNWnt6RkuII4v2GOkhHNLyQethHff9qthu9fBwUZ5qExaYMwdPsxIIv160djj
	YQfYzKsRPMcKjm8IoMQKzrqoQOBRM+q7A==
X-Received: by 2002:a05:690c:c50d:b0:798:5333:ce0d with SMTP id 00721157ae682-79a1c08d4ebmr44869727b3.4.1773424898390;
        Fri, 13 Mar 2026 11:01:38 -0700 (PDT)
Received: from localhost.localdomain (99-47-159-199.lightspeed.mmphtn.sbcglobal.net. [99.47.159.199])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f42c4csm49980107b3.52.2026.03.13.11.01.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Mar 2026 11:01:37 -0700 (PDT)
From: David Baum <davidbaum461@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	David Baum <davidbaum461@gmail.com>
Subject: [PATCH] netfilter: ipset: harden payload calculation in call_ad()
Date: Fri, 13 Mar 2026 13:01:32 -0500
Message-ID: <20260313180132.75655-1-davidbaum461@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,netfilter.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-267552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidbaum461@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A3B162887B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

call_ad() computes the netlink error payload size with
min(SIZE_MAX, sizeof(*errmsg) + nlmsg_len(nlh)), but min(SIZE_MAX, x)
is always x, so the guard is a no-op.

Replace it with an explicit negative-length check and
check_add_overflow() so the addition is validated before being passed
to nlmsg_new().

Signed-off-by: David Baum <davidbaum461@gmail.com>
---
 net/netfilter/ipset/ip_set_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index a2fe711cb5e3..11d3854d9b11 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ip.h>
+#include <linux/overflow.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/rculist.h>
@@ -1763,13 +1764,18 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 		struct nlmsghdr *rep, *nlh = nlmsg_hdr(skb);
 		struct sk_buff *skb2;
 		struct nlmsgerr *errmsg;
-		size_t payload = min(SIZE_MAX,
-				     sizeof(*errmsg) + nlmsg_len(nlh));
+		int nlmsg_payload_len = nlmsg_len(nlh);
+		size_t payload;
 		int min_len = nlmsg_total_size(sizeof(struct nfgenmsg));
 		struct nlattr *cda[IPSET_ATTR_CMD_MAX + 1];
 		struct nlattr *cmdattr;
 		u32 *errline;
 
+		if (nlmsg_payload_len < 0 ||
+		    check_add_overflow(sizeof(*errmsg),
+				       (size_t)nlmsg_payload_len, &payload))
+			return -ENOMEM;
+
 		skb2 = nlmsg_new(payload, GFP_KERNEL);
 		if (!skb2)
 			return -ENOMEM;
-- 
2.50.1 (Apple Git-155)


