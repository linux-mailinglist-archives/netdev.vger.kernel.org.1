Return-Path: <netdev+bounces-40604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9D57C7D2F
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 07:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85960B2090E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 05:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4C569C;
	Fri, 13 Oct 2023 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3485693
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:47:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41935B8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 22:47:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1qrB14-0006Nk-RV; Fri, 13 Oct 2023 07:47:18 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1qrB13-001KAR-0Y; Fri, 13 Oct 2023 07:47:17 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1qrB12-00EDtH-U8; Fri, 13 Oct 2023 07:47:16 +0200
Date: Fri, 13 Oct 2023 07:47:16 +0200
From: Sascha Hauer <sha@pengutronix.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Boris Pismenny <borisp@nvidia.com>, netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: Problem with io_uring splice and KTLS
Message-ID: <20231013054716.GG3359458@pengutronix.de>
References: <20231010141932.GD3114228@pengutronix.de>
 <d729781a-3d12-423b-973e-c16fdbcbb60b@kernel.dk>
 <20231012133407.GA3359458@pengutronix.de>
 <f39ef992-4789-4c30-92ef-e3114a31d5c7@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39ef992-4789-4c30-92ef-e3114a31d5c7@kernel.dk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 07:45:07PM -0600, Jens Axboe wrote:
> On 10/12/23 7:34 AM, Sascha Hauer wrote:
> > In case you don't have encryption hardware you can create an
> > asynchronous encryption module using cryptd. Compile a kernel with
> > CONFIG_CRYPTO_USER_API_AEAD and CONFIG_CRYPTO_CRYPTD and start the
> > webserver with the '-c' option. /proc/crypto should then contain an
> > entry with:
> > 
> >  name         : gcm(aes)
> >  driver       : cryptd(gcm_base(ctr(aes-generic),ghash-generic))
> >  module       : kernel
> >  priority     : 150
> 
> I did a bit of prep work to ensure I had everything working for when
> there's time to dive into it, but starting it with -c doesn't register
> this entry. Turns out the bind() in there returns -1/ENOENT.

Yes, that happens here as well, that's why I don't check for the error
in the bind call. Nevertheless it has the desired effect that the new
algorithm is registered and used from there on. BTW you only need to
start the webserver once with -c. If you start it repeatedly with -c a
new gcm(aes) instance is registered each time.

I think what I am doing here is not the intended use case of cryptd and
only works by accident.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

