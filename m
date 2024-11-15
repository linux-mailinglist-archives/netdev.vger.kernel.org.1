Return-Path: <netdev+bounces-145202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4C9CDA9E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B67283AC6
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84E18F2DF;
	Fri, 15 Nov 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TJSmmzH3"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3F18E047
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659641; cv=none; b=A3APIW7cbgNbj5lWWd0OyeA+0MqbfdsJlbrUq4U/d3T+8C/1+/FNmY4Lg/Q0L+OzYAjTgVZqL59P3yi/Na3FH/Wc2blBtkKkYBPowuhefuf9yRgv7N4+oA4mgEAaP2iCSPK/ngiqpz0HE6yFolM8NhYOKAg1RwfrN1jtW4yo0vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659641; c=relaxed/simple;
	bh=mR9oF9pmJrdKyAvQOaGFFHhsiHBlVtpCxrHO2l0iVz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3GEymK4EiG7I0Ym3/AlAxqIO1t0fwbepqrTgXEn//InfdSrbre/iEOWeCSZ6cK/fx3uNdgST0pYdX/LFUZwOWqA/99S3LqwhW1kN9OVTHu9xsOzSDYxihl2m1KRYtl44G2gAi5k5i0YW8KPc02jYeJzPrzmFUXhLVxtYO800C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TJSmmzH3; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 05CCF2085B;
	Fri, 15 Nov 2024 09:33:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cqMDxTfCfTmw; Fri, 15 Nov 2024 09:33:55 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4937320860;
	Fri, 15 Nov 2024 09:33:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4937320860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731659634;
	bh=m9pn8vndlsDqENatj4l8afVbrs1SQ/EJzrqtZ6nt/Fs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=TJSmmzH3TuYf3HDZ3/WcBia60xu8zExkV71gMIXTgNttWPKBwqTv1PJovPTsXG+64
	 t2TSpE01VneQmQTox+5MRYXpL6UqRyCA/eNqY4VbNf9jT/lRVXgHw5x5baTKUvaTnm
	 cqZ4wM6Q/DAneqg8/OmHMMCEL/WNsYBsRofV1MU3CP+xEk0zv/TWJbZKrSv4jdoFSv
	 MxvMNKxkY0D7A9uDbWXW/SahZ3FEJCB9PiffsHLkvWG/WX7X4hZBmJZ9PIFmgAjBRV
	 EU0q4Vhx3OuHKrU1xbtK/dqWNbxmwmSbVHLE9zFaHivKysFZp0JB8ljOqYZ9a5wEci
	 vW9OoEXBgmacw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:33:54 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:33:53 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B85FC31843FB; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/11] xfrm: Restrict percpu SA attribute to specific netlink message types
Date: Fri, 15 Nov 2024 09:33:36 +0100
Message-ID: <20241115083343.2340827-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115083343.2340827-1-steffen.klassert@secunet.com>
References: <20241115083343.2340827-1-steffen.klassert@secunet.com>
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
Tested-by: Antony Antony <antony.antony@secunet.com>
Tested-by: Tobias Brunner <tobias@strongswan.org>
---
 net/xfrm/xfrm_user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index e4d448950d05..b6ce2b3c6b87 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3282,6 +3282,20 @@ static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
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


