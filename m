Return-Path: <netdev+bounces-173602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780AA59BE2
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81964188CF6A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517A230988;
	Mon, 10 Mar 2025 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OvKZBtkS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yuCVoSsu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OvKZBtkS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yuCVoSsu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022C2343C0
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625997; cv=none; b=hRA9GpP4WtJ08S6iZC2whX6ho932cSIHZcz5HO+ZNuYynXV20fBSsPlG/kr2CAgCKAkGi+MEq3dZTPRHHS98hgrhh+FwqV+QQGmrQsqzhZ/kEr3CTTV+PXwSDDBvmbcdim0Yp9izEDoaE/jmU6MmbjfyLO7o5gB+pjfIIzq2IEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625997; c=relaxed/simple;
	bh=BtxPDe8zkq/NBpYVlLij2a8ynqMMcpMY3Pfrlpgmqxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iquHDJfJ+kRtJEV1tzQd/qyusfUK2gH8Xignx6VW0HdQdU5BoWCEgY5IcI/rNuPfsaD4k54t5VpHzoZSySL8TP2FDaNpxhmhKdyfKDI2Jrgq78Gres3SdAIoyjE/WkVpP4M8t2w8eQ9os/dPuOdeymuFb3T37Fh7pTh7ffu7PxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OvKZBtkS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yuCVoSsu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OvKZBtkS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yuCVoSsu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C2B621162;
	Mon, 10 Mar 2025 16:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/15a4p4/MRhFHiV3UC/tU5arF9LRXK/RyuAoe1B54Zs=;
	b=OvKZBtkSVIuhal8NQF+trarWxwmgq6Wiw/cbDYY8tMMfjZud9/5ATVMMxueNOwlHZGMuUI
	M29AcdqxQMrs9/5VIGuPJbYtA2lUavwVe3kcYb96TTYhR2vFbh4AFrCSy8VhIxR4O2mevj
	n07uNHkaE1+cYHhDSzY6jEsRuSliWxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/15a4p4/MRhFHiV3UC/tU5arF9LRXK/RyuAoe1B54Zs=;
	b=yuCVoSsuVODwm2e/wNVO6b67HB9RlLPhbzlO3ATIFQBPElZ0sdOsDYG4LnVoHXS38M8rJP
	8Fjj6sLzzb6BZBAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/15a4p4/MRhFHiV3UC/tU5arF9LRXK/RyuAoe1B54Zs=;
	b=OvKZBtkSVIuhal8NQF+trarWxwmgq6Wiw/cbDYY8tMMfjZud9/5ATVMMxueNOwlHZGMuUI
	M29AcdqxQMrs9/5VIGuPJbYtA2lUavwVe3kcYb96TTYhR2vFbh4AFrCSy8VhIxR4O2mevj
	n07uNHkaE1+cYHhDSzY6jEsRuSliWxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/15a4p4/MRhFHiV3UC/tU5arF9LRXK/RyuAoe1B54Zs=;
	b=yuCVoSsuVODwm2e/wNVO6b67HB9RlLPhbzlO3ATIFQBPElZ0sdOsDYG4LnVoHXS38M8rJP
	8Fjj6sLzzb6BZBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CDC6139E7;
	Mon, 10 Mar 2025 16:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o8dHHYIaz2fCaAAAD6G6ig
	(envelope-from <nstange@suse.de>); Mon, 10 Mar 2025 16:59:46 +0000
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
Subject: [PATCH v1 4/4] ipv6: sr: continue initialization at ENOENT HMAC instantiation failures
Date: Mon, 10 Mar 2025 17:58:57 +0100
Message-ID: <20250310165857.3584612-5-nstange@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

As it currently stands, the IPv6 SR HMAC __init, and thus the IPv6
subsystem's __init, would fail to come up if any of the HMAC algo
instantiations failed.

This used to be fine, as they usually don't. However, that situation will
change, because NIST announced to sunset SHA1 by 2030, and then at latest
instantiations thereof through the cryptomgr will have to made to fail with
-ENOENT when booted in FIPS mode. Note that the sunset date has
implications on certificates' lifetimes for those issued today already, so
distributions might be eager to disable SHA1 in FIPS mode downstream
starting now.

Make seg6_hmac_init_algos() to ignore ENOENT HMAC algo instantiation
errors. Note that in this case, a failed algo will have its ->tfms == NULL,
and __hmac_get_algo() would filter such ones already.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 net/ipv6/seg6_hmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 85e90d8d8050..4a63ee4dbf7e 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -433,7 +433,7 @@ static int seg6_hmac_init_algos(void)
 	alg_count = ARRAY_SIZE(hmac_algos);
 	for (i = 0; i < alg_count; i++) {
 		ret = seg6_hmac_init_algo(&hmac_algos[i]);
-		if (ret)
+		if (ret && ret != -ENOENT)
 			goto error_out;
 	}
 
-- 
2.47.1


