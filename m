Return-Path: <netdev+bounces-276083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD7cJusw1WmU2AcAu9opvQ
	(envelope-from <netdev+bounces-276083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:29:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F317D3B1DAB
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B203002F8E
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03E397E83;
	Tue,  7 Apr 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F2xieko8"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCA3B6364
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579148; cv=none; b=ceKUDgaavK3F+1Pu6zv/Ufp9TUAaGrRYkKmd5T1DGNCPKLu5wA5qlGFM/1ptKfAd/Y5z5KieZgRcv6Ty4YqA8KA02hjLvi7mf2Dvvs+H62eCkxkSmJbTr1z/k7BZZQ7uJalpmt7hiMypzSZhWLSsBZUKNlwnrIh76KoztaA9328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579148; c=relaxed/simple;
	bh=pmjkMioukLW5g1txgrEEVf7hs/e4o+qCrWbxN4mexf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW2TL2AcBcZVPGmeWukeo64R5yq3OZw2ivOr6DSL5HUDy1NF5K/JVDGnjQUPtD8quj+1au9BkzOz0c/fMyIpsO9BgF0wSiHDUVIfZLUyhS5INjklclNT68qO1d93fWAVjCm5eIT+gnA+OB/MlbLss2YySL95YcZqbmCtjQwft+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F2xieko8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775579145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2nx21UCgkelQfmsgGrpgYKaWUBt9g94q5n1ek11K60=;
	b=F2xieko8jOnq5N0YUiCjgnEmedw786pA5ZyS14GdnXEQJ0h8JTP+sdT0p9voakFiL69hV/
	6PgcUxReE/yiK9Vg5ItFfSlSMxhvShGfBbr/VgbOjychgv+/fpkFLIITpEzRxcn2gFZVKD
	4iXanCO6HPOk7mnnGSszZlv5JCIfRHs=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v5 2/2] net: hsr: reject unresolved interlink ifindex
Date: Tue,  7 Apr 2026 18:25:02 +0200
Message-ID: <20260407162502.19462-3-luka.gejak@linux.dev>
In-Reply-To: <20260407162502.19462-1-luka.gejak@linux.dev>
References: <20260407162502.19462-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_FROM(0.00)[bounces-276083-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: F317D3B1DAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

In hsr_newlink(), a provided but invalid IFLA_HSR_INTERLINK attribute
was silently ignored if __dev_get_by_index() returned NULL. This leads
to incorrect RedBox topology creation without notifying the user.

Fix this by returning -EINVAL and an extack message when the
interlink attribute is present but cannot be resolved.

Assisted-by: Gemini:Gemini-3.1-flash
Reviewed-by: Felix Maurer <fmaurer@redhat.com>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_netlink.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index db0b0af7a692..f0ca23da3ab9 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -76,9 +76,14 @@ static int hsr_newlink(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	if (data[IFLA_HSR_INTERLINK])
+	if (data[IFLA_HSR_INTERLINK]) {
 		interlink = __dev_get_by_index(link_net,
 					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
+		if (!interlink) {
+			NL_SET_ERR_MSG_MOD(extack, "Interlink does not exist");
+			return -EINVAL;
+		}
+	}
 
 	if (interlink && interlink == link[0]) {
 		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave1 are the same");
-- 
2.53.0


