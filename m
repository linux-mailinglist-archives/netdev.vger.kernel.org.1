Return-Path: <netdev+bounces-256432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEzYGotCgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:46:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A45DDCBE
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A3493105EDC
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2D3D1CC9;
	Tue,  3 Feb 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvA1KdX7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114EA36AB59;
	Tue,  3 Feb 2026 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144166; cv=none; b=SuT2P/rtumReYtCHfVAZto4uqCZYOVqricinJci8JUnDzaBTYgBS8u7STN8otJ3aq5tOtm9gaXJYUEw0kIO46mOeqmFBoOqMtwglt6PLEUwfIK1br7H/4Z3roXlVDXrlydiqFPIkbXUGJswCYi1JJ/3iIPfP7rCeTq1YdhK01p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144166; c=relaxed/simple;
	bh=lX25X57JSWrgUhD/y0KpRAfgKf2YeiuLHVo/Q4avhcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhT+2flfTVPeUcTtU3suRRio/iQ2hnhmnLpYbusA0hmyu9siO1ZVAMEbEWa74/02UVKYtQd6LrNuBW+sWQst89dJZ4EjX+qT9VjjOnYJ97LDrSjyKQzUvVlGQBlGlQeo4uQNkCAAo1FRIo6yCCnWSyjULFNxjnFhQoiEC6m27go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvA1KdX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE86C19421;
	Tue,  3 Feb 2026 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144165;
	bh=lX25X57JSWrgUhD/y0KpRAfgKf2YeiuLHVo/Q4avhcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PvA1KdX7nZKBIBmzc6oD3zoyrvEbZWOJDEGxYz3YjcUb9iAaDYBnqiCqKvZYWGR3a
	 4oEbr5cogJxsWLRO1vCEFdhVS5obp9sGhlcMLkdEHiYh9Z6EbItRw23Hqd58Ex13yw
	 MyEN0VGOiA9zpmb2yCjoPZ2ecgC89FnIk3cKZN9ye+zjIlYYLIE/0gnYkkGrEc0Msz
	 aiXHldz5rc5hs3zNPVLzB0I1u3AkLKdZB4Siz1KJm9ynUs/AAr9eFQMnxG2di06Gq2
	 SreNbqoh+If/D4XrnfR7kyQRqq+x8lhE6uE5s1ComvAZIq8uOAjOKfdcEYDIxi+PbR
	 OctRY4eXNvDJw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:23 +0100
Subject: [PATCH net-next 07/15] mptcp: allow overridden write_space to be
 invoked
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-7-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ksO5WD3m/Qenl//M70QBvjWcIAqOU82b4UY54WOMios=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHLu0osPVJFIqTQvzvP58Ejf9fs3xmuy5adlBWzSnM
 Bkp3Z3aUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJGNBxgZjm5xKG/8wfTcXDPr
 5rNs76PrfRXX2kpufVcrv5b52Qz/eEaGjoW6zJXizIr/BZnXvCm6+PLEvlWrFx+5z/Hbm712esJ
 bXgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256432-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: D8A45DDCBE
X-Rspamd-Action: no action

From: Geliang Tang <tanggeliang@kylinos.cn>

Future extensions with psock will override their own sk->sk_write_space
callback. This patch ensures that the overridden sk_write_space can be
invoked by MPTCP.

INDIRECT_CALL is used to keep the default path optimised.

This patch is shared early to ease discussions around future RFC and
avoid confusions with this "fix" that is needed for different future
extensions.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f4bfe91ca7f9..0bd1ee860316 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -975,7 +975,7 @@ static inline void mptcp_write_space(struct sock *sk)
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
 	if (mptcp_stream_memory_free(sk, 1))
-		sk_stream_write_space(sk);
+		INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)

-- 
2.51.0


