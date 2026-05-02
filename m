Return-Path: <netdev+bounces-283484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOV4JYda9mn2UAIAu9opvQ
	(envelope-from <netdev+bounces-283484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:11:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C974B36A6
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 22:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D7F13003404
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E664387373;
	Sat,  2 May 2026 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="J0F57fHx"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9D3859CB;
	Sat,  2 May 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752709; cv=none; b=R7OpXOEYc5RoTP7WtMK+NLp1XZ1FkJ3NTgczWGJesxNfgJwCNscDYkQOed3XfK4Kb+wEyVYXzD37/dDA13BGnPoDEOa/9eBGCfrAZij5hQtj/DG+LYLshhXd2kv8sTvY3ZKQxBMfhHoVpsTovpN2WQ4sp+RXJTQkR3qEn2NArQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752709; c=relaxed/simple;
	bh=1efGRYJ4dwjOPVqaTtTkpEfgSljIG5ZIC37r8cq9Xko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TniefL83oFgcOVRC5gWbS+bSLlVLC+H8uLikm5K84wMX0fkymwzpewBWrZQBLm7adF0xDcOl5JyIcKA0cICU1+OnzSADrv3md0/zoJdW/ukunBhy4mNpDKNa2Zxc99Vdn/NYgK7TAFuFA2bm1QPb1boR+JVKMmMP/wpASBaAfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=J0F57fHx; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id B7A25E838D7;
	Sat, 02 May 2026 22:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1777752698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCF8nWae30qrmbxhZCnlYC51xfH773Jl0CBVPOMzJF4=;
	b=J0F57fHxm/iv4Wuc4vkQDJj9gqgzl6UcK6AK2gDMWiy0eVTM63YgRIBgO34ZvSwmMK151e
	CuZpaYpmCHgx7hV0C3kz4j/TPIVy8U6c+T/rpN2pkLvoyV5lB3c8kTGGNWyQCONGlTkBro
	7NbZ4WgHEeQEnHSb93Yi+sXYvQbDli1P5x0inLyqHbnudmI/wcvzNNq6XeAEDrfsEF8g2a
	4jdgFjRc12HsuNQCWaBfOFbWv+PnLEB/RJootybS33iLHhoEka2vecbNAC9ekLj5Jg8hO1
	M1rDLeJPDR1EwwQFTfau9wJK+2EpozV96UutuNV7itJChHt8bNrPrPYi2i1tYA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id l6JMeDMJ8Utl; Sat,  2 May 2026 22:11:38 +0200 (CEST)
Received: from p14sgen5.lan (p57848dd9.dip0.t-ipconnect.de [87.132.141.217])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 02 May 2026 22:11:37 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Corey Leavitt <corey@leavitt.info>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sat,  2 May 2026 22:10:16 +0200
Message-ID: <20260502201016.2215520-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424144124.131837c7@kmaincent-XPS-13-7390>
References: <20260424144124.131837c7@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17C974B36A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-283484-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

I tested the series on a Hasivo S1100WP-8GT-SE with hs104 PSE
chips. Boot is clean, no more probe loop. ethtool --set-pse on/off
works, and a PD plugged into a port gets power. So the fix works
for me.

One thing I noticed: rmmod alone does not work while ports are
attached. Each PHY that holds a psec keeps a ref on the PSE
driver, so the module count stays above 0 and rmmod fails.

Unbinding the i2c devices first works:
  echo 0-000d > /sys/bus/i2c/drivers/hasivo-hs104/unbind
  echo 0-0015 > /sys/bus/i2c/drivers/hasivo-hs104/unbind
  rmmod hasivo-hs104

After unbind your PSE_UNREGISTERED notifier fires, the PHYs drop
the psec, and the module count goes to 0. Then rmmod works.

Not a big deal, but maybe worth a short note in the cover letter
so people know they need to unbind first. Or if there is a clean
way to skip the per-consumer module_get and just rely on the
unbind path, that would be nice too. What do other folks think?

One thing my test does not cover yet is the SFP path change in
sfp.c, since the S1100WP-8GT-SE is copper only. I do have an
S600WP-5GT-2SX-SE that uses the same hs104 chips plus SFP+ cages,
but it is not on my desk right now. I can run that part on it
later.

Anyway, thanks for the work on this. Happy to test a v2.

Carlo

Tested-by: Carlo Szelinsky <github@szelinsky.de>

