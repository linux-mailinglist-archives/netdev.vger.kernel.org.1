Return-Path: <netdev+bounces-302705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zZeaI3KbQmpQ+gkAu9opvQ
	(envelope-from <netdev+bounces-302705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11E6DD449
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:21:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kXH3UMwg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302705-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302705-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9387304200F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42343CED8;
	Mon, 29 Jun 2026 15:58:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA63438FF4
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 15:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748694; cv=none; b=XidhH8fSZVS9nTcKaH+MAo7HF5f4wHILRZeNaACF5X2gYI1FDGERkt2kK35tzVwOyS74gl02NfihlHOCJOlbTid/Lr/7KUq71y6ACJZTifiUwxrPNKvPB0b7hniYZtVw7zqwzbpIdomvb8OKOrntvxSEaWhNuRQnNzhmWVPnQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748694; c=relaxed/simple;
	bh=fyGt+jc0oNFM66yYaLF0Z5hcoJwFRhon7H7nHQ471Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLrvjYcFImKtEwi5lxCnuhM+5SfbkYVk6c62U5P3wz51RPLkElE9sURL4mx89VfU4NoRpjTfKMnU1tVqzB5Ni2kKxz+0YqQbwln3NxkHR39/+FFVgo3MIIWokJja3YHh06Rp3Q5NChXPqK6cWHnhEczvKTOrAnS4SZ/F3skzohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXH3UMwg; arc=none smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139b5e604b9so4103180c88.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782748692; x=1783353492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wY5L1SkTbcuC0ovvgAOdSZ2ZO/9WR1lWjpj1amt2bl0=;
        b=kXH3UMwgNfKkKJRJjNhzorC+kDuigaZQlHsQkj6bemHhGTppkXiBIwP2/Q/JYIC2OS
         tK66mWPJD83nFmnDjcWjANBoZPUPEgZwSg2zPIoy8eB6GpSUxT4rhzfOiT42O6iNG+4X
         RfZXNWUTonB0xPZJ0N6MrJLyE4OyN0kI2yW0dvwvES6d1xufljaw/kLim+TCk7dHRW0a
         g2vuXPRcOm4+fU//d4pClzrQwMNnMylvn+3QKzafs3/02p5kV66f0r16lYIxys4QfwY+
         bl+BvOQ3LRmo5tkBfuntuijnirLtLQm/eH/IgaSf5/nnHVVMNhu1IE+swJ927Ioi7oWn
         IybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748692; x=1783353492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wY5L1SkTbcuC0ovvgAOdSZ2ZO/9WR1lWjpj1amt2bl0=;
        b=Qxi+VuH1qKeGMVeWGBal/afmeL/iXTiXP1aRHgZjgKVbN2kEsiP/oRellZvSssh/gy
         ANkcbwEjNCDkP3ZjhqNrQYawiZs3X8lSpMYnJpOEfZr7ZiuHKrKaSXmGyOoHgoGiIC3Q
         f+3LxkaO/nWtg/JFSuxXG2e1pmXJDydkrYM1dt0kPH4pCYuEcZuC0aUPoX861NJEE/l2
         jLDbc7K3RUcP4tJi4qS1+SOHdMpUUpAwAHsxH3NsGZM4FjEodmuB2JNCEC1Jxb20YULF
         MK9EkEJOR8Ipvv8muXN0zZO1tG0iM85qGkTMQyZ64q9SB+2Y5RgyxelWs6OtMWoEZqjt
         IYUg==
X-Gm-Message-State: AOJu0YzFozeU03IVwVEvQQfFRG08EL/aHM3DUxnw/w4D1KpmEKuCMlvo
	vjgl/fizD0ONmyyG/BG8/wP3GWVtsgvQuG2xAL30rFSM7sARv0Gs0FyhA/TE+7qg
X-Gm-Gg: AfdE7cmIshZ+/b4F8OdWvJHy4+Iy6TegGeXGBtyApNZUMKx9Ml71lI3bGlzs3ssZrKY
	EWmlyfUI/etlOWkubv7mqXSSyPXGakvEKOtjK0tJ6hJv0EugcasczsUqZUXKCJRFrjiWT9f2u1t
	7xBp484i52V1q0/Kfu0l3YX22Hecfc9JcLz/OxXQLZ2nEmqr2MUkQtEvuttiQsv7DAtn9SEEc8L
	ysnmQXGItHkA629/f5Lyg0XPNP1yrqQPabx01TKW70jFa5oLE/h3owvKZdpSK1r2fcSnzGvVblA
	B4oAgKJ4CP+EIzQu0B2HSRB+sGsHhKRvaMyPpzA2SShXvGJ7K5NI/iPlP0JC+krrPEzUM7roMBv
	JKYhb2zFTrhj1LO41zGur4adW4vJKlwF+iFDH+lH+cvDGV5Iq/atWWqt8wQZx8fMVGz3mthnAfj
	hZ9oXtOUJtMLwR8Gw+TxvemtO2Ejc=
X-Received: by 2002:a05:7022:3d18:b0:134:dfd0:9760 with SMTP id a92af1059eb24-13b2a1603edmr28091c88.5.1782748691602;
        Mon, 29 Jun 2026 08:58:11 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139fc2ebcc0sm15673080c88.14.2026.06.29.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:58:11 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH] net: neighbour: add neigh_parms_lookup_dev() helper
Date: Mon, 29 Jun 2026 15:57:45 +0000
Message-ID: <20260629155748.715754-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-302705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paritosh.potukuchi@amd.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:petrm@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:mid,amd.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B11E6DD449

Provide a helper to lookup neigh_parms associated
with a given (neigh_table, net_device) pair.

The existing lookup_neigh_parms() helper is internal to the
neighbour subsystem and cannot be used by other subsystems.
Some stacked/virtual devices like bond require access to the
underlying device's neigh_parms.

neigh_parms_lookup_dev() is designed to be a wrapper around
lookup_neigh_parms(). The function provides controlled access
to per device neigh_parms.

The caller is expected to hold rcu_read_lock().

This does not break any existing functionality.

Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
---
 include/net/neighbour.h | 2 ++
 net/core/neighbour.c    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 8860cc2175fc..1b3b06eda886 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -438,6 +438,8 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 			  proc_handler *proc_handler);
 void neigh_sysctl_unregister(struct neigh_parms *p);
 
+struct neigh_parms *neigh_parms_lookup_dev(struct neigh_table *tbl, struct net_device *dev);
+
 static inline void __neigh_parms_put(struct neigh_parms *parms)
 {
 	refcount_dec(&parms->refcnt);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..6d32c2668af3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1757,6 +1757,14 @@ static inline struct neigh_parms *lookup_neigh_parms(struct neigh_table *tbl,
 	return NULL;
 }
 
+/* Caller must hold rcu_read_lock()*/
+
+struct neigh_parms *neigh_parms_lookup_dev(struct neigh_table *tbl, struct net_device *dev)
+{
+	return lookup_neigh_parms(tbl, dev_net(dev), dev->ifindex);
+}
+EXPORT_SYMBOL(neigh_parms_lookup_dev);
+
 struct neigh_parms *neigh_parms_alloc(struct net_device *dev,
 				      struct neigh_table *tbl)
 {
-- 
2.43.0


