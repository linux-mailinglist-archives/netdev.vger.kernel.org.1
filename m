Return-Path: <netdev+bounces-303438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r7ubB9Z4RGqRvQoAu9opvQ
	(envelope-from <netdev+bounces-303438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:17:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BBA6E93A4
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HyzoFKnv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303438-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303438-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2211E301466B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17A1B3B19;
	Wed,  1 Jul 2026 02:17:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F254F5E0
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 02:17:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872275; cv=none; b=BZuWmhZ9beBOj/r4vZV1HZMJrjNbxQuIPWJRIRvTwhRDtkVWmoj+jySfg20wRoHmHeJBdHUvFFptWuclxVIb4QiztH24R+XhJhmr/rQ4+gLkRBnvut5ll0Gbws5mMRPu8t6CaMbtSVHbXPJ9U3lBCqks7ANn4QgqU2AsmeXq9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872275; c=relaxed/simple;
	bh=bFtN0DWrXaFyPLIRYkrIGmbHXEqS6FcrVitKqdHAnAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HG2/9bMQ7drQozoFDewzPXoYhw3eoA1byg43WhffLZHQIlwA6RSdS2swQrLhKJLW3UTu8d5Jina2SUEmeFDTWMyvUJmQ+DLQWHsZG1PrZLR/3xKA75991c8zXB0g8KY8w4doWNAleed93p6eGOkahmeZU9IxlcjWGks54ukqNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyzoFKnv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11C91F000E9;
	Wed,  1 Jul 2026 02:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872274;
	bh=WD1pSiuoNdirDu25cNdEAcwleSuUFFdYBJzEtd35hIY=;
	h=From:To:Cc:Subject:Date;
	b=HyzoFKnv1R/880XmZMM3E20+wTdQpIg+j0w9CVq+id3mt8b3GMAy/jKrsPvFvX984
	 ezxaeUNr85QCE6PIYPHgmUSL0reGUBssGCknPjy2vK5JZhWHUgJOA17y/QmLKwPpPm
	 9O/GLguzatgZj2gtJftp+xBGUR7yauEMglmJE4ghPcIH00l4F8jF5KhpnwcEnVBlyK
	 RiT8T9/z+RGZzV7uNz4wC8nu0fY9RYzOYuugd6AQyM+kwy7oTktxjqvzQTtcBW4wzs
	 6GFHJbfMQ8p6Nznl1miqdRueCHKNPccCOhZjflnDEJPZvwYyCZfmoYJZf/BgRT4AqM
	 g0OLdzMWD4U0w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	gal@nvidia.com,
	jstancek@redhat.com,
	ast@fiberby.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/2] tools: ynl: pyynl: pull the --family resolution logic into the lib
Date: Tue, 30 Jun 2026 19:17:49 -0700
Message-ID: <20260701021751.3234681-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303438-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:jstancek@redhat.com,m:ast@fiberby.net,m:kuba@kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,nvidia.com,fiberby.net];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63BBA6E93A4

When packaging YNL as a system level utility we added a --family
argument which auto-resolves the full spec path from a well known
path in /usr/share. Spelling out full YAML spec files is at this
point only done in-tree, for example in the selftests which need
the very latest YAML. But the selftests have their own wrapping
classes for each family so test authors aren't really bothered
by having to spell the paths out.

Afford the same ease of use to the Python library users.
Move the path resolution from the CLI code to the library.
This simplifies the pyynl use by a lot:

  from pyynl import YnlFamily

  ynl = YnlFamily(family="netdev")

Unless I'm missing a trick, resolving the /usr/share path
is hard enough for most users to lean towards shelling out
to ynl CLI with --output-json, which is sad.

v2:
 - fix the ethtool script (Donald)
 - fix --family=X --validate (Clashiko)              
v1: https://lore.kernel.org/20260630001432.2204298-3-kuba@kernel.org

Jakub Kicinski (2):
  tools: ynl: pyynl: re-export the library API from the package root
  tools: ynl: pyynl: pull the --family resolution logic into the lib

 tools/net/ynl/pyynl/__init__.py     |  9 +++++
 tools/net/ynl/pyynl/cli.py          | 56 +++++++----------------------
 tools/net/ynl/pyynl/lib/__init__.py |  3 +-
 tools/net/ynl/pyynl/lib/nlspec.py   | 22 ++++++++++--
 tools/net/ynl/pyynl/lib/specdir.py  | 51 ++++++++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py      | 19 ++++++++--
 tools/net/ynl/tests/ethtool.py      |  7 +---
 7 files changed, 111 insertions(+), 56 deletions(-)
 create mode 100644 tools/net/ynl/pyynl/lib/specdir.py

-- 
2.54.0


