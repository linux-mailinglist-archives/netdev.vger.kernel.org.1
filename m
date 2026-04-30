Return-Path: <netdev+bounces-282983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOsuKjK382mW6QEAu9opvQ
	(envelope-from <netdev+bounces-282983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 22:10:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1FE4A795A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 22:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A19301FA74
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442F38AC6C;
	Thu, 30 Apr 2026 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWMB/C8t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880023750D5
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579785; cv=none; b=LUWZ3My4QzT+VNTQLjHHDR599Or9QPlV19QMNPdvUVcjODMMDLAWy0XdcD4a7/y9jNm+88OOjPOQFaK9ZuRd2CrV9dCVOSXEcSv0u802RFEbB6IIVM1AxYnjhiZ0zjnev2zEcwcboxjveiXyaKHBH/qUKXrOX9iyGyILuwkFJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579785; c=relaxed/simple;
	bh=VD18TQCJb+UvimBYuvfIE6T/IibWEdZ2EJLJM4gP79E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aspr7hCceNisRAqVGO2AEzAYO2Rab1TFtnB49nmdeEDsZjM3dzQwgpPrG6vqaa+U0O5M+lkqobCBXTlXMT9f12Md8MIs7J3+qm45rOgiqJEO0Qs4IPOg5by+WegnozQthW5ldLsZCdIdP6bmxWFl5PogCA0Mi8uTbtpXS2l6zag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWMB/C8t; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8acb85a973cso20346906d6.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777579783; x=1778184583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBJRCGaM7qg4vs+OULvt1tqKlI+D/Ob+RbwxfUm/5d0=;
        b=BWMB/C8tMmWGka4vmaJXW9zTs9dWvaN3aUkJSfoSmk3mapYWRv8BQZghOOzYhSocyP
         6L4aFURQeEyT9icIcEfBnShmzExZzBuEzTzHTRzPVfQ58aqra2065HJhvQAzFpHu7qbf
         YLGJWCyJufvwfVET5Ec7JLlMOMTG6QvDQyCazCMRPmLRG3YX2uN1i4VIy3081c8GtxEf
         5YobZfpHirBakf2N9ibdZ6xWzMKT0FEAeJ84ldOtrPle76h2bE51bIoX8aaEYCxz63Fm
         BgH+8PSWnxUOF/0oLjYNfb4qwdV8cH5sDdcucCyzaxma/g2pWy6cATZUxch3z/Vb1Ccn
         ITKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579783; x=1778184583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBJRCGaM7qg4vs+OULvt1tqKlI+D/Ob+RbwxfUm/5d0=;
        b=pb9GZxcXyRc+zFKCORPLgacBffPzM71WWI+3TyNQclDYP8GdGm2sjVEBgGKMPxMslR
         L9VqlKSjqdVI4B9cVtOL1h2a5NQ54mXk5AABT73Hy/PJ7tUo9627fDjGy0zdcgkCH4Qw
         s4O9+eHKJdcwKlfW2Os5sa4/hYiLot8Yuk/P332vWavwWu4+9lEnpoc7Mhr85/QN7YB/
         YWklGIXGp1X5xPqN9+cwdOfX0WrQNbysCFD0QSCSxGgGmP2MRSoWpnmUZi0fZ0A+V9iG
         15z9r6xHwAOLoUBzxyfbxqJSxUiqYEJMFpkdri0+YwItUIgAgL0s4cJeWxUK8Cn8lAvJ
         i+YQ==
X-Forwarded-Encrypted: i=1; AFNElJ/B462INXlZWwvJuAheKmept354xekq7pAQpIJKUWI004HkOMbg77AC0AGg/ctIGjrWnfeG4Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEM7GPu2PQ8t+fcZJfSAaKy1ILITDApnSjmOYBmYI5prICIY/n
	2YAaq3yTdV2c7ns1r0YB8LNlLGlFOsdnj6pshbsu1NEWwDUV2Y6W2ccDv0kU34l+kgmf3g4QZRC
	vWl5PiJZLbH+cKUU/Y7dW+lFzFYPkb1PmPdzC1g==
X-Received: from qvboo32.prod.google.com ([2002:a05:6214:4520:b0:8b4:f68b:27ab])
 (user=sharmasagarika job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3303:b0:8ac:a744:7789 with SMTP id 6a1803df08f44-8b3fe6e6686mr62510266d6.5.1777579783398;
 Thu, 30 Apr 2026 13:09:43 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:09:00 +0000
In-Reply-To: <20260430200909.527827-1-sharmasagarika@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430200909.527827-1-sharmasagarika@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430200909.527827-2-sharmasagarika@google.com>
Subject: [PATCH net v2 1/2] ipv6: update route serial number on NETDEV_CHANGE
From: Sagarika Sharma <sharmasagarika@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sagarika Sharma <sharmasagarika@google.com>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0F1FE4A795A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sharmasagarika@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

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
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


