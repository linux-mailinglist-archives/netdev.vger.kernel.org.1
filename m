Return-Path: <netdev+bounces-132495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A9991EE8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3CFB2131F
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A51CD31;
	Sun,  6 Oct 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3/ZMZAL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252CBAD55
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728225086; cv=none; b=Z09wxZdCQBkBFwHAowDMyhs9I7bJ8R9I4OAYJnt4EkTffcB8kSOSrT3qtq7bcSWY/CF5ppKrXb6XnXzINeR2I9cWRqb2bmgSgXX7JS3MMY49jud46mMZJ2ZnpYcCsoxESKqYRE0BWB4prkP5+4Oyb6ffn0xQdvOazVMXvls5T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728225086; c=relaxed/simple;
	bh=4ZGZT4MMqAaWYL/ciNFnqa1WpgiaShL682CJk0bNAfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teYhj5i1OVAtbSBn1u3DltiuIFib6DA53ooYChDTYaFLS5t2lw4BDou/C+YUeinVB4Rx1NSkCOqU07VteOA3McJvOt5SbB64FqFlF2Qls4L4eCDbIBf27To9/Unshxh59pxEEP91J3+xyp7RuQ8n0kwJID8Vs0T9DE6nFAWRl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3/ZMZAL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb33996b79so4812866d6.0
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728225084; x=1728829884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw0P7V+qzzyqDMnqGzM4CxAJl6n6mMsxzoMLjOlN4Gc=;
        b=F3/ZMZALt9OkI8a8UuiGq1YFTkVwMwreOrxq25B8yRqjKCcP9fNxLh/WUdUJpdmt7l
         OnEd/fv1KUqrW6w2Jim/Sc2jSPxumgmaV1hXTq3YK6RhLjXn2kQbNsLyEWNTkDaBsbTf
         A0SHufNds05YTfnYiv9ujpcSoB+XZvAnt4k3mqX0kG1BVXaY3CRNewPVuBnTj7HNUDvY
         P/zOraVP0dGSP84XcluorgDLCx7COKB2dPQ0/oS+F20j508je2qgNnqWeu3Oi9zBMRkO
         KReWcELpLRzXoziRdiHfvJwYEwbtkYo7UQOkoKqfoBhUahapvlOlAPBKrM9rJYPsl96u
         zWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728225084; x=1728829884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gw0P7V+qzzyqDMnqGzM4CxAJl6n6mMsxzoMLjOlN4Gc=;
        b=mFmOxeSbTycwFVyue1fIolvboteeY5CjDW5mYDJ3KQKpOP64beq2V65Ao2rEXPmBMs
         iLuIEcSzNeh3W6nR7H3E+GDPY3WIcVmA0Zpm83HUrMegQRbiPBc9ZhnEO7z9fJxRG0Rw
         1fh1jJyDLM/QJv8Aiw6eU3MiTYbv3KZC1S1JW8JVU280N5sy+uz3nGSoKxdKlIglZrE2
         N/29Cc8DsYfwiIQ1j/QutsGWsvr4zk4CF8KL9GAXVFndpM/E8ajVSUj/VFsxu4Bo/or1
         7OV4C/jpghYi+pT3CNegswsIBfuPBbqY0v+kUdklBMWwAThCIYnmnxYeUbF3FqVLx9BB
         mYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWli65q7kDuga36pGtB23ec83lCDaj80g5ERDSzbVVgJm4/R3/4A8Xy3RkaHZNjijO7h1S46VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6zb5VWlDNk2+mRhYVXaT98E+Hcd6eweeZa2oNoh+ObahxTlnx
	SV1eTBy+pq+l+KnQQiqTNDTMVhvR7FzzEzekiIX2ANK2BleJS3/1TJnwYcns8T337UYMnywrHow
	cOfPkeCT3LpsQOfeup4u587bTcg==
X-Google-Smtp-Source: AGHT+IEk/DcpyxjYYfGAxEHKe6123YNPwi783T0AHzGS2+e/VMSEUCNwXS6NB5Q5hqi3CwsOVT8tdlEehOaTa74/cAU=
X-Received: by 2002:a05:6214:5007:b0:6cb:6006:c98b with SMTP id
 6a1803df08f44-6cb9a2f5ba2mr63712986d6.5.1728225083992; Sun, 06 Oct 2024
 07:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728143915-7777-1-git-send-email-guoxin0309@gmail.com> <CADVnQymUCp1nocPYUCXx1QmN4Y8ABJMd0urJeB5_J=TL8b7_Yg@mail.gmail.com>
In-Reply-To: <CADVnQymUCp1nocPYUCXx1QmN4Y8ABJMd0urJeB5_J=TL8b7_Yg@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Sun, 6 Oct 2024 22:31:12 +0800
Message-ID: <CAMaK5_hKpZcO89ej-nJWHnF=1nM=rYSLA6n-gY4WK0Hzg-sPdA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: remove unnecessary update for
 tp->write_seq in tcp_connect()
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks neal, my bad,
I will read the document and post v3 for this patch

On Sun, Oct 6, 2024 at 1:40=E2=80=AFAM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Sat, Oct 5, 2024 at 11:58=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wr=
ote:
> >
> > From: "xin.guo" <guoxin0309@gmail.com>
> >
> > Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data")
>
> To match Linux commit message style, please insert a space between the
> SHA1 and the patch title, like so:
>
> Commit 783237e8daf13 ("net-tcp: Fast Open client - sending SYN-data")
>
> > introduces tcp_connect_queue_skb() and it would overwrite tcp->write_se=
q,
> > so it is no need to update tp->write_seq before invoking
> > tcp_connect_queue_skb()
> >
> > Signed-off-by: xin.guo <guoxin0309@gmail.com>
> > ---
> >  net/ipv4/tcp_output.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 4fd746b..ee8ab9a 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -4134,7 +4134,10 @@ int tcp_connect(struct sock *sk)
> >         if (unlikely(!buff))
> >                 return -ENOBUFS;
> >
> > -       tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
> > +       /*SYN eats a sequence byte, write_seq updated by
> > +        *tcp_connect_queue_skb().
> > +        */
> > +       tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
> >         tcp_mstamp_refresh(tp);
> >         tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
> >         tcp_connect_queue_skb(sk, buff);
> > --
>
> As in the example provided by Eric, please use Linux kernel C comment
> style, which places a space character between the * and the first
> character of the comment text on each line. For example:
>
> /* SYN eats a sequence byte, write_seq is updated by
>  * tcp_connect_queue_skb().
>  */
>
> For more information, see:
>
> https://www.kernel.org/doc/html/v6.11/process/coding-style.html#commentin=
g
>
> thanks,
> neal

