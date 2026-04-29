Return-Path: <netdev+bounces-282360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FGIL+zu8WmulgEAu9opvQ
	(envelope-from <netdev+bounces-282360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:43:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE86493B01
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9B4F300380E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2123E3DB4;
	Wed, 29 Apr 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="YaNpkrW6";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="aIGYQGlc"
X-Original-To: netdev@vger.kernel.org
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2D3CA48C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.144.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463013; cv=none; b=GQFILTih7YtB5WiNC9SQZOvsDx83f61i4o/qfFjQ+4uPv4P2iTZy+/BBKY+3VaPwpAeFe0anCf8OS8g1/RCQthV+1P4LSCU+2NNirYZcoeEGdQOFr9lxBoNCmGNUcq9Nf0QHxFhM16eEt4RIHQExyxzBLhq9xt9E6rrDfVxXw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463013; c=relaxed/simple;
	bh=3qKJztgQJUPlrEGGhE7sBKYebN7wefY41CWQRFz0KqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEeHpiDOyeX52F4Yuf2apHGoR+0k6Z/P6dvr9LK1oy/7a8T/S4Ij2n2odstW8MfEfVred1PIHUuPbjeh7QR0fvXHGp6AzukYcW8P4bFnqDAl0DTvacsF0v5EHh7bc+52F3N8EX6Z8r1O1lKFQSL55aQgFNJ3WP7zkszLdC7XtCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=YaNpkrW6; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=aIGYQGlc; arc=none smtp.client-ip=18.158.144.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=dTVmkDqISXk7x13mQynSnLZ/iRnnoPVhJt0i9GNoi3E=;
	b=YaNpkrW6dm4ahj1G8g79bt9TkR0OF+l+aKtbgTA8HOxcZcNRfp0GIwqnQJ86DTRFAaQ6acqoNw9/g
	 RwRrkBoJk3MaOuhjLzzj0RsEbfC/FhQd2Nd+63VrO6YpbTxvmGAMi0Frb7GRjTfrooA4RGcS8FOK+P
	 VMADsISbWr9AdVB4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=dTVmkDqISXk7x13mQynSnLZ/iRnnoPVhJt0i9GNoi3E=;
	b=aIGYQGlcV7oRz7IIkdVucTBrIAJ6zPtcmqEE0WcY214xKJPrSILxg+b+lYuaEo/QB6Wb0MT0XR8oz
	 sklnzykja+h9R4YY9+ruDCmlhZJccWircXTRTky0aFck35OeT+QKT+m84jbnmdnHAL2WGt4ntYjgad
	 AYVtNPyLhI4A88WBfoLLFHGG0hmCFkpdFqR+aCBTMvNB5pu/VptS6Bsdt63y/qdu1mXVs5fQQrAgPG
	 IsdiHhPdNPUWTihbbsM+vW2wdEysdaDllKTO1zMzm6axCzpBCuCKZPvj4B1emZfpM/O5wZg1qI5Xp+
	 pJOJH8hDgu9WCMnq6yn/TSjqLVtYF7A==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 7752593b-43c0-11f1-8259-bda8640e0fbb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 7752593b-43c0-11f1-8259-bda8640e0fbb:11
CFBL-Address: prvs=057955d709=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound2.eu.mailhop.org (Halon) with ESMTPSA
	id 7752593b-43c0-11f1-8259-bda8640e0fbb;
	Wed, 29 Apr 2026 11:42:16 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id A9D4E1614;
	Wed, 29 Apr 2026 11:42:13 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 3563E60B7D47;
	Wed, 29 Apr 2026 13:42:13 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Date: Wed, 29 Apr 2026 13:42:07 +0200
Message-ID: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DDE86493B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=duo-1630306886989-947ac67a,outbound.mailhop.org:s=dkim-high];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282360-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[hitachienergy.com:+,outbound.mailhop.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hitachienergy.com:email,hitachienergy.com:dkim,hitachienergy.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outbound.mailhop.org:dkim]

Unmapping of uf_regs is done from ucc_fast_free and doesn't need to be
done explicitly. If already unmapped ucc_fast_free will crash.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 3bd57527b1be..8155e92af14e 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -773,11 +773,6 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 	kfree(priv->tx_skbuff);
 	priv->tx_skbuff = NULL;
 
-	if (priv->uf_regs) {
-		iounmap(priv->uf_regs);
-		priv->uf_regs = NULL;
-	}
-
 	if (priv->uccf) {
 		ucc_fast_free(priv->uccf);
 		priv->uccf = NULL;
-- 
2.52.0.120.gb31ab939fe


