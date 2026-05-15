Return-Path: <netdev+bounces-288311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGwYBj0bB2rnrgIAu9opvQ
	(envelope-from <netdev+bounces-288311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:10:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF35503A5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DAB930AF00E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD8233149;
	Fri, 15 May 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgypJfoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30217745
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850111; cv=none; b=au3Fj6Nqt5xB7fiVplY2FmIiN/nx3u/rAaNVG1T+tTKjb75oBEBOTq2VHBETXK9af7KRttXw9VZZ46h8Ia4lztntStx/h7HbCHNB/IlWeZtU+qU39mmwkRROlEBPdTd4alnGmKJesP7W+Nu9gePyGi8nRazClkL/sb1lzN0MJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850111; c=relaxed/simple;
	bh=NpIlQGPIlyhgjkd6WxibxScaBsCwsxCGGYy7sjYYPVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odtKvq3hczAA3DtURz8IcOCIVTl4JDCVnuTt4EQRGuwiC5yxqj1EIdK27gPIJyRXpHFRyoVSPozDRk+8l7i4JCh941gcm8VTpgOO/lnoX7Kbwf7d2eICJ+LP8z46Qw3OwEw1su1zOcKO2tHXC45CBbd7weruV7EUQgGAVG3yV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgypJfoX; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso8884167eec.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850110; x=1779454910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RI2Tf6l/K6e7lXAgpwYm6PolLJwVtTfmbToF4Pb6OP0=;
        b=JgypJfoXkamXEs2d5D9XunFEZWBGuHnzS394ooU83hnr4H8wMZWLBYKAq/nkZlyv1N
         DiKWFi9UPMW9tVWh84LVq1ncFNTaZPOdMrg3vHHgoTKU1uPa1dHdsvEls1dbD5kq4734
         P59NUCcPA7TX+64Yj62Sc1qqCrD6djadasIWm3qNLaqHHjtFKlOc5MZOIJQ976gbcN6i
         yPQ+jSLtKB4LiP4VE2thjhGy/tP1UiDNSpSXBq2PI0R4rA55sB3jcq127IX8mD9JjpF5
         Vyb8uO71oFm2BG8Qp0hnX1wCSXURDQtjXPLTNjSOFRjk6hYPUuIq7vjmBoqY0k0hRE4G
         Zflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850110; x=1779454910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI2Tf6l/K6e7lXAgpwYm6PolLJwVtTfmbToF4Pb6OP0=;
        b=NGRSXM5Dbz+oVeDvdHHw7oJuVhSpcU0MRfULgCiO58pwGLlJ2VvMs6cvozYFSoQ0B4
         F2+z4Ka+oyL64MU3WYVwjTDF3HkCRBmWnw/lCClG2O27rJ8Nm/2pJgq/gFP3sPSwd33d
         b7WgEj030cr/9CYc9MFyaPKelKgVaMPkR/s8kxySy/5ak3uZ2bo8Khp0yZfFj3xWeQcq
         LD3PdC09vpeiJCMHmsNmZ5er7qn/M4equ4jUmNPZ3I2VBC4MkEQ2V0uP/CkIdgjd3pD9
         VwS56B9iZd76iHJc/R8ONkLbwm3YVD8dKBE54pemrI2dyJTH6+PYCBNzW5fNKw7mWWbP
         oGJQ==
X-Forwarded-Encrypted: i=1; AFNElJ++7H2c1CBIogQWYu+czW0GHXHss1XBiXgCA16h5ALGvvsbt8jaB8VYHLN08H5q/3OCzF7DhHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTflf5pQbcYoyqBp6QrrlloboZ12q/movvhk9tJUmpwkZiiAe2
	9H+vEYwg/lqAvJEkFFzC6lXRixgMMqBtfdoekmeqx+N+2nsYOsxTjTro3Ok9PK2H0H4=
X-Gm-Gg: Acq92OGM/s++l+rZyL/oyKLFsx1vKGLIH9N+D/Go37dTU3E111c5+s/5nWjLdjU6Ltx
	FnQFHG71bAGhsWAUXhGP9+ipvmvxUZvKavtXzPV6LT2MGi8Npu9od0jGkM8eLfrNod1aoYIqvwf
	kf5+IQ9vHLxV2Lgjdboob5cGVm6Gwu0TQFaeLQrNMjv+Sjlt8nMqN65C87hWSqYSjsuMW+NXbln
	ZWT3Dl9cw10aMbrPXQ/jE9JGXifPkWOBIGorsEL85Q5b3uv/GE/cvdRSeP2JKRJg6jZJICXeQKr
	+4f16titNyJFJtq4GnY/Az81+vdGwFw1MQusFjg7x4ffn3zYugLqkKQluSzeDk37cU2Fpp9WgYX
	Y8HXwSpcPI7C+KHet/pLZh10s2T7ZfmTrnL2DzbOz5p1Fmu/i8TLB7wossBlHfj72NIgkXWxtju
	U5Sak3d6j8nMnWsxar8AS17nqdfEPzMDkGhA6jGvqFflEnSzkw4K4OryNVdN1B6AeU7qpogLAur
	m5z/pNYp8FAilrycq+k
X-Received: by 2002:a05:7300:d511:b0:2de:cc07:e83 with SMTP id 5a478bee46e88-303982ac0c2mr1679468eec.15.1778850109501;
        Fri, 15 May 2026 06:01:49 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc464sm7239271eec.14.2026.05.15.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:01:48 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] ipv6: rpl: add NULL check for idev in ipv6_rpl_srh_rcv()
Date: Fri, 15 May 2026 05:55:30 -0700
Message-ID: <20260515125530.3396293-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78BF35503A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288311-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.930];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

ipv6_rpl_srh_rcv() calls __in6_dev_get(skb->dev) and dereferences the
result without a NULL check.  When addrconf_ifdown() concurrently clears
dev->ip6_ptr via RCU_INIT_POINTER(dev->ip6_ptr, NULL), __in6_dev_get()
returns NULL and the subsequent READ_ONCE(idev->cnf.rpl_seg_enabled)
triggers a NULL pointer dereference.

 BUG: kernel NULL pointer dereference, address: 0000000000000370
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:ipv6_rthdr_rcv+0x3bf/0xe70
  ipv6_rpl_srh_rcv (net/ipv6/exthdrs.c:504)
  ipv6_rthdr_rcv (net/ipv6/exthdrs.c:691)
  ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:478)
  ip6_input_finish (net/ipv6/ip6_input.c:532)
  ip6_input (net/ipv6/ip6_input.c:540)

Add a NULL check for idev, dropping the packet when the device has no
IPv6 configuration.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/ipv6/exthdrs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 95558fd6f447..19002e551a03 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -498,6 +498,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	u32 r;

 	idev = __in6_dev_get(skb->dev);
+	if (!idev) {
+		kfree_skb(skb);
+		return -1;
+	}

 	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
 			     READ_ONCE(idev->cnf.rpl_seg_enabled));
--
2.43.0

