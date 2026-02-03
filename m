Return-Path: <netdev+bounces-256187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGa8M2SrgWn0IQMAu9opvQ
	(envelope-from <netdev+bounces-256187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92FD5F0E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB31A3008D4D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04CF392C3A;
	Tue,  3 Feb 2026 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L63pAZLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438A37E310
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105698; cv=none; b=S7647I073hAIaL+yqHK76J4nrpgXcAAsZE5lvf5CNPkVt5NzHqCgHGYF8jD5tzKE5dHT65nwxMSsNIEfIkQWlue8Wu0wM1aVJA4Kzt/4NvKbaDMfAGZE9GmPAKMj4E/Pe5X9PwdY6wN/BcuGUnOS2932L9kJS8tKOXpOQCjDWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105698; c=relaxed/simple;
	bh=q3X6LXGY4pvrxPIY1+ZdGtvX1s6x9ZtFOSXn48a+I78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbFmYu+yXAx2aWSvtpFmsYo9u9rcyKDuIEUUWA5bjHbpnf8EJwR4o8IqKrq108oOMDuQq4Kkbx9MCd9/NSZu05umz/5NTowS0PUxLuw3KuOwt8l7JfYE5xJoboyl746C+5EB6+Lwq7ytT8gtc0u0HJHud8bvLcDjcLBIj1GiA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L63pAZLn; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649bff225d4so1901474d50.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 00:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770105696; x=1770710496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnK1EPBJzbPse5QDMYYT7zPjH8hy43jPBzPzSg4c+hU=;
        b=L63pAZLnProgbZeVf8Xr500kKtlCp+q8LRJHWZyhyoDMmVyZDOrTVFo6/fiAcCg//k
         Qlmq+avt/MG5/Ek1+lHhaxmXkCUdYv09FjJsQC8gf/7lac5SEIqgQPN3Na/RICVchTSm
         rr+MI+gC6gWxB8D4qQXhJDD1giF1fh56y4l7qf/AqnKEWi0sB4PUwQRk4uh2TnyILrhD
         GPbHSKPtgceM5H6TOk4etDlA2yaxX/4AAXihR00IoXsoy4mfhcMOS4aF7EE0sR7XF1wO
         62XHPp4ufppMe4x4tsZpIW5h0EKGArjF5BvhpbIW5vIGZ1QlidrdjKCQf6qN4MCZANBC
         vFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770105696; x=1770710496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnK1EPBJzbPse5QDMYYT7zPjH8hy43jPBzPzSg4c+hU=;
        b=LXvAj6u6sM73X8zYiJm8yypweojLUWcZ2bpODEcmfrPPeeSe7eHxAdKkUTQw7OLXVg
         Fs8H92e/N7HpwtxOtpFRNxyX/rBTLT85X8z+8ShEmYtuSQ6Ivuo/Z3oyVVQ60lmX7Z5K
         GXasYqJUjyPdqpMJQxUAuG8piTow2r6yAP9Hdxtc6v5B7b3B2SnvhKdMIvNTFLnr1T3s
         X40cQZae2EtcIwNDYT0cD5YVedp/5cs8LizStQuUnc1d/S6llRo3/DbzTKozVVlkyyeK
         x6N2RM+U3JYUOEE9QaRAiWF9W4DYiWwvRuIDT2DBhfi6gkeFICyEK6RGGcUa5ah83kG3
         eAxA==
X-Forwarded-Encrypted: i=1; AJvYcCXxlt4cXKMGd3E1rMmcnqk6FUZ+WoowQ5U7gQoeg99WdKXGoadExflsCiVSpiN12a37joMxx24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7P3AMfp/jIjREysSFXDSFZP0uhCZ+I/gIJvlK9ktHwveCtOO
	9qe0dC7EwjTV5U2QKq1du1EgN12NGe8Ca0GvXhi38bElny7oL8PfewvX
X-Gm-Gg: AZuq6aKikRSRkFAIn8Sh721+aQyfNZjwPlp6E4KeVm53plWw8tJHNbyIE8ihqsF6Sgc
	GduJCfWLTjBTI18i5s8YXuNINeWvDPqvdt46NpmSOeIR2iflG3KySAfipi3xT5jMtgy1RlCx9VY
	iqCXyKI3AO233LVOS6HHRiBBein1RAMNG5IVI0wnMy4/fPTzt4FFNixqzgEgeskYRsxakd2LZai
	xRAtHbQIDqwWPo4CDJx5Z8DbWkOroWBsaQWRZAvnQApAC2iQ8E4iEILRu2Rm+k8doy1XHv1dyn+
	89yDItLm5On+AidW5v2gU5bhab/eGP/ow2U+tblO7qUptBX4bWeslMEN4IwP5dNbG+6ZBu3JCGb
	GETzn4dvoTD9x4D8ufxt8PMnnVNSEWfJT5L5B5fhmb0GC8APe7HyRxZo2nTKS/jhyTOm7Eo9Ezz
	3dFINcGJvyymXdezuulmjTIJifrItD3I1JYIeSeE5DB4U22Tj+Is+NcX/JgEpSWiwJAWhh4oj5A
	m5S8XefS5hJJp+ZbznS5BfAS/5QboR/y0Z7
X-Received: by 2002:a05:690e:1484:b0:649:6581:a683 with SMTP id 956f58d0204a3-649a83c1a29mr11604677d50.12.1770105696377;
        Tue, 03 Feb 2026 00:01:36 -0800 (PST)
Received: from u2404-VMware-Virtual-Platform.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649d51511cdsm803782d50.6.2026.02.03.00.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:01:36 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] netfilter: amanda: fix RCU pointer typing for nf_nat_amanda_hook
Date: Tue,  3 Feb 2026 16:01:09 +0800
Message-ID: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256187-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7B92FD5F0E
X-Rspamd-Action: no action

The nf_nat_amanda_hook pointer is accessed via rcu_dereference(), but
it lacks the __rcu annotation in its declaration and definition. Sparse
reports "incompatible types in comparison expression (different
address spaces)" errors in nf_conntrack_amanda.c.

Fix this by:
1. Adding __rcu and __read_mostly to the global nf_nat_amanda_hook
   declaration.
2. Adding __rcu to the global nf_nat_amanda_hook definition.
3. Explicitly declaring the local nf_nat_amanda function pointer
   without __rcu to store the dereferenced pointer.
4. Using rcu_dereference_raw() to fetch the hook address, which
   satisfies sparse's type checking for function pointers.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 include/linux/netfilter/nf_conntrack_amanda.h |  3 ++-
 net/netfilter/nf_conntrack_amanda.c           | 11 ++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_amanda.h b/include/linux/netfilter/nf_conntrack_amanda.h
index 6f0ac896fcc9..edf1d30135a3 100644
--- a/include/linux/netfilter/nf_conntrack_amanda.h
+++ b/include/linux/netfilter/nf_conntrack_amanda.h
@@ -12,5 +12,6 @@ extern unsigned int (*nf_nat_amanda_hook)(struct sk_buff *skb,
 					  unsigned int protoff,
 					  unsigned int matchoff,
 					  unsigned int matchlen,
-					  struct nf_conntrack_expect *exp);
+					  struct nf_conntrack_expect *exp)
+					  __rcu __read_mostly;
 #endif /* _NF_CONNTRACK_AMANDA_H */
diff --git a/net/netfilter/nf_conntrack_amanda.c b/net/netfilter/nf_conntrack_amanda.c
index 7be4c35e4795..7b3fffea45da 100644
--- a/net/netfilter/nf_conntrack_amanda.c
+++ b/net/netfilter/nf_conntrack_amanda.c
@@ -43,7 +43,7 @@ unsigned int (*nf_nat_amanda_hook)(struct sk_buff *skb,
 				   unsigned int matchoff,
 				   unsigned int matchlen,
 				   struct nf_conntrack_expect *exp)
-				   __read_mostly;
+				   __rcu __read_mostly;
 EXPORT_SYMBOL_GPL(nf_nat_amanda_hook);
 
 enum amanda_strings {
@@ -98,7 +98,12 @@ static int amanda_help(struct sk_buff *skb,
 	u_int16_t len;
 	__be16 port;
 	int ret = NF_ACCEPT;
-	typeof(nf_nat_amanda_hook) nf_nat_amanda;
+	unsigned int (*nf_nat_amanda)(struct sk_buff *skb,
+				      enum ip_conntrack_info ctinfo,
+				      unsigned int protoff,
+				      unsigned int matchoff,
+				      unsigned int matchlen,
+				      struct nf_conntrack_expect *exp);
 
 	/* Only look at packets from the Amanda server */
 	if (CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL)
@@ -155,7 +160,7 @@ static int amanda_help(struct sk_buff *skb,
 				  &tuple->src.u3, &tuple->dst.u3,
 				  IPPROTO_TCP, NULL, &port);
 
-		nf_nat_amanda = rcu_dereference(nf_nat_amanda_hook);
+		nf_nat_amanda = rcu_dereference_raw(nf_nat_amanda_hook);
 		if (nf_nat_amanda && ct->status & IPS_NAT_MASK)
 			ret = nf_nat_amanda(skb, ctinfo, protoff,
 					    off - dataoff, len, exp);
-- 
2.43.0


