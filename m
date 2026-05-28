Return-Path: <netdev+bounces-292499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC33KiKUF2oiKAgAu9opvQ
	(envelope-from <netdev+bounces-292499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:02:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 085825EB767
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF08930097C2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973F1F5847;
	Thu, 28 May 2026 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8FgFeyp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D51A0712
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929822; cv=none; b=o9ISgI1orJQ+dd4R2B4YZrIYyubhLolgh1q01586/NklDJldXq5S7hCbLJNEeW44SaR31Juooh4SrXDjTgFaUlAAcNv4EfNROSERPrRTYmd3hFq1atNcAcZbOpt+wrardw12gd1Ngx8gmnIEZs6VyNIGRBgOR+0eTf8UwfCFs7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929822; c=relaxed/simple;
	bh=XdwrW8xLJl3x3o2hw4mr4xx78JzFZPFIFMj7jYO1eLg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P1oOJTGVnEW8r3dQm0iSGDaCPwCdo1LGl6fZcsjcTtT/79Wd+0COEDIvp/FmVqeFv+CgFod4VQ7zu0blNaC+bwovIwPbs/d6jR1Rbqi/Vvor2DKUeJdZzch79c9Gvdod/7IXQoYxhDrIeD2XEEzGDH4aq713PQ42nYS9x4xtDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8FgFeyp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9429f49cso16682334b3a.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779929820; x=1780534620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VmU6KmCccSC8gy+4i0vtnTdAAeX7h7Dze5j0ocp0izk=;
        b=l8FgFeypyMn0aUNzdNFdhGVbX7DD/JBHLSH/dcwNs1GVzlyLBdXuw28SdvZ5z1SKrX
         AM1FY1kMzALghTcPSmeZa0cIu5oXB/DOL/AAT/phR1gIQ+eSlAs5FA2EcDasOkF3kUo/
         pOvKtGtR/GuLxjDbZxXmD1Wan1wyrg2rGEC+n+cnCWCG0z4Me5Euc1aPnBKNAG5bxl9r
         RQ74ZlOY7do8nUBF+tE7IStqEFjc3321WhsCfghB0I8LAg5w7KXef3VwbVxZSRMiGyeB
         8MhApg6X2wwNut5Y5JHC8olGtMdtGYUV+vNtF+R417EaHewVNRKjFtcBNs0ihDSjrN5N
         DVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929820; x=1780534620;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VmU6KmCccSC8gy+4i0vtnTdAAeX7h7Dze5j0ocp0izk=;
        b=DDaiW2YpN3ZCgedz8dtF3RLmWioqFxf7nKlwj0JCox70dEhtUchIU7VwyXXrUmRLS2
         IPRW0bRJW+/CAtZFhfXvthnsDrlu+2RD9/lBNHKsHChVYZ9mRiY+0QorqSRHMQkibxUc
         hTUANliE6X+rIYhZnylDtgejyO40E/ZusZlLG9ujMnmg/Bj5W/Fda+lxaK+aFtq5z16f
         he/TuFG9VUrSMKqSEqRErTJxtLn6HIBq1vSxPLxdYXTlqigqaA8+rXgDwS8MV+EdWTe/
         Z0H/k11BaRrpEOCkb1j8Q8p1MoecGQXO3RDbMg8PU8utzUc3bA7CY4D7JfWGfZSvDiOo
         JjDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Nuooxkur6JP+oj4uaw8garcjXYJno9fUaXDSRbHRoH3aBj7q6MBIOVnRB4jml4ecVq0mlfVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeN94BnnR7GUSYsf9ZnDRqJ8WSJrJtoYIEtRK0ilyyKX6U6uO
	B7mItLPawPpWsfADpv2eWFy4vZgSq+fy4d8LIaNmqNGkzaQUGyPBta6ZWDVaCwWxbZi7eD3PYpk
	b3MX9fA==
X-Received: from pfbfi5.prod.google.com ([2002:a05:6a00:3985:b0:839:9ad:ee32])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391e:b0:837:27f4:ffe5
 with SMTP id d2e1a72fcca58-8415f18266dmr23740730b3a.19.1779929819749; Wed, 27
 May 2026 17:56:59 -0700 (PDT)
Date: Thu, 28 May 2026 00:56:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528005658.1756248-1-kuniyu@google.com>
Subject: [PATCH v4 net-next 0/5] geneve: Allow binding UDP socket to a
 specific address.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292499-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 085825EB767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By default, a GENEVE device bind()s its underlying UDP socket(s) to
the IPv4 or IPv6 wildcard address because there is no way to specify
a specific local IP address to bind() to.

This prevents deploying multiple GENEVE devices on a multi-homed host
where each device should be isolated and bound to a different local IP
address on the same UDP port.

This series introduces two options to specify local IPv4 or IPv6
addresses for a GENEVE device.

The corresponding iproute2 patch is here:
https://lore.kernel.org/netdev/20260523061102.2762452-1-kuniyu@google.com/

Once this series and the iproute2 patch land upstream, I'll add
a small selftest.


Changes:
  v4:
    * Patch 5 : Simplify validation in geneve_nl2info()
              : Add ynl spec

  v3: https://lore.kernel.org/netdev/20260526015152.2409183-1-kuniyu@google.com/
    * Patch 5 : Use NLA_POLICY_EXACT_LEN() for IFLA_GENEVE_LOCAL6.
                Mention source address in error messages in geneve_configure().

  v2: https://lore.kernel.org/netdev/20260525001745.1251640-1-kuniyu@google.com/
    * Patch 1 : Move addr_type to if-block for CONFIG_IPV6=n
    * Patch 4 : Don't set cfg->dualstack for IFLA_GENEVE_REMOTE6?
    * Patch 5 : Validate saddr in geneve_xmit_skb() and geneve6_xmit_skb().

  v1: https://lore.kernel.org/netdev/20260523061654.2767060-1-kuniyu@google.com/


Kuniyuki Iwashima (5):
  geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
  geneve: Pass struct geneve_dev to geneve_create_sock().
  geneve: Pass struct geneve_dev to geneve_find_sock().
  geneve: Add dualstack flag to struct geneve_config.
  geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.

 Documentation/netlink/specs/rt-link.yaml |   9 +
 drivers/net/geneve.c                     | 240 ++++++++++++++++++-----
 include/uapi/linux/if_link.h             |   2 +
 3 files changed, 205 insertions(+), 46 deletions(-)

-- 
2.54.0.794.g4f17f83d09-goog


