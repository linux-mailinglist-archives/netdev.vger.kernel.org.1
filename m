Return-Path: <netdev+bounces-301141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P3jfNVZNOWoaqQcAu9opvQ
	(envelope-from <netdev+bounces-301141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51AF6B0893
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:57:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=DahQ+KU1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301141-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301141-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87C3A3045EB5
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFCB311C27;
	Mon, 22 Jun 2026 14:53:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67533101C8
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 14:53:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139992; cv=none; b=qkWcuBvkM6EPEUGndwLClm2LK7pQ+RkASJ/49QTqQfMCF9ijawYwvRTNhjA9j0sct9zWxyBPTckjaCFmosBlj9fYNduE2etN0/k2ff7mMKobXCZmNEV0Y4YFDyYIN+rhuv/FGi4NfhejeaGEt2KnR3ThTwISDT6GBexhU5nACNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139992; c=relaxed/simple;
	bh=Xy59s+JNRnmSM6VzrGtWFcxa0uMF9TCT4hk6jnMbGwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZdWcWv689AZozUmQ9ABlHbsk+dQ3UFzkQDhlk0JStEi3jPPr8p/FusAzoKuOfnHC2cALp4nlfouwRsP2boCSJPTyGD/dXbLIeNhU+JJSFPL07E8JQt2CYHCLnRvwXdBxg/gOi7XCxuyRLaxW9uGViE3MVT1Bc0WSOj0BzxXQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=DahQ+KU1; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6974ef0c3b1so4351881a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782139989; x=1782744789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+82Wee9YcYFC/CDtK+GzldKM6pWgg161oAknThGH2Q=;
        b=DahQ+KU1HUi+xzN5D+GKQLaLLWGhqQKN88PehlWXgESv1ndgnhx+VPcX96jEnRXskd
         tceBMZi1ExL+jvZJF+8JJgCpZ86mab4H6TLw07SLk5pCxOdNIqlBnVPabjePdv3qM2rK
         kCn1PrsV4pH2QgztMBtjJFhgKSDqMIPuRYjzMJgnnuUsBkOUivkALprBGPAeqKl/X0ae
         kX72Zu9wcZxGXGHvsHiw9AMQZlD9Ltj3D4Qfbw+zrP/m6OT8WbszzGYIxPJEYogaKgQC
         3cEyDz76bNw+d+aNbcxOUmKsSLX51sTBrIEYCiKktC8vuDja1zRDNm7pU/RmjOgXzGhV
         LLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139989; x=1782744789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+82Wee9YcYFC/CDtK+GzldKM6pWgg161oAknThGH2Q=;
        b=TNYFFl84UDbTaE2iXyy9ZYvIIHVfj3CcDshEgmy2Hru0H/Oup0uJBks43SaRn2bnhu
         g5ncmXUEgLQPa1tT4B8Sy8nzkMPJVlDxVKzhTmnzkYFR3H3TK5KVapyVEXTTjpCpgfOv
         5C/ijip03NLaniBZEo5YcTx40DcW981oxPBRScoRLrPYDbj/RVj0dKS49vwuDo4ZepRF
         /fvkuiu2+WZdZXvirBTAZJsxRjmsHLiTYSoY0HI98zn3s89MoZTndhlAcy+2wtCG5Xvy
         gPkJHP01mlTd5ogp+n3eREoPwq9k9Su5Bu+KeSihD7GAqh/+H+KKzjTe4PKsI4Kp70zw
         Mx8g==
X-Forwarded-Encrypted: i=1; AFNElJ/5kqTKoEk1/uH34ZZ21fkG4MxuaOYMXDRff3qHfVM2EJMH4Acmqz7zZTCLoiwtMkxIV0+S2iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyewO9ktLlpa9ni4vTybYHXtpewFHK42bn3fk5D62m5lpD71uxT
	2BvuaZSCp5fx6MVm8iK0v1btJ8j2AAZgLj1L1JWA0MXtNFdeQ0W6LmFSELvg51OxJjr5
X-Gm-Gg: AfdE7ckdY2XXI+xGrGCqPyauz/jmc98o3HKw9ZnovKSfGHSmYU9B+kRq21WRNf1C5/I
	w91hdICjBHKNvz7DF4XsI80S6vhplSRk+Or/EMhhjyMvB0Rm9ndx1RXqpa2s2bitnmkBRml8CgL
	r0aZmCeFHiqyKClzFqJ7rk4v1/hhy4ldjo3P8nnH40bk3LrvBda8auhTCTLg2GPbWuuNDaFoxpa
	WwIlXeN8BHGStCBGYagF2Tw6Uq4ndbCZzVoSYcyho8wQ9RwEY3ZgMyYr7lIUyEZNwoRr2BTRiWp
	FzsBIPMCf1KoqTVtE5M/Hc1UqXRApOlojAAWl0sNxrIFVF9MHlM7TjRg3Gsa9zpGqI47oZN22ds
	4SDiOWCnr7LIqqUJyZDsim9fL4TYtJHeBnQaHUm1z5BBfrzVinZYhYWHEhaGoL3gf+2YxLQSolt
	Bx
X-Received: by 2002:a05:6402:2116:b0:662:ac7e:aac9 with SMTP id 4fb4d7f45d1cf-6975678925emr6317263a12.20.1782139989329;
        Mon, 22 Jun 2026 07:53:09 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b82fa67sm3680336a12.4.2026.06.22.07.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:53:08 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Samuel Page <sam@bynar.io>
Subject: [PATCH net] nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
Date: Mon, 22 Jun 2026 16:52:43 +0200
Message-ID: <20260622145243.3167276-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301141-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sam@bynar.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E51AF6B0893

nci_target_auto_activated() appends a target to the fixed-size array
ndev->targets[NCI_MAX_DISCOVERED_TARGETS] and increments ndev->n_targets
without first checking the array is full; unlike its sibling
nci_add_new_target(), which bails out when n_targets already equals
NCI_MAX_DISCOVERED_TARGETS.

ndev->n_targets is only cleared by nci_clear_target_list(), so an NFCC
that repeatedly re-runs discovery (RF_DISCOVER_RSP, which re-enters
NCI_DISCOVERY without clearing the target list) and reports an
auto-activated target (RF_INTF_ACTIVATED_NTF) drives n_targets past the
limit. The append then writes a struct nfc_target past the end of the
array (a slab out-of-bounds write), and nfc_targets_found() goes on to
walk the array with the inflated count:

  BUG: KASAN: slab-out-of-bounds in nci_add_new_protocol+0x94/0x2ac [nci]
  Write of size 2 at addr ffff0000c7299a18 by task kworker/u8:0/12
  Workqueue: nfc0_nci_rx_wq nci_rx_work [nci]
  Call trace:
   nci_add_new_protocol+0x94/0x2ac [nci]
   nci_ntf_packet+0xddc/0x11a0 [nci]
   nci_rx_work+0x15c/0x1e0 [nci]
   process_one_work+0x2dc/0x500
   worker_thread+0x240/0x460
   kthread+0x1c0/0x1d0
   ret_from_fork+0x10/0x20

  The buggy address belongs to the cache kmalloc-2k of size 2048
  The buggy address is located 1024 bytes to the right of
  allocated 1560-byte region [ffff0000c7299000, ffff0000c7299618)

Guard nci_target_auto_activated() with the same check used by
nci_add_new_target().

Fixes: 019c4fbaa790 ("NFC: Add NCI multiple targets support")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
 net/nfc/nci/ntf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..566ca839fa48 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -603,6 +603,12 @@ static void nci_target_auto_activated(struct nci_dev *ndev,
 	struct nfc_target *target;
 	int rc;
 
+	/* This is a new target, check if we've enough room */
+	if (ndev->n_targets == NCI_MAX_DISCOVERED_TARGETS) {
+		pr_debug("not enough room, ignoring new target...\n");
+		return;
+	}
+
 	target = &ndev->targets[ndev->n_targets];
 
 	rc = nci_add_new_protocol(ndev, target, ntf->rf_protocol,

base-commit: 47186409c092cd7dd70350999186c700233e854d
-- 
2.54.0


