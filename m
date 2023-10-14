Return-Path: <netdev+bounces-41043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 694197C9680
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 23:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7755B20C3E
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332726285;
	Sat, 14 Oct 2023 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EhsPLu3R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46391C8C0;
	Sat, 14 Oct 2023 21:18:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BC8CC;
	Sat, 14 Oct 2023 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GUOYh/aQsCH7U/D4Ni685NDFLunCDbfhb1mVIHYQ3Sg=; b=EhsPLu3RzPX5mfqfqo/L1HtxNQ
	BK9ZpBtmQzvz8SHpNWHgrvz/bbIkZQGCiMPVv7Eeb6jkdjFJgo3iaF5dMIUGfM6epfiLH67EflYPx
	f7MJ/UyKSfLJTJKYTggsS6KciFRLybmonNQh3nt4qGu94iWBNqI0ZTaJvgZ5B5XB8lwQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrm1e-002Cer-HG; Sat, 14 Oct 2023 23:18:22 +0200
Date: Sat, 14 Oct 2023 23:18:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ca362a9e-2212-4f3a-bc35-3187ff905ec0@lunn.ch>
References: <4791a460-09e0-4478-8f38-ae371e37416b@proton.me>
 <20231014.193231.787565106108242584.fujita.tomonori@gmail.com>
 <3469de1c-0e6f-4fe5-9d93-2542f87ffd0d@proton.me>
 <20231015.011502.276144165010584249.fujita.tomonori@gmail.com>
 <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d70de37-c5ed-4776-a00f-76888e1230aa@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> What about these functions?
> - resolve_aneg_linkmode
> - genphy_soft_reset
> - init_hw
> - start_aneg
> - genphy_read_status
> - genphy_update_link
> - genphy_read_lpa
> - genphy_read_abilities

If i'm understanding the discussion correctly, you want to know if
these C functions can modify the phydev structure that is passed to
them?

Yes, they all do modify it.

They also assume that phydev->lock is taken somewhere up the call
chain, so they are safe to modify the structure without worrying about
multiple threads being active.

There are some functions which currently don't modify the phydev
passed to them. However, we are pretty bad at putting on the const
attribute. I also think it would be dangerous to assume such functions
will forever not modify phydev.

	Andrew

