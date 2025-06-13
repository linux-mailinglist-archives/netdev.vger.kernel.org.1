Return-Path: <netdev+bounces-197492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FA6AD8C9F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1413BAD09
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4BA1D540;
	Fri, 13 Jun 2025 12:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F87275B1F;
	Fri, 13 Jun 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819382; cv=none; b=i8RugTLmH4tGAg9XUymo0BYQSMGMh85xkh7AsKBIZAUKRR2qb8lMvHgzyRRzvEQzp2i9AySGYnXNk0PgBEuLxsVyZ98Ne+MGzk0vcxBms0uzZ2iQVAXphQ/XicxF93pO8MAcHOblGkZyyBCx/TCkye8BrzandP46QSI9vHoQ23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819382; c=relaxed/simple;
	bh=MqkTIBby2wvrD0suonE6HSiAFSYk5pQxx0AVGdk6xM4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YolWiQXHbZQ/irqv5OGfmhzzsGRcf6MxoZJlluRjHprVPfxQuNaHzXjYWF0zoJx0hd3TBQOGNMuCtwYcbKknyEk4PFcFDG/GHILtyYGvc0Yj3yCXAMYc/+F1ShDlox59vs3ssHzg4WGfl/UW12NR9PIw4jjTYFM1abOCs6wf+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uQ3oY-000000001H0-12R5;
	Fri, 13 Jun 2025 12:56:04 +0000
Date: Fri, 13 Jun 2025 14:55:46 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
	Robert Marko <robimarko@gmail.com>
Subject: [RFC] comparing the propesed implementation for standalone PCS
 drivers
Message-ID: <aEwfME3dYisQtdCj@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi netdev folks,

there are currently 2 competing implementations for the groundworks to
support standalone PCS drivers.

https://patchwork.kernel.org/project/netdevbpf/list/?series=970582&state=%2A&archive=both

https://patchwork.kernel.org/project/netdevbpf/list/?series=961784&state=%2A&archive=both

They both kinda stalled due to a lack of feedback in the past 2 months
since they have been published.

Merging the 2 implementation is not a viable option due to rather large
architecture differences:

				| Sean			| Ansuel
--------------------------------+-----------------------+-----------------------
Architecture			| Standalone subsystem	| Built into phylink
Need OPs wrapped		| Yes			| No
resource lifecycle		| New subsystem		| phylink
Supports hot remove		| Yes			| Yes
Supports hot add		| Yes (*)		| Yes
provides generic select_pcs	| No			| Yes
support for #pcs-cell-cells	| No			| Yes
allows migrating legacy drivers	| Yes			| Yes
comes with tested migrations	| Yes			| No

(*) requires MAC driver to also unload and subsequent re-probe for link
to work again

Obviously both architectures have pros and cons, here an incomplete and
certainly biased list (please help completing it and discussing all
details):

Standalone Subsystem (Sean)

pros
====
 * phylink code (mostly) untouched
 * doesn't burden systems which don't use dedicated PCS drivers
 * series provides tested migrations for all Ethernet drivers currently
   using dedicated PCS drivers

cons
====
 * needs wrapper for each PCS OP
 * more complex resource management (malloc/free) 
 * hot add and PCS showing up late (eg. due to deferred probe) are
   problematic
 * phylink is anyway the only user of that new subsystem


phylink-managed standalone PCS drivers (Ansuel)

pros
====
 * trivial resource management
 * no wrappers needed
 * full support for hot-add and deferred probe
 * avoids code duplication by providing generic select_pcs
   implementation
 * supports devices which provide more than one PCS port per device
   ('#pcs-cell-cells')

cons
====
 * inclusion in phylink means more (dead) code on platforms not using
   dedicated PCS
 * series does not provide migrations for existing drivers
   (but that can be done after)
 * probably a bit harder to review as one needs to know phylink very well


It would be great if more people can take a look and help deciding the
general direction to go. There are many drivers awaiting merge which
require such infrastructure (most are fine with either of the two), some
for more than a year by now.


Thank you!


Daniel

