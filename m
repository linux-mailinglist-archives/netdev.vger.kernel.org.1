Return-Path: <netdev+bounces-256326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ENQFnAMgmmCOQMAu9opvQ
	(envelope-from <netdev+bounces-256326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:55:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E6DADC9
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 632DD307DFF6
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434243EBF36;
	Tue,  3 Feb 2026 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMgcB7gV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942B3ACEF7
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130538; cv=none; b=khBNKGYoWJLIicAB+fLKhxVM8kZa9iKO2YP30nQ+qlC0gdsqqgsBO08oXA2F9KNKwgh3p0Dir1BpZg+WoGmJ86smVKshnLMkZbyIMWnkMcX43I7lb/NccTabWHM47L6vlEjHPlk5piYj0iP86JhrRb8KfTuTcErKk2F24sLKyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130538; c=relaxed/simple;
	bh=NRgVJBul0Y8zpGSgGKNgKM+I9r7ovGTkQ6APHRuS7mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5Rf0FoBk2Tm/opZ4Gxe+OYAV5CISsVS5pjb2Wi6ZrJl3ZnbVvH3thD1FtGLKaZJd4Va2flKfDEO5nqu6hdWly+02KCTglhivbH6/J9AFMsl0fMRZ32xFaFG4Kaq2RcRd3y7ND0TYMIh+J1OLD1681eEyEmjTQEqertZTM4bpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMgcB7gV; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b71557299dso5807412eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770130533; x=1770735333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARM7OCB27g2Bz6Y1P5CF31jTt4HxwnIXMV7CLDf4O6g=;
        b=lMgcB7gVLJBqTU6jI+7fIlgIRS3Vf8c5SWyknBT7xxEXWcWGwdv9zTuwu4rNlEm6iI
         797OXgkwkgvklpjyzSqmztvg2yMR8o3/YY/84nfBKDhsaJA7QwVAY8a2YflCt5M/mD0v
         fdJjKHv+Rmf0gHSBexfJCKxPLLtXB4iKBfpTLlQPuWaD6oLFwSs31vr5+/nVNMV10xGL
         jv0tQkhNaOcUy5sjfg+aWQWp5fIJbW0MmQskvMUihYS+E9DK/mgM+acQakQmF4buGXDk
         f/UyVOuktw8HZzmNJUVxxcwxAJ7ztOFFe5DRkVAD95RQxePX2gT53O2bty/O/DXufsU9
         Nu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130533; x=1770735333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARM7OCB27g2Bz6Y1P5CF31jTt4HxwnIXMV7CLDf4O6g=;
        b=op92dlnySTPT24WsFOe/USuMyA/k2vroRqos5/2OLi1SThZAp9wD8+MnZhsP7AwjZA
         lS1AImDeYukf4Ood0fZVutMLCPDIElTCKI0GiEgbolcYMxUbZhN8NHzPZqAw+ILSF6sn
         xEkMbl+aDAucgB0qtzaSe4AJxST8rnneqsaPowvpsUlo5fPYEyBdtgBCtWbesi6lfTRm
         BWx44qyq0i0/up7119cSXFr5Npvb9co6qw6wb/oJPln7B3FnLOHPw3NVBAGeW7Jcp1S2
         qajkO8VcjTfc3QUE6raAt2y1vJgjx9YqHfwALMiTbhOGfFgRC1rbKIc/9yL58DJeDvRP
         Eimw==
X-Forwarded-Encrypted: i=1; AJvYcCVe4D1Z3CpRF4TVRA8nXvfVG+WARkBblwCmGAjZMKBCkMRe5HinrNPzds6RiPPIGQWB4Z1I648=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8dP8iY1zzEd0ZyQ7qezsRia+f4sJNxsNNsemVfqo1gbgxCQI
	3khZq815aTX4qYx8JBkq2Crzc2D9xH/Fy72w8kAlQisEttyGWodHWf0W
X-Gm-Gg: AZuq6aJO90LxglDxT89g67AYRge6wS73PMVew7cwgQ3x3SxpAlEKd5W+uH/2w7hjrn+
	K3bEziMqDPoCOTYSooK6g+lvEMVRCRbHdbj6D3ifiocgSIC/ANMjXDl4Dgr/r2NOqq3mQ8/I53R
	QwNmmuKxghK3+CvuCqTt4SYcuxxB0/Wj8HaIkNyRMzdxVlYMa0NHEK9b41iEDB8nPEKO8eOjjCH
	N4E1/clFpymsGPkOdDfewGubQCxZmVCWWF2B2UcThMppGF2rr01d4tP1xs/PlWJ2dF8S/mlkneg
	xdbvqaEpuA9WVwajwttqfMiJy1aDZl2xC/QRe8LUJNAiiTY4Di0kfN2LuLSqzp3asv0ZRyqJSzv
	fDxk9/IkVQDA/rM+hcbCcwUTwHluvO9yFvRTWuXbiLSPJgZWALWsyPer0e73V9gT7aKrXbqIQGu
	o8BXuxUdxMAnDAsT4qLLd478zrMc3JYw++3lZQJ5DN5a7sBJnstok2GHXXuKlUQoJpV721zT0jf
	QXHfb0PHIDFFvFM10J7
X-Received: by 2002:a05:7300:220f:b0:2b8:209d:5980 with SMTP id 5a478bee46e88-2b8209d5c4amr1327259eec.30.1770130533426;
        Tue, 03 Feb 2026 06:55:33 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16ef40asm21806765eec.13.2026.02.03.06.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:55:33 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2] netfilter: amanda: fix RCU pointer typing for nf_nat_amanda_hook
Date: Tue,  3 Feb 2026 22:55:11 +0800
Message-ID: <20260203145511.164485-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
References: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256326-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,nwl.cc,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Queue-Id: CB0E6DADC9
X-Rspamd-Action: no action

Sparse reports "incompatible types in comparison expression" error in
nf_conntrack_amanda.c because nf_nat_amanda_hook is used with
rcu_dereference() but lacks the proper __rcu annotation.

Fix this by correctly placing the __rcu annotation inside the pointer
parentheses in both the declaration and definition. This allows the
standard rcu_dereference() to work correctly.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
v2:
  - Correctly place __rcu annotation inside the parentheses as
    suggested by Florian Westphal.
  - Use standard rcu_dereference() instead of rcu_dereference_raw().
---
 include/linux/netfilter/nf_conntrack_amanda.h | 12 +++++------
 net/netfilter/nf_conntrack_amanda.c           | 21 ++++++++++++-------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_amanda.h b/include/linux/netfilter/nf_conntrack_amanda.h
index 6f0ac896fcc9..9f957598a9da 100644
--- a/include/linux/netfilter/nf_conntrack_amanda.h
+++ b/include/linux/netfilter/nf_conntrack_amanda.h
@@ -7,10 +7,10 @@
 #include <linux/skbuff.h>
 #include <net/netfilter/nf_conntrack_expect.h>
 
-extern unsigned int (*nf_nat_amanda_hook)(struct sk_buff *skb,
-					  enum ip_conntrack_info ctinfo,
-					  unsigned int protoff,
-					  unsigned int matchoff,
-					  unsigned int matchlen,
-					  struct nf_conntrack_expect *exp);
+extern unsigned int (__rcu *nf_nat_amanda_hook)(struct sk_buff *skb,
+						enum ip_conntrack_info ctinfo,
+						unsigned int protoff,
+						unsigned int matchoff,
+						unsigned int matchlen,
+						struct nf_conntrack_expect *exp);
 #endif /* _NF_CONNTRACK_AMANDA_H */
diff --git a/net/netfilter/nf_conntrack_amanda.c b/net/netfilter/nf_conntrack_amanda.c
index 7be4c35e4795..2e3753758b9b 100644
--- a/net/netfilter/nf_conntrack_amanda.c
+++ b/net/netfilter/nf_conntrack_amanda.c
@@ -37,13 +37,13 @@ MODULE_PARM_DESC(master_timeout, "timeout for the master connection");
 module_param(ts_algo, charp, 0400);
 MODULE_PARM_DESC(ts_algo, "textsearch algorithm to use (default kmp)");
 
-unsigned int (*nf_nat_amanda_hook)(struct sk_buff *skb,
-				   enum ip_conntrack_info ctinfo,
-				   unsigned int protoff,
-				   unsigned int matchoff,
-				   unsigned int matchlen,
-				   struct nf_conntrack_expect *exp)
-				   __read_mostly;
+unsigned int (__rcu *nf_nat_amanda_hook)(struct sk_buff *skb,
+					 enum ip_conntrack_info ctinfo,
+					 unsigned int protoff,
+					 unsigned int matchoff,
+					 unsigned int matchlen,
+					 struct nf_conntrack_expect *exp)
+					 __read_mostly;
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
-- 
2.43.0


