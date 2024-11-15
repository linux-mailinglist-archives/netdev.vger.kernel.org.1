Return-Path: <netdev+bounces-145259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA79CDFCB
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E131F23A04
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143911C0DED;
	Fri, 15 Nov 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="aqPRxc32"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914011BE871;
	Fri, 15 Nov 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676996; cv=none; b=M++15xmM0zz7p7mluLspSDkE3dv1bfWZVyATfHZLwjfi80VW3cTsIv7LSRjJRjRPvKLNS0pUcVXyPpsRUPsQ2/VlLcKR0917RwbeyKiYujxldOI7XLeM8VNa6L8oRJu/NnRq2L+ClxysCC2aPMDyeiwBqG0u3RFwoH2MCw0DuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676996; c=relaxed/simple;
	bh=3jWAuvttfkTfZzsbxtcgvV47odMj7CMhzGkoNkPJSdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQBhNfSI9gV16WwvcKWo7WGW0sDV42xPOtgwVyz5z3ukb+kxlRdgX5H11CMvAO0yeEUq2HSkIAxgG6qSSqnbaBPizCrIW44L+SuDYrbCAaIzCxXSCoSP0EzBQCnindQqjIMcZ+hv+CFlMRiuYiNyGpCO8t2IActQeEpv9oZQVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=aqPRxc32; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHx-007mgY-Ud; Fri, 15 Nov 2024 14:23:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=yJFTAVAASI6sxwOZOt2cXYits0TqNJEJCAJ5jZI1vVM=; b=aqPRxc327TcX14+e4T0mqiTsgR
	aD+b08trHITt/cIcXnpY5l78YvXWGWq3asem9bOxE/bSpH7YFWWt+c6hA6qR8Bn3Sb9jyLrbOic5/
	WAtydNrEHMO+GkNw0U8qt/PU5Ahfo5ejor99SPgOIcE6AX1jLtrjQXSXDRcqsdRCQNPW3b1r2pH2l
	9CJriqzR49jdYOVyICpwAY6TwjepC6CwilpEfPox8Yue68tMEp+WH2hVPuBhoQ6Bd6gee84H5Iimw
	2JIoJMOEYlVQ5kO4L/8cpj2rxIgW2/QUTno4ZgkLWNKYGDLD8NcP0bGgelUBX+iWufVZ9iFCyFxiS
	cdzZFbjQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHx-0003ow-Fo; Fri, 15 Nov 2024 14:23:05 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBwHi-00BIK5-SJ; Fri, 15 Nov 2024 14:22:50 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 14:21:41 +0100
Subject: [PATCH net v2 2/4] llc: Improve setsockopt() handling of malformed
 user input
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v2-2-9b1254c18b7a@rbox.co>
References: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

copy_from_sockptr()'s non-zero result represents the number of bytes that
could not be copied. Turn that into EFAULT.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/llc/af_llc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 4eb52add7103b0f83d6fe7318abf1d1af533d254..711c8a7a423f1cf1b03e684a6e23c8eefbab830f 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -1096,12 +1096,12 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
 	int rc = -EINVAL;
 
 	lock_sock(sk);
-	if (unlikely(level != SOL_LLC || optlen != sizeof(int)))
+	if (unlikely(level != SOL_LLC || optlen != sizeof(opt)))
 		goto out;
-	rc = copy_from_sockptr(&opt, optval, sizeof(opt));
-	if (rc)
+	if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
+		rc = -EFAULT;
 		goto out;
-	rc = -EINVAL;
+	}
 	switch (optname) {
 	case LLC_OPT_RETRY:
 		if (opt > LLC_OPT_MAX_RETRY)

-- 
2.46.2


