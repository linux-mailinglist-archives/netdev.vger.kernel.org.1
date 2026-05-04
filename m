Return-Path: <netdev+bounces-283937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOH1FzHF+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02A4C1386
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 138173037155
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C93DE45D;
	Mon,  4 May 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="OL9uAbSw";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="p/AJbfmr"
X-Original-To: netdev@vger.kernel.org
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F613AA4F8
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.144.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910869; cv=none; b=jaeRsNI5Xz/K6MkS8auMLTM/4XHAingTQ+nHEqJnquvkbyvrUiJGIche+ASoTakD6CpHdK0jERUBgYoPYqfwK9bQN4v9ztic+O0mgm1xbPABnvjpWEeOwpzyrEW4hJUBvEnpq0IwH3GFxZw7P9WYRWpaKClQlwEL3ycDaPKbvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910869; c=relaxed/simple;
	bh=+eyvgnBcgfpD7w2jYYxwjkWtmk2VK/L3esmIDRLa0RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRqKn+jfFyNRB2RaXg6RF+gaJbPLo9N97NdRDzjKONMOLWO4KW8ELdvYBh21uXuXsnns31+AEBNci/lbQ0e8cepfv/+U7owzFMHv0VsTew+7lYuJl3aT3QYgARtZtnbYVHbKncxGmVC4cHK+4vs5ydjB7YZymwiJ59q8cuQ30wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=OL9uAbSw; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=p/AJbfmr; arc=none smtp.client-ip=18.158.144.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=EUFvEmeJBYqCCX1r0w814BKzBUANfrvmRMxAJS96h18=;
	b=OL9uAbSwv0OdhxtUZKu7+aP1M6sJQJy8IuZvrTsj4C8/1PMtPKcDs/yfV2owleIXMJ/hJZbwsBwHn
	 9zvwQwub8XsdVqVmnzVM0hD8dTP/MepBois+N23BR0jg+ycKRoQkDLJQw1ze5MIJ35JcIejmuvfcBv
	 iQAHBXGw4fPaWAn8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=EUFvEmeJBYqCCX1r0w814BKzBUANfrvmRMxAJS96h18=;
	b=p/AJbfmrQfjjgioexoZTNZhJbP49pLzX6RLHZfUF6NqV7dlrFFZA80v7fcQpyjBW2Zy+57DCKP9mS
	 dPy2PX9o5a5SO+tNosx+FBgJ+mZv2hHET+cxI9yfqas7cMp2+/fnQgiGwhg1nnX7S9Ywc73zBqTf6c
	 LG0tXEq363Bh2djXz4tvcsRWRB+/Y5Ydt+4RA5qoYBmApIGtmrsqPFXyfnka7E4QiN6nH+SwYXc9pl
	 hnsM0afATzByE0y1l/k3HnRiD5wOvCYHyqb1gtMT9jDJ3/miyQd6naCTuXiPLrZjUGzO9IrsZ2R6fa
	 aVSlHt3RgPN5Xa+CCNK4HuhqpITPZyw==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 5de56510-47d3-11f1-8ef3-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 5de56510-47d3-11f1-8ef3-f54febe22707:13
CFBL-Address: prvs=058485b737=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown [20.82.50.241])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id 5de56510-47d3-11f1-8ef3-f54febe22707;
	Mon, 04 May 2026 16:07:38 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with ESMTP id 51B5E805240;
	Mon,  4 May 2026 16:07:36 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 25F0C60B7D47;
	Mon,  4 May 2026 18:07:36 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: fix indentation error
Date: Mon,  4 May 2026 18:07:34 +0200
Message-ID: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC02A4C1386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=duo-1630306886989-947ac67a,outbound.mailhop.org:s=dkim-high];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283937-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[hitachienergy.com:+,outbound.mailhop.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hitachienergy.com:email,hitachienergy.com:dkim,hitachienergy.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outbound.mailhop.org:dkim]

Remove the whitespace to fix the indentation.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 09081f128a98..adf3863463f5 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -764,7 +764,7 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 		qe_muram_free(priv->ucc_pram_offset);
 		priv->ucc_pram = NULL;
 		priv->ucc_pram_offset = 0;
-	 }
+	}
 
 	kfree(priv->rx_skbuff);
 	priv->rx_skbuff = NULL;
-- 
2.47.3


