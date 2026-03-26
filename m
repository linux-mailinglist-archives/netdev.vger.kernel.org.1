Return-Path: <netdev+bounces-272126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEUKCd9axWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFE338305
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74B9930EC37C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412E40B6F6;
	Thu, 26 Mar 2026 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ov8t+wVB"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA9408230
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540071; cv=none; b=Wr/00JBFLxtGCSidsXdfm0JaWy/0JhlBI/P62HfHxRlt4Qwn6sF2GM3cmU94zgZjkrXQxmAUnx+hBV8cD3h0GfEiOuCFKDa4q4bP2I85tjKiKmDlBMK02Z6CCTP4YemFY+zhNmIP22S3/Y/GHe91RDZv8nPqLzCOF59nvztYMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540071; c=relaxed/simple;
	bh=VKCyhqMVXE+KSqjXVeG+3hvSNLI273PUuk32Xdv7S5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovy/tU+kXg3hI4hCY3tmLuPPJBO8AgxyAEV6CpTzow4XIyYUI8whURmQxMnjohiMnSWBkhJEXyp3Z0nApg1vEXQ5dfz66oeGIDYJCIq6uhtszlT66CIoni3y8FkfJk5pJZ8JkVXRRKGzMqyfE0Ckm3HuzlLyf+aycRpUyheE3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ov8t+wVB; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774540068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXNLfi3VDWQRurd0FK4vAiq2uw5ZAgnel28YQEol3sw=;
	b=Ov8t+wVBvvTlFIozN/P7qlTc+R44ggI+gmyiou7IkgaObdAWk/SGK6F8aXzGEYf8LMWNjP
	pNO7l/a3tgRCZm3AGJySOqAG9OQnmsqdbZQqCirmSG0q7wByr+qCC0tlkseieN+DatGpuU
	BXzoCks5DoaEJEqbaGILZfpt0LqSkes=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev
Subject: [PATCH net-next v2 4/4] net: hsr: reject unresolved interlink ifindex
Date: Thu, 26 Mar 2026 16:47:15 +0100
Message-ID: <20260326154715.38405-5-luka.gejak@linux.dev>
In-Reply-To: <20260326154715.38405-1-luka.gejak@linux.dev>
References: <20260326154715.38405-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272126-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 38BFE338305
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

In hsr_newlink(), a provided but invalid IFLA_HSR_INTERLINK attribute
was silently ignored if __dev_get_by_index() returned NULL. This leads
to incorrect RedBox topology creation without notifying the user.

Fix this by returning -EINVAL and an extack message when the
interlink attribute is present but cannot be resolved.

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


