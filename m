Return-Path: <netdev+bounces-44401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D127D7D36
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F271C20DD1
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225811712;
	Thu, 26 Oct 2023 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B27C123
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:03:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C2191
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:03:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1qvuOc-0005qF-Vj; Thu, 26 Oct 2023 09:03:10 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1qvuOc-004LjJ-6G; Thu, 26 Oct 2023 09:03:10 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1qvuOc-00GPL8-1U; Thu, 26 Oct 2023 09:03:10 +0200
Date: Thu, 26 Oct 2023 09:03:10 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	kernel@pengutronix.de
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
Message-ID: <20231026070310.GY3359458@pengutronix.de>
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
 <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Oct 24, 2023 at 03:56:17PM +0200, Paolo Abeni wrote:
> On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
> > It can happen that a socket sends the remaining data at close() time.
> > With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
> > out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
> > current task. This flag has been set in io_req_normal_work_add() by
> > calling task_work_add().
> > 
> > It seems signal_pending() is too broad, so this patch replaces it with
> > task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.
> 
> This looks dangerous, at best. Other possible legit users setting
> TIF_NOTIFY_SIGNAL will be broken.
> 
> Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work() ?

I don't have an idea how io_run_task_work() comes into play here, but it
seems it already clears TIF_NOTIFY_SIGNAL:

static inline int io_run_task_work(void)
{
        /*
         * Always check-and-clear the task_work notification signal. With how
         * signaling works for task_work, we can find it set with nothing to
         * run. We need to clear it for that case, like get_signal() does.
         */
        if (test_thread_flag(TIF_NOTIFY_SIGNAL))
                clear_notify_signal();
	...
}

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

