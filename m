Return-Path: <netdev+bounces-219232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32689B409A9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55385427EA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701632ED5F;
	Tue,  2 Sep 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="LM6SfkCk"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D457324B07;
	Tue,  2 Sep 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828026; cv=none; b=UVHjbwSUwjsmN61jIss5XrfmIp8xrJqm9jDJA49Opja18EdqCpUWnJIpNgtGqWbRZRSyANDGoTxwLnH+pkSf/vwHF7T589sBYLRDwERG0ZSWGSAerPWS6jqyuzeFTSKiuMswyQNoZL0Muhrie7mfnXAF/g9ia1Uvabl0R3ZK19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828026; c=relaxed/simple;
	bh=Gl9gajoVLzxJmnc1ePJC2X6wmSn5VMF8xSjXsX/13sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrmOevqC8vxwg2Cgr3qDhdFYUKHrCG54pmC6JaMQRr2gZuw1pDDbMNn37r1wVVIcVPdfTxbJK2bsP3aiEqrL93I6PYzVJSVjWKc8GI8y01a4WFBJUrH+9P2dzM6loINLBrbfCWLRQBo0/JomZCflHRDC92Jrg050VlB0+7vt2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=LM6SfkCk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756828014;
	bh=Gl9gajoVLzxJmnc1ePJC2X6wmSn5VMF8xSjXsX/13sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LM6SfkCknppZarc359u1pKKMp5FVG/mXGK49GkIr6bOMvk7w9PsJg6y4+l5yPR1kb
	 pgxz8Q7eW12zv+Kzj6zHFTMqy0BTlESPvCF2PH6h3+KNawzByb4QUd9nwQWcscr+mf
	 l85SXavvWQ6vvb0aPSha8m6iP2KDllBlIC+rvR7VWvw6GJdzw9MWc7+PKcBFf7Q8PV
	 I4313zfPaIpsIuFSK4ECG0OUtyK+qPWGv7ZNr9FHQwqJt/gDOlPz4nFWz61w7Phyrl
	 Prk0p+8JnTkab+3r9ftMe59P2A+BNiaDhTjfse0x0rK2q60yrk3A4tdNDdViQWarkV
	 CpRsph9HtmTYg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 42FC0600C4;
	Tue,  2 Sep 2025 15:46:53 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id E2F0F20226D; Tue, 02 Sep 2025 15:46:42 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] netlink: specs: fou: change local-v6/peer-v6 check
Date: Tue,  2 Sep 2025 15:46:35 +0000
Message-ID: <20250902154640.759815-2-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902154640.759815-1-ast@fiberby.net>
References: <20250902154640.759815-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While updating the binary min-len implementation, I noticed that
the only user, should AFAICT be using exact-len instead.

In net/ipv4/fou_core.c FOU_ATTR_LOCAL_V6 and FOU_ATTR_PEER_V6
are only used for singular IPv6 addresses, and there are AFAICT
no known implementations trying to send more, it therefore
appears safe to change it to an exact-len policy.

This patch therefore changes the local-v6/peer-v6 attributes to
use an exact-len check, instead of a min-len check.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/fou.yaml | 4 ++--
 net/ipv4/fou_nl.c                    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 57735726262ec..8e7974ec453fc 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -52,7 +52,7 @@ attribute-sets:
         name: local-v6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: peer-v4
         type: u32
@@ -60,7 +60,7 @@ attribute-sets:
         name: peer-v6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: peer-port
         type: u16
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 3d9614609b2d3..506260b4a4dc2 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -18,9 +18,9 @@ const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
 	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
 	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },
-	[FOU_ATTR_LOCAL_V6] = { .len = 16, },
+	[FOU_ATTR_LOCAL_V6] = NLA_POLICY_EXACT_LEN(16),
 	[FOU_ATTR_PEER_V4] = { .type = NLA_U32, },
-	[FOU_ATTR_PEER_V6] = { .len = 16, },
+	[FOU_ATTR_PEER_V6] = NLA_POLICY_EXACT_LEN(16),
 	[FOU_ATTR_PEER_PORT] = { .type = NLA_BE16, },
 	[FOU_ATTR_IFINDEX] = { .type = NLA_S32, },
 };
-- 
2.50.1


