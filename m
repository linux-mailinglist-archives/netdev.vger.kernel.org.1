Return-Path: <netdev+bounces-264546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zUZSCiPyqWnhIQEAu9opvQ
	(envelope-from <netdev+bounces-264546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:14:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A27AE2186F3
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F3E93022046
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2629341AB6;
	Thu,  5 Mar 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFulUc1q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D42F1FFC;
	Thu,  5 Mar 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745246; cv=none; b=FJI9X8RB/OByKAZ9X88p+W5z3xKwHPnGbR8suNyfCwNV4mATB4XhFTO10nmOqzMl9gnQ1Jymd1uNQxGV7ODeh8O4TAN9Z7J6cUM/2uZlVfKZJYDZCEEQecN1oWa0x9AMDziWppc+mrpfnolxyaHGbhjVuHzh+4ifVmoBFMIx+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745246; c=relaxed/simple;
	bh=sNzzSK7Tv4Zf+h+tnePYHBy64GXLa66ZaCoSTRTeFdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kuJtYewa5XetbSB+zEogJsItkS5pNJrTzIG26jZtAapmHl52q83whQ2kaxBcODZxPhjNC4UogpYyIWqDk4OQ0PAwUceipy2ckDfZzWNcF0ADTjS5VSvNg6/tpfeFeOKjgVrBPfy8heHsfA2cHO62CDOnLOJ7/NodyxatgTgCOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFulUc1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87097C116C6;
	Thu,  5 Mar 2026 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772745246;
	bh=sNzzSK7Tv4Zf+h+tnePYHBy64GXLa66ZaCoSTRTeFdc=;
	h=From:To:Cc:Subject:Date:From;
	b=EFulUc1qE8tN0qcWjIwOrjcUdKaBs/ULowooNkQbzTL2iSSuoXXXEt5CSykoFfRdd
	 aHqrdgOmlSDOIcekCNbysl7QHWBSo2LXVcCP1eFrLSUtSAdAYC7ht5TtxcuJW04EDK
	 uDvj5Vp3CohVPEYVkP2CoG7clPGblUJmiYIuP+OXbWfgCxTvSn5TTyk4OOwj+VAY0/
	 kaS+fcFqg1RuH7i31HrV3xM6xHMoX3vXiUpUW25sfMl+Z1a/H3DgiEjzXdI8RiJHBR
	 gPUpGR1Gm6cUvvkKvEW5YMmZw4BynLQd0aerb7hWQlKzNmHcrhJ3rRf33DIQx32l6H
	 m/F9VvkeKL+Qg==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: <netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/6] TLS read_sock performance scalability
Date: Thu,  5 Mar 2026 16:13:56 -0500
Message-ID: <20260305211402.39408-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A27AE2186F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-264546-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
NVMe/TCP) to coalesce on the use of read_sock. When I suggested
this to Hannes, he reported a number of nagging performance
scalability issues with read_sock. This series is an attempt to
run these issues down and get them fixed before we convert the
above sock_recvmsg consumers over to read_sock.

Each patch's commit message speaks for itself, so I won't repeat
that content here.

Series is based on commit ab99e1167293 ("Merge branch
'net-ethtool-track-tx-pause-storm'") in the net-next tree.

---

Chuck Lever (6):
  tls: Fix dangling skb pointer in tls_sw_read_sock()
  tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
  tls: Suppress spurious saved_data_ready during read_sock
  tls: Flush backlog before tls_rx_rec_wait in read_sock
  tls: Restructure tls_sw_read_sock() into submit/deliver phases
  tls: Enable batch async decryption in read_sock

 net/tls/tls.h      |   2 +
 net/tls/tls_strp.c |  36 ++++++++++-
 net/tls/tls_sw.c   | 157 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 147 insertions(+), 48 deletions(-)

-- 
2.53.0


