Return-Path: <netdev+bounces-296680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ESjGB+T8JmoPpQIAu9opvQ
	(envelope-from <netdev+bounces-296680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:33:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A22B659477
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:33:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZGuhAUEW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296680-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85E3E3009543
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62CC31D371;
	Mon,  8 Jun 2026 17:33:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050934EEF7
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 17:33:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939996; cv=none; b=fjaPVGBquYmi0dcrwYueLDys1VdoXqC9lS/dQps3GYfOxt8XZueCXBSP2bhbpKnYykwbzFzIEahuYKRJ9hpwh6MmfKEv9zo69e3MAask3eSjqXfJuPwMyqTIIO0885/6xreTDGHBMQi+oIv5NEFqc8DRl0oiyDW7FCSLQ6WjxYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939996; c=relaxed/simple;
	bh=t6PbaQFaFaNPFScMXvcyC6deTSlUOgGj+lsEl6bI3BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NG3eS8UBTehats2Aa4qF4rJ3TvHnb1dancTtDMQ8D+Yv8kLdHmMfIGRMCMlKlZEHzKUc3yhVFuRmrhvW/ilzptRfUvNfg577i/LMBYKGREEO+OdKhcDxorcOegAw0RziNaTNJBJL1IkX7L46W0AOVW0ZJX0stv2J7g4GqyHhstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGuhAUEW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F49D1F00893;
	Mon,  8 Jun 2026 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939995;
	bh=o3U6GxMxZtA2Ttj48bu/+Feg1kdvNB6iFhl63WTlH6g=;
	h=From:To:Cc:Subject:Date;
	b=ZGuhAUEWeZX3ifWyZuT19b3HnOM78baZVH6FHA7tT3HcvohMJ2VB1AXhxqHiGR28i
	 f8J/eC77os4kNY3WWOoMqKMT9PBsbuZ3hXGmC7h3EFO3xEPJQhhasW2H8nTLOQg1jD
	 YQqdHo5yvtm7iXSXQn/rYv7c0yrosFUBrMwFxzHV83AvDMUHbgMqk4ZO/YNBl7RSDt
	 /mgla2Av0o/G2AagIzN5hQn0fXoGLy6Vn4dcy6v1el0DDzbvmQQ0H9pL/6Lo0yjo/j
	 oJqzzdvSQe8S3ihgInG5690qM/36yYA1FPN1u99Uf/SBZI/gc3zsia4v70l163OWK5
	 8/i31uiTn7eEA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] selftests: drv-net: so_txtime: trivial fixes
Date: Mon,  8 Jun 2026 10:33:03 -0700
Message-ID: <20260608173305.372987-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-296680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:kuba@kernel.org,m:andrew@lunn.ch,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A22B659477

I noticed that so_txtime is only passing on NIPA setups which are
looped within a single host. The cross-machine cases just flat out
fail. The initial bug is obvious - the test does not deploy the binary.
But even with that I think more work would be needed to sync the
time / adjust the expectations for a dual-machine test.

Feel free to nack / take over, this series is admittedly achieving
very little in practice. The test will still not be usable on dual-host.

Jakub Kicinski (2):
  selftests: drv-net: so_txtime: remember to deploy the binaries
  selftests: drv-net: so_txtime: check IP versions

 tools/testing/selftests/drivers/net/so_txtime.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.54.0


