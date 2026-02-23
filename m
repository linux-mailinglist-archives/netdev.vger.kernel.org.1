Return-Path: <netdev+bounces-260217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NF6N1/NnGllKQQAu9opvQ
	(envelope-from <netdev+bounces-260217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:57:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542517DDCA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAE6F30FF3E4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743F37AA90;
	Mon, 23 Feb 2026 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Jl+5aZn6"
X-Original-To: netdev@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92AB37AA77;
	Mon, 23 Feb 2026 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883578; cv=none; b=qaz+uSSE2XSctKDQRgrEUGHZrUmju9+ScbQFcjEy6yS9GGV22ftBq0zOY+Z3VLbCuGYM6QQL0O+0h/sELQliyFg/Eb4vHlLFp5wl/V6fw3uOokzeCwrzCrJ2tmBVUeKIA8Lxjsv4Xp58pb6ilX185muQAXNxWj5pnaBf70XmnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883578; c=relaxed/simple;
	bh=qtP38MaTf/OO1c4XDeW+gZQilw49VkT2LCkLWQnTNog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6kWn5dI5yt6MP3SOpqktC6oG6kqKd4VVOQWESr6moBL/FnJHFbI7+O9CL1uJPFNLmEVLLdvG80QAfCk3ZJO41ZrxaifTtILL5QrXmfDk4CRTUvZHfcoUOKr0R2ncspsNrpIwzCuHKRzI924lQPCzd+opRwgIp8magHyAgYhaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Jl+5aZn6; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZN92yFPzlh2fR;
	Mon, 23 Feb 2026 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883574; x=1774475575; bh=JMpWL
	lk4dcnYEp1thSbtksjwVomaU0aDgfmv5lEycPc=; b=Jl+5aZn6pHkDjwICY1GnA
	kLcvzWBkkf/K+4DNz5VYRwyCgHjeLCkZP7XoJP5XY/NhT1lzGwBYsQiR01i7GPE3
	93yAf2R1lZAsY5QW6DdNHO/a52Rk7Vt4HuSjk/IkgxtcXH8mRJqFLlzC/KIm9QTQ
	HqhciPjHpiVv98+/YTyw3o+tN1U7J0TvTdumdv638+XMq6k9GFUMZAh6Xqk2kLVz
	DpAwVk6bEZpTiEeRrlgEfULZZQxgoWGHkR1avanf6ZTl0/qlPs9UQqa39WpnIeE5
	JwsTEfmbFUT5sRJEGLhOqfjbxw6fuP6RXhYOmumoyp0SO49C48G13ni2PS2oRUcS
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id okCeZ4GAIqNR; Mon, 23 Feb 2026 21:52:54 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZN25bD5zlh1Wk;
	Mon, 23 Feb 2026 21:52:50 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
	netdev@vger.kernel.org
Subject: [PATCH 17/62] bnxt_en: Make bnxt_resume() easier to analyze
Date: Mon, 23 Feb 2026 13:50:32 -0800
Message-ID: <20260223215118.2154194-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-260217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim,acm.org:email,broadcom.com:email]
X-Rspamd-Queue-Id: 5542517DDCA
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

