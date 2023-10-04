Return-Path: <netdev+bounces-38069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40317B8DE2
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 762332817A7
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605E224D4;
	Wed,  4 Oct 2023 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JQ6OejVV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5A721A1A
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:12:35 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D271A6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:12:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bdcade7fbso41240966b.1
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 13:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696450351; x=1697055151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmwpd1CMBj/zW0Pr+iJ9G2UH6hQACRNF8JDThDi5kTM=;
        b=JQ6OejVVMLR3XZmTp8Y5z1me/wSNEfARN+RnNYxVW7Ibb6Onjv1vDUtQ7UTRuX3PDq
         3ZSPgSjAY7A5nMTktYnaxDD8i5JRA6zpl5sW5lxFsWwMeaIi2l0vIo2XGx+96UZY1pM2
         TxuGHuJ2vozhUtnEBiQaeS4dheph2HGHDYZFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450351; x=1697055151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmwpd1CMBj/zW0Pr+iJ9G2UH6hQACRNF8JDThDi5kTM=;
        b=SQV1Rn3XmRl+My+OHVFb6l03q6LA9UzEHFZrixXocfYntLwzFfdQf0XQU3FrmeXoNR
         g3RbR/5wIrz1o+YvI/vRfhKLxn4Fdn190JpvXvH3jvwyfrg+2JfktSgv6J/C3CZdNpFn
         a8mXAZriXO+tUO34SPvz0tTVnlZqni4nkzZK8PIHBd33X8uMXl1zmGMZ8VkAKAd49Fu0
         b72ywLHmvPexmlzSRL3278CAICvhez/7NxdQjdfkp81FBnTfMJaE7DNk5h2uNglTEhyd
         7LDX2og/Mg0WZLfQlbqiOhm6dCwljxfGoi/mydAFktqEzbsgxKH0tH2WRTY5FEyvf7dL
         HmmQ==
X-Gm-Message-State: AOJu0YzlRUmtPdaTiDj7mY6zikgR2KUP2t7PhHs6TIr1gvQu9EN4maNh
	vxn1k6z43Tji5mfl3eSVoxDD0gAIEcF1gw/O7QVE+pus
X-Google-Smtp-Source: AGHT+IH10+8+iyU+pdjdOPlJMvWxKRUlTTjlIB4YsjvEbaPuAzSEVsUwvyfBgGrl9x8eHOIeuKYCoA==
X-Received: by 2002:a17:907:7897:b0:9ae:3c6c:6ecd with SMTP id ku23-20020a170907789700b009ae3c6c6ecdmr3264754ejc.19.1696450351050;
        Wed, 04 Oct 2023 13:12:31 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709063c4700b0098884f86e41sm3289953ejg.123.2023.10.04.13.12.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:12:30 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so298a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 13:12:30 -0700 (PDT)
X-Received: by 2002:a50:d64b:0:b0:538:1d3a:d704 with SMTP id
 c11-20020a50d64b000000b005381d3ad704mr423edj.1.1696450350049; Wed, 04 Oct
 2023 13:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004192622.1093964-1-dianders@chromium.org> <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
In-Reply-To: <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Oct 2023 13:12:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKe33R0z-Qu32F2q4eHdwox88oTprgvDf_bMJZcBM+hQ@mail.gmail.com>
Message-ID: <CAD=FV=UKe33R0z-Qu32F2q4eHdwox88oTprgvDf_bMJZcBM+hQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] r8152: Block future register access if register
 access fails
To: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>, 
	"David S . Miller" <davem@davemloft.net>
Cc: linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, 
	Grant Grundler <grundler@chromium.org>, Edward Hill <ecgh@chromium.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Wed, Oct 4, 2023 at 12:27=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Even though the functions to read/write registers can fail, most of
> the places in the r8152 driver that read/write register values don't
> check error codes. The lack of error code checking is problematic in
> at least two ways.
>
> The first problem is that the r8152 driver often uses code patterns
> similar to this:
>   x =3D read_register()
>   x =3D x | SOME_BIT;
>   write_register(x);
>
> ...with the above pattern, if the read_register() fails and returns
> garbage then we'll end up trying to write modified garbage back to the
> Realtek adapter. If the write_register() succeeds that's bad. Note
> that as of commit f53a7ad18959 ("r8152: Set memory to all 0xFFs on
> failed reg reads") the "garbage" returned by read_register() will at
> least be consistent garbage, but it is still garbage.
>
> It turns out that this problem is very serious. Writing garbage to
> some of the hardware registers on the Ethernet adapter can put the
> adapter in such a bad state that it needs to be power cycled (fully
> unplugged and plugged in again) before it can enumerate again.
>
> The second problem is that the r8152 driver generally has functions
> that are long sequences of register writes. Assuming everything will
> be OK if a random register write fails in the middle isn't a great
> assumption.
>
> One might wonder if the above two problems are real. You could ask if
> we would really have a successful write after a failed read. It turns
> out that the answer appears to be "yes, this can happen". In fact,
> we've seen at least two distinct failure modes where this happens.
>
> On a sc7180-trogdor Chromebook if you drop into kdb for a while and
> then resume, you can see:
> 1. We get a "Tx timeout"
> 2. The "Tx timeout" queues up a USB reset.
> 3. In rtl8152_pre_reset() we try to reinit the hardware.
> 4. The first several (2-9) register accesses fail with a timeout, then
>    things recover.
>
> The above test case was actually fixed by the patch ("r8152: Increase
> USB control msg timeout to 5000ms as per spec") but at least shows
> that we really can see successful calls after failed ones.
>
> On a different (AMD) based Chromebook with a particular adapter, we
> found that during reboot tests we'd also sometimes get a transitory
> failure. In this case we saw -EPIPE being returned sometimes. Retrying
> worked, but retrying is not always safe for all register accesses
> since reading/writing some registers might have side effects (like
> registers that clear on read).
>
> Let's fully lock out all register access if a register access fails.
> When we do this, we'll try to queue up a USB reset and try to unlock
> register access after the reset. This is slightly tricker than it
> sounds since the r8152 driver has an optimized reset sequence that
> only works reliably after probe happens. In order to handle this, we
> avoid the optimized reset if probe didn't finish.
>
> When locking out access, we'll use the existing infrastructure that
> the driver was using when it detected we were unplugged. This keeps us
> from getting stuck in delay loops in some parts of the driver.
>
> - Reset patch no longer based on retry patch, since that was dropped.
> - Reset patch should be robust even if failures happen in probe.
> - Switched booleans to bits in the "flags" variable.
> - Check for -ENODEV instead of "udev->state =3D=3D USB_STATE_NOTATTACHED"

Argh, the above 4 bullet points were supposed to get moved "after the
cut" and describe the differences between v1 and v2. Sorry! :(

To avoid spamming people, I won't send another version and will wait
for feedback. I'm happy to fix and send a new version at any time,
though.

