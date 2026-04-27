Return-Path: <netdev+bounces-281263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNz8B4og72ma7QAAu9opvQ
	(envelope-from <netdev+bounces-281263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C51FF46F3A9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D685302B209
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800B39B94F;
	Mon, 27 Apr 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+tmqUx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15D39B495
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278970; cv=none; b=E+qPFfEVBHg7yQOyNE0zClMcDNl28NVp4wLxT3H47qpDU4DQSvMV5A74U5QhQHrHLaYPgr5jFjzRWgmMni4OuRXRlgY/edDqeZ1Sqt0mN32vx8TzcCtDUu5BF+XBb+TnuFeznBOj4yTQvlh5+AaXPBf4U+HamCEc1zrHdShYIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278970; c=relaxed/simple;
	bh=htWFTsEWIvgsAK6g5E1xo6Hi5ITq5dmB7EK6Xng2G3M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HmTUsvmGggJigUa63C45wBoBL/gP683wD2DtyZimHgGJ+C3ZG6+Uji80EX/NqG+z9To/xKDIxZpT95KALpHtiyZaRrLINcW0ih1oZ6vc0evIefo3a9gorY3R6fIxY3U9OLaaBz6X+IVCI16uYkVvyFZWyGkR3vk9xDY0YemGjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+tmqUx+; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d8ed08aa4so58736341cf.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777278968; x=1777883768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hqqbdhMu1/ff85jQnwehJYCzoINBRC6PtCnNnnmFa1M=;
        b=G+tmqUx+IgAQw+OM+STIcAu3BIsIhBkbxIwzYyQDufCywfi/SaqHbgMWtQoPdWXelk
         ewZMAenvuf6Bxhgz4dTzbg/MC/8wxu1BckO4ElMIQxOEVKFhYEdINEMJ448IxMcKKCTX
         lABoskl7jSXktS/meRhA+R2WyOq+OOcMn0gPI/zJLSlrZoSnyj7gVqozmu9gB7u4uoyI
         Mz9NqxeubHkEvTUd0n5yZtG34Uhdy3IKQtipke7NaJSggIwO9soM0ueGQL3724mUF1u+
         LQYDpoIG0V7GN/m93YpM5lkfTJyOlbLVJDZPgbYK3ShKQU6PQnSETL4nTRfVGPNcQL5y
         jGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278968; x=1777883768;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqqbdhMu1/ff85jQnwehJYCzoINBRC6PtCnNnnmFa1M=;
        b=ZJclU7L+MPrvx9PiTJw8hzY87RaVTsh5zWkzJ1REB/Uv6MkBH1sycbd0JTJMNiflAQ
         Eh3+dfxr65nOy8aHk23o67Z/glY8iZ+ZAs4U3lyIF6gthyx4NOp3iMdprqRRJJLDjnNU
         ah7MqCIiP0xHnzewC1OjiBX2JQrdjbePFOuyswbN217w1npxggJulPPrJuy4LnQyQEPj
         K/iheSyTNGEQHpbCNYCeZUv01yw2aV//VqJdNfgZ3GZUfCICfqz0sQ91+dEdANIgdg2A
         C5BqHpsbNdJxmGk30tvovTOFVwx34XKzn5DzZPlpKXBnJ6eesFHxj8BpAkw0AUdTldrG
         kDUg==
X-Forwarded-Encrypted: i=1; AFNElJ92PxDdMcvitneAMNtiPQftQF1/HfvsRaH1qtkqVXHt912SKm2LBUhXO9ZK+NondynN8WPi1Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIbxi8FHvWjZRXn8rawTesyi7nU7BRcaGsHaTwCn+C1tKX0+U
	+torcbfW0yqi28SGX6c4Fz4IHCcJmlOxv9Xlohu2WIZ0XRJEPqSU2a+8ExSj8eouObn1Zi8GYbY
	rQ6S9EsB2BeJs5g==
X-Received: from qttr11.prod.google.com ([2002:ac8:794b:0:b0:50f:b41a:537c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7dd3:0:b0:50f:b260:cad7 with SMTP id d75a77b69052e-50fb260cf0cmr406663541cf.41.1777278967623;
 Mon, 27 Apr 2026 01:36:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 08:36:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427083606.459355-1-edumazet@google.com>
Subject: [PATCH v2 net 0/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (series)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C51FF46F3A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,redhat.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

cake_dump_stats() runs without qdisc spinlock being held.

This mini series adds missing READ_ONCE()/WRITE_ONCE() annotations.

Original patch was too big, splitting it eases code review.

Eric Dumazet (5):
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (I)
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (II)
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (III)
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (IV)
  net/sched: sch_cake: annotate data-races in cake_dump_stats() (V)

 net/sched/sch_cake.c | 217 ++++++++++++++++++++++---------------------
 1 file changed, 113 insertions(+), 104 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


