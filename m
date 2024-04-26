Return-Path: <netdev+bounces-91788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3218B3EAB
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F82284381
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF931635DD;
	Fri, 26 Apr 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbFB8fLU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D713F434
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154110; cv=none; b=mLa+TBkIhYIIoxj4NBWNIARoVQy7T1DSVYPJo/wFk815kDsho74CzL65QWUK7/mtaNYkNbPlVe6XFyY/KWzLasx8F1h9DJukr72ULnkQoNsyp0E8fpQ9N4t1eHs70m4FE9MuFQCE6ZrY2Or58PbFSojiHUT6edtX0ErJMZqqjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154110; c=relaxed/simple;
	bh=kL+7ZrrqScdesusKGohNEzDyqEogNewFbdVCuWv96gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YMAObuD11+KojsWoNpTvM7HBolk+8VTs6CkRZgxq/GqOBDmNLlhvEgbEGWH1Gh5O1+w7xddt8pUJS/6R3/8BNdPQpMjqvgsUQB77Q6spy7ihBarabkBL5zej1LSlrEx0fvb09vBZY2ocA0caxHonelZWymmxjaJ5WM3zOgX1S1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EbFB8fLU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so1328a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714154107; x=1714758907; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8c3fp45OFJMal76GyuAg1MWr//D/Pxstvhd99L3qf4=;
        b=EbFB8fLU+HOxk1ovsWuxJF8n0Ey4NCe0IN9yhYWs67CW16Zqi96gAX9fWndHM/26t5
         P6kqV5c729OGawQdVUQBxX0a1/sfYObNfIgq1Z/60KuHmP5NyLI30Be01+mmxKiXNEBU
         hviLd6bhAxaBZk38Xlqb+DGsGB5wfkDVBAywqTBUQwiv/f2Vy059S+LDMSV5OkVoD2ih
         Xc3PSO47101ElClblvfHivaVsaEOBA+M6Surp9nlDk68CwkLqae+JwiWz41NKNNSZ2CC
         L8AZGSMJDVd91KZaHU1xNsLcaRJhyETg4+uBmJSu/AgLKbjzdo42128uADmq80Ar7DJU
         QpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154107; x=1714758907;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8c3fp45OFJMal76GyuAg1MWr//D/Pxstvhd99L3qf4=;
        b=HPG9TKWEPAWatHKq8rToPdQ8BLH0A5P9UKrdFt45X2+pB3T/COaGbbduE5hYokcCpO
         Xj/IUdvZQZ7fyheKsO37oIWxMG2Q/BorAE7FXjP6GThXSrEisVDqpknIdpUKvCFAvMZO
         2L4Nsmz57sHbulmuQBMUfVGG2+a/sax0pZbfmk0xsBR70fggllvSb/KqtkTGX+TH6FDC
         JThXk+lXY4j7H4DK/v51G6ypGQ9PmZrEfbkn5ot7bpZ6FxHRUzpO2ijppaADLnSrkPtK
         U1v+R1Tj+qn354sNwkSI2a53qTDJ8yclpu/kg3lUG4KJgK9230UFq4uYGRpDyKHHwNZo
         qrXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDDay45b2IbqJ6CBTOf4iIWbIRiIkiGZpq/+kN6BnyWT0Rj9QeeEALppYb3xJJTfGLD53mpGavacfnf5CbM49q6QiNsU6s
X-Gm-Message-State: AOJu0YxtKDpb3ScoQBVqRDaBa9+cYaACsvvfVTHotBV9J17/ocUq3WpF
	JD92q8SGXrFFrsVblJsSFjYqyEYulPZWW8CJ0YSUeTpbtbMnocHeNhLHQkPVGBRZ8Orgfzj+m9N
	jyvta+0m6H1ZHpofrdQnoBVqjRnjXNHgBSQL8
X-Google-Smtp-Source: AGHT+IGNneXmQFDgqQc9JoRJ7D4mFnW6fLkrjLGyh1mdJTz9eclJLKxSl2hXpj0qG+wm1H4YOnpVMdvcBQl67A2FHxE=
X-Received: by 2002:aa7:c6c9:0:b0:572:fae:7f96 with SMTP id
 b9-20020aa7c6c9000000b005720fae7f96mr3051eds.6.1714154106362; Fri, 26 Apr
 2024 10:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134731.918157-1-vinschen@redhat.com> <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
 <Ziu6k5cjXsaUpAYH@calimero.vinschen.de>
In-Reply-To: <Ziu6k5cjXsaUpAYH@calimero.vinschen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 19:54:52 +0200
Message-ID: <CANn89iJ_eM2oK5ruGu1NMk0ZEivEQO=R64E9eb9ujYj+=qWiKA@mail.gmail.com>
Subject: Re: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
To: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 4:30=E2=80=AFPM Corinna Vinschen <vinschen@redhat.c=
om> wrote:
>
> Hi Eric,
>
> On Apr 23 16:10, Eric Dumazet wrote:
> > On Tue, Apr 23, 2024 at 3:47=E2=80=AFPM Corinna Vinschen <vinschen@redh=
at.com> wrote:
> > >
> > > From: Paolo Abeni <pabeni@redhat.com>
> > >
> > > Sabrina reports that the igb driver does not cope well with large
> > > MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> > > corruption on TX.
> > >
> > > An easy reproducer is to run ssh to connect to the machine.  With
> > > MAX_SKB_FRAGS=3D17 it works, with MAX_SKB_FRAGS=3D45 it fails.
> > >
> > > The root cause of the issue is that the driver does not take into
> > > account properly the (possibly large) shared info size when selecting
> > > the ring layout, and will try to fit two packets inside the same 4K
> > > page even when the 1st fraglist will trump over the 2nd head.
> > >
> > > Address the issue forcing the driver to fit a single packet per page,
> > > leaving there enough room to store the (currently) largest possible
> > > skb_shared_info.
> > >
> > > Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB=
_FRAG")
> > > Reported-by: Jan Tluka <jtluka@redhat.com>
> > > Reported-by: Jirka Hladky <jhladky@redhat.com>
> > > Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> > > Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> > > Tested-by: Corinna Vinschen <vinschen@redhat.com>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v2: fix subject, add a simple reproducer
> > >
> > >  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/=
ethernet/intel/igb/igb_main.c
> > > index a3f100769e39..22fb2c322bca 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_ad=
apter *adapter,
> > >
> > >  #if (PAGE_SIZE < 8192)
> > >         if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> > > +           SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2)=
 ||
> >
> > I wonder if adding IGB_SKB_PAD would be needed ?
> >
> > adapter->max_frame_size does not seem to include it.
> >
> > I would try using all mtus between 1200 and 1280 to make sure this work=
s.
>
> Erm... did you mean between 1500 and 1580 by any chance?  1200 doesn't
> really seem to make sense...

No, I meant 1200 to 1280 .  IPv4 should accept these MTU .

1200 + 768 =3D 1968
1280 + 768 =3D 2048 (2 KB)

I am worried of some padding that would cross 2048 bytes boundary,
while SKB_HEAD_ALIGN(adapter->max_frame_size) could still be < 2048


>
> I tested this patch now with mtu 1500, 1540 and 1580 successfully.
>
> Either way, I'm just heading into vacation, so I guess I'll pick this up
> again when I'm back, unless Paolo takes another look during my absence.
>

I guess your patch is better than nothing, this can be refined if
necessary later.

