Return-Path: <netdev+bounces-288849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIRlCZaeCmpP4QQAu9opvQ
	(envelope-from <netdev+bounces-288849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:07:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7FA565D8A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 287B13001478
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D538657A;
	Mon, 18 May 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0y0IMoi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D5380FCA
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080850; cv=none; b=Ndh7i2GmhvAIq2M79NMkXXuJEoNGM3dIYufOHmE920yMxrJ6ZukAM3vm/++oqK1BRYqId+2Zvk42lquuIaX45XgIPAVT7eEABkP8+7mhxycvSNE+W/r5Q561mUpNOZAyVxT1tqNszHvihDzb4EayNSUL66mwhpitOyVbwI5zeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080850; c=relaxed/simple;
	bh=lexZUGNO0PNJEtr8UkTVyVCXHd3QoNWeHgyDWj95snM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HM537GZfFHf6pOMmgsYf8cmOOO4I4QxE9neoRirqVW5AKCH5OfP2AX7+2lgvqkTkQCDl4EDIahYfRqA2mZgRCsud4etdYhC8Q8oNZIG4J/rXFFV6qG2fhEXTM0Wk1nOfNj2WlczPBNDy6gtpso1Sdv/9mMX4ZeYXTlDjzihe2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0y0IMoi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baf7748d0aso17982525ad.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080848; x=1779685648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F1yKiJK611v41kGbVyszyECAdp0vIakrs65Yges67SM=;
        b=r0y0IMoi2AI5PalH2aiL5jtTjGf5JrxL4j4yS2QWNj3iXB6rRHasDWpvEG8qv0KT/U
         mGSlyTClW4YsTT2azG9/hQH7WW5EuolbL02nK2exu5DJlNpIKUzoOHT3qjK2UxOPDI20
         3vngmbe30FMY2MeZYAsWT1mzxKNXF5D96YevEO8uRjQJqKM3dDxihD5Ba9wpGdBkjLIS
         +K6//FkTY0c0Gzxb8O8onJdxa5gNdIgxC2xk+8tf8jwIsqvOr6p6hzqjFGNj7e6DavO1
         GsdzX9FDXu6scLhtk84NgX3m7CAjRQA9cGMKjIncbkiVbbNJ8PN7eiUmDfEuOPc+MQuD
         hKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080848; x=1779685648;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1yKiJK611v41kGbVyszyECAdp0vIakrs65Yges67SM=;
        b=R3TisxAjrLR96x2LoL4eAa5DHfSSVVtsyvteGl2fGqSKPBZoMyJC38C+ktr1uicw1O
         n1EUhvxVD2fCnjqefewxxXpfvDoK5bKE+4alBhVhyulw8hylonJ0RXjGJz1eEcKlDZwh
         Sfbl2iJS2o7ZDLq5hsjoWaUuaHOv7DCxnlMaJon/AK7qYX11IyQ+iPmGJCug6b0KxB7N
         ZL1TO/r3hrAGVI/TnYfDM6BdUr2puRxs+Gn0fRH5t3/nuDDzqQRVgLeWEE25BDxkCY/1
         isXGh9N5eyixFYcna/p4weOXlCPokxfJp6QPilI3XqpqtUGNLAdjKbLGfBhqEFzDFPl9
         B45g==
X-Forwarded-Encrypted: i=1; AFNElJ/mSzojuMQyIEHsKKmsNN/9qkfu2mIjyZgy6emfrXQjc2zL6Wx3mO657vxAP8vkZfkuBtRj4VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzDSb7tMIiRT8AdwR656DvxG5PocnUDyWQEd/zhzudw5haP63
	mHJMO83jZSnwDu4SvwxmokzNMj+E1O31CPs+M7IvAYa/yR7neyRt5k2puZIShcejPUWu8ZQU1Pk
	oqIT7vg==
X-Received: from plsa8.prod.google.com ([2002:a17:902:b588:b0:2b0:4f86:510])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f87:b0:2bd:b6f4:4500
 with SMTP id d9443c01a7336-2bdb6f4475dmr66683595ad.11.1779080848417; Sun, 17
 May 2026 22:07:28 -0700 (PDT)
Date: Mon, 18 May 2026 05:07:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518050726.318824-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/5] udp_tunnel: Speed up UDP tunnel device
 destruction (Part II)
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BE7FA565D8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288849-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Most of the UDP tunnel devices called synchronize_rcu() twice
during destruction, for example, vxlan had

  1) synchronize_rcu() in udp_tunnel_sock_release()

  2) synchronize_net() in vxlan_sock_release()

The former was already removed by:
https://lore.kernel.org/netdev/20260502031401.3557229-1-kuniyu@google.com/

This series removes the latter.

Patch 1 & 2 & 4 remove synchronize_net() placed before
udp_tunnel_sock_release().

Patch 3 removes yet another unnecessary synchronize_net() in
geneve_unquiesce().

Patch 5 is a follow-up patch for a sparse report by kernel test robot.


Kuniyuki Iwashima (5):
  vxlan: Remove synchronize_net() in vxlan_sock_release().
  geneve: Remove synchronize_net() in geneve_sock_release().
  geneve: Remove synchronize_net() in geneve_unquiesce().
  bareudp: Remove synchronize_net() in bareudp_sock_release().
  bareudp: Use rtnl_dereference() in bareudp_sock_release().

 drivers/net/bareudp.c          | 3 +--
 drivers/net/geneve.c           | 2 --
 drivers/net/vxlan/vxlan_core.c | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


