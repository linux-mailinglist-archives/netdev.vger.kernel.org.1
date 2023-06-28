Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C89774131A
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjF1Nyd (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 09:54:33 -0400
Received: from vps0.lunn.ch ([156.67.10.101]:40062 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbjF1Nyb (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 09:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=P6cmuf0SSytqlSR57AgCub75y1mIBY9HtWI98JRc4Ro=; b=CTpEX1KXuRrEeKE13i+ulrC6Wi
        /tk9CEPFXGgtxro+Y9Eg44QpKBywR2qNeN2qZzp+2yke97uRMxkarp/Jp/uBPAsP5Emy7jrTe+CYD
        Zfcegwkx4rK7NWgo1VKkTsRQmcCXMhrvsEUrIq2thDjNS7kaT+GNwOId6CDr4LTlo8yg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEVcq-0007bE-1u; Wed, 28 Jun 2023 15:54:28 +0200
Date:   Wed, 28 Jun 2023 15:54:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Revanth Kumar Uppala <ruppala@nvidia.com>
Cc:     linux@armlinux.org.uk, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-tegra@vger.kernel.org,
        Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 2/4] net: phy: aquantia: Enable MAC Controlled EEE
Message-ID: <57493101-413c-4f68-a064-f25e75fc2783@lunn.ch>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-2-ruppala@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124326.55732-2-ruppala@nvidia.com>
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, Jun 28, 2023 at 06:13:24PM +0530, Revanth Kumar Uppala wrote:
> Enable MAC controlled energy efficient ethernet (EEE) so that MAC can
> keep the PHY in EEE sleep mode when link utilization is low to reduce
> energy consumption.

This needs more explanation. Is this 'SmartEEE', in that the PHY is
doing EEE without the SoC MAC being involved?

Ideally, you should only do SmartEEE, if the SoC MAC is dumb and does
not have EEE itself. I guess if you are doing rate adaptation, or
MACSEC in the PHY, then you might be forced to use SmartEEE since the
SoC MAC is somewhat decoupled from the PHY.

At the moment, we don't have a good story for SmartEEE. It should be
configured in the same way as normal EEE, ethtool --set-eee etc. I've
got a rewrite of normal EEE in the works. Once that is merged i hope
SmartEEE will be next.

    Andrew
