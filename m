Return-Path: <netdev+bounces-290184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMRxOMRaDmo4+AUAu9opvQ
	(envelope-from <netdev+bounces-290184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:07:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100759D84B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404F530CBCB0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8C229D26E;
	Thu, 21 May 2026 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMvF2c/K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8A299927
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325446; cv=none; b=tn7nSCiW0EflZE5SdFQwJa8QrYFo5Ub3YJhfpZ010fVgrduehMj0jMxKjbDankzt6CFGOAgWwYU3f8fsodebOUvXBPmwb956lCMBeIzNLkTluAaL0PhHh9AJk87kDGjjar/esdH49DuxyUUf3hKbS/2G4XH/MF4Hq5zL/CvTcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325446; c=relaxed/simple;
	bh=AS3r4SOTc4veYSfaHwgwn+ULtHBqWvT8Yq79Cu0j7WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBeYvXk/+1pAUdbzsjWJQNJ38/ajW9bDNA+UDIOymMPtfvwPui+Lkx4ZIzINeP6Fuw1ZCy4chfrsMi3iT+DOHhWUhYL8EKTLz8YVMJn5/0WJJu1Lik+yBjbbOmv9NpUq4ZzBzYXEYSp/Oy6wYxkaas/Fw0xRRgyDAy2Xah9WqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMvF2c/K; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824c9da9928so2288298b3a.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325445; x=1779930245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLqsfTgrZOczLHoU8IEadZ/9mpSZuAXVPGGnbvVO5aU=;
        b=SMvF2c/KcNGZT+6uRTRqQihxxx9dF5TPjroCcs7vjB/gVEymMYpEDC+uqY+DNOhkxN
         b1ilTnE434PITCqplXatB8MzdO+xNgnKw6vxuTTkEWFPh+u0jbjicg1yP1zkNpnQY4fH
         CsDa5h8CMVupxCpNYx9BBbWgp9Bx3P75J1Hm1MtdAccbuBzPt5SIl9ZqUtF/cbYIXiz7
         ABcHxAcYWk0m+ERm23mrvmJKaNJMOl32R7S0ahPO1IJbMGxPVnMsKEoY2Yc+7abMydOw
         ++DFW5SOqturRsm0byO66FuuejBJomsxIEFoNRy53v5UskAzgBzvAIJkH3tuqfPGfkp/
         pQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325445; x=1779930245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLqsfTgrZOczLHoU8IEadZ/9mpSZuAXVPGGnbvVO5aU=;
        b=XFeh/VpcnuWo1HkMp73e7m/dKkq+CQATw9fQHM5eFhJ3L0hlRozSo7ijp+BNgI5Qwb
         wO7GPbfZPj9bknSEAqyRCpHrckP+crBtgP45VOTLbNRNDKI4Kk3yvH6beZC5v2VEFqDA
         PFlEnpYl5tthq5DMJnjnwb51enUEaBgRFoyKWzElIZmkagwfQvBdoG7n811Pr582GQNx
         FkwsGscTO7QSL3WT/fAYyXC/ml/pnMNJ7ildLFocY/uXylfLgBgcDi+7szXJiLmvz1du
         aa8PAQhhX2bXdd/gwst2f11BuxoRZEi9Yblai+a8EPsU4BF2aSkG+IWVxijQfylFejFx
         0d/g==
X-Gm-Message-State: AOJu0Yy3tkqrA16lxGhq9mQ/rpb3JWrOLLvGAgnf3bv+rTlTSvlCL6Q3
	ggp+YH9dZ8wYAKYae15ZbryVYYJ4U4gRgEaN2QAv3M3GZEIPaFG3atwucyKiEWhX
X-Gm-Gg: Acq92OEYgio6xg05GYNeJm/Jt26onK0eY5Z/ZI8KkladVWHY78kMLXwCxA49nIvuBXu
	z6rC8gZp/e/mOACEaVLw19khx/huPgRrnhCgdySLppQadZRPHvDOSohmHveBT8w2EjJlYbY2WSl
	nKDWY5TWzcM6f/0jNtQlHn7s8PZigmFGC8IjCvdtUhFOhhdglEt1dZt4k9S/X4Ti0IEdJ/gr107
	lDBdK3t1J1FO+EzO2kkFGKb+ME1/cAjdrAsaLy8/J7l8spEqocGni6zqkfBZFbq8qjQkWJxzNbG
	QMk9I9jAOfojzElNybPQVAMrR0LuZQ+/uG/SrgrTaWdZfFxfkR7hNmWlG6ad+1Bgl+i2M3meyvk
	SlLyfRzlgGc2PGIXfCXcCNo5Jk82ikmCVBPBGntzdU8sgtZq48Mq0zonxUgj8o9qJaA08gxwvCK
	pp/UVZ5bWLOlYNAbZ1Tv7HEMMU21EZyffohd01LWdIh3acPEQY6CY3VIDfPpYc
X-Received: by 2002:a05:6a20:7489:b0:3b2:8685:13e4 with SMTP id adf61e73a8af0-3b3086eca0emr810470637.15.1779325444711;
        Wed, 20 May 2026 18:04:04 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661f:1232::1d0:bf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114a70sm26319616a12.22.2026.05.20.18.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 18:04:04 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/3] net/sched: prefer existing extack message in qdisc_offload_graft_helper()
Date: Thu, 21 May 2026 09:03:05 +0800
Message-ID: <20260521010320.208138-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521010320.208138-1-mmyangfl@gmail.com>
References: <20260521010320.208138-1-mmyangfl@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6100759D84B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use NL_SET_ERR_MSG_WEAK so any existing error message (probably from the
underlying driver) is used instead of the generic fallback.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/sched/sch_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 3c779e5098ef..8a3236456db4 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -859,7 +859,7 @@ void qdisc_offload_graft_helper(struct net_device *dev, struct Qdisc *sch,
 	any_qdisc_is_offloaded |= old && old->flags & TCQ_F_OFFLOADED;
 
 	if (any_qdisc_is_offloaded)
-		NL_SET_ERR_MSG(extack, "Offloading graft operation failed.");
+		NL_SET_ERR_MSG_WEAK(extack, "Offloading graft operation failed.");
 }
 EXPORT_SYMBOL(qdisc_offload_graft_helper);
 
-- 
2.53.0


