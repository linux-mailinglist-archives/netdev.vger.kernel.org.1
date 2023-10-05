Return-Path: <netdev+bounces-38372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9097BA9A2
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C2E82281BED
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6784120E;
	Thu,  5 Oct 2023 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buJHvxF7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD2262A7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:59:07 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C2A6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:59:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so2415670a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696532344; x=1697137144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lR9kBzP4HzmUYL7oxiYPmG/L3XFvdQlr5bxMwqJhBo=;
        b=buJHvxF7NAmqGaUcBU99d/RKj+x2ZyOZ0YJ6THx0tg0WlhmlxhJh06TZj5BgaX+Wns
         DZcegxGlG76g+YN+cnTBisgv+9anblFlQwHLNKn/uJPa+osZVyqywodvXeF/hPhyFq7m
         5rDPXHKZYNDSsJFY6b1swrsn7ozLhf3eTsnE5i+wLWxdGyU0ccPiWxG6W4QzbOe45sru
         2F+o6HkDSgYDx5U2MYQcnqLlRzHYP6PbNp4Mknl1varWW/fWbAHTOjhRN3MXxiSEyRnc
         g10Y3QjzIK31HdtLaCImViHmDpcwQWcfVJcE2ErEEMLC9iHUc+DhMKZSN7fBbFzaGUYl
         FP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696532344; x=1697137144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lR9kBzP4HzmUYL7oxiYPmG/L3XFvdQlr5bxMwqJhBo=;
        b=JviwFSfLJV0qwST92DblOtx0fWqwDSB6dbhZ90yjVY98bRkJz1pZW671uLhpXYAGBa
         H41bQXiHXdps2xHvUtUIgXl49c/Ohh4z82gFAMPYURGTJimFYAzOPHEDZvP0LNnK5BUU
         ybeiwVpCoMmqGzKZNRAkC9QAO0Az4fDd3HMDKDgmj/MGnTSoDvK61eZN1KzLYqJRDzLK
         Ud7MuA3Ybhyy/aMGfqjyg9aM+OGBLvlrm/Bs5BbDvNaMge7wpkirjBF05zdEXLnpiFCk
         MZ2hvm0znPS29zY0qJZqOJ0sQ9WA++nNFELZL3e6KQmpDllKyv0qAkJYApO73667Q1S7
         Ormw==
X-Gm-Message-State: AOJu0Yzf3gAgkp3ayGzjs+7iIYAU9cTkzKaSyoc0dBS5AcICAzABqX/8
	0aPkd7IK/PMII6Qz2HB0C7REhrsz7P0BuN8Vb+6Mng==
X-Google-Smtp-Source: AGHT+IEFH4brKmq5pHVpkJEk98f2RRO4OH1zEacEcaOm281UdKlMPYvOelyoZBG1kY/93jVKQuOQgexasPYGRQ3k2HY=
X-Received: by 2002:a05:6402:b35:b0:530:7ceb:334 with SMTP id
 bo21-20020a0564020b3500b005307ceb0334mr5340216edb.3.1696532344568; Thu, 05
 Oct 2023 11:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com>
 <202310041959.727EB5ED@keescook> <202310042201.7B14CA59@keescook> <984bcd4d-627e-7d26-2a50-73607ea0eecd@intel.com>
In-Reply-To: <984bcd4d-627e-7d26-2a50-73607ea0eecd@intel.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 5 Oct 2023 11:58:52 -0700
Message-ID: <CAFhGd8rN3WwXPxh6SZokJk1M03Z9b5JdiUJ9ObRyCkOksMzJBQ@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: lan9303: replace deprecated strncpy with memcpy
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <keescook@chromium.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 7:54=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Kees Cook <keescook@chromium.org>
> Date: Wed, 4 Oct 2023 22:02:00 -0700
>
> > On Wed, Oct 04, 2023 at 08:07:55PM -0700, Kees Cook wrote:
> >> On Thu, Oct 05, 2023 at 12:30:18AM +0000, Justin Stitt wrote:
> >>> `strncpy` is deprecated for use on NUL-terminated destination strings
> >>> [1] and as such we should prefer more robust and less ambiguous
> >>> interfaces.
> >>>
> >>> Let's opt for memcpy as we are copying strings into slices of length
> >>> `ETH_GSTRING_LEN` within the `data` buffer. Other similar get_strings=
()
> >>> implementations [2] [3] use memcpy().
> >>>
> >>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#=
strncpy-on-nul-terminated-strings [1]
> >>> Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband=
/ulp/opa_vnic/opa_vnic_ethtool.c#L167 [2]
> >>> Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband=
/ulp/ipoib/ipoib_ethtool.c#L137 [3]
> >>> Link: https://github.com/KSPP/linux/issues/90
> >>> Cc: linux-hardening@vger.kernel.org
> >>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> >>> ---
> >>> Note: build-tested only.
> >>> ---
> >>>  drivers/net/dsa/lan9303-core.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303=
-core.c
> >>> index ee67adeb2cdb..665d69384b62 100644
> >>> --- a/drivers/net/dsa/lan9303-core.c
> >>> +++ b/drivers/net/dsa/lan9303-core.c
> >>> @@ -1013,8 +1013,8 @@ static void lan9303_get_strings(struct dsa_swit=
ch *ds, int port,
> >>>             return;
> >>>
> >>>     for (u =3D 0; u < ARRAY_SIZE(lan9303_mib); u++) {
> >>> -           strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> >>> -                   ETH_GSTRING_LEN);
> >>> +           memcpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
> >>> +                  ETH_GSTRING_LEN);
> >>
> >> This won't work because lan9303_mib entries aren't ETH_GSTRING_LEN-lon=
g
> >> strings; they're string pointers:
> >>
> >> static const struct lan9303_mib_desc lan9303_mib[] =3D {
> >>         { .offset =3D LAN9303_MAC_RX_BRDCST_CNT_0, .name =3D "RxBroad"=
, },
> >>
> >> So this really does need a strcpy-family function.
> >>
> >> And, I think the vnic_gstrings_stats and ipoib_gstrings_stats examples
> >> are actually buggy -- they're copying junk into userspace...
> >>
> >> I am reminded of this patch, which correctly uses strscpy_pad():
> >> https://lore.kernel.org/lkml/20230718-net-dsa-strncpy-v1-1-e8466474771=
3@google.com/
> >>
> >> I think you want to do the same here, and use strscpy_pad(). And perha=
ps
> >> send some fixes for the other memcpy() users?
> >
> > Meh, I think it's not worth fixing the memcpy() users of this. This
> > buggy pattern is very common, it seems:
> >
> > $ git grep 'data.*ETH_GSTRING_LEN' | grep memcpy | wc -l
> > 47
>
> We have ethtool_sprintf() precisely for the sake of filling the Ethtool
> statistics names.
>
> BTW this weird pattern "let's make the array of our stats names of fixed
> width (ETH_GSTRING_LEN), so that we could use memcpy() instead of
> strcpy()" was pretty common some time ago, no idea why, as it wastes
> memory for tons of \0 padding and provokes issues like the one you
> noticed here.

Just sent a v2 using ethtool_sprintf(). I'd appreciate some feedback on if =
I
used it correctly.

>
> >
>
> Thanks,
> Olek

[v2]: https://lore.kernel.org/r/20231005-strncpy-drivers-net-dsa-lan9303-co=
re-c-v2-1-feb452a532db@google.com

Thanks
Justin

