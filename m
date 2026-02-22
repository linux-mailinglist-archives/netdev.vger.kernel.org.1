Return-Path: <netdev+bounces-259874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DfSLxP4mmmqogMAu9opvQ
	(envelope-from <netdev+bounces-259874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 13:35:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B8A16F0DA
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 481CF300C345
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18451227BB5;
	Sun, 22 Feb 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGNiuGST"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D638F9C;
	Sun, 22 Feb 2026 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771763719; cv=none; b=lMStdfN8YDztbWWXeCW3DHzmZwpEAGgxjmc7LvKfEQL8NejPE7CHhphKS8IqQDWSYjJrqa8wD5t0Y2N9ERnS1KAndr26zNh7ix2DW7ZkFxQgjb1uJ23nds7v3jqxGnC1N8Rm6pUqEspYJpLsoZKvrp62pT2kv5TvAxBzfrQUmrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771763719; c=relaxed/simple;
	bh=Ad3HcaJiaO0xhdi6BjPXye6filJoTMtnWzaj36dECf4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VhltvCbFDcYVCLs2K/NFKt1ue7KKibWnyJE4FWQ0GxcmLSFb4DJQzDuUmjnYqBLer58W+6StEwrPMVFz/nWy9bDCMadubqXJQ3LL+8wXEoZn5LV+Qz/UEhPkoybJCJKzmbNFjyrPWonggvE6CFWqlhAzyMMVIZi2tu4+9PX0+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGNiuGST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7643BC116D0;
	Sun, 22 Feb 2026 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771763719;
	bh=Ad3HcaJiaO0xhdi6BjPXye6filJoTMtnWzaj36dECf4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BGNiuGSTA1hfBqXw+BWSDd0nb5DvJwtyfISIm3AUT82mH/d27ffZwADfWg4GWzAih
	 vK3D9+WVyBuwf2rf0YuzrS36E5HRXboO5/is+qFZXTeZCxvqHzc103TELM7+m7txKD
	 Icg9ZwgfVUaU2noVu5z4t+5PtKchYW/2J2nR4i2SepxliyBCGNbpme0VfsZn/gtKs0
	 7ueYwJfWQjX9XVsiiREpNM84eE2F9wrhppTdEdVrbsm4h6vPG5iCQl1ZrlMMZrAkzL
	 KcKhHmtQ7/P49R0qiIiF1MeGsyP5BsZi+/qUTBoV1CeMDyk7yVM5piyr8RCsIragro
	 QXwghH6xtlhsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C83AC61DFD;
	Sun, 22 Feb 2026 12:35:19 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Subject: [PATCH net 0/2] tcp: re-enable acceptance of FIN packets when RWIN
 is 0
Date: Sun, 22 Feb 2026 13:35:07 +0100
Message-Id: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TnANCvpKhJRutZctNCoS/550H
 JiZBJECU4S+ShDo4si7FMC6ArdNspJiXxiMNq02BtXCj30p7PYWbxcW5XGeEJ1vZt1ByY5Axfm
 XAwidMOb8AWG+m55nAAAA
X-Change-ID: 20260221-fix_zero_wnd_fin-d1ba11cd3b07
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771763718; l=767;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=Ad3HcaJiaO0xhdi6BjPXye6filJoTMtnWzaj36dECf4=;
 b=a4wxL2o8dJnNrLbg12N86bR+YJDyDe+zCosqzLSxm28QtxkJzW+Bo1FrcyO6/PiwAXsHp0+OL
 6gYnbe9lCz7C8nbCQSPVf/kBkJ3JZtcsvrGfYFyj1xdBx4zcmeekK1T
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259874-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35B8A16F0DA
X-Rspamd-Action: no action

Hi,

this series restores the ability to accept in‑sequence FIN packets 
even when the advertised receive window is zero, and adds a 
packetdrill test to guard the behavior.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
Simon Baatz (2):
      tcp: re-enable acceptance of FIN packets when RWIN is 0
      selftests/net: packetdrill: Verify acceptance of FIN packets when RWIN is 0

 net/ipv4/tcp_input.c                               |  7 +++++-
 .../net/packetdrill/tcp_rcv_zero_wnd_fin.pkt       | 27 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
---
base-commit: d4f687fbbce45b5e88438e89b5e26c0c15847992
change-id: 20260221-fix_zero_wnd_fin-d1ba11cd3b07

Best regards,
-- 
Simon Baatz <gmbnomis@gmail.com>



