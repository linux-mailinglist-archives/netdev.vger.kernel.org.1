Return-Path: <netdev+bounces-173598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716BEA59BD5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14867A4E29
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFFC22FF2B;
	Mon, 10 Mar 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JL4bxYcK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yHiSU9I3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JL4bxYcK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yHiSU9I3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9B22FE19
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625975; cv=none; b=naPHFi32iIwu7IaBOC+iAKyr9rfzhfjOcpnlu/nXzbn+C318T6YyuuHpRbIarm2BFtAXMaw5AL2jOAfS76Ysiw0QxTUlsWQsb8u/k8R7Pzjx0NInq8mKE46kO91KBNubO2kcodFL6i+xnbq6C8uO8qx269wUmf2m47ftGl5XXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625975; c=relaxed/simple;
	bh=2ZRgAMr5GbjGAJINXjiicJFz+bJe8w6EItjLFFSV8cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLIwFgq4MozXvXRctII8i29JUcCfcXHDL5MbfDXbejFLaAhktA1v15TKqZzfDoyByj3gxLgSIm/hBHQ/WTnfbJr14dcN9LwjDDq530FfnYxVLVBSVMToayTDFKUG/XCDBx462Wj2K0ZLvidIzQhi9LSUzhxSIBr2RkDj0w6qjhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JL4bxYcK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yHiSU9I3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JL4bxYcK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yHiSU9I3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A46F4210F4;
	Mon, 10 Mar 2025 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asvK7OjCQ+r/xjTTpNpI9ccqBfRl2LGvzZZGhZs/1uo=;
	b=JL4bxYcK1HLtZo7fn5cXYnIA4Ul5gi3whknobgy96rdzpmKpSaiTzr8jNCNKFUqoMYhTy4
	hJfLCIlm40/UKO9Fq+fqT3oj8ineJcB65b+1sYPpqubkpyI1PQRh1NmCPSozV18wRiOK6i
	U+/qVUaq1+IesV1e+FnN7pfaHgYX26o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asvK7OjCQ+r/xjTTpNpI9ccqBfRl2LGvzZZGhZs/1uo=;
	b=yHiSU9I3FlyQ/zKmfdhCgiA/13J8ZKOHpWXtG8loKAOvHUA+42W4SN/H0zq+qEnjHc3WnE
	QU2G4mOoddI9B8AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JL4bxYcK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yHiSU9I3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asvK7OjCQ+r/xjTTpNpI9ccqBfRl2LGvzZZGhZs/1uo=;
	b=JL4bxYcK1HLtZo7fn5cXYnIA4Ul5gi3whknobgy96rdzpmKpSaiTzr8jNCNKFUqoMYhTy4
	hJfLCIlm40/UKO9Fq+fqT3oj8ineJcB65b+1sYPpqubkpyI1PQRh1NmCPSozV18wRiOK6i
	U+/qVUaq1+IesV1e+FnN7pfaHgYX26o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asvK7OjCQ+r/xjTTpNpI9ccqBfRl2LGvzZZGhZs/1uo=;
	b=yHiSU9I3FlyQ/zKmfdhCgiA/13J8ZKOHpWXtG8loKAOvHUA+42W4SN/H0zq+qEnjHc3WnE
	QU2G4mOoddI9B8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94DAE139E7;
	Mon, 10 Mar 2025 16:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3msYI3Maz2eZaAAAD6G6ig
	(envelope-from <nstange@suse.de>); Mon, 10 Mar 2025 16:59:31 +0000
From: Nicolai Stange <nstange@suse.de>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [PATCH v1 1/4] ipv6: sr: reject unsupported SR HMAC algos with -ENOENT
Date: Mon, 10 Mar 2025 17:58:54 +0100
Message-ID: <20250310165857.3584612-2-nstange@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310165857.3584612-1-nstange@suse.de>
References: <20250310165857.3584612-1-nstange@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A46F4210F4
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The IPv6 SR HMAC implementation supports sha1 and sha256, but would
silently accept any other value configured for the ->alg_id -- it just
would fail to create such an HMAC then.

That's certainly fine, as users attempting to configure random ->alg_ids
don't deserve any better.

However, a subsequent patch will enable a scenario where the instantiation
of a supported HMAC algorithm may fail, namely with SHA1 when booted in
FIPS mode.

As such an instantiation failure would depend on the system configuration,
i.e. whether FIPS mode is enabled or not, it would be better to report a
proper error back at configuration time rather than to e.g. silently drop
packets during operation.

Make __hmac_get_algo() to filter algos with ->tfms == NULL, indicating
an instantiation failure. Note that this cannot happen yet at this very
moment, as the IPv6 SR HMAC __init code would have failed then. As said,
it's a scenario enabled only with a subsequent patch.

Make seg6_hmac_info_add() to return -ENOENT to the user in case
__hmac_get_algo() fails to find a matching algo.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 net/ipv6/seg6_hmac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index bbf5b84a70fc..77bdb41d3b82 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -108,7 +108,7 @@ static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
 	alg_count = ARRAY_SIZE(hmac_algos);
 	for (i = 0; i < alg_count; i++) {
 		algo = &hmac_algos[i];
-		if (algo->alg_id == alg_id)
+		if (algo->alg_id == alg_id && algo->tfms)
 			return algo;
 	}
 
@@ -293,8 +293,13 @@ EXPORT_SYMBOL(seg6_hmac_info_lookup);
 int seg6_hmac_info_add(struct net *net, u32 key, struct seg6_hmac_info *hinfo)
 {
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
+	struct seg6_hmac_algo *algo;
 	int err;
 
+	algo = __hmac_get_algo(hinfo->alg_id);
+	if (!algo || !algo->tfms)
+		return -ENOENT;
+
 	err = rhashtable_lookup_insert_fast(&sdata->hmac_infos, &hinfo->node,
 					    rht_params);
 
-- 
2.47.1


