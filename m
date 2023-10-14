Return-Path: <netdev+bounces-41000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57BB7C9542
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 18:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CC01C20A43
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198413AD5;
	Sat, 14 Oct 2023 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0xP1chpQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E4F4F1;
	Sat, 14 Oct 2023 16:13:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A0A2;
	Sat, 14 Oct 2023 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mzqMfzRxzG70Knwvi6tm0b5cGlVoxpozVCu8YLy3yG8=; b=0xP1chpQpytJmfkOYJUkI+Hvv4
	4GO8LpdIGkE3fvVpwIfyzJn4nTntAloMj1KN06CCFJECEXAI/KW0+lrg27r/RXbg2LlJua3sHeRId
	1eRBFJJQhorhTd0eDdQk6ZAWLwHa2dgjDHeIO9GesIrAT2YkDP8bjB4H4bA7xIp1NZq8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrhGQ-002BXN-2v; Sat, 14 Oct 2023 18:13:18 +0200
Date: Sat, 14 Oct 2023 18:13:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Stitt <justinstitt@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: cpmac: replace deprecated strncpy with strscpy
Message-ID: <985a2962-c327-4115-bc59-b1bc896be9b3@lunn.ch>
References: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 08:53:30PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect mdio_bus_id to be NUL-terminated based on its use with
> snprint():
> |       snprintf(priv->phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT,
> |                                               mdio_bus_id, phy_id);
> 
> Moreover, as this is the only use of mdio_bus_id, we can see that
> NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Note that for the replacement involving cpmac_mii->id, the source
> buffer's length is equal to MII_BUS_ID_SIZE which could result in a
> buffer overread. However, there is no buffer overread since "cpmac-1"
> (the string copied into cpmac_mii->id) is smaller than MII_BUS_ID_SIZE
> thus meaning the previous usage of strncpy() here did _not_ have any
> overread bugs. Nonetheless, let's still favor strscpy() over strncpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

