Return-Path: <netdev+bounces-275618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCGvCKjG02mqlgcAu9opvQ
	(envelope-from <netdev+bounces-275618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EFA3A453F
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BC1530071D0
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361563845B3;
	Mon,  6 Apr 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="bHWv+7hz"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844703806DA;
	Mon,  6 Apr 2026 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486628; cv=none; b=gbRnLt0lyPuy36U1GZKF1QIYfJ9IxcYvQnZn4GkC/UwwNcnlioAWj2+mUvQRSYisQ22boztmaDP1BgHOFuKwzs8tE2/zAoYXMC//fC3QUchvqMe5yEYclmNb+fxaezT2447fRSbkM3kTC3vFUvS29X+wH4CwmDUGDKT7TeTWNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486628; c=relaxed/simple;
	bh=rmjYbnkw94A9U79dmJ5TDUh19hIbyDLscu8kGB8Ab28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuAP8HY+tn2YL0cLKAg3tPeyWOSzrc6/hMVmdk4u3WvDmmZQLg4BmU75568+mLz4Fck+q1BXWkP8i1qY/Rary90gxulB4thzfhr6dOla3nITQ7+e6lsWQ8YQmBKXp7Ul5/9mfF2+5n2qtvjgo1heEwu5WRG+eKb2wARrKAnvyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=bHWv+7hz; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id CBD6CE831AD;
	Mon,  6 Apr 2026 16:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1775486623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmjYbnkw94A9U79dmJ5TDUh19hIbyDLscu8kGB8Ab28=;
	b=bHWv+7hzNB6yWgwO9GiuBJ6SAn1axBbnwiVgebVeao7SB/+2OEw/oKoldA4is0ICdB/Xt4
	Ki9JMMpmniX6QYEdH5puig6BAJY0vsLnaxL9gNcrIZkb4i1lhbdKYamMzKwl0He1mqwPuH
	ZJYVyiFlV9bX4XxeNQP3ipPPo5YVEGd6U1vYOioFLlzp37XDhor+eVL33Zx2Zj6RAr+Wxb
	ObZn5ua3JosgX1XWhnIYP9K31qxFdd+gueb/xzhDvr+rI0cpumE3J5WQd7OOxwTe7B/08K
	7QAPaV4eDJ7vqCOC7kCZ4vJlNOxKS310A6/H+qx+r6akIRkNuBVyeqYlViBgAw==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id yWJJs7mzYGDh; Mon,  6 Apr 2026 16:43:43 +0200 (CEST)
Received: from p14sgen5.intern.hubertus-soelden.com (unknown [83.218.176.39])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon,  6 Apr 2026 16:43:43 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as non-fatal during PHY registration
Date: Mon,  6 Apr 2026 16:43:24 +0200
Message-ID: <20260406144324.4007913-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3597433c-ce26-43c6-9a5f-e942a3db5340@lunn.ch>
References: <3597433c-ce26-43c6-9a5f-e942a3db5340@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-275618-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,szelinsky.de:dkim,szelinsky.de:mid]
X-Rspamd-Queue-Id: B8EFA3A453F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew, Oleksij,

Thanks for pushing me in the right direction here.

So if I understand correctly, I should move the PSE control lookup
from fwnode_mdiobus_register_phy() into phy_probe(). That way the PHY
just defers like any other device if the PSE controller isn't there
yet, and the bus scan keeps going for the other PHYs.

I checked and bus_probe_device() is void, so device_add() won't fail
even if probe defers. And once the PSE module loads, the deferred
probe retry should kick in and claim the regulator before the 30s
cleanup runs. If the module never loads, the regulator cleanup is
actually the right thing to do safety-wise. So no need for the
admin_state_synced workaround or the lazy resolution stuff -
deferred probe just handles it.

Unlike lazy resolution, this also doesn't break notifications, so
PSE is acquired during probe, not on first ethtool access.

Does that sound like what you had in mind?

Cheers,
Carlo

