Return-Path: <netdev+bounces-239455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D370FC68869
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 405AB35A1FA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237D31A7EA;
	Tue, 18 Nov 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MN/fxDSe"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A8312828
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457984; cv=none; b=cx8tghnrxCmrenfOqJ112Nz8yn1yxRXf60Zrd9SZBOM3FSU2VgjXzZi9W+lgHj0yC8nwrpDkIGR7WLLJwcWcl9Zxp434om52M1zoL8oA/mSBFQD7+CTpjfN36qksJex4a2cfLoFg7mfn0w+HW6hVF0SuUr5fQ97dQ7qcHNGTu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457984; c=relaxed/simple;
	bh=JB/8fm+GBjHf07GKRvk4N+rA32TYYCknuWcXznF5cVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qn7yW0RUD4Z109JbyvTxNJzUyW77hm2rLZ2VRQActDdC5OlmJLLVICxvNXDagOZZvuaxGpKOFy7Mwaz4ITEaCDQrcMegDcZ0V6A3rgiEoQZe6HXh9LmS+pEmbih+AngEisXh4ggnp4ledGrlb9asPYJlY8yLmt/g54Xe6yIBJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MN/fxDSe; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4C6312088E;
	Tue, 18 Nov 2025 10:26:20 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cDp9Dg8CJGFZ; Tue, 18 Nov 2025 10:26:19 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B0C81207FC;
	Tue, 18 Nov 2025 10:26:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B0C81207FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763457979;
	bh=48lL6Fh6cnkvZcHjRsQmWvMdekcQ+R9y0GvdmlQq0Aw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=MN/fxDSeAtGQwjlp7OxFuvLf1XtY1uZhgkJyHTubr9JDfqvstvPM4uidl8N6q+a5c
	 8JYh4MZv0F+W5pfnze9COWkXI6l1vqUM3xv02eiekM4wXeYv9tEAdlR2pbwfxp0ePu
	 orePqeFkeuNXKtZubIit8Xdgq0twRSuzYGFxPmYUwcVe1RJ3gcGMNQutoBbYTGi0uH
	 hvB4R42ri+DXxW8dOQoPbK0YHnKkbajM0XdfGT4+IC1KitjNs98Erm02oFrJgcyovA
	 8iiNJPDaki5Ci2MCQhUuE4+kpnoQTjKzZDc+XS8aBKun1a9FmrUWVKPNhYkPOwcnXe
	 ocxi56xyXzIKw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:26:19 +0100
Received: (nullmailer pid 2223997 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 12/12] MAINTAINERS: Add entry for XFRM documentation
Date: Tue, 18 Nov 2025 10:25:49 +0100
Message-ID: <20251118092610.2223552-13-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118092610.2223552-1-steffen.klassert@secunet.com>
References: <20251118092610.2223552-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Bagas Sanjaya <bagasdotme@gmail.com>

XFRM patches are supposed to be sent to maintainers under "NETWORKING
[IPSEC]" heading, but it doesn't cover XFRM docs yet. Add the entry.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d652f4f27756..4f33daad40be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18041,6 +18041,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
+F:	Documentation/networking/xfrm/
 F:	include/net/xfrm.h
 F:	include/uapi/linux/xfrm.h
 F:	net/ipv4/ah4.c
-- 
2.43.0


