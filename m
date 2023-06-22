Return-Path: <netdev+bounces-13179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9A73A8B9
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F21C211D8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8F206B4;
	Thu, 22 Jun 2023 19:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D191F923
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:01:49 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4659B;
	Thu, 22 Jun 2023 12:01:48 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-31121494630so8626255f8f.3;
        Thu, 22 Jun 2023 12:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460506; x=1690052506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQKzGLLngarWVhVTw2URKzbQiX5Xh0ThcGjikbK/29A=;
        b=UDaogkxedFUKrLBbokO3Ju1XWzQsshU4NzizhE111YxjVL/KNgAdifnWs3aZVyEqnh
         vZLqxNQG2p5Z41RNyZ2k1HYP7KJToFUID1byUceENvRpFn2nmR/Fk/3WzleWGvlOzZBg
         cbtsILSaBxvPwgt6bsmd3HEx6TR2HX3bnAuRa0OHGTEDRRUKAYhbmcvyN+XtUXdS/smy
         TqIuucLOcep/obdp00dn2uafwYJ/S4an7+fCBuCNKM4VQh2n7V5rQ5kAexgk9ST+XZnL
         BsB9yEtdUnp3AvAw+5NPltZEX4Znv66aHgXRugSSkasJa4s8vfAHsOaoVqBv/jNSCYWT
         wHaw==
X-Gm-Message-State: AC+VfDzUGonVeZqp2rk4tW0X5cz5cCvSnqP0udUDlT/eVoGBUMoR85aJ
	NuctXn7FZLyWZHinSTcAZt0=
X-Google-Smtp-Source: ACHHUZ4Fm507H6gAfhlPKOCV3A52LQqvUW+RMQ+AjS6G760+nRpx0UGIk5+/UcW36fRpV4dsuqghUA==
X-Received: by 2002:a5d:67cd:0:b0:2ef:b052:1296 with SMTP id n13-20020a5d67cd000000b002efb0521296mr17148852wrw.22.1687460506529;
        Thu, 22 Jun 2023 12:01:46 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b003078681a1e8sm7680789wrt.54.2023.06.22.12.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:01:46 -0700 (PDT)
Date: Thu, 22 Jun 2023 12:01:44 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	leit@meta.com, Arnd Bergmann <arnd@arndb.de>,
	Steve French <stfrench@microsoft.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Simon Ser <contact@emersion.fr>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH] io_uring: Add io_uring command support for sockets
Message-ID: <ZJSamAduIRJ3b/TX@gmail.com>
References: <20230621232129.3776944-1-leitao@debian.org>
 <2023062231-tasting-stranger-8882@gregkh>
 <ZJRijTDv5lUsVo+j@gmail.com>
 <2023062208-animosity-squabble-c1ba@gregkh>
 <ZJR49xji1zmISlTs@gmail.com>
 <2023062228-cloak-wish-ec12@gregkh>
 <20230622103948.33cbb0dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622103948.33cbb0dd@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 10:39:48AM -0700, Jakub Kicinski wrote:
> On Thu, 22 Jun 2023 19:03:04 +0200 Greg Kroah-Hartman wrote:
> > > Correct. For now we are just using 0xa0 and 0xa1, and eventually we
> > > might need more ioctls numbers.
> > > 
> > > I got these numbers finding a unused block and having some room for
> > > expansion, as suggested by Documentation/userspace-api/ioctl/ioctl-number.rst,
> > > that says:
> > > 
> > > 	If you are writing a driver for a new device and need a letter, pick an
> > > 	unused block with enough room for expansion: 32 to 256 ioctl commands.  
> > 
> > So is this the first io_uring ioctl?  If so, why is this an ioctl and
> > not just a "normal" io_uring call?
> 
> +1, the mixing with classic ioctl seems confusing and I'm not sure 
> if it buys us anything.

Sure, let me remove the dependency on ioctl()s then.

