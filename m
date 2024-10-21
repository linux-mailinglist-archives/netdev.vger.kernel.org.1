Return-Path: <netdev+bounces-137640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A49D9A91BA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 23:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E351F23135
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5DA1E1C17;
	Mon, 21 Oct 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATbao0iu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A1433D8;
	Mon, 21 Oct 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544734; cv=none; b=NiDElDHZBT2RWcwLfsoqt+V/69h5WorGwZoG3GEZSMUknRQWcEGVYeJnJP7udtALlnefZ3Sk0zWA/rtR9jkVSrVrhHujK8YBB9txD10G4fWfowr24HBkLsVNxqbuPzO44JQTfQsQKFLr9Q4fpKAYhyR9wk0L3cIBzjKIypfsL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544734; c=relaxed/simple;
	bh=s3OodBpvSxMaKETMNVer5BaqSCckKv3NVV3mvKgGpIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYBatUj2hGVgebp/fe3Vem233eQ80TcxnIXTMppmGKncSC//w7KJl7haKs2YENbBjIjfDvndNVbVNCJBQs6db5SU2lyfcedYVkMyhNzO0wll9h7aqVYfs4RMQtCFhT4FB+v5ptaboGiVeVxjJmiJeIyc4fQf67gB5mSFf+FAB3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATbao0iu; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290d5f83bcso4435073276.0;
        Mon, 21 Oct 2024 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729544732; x=1730149532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XElkwMERNnE8VSEPnaQSQ45i/ARWFoihHrUBejZ+Uc=;
        b=ATbao0iujigQQ3au1KP4nFikdRTsmkqnjGjF9PavMHjn0GH5zqwHrKxxEkIIKAt7bo
         6PDYmQqvXLp29xVbg4weIy71SQyk7UZSSFzmBvZPWdZV0J98XOBrF/sYD0rCgCks+AuO
         RkILcHWD6HPJkomgf8c7NsTND0iGp97c5gaDetv6FFPCNU4Nsf9KCj3cBp2WvkOwyxux
         A+mUCzq6diFB50St03lnDJyEPDcNY+gt3M/YXLXfGOSfj7t2UT4bzDIhTBBvCBSy5e5r
         YS4gfGUZ45iIhW+bOwJjkL0zAYNI6OLCewvaj3MX3NCi/WCl6KPG1fxLgPdCws4Vubmy
         NZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544732; x=1730149532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XElkwMERNnE8VSEPnaQSQ45i/ARWFoihHrUBejZ+Uc=;
        b=r7plWr7XRZU/lbSxlDCIpyX8OKE5+Xd/Xz2lw4YvnLqm745OEcqe1Il99OYz0AkDsx
         GAWA3qEtrzft6UoRQEY85HqtKAiB0lZmEIArE1l3ml9dLL+uADno9CD3ZYWnaI903tzF
         TIMJYnUFXqQjygubx3nX45ZFfp1Bgwyzkj7HVuOffC1UQjNKpEPRv2TQ/avzTaW6W0nF
         Jokmbm2YE8plP1LNb19dTpq0LifV1nzXCKpuMuA2DyOA6d40hZTS9Or9l2trWhrYJlUW
         a3OiUSlLNICj3yjcKxbqoLRUgvE0MDBGtP/XBDIM2u4lNkF0DOV4JVkDM6H9eDU7ugDa
         HF4g==
X-Forwarded-Encrypted: i=1; AJvYcCWBc4EEIpiYo7N2c4u0G1RLqaWTBHjh7Bh+kLFq3BD708dK9FqXJSJ2VglSP4RR++aawovCUdfjg85eUKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0gutTHIfJ6Jw0/qaD9K4zrIFFYgk/3yNZEHkfYmJc64Coc+c
	5OYnBTLxYzcM8p1IP9xaaIXQxU9WLCRgVbEcfSzsCWU4RRSlkuFFg5TNpyfSFK6jh0i0vG5ZXRk
	DtYMwin+c8oHqhx7pIT8U28Am6cU=
X-Google-Smtp-Source: AGHT+IFCxai+kxr3M4e8Zh3FnJ3fHP5dKiNqnRGunmCsgYduD/ZXRt+MSdHmeMMOUy4Wh41Usd7H0eU2oogc0FffCbQ=
X-Received: by 2002:a05:690c:28f:b0:6e2:313a:a022 with SMTP id
 00721157ae682-6e5bfe94d4bmr125588627b3.33.1729544731923; Mon, 21 Oct 2024
 14:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021022901.318647-1-rosenp@gmail.com> <CACKFLi=WNXhDJPD-bt5cm46bBDZRn=8ZbDCQfE0juO_32SDuAQ@mail.gmail.com>
In-Reply-To: <CACKFLi=WNXhDJPD-bt5cm46bBDZRn=8ZbDCQfE0juO_32SDuAQ@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 21 Oct 2024 14:05:21 -0700
Message-ID: <CAKxU2N8vW-b-=FpdZdBvakWzEYYhHJyhLDsEs-PJ4gapaxH0ow@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bnxt: use ethtool string helpers
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 1:26=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Sun, Oct 20, 2024 at 7:29=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > Avoids having to use manual pointer manipulation.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 110 ++++++++----------
> >  1 file changed, 50 insertions(+), 60 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index f71cc8188b4e..84d468ad3c8e 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -713,18 +713,17 @@ static void bnxt_get_strings(struct net_device *d=
ev, u32 stringset, u8 *buf)
> >                 for (i =3D 0; i < bp->cp_nr_rings; i++) {
> >                         if (is_rx_ring(bp, i)) {
> >                                 num_str =3D NUM_RING_RX_HW_STATS;
> > -                               for (j =3D 0; j < num_str; j++) {
> > -                                       sprintf(buf, "[%d]: %s", i,
> > +                               for (j =3D 0; j < num_str; j++)
> > +                                       ethtool_sprintf(
> > +                                               &buf, "[%d]: %s", i,
>
> If you combine this line with the line above, I think it will look better=
:
>
> ethtool_sprintf(&buf, "[%d]: %s", i,
>
> checkpatch.pl may warn because the next line won't line up, but I
> think it will look better and it reduces the number of lines.  The
> same comment applies to other similar spots in the patch.  Thanks.
I use git-clang-format for this stuff.

The only real way to satisfy everything is to use a temporary variable like

for (i =3D 0; i < BNXT_NUM_PORT_STATS; i++) {
  const char *str =3D bnxt_port_stats_arr[i].string;

  ethtool_puts(&buf, str);
  }

to make everything small.
>
> >                                                 bnxt_ring_rx_stats_str[=
j]);
> > -                                       buf +=3D ETH_GSTRING_LEN;
> > -                               }

