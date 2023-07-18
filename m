Return-Path: <netdev+bounces-18712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BEE75858F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84242816B7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59EB171BE;
	Tue, 18 Jul 2023 19:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA92168DD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:31:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED76198D;
	Tue, 18 Jul 2023 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4lvrkWb6sfRiU5F2WxbxoLsvFXn2cJ/Sdsc7oIw9b8Y=; b=RxWb4ZqkCJJM4ETLid0VMKIMWf
	R8wRhiq0A658gKpuMIItkj4B0yqM6ftio+QEER5QhbdX4T4yEVvPTZfgakdg/4+x0nSkmdfr1FRbC
	ZENuNMykair96x6nZj53SgSp7oYcWGM5LODf9ZgAyXEDefwaH5Ao0Gp4r1nBQ8QqM8KM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLqPY-001ePh-BG; Tue, 18 Jul 2023 21:31:04 +0200
Date: Tue, 18 Jul 2023 21:31:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>, justinstitt@google.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] net: dsa: remove deprecated strncpy
Message-ID: <dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
 <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
 <20230718121116.72267fff@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718121116.72267fff@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 12:11:16PM -0700, Jakub Kicinski wrote:
> On Tue, 18 Jul 2023 11:05:23 -0700 Kees Cook wrote:
> > Honestly I find the entire get_strings API to be very fragile given
> > the lack of passing the length of the buffer, instead depending on
> > the string set length lookups in each callback, but refactoring that
> > looks like a ton of work for an uncertain benefit.
> 
> We have been adding better APIs for long term, and a print helper short
> term - ethtool_sprintf(). Should we use ethtool_sprintf() here?

I was wondering about that as well. There is no variable expansion in
most cases, so the vsnprintf() is a waste of time.

Maybe we should actually add another helper:

ethtool_name_cpy(u8 **data, unsigned int index, const char *name);

Then over the next decade, slowly convert all drivers to it. And then
eventually replace the u8 with a struct including the length.

The netlink API is a bit better. It is one kAPI call which does
everything, and it holds RTNL. So it is less likely the number of
statistics will change between the calls into the driver.

	Andrew

