Return-Path: <netdev+bounces-118714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA39952888
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15CB1F235B9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 04:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0AF43155;
	Thu, 15 Aug 2024 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwjNp6eS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB13D967
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696201; cv=none; b=UTVO1iWeuyexnb/SpV44irsDzofYE8knx5vh2AL+vC/UGda9j7NR5T3T+p5eW1R0pm9rFBVlrK9U+LLVwUc3mVTpE+fp6q228BQlxUpP1sV3GQnYMWXCF1Pp1fWz9CmfLF8kHDfiGYdkMz5r5DIG46Lrumyg1fT9wzTo9kNl3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696201; c=relaxed/simple;
	bh=ScuQSNpmu8cfwGAkpUxdJZd/0YU+jDoQJzaTX0HMMl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw/Q9CAvGyRpsi3FuvCDZ4r4ooDm89hXAh7fvV3FcAONsR/8cSspZ2WAUaiZMJNrwTEJNDF2FqeZlJ3Qp5jGdevauGfitLd7Ymyl/iwOZKO6pQ3oY9tyJ0J8P4ykCfLuWwO5251ZtnCNHCpO0HG8vPr9x6WH+aA1i/TZNi0eiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwjNp6eS; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-397ba4f7387so2634025ab.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 21:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723696199; x=1724300999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/brrcTmmZ6JsVQPbhOMEvNk0Eca0/oU69zHiC6XRQ/s=;
        b=FwjNp6eSOeeYook//YHD0AGP+/6YsQy6gELVipAMSLWH0Esd7+Tf8r5mu5hNKuD80B
         Bnnu+XZJ1SbJIvgjzjylrrS1vgRv7vwO1ugr70crhyjx/C7te8lRLRj5xcZ6xRbmTd5s
         ZNz9UZd9g3xluVmkYljyYYPIU1rfa36xBFR4JIhosr29pRwZIWH0IeoThL1/Bt01QIpH
         ZgRtEtEY0EUZR+r4mUgW/Sl7rENHx6uZ2muccR/LOKXmmrYC7Lly/41cvd60ajg5n3Sf
         QR5tRWNAs9fyPZaVIPY/Hmfs9pmLCtn61gTPsqhdQBxmZWHP2jN4LDNS4VRGBJXN0knq
         JFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723696199; x=1724300999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/brrcTmmZ6JsVQPbhOMEvNk0Eca0/oU69zHiC6XRQ/s=;
        b=lWJn2Uh5Zj+86ermH3QEL7kYSqT2tAbfSbAc3RS3l3rTO11Ojr+0k2KsSdNEZej4HD
         2rXkMDwAum+mNFGF9eZt1T7Ds1Kmxlqe/V6ZH2NK66auDVPPmgp2kq+Jk7w//4U3K777
         nxps15B1b6z6Zvtzu4URsz4PjmDBMrehPkej0snNgVH5ZLb5KRHlTxAx4VfXuwEczntR
         oPA8RBi2sDRLezGVJdGFEndcX24H6FPyLGEtKZtTOJxvuFTlwZuQeV/98m+ScwS0Fky/
         MhJLHIOl0FQ+dBADEU00MO41e1CMoESqmGz2JvePgu3919vwe2BW5DPH7Hyti5MvS0h/
         P4vg==
X-Forwarded-Encrypted: i=1; AJvYcCU5LggmntsfBQAdog9AEnmaTzR2Z2XtP4nK3MeckAkkurlSk7WnralXGoLrUGrcKDhVVGkhucP86qY9G9OTofpj7l91HrRt
X-Gm-Message-State: AOJu0YxKk1RmehbmFJVk21qDdePsdN2pe6EWUOslISKXiy8sruSabxTm
	wknaQsPRH0cUWo/6lp+rrVrf9vAsUcvXDxqaT3YEcyhEy7UnkMLgAwbc0OdwrE6f4SMWeJKDqXQ
	WxiIW2anUKWGLXJ5cedmZE/wsiZM=
X-Google-Smtp-Source: AGHT+IET394LuBhb2N4n0HWAh4fJBbzO/5E5RODGZPiV8iae3vRPUnjCqV8rz32aBmSiqkOKKN1J1LLYqAc2Lv4g7Qs=
X-Received: by 2002:a92:3603:0:b0:39b:324a:d37f with SMTP id
 e9e14a558f8ab-39d1245b039mr48819535ab.2.1723696199010; Wed, 14 Aug 2024
 21:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814035136.60796-1-kerneljasonxing@gmail.com> <20240814193844.66189-1-kuniyu@amazon.com>
In-Reply-To: <20240814193844.66189-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Aug 2024 12:29:22 +0800
Message-ID: <CAL+tcoALxw0Pi+c1imyPHJu=ahaY5bU-adWPfCC4s4MGCQNTmA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid reusing FIN_WAIT2 when trying to find
 port in connect() process
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	jadedong@tencent.com, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kuniyuki,

On Thu, Aug 15, 2024 at 3:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Wed, 14 Aug 2024 11:51:36 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We found that one close-wait socket was reset by the other side
> > which is beyond our expectation, so we have to investigate the
> > underlying reason. The following experiment is conducted in the
> > test environment. We limit the port range from 40000 to 40010
> > and delay the time to close() after receiving a fin from the
> > active close side, which can help us easily reproduce like what
> > happened in production.
> >
> > Here are three connections captured by tcpdump:
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
> > 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
> > // a few seconds later, within 60 seconds
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> > 127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
> > // later, very quickly
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> > 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
> > 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> >
> > As we can see, the first flow is reset because:
> > 1) client starts a new connection, I mean, the second one
> > 2) client tries to find a suitable port which is a timewait socket
> >    (its state is timewait, substate is fin_wait2)
> > 3) client occupies that timewait port to send a SYN
> > 4) server finds a corresponding close-wait socket in ehash table,
> >    then replies with a challenge ack
> > 5) client sends an RST to terminate this old close-wait socket.
> >
> > I don't think the port selection algo can choose a FIN_WAIT2 socket
> > when we turn on tcp_tw_reuse because on the server side there
> > remain unread data. If one side haven't call close() yet, we should
> > not consider it as expendable and treat it at will.
> >
> > Even though, sometimes, the server isn't able to call close() as soon
> > as possible like what we expect, it can not be terminated easily,
> > especially due to a second unrelated connection happening.
> >
> > After this patch, we can see the expected failure if we start a
> > connection when all the ports are occupied in fin_wait2 state:
> > "Ncat: Cannot assign requested address."
> >
> > Reported-by: Jade Dong <jadedong@tencent.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/inet_hashtables.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 9bfcfd016e18..6115ee0c5d90 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -563,7 +563,8 @@ static int __inet_check_established(struct inet_tim=
ewait_death_row *death_row,
> >                       continue;
> >
> >               if (likely(inet_match(net, sk2, acookie, ports, dif, sdif=
))) {
> > -                     if (sk2->sk_state =3D=3D TCP_TIME_WAIT) {
> > +                     if (sk2->sk_state =3D=3D TCP_TIME_WAIT &&
> > +                         inet_twsk(sk2)->tw_substate !=3D TCP_FIN_WAIT=
2) {
>
> I prefer comparing explicitly like
>
>   inet_twsk(sk2)->tw_substate =3D=3D TCP_TIME_WAIT

Thanks, I will adjust in the v2 patch soon.

Thanks,
Jason

