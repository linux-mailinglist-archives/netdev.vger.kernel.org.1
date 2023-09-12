Return-Path: <netdev+bounces-33194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BB779CF69
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BCD1C20F42
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A87168A3;
	Tue, 12 Sep 2023 11:06:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A81426C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:06:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56129F
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:06:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qg1E6-0006GO-5r; Tue, 12 Sep 2023 13:06:38 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qg1E5-005lSi-Gp; Tue, 12 Sep 2023 13:06:37 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qg1E5-005cZt-9B; Tue, 12 Sep 2023 13:06:37 +0200
Date: Tue, 12 Sep 2023 13:06:37 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE support
Message-ID: <20230912110637.GI780075@pengutronix.de>
References: <20230912122655.391e2c86@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912122655.391e2c86@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello Köry,

On Tue, Sep 12, 2023 at 12:26:55PM +0200, Köry Maincent wrote:
> Hello,
> 
> I am working on the PoE support and I am facing few questioning.
> I would like to use the same commands and core as PoDL, but non generic
> development raised questions.
> 
> The admin_state and admin_control are the same therefore I will use the
> ethtool_podl_pse_admin_state enumeration.
> The power detection status have few differences, I thought that adding PoE
> specific states to ethtool_podl_pse_pw_d_status rather than adding a new
> ethtool_pse_pw_d_status enum is the best way to avoid breaking the old API.
> 
> I also would like to remove PoDL reference to ethtool but keep
> "podl-pse-admin-control" command for old compatibility alongside a new
> "pse-admin-control" command.
> 
> What do you think? Do you think of a better way?

By defining UAPI for PoDL/PoE I decided to follow IEEE 802.3
specification as close as possible for following reasons:
- we should be backwards and forwards compatible. IEEE 802.3 is always
  extended, some existing objects and name spaces can be extended
  withing the specification. If we will merge some of them, it may get
  challenging to make it properly again.
- PoDL and PoE have separate attributes and actions withing the specification. 
- If we follow the spec, it is easier to understand for all who need to
  implement or extend related software
- I can imagine some industrial device implementing PoDL/PoE on same
  port. We should be able to see what is actually active.

IMO, it is better not to mix PoDL and PoE name spaces and keep it as
close as possible to the IEEE 802.3.
Same is about ethtool interface. 

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

