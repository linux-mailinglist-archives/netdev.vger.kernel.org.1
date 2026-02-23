Return-Path: <netdev+bounces-260212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCR2J+PLnGlHKQQAu9opvQ
	(envelope-from <netdev+bounces-260212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:51:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0604C17DC21
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AAFE30D6E3D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319273793B8;
	Mon, 23 Feb 2026 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FNDp/mkA"
X-Original-To: netdev@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E633A6E9
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883428; cv=none; b=Bfyl0MDzEfx5WiLNjKZt03tnriz9KElBdgREUBrwa23KFuLeezqLKbuD0XISh9WUep4kG6ShWB30+ErQNiFsdyAwOJwx94s9A4O5NS3isR/0Qtsgu6YLME6VLSspvEpfS8IGhf3d1H9hpmvMkMR7d3tdWHPXTgL0Y2dXy0zJyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883428; c=relaxed/simple;
	bh=qtP38MaTf/OO1c4XDeW+gZQilw49VkT2LCkLWQnTNog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OagtBINxB6gAp9pZ+YbjfUMv8Rj3yTRvqrk2oDZ8ru0LQbwQqoxW3+5R4QPzkddIfUFgOim6U3hPY7mp8cMZzTDB948tjxp4BgsJglqzV6iJefk+D3pt0mWNcExlEODvFCyfbHj9nAjq5xqoDoUgL9ehU+tDpHDod/ppU+jNHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FNDp/mkA; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZKG623Pzlh1Wk;
	Mon, 23 Feb 2026 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883426; x=1774475427; bh=JMpWL
	lk4dcnYEp1thSbtksjwVomaU0aDgfmv5lEycPc=; b=FNDp/mkAhgK4vG8iE8zWM
	k+PfftIvKwmNzrnJi1hr0O641bexFcbr4DL8b/rQoyh87aNHmFsFDGlS+AOD2/Jx
	NWmdtth7kwqpbDV13JbAKZ3y+merbWxXR4Lr9LfSbz34acCbMuVkL8Y5zhHn3/SM
	KPaAvqz9tBbU/D5plUG0R5vsEBRVuK5bCz3d6vmlxkIgQ1b0zkCxvAWB8PfKdrPP
	aftLQ4cMJ3WVtXf2n4vK65+KVYH3As9P1i6spqgPvOdPfBIOQY8/hybsI3Ur9fP5
	cWm3KpBZf2iwxPY6i1D24GbM4ai0e5UK+A/NcRHOeO37Oq8ZtrdSfziUF10KByUc
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id s9Rg_GU3Howl; Mon, 23 Feb 2026 21:50:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZKF10M0zlfgPY;
	Mon, 23 Feb 2026 21:50:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
	netdev@vger.kernel.org
Subject: [PATCH 17/62] bnxt_en: Make bnxt_resume() easier to analyze
Date: Mon, 23 Feb 2026 13:49:05 -0800
Message-ID: <20260223214950.2153735-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260212-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim,acm.org:email,broadcom.com:email]
X-Rspamd-Queue-Id: 0604C17DC21
X-Rspamd-Action: no action

Pass the same argument to netdev_lock() and netdev_unlock(). This patch
prepares for enabling the Clang thread-safety analysis functionality. No
functional change intended.

Cc: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
index e062d5d400da..950708575268 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17121,7 +17121,7 @@ static int bnxt_resume(struct device *device)
 	}
=20
 resume_exit:
-	netdev_unlock(bp->dev);
+	netdev_unlock(dev);
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);

