Return-Path: <netdev+bounces-18675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6B758417
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6698E280FE2
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB016403;
	Tue, 18 Jul 2023 18:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0915AFD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578FDC433C7;
	Tue, 18 Jul 2023 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689703530;
	bh=T+w+JLxHTVEHg9YoBJPgRg++YjqipJExjPFcJ7KLG90=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VoBZ33Vs92ylWT9T7sZf2UoOU87pYyxQWD0ywrg8+cx0wJ3EU5VXUnNZu5w2GJy55
	 Tnr2qxqvCca3Nx5BnHqwbUV+TL8oln/PKoGy9f4Qa0i+10gwrHFRly2faxq/r0alb8
	 1SzUagNlLnVxl5ku69sfaE8l4/OXvL5k/IcHatGcxKpxDKAZ85/6w1xtMesefGZMF3
	 6PQwGUuRGSRaBd7sQw0tpfpGehvw/6jyjgWz7QndOsZJpBma1joPhhheDk6NCuJrrq
	 BYXcQMCi8lAiUnAnQnJte4sfUqz5EFBOF+a39oH/jg6fA8Ytmw51ggIzA4tUB8+51d
	 F5VZ2YCn1Y8Zw==
Date: Tue, 18 Jul 2023 11:05:23 -0700
From: Kees Cook <kees@kernel.org>
To: justinstitt@google.com, Justin Stitt <justinstitt@google.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kees Cook <keescook@chromium.org>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] net: dsa: remove deprecated strncpy
User-Agent: K-9 Mail for Android
In-Reply-To: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
Message-ID: <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 17, 2023 5:04:19 PM PDT, justinstitt@google=2Ecom wrote:
>`strncpy` is deprecated for use on NUL-terminated destination strings [1]=
=2E
>
>Even call sites utilizing length-bounded destination buffers should
>switch over to using `strtomem` or `strtomem_pad`=2E In this case,
>however, the compiler is unable to determine the size of the `data`
>buffer which renders `strtomem` unusable=2E Due to this, `strscpy`
>should be used=2E
>
>It should be noted that most call sites already zero-initialize the
>destination buffer=2E However, I've opted to use `strscpy_pad` to maintai=
n
>the same exact behavior that `strncpy` produced (zero-padded tail up to
>`len`)=2E
>
>Also see [3]=2E
>
>[1]: www=2Ekernel=2Eorg/doc/html/latest/process/deprecated=2Ehtml#strncpy=
-on-nul-terminated-strings
>[2]: elixir=2Ebootlin=2Ecom/linux/v6=2E3/source/net/ethtool/ioctl=2Ec#L19=
44
>[3]: manpages=2Edebian=2Eorg/testing/linux-manual-4=2E8/strscpy=2E9=2Een=
=2Ehtml
>
>Link: https://github=2Ecom/KSPP/linux/issues/90
>Signed-off-by: Justin Stitt <justinstitt@google=2Ecom>

This looks fine to me=2E I think the _pad variant is overkill (this region=
 is already zero-initialized[1]), but it's a reasonable precaution for robu=
stness=2E

Honestly I find the entire get_strings API to be very fragile given the la=
ck of passing the length of the buffer, instead depending on the string set=
 length lookups in each callback, but refactoring that looks like a ton of =
work for an uncertain benefit=2E

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>

-Kees

[1] https://elixir=2Ebootlin=2Ecom/linux/v6=2E3/source/net/ethtool/ioctl=
=2Ec#L1944


--=20
Kees Cook

