Return-Path: <netdev+bounces-16298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1893774C957
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 02:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0689A281014
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 00:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E510E6;
	Mon, 10 Jul 2023 00:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B00EDC
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 00:55:38 +0000 (UTC)
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E7511B
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688950536; x=1720486536;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=byXT/xFmqDD+CZsNnq9g4TTQ5FLhdllwCHHpJVlkyxA=;
  b=TrJ+Gjx1ICwmBMYGI7486j2DNmPQcTBMaXqf2zYca0oyi+yPqyZeBvTb
   +/2ohR/dBuiYlTYLi9lObJYNHg9eg0f4dZeTqLF3bhtGJv7xY9MbTnYtV
   8UdfdySTXWNLGOzsaHn58iIv4WdsxB5b3IT9dQqIMG8QZV+yN+5DUWuDf
   9Y20+L0APbbx8qVd+vox5zHx7ZiegnGIFOZh+Bxc8Ha990sBq+Qcv/JmH
   xqXbC3RwZvVauZpdKT3EojLej4GJ7f2tQDYy+uGdU15bc1MxTF32+C+yS
   RtteJ6MPHjlNvVsQcXkn3YtH9fWwOHP3+8S9wEAF+deHxpzPi4VqyD0xb
   Q==;
Received: from mail-wr1-f72.google.com ([209.85.221.72])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2023 17:55:35 -0700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3143c9a3519so2729526f8f.2
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 17:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688950533; x=1691542533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCDKDJuhMe/luM3VFI5ib+K9xMOi0C+lL24R61nDELU=;
        b=E5yAXUur4ozLmLijl5wf9gsUVFry5Mi0buAfkkuxU82pMwaEK+nEGz82sa1z22nFTy
         0lpTFvX9C4wxp3OJSS3qu5i3WphSDO3hRNERLr6Qx0iHQuPodZxlxgLrDoMh1TY802Zc
         UKVKywJVkXqSjMCyFwhF03VBq6XtA1iRWSzSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688950533; x=1691542533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCDKDJuhMe/luM3VFI5ib+K9xMOi0C+lL24R61nDELU=;
        b=kPgtTBZd/ux1H8mT5XD/FKk1JtqIImk0uS9R99Yw++JCk/K6K1D6pArBH4Hoiq9ryh
         HexuSFEbHXa2WM7uK5cx2w1WOkD0EYa/Xm4oZ8++kIJtj5NBNXRrWv+n6yKfDn1/O8Z6
         fX70QAjZWDxmJI2gNIXmG06yzEmRH8sgPGqbu7cags4ITafJsf9fo2/j1Ss6JnTC7lPX
         KFlMEun1w6R1i95/p+Q3P8fRmerrZ8RDNENmR+QyNuDUCJmAVoQQNheLPzMClU3kQel1
         JHNJfFAm9U9RWVHhV8/lgHOTDeBiLpeMx7YQdHBda5B2HjooMGOJvw1VnD74NOTmnMu1
         sysg==
X-Gm-Message-State: ABy/qLazJiVxD60ODFFfTMVQ5CXpL6cVaYvUVZP62OiHRuFiWbzAEIxh
	LQi+MeY75nUfkt/aEnL1UisBCeQPRcTDKlOwAec97I7VwuFqI8R6rr70zSAPSjhCDr4TPKfu1bD
	yQyjGVK5WbOjhOjfNIvukT5wTkjRYbTW3XK0Uc/rUamny
X-Received: by 2002:a05:6000:100d:b0:313:ef24:6ff2 with SMTP id a13-20020a056000100d00b00313ef246ff2mr12720810wrx.2.1688950533265;
        Sun, 09 Jul 2023 17:55:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF77PbPgC2orYPAxraE+vB+6gHcJRG+ezUH+qNiru1V7ZNzxhdB+WTVUrRGi5UhCucCnyJwvy3hOvQxpdaOpKo=
X-Received: by 2002:a05:6000:100d:b0:313:ef24:6ff2 with SMTP id
 a13-20020a056000100d00b00313ef246ff2mr12720796wrx.2.1688950532984; Sun, 09
 Jul 2023 17:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+UBctC57Lx=8Eh6P51cVz+cyb02GE_B-dWnYhffWoc-nm7v6Q@mail.gmail.com>
 <9fff2b17-0b66-93a0-87aa-ca6479cb0663@intel.com>
In-Reply-To: <9fff2b17-0b66-93a0-87aa-ca6479cb0663@intel.com>
From: Yu Hao <yhao016@ucr.edu>
Date: Sun, 9 Jul 2023 17:55:22 -0700
Message-ID: <CA+UBctDVMXGcCi1ZVepNCGSZvhw4OR8fqWOOQjLkOQ6NXNAnJA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ethernet: e1000e: Fix possible uninit bug
To: "Neftin, Sasha" <sasha.neftin@intel.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, 
	"Edri, Michael" <michael.edri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I think u16 phy_data =3D 0 would not hurt us.
Let me submit a patch which just initializes u16 phy_data =3D 0.

Yu Hao

On Wed, Jul 5, 2023 at 8:47=E2=80=AFAM Neftin, Sasha <sasha.neftin@intel.co=
m> wrote:
>
> On 7/5/2023 03:10, Yu Hao wrote:
> > The variable phy_data should be initialized in function e1e_rphy.
> > However, there is not return value check, which means there is a
> > possible uninit read later for the variable.
> >
> > Signed-off-by: Yu Hao <yhao016@ucr.edu>
> > ---
> >   drivers/net/ethernet/intel/e1000e/netdev.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> > b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index 771a3c909c45..455af5e55cc6 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -6910,8 +6910,11 @@ static int __e1000_resume(struct pci_dev *pdev)
> >      /* report the system wakeup cause from S3/S4 */
> >      if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
> >          u16 phy_data;
> > +       s32 ret_val;
>
> why just not initialize u16 phy_data =3D 0? How did it hurt us? (legacy)
>
> >
> > -       e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
> > +       ret_val =3D e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
> > +       if (ret_val)
> > +           return ret_val;
> >          if (phy_data) {
> >              e_info("PHY Wakeup cause - %s\n",
> >                     phy_data & E1000_WUS_EX ? "Unicast Packet" :
>

