Return-Path: <netdev+bounces-157714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363FA0B5ED
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D381666F6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D715F22CF35;
	Mon, 13 Jan 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HbV//J92"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71722CF30
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768754; cv=none; b=g5DvQ1/vjRvRSjVD8/Eluq/3MeNUIpeltXodIhxtWbUv6V+kQgwGyg9OwlnmomEh62IK/E8berVYUrm08sLVUs16VUf/EOais3o27pdGUn/r2rRjOshLgEsYEkCFuVCmmiWqlnUOpmpdI2rfJPY5q0Q7BDxMcJYSJunlLj+1h0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768754; c=relaxed/simple;
	bh=lM19slQSzr84yEo2MfTfOOnbwx+ie3cshz0kSwx98HY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LWEWfDHhGCQ1i6DYgfiFJSLlsuHVb8riogWsXOg76rTZlej6dT5gvkJdKoA6Ya11zCC+s8ALIoO+gDEucQuEKXCYX7lyy7ruzTf6rvxnaCrZe66ZgnszbVyeoFgizSzXKpkAORc/9jVuVmX+1Q5t5r9GtEzWvGb0cLA4WPYjnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HbV//J92; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rbT7xplslF0DCwfG1zTGk6wwOgd2peDWsm8gQHEx3QU=; b=HbV//J923OKFzYQsHCa/mYJO0C
	9uuIYF46MTKqOgpdamOhMHRV+Wm9SIPPz91V3memmxMaE/Qvruj7Qa1HlS6zQUHdjMwaedD5hXUP5
	25q7Z3fpmeUVaxOsEIQWB0HFGwIbMmC5js2OhLEieEh1+ld6qW61bVOE/pKMp45QWEctF4pLwR62+
	mYMXdMNCIfc5usr9g7m7sv3Vumj9ERgypVSYZTPCuxmR2nZtsLg4pnovVXSG8XsQ1Iq1bQYzIt2DJ
	bqK7ZxiyrLDLtM01HHbmbFtTQX6pRn6rg7c8BgN4S+psaC1cJDcFdP+6fagisCsJ36P7t3VI78DrS
	F6U8pnyQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58056)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXIt3-0006Ue-02;
	Mon, 13 Jan 2025 11:45:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXIsz-00042f-1U;
	Mon, 13 Jan 2025 11:45:37 +0000
Date: Mon, 13 Jan 2025 11:45:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: lexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/9] net: stmmac: further EEE cleanups (and one fix!)
Message-ID: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series continues the EEE cleanup of the stmmac driver, and
includes one fix.

As mentioned in the previous series, I wasn't entirely happy with the
"stmmac_disable_sw_eee_mode" name, so the first patch renames this to
"stmmac_stop_sw_lpi" instead, which I think better describes what this
function is doing - stopping the transmit of the LPI state because we
have a packet ot send.

Patch 2 corrects the priv->eee_sw_timer_en flag when EEE has been
disabled. Currently upon disable, priv->eee_enabled is set false,
but through the weird logic that was present prior to the previous
series, priv->eee_sw_timer_en was set true. This behaviour was kept
as the previous series was cleanup, not fixes. This patch fixes this.

Having fixed priv->eee_sw_timer_en to actually indicate whether
software timed EEE mode is being used, it becomes no longer necessary
to test priv->eee_enabled in addition. Patch 3 removes the redundant
test. Patch 4 also uses priv->eee_sw_timer_en before manipulating the
software EEE state in the suspend method rather than using
priv->eee_enabled, which brings consistency.

Patch 5 provides stmmac_try_to_start_sw_lpi() which complements
stmmac_stop_sw_lpi(), and allows us to move duplicated code into one
location.

Patch 6 splits stmmac_enable_eee_mode() - one part of this function
tests whether there are any queues that have unfinished work (in
other words are busy). Separate out this code into a separate function.

Patch 7 also splits out the mod_timer() for the software EEE timer
intoi a seperate function (the reason will be in patch 9.)

Patch 8 merges the remains of stmmac_enable_eee_mode() into
stmmac_try_to_start_sw_lpi().

Patch 9 fixes the delay between transmit and entering LPI. Currently,
when cleaning the transmit queues, if we discover that we have finished
cleaning up all queues, we immediately instruct the hardware to enter
LPI mode without waiting for the LPI timer. However, we should wait for
the LPI timer to expire. Therefore, the transmit cleanup path needs
to call stmmac_restart_sw_lpi_timer() instead of
stmmac_try_to_start_sw_lpi().

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 58 +++++++++++++----------
 1 file changed, 33 insertions(+), 25 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

