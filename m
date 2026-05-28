Return-Path: <netdev+bounces-292569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEAoCjDkF2otUggAu9opvQ
	(envelope-from <netdev+bounces-292569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975BA5ED5CB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F7973022AB3
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F2335564;
	Thu, 28 May 2026 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwd0bB/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E232143D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950637; cv=none; b=aE/pP7Y2QEF/KtU/zom9DMRjQ8JS80MnkaS6ACipDWQzvsFyN3+1UcJofldFHUL6SyX+gi+M9ImdR7enL9Ogyz09iqEN5CuOY6mhwd9YabotLtVOhFqoqjApWYLjVEl/rZbaHiFcQS14VUPuXD63t0CbQG0LlVYZhpLfgV5/EUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950637; c=relaxed/simple;
	bh=FVVTsYJTF2e7bLuXg7RDhzR2fz01nujdVpYjmQP3WYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hjs3mmmttmcH8qGNlT828NeCZQ2/AIvo4RpjPqKz/R4IbLO+X+acPFRkEd/INzSoX2bBtSHYSpjrUP7t2l8Z3oet0K5f9HfWQ24MZLSdwz9jmHAzctHJPySLsGi8vJcAw6grBlKh3H07asjRO8nlROaAqsBrJEJhpI7+5V1Cu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwd0bB/D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d734223e4so7815867f8f.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779950632; x=1780555432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIMAjveMjrmBbIqxPwW9V0vcTecYVP+AHHLTYlg+7H8=;
        b=fwd0bB/DTXksAfd4NNxVwjc72effjrmiSz1t92eRsT+txSnPCpeYNyB6TTwoYvnpyy
         0Hxu99bKq1YviNXfAx53TYXbcpS7SfkqpGMDHwpWJgCGqdjalhikrpeG1wYM3VxhXkLr
         4xjZn8GuJgrJWK9nnCNu2zI94LtARD+Fva/scsopY+HnXbkQkNhsnz3P8SfWVSRNehLb
         ZEfoKKbJcOqMNh8qBKbUj9aX+oQsPkcaBExJdW32jOzViuy+jqVRbFH5SBbSmj8CPEb6
         m0jL3y8LuX8bB02RwmlXEICPR1nvg9UFltc3MUXoSfm8lAqwAURATr0pdgWi8blxtGgn
         rTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779950632; x=1780555432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIMAjveMjrmBbIqxPwW9V0vcTecYVP+AHHLTYlg+7H8=;
        b=nH6JfMRsdw09S/ecRo/EWbu1fE3Wk3Un0z5m1x5FD0ycDYQr6zIDaqL9Cg+E106Jsu
         iOfs10FFsTzkYWavTtx/6hfQoqrUn0HsQ1SAtJqI7+PLI24kNetOAJa6fRvFQ+z96/3C
         +YyVq2dmaysiQ2TEXy5Sk0kNtumPULh7UFX8x5y3hFKMk76P4SlE081UoYhZ47J+ZxrQ
         bLoCowyf0mVJ0hwr6jPk1Lx/zXu6sdNVyJ6wmhFTwjZlaVgFTAp9eBZjHm0hjG2f5O7J
         CJ4oo/QQ13tLYFheBLQRGLjDetALG2poXYPsJlECbsHlNnm3KkHuFrGMoaIBzhnXM0W/
         5ikg==
X-Gm-Message-State: AOJu0Yws4ELxtbV0DuvitvgdNQHxBHpqIA8xdnj41xgy4uRnFoAbdhzp
	cypVN8cySiutu9Tm84c9DPdzNm8lSrNtuCaZOeQN7OPESRfWXx/3tT9SGSUSFXY1
X-Gm-Gg: Acq92OEnUS0atkrfkqZqzE9Bh0EgYMq2SYd5WBCrUs7ESIj4+/pGFkvoTQOVeUxNii2
	MT5R4dvQB6gDGuZ4uaID2wv1CMzcmmGE/FnOuex9VFFpKbjLb4le5hu+4kfzkqvt9W1ijnV73gq
	BLgPDhqrs/7H3ftT9Ic1Wn8CjLZps4PKwiZ2j0XUgk343NlAK72GcGQL4ro7Xzd4MLrgcZd8GwM
	izVOaVKfUnBxCWdAO8VQ3UJkmvyCeEyDs0ntM9RVhBLVNbBCrZdnxj/eL00Ub54R4DpKUnJSlxu
	RwqerQzAy2AtHde3L8nltSgpdqpJGLa44JvEQ4T9qH+1nvLUQ0lwJNnMPatqihjOBX3AOGR70ms
	IjMrOCbwiq/dOb8txlUVGm7LnkR05T+SPkK6Y6pO1aTwl1SkVo995x8Ik6yPjHHzYMNK74ogfrh
	SevW3J2093YSIqwbo6WrJG0lyhSTUODsfJc5HNTnk4FpL8Hcxt6ZufuQ2JCF4hdmU/EA==
X-Received: by 2002:a05:6000:1842:b0:449:cd74:7432 with SMTP id ffacd0b85a97d-45eeba61e70mr456729f8f.15.1779950632210;
        Wed, 27 May 2026 23:43:52 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm10934563f8f.11.2026.05.27.23.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 23:43:51 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	sd@queasysnail.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net] xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
Date: Thu, 28 May 2026 08:43:49 +0200
Message-ID: <20260528064349.5512-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292569-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[secunet.com,queasysnail.net,redhat.com,google.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email]
X-Rspamd-Queue-Id: 975BA5ED5CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

validate_xmit_xfrm() returns NULL both when a packet is dropped and
when it is stolen by async crypto (-EINPROGRESS from the offload xmit
op).  Callers cannot distinguish the two cases.

commit f53c723902d1 ("net: Add asynchronous callbacks for xfrm on
layer 2.") changed the semantics of validate_xmit_xfrm() returning
NULL from "packet was dropped" to "packet was stolen (may still be in
flight)", but __dev_queue_xmit() was not updated to reflect this.

On devices with a real qdisc, sch_direct_xmit() handles a NULL skb
gracefully and async completion via xfrm_dev_resume() delivers the
packet correctly.  On virtual/bridge interfaces (noqueue qdisc),
however, __dev_queue_xmit() takes the direct branch:

  rc = -ENOMEM;
  skb = validate_xmit_skb(skb, dev, &again);
  if (!skb)
      goto out;          /* returns -ENOMEM to the caller */

The packet is in fact delivered correctly by the async completion
path — the -ENOMEM is a misleading return code, not an actual drop.

Fix this by returning ERR_PTR(-EINPROGRESS) from validate_xmit_xfrm()
for the async case so callers can differentiate it from a real drop.
Update validate_xmit_skb_list() and __dev_queue_xmit() accordingly.
__dev_queue_xmit() now returns NET_XMIT_SUCCESS for the async case,
which accurately reflects that the packet has been accepted.

Fixes: f53c723902d1 ("net: Add asynchronous callbacks for xfrm on layer 2.")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 net/core/dev.c        | 10 ++++++----
 net/xfrm/xfrm_device.c |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index XXXXXXX..XXXXXXX 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3846,7 +3846,7 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *
 		skb = validate_xmit_skb(skb, dev, again);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb))
 			continue;
 
 		if (!head)
@@ -4552,8 +4552,10 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 			skb = validate_xmit_skb(skb, dev, &again);
-			if (!skb)
-				goto out;
+			if (IS_ERR_OR_NULL(skb)) {
+				if (IS_ERR(skb))
+					rc = 0;
+				goto out;
+			}
 
 			HARD_TX_LOCK(dev, txq, cpu);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index XXXXXXX..XXXXXXX 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -191,7 +191,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featu
 		err = x->type_offload->xmit(x, skb, esp_features);
 		if (err) {
 			if (err == -EINPROGRESS)
-				return NULL;
+				return ERR_PTR(-EINPROGRESS);
 
 			XFRM_INC_STATS(xs_net(x), LINUX_MIB_XFRMOUTSTATEPROTOERROR);
 			kfree_skb(skb);
-- 
2.50.1

