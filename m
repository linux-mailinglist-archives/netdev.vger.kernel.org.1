Return-Path: <netdev+bounces-286768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDrJHTAcAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:13:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B151426A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2289930F0BEE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF8466B4C;
	Mon, 11 May 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdokK86m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8937CD53;
	Mon, 11 May 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521766; cv=none; b=udfkNwI9tfVqZ1ilGo1pEVIah5b0lVlgWhm9U9UxUswgCaR1PU2D3a2G5hMNmymDevh5EDgTnJwB5zHWaJsCm2IiUEOzczlxC7nGd8oiFeHa7WyVZ/GwHzaqK5CVXT1mJeYqLv3yj7CIPJsLNuLrDsxbAfPbQ8NvojW3M0DC3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521766; c=relaxed/simple;
	bh=ixiwMLnwDJsrP9KY8lA7bsLN59sY6wvx0qCk2K9Ln6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HunLzc15L1n6Ig+YDGNV91NsNjZZA+q271IwSVwJg5ZNgVASGpDA5iHD2XmDqgmK5eQLtdXvcHJUP7+4hj8cpTaWcR/WhYwss8TMldyShq3DLcQHltx/lyu8ATQ2pFU1Ihfr+mXlW9As/2MgGgG+3FqBQ1syjCByGf+71Gr4F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdokK86m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7DCC2BCB0;
	Mon, 11 May 2026 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521766;
	bh=ixiwMLnwDJsrP9KY8lA7bsLN59sY6wvx0qCk2K9Ln6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=hdokK86mWO2F/4jzCt4fZaJrpBHw4GlOj21V0fbVHF1qBOmunePgirLU8IpjV4bpq
	 gFN0VO4wUwwHFeGaXej9DJbdOUq8XK8d5HtnOcSKds/W2yK8p8ySv6OE0IE5QtrXsi
	 FX193lWayNeuXmpJlN0hWutKmjOSIszrMsPd1LPFF0JFA9TloHPzx3WmnyZviJIjdf
	 70vFTsB1CncIWdJSnwfdM611f08o5FM3p159747I/Ac9fxJb/yEyqMB4f8sj7J/E1q
	 Q1GTATbFspH9evK0CieYQ0WlXbzPxhoNpctsvl1gQ5vinMvPoaH1E9XCQSKnZN3rYt
	 R4XNXLdmuIpnA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sd@queasysnail.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/4] net: tls: net: tls: fix a few random bugs
Date: Mon, 11 May 2026 10:49:16 -0700
Message-ID: <20260511174920.433155-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 152B151426A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,queasysnail.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286768-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fix a few random bugs, from external reports and my local scan
with various AI tools. Mostly corner cases in code which I don't
think TLS maintainers would consider "battle tested".

v2:
 - patches 2 and 3 are new (Sashiko report)
 - patch 4 is rewritten to remove the code instead of fixing it
 - drop the selftests, they were a little too specific, more PoC
   triggers than selftests, and Sashiko kept nit picking
 - old patches 1 and 2 were already applied
 - old patch 3 is gone since it can't trigger today (I will send it
   to net-next)
v1: https://lore.kernel.org/20260429222944.2139041-1-kuba@kernel.org

Jakub Kicinski (4):
  net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg
    ring
  net: tls: prevent chain-after-chain in plain text SG
  net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf
    verdict
  net: tls: remove bad rollback and UAF on ENOSPC

 net/tls/tls_sw.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

-- 
2.54.0


