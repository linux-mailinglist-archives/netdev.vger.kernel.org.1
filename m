Return-Path: <netdev+bounces-102432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9699C902EA2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E91DAB2133C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ABF15ADBB;
	Tue, 11 Jun 2024 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu1jqijJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDE1581E2
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074611; cv=none; b=cxg7qH+HEmqkKYOZXqeF2npwwHrllaIzA/PLzzHgwH1iR6elExGSel+qsOxj8GxWlpRN9CgNBdXznwQ41ulha2bjqHFLz+hkWIXwgMFwu+atkuCst2AQm2i2jie4wV8vjC+G4sdyvrCmR9pVdZjwMvl164EdTbpsPbSpVtGDonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074611; c=relaxed/simple;
	bh=u19nYeukHLKbXEBOaaw+fkkUCtMPcISXCjD9zqHbg2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppvTE2yq4qwFF2AimKSfokusroEeUHrC8OZ8xgLj440+PJoaVavAEAwJtkf58c6u3EAuGSXpxjTucGlWwLSkFSDaMDfXGtTdlhnuaJiHxlzmZHL64fgfD0J4xjUF1IDzHoNPOuO7nPcuHuyv1fLZSkr7iqu5Fr9LIBqxTatp7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu1jqijJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so910761a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 19:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718074608; x=1718679408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u19nYeukHLKbXEBOaaw+fkkUCtMPcISXCjD9zqHbg2M=;
        b=Eu1jqijJgGVBxANuWUw77kHi79nr8AV6UmdahjUorl7n7W8fmEyBuuOao0hqO7cL/F
         jLkyEynMoIm/S/nTgzIC35CfYXPMj2hANAgatC6aH8fEOFoY81VTPX1d+4qN5e43JcOZ
         qxFTD9EbiN71NOxJiZT0AliK7fAcfJdl3QBmePo5fbQ3HZmZiLvHtJuRkeiz/Ghw/FJs
         xRUqcCIJvApUQpCo+uNn6M5h7AwlpGwiCUwCE9jLFRDB5/cFdT/0ZiFUghTFGBdROv8F
         Rlu36Hy1LV2DC4eXQ3e2mKPlnVB7GRN1HEv+imO84Gphfn2xR1D8Cdgw9BFurIo1Lao0
         w+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718074608; x=1718679408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u19nYeukHLKbXEBOaaw+fkkUCtMPcISXCjD9zqHbg2M=;
        b=k0gBjzdCv1bLY20NoCfvxbiWHM7ACh2AO+1CkJkZdLlACM6ftWppajM78klZ885xRB
         Pi+FlFz1YXu5bWm7DbOJbEwKjCcwahew//BSCM8jd9wWL001YnrNMmDgevl7WptVZHis
         L3nx8K/8RyXY0gTJ4dEplN2JF0MUFWRuLGMoNm7xsQP9x/JtKHisCt63EWvDleuyDPRa
         IefBXg/e33TN5alYyPugs47UbAJk4hItsFBLGRNcfKtM4ZyRLOOkriatPIS7/5RaTyb8
         AJ8DFW5YjxQ2B0IbsR71zPxXOGfgnKlJg66RHhqcWVMPyJGtsIzqNppFOl9S6d3Xk6qg
         L1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVOWg5rHhcprHo3ati0FYy8ww0J4M0uJpcK66tr6cxcfPC1KOKo+LAKZ2zfR9Xycs4eggQJmOvXXa4k+DFvgEVeT7JYc6o
X-Gm-Message-State: AOJu0YxRbMcnVcU4hhreluadasLoJZo7mzOloj9VqbUaNTdU6cLr5uZp
	9GqAKGH+UMCfVK3TXONLCk2yj2CxdOr0MytpSr+4YU0JeKojLpyj6VlTgRdWVPD9p0P7IMsS66D
	0QPUIbEmHtjs/Kg2aVOoyDahktXc=
X-Google-Smtp-Source: AGHT+IHixH8tpH74VFFtwCApwnQdwa6F/TYXNRnC1q2OY6uMmL8u0C9cTVuN33YXPzmR49QJUfT42+N/eKIWzJIBqQs=
X-Received: by 2002:a05:6402:3196:b0:57c:6b49:aef with SMTP id
 4fb4d7f45d1cf-57c90d16fd9mr810565a12.11.1718074607878; Mon, 10 Jun 2024
 19:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609131732.73156-1-kerneljasonxing@gmail.com>
 <CANn89iK+UWubgdKYd3g7Q+UjibDqUD+Lv5kfmEpB+Rc0SxKT6w@mail.gmail.com>
 <CAL+tcoCGumdRKgd_1bQj1U_sNPsvYmsNOKwSWxazU0FwmeNTwA@mail.gmail.com> <20240610184505.35006364@kernel.org>
In-Reply-To: <20240610184505.35006364@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Jun 2024 10:56:09 +0800
Message-ID: <CAL+tcoCZ_pfv5g1P+x+gTeAseifJ=W6y+0GGgS31ih7BqGCrTw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dqs: introduce NETIF_F_NO_BQL device feature
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 9:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Jun 2024 07:55:55 +0800 Jason Xing wrote:
> > > (I think Vladimir was trying to make some room, this was a discussion
> > > we had last year)
>
> s/Vladimir/Olek/ ?
>
> > Thanks for your reminder. When I was trying to introduce one new bit,
> > I noticed an overflow warning when compiling.
> >
> > > I do not see the reason to report to ethtool the 'nobql bit' :
> > > If a driver opts-out, then the bql sysfs files will not be there, use=
r
> > > space can see the absence of the files.
> >
> > The reason is that I just followed the comment to force myself to
> > report to ethtool. Now I see.
> >
> > It seems not that easy to consider all the non-BQL drivers. Let me
> > think more about it.
>
> All Eric was saying, AFAIU, is that you can for example add a bit
> in somewhere towards the end of struct nedevice, no need to pack
> this info into feature bits.

Oh, thanks for pointing this out.

I would like to add a new bit field in the enum netdev_priv_flags
because it is better that it's grouped into an existing enum for
future compatibility.

>
> BTW the Fixes tag is a bit of an exaggeration here. The heuristic in
> netdev_uses_bql() is best effort, its fine to miss some devices.

I see.

Thanks,
Jason

