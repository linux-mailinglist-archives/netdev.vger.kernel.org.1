Return-Path: <netdev+bounces-256192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D1zFUG1gWkrJAMAu9opvQ
	(envelope-from <netdev+bounces-256192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E1D6550
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E1113019169
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D72395D96;
	Tue,  3 Feb 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXWZfW1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656D29BDBA
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108223; cv=none; b=pu09rzlmYM5d+WFp6zlN4VgYaLx0NxLLFofXHLCMWEWPKWKdiSZNKFHj0SBDfmjFSvVCe1dVPPJwU9qkMTlFiS1bK35JU7tMzxTL6tRXaVgmy1iIJ/kmhCfSqbJMyy+TpzV2Cgu/pSVoRb37gicgWkiHe+WU67GppJXV1dHP6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108223; c=relaxed/simple;
	bh=/vj8FfFEYx4ybfsw1a4KFbNnoLnIwN3x1fS6W+SsamE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3+Q+ItEziFiBELvQY1/EhoW2v+0R67oWIZdmNSzX51A06+bJXXeBXY5/+8fvLvS2b1RHzp7A8OHAYxRCrb8F2usKYafmtO3Zj+zA88f/M+x2y6VOzijxoqc0NmEnBOZNPSFr3jVay5Q55eikzP3NMDjvRuOC1SwzxqeBNuKsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXWZfW1P; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-11f36012fb2so6272201c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 00:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770108221; x=1770713021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMDFXYLSzSLdaG2mbvsH2lIntPnUeMn+Wtbmb/TRzL4=;
        b=DXWZfW1Pbqf5tAchQwTkhkzEkKpbYmUAmkOVc09XZQgaChOEXeb0cleetV6fPnLkxj
         ySLv83h5Y7Whi/4zpTCbPd3qnu493aUfwP8uIcc1gO7OotsIZ3GXnbE9xxp2HG8wXXO9
         nQmcygmf7jH4fKSZb8sCzTcdyYejKlYnb31bKpQfBoJXEtHS2iDlOuFXLitoEhltwiDa
         2K07J+CHxXQuP4B+/jtwQnnl8xxBVRCvGVH2PuqqS/Z2HQOkPZ41QO/IgZpfeVK9zkLC
         2e8S7P/WcscKuFo3s7qwEbjNV0DyJMre7ovPR4TmoqIB03pxvDrh+yZJYLjMli41oR//
         xcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108221; x=1770713021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMDFXYLSzSLdaG2mbvsH2lIntPnUeMn+Wtbmb/TRzL4=;
        b=w4stkpheXgf2QQmafgSrOZd1fpVqTpSzoNqqynhyBpTsLhFmKTHSdXM01yy8WTJJX8
         ke10oGhr6YELy4TDeAyLRJlHa/eV6pjCtdG7VPIpd2e3Pln4RMomWYShO2rZRZP1NXqJ
         GwACHxyMgLf0R1R0Fx4ar/xteKG99V57nGQ5G0NmCP5AyfXdFiDNpl4s0q/RROWmu0g/
         iWIQ/BbxHvRYgGluTUk7SFjz6VvzjyZk0oqUe3iJ+2ckb/VDDOZvLNcaxuRKfCYQZbk1
         NWZ7GMWZ45KTFVADB9xjl5t6o/NdE7Q8SuKl36DQXtOU4jbXAMZEOd7JzJ+mFqP4Djp1
         xcLg==
X-Forwarded-Encrypted: i=1; AJvYcCXzZLoTcJequOgfW8cgDapK1y1Fjdhyaq6wg7fFYdhhus3Zl98hgij/DBxRflH4kAs69Pekx9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OlT7iM7KcH+8MxZj1xe+z8QYbrk1Msma/UBUtbB+CjSK5Ggg
	iwiVS6N/UbCIVhGnHjYhFTK8SgMccKWLK+1aY6oq7VLd/hIM/pENvT1O
X-Gm-Gg: AZuq6aL/YcwlYQkEm8ll7oxVwRDV6e24BHoDIpWFFFF5Qqg2AfwaDM+SqP2pltSxJ/6
	85lriUI7Cn2lRQUgMZ4ahHcedEdEPj0/ct+aChYxKEUao2cyuHtuxdYabSDjoipY4xlBiYI5OMI
	KNM62/uewGy54CDLvmcsCu4ejeOsjOReXu29LGsB/c+/52R0X7sG9ON154SAK0kS0G2o573CFD7
	r9VBsM/7IsSQoRScCA/b+liHBFCrCC4hcui+aX4QhYXS3H85ij1HyEu3bZdcxk5YGGsCqfwsRBh
	0fvFEmLN2R5neDzHDF334ftBIUBjqhExJjuWkLbrqO1QW5oDz3VjKo2T/4eiTrDsFVKCBwo9YqT
	9Qb9jzuWp3hOD7Kc8YlAOyqcMKhhCQebvC1wVcAzzpjEnwD0TxsKW1MMwlhJkQvtVAUnULKqaT5
	3xx3tzUe6PS5s//hQVb3+YjGhXKSGHYNJ2w1usYHcuZq4KKRxAkjKuk3bQNcdwOQhFhIhAJ2EIS
	mRPzM0/CA==
X-Received: by 2002:a05:7022:7a6:b0:11b:95fe:beed with SMTP id a92af1059eb24-125c0ffbbecmr5515230c88.38.1770108220751;
        Tue, 03 Feb 2026 00:43:40 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f597sm19048396c88.5.2026.02.03.00.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:43:40 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] netfilter: bpf: add missing declaration for bpf_ct_set_nat_info
Date: Tue,  3 Feb 2026 16:43:23 +0800
Message-ID: <20260203084323.2685140-1-sun.jian.kdev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-256192-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EF7E1D6550
X-Rspamd-Action: no action

When building with Sparse (C=2), the following warning is reported:

net/netfilter/nf_nat_bpf.c:31:17: warning: symbol 'bpf_ct_set_nat_info'
 was not declared. Should it be static?

This function is a BPF kfunc and must remain non-static to be visible
to the BPF verifier via BTF. However, it lacks a proper declaration
in the header file, which triggers the sparse warning.

Fix this by adding the missing declaration in
include/net/netfilter/nf_conntrack_bpf.h inside the CONFIG_NF_NAT
conditional block.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 include/net/netfilter/nf_conntrack_bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack_bpf.h b/include/net/netfilter/nf_conntrack_bpf.h
index 2d0da478c8e0..25b51fa783c8 100644
--- a/include/net/netfilter/nf_conntrack_bpf.h
+++ b/include/net/netfilter/nf_conntrack_bpf.h
@@ -33,6 +33,9 @@ static inline void cleanup_nf_conntrack_bpf(void)
     (IS_MODULE(CONFIG_NF_NAT) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
 
 extern int register_nf_nat_bpf(void);
+int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
+			union nf_inet_addr *addr, int port,
+			enum nf_nat_manip_type manip);
 
 #else
 
-- 
2.43.0


