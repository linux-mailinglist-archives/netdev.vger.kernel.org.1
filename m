Return-Path: <netdev+bounces-50551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2517F6155
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AE1281B85
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1522FC42;
	Thu, 23 Nov 2023 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myCexJJ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD892FC3B;
	Thu, 23 Nov 2023 14:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46714C433C8;
	Thu, 23 Nov 2023 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700749481;
	bh=J/LtgofwEQkoiVQZqoNXaJ9BMFsu3JjYY9qmjaMQE74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myCexJJ1T1cKOvaXEHq4wweMQTiZAHJaQIpqITF2nz0OF3uoL1iwYojYKJkw4PYVR
	 QfcDimY0ygH2HZrSIyCxQrHtsuFSlRQPO8OTFSPPOPD7jiDp1jBKsun38Rr4JNnKp/
	 BmWkp+sMWRtw61zy6k1ytLqHhl3Q4c0zvaTAIWfuyGnDaFrnmulhvIfl/FxaSg01uJ
	 vrKGenvAmwgayiPxnrogPgWdPV/BSA74uwa6+96sgKUQMzWHo9r/72hHKGaYMFypuP
	 Tziu/KwbkQbvBfy4JH+YRTGybdW4tL5tlgZkmLy3GB1lSUmdmnybhceCeyVupWJV6p
	 pdxhlPoo5kacQ==
Date: Thu, 23 Nov 2023 14:24:35 +0000
From: Simon Horman <horms@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Grant Grundler <grundler@chromium.org>,
	Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] r8152: Add RTL8152_INACCESSIBLE checks to more loops
Message-ID: <20231123142435.GG6339@kernel.org>
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
 <4fa33b0938031d7339dbc89a415864b6d041d0c3.camel@redhat.com>
 <CAD=FV=VALvcLr+HbdvEen109qT3Z5EL0u4tiefTs3AH8EHXFnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VALvcLr+HbdvEen109qT3Z5EL0u4tiefTs3AH8EHXFnA@mail.gmail.com>

On Tue, Nov 21, 2023 at 09:55:46AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Tue, Nov 21, 2023 at 2:28 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> > > Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
> > > the driver. There are still a few more that keep tripping the driver
> > > up in error cases and make things take longer than they should. Add
> > > those in.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > I think this deserves a 'Fixes' tag. Please add it.
> 
> Sure, I can add it. It didn't feel worth it to me since there's no
> real functional issue--just that it takes a little longer for these
> loops to exit out, but it shouldn't hurt. I guess that means breaking
> this commit into several depending on when the offending loop was
> added.
> 
> 
> > Additionally please insert the target tree in the subj prefix when re-
> > postin (in this case 'net')
> 
> Funny, I just followed the tags for other commits to this file and the
> "net:" prefix isn't common. I guess this should be "net: usb: r8152".
> I can add it when I post v2.

Hi Doug,

unfortunately prefix can have more than one meaning here.
The target tree, often either net or net-next, should go
in the [] part of the subject.

In this case I think what you want is:

	[PATCH net n/m v2] Add RTL8152_INACCESSIBLE checks to more loops

