Return-Path: <netdev+bounces-132592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B9A992521
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE85828172F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453615C14F;
	Mon,  7 Oct 2024 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DOLsvCx0"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5BE158D93
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284045; cv=none; b=DM56MuDw3ReEk3AbASGFmbS+FpBwVRFP3aUsXI5YwPr85VhaMD9bIZ/FZ+O0vr/FBdJLdbUgfhdKVCO3sog1FpJwtFEYP8SOL9HhyZ91P7pLoUxtm5atBeY24R9kyjaAyvsg1NmeCmnulZM8EBjNuMyfzsU3M9Alezey09G1t0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284045; c=relaxed/simple;
	bh=XtOY9S5mY0quqEWuanChRwP8bWzwSEoTEAEQmkv4XbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Twh102ZXGQH2q/XgQ9i54Uljc3IEwL6cKwxPHE7l2qHJQ1xm3qmmNkaGAeZOm+4YRdAjnvlvppT8LhR+7uvtWvsGWNub3Wj8xmeotRrutU5xtYC9O7ngGRlQRkgl50tncAQJpNGY2WZ+Q//oleHTPTUXaRA0DSo54YlWWdj5exk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DOLsvCx0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 89FF72074A;
	Mon,  7 Oct 2024 08:45:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9QjrIZ8s1oVH; Mon,  7 Oct 2024 08:45:20 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 66BA620754;
	Mon,  7 Oct 2024 08:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 66BA620754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728283518;
	bh=UVxy/2tr/O+QWiWYEuydbcl+tJFIqZfD3iZF7Etg4l4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=DOLsvCx0gCwz7IfkxzjSYY4l8gnZPN40qbdOrhvg01vDw25dPAtzlBWjdSleZmo9Z
	 3onLW83TebKhsaTmYVQfSldaZhF2imvKmC8x8iriPHI23dql4lEqWnydkVUws7hGRQ
	 BAaOm6YIQlgiPI9k9VxLDQhwVYi8J+RV8pW2p/vYGVrH7Us0CyTE5uY4Iigfy/S6Vl
	 G9Yzf+vC3CVtzxb+a1iME+TLRD3TAN5en3iyjgvgPX+JuQbFQMcKOi3AK8FIa0eqx3
	 1FMYqrrXlTzesiWK0GUNBpVVn2u8DmTj8LYGWGEQpZ2O4UWj3IcUCmSz/fRWCBAR5U
	 noKnAQBzr64QQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 08:45:18 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 08:45:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5336E318416A; Mon,  7 Oct 2024 08:45:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, <netdev@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, <devel@linux-ipsec.org>
Subject: [PATCH 4/4] xfrm: Restrict percpu SA attribute to specific netlink message types
Date: Mon, 7 Oct 2024 08:44:53 +0200
Message-ID: <20241007064453.2171933-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007064453.2171933-1-steffen.klassert@secunet.com>
References: <20241007064453.2171933-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Reject the usage of XFRMA_SA_PCPU in xfrm netlink messages when
it's not applicable.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6bf53e17d382..291bc320c072 100644
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


