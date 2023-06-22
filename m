Return-Path: <netdev+bounces-13130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC6F73A632
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164FA1C21044
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB691F932;
	Thu, 22 Jun 2023 16:38:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F47E557
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:38:22 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397461BF7;
	Thu, 22 Jun 2023 09:38:20 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3094910b150so7620084f8f.0;
        Thu, 22 Jun 2023 09:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687451898; x=1690043898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB0suKEkJQmytRBmMlmNivZj0JmQI27egSZIQBCLiKY=;
        b=KVW9INFjTGP6nLf6nHrM5DXcR4AYi5Fh/+EDicKxVnvB6IqaJsiKoFzx2w/MQT133v
         JERTJJhS0hrgbtCgmknm8aiwvlLhPihdBC8lwkZ0WNp4/lkFjd9cKDjRF6Kjg0XRoRxF
         IIdnt5BgaoDO5JEfHRh5gSA8LmIk8dSR9h5fglbhHIo2TBYQxsBC6onWyXdzss+Z3uQV
         TYFChTfNX6EApYbRAky40u8/PTIslbTCt3AIdz4o8RVf+ajlOXJ3HlJaz8AAJWmwyw8K
         RBueB5Hj25GuiGsJqwGbTVR7wdm1VLQ0PzaSs5mY08HYanVJw8yt/aop/7ai8F4ucsWu
         QIBg==
X-Gm-Message-State: AC+VfDzxpSVfyG1WDFU7FqZ3r89xiLrx/3E90N3QCZiqKjMqxhzJanCS
	wWlevF8DAzChIGIJYBmbIy0=
X-Google-Smtp-Source: ACHHUZ7YJPRoIzsSuvgk6Ca3b8fdnvDMB9LWha1ZeFUS82uYJVQLFsZOiUBzDHQot94HjDnJyBNlSA==
X-Received: by 2002:adf:f488:0:b0:311:1b0b:2ec8 with SMTP id l8-20020adff488000000b003111b0b2ec8mr16952643wro.52.1687451898377;
        Thu, 22 Jun 2023 09:38:18 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id c11-20020a056000104b00b003063a92bbf5sm7507180wrx.70.2023.06.22.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:38:17 -0700 (PDT)
Date: Thu, 22 Jun 2023 09:38:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <ZJR49xji1zmISlTs@gmail.com>
References: <20230621232129.3776944-1-leitao@debian.org>
 <2023062231-tasting-stranger-8882@gregkh>
 <ZJRijTDv5lUsVo+j@gmail.com>
 <2023062208-animosity-squabble-c1ba@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062208-animosity-squabble-c1ba@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 06:10:00PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 22, 2023 at 08:02:37AM -0700, Breno Leitao wrote:
> > On Thu, Jun 22, 2023 at 07:20:48AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 21, 2023 at 04:21:26PM -0700, Breno Leitao wrote:
> > > > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > > @@ -361,6 +361,7 @@ Code  Seq#    Include File                                           Comments
> > > >  0xCB  00-1F                                                          CBM serial IEC bus in development:
> > > >                                                                       <mailto:michael.klein@puffin.lb.shuttle.de>
> > > >  0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
> > > > +0xCC  A0-BF  uapi/linux/io_uring.h                                   io_uring cmd subsystem
> > > 
> > > This change is nice, but not totally related to this specific one,
> > > shouldn't it be separate?
> > 
> > This is related to this patch, since I am using it below, in the
> > following part:
> > 
> > 	+#define SOCKET_URING_OP_SIOCINQ _IOR(0xcc, 0xa0, int)
> > 	+#define SOCKET_URING_OP_SIOCOUTQ _IOR(0xcc, 0xa1, int)
> > 
> > Should I have a different patch, even if they are related?
> 
> Yes, as you are not using the 0xa2-0xbf range that you just carved out
> here, right?  Where did those numbers come from?

Correct. For now we are just using 0xa0 and 0xa1, and eventually we
might need more ioctls numbers.

I got these numbers finding a unused block and having some room for
expansion, as suggested by Documentation/userspace-api/ioctl/ioctl-number.rst,
that says:

	If you are writing a driver for a new device and need a letter, pick an
	unused block with enough room for expansion: 32 to 256 ioctl commands.

