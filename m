Return-Path: <netdev+bounces-223026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7761B5798D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4164E16D279
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80E3043C4;
	Mon, 15 Sep 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JkBXfelQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93E27A124
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937439; cv=none; b=hylYGMh4EvNhUkvN+Z3Pn51LIm6IjMSNHudQRhMMt0GIWL/FSzdrc9r5HPwC6izYNgJvLOyltSHD/c87BsbM6qgHylj6rYIsDKatoFAU0h4PTDpLZEahhTrDq31YX5J3kAQGjHEYjnY1RPKfmJgjSapR0OWXh1E7rlSHvHqiMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937439; c=relaxed/simple;
	bh=4iIsT/e0SkZkgz6cT/6zDmKcSsAO4TPDDaXg4J888mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUZHVaOAWSU+PMZboI58awDnq+cGs19czfH5thmqFlG0u6Y72Y9Sfq+cAFAYwtl+7rD1UVQ8gFyFPLb4KUHK3nP6Ux4ev0r1kaAAQMXJaQSgJfEunBdMRj2ObDl4VvCyQlsWyrcURVmWeV3pISsX0czi8v31erjhTD+zRBfCTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JkBXfelQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-329b760080fso4017365a91.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 04:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757937437; x=1758542237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGJm8DYIvDlO/KkwD8vnmqae7TgyeCejeZ/3X9vddjo=;
        b=JkBXfelQjExfOkJuzaIYeCjBy61YbFf13yL15Io6y8wBOlMz71sU0OrKiNNIjkIh9r
         lFqVlkQTjQsa4D7hvpa4n2FRtW4MxUk/o6aQ61qUseCTBVi8e6ai1wxAm9IAIaW8i0mQ
         0+NYaQ0IPIbY+ukY6/xRngxrjkrJucjGWyRoCWrBscnGOiAWMN3mvNKpf5NV2OE8Jwar
         UBh0VGs51hbKq6+FA9Q3fyY6iRk2wQbjLhVo4H3ItjchqwFfiRq7U3rvEY6gKrwW6GvO
         s5m9crVN6zy8MtrX6pWIPy7rIXaTD4DSLl2b+1zI4q0s/X9ZpxrNBtASPMVIr7kY3jDl
         q5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757937437; x=1758542237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGJm8DYIvDlO/KkwD8vnmqae7TgyeCejeZ/3X9vddjo=;
        b=Eqs04F1BYiitnGaBrPsMOqjqAeNVeipkPtZ18Db1JivRWLJgTYscKjEk+wyzvkmJ9F
         05S04wZtG6+bU4pjwZ26oHZcg9Apx8ju8CnaDzyHDubZEFWeBNCWalKkL+lHGhRtMdko
         0ey8l9YPXJ6Cfp6a8WGlnvqiDBQI48DUZfdIHo77LeQ3rU0Kt8W2cdVDa9HLMFypYbwf
         yGJ+D5stQUjLZCWCeTS4xmO32/w3oYmKjufuWKY48NRqxPoH7mHc+KukNGYYX/V+ltkE
         JiJx8oI3GiMBtnSPAY28yi0K/LeUQPWg3KKutg25+8OrnLJA9ctnLdSBZNFzSTgWswPz
         Xk1g==
X-Gm-Message-State: AOJu0Yx654HQL24LlFZkkTplTBoD1Ur8WsdP2LzH4kt9UWA2S21Phrnj
	CQ1lu81Hw0yy2ZaIxk2vUjxBFYIavK7M3ARHcOB/3sUbcCggl8utZd0qR+/cxELoanlyfHfOLVL
	IGdEU8Q76M1KoFYdL5W2zQn89fOtpYaH4BZv16oDTnw==
X-Gm-Gg: ASbGncu22gSmciwFIGZ2MkR8q2aEVGQLCk3eAsLD8a9Bj0tJTp9MxVqq3TojtKjDomT
	G3Ww7WyYkMF3/VROw/fRhf/fo1MYIvYgHMuoMoF+fK9CyvH/spLU/dA8hAOAcw29+8bztNlgGDr
	lTvk3tvzDDo/iUw4qnqxElVCcA1MiwQQ/bvnSBAg9BcQFFim7sW1Gqe1dqEkn54MdC/LDwMDmVu
	VWMkwg6AvYmkWssRszkBruP3Q8=
X-Google-Smtp-Source: AGHT+IHC9MtMM4aoht490pTslenJiMyVWixD64PNiClIAKHESGsSGqs2QzKXHaL4Reakb94ywmWjqmzVBmseZb4+OWE=
X-Received: by 2002:a17:90b:3810:b0:32e:749d:fcb4 with SMTP id
 98e67ed59e1d1-32e749dff67mr2285280a91.6.1757937436607; Mon, 15 Sep 2025
 04:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912034538.1406132-1-zhangjian.3032@bytedance.com> <4a639a86-37e2-4b3d-b870-f85f2c86cb81@lunn.ch>
In-Reply-To: <4a639a86-37e2-4b3d-b870-f85f2c86cb81@lunn.ch>
From: Zhang Jian <zhangjian.3032@bytedance.com>
Date: Mon, 15 Sep 2025 19:57:05 +0800
X-Gm-Features: AS18NWBh34xROiv3qqyYwXVx8rfGAbuctXdOp2l0uDfwsHFQdd4X0dtuYdgDNtM
Message-ID: <CA+J-oUvsnovtMGKVAWnw-eG6SZvNZLEOsf-8zp6BEwzq4_wvhw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] Revert "drivers/net/ftgmac100: fix
 DHCP potential failure with systemd"
To: Andrew Lunn <andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch, 
	guoheyi@linux.alibaba.com, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 4:25=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Sep 12, 2025 at 11:45:38AM +0800, Jian Zhang wrote:
> > This reverts commit 1baf2e50e48f10f0ea07d53e13381fd0da1546d2.
>
> > * rtnetlink is setting the link down
> > * the PHY state_queue is triggered and calls ftgmac100_adjust_link
> > -     /* Release phy lock to allow ftgmac100_reset to acquire it, keepi=
ng lock
> > -      * order consistent to prevent dead lock.
> > -      */
> > -     if (netdev->phydev)
> > -             mutex_unlock(&netdev->phydev->lock);
> > -
> > -     ftgmac100_reset(priv);
> > -
> > -     if (netdev->phydev)
> > -             mutex_lock(&netdev->phydev->lock);
> > -
> > +     /* Reset the adapter asynchronously */
> > +     schedule_work(&priv->reset_task);
> >  }
>
> So we are swapping one set of bugs for another set of bugs.
>
Yes, If the full reset is necessary.
In commit 855944ce1cc4 (=E2=80=9Cftgmac100: Add a reset task and use it for
link changes=E2=80=9D, about 8 years ago)
it was mentioned that a full hardware reset is required, and it also
notes that the rtnl lock is held.

> No other adjust_link callback messes with locks like this.  Have you
> investigated what actually needs to be done by adjust_link?
>
> Determining maccr in ftgmac100_reset_and_config_mac() look relevant.
> Does it actually need a reset, or is it sufficient to just set the
> bits in FTGMAC100_OFFSET_MACCR?
>

I checked most drivers=E2=80=99 adjust_link callbacks, and they basically o=
nly
write to a few MAC controller registers.
I also tried calling only `ftgmac100_reset_and_config_mac` and did
some tests, the network works fine
but I=E2=80=99m not sure this change is correct, which is why I wanted to
revert to the previous code.

> ftgmac100_config_pause() is called from ftgmac100_set_pauseparam()
> suggesting it can be called at any time.
>
> So i think the crux of the problem is what needs to happen to set bits
> in MACCR.
>
Yes, I think so too. However, here we just need to do some necessary
register configurations,
and that should be sufficient.

Hi Jacky;

I=E2=80=99m not sure if you=E2=80=99re familiar with these, Could you give =
us some suggestions?

>         Andrew
Jian

