Return-Path: <netdev+bounces-280403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K7DCKXB6Gm9PwIAu9opvQ
	(envelope-from <netdev+bounces-280403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:40:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9795446122
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21CD1306C376
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B73D3D1B;
	Wed, 22 Apr 2026 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GGrf3Nzr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155583D34B6
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861184; cv=none; b=YRG54QvK7poc/+LF3HWTnMjeXiBzU9UxBWIm571K2kCZsTMXFZHxwMafSRwhrVwSCbaoDJoWuLDW4kTRHsVEnuBPBoWyrPpVJFGey+c5kHSu7FtziNIvBc3jVEuIpd7NXYHmUh5oql5ii5orVCMpOrLgxF9dkPRgAS1EEoWyjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861184; c=relaxed/simple;
	bh=QTh9wIlAamYhNlvoCiK1+h7aKAQjQuM99xpPXTv1Kq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+fIbKUa16rX7jLDVHcERigg+b+ZGx7HK9FS7D24E/ME4QSqtp9LeccMzW3tuVhKCqcr5D8mBeW09O/SWy9P21Ggp+0Kjn113MartQMNMkf+z8Aln4wD3sFd8U+VjWJEf8UwKhqHDkdTeP//2tgjKmBjkO5iz1h+v5+PuMxsN5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GGrf3Nzr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso60634425e9.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776861181; x=1777465981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pKIN0Wfe+CN+De0VB8LYO0G8+rdIAPkkf5uWjG4wwcs=;
        b=GGrf3NzrRfc+PmyPIDgbI9e0/JlH555uASFSdcniUfohcoPXfaxd+m0L/fLjQCRJ8n
         XlNkw6B1QyDIOR6N/c7FksVDYREjiJW+1+zC4IbDy3Jj8RBYeXlObwZQ2oUnfjk0r8H0
         aAK90EJ0AOnvslz6Zo+moAmgq83uv2gtd1zi0GOZ4z8mhYyp9/rfaxbkTMULs/4vc1bQ
         L+wu+klotxht8B5Sc61j8IZgZ+zsEo7uGZXY+E84bwpipIfSECCV9ECwqBs8RdrTK6yA
         Ce/aFaDGmG7iQSyZBmqtOwnztmdScDuQV15MDlfp5b99Ls0egxn+bP7fLe2QeqFEopLc
         WbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776861181; x=1777465981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKIN0Wfe+CN+De0VB8LYO0G8+rdIAPkkf5uWjG4wwcs=;
        b=giGGqe97QqTBcwHP/e4IJ+OrDzaM7FxbwovscLz876ITghTPLY/IZqp+D8HYuxSiY5
         4Wo0DSyOolfaZFKtUwlZh4U7TQAxYmlhTl4qz2yaVyMu+oSrnEgpilMw9BsVqfcSknJi
         9wtvhYfydgLkmckWgU0RNjtmjBppQSksHW2CyUoy5C/cYluFSYB4gQJTvVwGqffQOKzN
         tdNt4DVyaWhvkbGItGbk6f5Sz1dyxvnYOTC30Qj3bxh3Ro8f2QySSBurs+DJCn5TUNKJ
         EnF8981AocL3WkD3q9aaMsAIai799v3Z7HQL3Ca2tTf90NV8GQJQoQNBoGH2Dxx1/WJ+
         ncNg==
X-Gm-Message-State: AOJu0YzWDvFxrNhcQ6Mfwug5mlQX/kk7rejnxow+jKWBcnTrLZ3T0nhH
	PGMkpR8+wz1d4XccMSZyVVCdNpUn4owFcqBIRDARXnap4EA8hj70k8VUscXsFxfnNjCn+9ofnbA
	SFU1wim4jGagaNyJ6Zh4gsiZtW+RStf5dfAKvI8OW4j8enma0FV+OgBdEdMj0uP6e
X-Gm-Gg: AeBDievTXayqmi3jwZTDG1Sot7k6iGyomZiIlZlPve3TYwHJwqEoohL+Mp06ArCmq5C
	FV+vngNTQHlNNQ6LW8+y+lMMnL5shkYDxlh4Z/aOT65uzACGVA8botrJabHYTutPvL1yY7fZrt6
	bwYsjz+SnUDxeu0irEMqq4hegOCiXEeXrOf6AVcE/JtC9JCSAb6Gz4rTMJt8AQy6cqd87EI7/xb
	9kbAFlO0YuE4glpSk+Tug7LwLwUmspuObApuqyL8ka6jaqH/85YRlNYIOrhVvWgPVuKnj43eYeJ
	vc3q7wCvnq7JxtSSU0HgylCLUGga59GZmO8KvBXAq1JcQf9v2KcGnH1NHs+JwJ/mzTKLzYeXO6N
	PSQSvg9r/yyopXAavmKqlSXLQu4zMT2ibtAQHuiRG7qi9PQlr456/6uMU6v3trI1ybziPgtv2tz
	sUFD+e0MWDEE81gdDTS/JCmy7qvOYT/qzvQSX5ZFbHI+GkacE=
X-Received: by 2002:a05:600c:12d4:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-4891f049763mr107158945e9.2.1776861180984;
        Wed, 22 Apr 2026 05:33:00 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9c05:1850:4a76:783e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm139657135e9.3.2026.04.22.05.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:33:00 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 0/1] pull request: fixes for ovpn 2026-04-22
Date: Wed, 22 Apr 2026 14:32:41 +0200
Message-ID: <20260422123242.530882-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280403-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.982];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Queue-Id: D9795446122
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello netdev team,

This PR is a new version of the one sent on March 20th.
We are trying to address a remote, yet possible, race condition between
tearing down an ovpn interface and adding new peers via netlink.

After further discussion including Jakub and Sabrina, the following
patch came up.

It should address all raised concerns.
Sorry for taking so long to get back to this.

Please pull or let mw know of any issue!

Thanks a lot,
	Antonio


The following changes since commit 478ed6b7d2577439c610f91fa8759a4c878a4264:

  net/sched: sch_dualpi2: drain both C-queue and L-queue in dualpi2_change() (2026-04-21 15:00:39 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260422

for you to fetch changes up to eac0dfc41d179d5f78d6d7ee401c63f48ba04b5a:

  ovpn: fix race between deleting interface and adding new peer (2026-04-22 14:30:17 +0200)

----------------------------------------------------------------
Included change:
* fix race condition between interface teardown and new peer being
  added via netlink

----------------------------------------------------------------
Antonio Quartulli (1):
      ovpn: fix race between deleting interface and adding new peer

 drivers/net/ovpn/main.c | 12 ++----------
 drivers/net/ovpn/peer.c |  8 ++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

