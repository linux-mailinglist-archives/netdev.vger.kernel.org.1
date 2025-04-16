Return-Path: <netdev+bounces-183327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64CA90617
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EFD19E395D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695E01FC0ED;
	Wed, 16 Apr 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M2FGhuHM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB21FC0E3
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812799; cv=none; b=eBHt/cwnZNER8EP+zvCGFaELl07YzmGX7oOVUjVTPqcK/A6XwGChPvlH8gEPOHGS6KbBaUnrI7ChVLIA3j/STWiNyOuDFXZ0TIbvkYpnO3NuCdmBXXvAqDv61U62z42dWhi1Jk1e54z52L2OKwlAsm5y1Q/AF3YHMWlXNbRjhAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812799; c=relaxed/simple;
	bh=mnE1XyyBx3n5f658PJ96GhxADjYCTq5fq/is9Esp2hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8BRILvXvJSeuVbqqL+qME6i1JD6l44P2zRdCojcWBrntK1OhDvOXo/k1jFrcFBdpBn2BbW6HpNe6wP6k70Cys3C2aARL+g8RZnxUtMa7TRxG5qZkqZ+F0TnsU/BlCA6PgmjODZtjTehARVA3H2XW74lD6tXqBKBaV8KWRFXvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=M2FGhuHM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SlWV7KRrdPRge9FHfHpn1ECGl8B4DT6+p6WEnsWTmD8=; b=M2FGhuHMC3ccd+d+6TAKnvFOL2
	56tu9FwICKWbGnxCcG7+Z9w7RDenh9wNOpIQxLPWf6F2cnkOm6txUCP4SRM/vKnfbSx6dYQ+LW6Wr
	ekc6RasShe5e5/9LHlLO1lTlo/1lHiUWBWwPPOJXeUa6yoz283Dw3lKaSMioAUmgjcuDL5IynUk+w
	mrImCV+Gmw1SQcH82bVh3Dt9ihCJlEota47KPOU4NBHfMh/Qbtq/KqwSaYo72orgCcs4lYfjhSVS+
	5x9FLd2h4/k1PBmFpq+EedMEIbhFI+Pq5Jaow7L9DbXWHkG1CUeEyOtX2R6Cce0+VQ5cj5jO1yiuV
	kJtliDlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45310)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u53Vk-0001SX-1h;
	Wed, 16 Apr 2025 15:13:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u53Vg-0001Sv-3D;
	Wed, 16 Apr 2025 15:13:05 +0100
Date: Wed, 16 Apr 2025 15:13:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 0/5] Marvell PTP support
Message-ID: <Z_-68PMRo3rGT-9V@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
 <Z_-Lr-w95sX4fLIF@shell.armlinux.org.uk>
 <20250416151949.6bddde35@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416151949.6bddde35@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 03:19:49PM +0200, Kory Maincent wrote:
> Maybe using kdoc in marvell_ts.c. You can copy paste the ones I wrote on
> the v2 of your driver I posted.

My position on kdoc is that it's worth kdocing interface functions, but
should never be used for internal functions. How many developers build
the kernel docs to read documentation divorced from their static
functions? Probably zero.

> Also don't forget to run checkpatch, patchwork reported errors on your series.
> It was not an issue as it was a RFC but it will if you remove it.

I'll fix *some* of them that make sense to fix, but not all of them.
Those I won't be fixing are:

CHECK: Please use a blank line after function/struct/union/enum
declarations
#465: FILE: drivers/net/phy/marvell_ptp.h:14:
+}
+#define marvell_phy_ptp_probe(x...) marvell_phy_ptp_dummy_probe()

No, it makes sense to keep these together.

Also:

ERROR: Missing Signed-off-by: line(s)

on the last two patches - I refer anyone back to the cover message
where I stated about their current state. In any case, in this form
they will be rejected even if they had a commit description and sob.
They at the very least need squashing together once stuff has settled
and I gave reasons why that hasn't happened yet.

Given that I can't test that anymore, nothing's going to change on
those last two patches, which means they will remain unsubmittable
for some time to come.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

