Return-Path: <netdev+bounces-263392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCitLsw8p2mofwAAu9opvQ
	(envelope-from <netdev+bounces-263392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:55:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95571F674B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BF39302A6F2
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76F3890E2;
	Tue,  3 Mar 2026 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3mtLeq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FA38645A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567753; cv=none; b=mf8FJEuGJMh7njT05eMbGpgVuMAHUg2Aci5An7TPpbmIb4zEXDO2a14VQuRmIp8TvjusFa9GARpEHXobAJKrwibtkW9BM+mCL12NrhF0P2WDy2y6fgqptnZkvLXe2vx5KhLde5mfVAzklfibU0KTS5RustHyXz65PM9oX8QPz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567753; c=relaxed/simple;
	bh=xCB+gUvuhiMj1a0fMSB9Z41DIUR6vugAoq4q0yEs7Gc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WOZmtOC5cTHXsEYy00qnJ0yId+L5K3NujB7YPPrJYTANI6kUD8pe2XOMbpgmM9YKxHNiNFqhkLbb5ADHMMt5a5ILBxgcAXG9HHQug6rRLNunC+L4QY9Fgp17KkAenoaGWcmlNpYK6ZQql0N/k1IJMSUcjtS3d8Kfk9742siD2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3mtLeq5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-827448e844eso3325403b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567751; x=1773172551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y0qcUmgK82L/UaWD6aUQJpUbsOWwly7fscJPcy0f4xE=;
        b=J3mtLeq5cMF4efL5QzMW3InDoaPlxt62fS+4I3KLKdbGP6SHFW8PZzcf6isDnlCFIg
         QwLF+L3yVzQk3uHRyeZg1xp+aFcrElgMRsJ1iJxO/l5dM7tdl3fpS0+bHYOCbPOZS8AH
         796L2LywlEEk1drJ7aaTQ5s4nErYNyEgQo6/S3IX/CTbYN3BimBPO9XDS4X8q+BE6dEu
         QHHdfkbRhhP7UJnIyAzB59XrzAKgA/WckTEdI6hMVb7Bi28xBJORSmg/EVnwIZ3sO3ux
         BFRu/qe1jIUAwweNektN4ZRtfuKn4xSyswYWVngXZ1dXHFim2QriRMM0jMH4iYVxf38A
         dDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567751; x=1773172551;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0qcUmgK82L/UaWD6aUQJpUbsOWwly7fscJPcy0f4xE=;
        b=cJdINRG9pV7gPKC/BdpZ5tAqOAljD7YcHAdzY+pX3EGbEJgZ8BD9u8hgVE0xAWwbRE
         b/EBchZFY8ne2ncFtb3IdzwrMvUbN0ObxfbcIw3+/6a1OZPMyuQOA+NMLZHFLqeQMFcR
         epvT+Z6KFVJdzFCBRogXsX/zp69SqH3nMTUVgL2scMb1YEeameqx7W6n3DZWThemxTAZ
         3C8RaTW/qZSJJ7dgFaPM3W5mNvPPCHfXeHjXeeJ1GAME8XJfukwyclswgZd2z+MxU2Ji
         bcRbLD51bvsksGQ2qxrMwkFK206DKQVfLn7hWFkMahCZRleduOfQpk9yK9qnsUJFcDAw
         hM+A==
X-Gm-Message-State: AOJu0YxAoGDPLBnMObV/9zbQSutjh5YAvMg3XkmqXRUMxz+Fg2RJWtQ6
	A4ETLM3FgUJCsrX6V7d4lddl8GBUSrmPWpXZio2xqbF0nNd4oB4A4+uKmveyRSg1DixBOthGeFE
	X2m/5oVkq6Pi5MVae2elmVZgyeIizSYKfZguDK1SoXEdXZqJNMlq1MH5cOnn5tp8uHDrJ9yzqZO
	xUwEAXOpnM/UOx1reILvc1wDUNtZkT+APcamBkMxSK/rQ474s=
X-Received: from pfwo12.prod.google.com ([2002:a05:6a00:1bcc:b0:824:36aa:8d0])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2341:b0:81f:9a5b:e8fc with SMTP id d2e1a72fcca58-8274da094cbmr20670261b3a.54.1772567751119;
 Tue, 03 Mar 2026 11:55:51 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-1-joshwash@google.com>
Subject: [PATCH net-next 0/4] gve: optimize and enable HW GRO for DQO
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E95571F674B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

The DQO device has always performed HW GRO, not LRO. This series updates
the feature bit and modifies the RX path to enhance support. It sets
gso_segs correctly so the software stack can continue coalescing, and
pulls network headers into the skb linear space to avoid multiple small
memory copies when header-split is disabled.

We also enable HW GRO by default on supported devices.

Ankit Garg (4):
  gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO
  gve: fix SW coalescing when hw-GRO is used
  gve: pull network headers into skb linear part
  gve: Enable hw-gro by default if device supported
--
2.53.0.473.g4a7958ca14-goog


