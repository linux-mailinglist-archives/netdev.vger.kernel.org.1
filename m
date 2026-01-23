Return-Path: <netdev+bounces-252921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKgYOGu7c2kmyQAAu9opvQ
	(envelope-from <netdev+bounces-252921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:18:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9777978F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCF4300EFB4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA17218AAD;
	Fri, 23 Jan 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXrcjsbL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541E1DC9B3
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192260; cv=none; b=AbI9tyLXq4ocsNyFrVHJAqwczoG8oXeC7kNIGU5oWRWW1Bv1nUTo5KNXfgaoM3Sv2JveYiXf1CWEhmFkkAT8TeutADhT52FcyYrdeVoxLbR8aWvsZALOjiRrYOt+TeyfKVYZ1+NXa/w97tO2tCzkQv5zoXeVQ/98ajUPrGbBtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192260; c=relaxed/simple;
	bh=HL9Z8exH0p8ghijOUjxjCoBmCDjBhhDKtkS3KASOoh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQ342E7DeKGQrGr/Wj4pOENo6jx5+u8PHAPqKq2ofaybUQyeZcczyEkTQ+WPix17AKgSQwXslD1wIZN3iDd/Lbe3cHYmV9KBp6Ly08I5BgBYXW/J4luw7EmzlKDKScOk+3+wS9ZlsD1v41mYXZpbhV7b80fN6VewoFF61OjIaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXrcjsbL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8946f12b1cfso33939196d6.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 10:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192258; x=1769797058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zF0a10J5mLJVO6RkpWuar6FLLd6MMCZJu1XiB3Hvb/Q=;
        b=FXrcjsbL3lQYWuDMkpdApVo0X3645CYccv6zcaSnCoXp6BBd/yDyTO+duKymbcsrZO
         GJPdfdjjk8m5aHmkQKLd3JYG6ILSG65D0tkhM1OFQAwUQ2GOrLsMOlnHjAIrjU/NiDF5
         BCaHic6gTuhN9d+3TU5Uw9WOVBv9xcwhaXTh/lxVe1IT5YAPak2zMkVIljb5oaXrYE6o
         M3NEx7dKbdvR7YXl6EESGJzSgGid7CWahtKBZdrVeIArLCbiExGQgAhicWhNjM+QGlbR
         A1OtcUxOpqHrNAdL6+pH8nXO0MBpiUAndXULne4UlDy1srTLhyS6Ru4KH8gg2/+c7NFV
         wksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192258; x=1769797058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF0a10J5mLJVO6RkpWuar6FLLd6MMCZJu1XiB3Hvb/Q=;
        b=dX3W7fXmweDcVXgVBSIIvOMOVT9yx21n8lh5wcVwvfpyFz/MCf7m2aVlFeg/dg1vwk
         pcfSRnu1lqmdU2Zj0CtcSiyp3KaY9IN2fYYcfKsRsNv4FvPv/5PRwrdel9lTiMfwtLsI
         vumvKyHyTkdNA+2g89zgW2wN9PE7Jhbk8oYFrdnRDHVHQCeOmwZQMjK22JVKpyIOgzqB
         hOZtknyotDcRFn1MEMKC+kk143W2oLN65YrrFpi20KH/ElBnSICzIeEpvlEjLy19RANo
         JtswpHZa/UjPVmObeE7opGwxErm5ym8lhJFcfaANa7h8/WXNVQaEjsWcIUkfzTK0hGOY
         nTAQ==
X-Gm-Message-State: AOJu0Yx+lS0yJQDI/P9uaWgCEOslTZe58e5FQ6uxLhUCe7EW6FRApS8Y
	Q/nWcxhbdidfLaaLSvWMv7pOAzmrGfyB0GpLEqpH65w79VZ7P35yi2rSD9P4Pg==
X-Gm-Gg: AZuq6aJ3ovK5Usm5tD3cQvGL6AG1EM2wxaxiSmd5Ljk8OPtmJIbiYiJx9RicJfF0ChF
	u30WBmD8HNZSZBC4TWRBpMRqniC84rh9rxtfeUm1zcGPXTJHAuqa2N5+mfG4ajANNkTy35pq58Q
	UntoFDRqcGFDRnrw7GcYeNIpox7ITc4uSz6B0ZZrdWigOGFPkWuBXbuSypzyxFpeFu9BhaEO5iN
	hiI9WS0ArCeh6X0iEa8tFtzz1WDHjRCqSqPfqZtwPu/c3C3JD/qkv+dtp5lqziKu4aRxa9o1V5w
	Di0WPjwbrcX4RUtF92kMlRCpbFOQd1Hn3eS0kjJoGrlBTvoC58P1oumZrv6y+FD+CkQ8DC5HXqD
	bUw+kUs5neyheO7x0J123vT2CPxP/QDaw8zuOQSlzica2ThM4usKGaz0Rj8G4sigc/zg2Ty/PIK
	vM6EtCP2xpe1uaWlb7byf6F9Le3FVPkgA69wDdqfleeo3aMUK7dVxxYw==
X-Received: by 2002:a17:90b:17ca:b0:33b:cfac:d5c6 with SMTP id 98e67ed59e1d1-3537af9505emr1485005a91.29.1769185336053;
        Fri, 23 Jan 2026 08:22:16 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:15 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Breno Leitao <leitao@debian.org>,
	Carolina Jubran <cjubran@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	dev@openvswitch.org
Subject: [PATCH net-next v2 0/7] u64_stats: Introduce u64_stats_reads()
Date: Sat, 24 Jan 2026 00:21:32 +0800
Message-ID: <20260123162159.2877941-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,nvidia.com,ovn.org,fomichev.me,debian.org,vger.kernel.org,lists.linux.dev,openvswitch.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-252921-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B9777978F
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() and struct copying should not be
considered tear-free. Use u64_stats_reads() instead.

v1: https://lore.kernel.org/r/20260120092137.2161162-1-mmyangfl@gmail.com
  - rename to u64_stats_reads() to clarify data flow direction
  - refine the implementation
  - add docs
  - fix struct copying too

David Yang (7):
  u64_stats: Introduce u64_stats_reads()
  u64_stats: Doc incorrect usage with plain variables
  net: bridge: mcast: fix memcpy with u64_stats
  net: openvswitch: fix load tearing with u64_stats
  macsec: fix memcpy with u64_stats
  mpls: Fix load tearing with u64_stats
  vxlan: vnifilter: fix memcpy with u64_stats

 drivers/net/macsec.c                |  6 ++--
 drivers/net/vxlan/vxlan_vnifilter.c |  2 +-
 include/linux/u64_stats_sync.h      | 56 ++++++++++++++++++++++++-----
 net/bridge/br_multicast.c           |  2 +-
 net/mpls/af_mpls.c                  |  2 +-
 net/openvswitch/datapath.c          |  3 +-
 6 files changed, 55 insertions(+), 16 deletions(-)

-- 
2.51.0


