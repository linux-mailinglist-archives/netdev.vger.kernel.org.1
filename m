Return-Path: <netdev+bounces-15465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72616747C15
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 06:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163A91C20945
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 04:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2686A28;
	Wed,  5 Jul 2023 04:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35FE7FF
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 04:40:19 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9F10F5
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 21:40:18 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qGuJ5-0005TM-7p; Wed, 05 Jul 2023 06:39:59 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qGuJ1-000542-U6; Wed, 05 Jul 2023 06:39:55 +0200
Date: Wed, 5 Jul 2023 06:39:55 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Astra Joan <astrajoan@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, ivan.orlov0322@gmail.com,
	kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@rempel-privat.de,
	mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
	robin@protonic.nl, skhan@linuxfoundation.org,
	socketcan@hartkopp.net,
	syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing
 j1939_socks_lock to rwlock
Message-ID: <20230705043955.GE15522@pengutronix.de>
References: <F17EC83C-9D70-463A-9C46-FBCC53A1F13C.ref@yahoo.com>
 <F17EC83C-9D70-463A-9C46-FBCC53A1F13C@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F17EC83C-9D70-463A-9C46-FBCC53A1F13C@yahoo.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 10:55:47AM -0700, Astra Joan wrote:
> Hi Oleksij,
> 
> Thank you for providing help with the bug fix! The patch was created
> when I was working on another bug:
> 
> https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> 
> But the patch was not a direct fix of the problem reported in the
> unregister_netdevice function call. Instead, it suppresses potential
> deadlock information to guarantee the real bug would show up. Since I
> have verified that the patch resolved a deadlock situation involving
> the exact same locks, I'm pretty confident it would be a proper fix for
> the current bug in this thread.
> 
> I'm not sure, though, about how I could instruct Syzbot to create a
> reproducer to properly test this patch. Could you or anyone here help
> me find the next step? Thank you so much!

Sorry, I'm not syzbot expert. I hope someone else can help here.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

