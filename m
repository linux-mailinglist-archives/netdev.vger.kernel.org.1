Return-Path: <netdev+bounces-266657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGwlLN91sWnovQIAu9opvQ
	(envelope-from <netdev+bounces-266657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:02:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C7264FAE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADCC8301A789
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEE336C9D4;
	Wed, 11 Mar 2026 14:01:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8A36C9CF
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237708; cv=none; b=HqarW48ERwC7V1lw4QPVecVcbdu4f+BptJwaMW5fxydwInIy/tirVjqxTR4De6QKsGSmLKGHQAm7VHCIkxJtaSq3TufTOAEBpwYpVp/1bF1uvZIBFP+5hLo+IC4u83E7Ti/C7E5RO9vzB2hfde7OninjXCyV6hvptC8IBK7kbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237708; c=relaxed/simple;
	bh=S4UmMmjJrDTazcbT5LVID27SCCCkhWidRFPu6ff3d48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDD1bbJWePjKk5kxemDIyT2r4LTYWBvZRBOV64WyEHWZVUGKbKigBXTbHfeMwRz6fBXruqUXGCyoUrxx/wGGozI612OcwXY44WzyfpdF7/gcEUJTZYFuD0A1p6zqG7sJ2+nzsSW8h57MAJO1lwgVDTW0wvLSYDGw1Euahu/r9Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0206FC19425;
	Wed, 11 Mar 2026 14:01:45 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: rmk+kernel@armlinux.org.uk
Cc: andrew@lunn.ch,
	conor@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next] net: phy: vitesse: add inband caps and configuration
Date: Wed, 11 Mar 2026 15:01:35 +0100
Message-ID: <20260311140135.937544-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F5C7264FAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266657-lists,netdev=lfdr.de,renesas];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.937];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,kernel,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,armlinux.org.uk:email,glider.be:mid,glider.be:email]
X-Rspamd-Action: no action

	Hi Russell,

On Wed, 11 Mar 2026 at 01:07, Russell King <rmk@armlinux.org.uk> wrote:
> Add support for VSC8662 reporting its inband capabilities, and also
> hook to configure the PHY's inband mode.
>
> This fixes a regression in the macb driver caused by commit
> 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")

Fixes: 1338cfef1ff1b958 ("net: macb: fix SGMII with inband aneg disabled")

> Reported-by: Conor Dooley <conor@kernel.org>
> Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud

s/Link/Closes/

> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks, this fixes the regression on MPFS Icicle I bisected to the
aforementioned commit.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

