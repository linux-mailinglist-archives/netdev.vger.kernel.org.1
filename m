Return-Path: <netdev+bounces-229124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0ABD8613
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860DC1923427
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5D23F294;
	Tue, 14 Oct 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hHEKw3vG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vLp4/teg"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8ED245023
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433482; cv=none; b=Lmco5n+csVm9puWCvOtMqCliWsFHXMo4BnLj4xP/1AOVW8DYfSwAjLbW75j/2wncuc1cM2bSRBmYYZL1qTamjU/WGZ20Y4TdtgYLBCIienJJ+RML0Fq0aFMinPo0CzILIN1G4YDm/1Q7hFlZagBKAknplueK6YyOUgM+wYFyyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433482; c=relaxed/simple;
	bh=Qps+QhqHweubUDvqQdXgpGBpXSuTG1F3M7FuxgXhRkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpfvJWxsP7pdOLEXnF4dyRiPkk2P/GUYUn0IutMq3hTQpaoPOXh4kD2+fzhwP4Ok9bfcOPjEtwExYTdDTzC++dWXEVDEb6VuaW/bnZ0qIyfOtCUa2oD/U2k6GhsfRdlDehiKUt9ab25C2C0OAvejD+befgvZ/Dc6EGITbEwcegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hHEKw3vG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vLp4/teg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFF8414001E8;
	Tue, 14 Oct 2025 05:17:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 14 Oct 2025 05:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760433479; x=
	1760519879; bh=vKznnaDAPZZd7T4UUbylnitsm5NsoRB4DfPaX5+6qDo=; b=h
	HEKw3vG0NitrQHpMb+k4hUFR21P9nFVge2CUHNQT4Kpo1cNnknlDPgJlrPAbtmK+
	BrBMbYQnCP1LYUpISrQMIqeuu11OVKzzIHY6VPhZRvpDeX2ca3QoBfcVr6gfxGCr
	quJIsiysvjUuSTDGhZCrYwyYSp+2Mj5MxQR2JZGMDf03ijObK2zFEBl0OarDJnB7
	cACRTPGwd7Qp6OvWBmvIdFY1ss9HmXB9JBU/I8V/krZ6hVfpyQy5+Y0qLYmu1FaF
	7pgDmWbESPuUXOMKgcTTPWYoV5S5hGE0I6g8MIWTmLHvym6MrUZOq09qnutBWJzR
	EIl0ZYTxAhAx/b84SWbCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760433479; x=1760519879; bh=v
	KznnaDAPZZd7T4UUbylnitsm5NsoRB4DfPaX5+6qDo=; b=vLp4/tegzU76n05gS
	E3hm1H2A730QTU1WwcSrnCDeRo42zjePlFFCdK+QDQZ682tlnQzSQvxx5PhKRhtt
	p49E03AlQllT6gyf4jpHd4Strklw7/rAsFkN9gt0NyjHCs3ea/fCFMFenZSExcWE
	4q7MVURAFegjgt0Kdr8K9k4kU/EcrNWMPL6Ps7jzHYDMXSOxfEh4tkcTreu5H/B4
	U4DH4XSYJfjdaeToaSj7hBb1oQZNj10AhLbBCEmDoUbQKJRCGAaXm3KG8AkrPknk
	tthucx9APO0ad3x2nMNStsz6CMUh7M6eAf2eJZZ8w9iGNveWSt2npdFNVQn728O2
	Zvj/w==
X-ME-Sender: <xms:RxXuaKOS0Pi2gB0SBt6Yi8qo4ttM9SIRLo1HqIOFbzCrt1KnNXxSmw>
    <xme:RxXuaEd043-PVDyF18eA5YPttQzI8NWF2Zs8kOSA6lTCRiGb53uvuqzoGC2EirfsU
    fzLb0cC3jVvQUst5R0E4soyD7IDklmXByVA2u_IM_9L9QEq3gdxaxY>
X-ME-Received: <xmr:RxXuaHt2ZReRnX6gAjL05r-L1Y3gZ0aRLgJZLnDZGeP--GugiqwIwqZwXnHb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhhnh
    drfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RxXuaFmxHzdiMdQHh8OUZVd-dV9lc2NrXH-BvEv8DVoBjoiuIQ36LQ>
    <xmx:RxXuaJzS3KHIMhU9Jr1NG_NgqaaWug4xlYq-WaH0ofiTlhxgM7cCgA>
    <xmx:RxXuaHMcRxYne2ObOavVqIC_9SAi5WH3-xAOfslLz6KSYZ3116ufUg>
    <xmx:RxXuaFqwS0ul06s1k_4XnuQbinLTbOGW3M5XfASXXMDsThoMGcQslQ>
    <xmx:RxXuaCLl_9TKpOJ20_eA5JsKiged1sa1RbYG1eguMpBp3-45QSufBqxp>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:17:59 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	jannh@google.com,
	john.fastabend@gmail.com
Subject: [PATCH net 2/7] tls: wait for async encrypt in case of error during latter iterations of sendmsg
Date: Tue, 14 Oct 2025 11:16:57 +0200
Message-ID: <c793efe9673b87f808d84fdefc0f732217030c52.1760432043.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760432043.git.sd@queasysnail.net>
References: <cover.1760432043.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we hit an error during the main loop of tls_sw_sendmsg_locked (eg
failed allocation), we jump to send_end and immediately
return. Previous iterations may have queued async encryption requests
that are still pending. We should wait for those before returning, as
we could otherwise be reading from memory that userspace believes
we're not using anymore, which would be a sort of use-after-free.

This is similar to what tls_sw_recvmsg already does: failures during
the main loop jump to the "wait for async" code, not straight to the
unlock/return.

Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 36ca3011ab87..1478d515badc 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1054,7 +1054,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			if (ret == -EINPROGRESS)
 				num_async++;
 			else if (ret != -EAGAIN)
-				goto send_end;
+				goto end;
 		}
 	}
 
@@ -1226,8 +1226,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			goto alloc_encrypted;
 	}
 
+send_end:
 	if (!num_async) {
-		goto send_end;
+		goto end;
 	} else if (num_zc || eor) {
 		int err;
 
@@ -1245,7 +1246,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		tls_tx_records(sk, msg->msg_flags);
 	}
 
-send_end:
+end:
 	ret = sk_stream_error(sk, msg->msg_flags, ret);
 	return copied > 0 ? copied : ret;
 }
-- 
2.51.0


