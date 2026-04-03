Return-Path: <netdev+bounces-274984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEjREO6Yz2nmxQYAu9opvQ
	(envelope-from <netdev+bounces-274984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A75683935BB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 12:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDDCE30086CF
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76A2F532C;
	Fri,  3 Apr 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja8FjkWg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C8155C97
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212620; cv=none; b=gDbl10D2mOgTrkYadQKjt3kDbz7waZc0jvobbqfoLdzdmmrLrbEgevaJPNIukClXnesVkFcpikf9KRREjtwW6qJX1kFViPZaU5ZmtJPsGIjib1w3POllpgJEKfMdiGvTP333U8vljbOpMxlD3jnW6JZCq4eINVK140FDahN+82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212620; c=relaxed/simple;
	bh=vWjSW2LetUFVeiNT5Uqca+q2/U5GRA1sAIUfc7E7540=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=isQGHtEgyvmTkZPqgQYhatEPpwlUKBpJv8D7gYGHZqmyub78oyiyFITk2YfGS+muPxy5wvZmZ1bvrwJNyTuZnNbCvvGzp83vbvszUjbHKTMp2+cors3sPehYXAK1eufQeXeVoE+K5MckpZ/Ki2FaJdKWNxj37AXPHSNYICYKkwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja8FjkWg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d029f346eso1680023f8f.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775212617; x=1775817417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHvyame7ynNMd2bmiAmj8I34rTsgL2konQsfxo2dEws=;
        b=Ja8FjkWguhvZelKKHYqcLWZqYJsFNE2P/ycr+mlGSK5M63zS5Vyh4OEP9tZMUIXo7u
         49tVpl52w9MI5fW6FmAcTT9Ws+7A8G6Q3z9uPWEELZXrzua9pBci7zv2C3yKSkAJ0ZDg
         dNkWUPLpn4W6Yqjnh6Qw6V1pl7zXEgjrL1k/Umc48gOtlhYJ0Bomu96Nf47KS1s02EwX
         PAPrD0tOUN8e/T/XD/1BGRB+Zb8VluBzyIpjZKHtfYUJF5BtArfAwB9wHyRnSYUHXvs1
         8PHIyzimRGQXPG4VTVbfK3dFADAKJ+xdo1P5ljZRC6wI7qrYcsRnON5RCwiJFnqBKn+M
         O4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775212617; x=1775817417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHvyame7ynNMd2bmiAmj8I34rTsgL2konQsfxo2dEws=;
        b=qkreqLqHBQ/lVLHcVBZfloEkWeqWK0fi/r9Jwfe08+7Op7q79qENfDStK46GG1i9a1
         XPj39Wx/huRhep19exybDc593OoNx7DPS86UdO+YHfob7BSq5Sd9eIUGzUcBC5OLSrlx
         DFapzzsCnODkpcGxax2v+ZtfBqbgWbWQ4QXZzGwXFemM0Z83H1EKkM6l1B6LZszt33Ri
         SUaJGNDqtdY/4eJwxzAK4ZyXdfy04dvMvZuEkedkmVSzqTnVcFs+qKd0X61sA6G4b7Gq
         ESo4OByWRXPBcktWfwDKoC/Fgw4pWU/1J4/XTyD4ktyzNdItJTO/3LImuPUMLQRrJs+T
         JtXA==
X-Gm-Message-State: AOJu0Yz3F0m+A2/w/J6/j1qaPsG+s+qmKhW+dY1CwNCymQ7jfJG/W8nf
	IJBBVfRH9yF9qNzVU89ZBNDU7R4keOK8mQvcZ9KfZEds5EJChePQidZU
X-Gm-Gg: AeBDiev2LXfqto8oM/Ak47GAvOupvMkPRcPtV+rkhIY3fL58plvvGkZdc2LocBgecDD
	jjHmeaZztl1+NZGvr7neq/InVaFh4B4N/PRw9BbxzJfgiE38sW7sBh2N3chVgMEj8Wy272XK3Sj
	I/1Xt8EHIzrjFimnb+CIK7ibE3UCqArQV4USiOUZdwhGAfsVzuZWhtvSnnuyyf/ak+JNYeCUc18
	tn6iYctSfYYfrvH+o0UkseAW8S6oDnsZtxvYVfjwCgmbhQ8BDInJw8moV/xpLPCLcnkQ8pd8u5W
	AYn/wYTpYsMtNIvUV7h0pdj6D+j+a/h3lbWdPzfS3kC1Wix7LQBAiHL0I8NJTpinm98gBdugjQd
	U59iKfTJA6jlFakML9GQ0w5vW+2Vtr19ICpfasmiCPw3L03d4vy7tFd7GLygIzVZ0OGOJ9vRdS1
	0IZYuIJkg/bYsNBOGzoaL5Ro7ldJHFJBUqsNDa7osmRVBWpiTzq2GjpS4kzVXPXC+MS06ZaKMBO
	kPgVJ/T8Utt
X-Received: by 2002:a05:6000:2409:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-43d292a92e4mr4142678f8f.20.1775212617142;
        Fri, 03 Apr 2026 03:36:57 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5468sm15377225f8f.13.2026.04.03.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:36:56 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: "'David S . Miller'" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Qiliang Yuan <realwujing@gmail.com>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] net: use get_random_u32() for net_namespace hash_mix initialization
Date: Fri,  3 Apr 2026 11:36:54 +0100
Message-ID: <20260403103654.15304-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274984-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,suse.cz,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A75683935BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use get_random_u32() instead of get_random_bytes() to initialize
net->hash_mix. This is the preferred API for obtaining a single
random u32 value, as it returns the value directly rather than
writing through a pointer, and requires no size parameter.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/core/net_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1057d16d5dd2..deb8b2ec5674 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -411,7 +411,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt");
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt");
 
-	get_random_bytes(&net->hash_mix, sizeof(u32));
+	net->hash_mix = get_random_u32();
 	net->dev_base_seq = 1;
 	net->user_ns = user_ns;
 
-- 
2.53.0


