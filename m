Return-Path: <netdev+bounces-187119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A69AA50A8
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5597A3C8D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20800259C8D;
	Wed, 30 Apr 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVgF+5QM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mcPaFwYs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVgF+5QM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mcPaFwYs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17017C208
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027952; cv=none; b=tLnkRq5OaS6lNfm3njaPIlfT4nQe2uE/hSIM6UvIcQakatyjUkYCc2H37AGMFLowZeFIElSguLHzyLCwNg2jyKFWySosqCyJ+F8gmSelkZLTvAcICermvCo5oAakd7hck40nba1htPu+RTc0hQCiglwBW0Vj1nrSZ8C1dj1T/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027952; c=relaxed/simple;
	bh=rJR5I7ZGv2bI0kgfaY9XbuXJycU7KYXZnyb1tGTj8gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9C7GgA2Pj0NHVfGC39YF/acFhyWWB8i88iWy/NzX1GC2fn/39b53nsvb0uyaHlRPccn6GefqLnzrJfYxuyl+i1RjKHKHxZEXpUVa6DOeik6AY3D+9lSUW2RYXJmS/RPxqTpoHqrvqt7xGCG1se7YLDUXYSod/iveie/mhXJrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yVgF+5QM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mcPaFwYs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yVgF+5QM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mcPaFwYs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 979FE21962;
	Wed, 30 Apr 2025 15:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746027948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bCz+FpXULwSM6ut1VDAjt5z4jKj0VzKKYeqjwHlTBaw=;
	b=yVgF+5QMUh5QRdXsI4yMreUVngrk3Lf/8nsc6TN8uGAJA0Fov8ckwhT+adbRbc6wtlZZUd
	tI+fBkGPpL4fbxOP2orFrx/xCxWCT5YN0zH3Pkb2nOowdkCw9FOuG+VpCnqLEW6/00eFJb
	JzXXI3FFA+bCHhtzSfNse3yNsWX2M0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746027948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bCz+FpXULwSM6ut1VDAjt5z4jKj0VzKKYeqjwHlTBaw=;
	b=mcPaFwYsOeZT/dt2LiWXQJf9jUW4Xk0h+XOCV1UI3ZqV/eYDulvYLfX4reqV4sfP7ilsms
	xsix3fUUu1vbhDAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yVgF+5QM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mcPaFwYs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746027948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bCz+FpXULwSM6ut1VDAjt5z4jKj0VzKKYeqjwHlTBaw=;
	b=yVgF+5QMUh5QRdXsI4yMreUVngrk3Lf/8nsc6TN8uGAJA0Fov8ckwhT+adbRbc6wtlZZUd
	tI+fBkGPpL4fbxOP2orFrx/xCxWCT5YN0zH3Pkb2nOowdkCw9FOuG+VpCnqLEW6/00eFJb
	JzXXI3FFA+bCHhtzSfNse3yNsWX2M0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746027948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bCz+FpXULwSM6ut1VDAjt5z4jKj0VzKKYeqjwHlTBaw=;
	b=mcPaFwYsOeZT/dt2LiWXQJf9jUW4Xk0h+XOCV1UI3ZqV/eYDulvYLfX4reqV4sfP7ilsms
	xsix3fUUu1vbhDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1485139E7;
	Wed, 30 Apr 2025 15:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ny7xL6tFEmgfIgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 30 Apr 2025 15:45:47 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH] mptcp: Align mptcp_inet6_sk with other protocols
Date: Wed, 30 Apr 2025 16:45:41 +0100
Message-ID: <20250430154541.1038561-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 979FE21962
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Ever since commit f5f80e32de12 ("ipv6: remove hard coded limitation on
ipv6_pinfo") that protocols stopped using the old "obj_size -
sizeof(struct ipv6_pinfo)" way of grabbing ipv6_pinfo, that severely
restricted struct layout and caused fun, hard to see issues.

However, mptcp_inet6_sk wasn't fixed (unlike tcp_inet6_sk). Do so.
The non-cloned sockets already do the right thing using
ipv6_pinfo_offset + the generic IPv6 code.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 26ffa06c21e8..c4fd558307f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3142,9 +3142,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
 {
-	unsigned int offset = sizeof(struct mptcp6_sock) - sizeof(struct ipv6_pinfo);
+	struct mptcp6_sock *msk6 = container_of(mptcp_sk(sk), struct mptcp6_sock, msk);
 
-	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
+	return &msk6->np;
 }
 
 static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
-- 
2.49.0


