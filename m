Return-Path: <netdev+bounces-267524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEpsDuM1tGn4igAAu9opvQ
	(envelope-from <netdev+bounces-267524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:05:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3C286A4C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B783A3307B10
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA67397E7C;
	Fri, 13 Mar 2026 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOb3jN7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A73644C2
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417583; cv=none; b=qkVT1LMHHXLGF/LDujCFfp5+7WvVpFPzgDB1dZjXvwsO1ZcKSO1j3QGTeoexmCDYGo94ecPeINj6/LWv8NYUoJHlItOzIxcFgopDxRvi8yXR35LIy3uDoQ8LNrFeO+ugmYrVdOVZfJeApjSyyQ2gi+RhbRmgG1BME/HaNdiujcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417583; c=relaxed/simple;
	bh=NyQFippQ74CodrMrlfSTpe5qF5LdoixIWssiHGDKBDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVNb5uUjPCCrncgayqh7om3kL68DC1AoM8wtCm+LL427pNL6Oz1gIVA83X7NyRJVcKBnAVrqN9wU0rDr5E20h8tWbG/BbJeb5aA1dKGJevibIJItIbFRZdOcE8fHD5XP6ZKVtall6gw+rjGLpvsTisL1r6tLm1fplpPes/HL2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOb3jN7S; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so2319358a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773417581; x=1774022381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi657OdBqMCYto0UR//uTDdiGRQMozF8/CvltdPnQ44=;
        b=OOb3jN7S0wabgwlc46w3Zk6vZzNNsVV52cKEAmGNCuLjgSEJUmp+D+G47OSEdhqLQF
         h8go/uT8U3yGPyghZZhCk2DhglWTvlSjVKN4DEiHvL5vjvBuEASrfcirCGiGPCW5Fxat
         NLld4O2Ppkl4EATZvYy+ebpy86poiIFzobMRFC5rWMwVefm9WSgf63WPAbAn5Ty2qGCx
         aQXcl2S7j9o8lF6P3JqshbpcviaXStn3aSGZZ1RrSpJ2jgsuMIiSOBze20h+1QfOsBuu
         yeMX5LzB3gBHBrfSIYFWqmd5fPi4KoCUAx0ajfCg3Kwvi6xTfiAFQY3EHBaOWAv9A0HW
         rXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417581; x=1774022381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi657OdBqMCYto0UR//uTDdiGRQMozF8/CvltdPnQ44=;
        b=PnVdW2Xs0GiUaecT+YPMW9AEVCFWHfwpePqcaXgdsCEwguSrgYKxkPdeCZ/14BX6jw
         lzR++w3epK0ZNakY4BXZMFu4rylawA0EqaaZq2oZ6MYeMh9SnMC6MiF2qXzE+sGNU060
         Mj7EMW0cUWcLiqfZFvjKpUfugouuTj04rvvWRApS4nYhW8Ou6S+NGhuedjDimbJboZ92
         ghrEAun2RxLDcuRXsh184y+XLkCh+ssT+jZcdyi/LGSLCWtrWBzTgmqfdMJym2lesjIO
         SKoBZsAA/vSB5NLNls7ToklEZJlHJdR3aMgEdwD3fqbAVgLbovib3YBQPcchqQhvRs0M
         Vwtg==
X-Gm-Message-State: AOJu0YwFg1mNfTIpFGgwmb/XQqddjQDI6NGSKdD46pAnIgMB3aMLN9Xm
	CFmt/byX5pVzVXmRyyPav/3FcIiBDAMrtH19heMhai7lKUHaBjGKnd7sP7R7wMOe
X-Gm-Gg: ATEYQzzwq+IIRx+wdI7CH8HGqNXmGYRu9D7nEtteANuQVJwFbaxQ6AjZk2T4AxcjpQR
	7Akt9N6oBpDWHsZwtB7jhB8rJA5PVTQBL4/b44uLOmFCXKG+WTvIDGA/iJs+LPvjT1wyQm/zF2X
	mcGAajzKaaQNWOBbzLYnNGjFda1WPW9vENM/lwTbs2dG+149zo/ZPo+EmzN/c0U9utmbhoRsX+J
	Nj8Dr3Gd19i+d/J0t6BUbe8nXsBdtpk+G+SzsBYxYGmLSk9VeRQSHr5nH6exeplu4Q+eultChZl
	akbNOmhE+xFQNQtWPOVBtoRny/21fQUKxbiRAhOWjdlTlzIwY78z4ChBBbjpiXdnrZr8/0XcQvi
	SEQTvMdp2ZDNQwhak9sakMhfORhCjOA8Q0fnyQfkeIEwv6BUML2M9ihyeD2Myspa7TH1dbuc8iY
	EnxAwNJhg4+oC0WVNBxj4+QXZe9jid6TcmdBk=
X-Received: by 2002:a17:90b:52c3:b0:359:ff8a:ee44 with SMTP id 98e67ed59e1d1-35a21e4ee3dmr3756010a91.2.1773417581502;
        Fri, 13 Mar 2026 08:59:41 -0700 (PDT)
Received: from pwnlife.localdomain ([118.32.171.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a07f0a365sm8425476a91.13.2026.03.13.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:59:41 -0700 (PDT)
From: Minwoo Ra <raminwo0202@gmail.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christophe Gouault <christophe.gouault@6wind.com>,
	Minwoo Ra <raminwo0202@gmail.com>
Subject: [PATCH net] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Sat, 14 Mar 2026 00:58:44 +0900
Message-ID: <20260313155929.7406-1-raminwo0202@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,6wind.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-267524-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raminwo0202@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AF3C286A4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A XFRM_MSG_NEWSPDINFO request can queue the per-net work item
policy_hthresh.work onto the system workqueue.

The queued callback, xfrm_hash_rebuild(), retrieves the enclosing
struct net via container_of(). If the net namespace is torn down
before that work runs, the associated struct net may already have
been freed, and xfrm_hash_rebuild() may then dereference stale memory.

xfrm_policy_fini() already flushes policy_hash_work during teardown,
but it does not synchronize policy_hthresh.work.

Synchronize policy_hthresh.work in xfrm_policy_fini() as well, so the
queued work cannot outlive the net namespace teardown and access a
freed struct net.

Fixes: 880a6fab8f6b ("xfrm: configure policy hash table thresholds by netlink")
Signed-off-by: Minwoo Ra <raminwo0202@gmail.com>
---
 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 9e1a522ab1c5..6f0097cf28b3 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4282,6 +4282,8 @@ static void xfrm_policy_fini(struct net *net)
 	unsigned int sz;
 	int dir;
 
+	disable_work_sync(&net->xfrm.policy_hthresh.work);
+
 	flush_work(&net->xfrm.policy_hash_work);
 #ifdef CONFIG_XFRM_SUB_POLICY
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_SUB, false);

base-commit: 99600f79b28c83c68bae199a3d8e95049a758308
-- 
2.43.0


