Return-Path: <netdev+bounces-145098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784789C9624
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A4A1F22747
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D41B394F;
	Thu, 14 Nov 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="RzeIgxWM"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FF1B2522;
	Thu, 14 Nov 2024 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627211; cv=none; b=BivZMpb7I6jHBKJTtmIKGNu7qc5elHX+PyXKSO0A7bD2rLEz5CCiPDaNPJpSAaD0BgpVxPewUiUgebMmZfA83m8MRjrPqWehxIJWPPn/jqmpTdVJ0PiCtEddGT+mUO5pCxbjeyH2JJloFidnkVnvXuiz50/5eGrrIrv+8goUSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627211; c=relaxed/simple;
	bh=HCw2QyczsQy1jN8J8yTLSykC8+uwn1LUS9r12iDDefc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBi3i+0e/c2upe8HziwdZGRkMDuFsimtKswZXOcww9sAlxFRCST8qCyouoilaEQQIHXyIy2duhrNebUQkU8c0P09hqHrWAfYgRfgg2Hh7eWT93EEDxqW1Mcv5PwdKAi2HYY1alScNQj9GZFVTj88BllR7zXGMQPrCyB6b2F3Pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=RzeIgxWM; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKn-005yfq-2q; Fri, 15 Nov 2024 00:33:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=HOUl2UQCNdFUs+2Oh40+d3EZmBkRW+mer2gol1WTvU4=; b=RzeIgxWM7hQ9/TjoysrWPjYPed
	9NBoMnHf8nc3TFPqjUkgiyR+OlYGYLxixEWYxfh72CVA8TZnrWwkjbrkir06Y1GjNCMBJo+w8pAUw
	ZMTiwb6qcvP0MLEYTHJ6Grxjg0NmImE6kwsbRcLFNLbjwmmV3Q1BbLd/CU8IK7FAO8L/Gg2XtVMOa
	AwssEQp82J2kycmgyeu9xgRN4FsHPoviAZoQV+5FTp9q+KpBvhwyCNj/ehnXd17mBlV5sGDl+m62J
	mPntZycIkHuLwGSwVvG6dXmw3qvB/AScJmgnNujWz4fuUenCp3hF+RaBe3tC9XfABRxaf7AOoD4fl
	Wdh/jWPw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKh-0005mR-Ia; Fri, 15 Nov 2024 00:33:03 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBjKQ-008nXm-9X; Fri, 15 Nov 2024 00:32:46 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 00:27:25 +0100
Subject: [PATCH net 2/4] llc: Improve setsockopt() handling of malformed
 user input
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v1-2-d183c87fcbd5@rbox.co>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
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
 net/llc/af_llc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 4eb52add7103b0f83d6fe7318abf1d1af533d254..c4febedd1ca0e959dcecea524df37eb328bd626d 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -1093,15 +1093,17 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
 	unsigned int opt;
-	int rc = -EINVAL;
+	int rc = 0;
 
 	lock_sock(sk);
-	if (unlikely(level != SOL_LLC || optlen != sizeof(int)))
+	if (unlikely(level != SOL_LLC || optlen != sizeof(opt))) {
+		rc = -EINVAL;
 		goto out;
-	rc = copy_from_sockptr(&opt, optval, sizeof(opt));
-	if (rc)
+	}
+	if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
+		rc = -EFAULT;
 		goto out;
-	rc = -EINVAL;
+	}
 	switch (optname) {
 	case LLC_OPT_RETRY:
 		if (opt > LLC_OPT_MAX_RETRY)
@@ -1151,9 +1153,8 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
 		break;
 	default:
 		rc = -ENOPROTOOPT;
-		goto out;
+		break;
 	}
-	rc = 0;
 out:
 	release_sock(sk);
 	return rc;

-- 
2.46.2


