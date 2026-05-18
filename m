Return-Path: <netdev+bounces-288850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIqoDKCeCmpJ4QQAu9opvQ
	(envelope-from <netdev+bounces-288850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:07:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B3565DA6
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A43B93003836
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F45238838A;
	Mon, 18 May 2026 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpFCEW58"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8D381AEB
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080851; cv=none; b=dc2VptxjOvG9vz1exYgwruVKsRAeIEzmYXQJAqiQyWFwfzM+iKENl1DHU4cQO0szEP0m3jLCW+EMtf5c7iSWjRc3OJ2bn/JxtkgUq4YQkrSxJngZTV9oOKcufKY9Bv1RF+AFu1pngxVYSHhgIUubipQR+MI7y/c2b/W27VOWUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080851; c=relaxed/simple;
	bh=p2kUmR9OMZpuB9L/Y9L4kCKti7i5xdNrQtslAwsXxbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=if/LVfg7s3FLcif7XeGRj8jxo822L1rdmVAFDxi6V0RwNwbchilh9JvxMPtQbtkiLLJtP1p+HdJXOpARdxy7DJHpl1M6ITHbk43TFZL5NgB1ZNHz9puFdXgDeoZZ4vzg9Rd3mkDo+bcU4pD+Q+w5524C/hlN8jCn6nrpc5wTkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpFCEW58; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827c880e39so734676a12.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080849; x=1779685649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTpLRpEczwI2cIxxBl5B8V5K2DZ0UU/E1F5sUbWiIOg=;
        b=IpFCEW58DohJj9Z5u8wIZGZ0KJ1DOPIaKh6EdadhoDV4BsG/OTQ0ZVm4XfON4M7oEX
         zco9F4gVVtoxgiO0U4xHaH0I3vMkc1Tf6oUvaoDB6qBcCMmlGEy1k23w9TnAEg5oG77n
         O/XCWDfhuBrtOUMrJxiRnZFPjLKm1Jv6qkmG4+3BRNG1JYhGTdZIi45x2S0Rqxtsfc/H
         ObPZ+ywZsX57MfLyhh1AGhWfAOaRTXj38R1nri7BvIX6INXAU00qW58R+0wHk9QSy/i/
         saoqa960qwVhito1l8L5stk8AkZJ5Zz5MmBXUmgOLFrNLZckEyzOnIk8TvFKVObnF/uB
         z2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080849; x=1779685649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTpLRpEczwI2cIxxBl5B8V5K2DZ0UU/E1F5sUbWiIOg=;
        b=E1dZ+wh59Tiv5GpcP7kofrt+jrISxin64AuHRM2b/EWg8ybhDK6GCZ1Xhw69dZoSbz
         D35s4fIy+A3HZgLphWkVODWkNmFBReuE6FaWs7XrIjVw/DzftFq2pVnHh5XWbaoccEGH
         x1zqx6i3gDVcVoMO/KG0fdVQajVf6vI+DZjU27syxXYb28o9YzBnmQgF5ImfjoVsYhYk
         8ZeoQvWJEcLiHmcZopix3mx9a54x3F8ws8/WirNw6NfVr/rmAQomJ15jj81/YCkSUfGC
         SeLEWC6R9w55qU5vTsi45WCjSv6z6xaWwErDfjlH9eSHY96nP+lh6GmDPu/fvaNWDl9e
         86SQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xCbWkx9OUA91Gp8624tC56WTWTFUzmkymXRaWoKBHsID0PAG+t2wsdyF6/DIWgvNNe5qDZkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4a2unc7iMYL5EYvbm8jTiTw9GUsQ6kATsTBMOesg1JhFP/9R
	jzehFXvKxSaQeZdYIl8HF/exLAGPGJoCFdT1GXpbV2a0EAf6eeLQL3mabOuc7eenlFeOWBwznVM
	L9UQLbg==
X-Received: from pfvo27.prod.google.com ([2002:a05:6a00:1b5b:b0:837:e90f:8cd9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:26db:b0:82c:6f07:299f
 with SMTP id d2e1a72fcca58-83f33c45c75mr9169807b3a.14.1779080849159; Sun, 17
 May 2026 22:07:29 -0700 (PDT)
Date: Mon, 18 May 2026 05:07:08 +0000
In-Reply-To: <20260518050726.318824-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518050726.318824-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/5] vxlan: Remove synchronize_net() in vxlan_sock_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2F8B3565DA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288850-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Initially, a dedicated workqueue was used to defer calling
udp_tunnel_sock_release(vxlan_sock->sock) and kfree(vxlan_sock).

Later, commit 0412bd931f5f ("vxlan: synchronously and race-free
destruction of vxlan sockets") removed the workqueue and instead
invoked these two functions immediately after synchronize_net().

This was intended to prevent UAF of the UDP socket in the fast path.

( Note that the "nondeterministic behaviour" mentioned in that
  commit was not addressed, as another thread not waiting RCU gp
  still sees the same behaviour. )

However, a week prior to that change, commit ca065d0cf80f ("udp:
no longer use SLAB_DESTROY_BY_RCU") had already moved UDP socket
freeing to after the RCU grace period.  This made the synchronize_net()
in vxlan_sock_release() completely redundant.

Since vxlan_sock now uses kfree_rcu() and is invoked after
udp_tunnel_sock_release(), vxlan_sock is guaranteed to be freed
either at the same time or after the UDP socket is released,
following the RCU grace period.

Let's remove the redundant synchronize_net() in vxlan_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 00facbfabced..8c3885665b58 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1515,7 +1515,6 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 #endif
 
 	RCU_INIT_POINTER(vxlan->vn4_sock, NULL);
-	synchronize_net();
 
 	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
 		vxlan_vs_del_vnigrp(vxlan);
-- 
2.54.0.563.g4f69b47b94-goog


