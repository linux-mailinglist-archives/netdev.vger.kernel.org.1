Return-Path: <netdev+bounces-238506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D92C5A1E8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 22:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D3864F0834
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2201331195A;
	Thu, 13 Nov 2025 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI/xzN4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8F3148C2
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069042; cv=none; b=ewa9D1xu3FgKDiGT/c5XJ/1oNaMZw5fx+3x2VA7CPomLJSRmusmPaaZx8DCKcJSgl/Ahsf6ASeRy/2Ml3gFhaAa7vc/Uy0eM3zMiQZm4AQLhyo1fD3VJG9zLHHGilpxjGdfI9Woc3aQ/RM88QqvSG4IRjEwqNO1Qrvhns7peKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069042; c=relaxed/simple;
	bh=pO5srCnJ/G8Wtg56D/7o5a0CmnBEcn72CLEb/fHokxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDd88fbbdQfj3O9tgs2MMc7+cgIzA/T2ekKK9HCH9u95ouwtgyMX/2wfkHJ+5iP40ToprfygILFJT48C4OaxmxhHhVI7Ak2ECdkF0rYnCzpJP5VNYj+MEgMQSsF1CiUGSFMqN2ydsBbddEDjjef8IvQ64xFKPdTBVDi6EheC0xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI/xzN4m; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298039e00c2so16108805ad.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763069039; x=1763673839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh73fAdHPRVMVUq30CorTp1R5F8aS3XmyyV4X7uyU7E=;
        b=eI/xzN4mkntpzlGY6HqBvRBgOqSg58DBIPpzyvWAG3ZWanFkg6Z61zKadGHvxT47Qm
         UDThgTfgYG12c/mNZeJINbDaBMn2o3LFOjryhdGJxleKL1GoO6utBrU2xCZJgj00UCfA
         6KdrgH5AnXglxgUNSKEC+Tn1fUXftqkDq9PWjuYbuxIKxBAVxCvtmEKzxKaGd+UZ7KKi
         vaOYM1LUXjlO74LBFsn2+mm3ohR1+TvfhKkQaKpZRNtbP3zSQlGzftMS/SjT3CkNx6+X
         244W7EcfWaziUDCX+2o01v8FTEox2GsR8TNGuBhIcLXoIGilOtiACKxhlQlHXNgdznzD
         yv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763069039; x=1763673839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eh73fAdHPRVMVUq30CorTp1R5F8aS3XmyyV4X7uyU7E=;
        b=NcO26RwnFpHsDi29IJU0XVNvU2bdlL8P1HnVG12svcaCU2aTMwnJhODGDUIziF3v+W
         QqXdPxPeAdcjm+OykXoRcIID/EmKjmb9r4c0AJoLD00jibWXJlq/2DMlLudnYZGOlF60
         iB+jk+mLDW/B1vkM1iQubP2cZAxbkUzlnF0gz3PlyNTv7L4RZVmWXZ8WwmT5xaiKCEG/
         yzSHF1kwLRNUB2qTySc2Yk/HAXTw47PmEFzuMARGQB0mbg0rbHWevb0NA4BBhJm7y1NP
         8VMqC9TbSP0WL398ZBA30N/E4biWNWOvI1/e9ucM3E386eI2kvLDpnJU99db0i/yKnBp
         eZKw==
X-Gm-Message-State: AOJu0Yysnb/QQnlI0wKaLWy7WZAiamDZm21ASoC0hHrUQ5EP9oOe6xtR
	oozEJCmfLiktDZ2pgzYZWv8BEzQv1U+6k8NSuA0Emhb6nM/wYfghH3spsHyAdI5AbE6an+YpUAC
	7nqc+HBjlvfHf3yhPeCnSZ2B5fP4p3xY=
X-Gm-Gg: ASbGnct2J+qMqJ5rfArZF7oyvp29zit3il0TFcdLcZJvwWN3D40Ek/6c8NvhwaGG4ib
	umfG6FAfGAw4sZn0bqId3Vensi6/UKyLNx46WzuMgnEOS3eKdT8P8kYRXTRq2p3M+TZtpMM45PS
	2sX8MCvRf0XKr7Z5QsuoiIHn0zf6edO6GDOq65Ae5E30IBC1h1RWOMy/caBYJgdIsjk91xuqvi6
	iilrsfqJhDKzhdYoJM474T2bGGWJWadEF93pQpd+Cjw00S5qAlBbtKbSa9O
X-Google-Smtp-Source: AGHT+IHIy62FYNI2+fsss76ZAxstDpGuH13CcKtwJwf7q37KPjXXhYyeWXtZJfedfcdinC12R6BE741QmBSKtVPCgHU=
X-Received: by 2002:a17:903:1a10:b0:295:21ac:352b with SMTP id
 d9443c01a7336-2986a6d6834mr4511285ad.15.1763069038948; Thu, 13 Nov 2025
 13:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <cc874b85134ba00f8d1d334e93633fbfa04b5a9a.1761748557.git.lucien.xin@gmail.com>
 <3618948d-8372-4f8d-9a0e-97a059bbf6eb@redhat.com> <CADvbK_f9o=_L=K+Vo_MbJk3mXFgriUUtGCSVm6GNo6hFHk5Kzw@mail.gmail.com>
In-Reply-To: <CADvbK_f9o=_L=K+Vo_MbJk3mXFgriUUtGCSVm6GNo6hFHk5Kzw@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 13 Nov 2025 16:23:47 -0500
X-Gm-Features: AWmQ_bl_mzAmk37GvxSMi73Wl76L8rzqwm6CGLE5Z5FgVRtg24EVCmyQJDOWLoo
Message-ID: <CADvbK_fi6GDOwpo_vRNWDXLn9v7Kys5zuz8RGNxFYEm6y0KcTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 13/15] quic: add timer management
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:49=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Tue, Nov 4, 2025 at 7:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On 10/29/25 3:35 PM, Xin Long wrote:
> > > +void quic_timer_stop(struct sock *sk, u8 type)
> > > +{
> > > +     if (type =3D=3D QUIC_TIMER_PACE) {
> > > +             if (hrtimer_try_to_cancel(quic_timer(sk, type)) =3D=3D =
1)
> > > +                     sock_put(sk);
> > > +             return;
> > > +     }
> > > +     if (timer_delete(quic_timer(sk, type)))
> >
> > timer_shutdown()
> Will update. Thanks.
timer_shutdown() sets timer->function to NULL, and it causes mod_timer()
to return 0 without enqueuing the timer. This breaks the code:

                if (!mod_timer(t, jiffies + usecs_to_jiffies(timeout)))
                        sock_hold(sk);

in quic_timer_start(), and cause sk leak.

So I will keep timer_delete() here.

Thanks.

>
> >
> > Other than that:
> >
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
> >

