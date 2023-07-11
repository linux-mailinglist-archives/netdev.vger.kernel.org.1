Return-Path: <netdev+bounces-16913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2102A74F69E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 19:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517071C20D1D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422A61DDE9;
	Tue, 11 Jul 2023 17:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD82168CE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EECC433C8;
	Tue, 11 Jul 2023 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689095462;
	bh=InfyI8SICKvF4zmJpauBWDNo/zPPdtTLtpODWeNYZJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S32dMWGzpZI0vlWdhqWHPysllb8jt18+0TZ9/J6/kdL5p8gbnh9eiPh2pkxP+RwDr
	 d0EN67ZYCRaVoqoGTdUn7tSaPbpFLOvIKB9W3RfO7Khnv/gc5uueJyhHejEN0QUEtp
	 pIyQddscMT7tKiSD9x3pG9DciqYaTJHBdkJJC3KpKwgrjuvUf6W/QY5q9XxkZ/Pi6L
	 1gBsJQrRHm4KyQfkOzRIQfxTcHDyonHFTlhpw5HM9BDRs6j2HX+m+JAAOzoLO50WgT
	 kTSiEJqjA5aP5GKAdjVoyApZESK4B7ir78UtN6hH91vgx3PoLSGiIsfyDB0tfShxUw
	 r4Qhhl88+yrXQ==
Date: Tue, 11 Jul 2023 20:10:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <20230711171058.GT41919@unreal>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
 <ZK002l0AojjdJptC@smile.fi.intel.com>
 <20230711122012.GR41919@unreal>
 <ZK1O7lBF1vH7/7UM@smile.fi.intel.com>
 <20230711133259.GS41919@unreal>
 <ZK1csjLgGM+ezG/J@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK1csjLgGM+ezG/J@smile.fi.intel.com>

On Tue, Jul 11, 2023 at 04:44:18PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 11, 2023 at 04:32:59PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 11, 2023 at 03:45:34PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jul 11, 2023 at 03:20:12PM +0300, Leon Romanovsky wrote:
> > > > On Tue, Jul 11, 2023 at 01:54:18PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> > > > > > On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > > > > > > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > > > So what is the outcome of "int - bool + bool" in the line above?
> > > > > 
> > > > > The same as with int - int [0 .. 1] + int [0 .. 1].
> > > > 
> > > > No, it is not. bool is defined as _Bool C99 type, so strictly speaking
> > > > you are mixing types int - _Bool + _Bool.
> > > 
> > > 1. The original code already does that. You still haven't reacted on that.
> > 
> > The original code was int - int + int.
> 
> No. You missed the callers part. They are using boolean.

I didn't miss and pointed you to the exact line which was implicitly
changed with your patch.

> 
> > > 2. Is what you are telling a problema?
> > 
> > No, I'm saying that you took perfectly correct code which had all types
> > aligned and changed it to have mixed type arithmetic.
> 
> And after this change it's perfectly correct code with less letters and hidden
> promotions (as a parameter to the function) and hence requires less cognitive
> energy to parse.
> 
> So, the bottom line is the commit message you don't like, is it so?

Please reread my and Paolo replies.

Thanks

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

