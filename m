Return-Path: <netdev+bounces-267966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RRpTJdMgt2l2MwEAu9opvQ
	(envelope-from <netdev+bounces-267966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:12:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC9292852
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 911CA3040188
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E0637C109;
	Sun, 15 Mar 2026 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="iY0rPm2B"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BE30B535;
	Sun, 15 Mar 2026 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773609166; cv=none; b=LoGUmC0y1e9mCjYl9/iSI94AJxGrvtOybnGdu3/vxv2589EoAbVcqi2hirsoxlD6AT+JaTJ0BfPMp8fvBAzZj6Ot0C9EJbrmz/ZVRkRvVjwUT3taKij2WaOesnT+Stw5gXdJ8R8qFAWbgrLVJVw+2/WZWrTby8Zyq+MjRlMy890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773609166; c=relaxed/simple;
	bh=baQQ9q0kd3wcITK7sv6jKXLDYA4w41ZswxUMD1gSpwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axoiqXzg/jxv8Rx2wUzZt+EPUCwCNoiaJoY2nMKN490LWvi99jSx8iAgal32t81uiXw9E+RSLzD9jpLgECJAaQ1feD++GFCLSeObSUQ16HG4ZYa/k8P68NX2yk6SKT+ANFc9LyOLC0BxWhn9yE1iX7MmKcAA5Xyeh863a/KoKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=iY0rPm2B; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id EAE7CE839EF;
	Sun, 15 Mar 2026 22:12:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1773609162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioBdTR7mTLB2WhIfXT9h785cnRCocM+mUJ1WFCPO4ng=;
	b=iY0rPm2BEOukat4DnfAjMrgNEw3GjONDY7GR2V/XtHqmM1gBvnTUbxxZwNHfyYcUPygIjv
	DogfDIshIPH5wRqlx6K+HulfBHlvN5pQ5gzrYvsG+pazn3O9HaUG596GRWfDtY5vm5aqzN
	N2rRKPSXzlbQm0KNLsqFsDEdZ6X+eMYp9OUW+JsBjgnne2fM8J30uYnmbWpvhECTOec1+y
	nD/pAi3FDZzVdELJB9s567BbQXtXO/7sJF8iO3fXTNmh6RItl0LD4OpIFlLwN+fl4ynCib
	NTLACcMC3geZofLVME14reTLSqC3gr5pJ3k9K9fI5Nl5owKmBF7G7Y5wuYH8hQ==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id pYmxrQgiBbjT; Sun, 15 Mar 2026 22:12:41 +0100 (CET)
Received: from p14sgen5.fritz.box (dslb-002-205-089-164.002.205.pools.vodafone-ip.de [2.205.89.164])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 15 Mar 2026 22:12:40 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: o.rempel@pengutronix.de
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	github@szelinsky.de,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net: pse-pd: add LED trigger support
Date: Sun, 15 Mar 2026 22:12:22 +0100
Message-ID: <20260315211222.2519478-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <abblHRq6Q85j5lXA@pengutronix.de>
References: <abblHRq6Q85j5lXA@pengutronix.de>
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
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267966-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E1AC9292852
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Oleksij,

Thanks for your kind and quick feedback. I appreciate the time you invested on the weekend :-)

I will look into your suggestion and try to work on it... 

Regarding your question: It is a simple POE chip (hs104) that is integrated in different cheap realtek managed switches.
It communicates only via i2c with the host and does not have any other GPIP/IRQ functionality. The problem is that the LEDs are controlled via a different (MFD) chip that communicates via i2c as well. We wanted to uncouple this as much as possible to keep things clean.

More information you find here:
https://github.com/openwrt/openwrt/pull/22245 [hs104 driver]
https://forum.openwrt.org/t/support-poe-on-hasivo-devices-s1100wp-8gt-se/244817 [discussion]
https://github.com/openwrt/openwrt/pull/21578 [MFD LED controller]

Side note: We are working hard on supporting PSE-PD for openwrt (backports to 6.12, luci, netifd support) and we plan to port other old drivers.

Do you think this simple driver for the hs104 (openwrt github PR) could get merged to mainline kernel?

best,
Carlo


