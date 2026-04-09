Return-Path: <netdev+bounces-277040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDyUHZ/B12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:11:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABFC3CC70A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A134130432EF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C753BFE3C;
	Thu,  9 Apr 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1NYr8nc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3C3D34A8
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747269; cv=none; b=lSWozjSkxyhrYw/QKqfQEM3PBSHHqWNbhSzwyXX0wl2qRO//duFHDpeDfE0Qj0II30Vu4j3/GCK1bb0Skixu9wpc2BVM4DGD8UkiDH1RPBzh+nQP/03NnRjPnqiWxMyMeVrjzDa6btMKCh5RtBahg7LHeZeKn/57L2BBpNfqDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747269; c=relaxed/simple;
	bh=Tzx1JoLPABShYM1Pm3RTCn9DyXuxVz/UCK8Zh9PzwWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnYMkFTYd7dBTZh5W5+W4wqZYpI/g7tH+14ii8+sp+gdaHpHA+u1in/aoOO3aSH62wUOyqNpr5jF9aXWjGLBIPgPW2piOTgTmXkTcwJTw7C86nhCaeB6tggj6dSw0S5EqC7m5d4pbSSMswthyGYVkzVImIxsFDnQKBQYBa8DkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1NYr8nc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76864f4e58so373844a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775747267; x=1776352067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrEq8JFBlKt4BxwmLLBZiPMRBW9tfYXXYLLd/dH/SyE=;
        b=K1NYr8ncZ7rDgEspHQQy3QHmOK2zePYvr1Y/8hWeYphQM8gDSZO73Px+8E7JCfZ+8f
         5pb+QBGtVyQX0HJgArVXV7MhpjCIqfnNYR3s71h5cEfxiOK4FhQXnJV0Qhsn6dJrSzQv
         gYq7DUaLSop3GgBGksn7MEJdEJ0ZPnjJ4DHpSUGRJLyTn4qg1qg6leTAzcSppzGctOJq
         VHVpqtmqyBbPUdToOPr/EcVfgGpFlU4CM10/CctapHwjpbatQ2ScoZ1ka3lOwwPmsg45
         LzP8wLgXIxF+qYEbSEvoNUvEMsR9xFpdwaKFWhflad4bC4ogrQuy+/CHd6mMKrMPD4O8
         RivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747267; x=1776352067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrEq8JFBlKt4BxwmLLBZiPMRBW9tfYXXYLLd/dH/SyE=;
        b=Z6vAiKUjP4dnUj/C9vd9l9uui97armhQ8V9xKCWKjQIvrnJKyLEwUHVWp3SeSwlksU
         7gIqlmwroIF2dCVTxyKwhlnVGtkWyWbup2s6oeLQb09ZnpG47s3Bq5t4uF+rPafFntaM
         pAVEKCACzA8x5NjLLSz35MG1+ZW7cl0YqJSdeF0CsJNL+pPkW8YzlkLml+xmC0OUZDXf
         okEERCjVuqDewpDXj0f268fnnOBWPr5uxelH1pKfGaxEjYgpaVLT0vNMhPm7RKfKc2kl
         kVAGb/UtBGQWWu5AIxGEcaB/phi7O66HXF1d3tXBNsQISojPRRZmQcMO57GiG4qrlAbe
         wunA==
X-Forwarded-Encrypted: i=1; AJvYcCUYevsuvqLl32/X81U0u+c9ha1ylZ392YBck2a9wU6TgvU3CT3aQr7vZXbc61cavOgUNgXlKOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznWSSK9slWfXlQ0N0OvEvr1s7GhhhMKyYP+Tyxwt/6jbFnkBHy
	dDPzfF7O1PGLbhrs5b5Z1vJCpD0xx6+3LLDyacoOHlrV+kB2cCm+NejI
X-Gm-Gg: AeBDieu3wr8Q1PCGqrv+p/JPGYFqrIwW9pUJTFtqpQ94UuF4/xBQ7aSSfS3CJzw0ddm
	IWWnUVhCX+xH0DIBKHz2YszSlzJz44LLD7tLgUQyu9mBjqyiINSBAz8FGGC0/fb8l0xvJbEo7BK
	cLKEiBf4WTeek/dCKu9RJojQACZH5DxOPtGG0/9oYVuAPu2a/gMBBT85I0gvAYJqHdRCXIA8IFo
	OF4+v9RbY2/psFG2o7rVQbVVC+V3xUO+VzTmeKe3FDeZlSQ/dh3BEeSjvRLOeFxhh/GqcnAlGN4
	1CxSxro5yqSa0oRuYlbUQPwdtbPjEl0+ARTlKa9r9sYgqcBGXFp5fQXIWyLZLMYX7anbFUd0BpX
	3g89k7LUmgcD7t16oTwD4llPf5FfsZjLH97s7HMpq4/WdRMNFkwjMS0ZBBgC+lcN29JXSDV15YE
	qyKmd/BcYQsF3DaLOpy+UXKXtAfkKxNwGhEJ13tY47p9GyPV6kd09k6PHTbOOuZe1rNF3xR8Clk
	Iv/02Xr4cCR5cl8PuEX/Ng=
X-Received: by 2002:a17:903:22c6:b0:2ae:3b9b:db34 with SMTP id d9443c01a7336-2b28188da6amr269183375ad.42.1775747267056;
        Thu, 09 Apr 2026 08:07:47 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af47sm312363305ad.42.2026.04.09.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:07:46 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: nf_conntrack_sip: fix OOB read in epaddr_len and ct_sip_parse_header_uri
Date: Thu,  9 Apr 2026 17:50:57 +0800
Message-ID: <20260409095056.706441-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nwl.cc,kernel.org,trash.net,vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-277040-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CABFC3CC70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In epaddr_len() and ct_sip_parse_header_uri(), after sip_parse_addr()
successfully parses an IP address, the code checks whether the next
character is ':' to determine if a port number follows. However,
neither function verifies that the pointer is still within bounds
before dereferencing it.

When a SIP header URI contains an IP address that extends to the last
byte of the packet data, in4_pton() or in6_pton() consumes all
available bytes and returns with the end pointer equal to limit. The
subsequent dereference reads one byte past the valid SIP message data.

ct_sip_parse_request() already handles this correctly:

    if (end < limit && *end == ':') {

Apply the same bounds check to the two functions that are missing it.

Fixes: 9fafcd7b2032 ("[NETFILTER]: nf_conntrack/nf_nat: add SIP helper port")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/netfilter/nf_conntrack_sip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 939502ff7c87..83741901c6fb 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -194,7 +194,7 @@ static int epaddr_len(const struct nf_conn *ct, const char *dptr,
 	}
 
 	/* Port number */
-	if (*dptr == ':') {
+	if (dptr < limit && *dptr == ':') {
 		dptr++;
 		dptr += digits_len(ct, dptr, limit, shift);
 	}
@@ -520,7 +520,7 @@ int ct_sip_parse_header_uri(const struct nf_conn *ct, const char *dptr,
 
 	if (!sip_parse_addr(ct, dptr + *matchoff, &c, addr, limit, true))
 		return -1;
-	if (*c == ':') {
+	if (c < limit && *c == ':') {
 		c++;
 		p = simple_strtoul(c, (char **)&c, 10);
 		if (p < 1024 || p > 65535)
-- 
2.43.0


