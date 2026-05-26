Return-Path: <netdev+bounces-291747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAQgA8fAFWrRaAcAu9opvQ
	(envelope-from <netdev+bounces-291747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:48:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27135D904C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BDA53016B48
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3130C14F;
	Tue, 26 May 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwsGTp8f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21ED2F7EFC
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809752; cv=none; b=ClGOQJl17qB9QfGwEm84qk5tDmPV7jfNUQmJCy24dA5HIWtKXnoRcIUvWGNRsJN9v12nUFqJnEpUWUEFfiHFoigX9VENRa8nu07SfDTnxpAfcsrIHf3c1P85aBDO0uHo/TxT6Y2ZgdDDpLY+wUJv62ZM7foDiAu7oALtGcVt5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809752; c=relaxed/simple;
	bh=UoCuzmBB83dK/LER91Ai/anaQOjvm5k84g0yAx4MkjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moDB4pAtnwAVok/cTeNdt8qHQcSopR9U4AegGKUGq1VT0Hra1+Mq+SOpOQIyfl/YVnSDWdguUC083KzgkxBUlmLEswKWoX2mMseMuNkg0bXXlzUUWxx9Hw2oybxoa27QSfuhSIFvtSFkoD2MDD4eopl8lS7tGVV4/JhSNLNoTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwsGTp8f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38371F00A3A;
	Tue, 26 May 2026 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809749;
	bh=XDuAUppYRkvnLOtZZRx6YQYTHmfPq/arMOwRwzMrESc=;
	h=From:To:Cc:Subject:Date;
	b=KwsGTp8fcq5PdXKkhdovg40rHvyQ3DiTu3J9sHEwfYDEwSNohzE8bmUR5H8/oOE+P
	 3Tms4dsXT+k9OEKsoMwUxI3E7IprrdeEbOhhT3YGq48FSYKSDBupvT91mK4yctV4VV
	 32smillL8waycBYFctcxR/SqeRX7zeoSW6+dKlWGRxNCmA4D+1E89NFmQMW/Mb2HXS
	 Pb9la3qlUvfcq6Xx1ekYczk+qz9KHqCtMet8Yw/mM+hMxkg8LZKM3wik22rm8/HSvL
	 gQFsZlYlMvQ9PaakV7cIvCH8zaMzzL72Sq4aeHJIWR+YaFo2o2ZYEm/V+MdQrge57x
	 TYFRQphexnFuA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 00/10] ethtool: more bug fixes
Date: Tue, 26 May 2026 08:35:23 -0700
Message-ID: <20260526153533.2779187-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291747-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D27135D904C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Last week I sent two patch sets - one fixing bugs in RSS handling,
and one fixing CMIS / module handling. This set contains the remaining
fixes. There's a concentration of fixes around PHY and timestamp config
handling but not enough to break those out as separate sets.

Jakub Kicinski (10):
  ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
  ethtool: tsconfig: fix reply error handling
  ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup
    error
  ethtool: pse-pd: fix missing ethnl_ops_complete()
  ethtool: tsconfig: fix missing ethnl_ops_complete()
  ethtool: tsinfo: fix uninitialized stats on the by-PHC path
  ethtool: tsinfo: don't pass ERR_PTR to genlmsg_cancel on prepare
    failure
  ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
  ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during
    fallback
  ethtool: eeprom: add more safeties to EEPROM Netlink fallback

 net/ethtool/coalesce.c  |  6 ++++++
 net/ethtool/eeprom.c    | 10 ++++++----
 net/ethtool/linkstate.c |  6 ++----
 net/ethtool/pse-pd.c    | 10 +++++-----
 net/ethtool/strset.c    |  2 +-
 net/ethtool/tsconfig.c  | 15 +++++++++++----
 net/ethtool/tsinfo.c    | 19 +++++++++++++++----
 7 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.54.0


