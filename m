Return-Path: <netdev+bounces-305902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ea1MLAWDTmrhOAIAu9opvQ
	(envelope-from <netdev+bounces-305902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:04:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56322728FE5
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:04:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=cMJVQgYK;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305902-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305902-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7670230099BC
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9ED44103F;
	Wed,  8 Jul 2026 16:55:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893C3B38B8;
	Wed,  8 Jul 2026 16:55:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529718; cv=none; b=rN3JCV4v29y554fr2dHyMD9AJaBVwiH4g3eMkJxovjfHwDjN5XtwxF2QTwGAsMLpQeHZ2gjzGXz9oq4Whio4sYccxr2cHIKBbNOcbAnHayLupXKr1uZUQ1J4OyHWfdEqSpEg/5yPXO/8IBdJkANRf7JwIdNPvm9sQ2DsW0E3eWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529718; c=relaxed/simple;
	bh=E597jrkyamse8scXKS+eJA6HFU7y85qrwCtLMoF2A+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K2sJL7GwjZU/RZCZEcK1eeO5r7/1F7ciiEMpUDrZucfvC+Rj6eHnPnxZN77G/7FRnLCROiv88z/qYxF1xQqwke4hoRUFnDu5CZHOWZUgIkNyMLXEtD4AazxhVoXqvIqut6SUvaXxaTvtB9+CV1UrUmooYzdYgTPf+idMR2Jv1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMJVQgYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7988AC2BCB3;
	Wed,  8 Jul 2026 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783529718;
	bh=E597jrkyamse8scXKS+eJA6HFU7y85qrwCtLMoF2A+E=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cMJVQgYKlFzajGolZcGKlXnxYn8BndZZNonH+JBdN+FbdIkEdrnFTcwTZm2oW9Me7
	 DuOL55xJaJIWWeorVXSCsFpzK4o3eVXRKKfXWyVn0r/mFfnF2oWg/pF3pzU6/L7nS6
	 MvtJmRNxSnEM6JI1Dds4A2e3izD7hRPGEdkCtdKugpP+PImE2oOQI1wtOPX8Pfgb6X
	 QucuhyWOyi/D9OpbH4MzMhPm1TM1AkvF+PLUdrIBCmisI+TQlsL9CgkxkzXeIg2HGF
	 h5Z2ZCSATaRrhneHXY+3ltAO/6zgK8M2CzngLiq21vmT1z8NCyYIi260msjBqSxRsQ
	 P8YvbYKOVU9uA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CE7C43458;
	Wed,  8 Jul 2026 16:55:18 +0000 (UTC)
From: Mattia Meleleo via B4 Relay <devnull+mattia.meleleo.coralogix.com@kernel.org>
Subject: [PATCH bpf v3 0/2] bpf, sockmap: Fix FIONREAD for sockets without
 a verdict program
Date: Wed, 08 Jul 2026 18:54:59 +0200
Message-Id: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0K6dgwUpNSV9zAuynQKNUpJiw2Gc
 HcBN8YYl3/y5r2JBfKWAjsmE/MUbbCuW0a+Sxi2qmsIrF424ykvU5EKMAvgSWnoHETy2uIAqjB
 VKYVCaSRbPntPxo6b9czq3rDL+xge9ZVwWH0r1towOP/c2jHb4L+ZmEEGSLJQgucHQXhC59XNN
 Xbco7tvlcg/PdVvD4cUuNSay7zkGYpvzzzPLyVrRqkZAQAA
X-Change-ID: 20260707-fionread-no-verdict-a4f8697ac9f9
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Mattia Meleleo <mattia.meleleo@coralogix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783529717; l=1347;
 i=mattia.meleleo@coralogix.com; s=20260707; h=from:subject:message-id;
 bh=E597jrkyamse8scXKS+eJA6HFU7y85qrwCtLMoF2A+E=;
 b=0iyEGHE6MMl1uTga9/nSgQVDD2IvFs7va7vLyFLAhTkzB1duqMtZhZW6OGN5Axe7MNJiR1OnJ
 zsBC2BRmcNSDURwUIft6fxR3Jo0AhDyQ40dZ4TIJLHIXbVtfLgppgAF
X-Developer-Key: i=mattia.meleleo@coralogix.com; a=ed25519;
 pk=cs1zLoe3YDm4bJ7bfbPaZH0lHnd871JyJLiSh2eEzLs=
X-Endpoint-Received: by B4 Relay for mattia.meleleo@coralogix.com/20260707
 with auth_id=857
X-Original-From: Mattia Meleleo <mattia.meleleo@coralogix.com>
Reply-To: mattia.meleleo@coralogix.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305902-lists,netdev=lfdr.de,mattia.meleleo.coralogix.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattia.meleleo@coralogix.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,etsalapatis.com,coralogix.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[mattia.meleleo@coralogix.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,coralogix.com:replyto,coralogix.com:mid,coralogix.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56322728FE5

Sockets added to a sockmap/sockhash with no stream/skb verdict program
attached answer FIONREAD with 0 even when unread data is pending in
sk_receive_queue. Fix tcp_bpf_ioctl() to account for the receive queue
in that case, and add a selftest.

Changes in v3:
- Remove unused sk_psock_msg_inq()
- Link to v2: https://patch.msgid.link/20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com

Changes in v2:
- Split the fix and the selftest into separate patches
- Use READ_ONCE() to read the verdict program pointers
- Link to v1: https://patch.msgid.link/20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com

Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
---
Mattia Meleleo (2):
      bpf, sockmap: Account for receive queue in FIONREAD without a verdict program
      selftests/bpf: Test FIONREAD on a sockmap socket without a verdict program

 include/linux/skmsg.h                              | 14 --------
 net/ipv4/tcp_bpf.c                                 | 17 +++++++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 ++++++++++++++++++++++
 3 files changed, 55 insertions(+), 15 deletions(-)
---
base-commit: d2c9a99135da931377240942d44f3dea104cedb8
change-id: 20260707-fionread-no-verdict-a4f8697ac9f9

Best regards,
--  
Mattia Meleleo <mattia.meleleo@coralogix.com>



