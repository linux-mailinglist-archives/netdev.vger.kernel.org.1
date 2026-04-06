Return-Path: <netdev+bounces-275631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPrcCTnS02nGmgcAu9opvQ
	(envelope-from <netdev+bounces-275631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:33:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE2A3A4C68
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 17:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B80AE3011748
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0E26A1A4;
	Mon,  6 Apr 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RzztBOnD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DF1514E4;
	Mon,  6 Apr 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775489589; cv=none; b=jy125zdass/bIhaevICjs9nzfOdwjDhCFSifQZO5ufS903comPM0+2pPoveXbPFUZjrOvKzmPrq2mQMbe2Nx4viz2tqXYdeKWvAsKjlqqB260k2j0ooUYezp1jDRfQqNAO5+rpWFMvfRPH1w+zs9zwKJKLJi7dqb0fgXMdSyZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775489589; c=relaxed/simple;
	bh=cv/rpa3GqM2NidjZX23eueMStM8p/0HTp8XBZXdKvDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VP7OEjFy+w+oDb+fGjDoWl/V6TrCZ3+DB9UoQ+lkN9mF9jXsjh6m8zhYghHd3/Ox0sp+eYOGIY1nlZJxRc01yBeIIgHANreJjPcBe3jpwCE2pVWW7sWP0bQweF8PfEt3Kvu7BVZ2NBxDIQ8fJXwWSW4gthVAPo7haThonLtRLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RzztBOnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25E8C4CEF7;
	Mon,  6 Apr 2026 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775489588;
	bh=cv/rpa3GqM2NidjZX23eueMStM8p/0HTp8XBZXdKvDE=;
	h=From:To:Cc:Subject:Date:From;
	b=RzztBOnD2Ohi7dSt+je6+K86zp8MhEQKY8cy6sSIZFjUELtYamPJhxHYOvw/916VT
	 1wr6Xn5DQQHr+5xMhemoikntlf0P1B8LtS5X0rsN2TzwsU41O6uLHEe+8rdyrDnDSC
	 k/KFedzGaUN2mkJyCK2wc2JAyMu1XfyKVpXojMO4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] xfrm_user: fix info leak in build_mapping()
Date: Mon,  6 Apr 2026 17:33:03 +0200
Message-ID: <2026040602-shack-tamale-d8c3@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 36
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=cv/rpa3GqM2NidjZX23eueMStM8p/0HTp8XBZXdKvDE=; b=kA0DAAIRMUfUDdst+ykByyZiAGnT0i7ITkEI72eGBg/c51t/a6eTNgtHCuFZedxIV7FFIThN3 IhdBAARAgAdFiEE9LYMxb94wiFKMT3LMUfUDdst+ykFAmnT0i4ACgkQMUfUDdst+ynnoACeLnV/ NJl8eBO9AKZKooBHT+jZXi4An1xhW6D44/m3ZrYGs3/T+FSjmVp7
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275631-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,secunet.com:email]
X-Rspamd-Queue-Id: 3DE2A3A4C68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

struct xfrm_usersa_id has a one-byte padding hole after the proto
field, which ends up never getting set to zero before copying out to
userspace.  Fix that up by zeroing out the whole structure before
setting individual variables.

Fixes: 3a2dfbe8acb1 ("xfrm: Notify changes in UDP encapsulation via netlink")
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, I think this is correct, as I don't think a new skb has it's
fields pre-zeroed out, or am I totally wrong here?

 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 8a854fa9567d..1bb8d05561df 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -4165,6 +4165,7 @@ static int build_mapping(struct sk_buff *skb, struct xfrm_state *x,
 
 	um = nlmsg_data(nlh);
 
+	memset(&um->id, 0, sizeof(um->id));
 	memcpy(&um->id.daddr, &x->id.daddr, sizeof(um->id.daddr));
 	um->id.spi = x->id.spi;
 	um->id.family = x->props.family;
-- 
2.53.0


