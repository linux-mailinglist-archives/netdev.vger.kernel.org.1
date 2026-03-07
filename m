Return-Path: <netdev+bounces-265016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDxzJbWRq2mkeQEAu9opvQ
	(envelope-from <netdev+bounces-265016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:47:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B24229AB4
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C08D3023DD3
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527623AB87;
	Sat,  7 Mar 2026 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhZ4A6cD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CC50276
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851634; cv=none; b=An7UO5JYcz99WW5J9aNDmMh5DlzwZC1g7/I6WK03ILZZrWV/vzu2g+/gk3hhxAXvHLMkiHxXKj2WqrCJzyNtCwV517IicopSOG062pfCc35zNuLHgehpVOuoaBKj437Flyp59OBsVbhVj80NyWkNkCg4cM4aRcqSnEi11QrsoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851634; c=relaxed/simple;
	bh=NXkD5NZbIwr7vYu1DnzMQtIKed4XPAL825z7uEKI8Os=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WlMTvu9qr5lXI0NECNd2XcfSa35cmWDzXmian+N0CFANKUINUZk/52BbJhTfZ5JsG0Jn84dTVLf8zwzNU1p0CzhZVefkwJkQj1MVRYfflT70F0DvFpUqO9SFzwNET7Yd24PsyeSna2hB2z3GTPyQ64hHXm3ydvZyRj0dBHH4pTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZhZ4A6cD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4f27033cso63489285ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 18:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772851632; x=1773456432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3O+qKqpgyWwWnIN0cSSlw5OJuUTa1+ixXidJw46y0s=;
        b=ZhZ4A6cDs4L7a52Ww+frlDU7+Afx+Vbl6IAE7SnVODMsKRvGDx+Uaat/d4xfVwCJqi
         gPP/HDpC/5iUSN8Rw0F+IhKk3UkFQP0VENpAePVX7UOxLoaG5ITJ+UqxOlp0DgKrQb9s
         nhp6McvQPyIoTYvR1ufC7ejClOAuYo+yzX/Bn0Ra+OEFh1ZxbYpRXG7CbHs6s887HSb9
         g05OeluGSbOdTC6ax49fSjqg6AJKFk/0F9QEe0prDtk6sIIyy3t9EC+lORKxSOAlBjxi
         Akr///4IRfc4nwbFvBvLuoXZcW2cmyWRahMDdH9Supi8ygBYg0h2OuwPyzx6+nmtu/Kp
         C4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772851632; x=1773456432;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3O+qKqpgyWwWnIN0cSSlw5OJuUTa1+ixXidJw46y0s=;
        b=FUVhhcNjThWa/6ItUC7eFNBDdDDAuwRmhf2FYoHId/9GjDatmcQrT2tIM4fcfhkj0G
         1dxfyYK1wZIhAJcHVTe6HzSqIKQLQIGFWyEkMA1g/sR/m3mgcAesVL/HcbQ5TA6pmupw
         uSdquJdYRaTHJx0sVGHMw3Pk9pp7tgATEuBi6r0sUMNPzHRq7Ae8wWbAmjBL8TNoPtKV
         cG7cG3/midKaY8y0c/DgV/HJczHMQWdWcDn9Wl4pq9y3UtgCu9GdjEwSWocHf7VzRHz6
         W9ECbQr3rgBLZ2xSB9ElrvwPDlAiJfc0pIO1NoRUHAwJLiHkUBbrKJcZDAf/vn91/Sk2
         e0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXzuUgWkUZo+oJV08xRunClbCkm2oe3ARv1aHjmGjsp91hxM2VKx8TeIcvVwtXRpMM78gkH2A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqaejzptaMuZHq2JTL1pmVPKl6zbFrfhS6EV3OYyiIhutqjSF
	Qm20NKhV+UduRseyW0I6PkQP0SWJ8Deq9hg4d31SMOI5Gu5HA5MJCmEx1sERfoR4xvKaJmw9GAL
	ka5/3Vw==
X-Received: from plv2.prod.google.com ([2002:a17:903:bc2:b0:2ae:4964:6fe2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ce:b0:2ad:e975:4735
 with SMTP id d9443c01a7336-2ae8239798emr39703055ad.20.1772851632024; Fri, 06
 Mar 2026 18:47:12 -0800 (PST)
Date: Sat,  7 Mar 2026 02:46:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307024709.718395-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] ipv6: Fix two GC issues with permanent routes
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 20B24229AB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265016-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
permanent routes whose exception routes have all expired.

Patch 2 fixes an issue where exception routes tied to
permanent routes are not properly aged.


Kuniyuki Iwashima (2):
  ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions
    expire.
  ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.

 include/net/ip6_fib.h | 17 ++++++++++++++++-
 net/ipv6/addrconf.c   |  4 ++--
 net/ipv6/ip6_fib.c    | 15 +++++++++++++--
 net/ipv6/route.c      |  2 +-
 4 files changed, 32 insertions(+), 6 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


