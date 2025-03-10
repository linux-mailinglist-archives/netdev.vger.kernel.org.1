Return-Path: <netdev+bounces-173597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D30A59BD3
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5891888CEC
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5222FE19;
	Mon, 10 Mar 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t4EUzl9O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dMEFL4m7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t4EUzl9O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dMEFL4m7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E522FAE2
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625965; cv=none; b=f78whUzfIA1ejgxN6oGb88pq8Aiyn2Yu6V5yr7zxYjtsn77zmjyAYlAMyY7I7zdgZ1CXJyNSG1WYE/rCCvF5DHQn0w9fq+pFqHKSBCPoUDV1f3N+zzoqPxrpfDhaKmNqC3pscEPFbhZxO/b7z1XQMScA5QqD6BdRtgheuXOwW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625965; c=relaxed/simple;
	bh=pZqHfxusW9YbpT/f7NbmV/F2BFGrD+RjQYL8YSvVb7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkyqiWERs95PuBK5lcMDllKvPfYZ5qsiFCu5xDBkLjj6i6Rn6kHLH2XWMKFU0eQF2O/nm0mAPhhY+pgI34ANYybBbFqRWmRqBVRmWyEff0m4uXhxlHLTg7scakaHbdgGOW/JGM3PVfZ+21IKiqBCwrtvCzvwXGnUQ0iaUiLVlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t4EUzl9O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dMEFL4m7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t4EUzl9O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dMEFL4m7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD5AB1F38A;
	Mon, 10 Mar 2025 16:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4gwOeEAS/mzqvizsmIVwJTAAoCAzkWvcvv8rN1q1VW8=;
	b=t4EUzl9OSdjFHIXvPqXSXiF72qL9C5al8r5EWPMcBQrN2vuRucDXfYexVvZuv2xScUED21
	3UvvcykhL+2Ubdqoj79g47fdM3MtTLrpu5RmK+BigN9950xk39etFN1VAsSSj2GgRk0IFh
	YurUQIPT9v46vJ9ReUd9jirDzDu+SeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4gwOeEAS/mzqvizsmIVwJTAAoCAzkWvcvv8rN1q1VW8=;
	b=dMEFL4m7nBr4GKKVA8fyw9l34G7d/TyiP4W2yeltWy2ONq7Neb1MTUN+6rOyZCUa2URnjQ
	rLhrPb15yVJp+jAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t4EUzl9O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dMEFL4m7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741625961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4gwOeEAS/mzqvizsmIVwJTAAoCAzkWvcvv8rN1q1VW8=;
	b=t4EUzl9OSdjFHIXvPqXSXiF72qL9C5al8r5EWPMcBQrN2vuRucDXfYexVvZuv2xScUED21
	3UvvcykhL+2Ubdqoj79g47fdM3MtTLrpu5RmK+BigN9950xk39etFN1VAsSSj2GgRk0IFh
	YurUQIPT9v46vJ9ReUd9jirDzDu+SeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741625961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4gwOeEAS/mzqvizsmIVwJTAAoCAzkWvcvv8rN1q1VW8=;
	b=dMEFL4m7nBr4GKKVA8fyw9l34G7d/TyiP4W2yeltWy2ONq7Neb1MTUN+6rOyZCUa2URnjQ
	rLhrPb15yVJp+jAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B930139E7;
	Mon, 10 Mar 2025 16:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NTfaJGkaz2eQaAAAD6G6ig
	(envelope-from <nstange@suse.de>); Mon, 10 Mar 2025 16:59:21 +0000
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
Subject: [PATCH v1 0/4] ipv6: sr: make SR HMAC __init continue on missing algos
Date: Mon, 10 Mar 2025 17:58:53 +0100
Message-ID: <20250310165857.3584612-1-nstange@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD5AB1F38A
X-Spam-Level: 
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi all,

this series prepares for prohibiting any SHA1 usage when booting in FIPS
mode -- SHA1 will be sunset by NIST by the end of 2030 ([1]) and then at
latest, attempts to instantiate it will have to be made to fail with
-ENOENT (in FIPS mode only). Note that distros might want to make this
move downstream today already.

The problem is that the SR HMAC __init, and thus the IPv6 subsys as a whole,
fails to come up upon encountering such an error.

This series makes it to continue upon ENOENTs from the hmac instantiations.

Thanks!

Nicolai

[1] https://www.nist.gov/news-events/news/2022/12/nist-retires-sha-1-cryptographic-algorithm

Nicolai Stange (4):
  ipv6: sr: reject unsupported SR HMAC algos with -ENOENT
  ipv6: sr: factor seg6_hmac_exit()'s per-algo code into separate
    function
  ipv6: sr: factor seg6_hmac_init_algo()'s per-algo code into separate
    function
  ipv6: sr: continue initialization at ENOENT HMAC instantiation
    failures

 net/ipv6/seg6_hmac.c | 141 +++++++++++++++++++++++++------------------
 1 file changed, 81 insertions(+), 60 deletions(-)

-- 
2.47.1


