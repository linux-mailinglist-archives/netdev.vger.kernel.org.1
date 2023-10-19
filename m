Return-Path: <netdev+bounces-42551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC07CF504
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AAE1C209AC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B95A182AC;
	Thu, 19 Oct 2023 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i7n7Db79"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5F18030
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:21:20 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798F11F;
	Thu, 19 Oct 2023 03:21:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71BA56000B;
	Thu, 19 Oct 2023 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697710877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2ydsXXBaNBGMFpju1QSEdkFSa9tXDTzQRBfxsG6otY=;
	b=i7n7Db79nY/VWXnDbI9SYtt/qtDyAdtROrcJASSglaQq0S4kA0BCkd9sH+O7h8PCbPWgRZ
	BpXnW+ddcdjoh8XF0Jfvl+SSKd8up7VDJ33nVsqTqeyOPogF8KIE627ydCwtKPpHU+RoBv
	KEi8ACvEKF0qNEIXM7RYM2UDSL5qcQIoLZ+yoDDivxUHAAF13DeItCECs0Og7eLXlxPt1M
	nmzbaaPynO6UmIY5CrH86Swy4LVOalHZaHWCJQA6lAPi1ILMRTfJuBZTTIeedopl1nQIIL
	7YZtXtrsK7P+/y0jfv43LjGtkmThadBK6WfQviqnJzZs4wLIqhnPfW5JF+Z6yQ==
Date: Thu, 19 Oct 2023 12:21:14 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
In-Reply-To: <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
	<20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
	<20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 19 Oct 2023 11:51:40 +0200
Michal Kubecek <mkubecek@suse.cz> wrote:

> On Thu, Oct 19, 2023 at 11:05:10AM +0200, Michal Kubecek wrote:
> > On Thu, Oct 19, 2023 at 09:09:04AM +0200, Oleksij Rempel wrote:  
> > > With current kernel it is possible to set flags, but not possible to
> > > remove existing WoL flags. For example:
> > > ~$ ethtool lan2
> > > ...
> > >         Supports Wake-on: pg
> > >         Wake-on: d
> > > ...
> > > ~$ ethtool -s lan2 wol gp
> > > ~$ ethtool lan2
> > > ...
> > >         Wake-on: pg
> > > ...
> > > ~$ ethtool -s lan2 wol d
> > > ~$ ethtool lan2
> > > ...
> > >         Wake-on: pg
> > > ...
> > >   
> > 
> > How recent was the kernel where you encountered the issue? I suspect the
> > issue might be related to recent 108a36d07c01 ("ethtool: Fix mod state
> > of verbose no_mask bitset"), I'll look into it closer.  
> 
> The issue was indeed introduced by commit 108a36d07c01 ("ethtool: Fix
> mod state of verbose no_mask bitset"). The problem is that a "no mask"
> verbose bitset only contains bit attributes for bits to be set. This
> worked correctly before this commit because we were always updating
> a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
> verbose no_mask bitset"), that is) so that the rest was left zero
> naturally. But now the 1->0 change (old_val is true, bit not present in
> netlink nest) no longer works.

Doh I had not seen this issue! Thanks you for reporting it.
I will send the revert then and will update the fix for next merge-window.

> To fix the issue while keeping more precise modification tracking
> introduced by commit 108a36d07c01 ("ethtool: Fix mod state of verbose
> no_mask bitset"), we would have to either iterate through all possible
> bits in "no mask" case or update a temporary zero bitmap and then set
> mod by comparing it to the original (and rewrite the target if they
> differ). This is exactly what I was trying to avoid from the start but
> it wouldn't be more complicated than current code.
> 
> As we are rather late in the 6.6 cycle (rc6 out), the safest solution
> seems to be reverting commit 108a36d07c01 ("ethtool: Fix mod state of
> verbose no_mask bitset") in net tree as sending a notification even on
> a request which turns out to be no-op is not a serious problem (after
> all, this is what happens for ioctl requests most of the time and IIRC
> there are more cases where it happens for netlink requests). Then we can
> fix the change detection properly in net-next in the way proposed in
> previous paragraph (I would prefer not risking more intrusive changes at
> this stage).

