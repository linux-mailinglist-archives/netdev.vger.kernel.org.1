Return-Path: <netdev+bounces-46694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 074087E5E63
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 20:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0ACB20D9E
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948F636B14;
	Wed,  8 Nov 2023 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq2cqxMf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E237148
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 19:11:44 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB3B2118
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 11:11:43 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7bac330d396so2726057241.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 11:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699470703; x=1700075503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvZPmDGATvEjEM/hxNaayOVt/rInopENNaYbfcKzNig=;
        b=eq2cqxMfb4PBZUTGfkRHZeNtzo9vhUacLblqT9D5ez1lbAyzwGR5PA+ApohQdqiTet
         nzT5p7hrj/dA1FFcDmz4o2pNIJvKNiD0vpyJgmXRlM3B5TGEcrZAPjnOj4VfqcBsaq9T
         0qefx4NY+/gJlKLxJdHGisvZWdXx8kB7LE1IeuftUubI4blNf3zXqIMh4SSStcD2D/qD
         zNXjQpeMZLFenVJukVH26VPL3UHSpwXsFRKJXAkWbJkKtuoyS5SYn9PhFv2rDHgw8FRL
         oSlElK34H36ZYELxZXKXFy1Ll//02eravY1gwyOuw8gczAiH3hiZwNLiR+LajhAD7mbe
         o1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470703; x=1700075503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvZPmDGATvEjEM/hxNaayOVt/rInopENNaYbfcKzNig=;
        b=Di+mp2pN1rT+RU0l73/92saMLJoXVtYGCNFaCBKmbYOgfXnPkcVnp3Rz5EePb4MtJd
         /bxIEm2f8WTZo3AYddU622Yme74CfXdH7uzFoUXfomYIrRLjmvd1swg1kkagKAKSsR6J
         jNv5sRDp7D+VyxaoyCss1i6AZQZ9dpxhh/TowTvcCbN2KwOuk9J564uUYTJEr1BYINLD
         V7L3H1MsNT2cDB7M+mSd6w/zvLT4asboc3iqa6cXWg/V+pEhCtyCn9gEhSrszmEBsaOT
         p68jO5XFoiGgL6FQvI39JQUoUdXjChf4C/zaIB2JjmPmpYen4R96QCoijpZmoiNZHfxl
         za8Q==
X-Gm-Message-State: AOJu0YztYbeYgrjnKgTuX0dJhBCW5of75QT0pyKaySOSnI2abnLhsU4i
	r31bZrePfTKbBOaS63DtKsi5Ig4CMLbPFmiAFM0=
X-Google-Smtp-Source: AGHT+IGG3m7Xyzg20D1khpxeMVwESZRNNKwz5ozvITwqHaElHoH5sy8H/x+VpglcVkr/x5E6mJGHrwWl5r9NMp9eTao=
X-Received: by 2002:a67:c29c:0:b0:45d:9113:328f with SMTP id
 k28-20020a67c29c000000b0045d9113328fmr2590119vsj.34.1699470702726; Wed, 08
 Nov 2023 11:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jzqsld6q.fsf@cloudflare.com> <CAF=yD-+GNV_1HLyBKGeZuVkRGPEMmyQ4+MX9cLvyC1mC9a+dvg@mail.gmail.com>
 <87fs1gkthv.fsf@cloudflare.com>
In-Reply-To: <87fs1gkthv.fsf@cloudflare.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 8 Nov 2023 14:11:05 -0500
Message-ID: <CAF=yD-LFk+sydbT4k8DE1HNf7QLx1WxvEabnejENeJ9A5fKOmA@mail.gmail.com>
Subject: Re: EIO on send with UDP_SEGMENT
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 1:08=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Wed, Nov 08, 2023 at 10:10 AM -05, Willem de Bruijn wrote:
> > On Wed, Nov 8, 2023 at 6:03=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
>
> [...]
>
> >> Do you think the restriction in udp_send_skb can be lifted or tweaked?
> >
> > The argument against has been that segmentation offload offers no
> > performance benefit if the stack has to fall back onto software
> > checksumming.
>
> Interesting. Thanks for sharing the context. Must admit, it would have
> not been my first guess that the software GSO+checksum itself is not
> worth it. Despite it happening late on the TX path.

The heuristic is that checksum during copy_from_user is cheap, while
checksum after qdisc dequeue might have to read cold memory.

There will be cases where the data is warm. So YMMV. But that is the
basis for the choice.

