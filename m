Return-Path: <netdev+bounces-260183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL9bBha4nGkqKAQAu9opvQ
	(envelope-from <netdev+bounces-260183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:27:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81E17CE15
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1E333026314
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B03783A3;
	Mon, 23 Feb 2026 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJN2s+nb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94C37756D;
	Mon, 23 Feb 2026 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878420; cv=none; b=ogFyaWcGXaEw1dKFMabvySHe2vM0HSV2VyCd0G6YwpOkYyOof2m69q1/m1JpXJTaxhI8EchM1qYki2X6q9Zofh7DPyXFG9aSYRWq1VnfaCjk2ke4eQEq3y9wknpQYsdNxZV3ex+E9Sa4esbjFVPsYm0KqQBv4fjSZ61MTfZuW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878420; c=relaxed/simple;
	bh=fwYi93CGfjEa2OFp92jIVni+fxgRaiftwTNsMzjsdG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQdbI9PJvh2pH9nps8TPi+k34NvBJarB6WLUm5yXqf68EV+gTZDIVPZMGpoJJxS3b1qROEQCv19soebpl2o4yr+vpLYxDif0lLqs7X2F6mL9CQrs0maovWtqaBXXSwZuzbhkDmAxbKZb62F1B+Cdq1gjD/GxGcXuiLk5r1FElYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJN2s+nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1029DC19421;
	Mon, 23 Feb 2026 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771878419;
	bh=fwYi93CGfjEa2OFp92jIVni+fxgRaiftwTNsMzjsdG4=;
	h=From:To:Cc:Subject:Date:From;
	b=KJN2s+nb2pfhqR+MqED7Ng3Hn7iK07lJVFOZ4/fmxVYgiWmMmBOHd5vS8YxWaJDUt
	 kpASqaZ+Tg8ho13KbiB2QiTlBHoq7Lek7r43QpuQWO0cVVvb44+MQDsOi+X2v2nUhr
	 Ab5Zq3nni9xSxuDI2kBhFzJ8squy2XBCuoB9X20qHi2XJVikGC5t80NDhNiJQBOnAa
	 JL7tAStuhZ+7HjSZEpD/W3bCl7ajwDmyJQLFI1HXQGbP5VbZvZoxgZjZXX8J5UyEwH
	 gzlylcw8ENj/uUz6G8mCdIPlWPpI2dpRoMca87khlRty4mD61JOTw5NpjKsjwiAuZa
	 7MqOBvtQTPf0A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	petrm@nvidia.com,
	gal@nvidia.com,
	leitao@debian.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] selftests: net: py: improve bkg() error reporting
Date: Mon, 23 Feb 2026 12:26:30 -0800
Message-ID: <20260223202633.4126087-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-260183-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA81E17CE15
X-Rspamd-Action: no action

bkg() is a helper for running commands in the background.
When init or body of a with() block fails check if the bkg()
process already exited and report its status (including stdout/
/stderr). This significantly improves debugability.

Jakub Kicinski (3):
  selftests: net: py: avoid masking exceptions in bkg() failures
  selftests: net: py: use repr(cmd) for failure exceptions
  selftests: net: py: add cmd info for ksft_wait failure

 tools/testing/selftests/net/lib/py/utils.py | 44 +++++++++++++++------
 1 file changed, 31 insertions(+), 13 deletions(-)

-- 
2.53.0


