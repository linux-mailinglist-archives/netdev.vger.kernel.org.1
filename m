Return-Path: <netdev+bounces-266830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG54B1obsmnjIgAAu9opvQ
	(envelope-from <netdev+bounces-266830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:48:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC6B26BFFF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7654F3007884
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD173750DA;
	Thu, 12 Mar 2026 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBxdjXMU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F432E692;
	Thu, 12 Mar 2026 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280087; cv=none; b=Urob0Unt5y+IicIW3K0Hpp7Ca/RKJyK4SLAAmOytr/n0zQ23f9Ldm6+Lb5e3SiWUVvNvY0Q5bToUUoHRiydEifAV6xDyo6mjP9UCUImN76XXqmpa7+qPJw1TjOdpREe0CeRgbAojfoRC7R/UrYqPp9NowkdjOPD70/kkf39C+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280087; c=relaxed/simple;
	bh=g3zU/1nV6yV8qSKK59IKoogKsS8ghmFNA+vbOPXnYy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8NIAEKVmnJ4yEySYuDkNLtQDgl4sOuyikFhxoGT11Buprl5JB36JmghA0mIzNyQCvrnWHFTUTsBZsjLXnHiTAmWWj707DHSFbj6eDixI5gJ7/3NJ2wO9nJggm842W1P6t1FFXoHGEkvPkeUqFBSGRD+X+R/jWStGWRZMRpmy9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBxdjXMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B11C4CEF7;
	Thu, 12 Mar 2026 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280087;
	bh=g3zU/1nV6yV8qSKK59IKoogKsS8ghmFNA+vbOPXnYy8=;
	h=From:To:Cc:Subject:Date:From;
	b=WBxdjXMUnZLCi1L30HMfT/NqjNuesWfU0csvFq4pLX6tYzEl/LjWwpuU7ajVsp45s
	 TZ1WyppDHNB/tgBoZLYIVy7Uwa4cvwYOauOYnhbhg+3wLeCOApALV9/tMLiU7nULXG
	 UhJzoc3yeXsMxG22kczBr9IkCBTvMpw3kBWULBqR6lb+dk5xU0P9+tbnVfq/Osgj6S
	 8MjHqE3M9goWp3OqyivcvauTOFtGnc5DK+1tabENYfPiCZ8cYnfW2OamkSwAfpSybM
	 YD2ES8rBjhDQ1LdtBIdRNx+JxNm4FpBR9cZ4O/ie1OJs4oPjZgjndQYOIpJyhIYfEB
	 RZ97zMJnqW29g==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/8] TLS read_sock performance scalability
Date: Wed, 11 Mar 2026 21:47:56 -0400
Message-ID: <20260312014804.5083-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-266830-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 7DC6B26BFFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
NVMe/TCP) to coalesce on the use of read_sock. When I suggested
this to Hannes, he reported a number of nagging performance
scalability issues with read_sock. This series is an attempt to run
these issues down and get them fixed before we convert the above
sock_recvmsg consumers over to read_sock.

While I assemble performance data, let's nail down the preferred
code structure.

Base commit: 05e059510edf ("Merge branch 'eth-fbnic-add-fbnic-self-tests'")
---

Changes since v2:
- Fix short read self tests

Changes since v1:
- Add C11 reference
- Extend data_ready reduction to recvmsg and splice
- Restructure read_sock and recvmsg using shared helpers

Chuck Lever (8):
  tls: Factor tls_decrypt_async_drain() from recvmsg
  tls: Factor tls_rx_decrypt_record() helper
  tls: Fix dangling skb pointer in tls_sw_read_sock()
  tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
  tls: Suppress spurious saved_data_ready on all receive paths
  tls: Flush backlog before tls_rx_rec_wait in read_sock
  tls: Restructure tls_sw_read_sock() into submit/deliver phases
  tls: Enable batch async decryption in read_sock

 net/tls/tls.h      |   3 +-
 net/tls/tls_strp.c |  34 ++++++--
 net/tls/tls_sw.c   | 213 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 184 insertions(+), 66 deletions(-)

-- 
2.52.0


