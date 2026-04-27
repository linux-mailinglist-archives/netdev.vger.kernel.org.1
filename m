Return-Path: <netdev+bounces-281522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ2kJIzm72lPHgEAu9opvQ
	(envelope-from <netdev+bounces-281522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981C47B940
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F9273017BE6
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A133ACEF0;
	Mon, 27 Apr 2026 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fx2oTlfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695EC3559DF
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329798; cv=none; b=uvD+HNEfvmHY9kuyvFTOPKtF4vdozY1upSjRntwQiwQ1ozGB0zwpEY8Ij2u2ClwG2IzC5p9KK3UTM4Es/qNDR7wTO7oOGAXUe99nOSNJ1C5lCmtwgR5n/8Sym2OTybx/71IryHi6mXtFugJxIeEALkTPjczeMQ8kP6RIU+IyBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329798; c=relaxed/simple;
	bh=7kSIfuY2wsOd4iC9PovMKb7nubAFCr4XbMBvNtQ/VRs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tUsF7Q/vX+JmWwWZkEZ6godxtM/nAlIO/70mYFDEJgHjldYl3gU8FbcmcVAfp7xYjNcAMv1zv/cXDFe2e8abhw81oYsIg0iK7ZBzWjWwoeveQDQA3RaYZ8hVTphkQrAWdOy1pJ0Y1yFl8v3SAiqeTiZTVg/khnkZlHHeW17cruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fx2oTlfl; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d84b5f73bso85984181cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777329796; x=1777934596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuuQ+6LWht0IOcgLP/JLA7fco8IP2cdyWC85Ucq9KMU=;
        b=fx2oTlflwYullZ6uLueDHzd5NZMs6AffFjtbO0fNO51A9HxJmO8THXp3e/+UcwhqJ6
         dMHpM+YokUV8J6aALlOIOPA3Uwo8zq5lMsF7aimWCmi+VrohYT/UoEG0d10IvpqgGWpg
         Vs4C0CogZrLP+DRdfqzTo+p8qvZauGBj3A9881ZjmBUlWe30nzXrIKM3iOmEG/TPwy9o
         kVecRudWaiTRqYaAoIuxigWa9+uO3BAsMPnBO1WHstT06j7iEO3TglSFTB21VCJ2yuN/
         VuBA/RLTY8hLxUSEjTh5dCQMRqPv3d0owpIl+IERDI9prXBcfxl3AGKSCTCSEvzf1tH/
         Z82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777329796; x=1777934596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuuQ+6LWht0IOcgLP/JLA7fco8IP2cdyWC85Ucq9KMU=;
        b=AThg/jl9/B52LSNONDJ6WGxCSRnEMcDSMCn3ot8sS47aNTyznnseU5O/4Hjc0ZjWHK
         6S0dUjOP3/tSv4e6ru4ziqVmW9YnsNuxKaLhAi1WaInh1wsBaAx2t7nNdgYvxe8ba1/5
         9SXK4FWvUFxMVMaFN2exDsVEfYRltLJ6co63WERcxyedJMteIbMt6DsG3fVl5xfFkYy8
         KY9K8y2kbhvyX8DNh0v9HW4JOvL+kNNN+yb8YHEZCvyNkGb9T9d+zVKDOFRsuobP4jI/
         0QvDXqWdr7R/uOZ7R1SO/E9x5N4z0VhZlwojlxw6H+7zu1vZ1bGd0p5u+SFvu6e60DpN
         piQw==
X-Forwarded-Encrypted: i=1; AFNElJ8AU1kLbxgsN403cQCzkUzgOTmuHMjK8s4hYpQWj6G8p+mGuQsEH8IiSpaLGsDV1RM+280Kke4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRz9b76h/SQAy8zB0edcLkXYvXgU1R4Wm8HN3nET780I5tj+kH
	6cofhZ7sYzcw//7ANbyy+cSxVVvTLTikf9owG/uO7vTvrALTukNPBRhlD0tRyaInSSKWQzNJFB4
	oZ83pFVxLHQ7lMWwuHlVvx5aZazICpOUOq/Xqiw==
X-Received: from qtrr4-n1.prod.google.com ([2002:a05:622a:a984:10b0:50f:edee:e4cb])
 (user=sharmasagarika job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:58c8:0:b0:509:4410:4492 with SMTP id d75a77b69052e-5100e135315mr7920271cf.22.1777329796147;
 Mon, 27 Apr 2026 15:43:16 -0700 (PDT)
Date: Mon, 27 Apr 2026 22:42:22 +0000
In-Reply-To: <20260427224243.3499162-1-sharmasagarika@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427224243.3499162-1-sharmasagarika@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427224243.3499162-2-sharmasagarika@google.com>
Subject: [PATCH net v1 1/2] ipv6: update route serial number on NETDEV_CHANGE
From: Sagarika Sharma <sharmasagarika@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sagarika Sharma <sharmasagarika@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1981C47B940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281522-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sharmasagarika@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When using IPv6 ECMP routes, if a netdev listed as a nexthop experiences
a carrier change event (e.g., a bond device generating a NETDEV_CHANGE
event after its slaves go linkdown), established connections utilizing
that nexthop fail to fail over to other available nexthops. Instead,
these connections stall or drop.

This happens because the IPv6 FIB code does not invalidate the socket's
cached destination when a NETDEV_CHANGE event occurs. While
fib6_ifdown() correctly marks the nexthop with RTNH_F_LINKDOWN, it
leaves the route's serial number unchanged. As a result, sockets with a
previously cached dst do not realize the route is no longer viable and
continue to try using the non-functional nexthop.

This behavior contrasts with IPv4, which actively flushes cached
destinations on a NETDEV_CHANGE event (see fib_netdev_event() in
net/ipv4/fib_frontend.c).

Fix this by updating the route serial number in fib6_ifdown() when
setting RTNH_F_LINKDOWN. This invalidates stale cached destinations,
forcing sockets to perform a new route lookup and fail over to a
functioning nexthop.

Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
Signed-off-by: Sagarika Sharma <sharmasagarika@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 19eb6b702227..0dc0316530ca 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4995,6 +4995,7 @@ static int fib6_ifdown(struct fib6_info *rt, void *p_arg)
 		    rt->fib6_flags & (RTF_LOCAL | RTF_ANYCAST))
 			break;
 		rt->fib6_nh->fib_nh_flags |= RTNH_F_LINKDOWN;
+		fib6_update_sernum(net, rt);
 		rt6_multipath_rebalance(rt);
 		break;
 	}
-- 
2.54.0.545.g6539524ca2-goog


