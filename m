Return-Path: <netdev+bounces-23758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D6476D6B0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 20:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C5C281B8A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E9101CF;
	Wed,  2 Aug 2023 18:19:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3635F9F2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 18:19:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5B11717;
	Wed,  2 Aug 2023 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vugMJywOE93SV3kAUeXAKCse0EvFHhNIczoKtvubJlk=; b=HmiXdWkuy665ksIH7dQ/x8MHjh
	MW3Wy1mYP9tpYf1o92JcSxtQsjNFnA/XfoG8hoB2E+mqtuVLQUppK1ytNeoi6RolTtsqQcKWqbTXx
	kNJv1T0H15NDJ5f/KHhrJ4ir7GmO6A9MjnaXHU2KIzf9RsOq6UDI7NpTkNWziNVrXJevReydUKcUH
	+gqX7NQsXg4o2vFc9kR3f6DbjSRvwp4Uf/dh/VIPDznS2rQN79k2fzXoRXu5r7VF3Ds0tYNOmi2iz
	5sGT95xiM0xw7rOnRNQDdASeQVQnhrMlvBIVq1Ckt3FIIIzChAQShaj74K/DESZF03st36DsTGrIl
	yqqNEIhw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qRGRJ-005cp8-0x;
	Wed, 02 Aug 2023 18:19:17 +0000
Date: Wed, 2 Aug 2023 11:19:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>, Joshua Kinard <kumba@gentoo.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: require EXPORT_SYMBOL_GPL symbols for symbol_get v2
Message-ID: <ZMqeJT9Fv0zzw3/v@bombadil.infradead.org>
References: <20230801173544.1929519-1-hch@lst.de>
 <ZMlEvr1Vo+475e5X@bombadil.infradead.org>
 <20230802115658.GA30268@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802115658.GA30268@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 01:56:58PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 01, 2023 at 10:45:34AM -0700, Luis Chamberlain wrote:
> > On Tue, Aug 01, 2023 at 07:35:39PM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series changes symbol_get to only work on EXPORT_SYMBOL_GPL
> > > as nvidia is abusing the lack of this check to bypass restrictions
> > > on importing symbols from proprietary modules.
> > 
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Let me know if you want this to go through the modules tree or your own.
> 
> I don't think this would fit anywhere but the modules tree.

OK sure!

> Let me know if you want me to resend for the mmc dependency fixup or
> if you want to squash it yourself.

Applied, I squashed the depends on MMC=y as suggested by Arnd and pushed
out to modules-next.`

  Luis

