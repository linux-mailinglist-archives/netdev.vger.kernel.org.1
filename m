Return-Path: <netdev+bounces-138179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6AB9AC845
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F11C21540
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CE1A4AB3;
	Wed, 23 Oct 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="M6qcBaUB"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287E1A2658
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680841; cv=none; b=Hb7ruBIu0JM4p0DHdS3ft5Z2l5XPssT7t8pDX2lhPU/cbDujcGJ57qgRuG77fUElI0GkxB9isFL0WvbhZTTP9orzIGA+7Bx07DBuuq+2YFsg1GgVNRhgnwWUu0rRfGKUffdXyTBNIH7GawYgRVzINYGhwPgl0rLx0RqToGx5eVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680841; c=relaxed/simple;
	bh=eLd/sGRiS+pFCP6ne3bsworvj9oBXFUEGh4vG6Y3i0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcjFvsBZTsvpTSARpdjwu0nF+hEmyYA7x3tFKjHEmOHww12k+E4yta9ugXSuhUbvRs5WKHZLLFfn+47E5nx8yo1LPXno7/K2Zg5EjORsXOFNfijjBX47U76Lru8pkZuz3khsUla9CLSzM3fdmtV60BRgf1A9ivbZoJXoxbniE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=M6qcBaUB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A34EB2085B;
	Wed, 23 Oct 2024 12:53:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NbYJaY2a7lGi; Wed, 23 Oct 2024 12:53:52 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D20B420851;
	Wed, 23 Oct 2024 12:53:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D20B420851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729680831;
	bh=BCuSOqqZ/r5jqkFe+vBmbyLNl/+cRzHkmTdEJNVTVtc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=M6qcBaUBEaRpEBqHbOIxAVw4kZJcLf1mStzaAFoO+iJ3+glprWf8/UfVqilu9unMS
	 Yj530MknJ94E2uGajIfrsFbd1YgmZNxHnfAXm9c50oIggExOVgG045BeOIp66NVxGH
	 qTqpZWdrwyrtPO0emAs/R+5Q9e1EPMp4iXA0DMiP2PxpoWqx8bEmZ8xGbho63VIIhl
	 HkPNV0r73aaSMC1gDW74A3mImSOa7OgzmTRm3E6JhnnOAUxY2P5vfIS1BbTq5tuJ+q
	 9PHwJye1PwfWQP0toPSVh9qX6eDHdznkBFZGC2N5CwjEI7oxud5ViRDnYoTR+AmTC0
	 9QJSoha083mPA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 12:53:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:53:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CF7C63184DD3; Wed, 23 Oct 2024 12:53:50 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>
CC: Steffen Klassert <steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<devel@linux-ipsec.org>
Subject: [PATCH v3 ipsec-next 4/4] xfrm: Restrict percpu SA attribute to specific netlink message types
Date: Wed, 23 Oct 2024 12:53:45 +0200
Message-ID: <20241023105345.1376856-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023105345.1376856-1-steffen.klassert@secunet.com>
References: <20241023105345.1376856-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Reject the usage of XFRMA_SA_PCPU in xfrm netlink messages when
it's not applicable.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a9d071c93836..7bf7c870b851 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3276,6 +3276,20 @@ static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
 		}
 	}
 
+	if (attrs[XFRMA_SA_PCPU]) {
+		switch (type) {
+		case XFRM_MSG_NEWSA:
+		case XFRM_MSG_UPDSA:
+		case XFRM_MSG_ALLOCSPI:
+		case XFRM_MSG_ACQUIRE:
+
+			break;
+		default:
+			NL_SET_ERR_MSG(extack, "Invalid attribute SA_PCPU");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.34.1


