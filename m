Return-Path: <netdev+bounces-22897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21505769D50
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525FC1C20BD4
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668C19BCE;
	Mon, 31 Jul 2023 16:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839C19BB2
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:57:28 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A0D1722;
	Mon, 31 Jul 2023 09:57:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A68A68AA6; Mon, 31 Jul 2023 18:57:22 +0200 (CEST)
Date: Mon, 31 Jul 2023 18:57:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 4/5] mmc: use EXPORT_SYMBOL_GPL for mmc_detect_change
Message-ID: <20230731165722.GA10760@lst.de>
References: <20230731083806.453036-1-hch@lst.de> <20230731083806.453036-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731083806.453036-5-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 10:38:05AM +0200, Christoph Hellwig wrote:
> mmc_detect_change is used via symbol_get, which was only ever intended
> for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
> for it so that symbol_get can enforce only being used on
> EXPORT_SYMBOL_GPL symbols.

Btw, I really wonder if this should actually be used through symbol_get.
It seems like the MIPS/alchemy boards should simply require MMC to be
built in and not modular, or the IRQ handlers should move into a driver.

That would be a much less mechanical change, but this use really looks
a bit odd.  And makes me wonder if we should only allow symbol_get
on symbols specifically marked to supported it, but that would be
another incremental step.

