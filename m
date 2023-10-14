Return-Path: <netdev+bounces-40939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C37C9240
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2D5B20AEC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E97B1106;
	Sat, 14 Oct 2023 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="maqe7cYu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088227E;
	Sat, 14 Oct 2023 01:55:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0346CBF;
	Fri, 13 Oct 2023 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cjW+qsUfbs6nzKf1dTERhV/HEx/8IziabIg1Ep2LkPw=; b=maqe7cYuDKIiDrqKlbKmWOn7xM
	IrpLEF9ncAqzaX8IOBfdJCyG8Q6HyvABIRi8ENKEsHWCwFEk5fAvYk3zgfB6Rqm/zVAgE1T02HSWO
	O+Pe0xzv6vu7U8uIEtWKUpGC0Qk+B/iAc2hRT6PRiRcYtwaQduanCgdydx2qIbm9+Ux4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrTsT-0029U4-Mh; Sat, 14 Oct 2023 03:55:41 +0200
Date: Sat, 14 Oct 2023 03:55:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <a958d35e-98b6-4a95-b505-776482d1150c@lunn.ch>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
 <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
 <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
 <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
 <202310131630.5E435AD@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310131630.5E435AD@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> I've been told that this whole ethtool API area is considered
> deprecated. If that holds, then I don't think it's worth adding new
> helpers to support it when ethtool_sprintf() is sufficient.

I think deprecated is too strong. The current API is not great, so
maybe with time a new API will emerge. But given there are around 160
users of the API, probably over 100 drivers, it will be 20 years or
more before all that hardware becomes obsolete and the drivers are
removed.

> Once you're done with the strncpy->ethtool_sprintf conversions I think
> it would be nice to have a single patch that fixes all of these
> "%s"-less instances to use "%s". (Doing per-driver fixes for that case
> seems just overly painful.)

I guess it is the same amount of effort to replace them with
ethtool_puts()?

checkpatch warns about seq_printf() which could be seq_puts(), so
somebody thinks using puts is the right thing to do?

	 Andrew

