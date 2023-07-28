Return-Path: <netdev+bounces-22225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A777669B8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFD1281E25
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE111192;
	Fri, 28 Jul 2023 10:03:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F18D300
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C66C433CB;
	Fri, 28 Jul 2023 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690538617;
	bh=Mwb3geMIex9bief6/MfEaJk/1F/fz+2cfnXdqIIS7kA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tXpHkr01M64W1DlXlgN/uXAgQO8lbyiEuO9Cf0SA6Q2RwpJdglx+2A0vRRYDmqeFx
	 QkTSlvyPqmqL5v2RGTmtZIQCphoyH1AMpe/MzjMnZbgbsn7ANvRddsPz5dfpMpeuOG
	 6l12lZNR0KLb31OrfsB25kBIZZCHOOCZrMFkKSzf3Sn9GeITMm80WpBC25fbo/MeiH
	 Is2QOewf3opADVOZGSDdpl0GZlOCa0klQ0zI98I6Yqddd2IP316tAkQeY8FyfGyUD1
	 jRK4ZYBZDSKe9POSmHbsNwVOrkLU/PqrDqdXT/BM+hMIHzatm8aiKxo28ex5ebGkj2
	 BmUzcKu/wrcCA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so29495181fa.1;
        Fri, 28 Jul 2023 03:03:37 -0700 (PDT)
X-Gm-Message-State: ABy/qLa+PG976yRFusus4rZkBckoUUNOGEQke7u4ZF94NVHHGgq6Qh24
	LZ4/M/ZXyggUPjkwVZqfgTAwkLeLvUo49kclMVs=
X-Google-Smtp-Source: APBJJlFx+dQYWLD4Q57imF/9JvEvN5dBgTWOloOyttLP1mjqjiHeaGuGhb9mmggYpjQLqdnp9xDE77NZuZ6h+uNdIwc=
X-Received: by 2002:a2e:828f:0:b0:2b7:7c:d5a1 with SMTP id y15-20020a2e828f000000b002b7007cd5a1mr1160535ljg.23.1690538615123;
 Fri, 28 Jul 2023 03:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <ZMOQiPadP2jggZ2i@gondor.apana.org.au>
 <CAMj1kXFRAhoyRD8mGe4xKZ-xGord2vwPXHCM7O8DPOpYWcgnJw@mail.gmail.com> <ZMORcmIA/urS8OI4@gondor.apana.org.au>
In-Reply-To: <ZMORcmIA/urS8OI4@gondor.apana.org.au>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 28 Jul 2023 12:03:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFnr64b7SA1zYvSOrXazdH_O5G=i4re=taQa9hAeRbh-w@mail.gmail.com>
Message-ID: <CAMj1kXFnr64b7SA1zYvSOrXazdH_O5G=i4re=taQa9hAeRbh-w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] crypto: consolidate and clean up compression APIs
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Haren Myneni <haren@us.ibm.com>, Nick Terrell <terrelln@fb.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	Richard Weinberger <richard@nod.at>, David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, qat-linux@intel.com, 
	linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Jul 2023 at 11:59, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jul 28, 2023 at 11:57:42AM +0200, Ard Biesheuvel wrote:
> >
> > So will IPcomp be able to simply assign those pages to the SKB afterwards?
>
> Yes that is the idea.  The network stack is very much in love with
> SG lists :)
>

Fair enough. But my point remains: this requires a lot of boilerplate
on the part of the driver, and it would be better if we could do this
in the acomp generic layer.

Does the IPcomp case always know the decompressed size upfront?

