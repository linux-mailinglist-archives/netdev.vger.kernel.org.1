Return-Path: <netdev+bounces-40681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B228C7C8548
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52615B209B5
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC314268;
	Fri, 13 Oct 2023 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C9HT0EZt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48314011;
	Fri, 13 Oct 2023 12:05:44 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48FDA;
	Fri, 13 Oct 2023 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JVNjKA5BDxHIuNoLtOyLa0d8PBvTaC7XyqHCbnt00h0=; b=C9
	HT0EZtdZTTScE2v3IV7j2X36h2efmC5H3E6jYaFi4GMyhNJsRNTWKErZXFLPp+3JRhgc/JgIrGEXu
	OA3001XO64hvR99tJBz1CoZKBkx5xMobrF7Le1xEwXXZ3Q+RECtFyZr1rUbrpfC4ln9grnpq1M3pk
	1IGTLNwTDvDhvaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrGv4-0025Mw-JH; Fri, 13 Oct 2023 14:05:30 +0200
Date: Fri, 13 Oct 2023 14:05:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Stitt <justinstitt@google.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Message-ID: <e2b7f4fb-b2f9-4457-b5ae-4cf6acceb10d@lunn.ch>
References: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
 <a86149c3-077c-4380-83ec-99a368e6d589@lunn.ch>
 <CAFhGd8qAfWiC0en-VXaR_DxNr+xFfw8zwUJ4KgCd8ieSmU3t5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qAfWiC0en-VXaR_DxNr+xFfw8zwUJ4KgCd8ieSmU3t5g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 03:01:06PM -0700, Justin Stitt wrote:
> On Thu, Oct 12, 2023 at 2:59 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Thu, Oct 12, 2023 at 09:53:03PM +0000, Justin Stitt wrote:
> > > strncpy() is deprecated for use on NUL-terminated destination strings
> > > [1] and as such we should prefer more robust and less ambiguous string
> > > interfaces.
> >
> > Hi Justin
> >
> > You just sent two patches with the same Subject. That got me confused
> > for a while, is it a resend? A new version?
> 
> Yep, just saw this.
> 
> I'm working (top to bottom) on a list of strncpy hits. I have an automated tool
> fetch the prefix and update the subject line accordingly. They are two separate
> patches but ended up with the same exact subject line due to oversight and
> over-automation.
> 
> Looking for guidance:
> Should I combine them into one patch?

No, it is fine. Just try to avoid it in the future.

    Andrew

