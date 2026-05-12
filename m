Return-Path: <netdev+bounces-286942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKu5HEisAmoLvgEAu9opvQ
	(envelope-from <netdev+bounces-286942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:27:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DEC519936
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B14300C589
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D83315D49;
	Tue, 12 May 2026 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U72gxAxI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E412147E5
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560068; cv=none; b=oUWBg9QPLvh8WiuT8P+vOJIplZs+72P946up63cv4RkuWNBrp+GiAHyGw4c+SLFasmNaFL5/MRzqi2cf7guTvhfHu7nwfJyf/VZOzr8WIMmXXDolr6Zg7w+LJcAOXcqPVLVzIuBMpd/uVVn1xzhBQittBbSqwGROnFACXf0rLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560068; c=relaxed/simple;
	bh=xDJRaH32+yLusjVCAxK5vM4WnqrNyjYXf93abkp4NCA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jL9rejQQf27SAj1tnj+PFH0Gc8MXqTJoKbfjbx2xW310nuaxo1PfxL4v/Ipy0qCFW8vIy6fY+Kd3V/hAUDflKCNF+iTX0U3finEpdOkQV/uq8eXnjeCFawX+OpemFjnpHeooEx733oQKQLj8q0VUTad5uBX8j/BX480I5eNiqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U72gxAxI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso7368255a91.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778560067; x=1779164867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VZ+XWn2dXgyyjtWr2zeGi8k33vMJN6tP8ZYBTU3y9Vo=;
        b=U72gxAxI9diOn3/GBkMcbLpm3ClLWdsADsX7nPgeIt7RuEYKqHdCw4mRq8IMLMhRAh
         MSNhG8UkwQ7llbyaX5Cn9Ihj04a8cHjaOC7bVqie6GYPzgJZGf7ZYWBT9BfTBDDii+wW
         mpzGLMBw04nsBf1iwVxkth8pS+Mrmm/wzcsFy3PouhippNdOqUGjCjrqzPZu82u+4vrx
         SyoLzM6S6Jq87ADggHegXSsuTHmv9YEgkI8llUW4a6zCzXR6ios1ENpSJOAAgvn/v50S
         oPaBSA4pFLSdypta0mUAVdoJw/P5k/uQz9dOPTyV1eNCS2acramkWnrFWtRBGX+RdmKM
         JuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778560067; x=1779164867;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZ+XWn2dXgyyjtWr2zeGi8k33vMJN6tP8ZYBTU3y9Vo=;
        b=AKoYBO3yFzHk+K7tIKsCCcSQ2VLWLZZX0IxiY4HKsly2peUYZAipsgQ2ECne5ZztUR
         /mZGgjibO19vbob0D37QpveF5EqT3cBEWVbS++Z0ThqWWQ7UQmWQ6JzOKjjW+RSBz1km
         khC5eBhWdzCLb1Y6bogIwd3B7otSJY6nj/wJEqSl8idljy5o0IbGAMAZMtgK8C5Xe5RV
         2UpFoFxHnLUOMY+3eFIKwQ9BO7lwn8uoNzMo0InD5MUZhxsGzXD6tRu7mqNUStsZ+kC0
         innYGUobdqe5a310/I+g3/Z9jDs6JWj8erz7X64Jwdm3bI7S2Dh9j4PtGfbWjSeQbuFE
         qjSA==
X-Forwarded-Encrypted: i=1; AFNElJ/CKAePBxe+6VqyjMDAUIhqeHLLoeW6OqPFyjVnhFd0JyCMp0ZYIgvze2SDqVIKEqWSeTLQSsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+N8SJH3JtNtH5AxwVwQvEGYxJHkM7KWIgKkl3p3AXB9Ks85G
	z/OUAEH4Kcl6Ltb3q0Jo66HnKIy4tC/GFo8ZoesU4iISkA5JYDSArkwmIasGB0s+MN90Mzwa6CT
	fFw9J+/9y717/0g==
X-Received: from qknud4.prod.google.com ([2002:a05:620a:6a84:b0:907:1c56:2cbd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a14:b0:8cf:ebeb:c27d with SMTP id af79cd13be357-90cfd74216emr189197585a.54.1778559619867;
 Mon, 11 May 2026 21:20:19 -0700 (PDT)
Date: Tue, 12 May 2026 04:20:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512042019.3300975-1-edumazet@google.com>
Subject: [PATCH v2 net-next] ipvlan: use netif_receive_skb() in ipvlan_process_multicast()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C7DEC519936
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286942-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ipvlan_process_multicast() runs from process context, there is no
risk of stack overflow if we call netif_receive_skb() instead
of netif_rx().

This avoids some overhead adding/removing skbs to/from a per-cpu
backlog and raising/processing NET_RX softirqs.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: Resend after realizing Sashiko's feedback was not actionable.

 drivers/net/ipvlan/ipvlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 1be8620ad3971d281fb36fd0770efd67b566ae60..7ad12dc7845c836bdd04395f153b2b4b397797d6 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -286,7 +286,7 @@ void ipvlan_process_multicast(struct work_struct *work)
 				if (tx_pkt)
 					ret = dev_forward_skb(ipvlan->dev, nskb);
 				else
-					ret = netif_rx(nskb);
+					ret = netif_receive_skb(nskb);
 			}
 			ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, true);
 			local_bh_enable();
-- 
2.54.0.563.g4f69b47b94-goog


