Return-Path: <netdev+bounces-54627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3648807A9C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7BF2824A9
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECA7097E;
	Wed,  6 Dec 2023 21:39:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE4B98
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:39:08 -0800 (PST)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
	id 1rAzbh-00014y-Ge by authid <merlin>; Wed, 06 Dec 2023 13:39:01 -0800
Date: Wed, 6 Dec 2023 13:39:01 -0800
From: Marc MERLIN <marc@merlins.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231206213901.GA31178@merlins.org>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org

On Wed, Dec 06, 2023 at 05:46:07PM +0100, Johannes Berg wrote:
> On Wed, 2023-12-06 at 08:44 -0800, Jakub Kicinski wrote:
> > On Wed,  6 Dec 2023 11:39:32 +0100 Johannes Berg wrote:
> > > As reported by Marc MERLIN, at least one driver (igc) wants or
> > > needs to acquire the RTNL inside suspend/resume ops, which can
> > > be called from here in ethtool if runtime PM is enabled.
> > > 
> > > Allow this by doing runtime PM transitions without the RTNL
> > > held. For the ioctl to have the same operations order, this
> > > required reworking the code to separately check validity and
> > > do the operation. For the netlink code, this now has to do
> > > the runtime_pm_put a bit later.
> > 
> > I was really, really hoping that this would serve as a motivation
> > for Intel to sort out the igb/igc implementation. The flow AFAICT
> > is ndo_open() starts the NIC, the calls pm_sus, which shuts the NIC
> > back down immediately (!?) then it schedules a link check from a work
> > queue, which opens it again (!?). It's a source of never ending bugs.
> 
> Well, I work there, but ... WiFi something else entirely. Marc just got
> lucky I spotted an issue in the logs ;-)
 
and I am truly thankful for the time you took to help out. It made a
huge difference for me in being able to keep a laptop that I will
probably use for the next 4 years and otherwise had to return.
Thank you for going above and beyond.

> I'll let you guys take it from here ...

As this time the first patch I got still works for me even if it's not
the most ideal way to fix this.
As you all figure out what's the best/better patch, please let me know
if you'd like me to validate/retest.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

