Return-Path: <netdev+bounces-134600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8499A601
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E2EB26456
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3A21D168;
	Fri, 11 Oct 2024 14:10:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4C21A6E7
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655856; cv=none; b=CrTG2gdYOp3H/nPfQxgM+KkLB0QWmLUWEta2gawyTPlXgRmFCRMdLgOsqEobLC0FpT6lwIzyIaBJwCRmiRv9NX7Wd1OzeLFoBgtOMEvAwlV+uAn86gSnZpFBcHSYcnZiU+cjRVrXQ/uEE7CUSAr6HNHXd9VmrD3hn6KIBWYQrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655856; c=relaxed/simple;
	bh=Evz9PqaYCouD/IH0SVGRo5c95kYbJTRWx/H2nAPLIQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNIe9faoqP3SfRhvD2qOzenMBTlJOaPMoijltfD1E/U+dyngea+KEVWJLlhV6AI2cNRaAUOi3y197Xv97ePruiaP/mnxSL13sOmw34bk0aH55hNh9A6AvR9m2O9lATF0KjRUkbzSqgamixE3EgigaLAEE8pFpO42r3z+ORlA8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1szGLX-0004Wz-Jd; Fri, 11 Oct 2024 16:10:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1szGLS-0016f6-BL; Fri, 11 Oct 2024 16:10:18 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1szGLS-005ipa-0l;
	Fri, 11 Oct 2024 16:10:18 +0200
Date: Fri, 11 Oct 2024 16:10:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: eadavis@qq.com, davem@davemloft.net, edumazet@google.com,
	kernel@pengutronix.de, kuba@kernel.org, leitao@debian.org,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
	robin@protonic.nl, socketcan@hartkopp.net,
	syzbot+ad601904231505ad6617@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] can: j1939: fix uaf warning in
 j1939_session_destroy
Message-ID: <Zwkxyr-MndeD6mmB@pengutronix.de>
References: <tencent_5B8967E03C7737A897DA36604A8A75DB7709@qq.com>
 <20241011134124.3048936-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011134124.3048936-1-snovitoll@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Sabyrzhan,

On Fri, Oct 11, 2024 at 06:41:24PM +0500, Sabyrzhan Tasbolatov wrote:
> On Thu, 8 Aug 2024 19:07:55 +0800, Edward Adam Davis wrote:
> > On Thu, 8 Aug 2024 09:49:18 +0200, Oleksij Rempel wrote:
> > > > the skb to the queue and increase the skb reference count through it.
> > > > 
> > > > Reported-and-tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > 
> > > This patch breaks j1939.
> > > The issue can be reproduced by running following commands:
> > I tried to reproduce the problem using the following command, but was 
> > unsuccessful. Prompt me to install j1939cat and j1939acd, and there are
> > some other errors.
> > 
> > Can you share the logs from when you reproduced the problem?
 
ah, i was on vacation and it went under my radar, sorry :(

> Hello,
> 
> Here is the log of can-tests/j1939/run_all.sh:
> 
> # ip link add type vcan
> # ip l s dev vcan0 up
> # ./run_all.sh vcan0 vcan0
> ##############################################
> run: j1939_ac_100k_dual_can.sh
> generate random data for the test
> 1+0 records in
> 1+0 records out
> 102400 bytes (102 kB, 100 KiB) copied, 0.00191192 s, 53.6 MB/s
> start j1939acd and j1939cat on vcan0
> 8321
> 8323
> start j1939acd and j1939cat on vcan0
> [  132.211317][ T8326] vcan0: tx drop: invalid sa for name 0x0000000011223340
> j1939cat: j1939cat_send_one: transfer error: -99: Cannot assign requested address
> 
> It fails here:
> https://github.com/linux-can/can-tests/blob/master/j1939/j1939_ac_100k_dual_can.sh#L70

I assume it is just secondary fail, it probably failed on address claim
stage in j1939acd, so the j1939cat was not able to start transfer due to
missing (not claimed) address.

> The error message is printed in this condition:
> https://elixir.bootlin.com/linux/v6.12-rc2/source/net/can/j1939/address-claim.c#L104-L108
> 
> I've applied your patch on the current 6.12.0-rc2 and the syzkaller C repro
> doesn't trigger WARNING uaf, refcount anymore though.

Yes, because transfer protocol is broken now. 

> == Offtopic:
> I wonder if can-tests/j1939 should be refactored from shell to C tests in the
> same linux-can/can-tests repository (or even migrate to KUnit tests)
> to improve debugging, test coverage. I'd like to understand which syscalls
> and params are used j1939cat and j1939acd utils -- currently, tracing with
> strace and trace-cmd (ftrace).

I have nothing against it, some of them I implemented in C:
https://github.com/linux-can/can-tests/blob/master/j1939/tst-j1939-ac.c#L1160

Right now I do not have enough time to port it, but I can support anyone
who is willing to do it.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

