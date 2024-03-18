Return-Path: <netdev+bounces-80384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A587E924
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6871C2111E
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE6337707;
	Mon, 18 Mar 2024 12:10:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585638382
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763837; cv=none; b=CGbwAfzh5p4zLNBDK3aPrhwF9Pr/vCDzrvUTa7okEVrkE3yr18E0TDmgrch0gX1XDuWJDDWvEzj55rUg3xJY4Uq2Ofs6jEIwo1OImGEDkQKgkL2d02idSdBpGF7IudPoPq0kaPFLiL6D84Uq5ZdJYTEQxloAYWmI0I9MA1z+GzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763837; c=relaxed/simple;
	bh=9DO4H0yr1RtI4SR37swjRNKXlu0sNnwuEFpmHB3V3Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3ipubxyOtt4EPdQYHqiBdQyHCXtcKdOcFlsxGNiJ1X48m1xv30Fcdqkd6onwP0orG5TmRg6QZpeTeiDyBjnfTSeqP4SF0Z3L4cHjJcwL3v0FzAe3O4+H03gcIrJWUn/HfqK45cgC2zUHJJqnr3A0rt7WPtYYybefcN33+ziD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rmBp1-0004re-F6; Mon, 18 Mar 2024 13:10:31 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rmBp1-0074Ij-15; Mon, 18 Mar 2024 13:10:31 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rmBp0-005Uua-33;
	Mon, 18 Mar 2024 13:10:30 +0100
Date: Mon, 18 Mar 2024 13:10:30 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
Message-ID: <ZfgvNjWP8OYMIa3Y@pengutronix.de>
References: <20240315100159.3898944-1-s.hauer@pengutronix.de>
 <7b82679f-9b69-4568-a61d-03eb1e4afc18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b82679f-9b69-4568-a61d-03eb1e4afc18@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Mar 15, 2024 at 05:02:05PM +0000, Pavel Begunkov wrote:
> On 3/15/24 10:01, Sascha Hauer wrote:
> > It can happen that a socket sends the remaining data at close() time.
> > With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
> > out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
> > current task. This flag has been set in io_req_normal_work_add() by
> > calling task_work_add().
> 
> The entire idea of task_work is to interrupt syscalls and let io_uring
> do its job, otherwise it wouldn't free resources it might be holding,
> and even potentially forever block the syscall.
> 
> I'm not that sure about connect / close (are they not restartable?),
> but it doesn't seem to be a good idea for sk_stream_wait_memory(),
> which is the normal TCP blocking send path. I'm thinking of some kinds
> of cases with a local TCP socket pair, the tx queue is full as well
> and the rx queue of the other end, and io_uring has to run to receive
> the data.
> 
> If interruptions are not welcome you can use different io_uring flags,
> see IORING_SETUP_COOP_TASKRUN and/or IORING_SETUP_DEFER_TASKRUN.

I tried with different combinations of these flags. For example
IORING_SETUP_TASKRUN_FLAG | IORING_SETUP_SINGLE_ISSUER | IORING_SETUP_DEFER_TASKRUN
makes the issue less likely, but nevertheless it still happens.

However, reading the documentation of these flags, they shall provide
hints to the kernel for optimizations, but it should work without these
flags, right?

> 
> Maybe I'm missing something, why not restart your syscall?

The problem comes with TLS. Normally with synchronous encryption all
data on a socket is written during write(). When asynchronous
encryption comes into play, then not all data is written during write(),
but instead the remaining data is written at close() time.

Here is my call stack when things go awry:

[  325.560946] tls_push_sg: tcp_sendmsg_locked returned -512
[  325.566371] CPU: 1 PID: 305 Comm: webserver_libur Not tainted 6.8.0-rc6-00022-g932acd9c444b-dirty #248
[  325.575684] Hardware name: NXP i.MX8MPlus EVK board (DT)
[  325.580997] Call trace:
[  325.583444]  dump_backtrace+0x90/0xe8
[  325.587122]  show_stack+0x18/0x24
[  325.590444]  dump_stack_lvl+0x48/0x60
[  325.594114]  dump_stack+0x18/0x24
[  325.597432]  tls_push_sg+0xfc/0x22c
[  325.600930]  tls_tx_records+0x114/0x1cc
[  325.604772]  tls_sw_release_resources_tx+0x3c/0x140
[  325.609658]  tls_sk_proto_close+0x2b0/0x3ac
[  325.613846]  inet_release+0x4c/0x9c
[  325.617341]  __sock_release+0x40/0xb4
[  325.621007]  sock_close+0x18/0x28
[  325.624328]  __fput+0x70/0x2bc
[  325.627386]  ____fput+0x10/0x1c
[  325.630531]  task_work_run+0x74/0xcc
[  325.634113]  do_notify_resume+0x22c/0x1310
[  325.638220]  el0_svc+0xa4/0xb4
[  325.641279]  el0t_64_sync_handler+0x120/0x12c
[  325.645643]  el0t_64_sync+0x190/0x194

As said, TLS is sending remaining data at close() time in tls_push_sg().
Here sk_stream_wait_memory() gets interrupted and returns -ERESTARTSYS.
There's no way to restart this operation, the socket is about to be
closed and won't accept data anymore.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

