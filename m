Return-Path: <netdev+bounces-71100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F338522BA
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 00:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4241F24257
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 23:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843434F8AB;
	Mon, 12 Feb 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG5Q9HmH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC04F88E
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781484; cv=none; b=LH1aaMh9pLmo5A5MXbeYfS6tzDsQPhKw124FumZXEi/UeCt9R8S4pt/Ngn7wfQaAJmM0gkH3ejs6a59ntDR/bRD62p1FOTg3kxb2mucoP2R5+S7LJtgBjOCwjGFrcFouzopgkCvqvMrFk8AYuPT2eSBgMK41SQyhqF21ZWH2gSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781484; c=relaxed/simple;
	bh=HHzt94gQZzjlakplqAqDzJj+3mDQSvMIBQPqPbtq46A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgYg3ROIg3UPVGQ1CbDw2MTfddUd7/Q73GTWFpvnH1x7f+x8wp4ejWkXFTFETHHjKI35npvV0t4dP1Qum/ucKZNIGsLLO/4H9gCKSEEwQtLuR+zBXNxIMl1tlelV8BLG3vMCzVaRuO8r194MLIsf49h/pAgMCcwZLypuJi25NlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG5Q9HmH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so5042995a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781481; x=1708386281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JTBzSxqMFOewSMYWxfTAdUU0xVL9LQLxD90OoHTq/Q=;
        b=bG5Q9HmHibwawnLC/U6M1WFZZFcRhmUQi6Iz+qoTlVs9Yrk9F5XxP10JX+T55TJIf6
         QDgaso6eqeviYoodP0H2vS7yRjsnYx01wwJbPQa+tT81zuwS/xRCM5U0Pu6uw0yd++8+
         cJ+x1Kbo2HuLbczaFTSP2okmy3EXPIPeW8UhdiWriNFj5DFISe1dwmwnn/WiQ60cIdmO
         NNxuZsbYVRk6MhAve5ywF5GuN1P/DhtxFwdFpMIfNqKJBERwVcJOmXEJDL44jte9i2S2
         Z3nMlQ15CJ3F4gLpSi13tHkmPedrnBjRKhQ72BpQB2cfS0haMnIrtBZmRXMjevJn33+o
         ll6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781481; x=1708386281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JTBzSxqMFOewSMYWxfTAdUU0xVL9LQLxD90OoHTq/Q=;
        b=EDm3yq04Hb2PoYRLg5IxGcHPchF4YBS41ykkMb2Zrv5fbOX08smi+826PyJFRTL9Mk
         gQRtT5Zl7cGZuQwYI5pPcFs1M/1p78MS2HHuawrVksHk7ef+0SI4EZvv+oKWBZkKp75/
         +RvGoN70/4kNaBu00hPR8EyLfczlXXuiEe++RGTQx2ZRTXUjtmiJN+rHa65OtvJWlhnO
         VtdAkDYies9qZKKN8b9Q+gs1ZSCzUyvAgMunqz296Q4DfTLxZZeRKQMiolifFfbELdx6
         4e4PgZn6/JKyVmZGmpyLuS26WIV+gfnrmjVCyo/gSlOjtGMXtAMq8NLLvepOvfxeSsZ/
         t9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhW7VHhYNtXocpzaoc4kFis7Sv2BE+NXA/WFSVsImjkGLhC2mFDhjkyS+aYmpqF8KoCJ5dCef4FkFRCVv91jmMEwcGAMyV
X-Gm-Message-State: AOJu0YzSHpb+TP2LIw7d/FMlUlLc7TRundPHkHINKN5BsJ4oC+krGdzg
	EFwnEuUdPvnd7cLCrNg3oMBQY4IhLO1/9OfGDPXe4EKN+FPEAFempuOjYiQ8SL/0xPhyk4PKNjM
	KjRJkwkZnUmDDUBjvoIsgOgAHSTjaq/muZxM=
X-Google-Smtp-Source: AGHT+IGuGQpU+2aP76YxjUEdi/s0S7P9zz+OOWXSWlCcLHAkYT97sta6jxpT2QS0TvwKidHN9Q/3G1AoqFRykvuDlao=
X-Received: by 2002:aa7:d80d:0:b0:561:352e:ac42 with SMTP id
 v13-20020aa7d80d000000b00561352eac42mr6889960edq.19.1707781480707; Mon, 12
 Feb 2024 15:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
 <CAL+tcoDFGt47_V8R7FkDN8OD-mj8pY41XysoGY7dpddo08WHMw@mail.gmail.com> <CANn89iKEb_1kCPHjRDErmusqjGzK9w3h_tDYBxS+r-0nNHzhyg@mail.gmail.com>
In-Reply-To: <CANn89iKEb_1kCPHjRDErmusqjGzK9w3h_tDYBxS+r-0nNHzhyg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 07:44:03 +0800
Message-ID: <CAL+tcoA=a3F+fjwxdNih=d0gPwCRTBKBhDSr_z8-zVK7s15R6g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Feb 12, 2024 at 4:53=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Mon, Feb 12, 2024 at 11:33=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > >
> > > >                         if (!acceptable)
> > > > -                               return 1;
> > > > +                               /* This reason isn't clear. We can =
refine it in the future */
> > > > +                               return SKB_DROP_REASON_TCP_CONNREQN=
OTACCEPTABLE;
> > >
> > > tcp_conn_request() might return 0 when a syncookie has been generated=
.
> > >
> > > Technically speaking, the incoming SYN was not dropped :)
> > >
> > > I think you need to have a patch to change tcp_conn_request() and its
> > > friends to return a 'refined' drop_reason
> > > to avoid future questions / patches.
> >
> > Thanks for your advice.
> >
> > Sure. That's on my to-do list since Kuniyuki pointed out[1] this
> > before. I will get it started as soon as the current two patchsets are
> > reviewed. For now, I think, what I wrote doesn't change the old
> > behaviour, right ?
> >
>
> Lets not add a drop_reason that will soon be obsolete.

I will update it(add one or more patches) in the v4 patchset :)

Thanks,
Jason

