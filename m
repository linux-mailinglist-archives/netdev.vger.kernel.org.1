Return-Path: <netdev+bounces-22786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E0C76942B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F3928159D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A517FE9;
	Mon, 31 Jul 2023 11:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86E79E4
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24852C433C7;
	Mon, 31 Jul 2023 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690801529;
	bh=aDQytpIehxdC9Y92aOCsKJiiWVzUj/QKa0p5med/PCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6NCuUd2dWAFRltw2+pGmuDVTotQpjH0ekKpzZTX6xFqUgNw1T9VfYT3y9t9W5+Zi
	 a90PJEXjCJlyzYqhxvr/DW6eMaqAi8zS6wVgLCL/aR8FuEgbQLT1Uwoy4WRgpwA9Qx
	 +/vFsSMs5e4xpn7tonapNyoZMS+bpeH9TBXzd6Xo=
Date: Mon, 31 Jul 2023 13:05:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/5] modules: only allow symbol_get of EXPORT_SYMBOL_GPL
 modules
Message-ID: <2023073135-destiny-washbowl-2689@gregkh>
References: <20230731083806.453036-1-hch@lst.de>
 <20230731083806.453036-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731083806.453036-6-hch@lst.de>

On Mon, Jul 31, 2023 at 10:38:06AM +0200, Christoph Hellwig wrote:
> It has recently come to my attention that nvidia is circumventing the
> protection added in 262e6ae7081d ("modules: inherit
> TAINT_PROPRIETARY_MODULE") by importing exports from their propriertary
> modules into an allegedly GPL licensed module and then rexporting them.
> 
> Given that symbol_get was only ever inteded for tightly cooperating
> modules using very internal symbols it is logical to restrict it to
> being used on EXPORY_SYMBOL_GPL and prevent nvidia from costly DMCA

"EXPORT"  :)

> circumvention of access controls law suites.
> 
> All symbols except for four used through symbol_get were already exported
> as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over in
> the preparation patches.
> 
> Fixes: 262e6ae7081d ("modules: inherit TAINT_PROPRIETARY_MODULE")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for fixing this hole up, it's much needed.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

