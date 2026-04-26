Return-Path: <netdev+bounces-281165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAHEKIwk7mn0qwAAu9opvQ
	(envelope-from <netdev+bounces-281165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F4846A617
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52EF300EA96
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C136606E;
	Sun, 26 Apr 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkcWGcvL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4E364EAA
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214590; cv=none; b=jp5bw3BOTzS0mglJL/5M9eNthoW0sZhoy7z/dmZlv2xJPXV3YbOAgx7q/sg+Cr+SEsBd0Nu7UhuIXR10JGcHJYxjsmg6Aw7k9U9Ahc6BtnE4w6G4Ya+IzQDzTynDgrPi+yqgw18ZCa8oOZopVJiCi8qts8/Zh7ptaZJe8TEU30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214590; c=relaxed/simple;
	bh=BkKTDP/QdqV60QGLaKXzoX1Zq58loiHiNgpiGqts+0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHmhn3AfFaKp4n0EupWypPBOZb/l8P52HgaTc73CxFYXFrQYg1dXxLKMU8jXYLkTDv7ah0v9kGlhYzKeFQRaa2H31LzeJfCKpu0tEusOhyut45MHSQM0idls2uwHLIzFxnUOwN4I7jLzmC7psMGUaUO10VIqePdCTTEPs4Mihq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkcWGcvL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso131925325e9.3
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214587; x=1777819387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+fDrQ0imKcqjUd0pDltukSNKPmoj5xTHANz+kyGdM0=;
        b=jkcWGcvLacvY1y6WGFllv6v7k7ED4TRa3i14ALbEC7TghNb9zGdC71BMTJRy9//uvO
         llYPnBZrm0G7mQbNm/Hv9kF0XDnBEra8D+rHbanRqd68LyB13ee37r2bKC14XdLJX/51
         EcgKC2RQvE1H8p6pSbepiP4f288z5BWzpJxNKwb+VbrqFys4xF94nK1F7u9D93FpIPaG
         M1LeienPJrW+cKp2OTPDoVEmQ2fWM7vvkI9jXgxGg9a+SY+AohMYNW/Pui+fWbJcxGXZ
         5Yq8ovY9UKJHEwdsL9Kbznz1imtVkYkGqvycEuP3jAjoKNTTodjd0GaNQzAxR8ZhBVlr
         QBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214587; x=1777819387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+fDrQ0imKcqjUd0pDltukSNKPmoj5xTHANz+kyGdM0=;
        b=mnGAXVYA2OwjC9nWPFTCHFKq7V+Ffo8qzF7FFPoMVZOuxb+cW0F4oNJ0aX95WV5fRq
         +0xMISob7fkUun2kZKsI/n19BgtyyiTuIrc5sw0g0+1HXi9WM//cLxDHGz0wlEClDrbG
         caNc24oksa7La+y66isGTGe1yD6EGheGl8dLqbYG8xeWK4CVcm6LcW1NpE5m/y2IWUu4
         UjXYePjpQHZGuv7Mudrl6rJ0E2oYhPPPSfnn0t4mQLaX/4QqgvSoYz6kU/AmD++diGcF
         C4oGEFTnhWQlfls7H1jF6y+AZCRBGWk8OaYxTLt+J7Z7nMWFl8Oh3axkgpBD5uC11gQT
         qs0w==
X-Gm-Message-State: AOJu0YzWPiEpfcfvPyUZbtKzSKHFKQUVImB2We3t5rAcdrx+lAi+1lE1
	ktEX/RdZ3wz0jBWDw453Mjf7NYBYQ3llnkgpz/3MWuw/jvN/FJRzIKtNDrTHEA==
X-Gm-Gg: AeBDievJRjf8j+t3fhvjrY/1wmpQYsR0XVRYii+y6OnIRibfeyoHreJwhhG+qwFzAbz
	1aTNkRxq7BXPr+I9/fChZ7xH29IhodpbAQXLT8kvVHh1uNmIBCBDrNm+U2foBvHF7rqq7CQl9e7
	IIOXpZ0ShfBs6ACZbeW7/1ej7BZ/ZgNuQ9+IP1daDu93uZkfSwEnhByXb5GAJG4rwP7BOAd7vo3
	g9j824UEiubruyCL+YebUgC2huJ4OAW9CDrVT/UOui8BK+O2cI4gLG4qzmleo3cQ6iQ9CvrW2L2
	txKktzi9n+HjoTWzBBPsm5s6hDtQfwl43pYDRyt43xrkhiMCe6aDQzKqu+4bs/iSkfhXm2ir0Dr
	/nJ0nTmdC3KN0MWGmSfDLUEemnh/0eOtX1FH46+GWKHZbsK2bi9C/em5xheYbS1+JJT3UbOyoot
	VSa3T7GQbQEV81nKDWdonG4prmDhHybS37RPX/7d/0hGyJ2S0/yio62mZYa3zo8dqirIqNSE8kA
	cMOPwLqlXQSkVRRHECqCKDi4w==
X-Received: by 2002:a05:600c:308a:b0:489:6c22:e081 with SMTP id 5b1f17b1804b1-4896c22e217mr277337225e9.0.1777214586995;
        Sun, 26 Apr 2026 07:43:06 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm658230335e9.8.2026.04.26.07.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:43:06 -0700 (PDT)
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH net 0/5] rose: fix use-after-free and reference counting bugs
Date: Sun, 26 Apr 2026 16:43:00 +0200
Message-ID: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03F4846A617
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281165-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series fixes several bugs in the ROSE protocol loopback path and
state machines, all confirmed by KASAN on a live system.

A long-standing practical consequence of these bugs is that once the
rose module has been used to establish at least one connection, it can
no longer be unloaded cleanly: rmmod(8) hangs or causes a kernel crash
because outstanding references and running timers prevent the module
from completing its exit path.  Patches 2 and 3 together fix this by
ensuring the loopback timer stops cleanly and all neighbour references
are released on module exit.

Patch 1 fixes a device reference leak in rose_loopback_timer(): dev_put()
was only called on the failure path of rose_rx_call_request(), leaking a
reference on every successful loopback CALL_REQUEST.  It also removes a
dead check that can never be true for the loopback neighbour.

Patch 2 adds hold/put protection around the loopback timer body so that
rose_loopback_neigh cannot be freed while the callback is running.

Patch 3 fixes a race between the loopback timer and module removal by
switching rose_loopback_clear() to timer_delete_sync() and adding an
atomic loopback_stopping flag that prevents the timer from re-arming
itself after module exit has started.

Patch 4 clears rose->neighbour to NULL after every rose_neigh_put() call
in the ROSE state machines (rose_in.c), preventing use of a potentially
freed pointer by later code paths.

Patch 5 guards the rose_neigh_put() call in rose_timer_expiry() STATE_2
against a NULL pointer that can appear when a concurrent teardown path
(e.g. rose_kill_by_device()) has already cleared the neighbour pointer
between a timer re-arm and the next firing.

Bernard Pidoux (5):
  rose: fix dev_put() leak in rose_loopback_timer()
  rose: hold loopback neighbour reference across timer callback
  rose: fix race between loopback timer and module removal
  rose: clear neighbour pointer after rose_neigh_put() in state machines
  rose: guard rose_neigh_put() against NULL in timer expiry

 net/rose/rose_in.c       |  6 +++++
 net/rose/rose_loopback.c | 53 +++++++++++++++++++++++++++-------------
 net/rose/rose_timer.c    |  5 +++-
 3 files changed, 46 insertions(+), 18 deletions(-)

-- 
2.51.0


