Return-Path: <netdev+bounces-272026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBmSFIYoxWkU7QQAu9opvQ
	(envelope-from <netdev+bounces-272026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:37:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48B3354D2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A6B30C74D7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04F3FA5C3;
	Thu, 26 Mar 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnn8Szsa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCEE3F8E0B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528357; cv=none; b=GMOPfo2F2D1QjkxU308BZSfVeOLofNEkQxnnnOWMIRU9ft0WaqVV6WK8EeinLDPIGC2hecdprjFJzA0/yOrulDvMqOxUKigSRdsVZCC4tpXzf3Yabt3woCgySg+cfhJjGufRb9sGphoatJPLzrUxc8xoOUjBlJdgmZpSI+v4mfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528357; c=relaxed/simple;
	bh=ZEGAUcvooReaJ1XmRJnQfzG/aLY4zKJA94CADfSupZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BaqIZDFwYjXbr9peqwvxJFL+6x9VWhRAUDht/DRRdSfBgtcm+S5CbL07OO+koeX+E4HJFgidWYUGBUSikllT1P2M8CG24Z+X+S1GxivKc7df5y9kbsiikEvC4LFbfQoIRfmFlli/2HRUX/w/yTYlfB+PXNcnC57zNZQb+JM6hRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnn8Szsa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-486f89b7f69so11202195e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774528353; x=1775133153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCR1+XiCejEoTZukOGzTXx300luMCdEPMVOduAGAhwQ=;
        b=pnn8SzsaxWdT1Xg7bun4HelpBTaPt2xL5Ka6sp5j8DTsXSpU2WAsbA3TELSLbYAFdy
         BmzQBUatwrqo8rObW4ddm8mkrjc6kCFuj8a5R2gtQYVh4CCL64Rn2oy4IY2ymGebHjhi
         zlHCpFB5KCjkTlB3bfEc7elT9nYuQ9i6LPIdmgJJscO+ZNk1k35WIJulubbfe8NggxLP
         3zQy7tNjXAYOqqhnUrp74tJMbjLjNusJcK0aGeLbuIotj4vjeVTVliRpWff/V7q/tbIB
         efq5L5NgfqARFrJu9d1DymS2RHzbowq5/Z1wD8jTqIRK/jbSJTSNidRzOuhm17wZDkuG
         gWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528353; x=1775133153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCR1+XiCejEoTZukOGzTXx300luMCdEPMVOduAGAhwQ=;
        b=CejqJXmyNXSt9pr5D87YpPZZB1HNT46ttE0FK6odO2Rc5cPQfL0ZEt6f6Jh6P1zthQ
         BMYnMee6y2FBFM+SWTYiHasSRgurmXC6wwmJs/OfTK8+Cs2k0wDWpKzpIbV5sHa62AVb
         YR4pYE5dI/mT9HrfNoeETvabcUmKJgnGT9bdu3tldjMhW2xQx8l2vHDtHkPItWp0DTfA
         oER+bQ/dngPPkkh2J02FBwU0qZuFYlnG15OpaEcG3hNI9DeBW4Bf4102keUZhgu1q+AX
         vJ0C7Ip6mDp3sufjC23lYyZGY1kf6a7VZQBCBw0WVk6+VnFspczJbhUoaaGaPAweWDpo
         m6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhRJK7XEN0qo6jFmF2uYgJOZkCLnd83cR1wYkIWlY946FZUq/KagTd5GxEq3oWlgiXStUvlDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuHZzYV1+vmlCzAGfT3/aSfAIXYX0nJJZv+XOH9hKbiD8+KQX
	/QDbwZqoDT0Q7Y7sJzh+yiVXnTKUOAI6O5LXk7BWpkfmfzZ6cCsotfZKc0nhffnmlrvzj+CNng/
	anMjneBysarqmuA==
X-Received: from wmoo19.prod.google.com ([2002:a05:600d:113:b0:487:238e:327b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1d:b0:486:ffa3:592 with SMTP id 5b1f17b1804b1-48716071b2amr111318865e9.24.1774528352832;
 Thu, 26 Mar 2026 05:32:32 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:59 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-3-d916021cecdf@google.com>
Subject: [PATCH v2 3/4] mm/kfence: Use special gfp_t format specifier
From: Brendan Jackman <jackmanb@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Allison Henderson <allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272026-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,linux-foundation.org,oracle.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB48B3354D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

%pGg produces nice readable output and decouples the format string from
the size of gfp_t.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/kfence/kfence_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 5725a367246d9..10424cd25e5a6 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -263,7 +263,7 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 		break;
 	}
 
-	kunit_info(test, "%s: size=%zu, gfp=%x, policy=%s, cache=%i\n", __func__, size, gfp,
+	kunit_info(test, "%s: size=%zu, gfp=%pGg, policy=%s, cache=%i\n", __func__, size, &gfp,
 		   policy_name, !!test_cache);
 
 	/*

-- 
2.51.2


