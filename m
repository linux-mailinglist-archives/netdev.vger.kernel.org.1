Return-Path: <netdev+bounces-200558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07908AE618B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB90A17BC9A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846DC28136E;
	Tue, 24 Jun 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OWiHZi6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F72222CC;
	Tue, 24 Jun 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758868; cv=none; b=cEiwos+yau4iXokweKnYGF89xlmtXU1ZHnn30Zk/zkvmS0V0Kf9YvqqQdIkiaiDmshokzdG6QMQ2KuG1p5O3mSu7a0n8MzTZ29rLVly/J48UeOLFg+BWv2XsgtJs44lZR4oPMoCjIX1hikzMQNRO30hCyj8nME5iSA13re3i+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758868; c=relaxed/simple;
	bh=EBCJmKKlcL53r2vnhfAzxVBoMGSYOIFwr1YN1MhJRjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SbSRjvFyD3BKHJrzm6DPpBEKKpUJYI0kHQ/4a+4Hws92HxDWcBTBJRux+ypmUkII9JSveulLy5inRVmzvQ6m8bJKZwoDBOSEXBHP3hxsElINmXGrnEzisPJPhWrrMU5vJjSF6PE/uqdH721SEzBqfV8xXfs+dR11EE6loYRp8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OWiHZi6Y; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uU0M3-00AvYO-Ih; Tue, 24 Jun 2025 11:54:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=kf2/hDBT9aaBOd6ouZwDBEBoZykD658FhkvJs68qzvg=; b=OWiHZi6YqeS50b26RTNEq6EbPo
	+gLx8hTwOD7SX8Nx0Dc63pzD7ADMao/0Fe56nuJV2wWA25VLWItHaIgc/YVDqu6NAm6deX0uv/bqQ
	jX0obP4gDxcwrJy+c+dISKcXBtr68kmo2E5wuqXaKcthJcRnmnNNBbU3XACSN5wuQSQZVvrXLibH6
	q5MhrQ8oBXlnoh5Amy//3PvjPIUg1kyPKpFLJZyYL4tpMZ6XovXHfaSDreHuTpr7yVyMpPgWpRPLB
	IvZIX+wqQpQk5xB9mHs9LllhygTXcY2XBrXXBS/WJjX19LOdUV1muSSUnSti91uHRXHyAKEom2NEi
	wZ58VouA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uU0M2-0005uR-JA; Tue, 24 Jun 2025 11:54:14 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uU0Ll-00FYQf-9n; Tue, 24 Jun 2025 11:53:57 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 24 Jun 2025 11:53:51 +0200
Subject: [PATCH net-next 4/7] af_unix: Drop
 unix_stream_read_state::splice_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-splice-drop-unused-v1-4-cf641a676d04@rbox.co>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
In-Reply-To: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Since skb_splice_bits() does not accept the @flags argument anymore,
struct's field became unused. Remove it.

No functional change indented.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/af_unix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 235319a045a1238cf27791dfefa9e61b4a593551..1e3a4db1a96a57c84c199e30c164f66409b04be4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2674,7 +2674,6 @@ struct unix_stream_read_state {
 	struct pipe_inode_info *pipe;
 	size_t size;
 	int flags;
-	unsigned int splice_flags;
 };
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -3082,7 +3081,6 @@ static ssize_t unix_stream_splice_read(struct socket *sock,  loff_t *ppos,
 		.socket = sock,
 		.pipe = pipe,
 		.size = size,
-		.splice_flags = flags,
 	};
 
 	if (unlikely(*ppos))

-- 
2.49.0


